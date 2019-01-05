UPDATE ad_column SET entitytype='D' WHERE ad_column_id=213821;

UPDATE ad_element SET entitytype='D' WHERE ad_element_id=203286;

SELECT register_migration_script('201901052200_IDEMPIERE-3837Dict.sql') FROM dual
;

