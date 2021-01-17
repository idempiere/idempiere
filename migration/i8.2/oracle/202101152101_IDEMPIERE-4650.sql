SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4650 Problems with Language Management in PO
-- 2021 Jan 15 20:49:25 CET
UPDATE AD_Column SET ReadOnlyLogic='@#AD_Client_ID@=0',Updated=TO_DATE('2021-01-15 20:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7567
;

UPDATE AD_Client SET IsMultilingualDocument='Y' WHERE AD_Client_ID=0 AND IsMultilingualDocument!='Y';

-- 2021 Jan 15 20:51:26 CET
UPDATE AD_Process SET Help='In order to enable en_US as a translation you can enable any other language as base language.<br>
If you don''t want to have a base language choose a language that won''t be used for login.<br>
If all languages are going to be used as login, create an xx_XX language not login and use it as base.<br>
Please note that base language cannot be a system language.<br>
After running this process you must close all sessions and login again.<br>',Updated=TO_DATE('2021-01-15 20:51:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200040
;

-- Jan 17, 2021, 4:15:10 PM CET
UPDATE AD_Client SET IsMultiLingualDocument='Y',Updated=TO_DATE('2021-01-17 16:15:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Client_ID=11
;

SELECT register_migration_script('202101152101_IDEMPIERE-4650.sql') FROM dual
;

