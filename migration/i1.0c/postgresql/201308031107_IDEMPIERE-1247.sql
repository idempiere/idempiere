-- IDEMPIERE-1247 UX: consistency on opening as single record view
UPDATE AD_Tab SET IsSingleRow='Y'
WHERE IsSingleRow='N'
AND IsActive='Y'
;

SELECT register_migration_script('201308031107_IDEMPIERE-1247.sql') FROM dual
;

