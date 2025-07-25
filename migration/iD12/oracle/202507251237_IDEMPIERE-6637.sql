-- IDEMPIERE-6637 Wrong Default Logic for Migration Storage Provider parameter AD_AllClients_V_ID in Oracle
SELECT register_migration_script('202507251237_IDEMPIERE-6637.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 25, 2025, 12:37:09 PM CEST
UPDATE AD_Process_Para SET DefaultValue='@SQL=SELECT CASE WHEN @#AD_Client_ID@>0 THEN @#AD_Client_ID@ ELSE -1 END FROM Dual',Updated=TO_DATE('2025-07-25 12:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200287
;

