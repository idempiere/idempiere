-- IDEMPIERE-1083 Print shipping label applet is not working
DELETE FROM AD_SysConfig WHERE AD_SysConfig_ID = 200036
;

SELECT register_migration_script('201311061318_IDEMPIERE-1083.sql') FROM dual
;