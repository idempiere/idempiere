-- IDEMPIERE-6166 PostgreSQL DUAL table with more than one record
SELECT register_migration_script('202406072107_IDEMPIERE-6166.sql') FROM dual;

DROP TABLE IF EXISTS dual
;

CREATE VIEW dual AS SELECT 'X'::varchar AS dummy
;

DROP RULE insert_dbreplicasyncverifier ON dbreplicasyncverifier
;

CREATE OR REPLACE FUNCTION forbid_multiple_rows_in_dbreplicasyncverifier()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the table already contains a row
    IF (SELECT COUNT(*) FROM dbreplicasyncverifier) > 0 THEN
        RAISE EXCEPTION 'Table dbreplicasyncverifier can only contain one row.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql
;

CREATE TRIGGER single_row_only_trigger_dbreplicasyncverifier
BEFORE INSERT ON dbreplicasyncverifier
FOR EACH ROW
EXECUTE FUNCTION forbid_multiple_rows_in_dbreplicasyncverifier()
;

