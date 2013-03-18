CREATE UNIQUE INDEX ad_sysconfig_org_name
	ON AD_SysConfig (ad_client_id, ad_org_id,name)
;

SELECT register_migration_script('201303151018_IDEMPIERE-752.sql') FROM dual
;
