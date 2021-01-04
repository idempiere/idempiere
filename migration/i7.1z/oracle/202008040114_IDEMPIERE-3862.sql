-- IDEMPIERE-3862 ORACLE - Update datatype NVARCHAR2 to VARCHAR2

-- Script to change non-core tables and columns
-- NOTE: if you prefer to do it manually:
---   * change the dryrun variable to Y
--    * capture the output of running this script in a file and edit it
--    * verify and execute

SET ECHO OFF
SET SERVEROUTPUT ON SIZE 1000000
SET PAGESIZE 999
SET LINESIZE 32000

/* replace all NVARCHAR2 and VARCHAR2...BYTE columns to VARCHAR2...CHAR */
DECLARE
    old_table varchar2(128) := '^';
    old_idx varchar2(128) := '^';
    sql_drp_idxs varchar2(32767) := ''; -- drop indexes
    sql_cre_idxs varchar2(32767) := ''; -- create indexes
    sql_cre_comma varchar2(1) := ''; -- create indexes
    sql_cre_close varchar2(14) := ');';
    sql_add_cols varchar2(32767) := ''; -- add tmp columns
    sql_nul_cols varchar2(32767) := ''; -- make columns nullable
    sql_upd_cols varchar2(32767) := ''; -- update tmp=old, old=null
    sql_mod_cols varchar2(32767) := ''; -- make all columns varchar2
    sql_upb_cols varchar2(32767) := ''; -- update back old=tmp (restore)
    sql_nnl_cols varchar2(32767) := ''; -- make back columns not null
    sql_drp_cols varchar2(32767) := ''; -- drop tmp columns
    sql_add_comma varchar2(32767) := '';
    sql_nul_comma varchar2(32767) := '';
    sql_upd_comma varchar2(32767) := '';
    sql_mod_comma varchar2(32767) := '';
    sql_upb_comma varchar2(32767) := '';
    sql_nnl_comma varchar2(32767) := '';
    sql_drp_comma varchar2(32767) := '';
    sql_com_view varchar2(32767) := '';
    idx integer;
    tmpcolname varchar2(128);
    dryrun varchar2(1) := 'N'; -- change this to 'Y' to generate the script to execute, 'N' to execute immediate
