-- IDEMPIERE-6650 Performance - Implement support for using the uuid postgres datatype (FHCA-7074)
SELECT register_migration_script('202609101900_IDEMPIERE-6650-FixUUFks.sql') FROM dual;


-- IDEMPIERE-6650 Performance - Fix for missing FK constraints
-- The original script 202510101902_IDEMPIERE-6650-uuid.sql builds the "recreate FK" SQL
-- into v_createallfksql and only RAISE NOTICE's it instead of executing it,
-- so every UUID column that had an existing FK before the conversion ends up WITHOUT
-- its foreign key in postgres after the migration runs.
--
-- This script is idempotent and safe to run as many times as needed:
--   1) It reads the dictionary (AD_Column/AD_Table) for all columns using the UU
--      "foreign key" reference types: 200233 (Table_UU), 200234 (TableDir_UU), 200235 (Search_UU)
--   2) For each one it works out the referenced table/column using the same
--      "<tablename>_UU" naming convention iDempiere itself uses for these columns
--   3) It checks postgres (pg_constraint/information_schema) to see if ANY foreign key
--      already exists on that column
--   4) If none exists, and AD_Column.FKConstraintType is not 'D' (dictionary says no FK
--      should exist), it creates it:
--        - constraint name: AD_Column.FKConstraintName when set, otherwise a generated name
--        - ON DELETE CASCADE when FKConstraintType = 'C'
--        - ON DELETE SET NULL when FKConstraintType = 'S'
--        - no ON DELETE clause (default) when FKConstraintType = 'N' or anything else
--        - always DEFERRABLE INITIALLY DEFERRED
--      Columns that aren't uuid-typed yet on either side are skipped.
--   Each ALTER TABLE runs in its own exception-handling sub-block so one bad FK doesn't
--   abort the whole run; COMMIT happens right after that sub-block ends (COMMIT cannot be
--   issued from inside a BEGIN/EXCEPTION block since it implicitly opens a subtransaction).

DO $$
DECLARE
    r_column RECORD;
    v_target_table text;
    v_target_column text;
    v_source_type text;
    v_target_type text;
    v_fk_exists boolean;
    v_constraint_name text;
    v_ondelete text;
    v_sql text;
    v_execute boolean := TRUE;
    v_count_created integer := 0;
    v_count_skipped integer := 0;
    v_count_errors integer := 0;
