SET SQLBLANKLINES ON
SET DEFINE OFF

-- Disable unnecessary logging in AD_HouseKeeping.LastRun
-- Dec 20, 2020, 8:36:11 AM CET
UPDATE AD_Column SET IsAllowLogging='N',Updated=TO_DATE('2020-12-20 08:36:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56343
;

SELECT register_migration_script('202012200836_DisableLogInHK.sql') FROM dual
;

