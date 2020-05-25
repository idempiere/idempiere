UPDATE AD_Column SET AD_Reference_ID = 16
WHERE AD_Reference_ID != 16 AND ColumnName IN ('Created','Updated')
;

SELECT register_migration_script('202005121431_IDEMPIERE-1108.sql') FROM dual
;

