-- IDEMPIERE-4579 Function altercolumn fails when a role name has a dash
-- Placeholder, function just required for postgresql

SELECT register_migration_script('201807250000_IDEMPIERE-4579.sql') FROM dual
;

