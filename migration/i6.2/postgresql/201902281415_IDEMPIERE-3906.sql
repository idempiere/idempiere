-- Sep 19, 2018 3:29:19 PM MYT
-- AP2-580 remove mandatory location on BP quick entry on OFX Transaction
UPDATE AD_SysConfig SET ConfigurationLevel='C' WHERE AD_SysConfig_ID=200145
;

SELECT register_migration_script('201902281415_IDEMPIERE-3906.sql') FROM dual
;

