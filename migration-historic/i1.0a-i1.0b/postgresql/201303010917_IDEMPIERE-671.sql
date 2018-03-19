DROP INDEX ad_impformat_name
;

CREATE UNIQUE INDEX ad_impformat_name
	ON ad_impformat (ad_client_id, name)
;
SELECT register_migration_script('201303010917_IDEMPIERE-671.sql') FROM dual
;

