-- Feb 26, 2013 6:05:58 PM MYT
-- IDEMPIERE-724 Zk: Make iDempiere theme more easily customizable
UPDATE AD_SysConfig SET IsActive='N',Updated=TO_DATE('2013-02-26 18:05:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50025
;

SELECT register_migration_script('201303120925-IDEMPIERE-724.sql') FROM dual
;

