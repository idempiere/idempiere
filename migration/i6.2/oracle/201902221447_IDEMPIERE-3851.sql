UPDATE ad_column SET isautocomplete='Y' WHERE ad_reference_id IN (17,18,19) AND isautocomplete!='Y';

SELECT register_migration_script('201902221447_IDEMPIERE-3851.sql') FROM dual
;

