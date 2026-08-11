-- IDEMPIERE-6896 Unable to import DB seed into PostgreSQL 18
-- fix operator interval - integer
SELECT register_migration_script('202603121700_IDEMPIERE-6896.sql') FROM dual
;

DROP OPERATOR IF EXISTS - (INTERVAL, numeric);

CREATE OPERATOR - (
    FUNCTION = subtractdays,
    LEFTARG = interval,
    RIGHTARG = numeric
);

