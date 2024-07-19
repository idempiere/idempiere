-- IDEMPIERE-5437  Improve description for SysConfig SYSTEM_NATIVE_SEQUENCE
SELECT register_migration_script('202209301138_IDEMPIERE-5437.sql') FROM dual;

-- Sep 30, 2022, 11:38:44 AM CEST
UPDATE AD_SysConfig SET Description='Please use Enable Native Sequence process to enable. Y - Yes Use Native Sequence , N - No Use iDempiere Sequence (AD_Sequence)',Updated=TO_TIMESTAMP('2022-09-30 11:38:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50016
;

