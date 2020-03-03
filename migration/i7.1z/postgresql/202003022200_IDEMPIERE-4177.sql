-- IDEMPIERE-4177 Replace SYSDATE with getDate()
CREATE OR REPLACE FUNCTION getDate()
RETURNS TIMESTAMP WITH TIME ZONE AS $$
BEGIN
    RETURN statement_timestamp();
END;
$$ LANGUAGE plpgsql STABLE
;

SELECT register_migration_script('202003022200_IDEMPIERE-4177.sql') FROM dual
;
