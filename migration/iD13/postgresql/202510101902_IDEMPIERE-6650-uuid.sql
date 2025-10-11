-- IDEMPIERE-6650 Performance - Implement support for using the uuid postgres datatype (FHCA-7074)
-- pl/pgsql anonymous block that converts ALL UUID columns from varchar(36) to native postgresql UUID datatype
-- this script can be executed again and again when needed, it just touches the columns not converted
-- in case of failure you need to evaluate which actions to take before restarting it - for example drop some view and recreate it after
SELECT register_migration_script('202510101902_IDEMPIERE-6650-uuid.sql') FROM dual;

-- set as UUID all _UU columns that were defined previously as String (for example by 2Packs)
UPDATE ad_column
SET ad_reference_id = 200231
WHERE ad_column_id IN (
  SELECT c.ad_column_id
    FROM ad_column c
      JOIN ad_table t USING (ad_table_id)
    WHERE AD_Reference_ID != 200231 AND 
      ColumnName = substr(t.tablename, 0, 27) || '_UU'
);

DO $$
DECLARE
    r_column RECORD;
    r_fk RECORD;
    v_createallfksql text;
    v_execute boolean := TRUE;
    v_count integer := 0;
BEGIN
    -- Loop through all VARCHAR(36) columns that appear to be UUIDs
    FOR r_column IN
    SELECT
        pc.relname,
        a.attname,
        pg_catalog.format_type(a.atttypid, a.atttypmod) AS datatype,
        CASE WHEN fk.constraint_name IS NOT NULL THEN
            TRUE
        ELSE
            FALSE
        END AS hasforeignkey,
        CASE WHEN pg_get_expr(ad.adbin, ad.adrelid) IS NOT NULL THEN
            'ALTER TABLE ' || t.tablename || ' ALTER COLUMN ' || c.columnname || ' SET DEFAULT ' || REPLACE(pg_get_expr(ad.adbin, ad.adrelid), 'NULL::character varying', 'NULL::uuid') || ';'
        ELSE
            NULL
        END AS alterdefaultsql,
        -- 'ALTER TABLE ' || t.tablename || ' ALTER COLUMN ' || c.columnname || ' TYPE uuid USING ' || c.columnname || '::uuid;' AS alterdatatypesql,
        'INSERT INTO t_alter_column values('''||t.tablename||''','''||c.columnname||''',''uuid USING '||c.columnname||'::uuid'',null,null);' AS alterdatatypesql,
        CASE WHEN a.attnotnull THEN
            'ALTER TABLE ' || t.tablename || ' ALTER COLUMN ' || c.columnname || ' SET NOT NULL;'
        ELSE
            NULL
        END AS alternotnullsql
    FROM
        ad_column c
        JOIN ad_table t USING (ad_table_id)
        JOIN pg_catalog.pg_class pc ON LOWER(t.tablename) = LOWER(pc.relname)
    JOIN pg_catalog.pg_attribute a ON pc.oid = a.attrelid
        AND LOWER(c.columnname) = LOWER(a.attname)
    LEFT JOIN pg_catalog.pg_attrdef ad ON a.attrelid = ad.adrelid
        AND a.attnum = ad.adnum
    LEFT JOIN ( SELECT DISTINCT
            kcu.table_name,
            kcu.column_name,
            tc.constraint_name
        FROM
            information_schema.table_constraints AS tc
            JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
                AND tc.table_schema = kcu.table_schema
        WHERE
            tc.constraint_type = 'FOREIGN KEY') fk ON LOWER(t.tablename) = LOWER(fk.table_name)
        AND LOWER(c.columnname) = LOWER(fk.column_name)
WHERE
    c.ad_reference_id IN (200231, /*UUID*/ 200233, /*TableUU*/ 200234, /*TableDirUU*/ 200235, /*SearchUU*/ 200240 /*RecordUU*/)
        AND a.attnum > 0
        AND pg_catalog.format_type(a.atttypid, a.atttypmod) != 'uuid'
        AND NOT a.attisdropped
    ORDER BY
        hasforeignkey DESC,
        pc.relname,
        a.attname LOOP
            v_createallfksql := '';
            RAISE NOTICE '-- Processing: %.% (FK: %)', r_column.relname, r_column.attname, r_column.hasforeignkey;
            IF r_column.hasforeignkey THEN
                -- Handle first foreign keys
                FOR r_fk IN
                SELECT
                    tc.constraint_name,
                    tc.table_name AS source_table,
                    kcu.column_name AS source_column,
                    ccu.table_name AS referenced_table,
                    ccu.column_name AS referenced_column,
                    rc.update_rule,
                    rc.delete_rule,
                    'ALTER TABLE ' || tc.table_name || ' DROP CONSTRAINT ' || tc.constraint_name || ';' AS dropfksql,
                    'ALTER TABLE ' || tc.table_name || ' ADD CONSTRAINT ' || tc.constraint_name || ' FOREIGN KEY (' || kcu.column_name || ')' || ' REFERENCES ' || ccu.table_name || ' (' || ccu.column_name || ')' || ' ON UPDATE ' || rc.update_rule || ' ON DELETE ' || rc.delete_rule || ';' AS createfksql
                FROM
                    information_schema.table_constraints AS tc
                    JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
                        AND tc.table_schema = kcu.table_schema
                    JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name
                        AND ccu.table_schema = tc.table_schema
                    JOIN information_schema.referential_constraints AS rc ON tc.constraint_name = rc.constraint_name
                        AND tc.table_schema = rc.constraint_schema
                WHERE
                    tc.constraint_type = 'FOREIGN KEY'
                    AND tc.table_name = r_column.relname
                    AND kcu.column_name = r_column.attname LOOP
                        -- Drop foreign key constraint
                        RAISE NOTICE '%', r_fk.dropfksql;
                        IF v_execute THEN
                            EXECUTE r_fk.dropfksql;
                        END IF;
                        v_createallfksql := v_createallfksql || chr(10) || chr(10) || r_fk.createfksql;
                    END LOOP;
            END IF;
            IF r_column.alterdefaultsql IS NOT NULL THEN
                RAISE NOTICE '%', r_column.alterdefaultsql;
                IF v_execute THEN
                    EXECUTE r_column.alterdefaultsql;
                END IF;
            END IF;
            RAISE NOTICE '%', r_column.alterdatatypesql;
            IF v_execute THEN
                EXECUTE r_column.alterdatatypesql;
            END IF;
            IF r_column.alternotnullsql IS NOT NULL THEN
                RAISE NOTICE '%', r_column.alternotnullsql;
                IF v_execute THEN
                    EXECUTE r_column.alternotnullsql;
                END IF;
            END IF;
            v_count := v_count + 1;
            IF LENGTH(v_createallfksql) > 0 THEN
                RAISE NOTICE '%', v_createallfksql;
            END IF;
            COMMIT;
        END LOOP;
    RAISE NOTICE '-- Processed % UUID columns', v_count;
END
$$;

