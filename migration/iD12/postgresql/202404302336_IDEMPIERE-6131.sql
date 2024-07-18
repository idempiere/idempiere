-- IDEMPIERE-6131 Make ice blue compact the new theme for iDempiere Web Client
SELECT register_migration_script('202404302336_IDEMPIERE-6131.sql') FROM dual;

-- Apr 30, 2024, 11:36:02 PM MYT
UPDATE AD_SysConfig SET Value='iceblue_c',Updated=TO_TIMESTAMP('2024-04-30 23:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200021
;