BEGIN
    FOR r_column IN
        SELECT
            t.tablename,
            c.columnname,
            c.fkconstraintname,
            c.fkconstrainttype,
            c.ad_reference_id,
            c.ad_reference_value_id,
            -- 1) explicit dictionary mapping via AD_Ref_Table, when present
            (SELECT ref_t.tablename
               FROM ad_ref_table rt
               JOIN ad_table ref_t ON ref_t.ad_table_id = rt.ad_table_id
              WHERE rt.ad_reference_id = c.ad_reference_value_id
              LIMIT 1) AS dict_target_table,
            -- 2) exact-name match: columnname minus trailing "_UU" equals a tablename
            (SELECT t2.tablename
               FROM ad_table t2
              WHERE t2.tablename = left(c.columnname, length(c.columnname) - 3)
              LIMIT 1) AS exact_target_table,
            -- 3) truncated-name match (27 char convention used to build *_UU columns)
            (SELECT t3.tablename
               FROM ad_table t3
              WHERE substr(t3.tablename, 0, 27) = left(c.columnname, length(c.columnname) - 3)
              LIMIT 1) AS truncated_target_table
        FROM
            ad_column c
            JOIN ad_table t USING (ad_table_id)
        WHERE
            c.ad_reference_id IN (200233, /*TableUU*/ 200234, /*TableDirUU*/ 200235 /*SearchUU*/)
            AND right(c.columnname, 3) = '_UU'
        ORDER BY
            t.tablename,
            c.columnname
    LOOP
        -- FKConstraintType = 'D' means the dictionary explicitly says no FK should exist
        IF r_column.fkconstrainttype = 'D' THEN
            RAISE NOTICE '-- FKConstraintType=D, no FK needed, skipping: %.%', r_column.tablename, r_column.columnname;
            v_count_skipped := v_count_skipped + 1;
            CONTINUE;
        END IF;

        -- Resolve referenced table according to the reference type:
        --   200233 (Table_UU)     -> ALWAYS via AD_Reference_Value_ID -> AD_Ref_Table
        --   200234 (TableDir_UU)  -> ALWAYS derived from the column name (strip "_UU")
        --   200235 (Search_UU)    -> via AD_Ref_Table when set, otherwise same as TableDir_UU
        IF r_column.ad_reference_id = 200233 THEN
            v_target_table := r_column.dict_target_table;
        ELSIF r_column.ad_reference_id = 200234 THEN
            v_target_table := COALESCE(r_column.exact_target_table, r_column.truncated_target_table);
        ELSE -- 200235
            v_target_table := COALESCE(r_column.dict_target_table, r_column.exact_target_table, r_column.truncated_target_table);
        END IF;

        IF v_target_table IS NULL THEN
            RAISE WARNING '-- Skipping %.% (ref_id %): could not resolve referenced table', r_column.tablename, r_column.columnname, r_column.ad_reference_id;
            v_count_skipped := v_count_skipped + 1;
            CONTINUE;
        END IF;

        v_target_column := substr(v_target_table, 0, 27) || '_UU';

        -- Make sure source column exists and is already uuid
        SELECT pg_catalog.format_type(a.atttypid, a.atttypmod)
          INTO v_source_type
          FROM pg_catalog.pg_class pc
          JOIN pg_catalog.pg_attribute a ON pc.oid = a.attrelid
         WHERE LOWER(pc.relname) = LOWER(r_column.tablename)
           AND LOWER(a.attname) = LOWER(r_column.columnname)
           AND a.attnum > 0
           AND NOT a.attisdropped;

        IF v_source_type IS DISTINCT FROM 'uuid' THEN
            RAISE WARNING '-- Skipping %.%: column is % (not uuid yet)', r_column.tablename, r_column.columnname, COALESCE(v_source_type, 'MISSING');
            v_count_skipped := v_count_skipped + 1;
            CONTINUE;
        END IF;

        -- Make sure target column exists and is already uuid
        SELECT pg_catalog.format_type(a.atttypid, a.atttypmod)
          INTO v_target_type
          FROM pg_catalog.pg_class pc
          JOIN pg_catalog.pg_attribute a ON pc.oid = a.attrelid
         WHERE LOWER(pc.relname) = LOWER(v_target_table)
           AND LOWER(a.attname) = LOWER(v_target_column)
           AND a.attnum > 0
           AND NOT a.attisdropped;

        IF v_target_type IS DISTINCT FROM 'uuid' THEN
            RAISE WARNING '-- Skipping %.% -> %.%: target column is % (not uuid yet)',
                r_column.tablename, r_column.columnname, v_target_table, v_target_column, COALESCE(v_target_type, 'MISSING');
            v_count_skipped := v_count_skipped + 1;
            CONTINUE;
        END IF;

        -- Does ANY foreign key already exist on this source column? (name-agnostic check)
        SELECT EXISTS (
            SELECT 1
              FROM information_schema.table_constraints tc
              JOIN information_schema.key_column_usage kcu
                ON tc.constraint_name = kcu.constraint_name
               AND tc.table_schema = kcu.table_schema
             WHERE tc.constraint_type = 'FOREIGN KEY'
               AND LOWER(tc.table_name) = LOWER(r_column.tablename)
               AND LOWER(kcu.column_name) = LOWER(r_column.columnname)
        ) INTO v_fk_exists;

        IF v_fk_exists THEN
            RAISE NOTICE '-- Already has FK, skipping: %.%', r_column.tablename, r_column.columnname;
            v_count_skipped := v_count_skipped + 1;
            CONTINUE;
        END IF;

        v_constraint_name := COALESCE(
            r_column.fkconstraintname,
            LOWER(r_column.tablename) || '_' || LOWER(r_column.columnname) || '_fkey'
        );

        -- ON DELETE behavior per AD_Column.FKConstraintType:
        --   C = CASCADE, S = SET NULL, N (or anything else/null) = default (no clause)
        v_ondelete := CASE r_column.fkconstrainttype
                          WHEN 'C' THEN ' ON DELETE CASCADE'
                          WHEN 'S' THEN ' ON DELETE SET NULL'
                          ELSE ''
                      END;

        v_sql := 'ALTER TABLE ' || r_column.tablename
               || ' ADD CONSTRAINT ' || v_constraint_name
               || ' FOREIGN KEY (' || r_column.columnname || ')'
               || ' REFERENCES ' || v_target_table || ' (' || v_target_column || ')'
               || v_ondelete
               || ' DEFERRABLE INITIALLY DEFERRED;';

        RAISE NOTICE '%', v_sql;

        IF v_execute THEN
            BEGIN
                EXECUTE v_sql;
                v_count_created := v_count_created + 1;
            EXCEPTION WHEN OTHERS THEN
                RAISE WARNING '-- FAILED %.% -> %.% : %', r_column.tablename, r_column.columnname, v_target_table, v_target_column, SQLERRM;
                v_count_errors := v_count_errors + 1;
            END;
            COMMIT;
        END IF;
    END LOOP;

    RAISE NOTICE '-- Done. Created: %, Skipped: %, Errors: %', v_count_created, v_count_skipped, v_count_errors;
END
$$;


