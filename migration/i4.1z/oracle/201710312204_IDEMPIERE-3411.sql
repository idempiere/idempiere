-- IDEMPIERE-3411
update ad_sysconfig set entitytype='D' where ad_sysconfig_id in (
200104
);

SELECT register_migration_script('201710312204_IDEMPIERE-3411.sql') FROM dual
;

