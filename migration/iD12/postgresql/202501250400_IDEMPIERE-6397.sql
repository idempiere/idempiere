-- IDEMPIERE-6397 PostgreSQL json datatype doesn't works well with JSON field editor
SELECT register_migration_script('202501250400_IDEMPIERE-6397.sql') FROM dual;

Alter Table Test Alter Column JsonData Type jsonb
;