BEGIN

    DBMS_OUTPUT.put_line(chr(10)||'-- Dropping functional based indexes and indexes unique where one of the columns to be modified is part');
    FOR i IN (
        SELECT ui.table_name, ui.index_name, ui.uniqueness, ui.index_type, uic.column_position, uic.column_name, uie.column_expression, uic.descend, uc.constraint_type
            FROM user_indexes ui
            JOIN user_ind_columns uic ON (ui.index_name= uic.index_name)
            LEFT JOIN user_ind_expressions uie ON (ui.index_name=uie.index_name AND uic.column_position=uie.column_position)
            LEFT JOIN user_constraints uc ON (ui.index_name=uc.index_name)
            WHERE ui.index_name IN (
                SELECT ui.index_name
                    FROM user_indexes ui
                    JOIN user_ind_columns uic ON (ui.index_name= uic.index_name)
                    WHERE EXISTS (
                        SELECT 1
                            FROM user_tab_columns utc
                            WHERE data_type = 'NVARCHAR2'
                                AND table_name IN (SELECT table_name FROM user_tables)
                                AND utc.table_name=ui.table_name
                                AND utc.column_name=uic.column_name
                        )
                    AND ui.uniqueness='UNIQUE'
                    AND ui.index_name IN (SELECT index_name FROM user_ind_columns GROUP BY index_name HAVING count(*)>1)
                UNION
                SELECT ui.index_name
                    FROM user_indexes ui
                    JOIN user_ind_columns uic ON (ui.index_name= uic.index_name)
                    WHERE EXISTS (
                        SELECT 1
                            FROM user_tab_columns utc
                            WHERE (data_type = 'NVARCHAR2' OR (data_type='VARCHAR2' AND char_used='B'))
                                AND table_name IN (SELECT table_name FROM user_tables)
                                AND utc.table_name=ui.table_name
                    )
                    AND ui.index_type!='NORMAL'
                )
            ORDER BY ui.table_name, ui.index_name, uic.column_position
    ) LOOP
        IF (old_idx = i.index_name)
        THEN
            /* new column in same index */
            sql_cre_comma := ',';
        ELSE
            /* This block is repeated exactly the same below, changes here must be done also there */
            IF (old_idx != '^')
            THEN
                /* close command */
                sql_cre_idxs := sql_cre_idxs || sql_cre_close;
            END IF;
            /* new index */
            old_idx := i.index_name;
            IF (i.constraint_type IN ('U','P'))
            THEN
                sql_drp_idxs := sql_drp_idxs || 'ALTER TABLE '||i.table_name||' DROP CONSTRAINT '||i.index_name||';';
                sql_cre_idxs := sql_cre_idxs || 'ALTER TABLE '||i.table_name||' ADD CONSTRAINT '||i.index_name||CASE WHEN i.constraint_type='U' THEN ' UNIQUE (' ELSE ' PRIMARY KEY (' END;
                sql_cre_close := ') USING INDEX;';
            ELSE
                sql_drp_idxs := sql_drp_idxs || 'DROP INDEX '||i.index_name||';';
                sql_cre_idxs := sql_cre_idxs || 'CREATE'||CASE WHEN i.uniqueness='UNIQUE' THEN ' UNIQUE' ELSE '' END||' INDEX '||i.index_name||' ON '||i.table_name||'(';
                sql_cre_close := ');';
            END IF;
            sql_cre_comma := '';
        END IF;
        sql_cre_idxs := sql_cre_idxs || sql_cre_comma || CASE WHEN i.column_expression IS NOT NULL THEN i.column_expression ELSE i.column_name END;
    END LOOP;
            /* This block is repeated exactly the same above, changes here must be done also there */
            IF (old_idx != '^')
            THEN
                /* close command */
                sql_cre_idxs := sql_cre_idxs || sql_cre_close;
            END IF;
    IF (sql_drp_idxs != ';')
    THEN
        FOR s IN (SELECT regexp_substr(sql_drp_idxs,'[^;]+', 1, level) AS cmd FROM DUAL
                  CONNECT BY regexp_substr(sql_drp_idxs, '[^;]+', 1, level) is not null
        ) LOOP
            DBMS_OUTPUT.put_line(s.cmd || ';');
            IF (dryrun != 'Y')
            THEN
                EXECUTE IMMEDIATE s.cmd;
            END IF;
        END LOOP;
    END IF;

    DBMS_OUTPUT.put_line(chr(10)||'-- Converting all VARCHAR2...BYTE to VARCHAR2..CHAR');
    old_table := '^';
    FOR c IN (
        SELECT table_name, column_name, data_type, char_length, char_used, nullable, data_default
            FROM user_tab_columns
            WHERE data_type = 'VARCHAR2' AND char_used='B'
                AND table_name IN (SELECT table_name FROM user_tables)
                -- AND table_name LIKE 'AD_CHART%' -- uncomment if you want to test with a smaller set of tables
            ORDER BY table_name, column_name
    ) LOOP
        IF (old_table = c.table_name)
        THEN
            /* new column in same table */
            idx := idx + 1;
            sql_mod_comma := ',';
        ELSE
            /* This block is repeated exactly the same below, changes here must be done also there */
            IF (old_table != '^')
            THEN
                /* close and execute commands */
                sql_mod_cols := sql_mod_cols || ')';
                DBMS_OUTPUT.put_line(sql_mod_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_mod_cols;
                END IF;
            END IF;
            /* new table */
            DBMS_OUTPUT.put_line(chr(10)||'-- Processing table ' || c.table_name);
            old_table := c.table_name;
            idx := 1;
            sql_mod_cols := 'ALTER TABLE '||c.table_name||' MODIFY (';
            sql_mod_comma := '';
        END IF;
        sql_mod_cols := sql_mod_cols || sql_mod_comma || c.column_name || ' VARCHAR2(' || c.char_length || ' CHAR)';
    END LOOP;
            /* This block is repeated exactly the same above, changes here must be done also there */
            IF (old_table != '^')
            THEN
                /* close and execute commands */
                sql_mod_cols := sql_mod_cols || ')';
                DBMS_OUTPUT.put_line(sql_mod_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_mod_cols;
                END IF;
            END IF;

    DBMS_OUTPUT.put_line(chr(10)||'-- Converting all NVARCHAR2 to VARCHAR2..CHAR');
    old_table := '^';
    FOR c IN (
        SELECT table_name, column_name, data_type, char_length, char_used, nullable, data_default
            FROM user_tab_columns
            WHERE data_type = 'NVARCHAR2'
                AND table_name IN (SELECT table_name FROM user_tables)
                -- AND table_name LIKE 'A_ASSET_GR%' -- uncomment if you want to test with a smaller set of tables
            ORDER BY table_name, column_name
    ) LOOP
        IF (old_table = c.table_name)
        THEN
            /* new column in same table */
            idx := idx + 1;
            sql_add_comma := ',';
            IF (sql_nul_cols NOT LIKE '%(' AND sql_nul_cols NOT LIKE '%,')
            THEN
                sql_nul_comma := ',';
            END IF;
            sql_upd_comma := ',';
            sql_mod_comma := ',';
            sql_upb_comma := ',';
            IF (sql_nnl_cols NOT LIKE '%(' AND sql_nnl_cols NOT LIKE '%,')
            THEN
                sql_nnl_comma := ',';
            END IF;
            sql_drp_comma := ',';
        ELSE
            /* This block is repeated exactly the same below, changes here must be done also there */
            IF (old_table != '^')
            THEN
                /* close and execute commands */
                sql_add_cols := sql_add_cols || ')';
                DBMS_OUTPUT.put_line(sql_add_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_add_cols;
                END IF;
                IF (sql_nul_cols NOT LIKE '%(')
                THEN
                    sql_nul_cols := sql_nul_cols || ')';
                    DBMS_OUTPUT.put_line(sql_nul_cols || ';');
                    IF (dryrun != 'Y')
                    THEN
                        EXECUTE IMMEDIATE sql_nul_cols;
                    END IF;
                END IF;
                -- sql_upd_cols := sql_upd_cols;
                DBMS_OUTPUT.put_line(sql_upd_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_upd_cols;
                END IF;
                sql_mod_cols := sql_mod_cols || ')';
                DBMS_OUTPUT.put_line(sql_mod_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_mod_cols;
                END IF;
                -- sql_upb_cols := sql_upb_cols;
                DBMS_OUTPUT.put_line(sql_upb_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_upb_cols;
                END IF;
                IF (sql_nnl_cols NOT LIKE '%(')
                THEN
                    sql_nnl_cols := sql_nnl_cols || ')';
                    DBMS_OUTPUT.put_line(sql_nnl_cols || ';');
                    IF (dryrun != 'Y')
                    THEN
                        EXECUTE IMMEDIATE sql_nnl_cols;
                    END IF;
                END IF;
                sql_drp_cols := sql_drp_cols || ')';
                DBMS_OUTPUT.put_line(sql_drp_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_drp_cols;
                END IF;
            END IF;
            /* new table */
            DBMS_OUTPUT.put_line(chr(10)||'-- Processing table ' || c.table_name);
            old_table := c.table_name;
            idx := 1;
            sql_add_cols := 'ALTER TABLE '||c.table_name||' ADD (';
            sql_nul_cols := 'ALTER TABLE '||c.table_name||' MODIFY (';
            sql_upd_cols := 'UPDATE '||c.table_name||' SET ';
            sql_mod_cols := 'ALTER TABLE '||c.table_name||' MODIFY (';
            sql_upb_cols := 'UPDATE '||c.table_name||' SET ';
            sql_nnl_cols := 'ALTER TABLE '||c.table_name||' MODIFY (';
            sql_drp_cols := 'ALTER TABLE '||c.table_name||' DROP (';
            sql_add_comma := '';
            sql_nul_comma := '';
            sql_upd_comma := '';
            sql_mod_comma := '';
            sql_upb_comma := '';
            sql_nnl_comma := '';
            sql_drp_comma := '';
        END IF;
        tmpcolname := 'tmp_col_'||idx||'_tmp';
        sql_add_cols := sql_add_cols || sql_add_comma || tmpcolname || ' VARCHAR2(' || c.char_length || ' CHAR)';
        IF (c.nullable = 'N')
        THEN
            sql_nul_cols := sql_nul_cols || sql_nul_comma || c.column_name || ' ' || c.data_type || '(' || c.char_length || ') NULL';
        END IF;
        sql_upd_cols := sql_upd_cols || sql_upd_comma || tmpcolname || '=' || c.column_name || ',' || c.column_name || '=NULL';
        sql_mod_cols := sql_mod_cols || sql_mod_comma || c.column_name || ' VARCHAR2(' || c.char_length || ' CHAR)';
        IF (c.data_default IS NOT NULL AND c.data_default != 'NULL')
        THEN
            sql_mod_cols := sql_mod_cols || ' DEFAULT ' || c.data_default;
        END IF;
        sql_upb_cols := sql_upb_cols || sql_upb_comma || c.column_name || '=' || tmpcolname;
        IF (c.nullable = 'N')
        THEN
            sql_nnl_cols := sql_nnl_cols || sql_nnl_comma || c.column_name || ' VARCHAR2(' || c.char_length || ' CHAR)';
            IF (c.data_default IS NOT NULL AND c.data_default != 'NULL')
            THEN
                sql_nnl_cols := sql_nnl_cols || ' DEFAULT ' || c.data_default;
            END IF;
            sql_nnl_cols := sql_nnl_cols || ' NOT NULL';
        END IF;
        sql_drp_cols := sql_drp_cols || sql_drp_comma || tmpcolname;
    END LOOP;
            /* This block is repeated exactly the same above, changes here must be done also there */
            IF (old_table != '^')
            THEN
                /* close and execute commands */
                sql_add_cols := sql_add_cols || ')';
                DBMS_OUTPUT.put_line(sql_add_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_add_cols;
                END IF;
                IF (sql_nul_cols NOT LIKE '%(')
                THEN
                    sql_nul_cols := sql_nul_cols || ')';
                    DBMS_OUTPUT.put_line(sql_nul_cols || ';');
                    IF (dryrun != 'Y')
                    THEN
                        EXECUTE IMMEDIATE sql_nul_cols;
                    END IF;
                END IF;
                -- sql_upd_cols := sql_upd_cols;
                DBMS_OUTPUT.put_line(sql_upd_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_upd_cols;
                END IF;
                sql_mod_cols := sql_mod_cols || ')';
                DBMS_OUTPUT.put_line(sql_mod_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_mod_cols;
                END IF;
                -- sql_upb_cols := sql_upb_cols;
                DBMS_OUTPUT.put_line(sql_upb_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_upb_cols;
                END IF;
                IF (sql_nnl_cols NOT LIKE '%(')
                THEN
                    sql_nnl_cols := sql_nnl_cols || ')';
                    DBMS_OUTPUT.put_line(sql_nnl_cols || ';');
                    IF (dryrun != 'Y')
                    THEN
                        EXECUTE IMMEDIATE sql_nnl_cols;
                    END IF;
                END IF;
                sql_drp_cols := sql_drp_cols || ')';
                DBMS_OUTPUT.put_line(sql_drp_cols || ';');
                IF (dryrun != 'Y')
                THEN
                    EXECUTE IMMEDIATE sql_drp_cols;
                END IF;
            END IF;

    DBMS_OUTPUT.put_line(chr(10)||'-- Recreating the dropped indexes');
    IF (sql_cre_idxs != ';')
    THEN
        FOR s IN (SELECT regexp_substr(sql_cre_idxs,'[^;]+', 1, level) AS cmd FROM DUAL
                  CONNECT BY regexp_substr(sql_cre_idxs, '[^;]+', 1, level) is not null
        ) LOOP
            DBMS_OUTPUT.put_line(s.cmd || ';');
            IF (dryrun != 'Y')
            THEN
                EXECUTE IMMEDIATE s.cmd;
            END IF;
        END LOOP;
    END IF;

    DBMS_OUTPUT.put_line(chr(10)||'-- Recompiling views affected');
    FOR c IN (
        SELECT DISTINCT table_name
            FROM user_tab_columns
            WHERE (data_type = 'NVARCHAR2' OR (data_type = 'VARCHAR2' AND char_used='B'))
                AND table_name IN (SELECT view_name FROM user_views)
            ORDER BY table_name
    ) LOOP
	sql_com_view := 'ALTER VIEW '||c.table_name||' COMPILE';
	DBMS_OUTPUT.put_line(sql_com_view || ';');
	IF (dryrun != 'Y')
	THEN
	    EXECUTE IMMEDIATE sql_com_view;
	END IF;
    END LOOP;

END;
/

SELECT register_migration_script('202008040114_IDEMPIERE-3862.sql') FROM dual
;
