-- IDEMPIERE-3547 Mismatches in oracle foreign keys delete rule
-- Not necessary in postgresql, just for oracle

SELECT register_migration_script('201711061621_IDEMPIERE-3547.sql') FROM dual
;

