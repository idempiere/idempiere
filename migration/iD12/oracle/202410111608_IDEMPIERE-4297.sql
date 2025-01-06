-- IDEMPIERE-4297 - Add Status Line Dashboard Examples to GW
SELECT register_migration_script('202410111608_IDEMPIERE-4297.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 11, 2024, 4:08:54 PM CEST
UPDATE AD_StatusLine SET SQLStatement='SELECT COALESCE(SUM(grandtotal),0)
FROM rv_c_invoice 
WHERE docstatus IN (''CO'',''CL'') 
AND issotrx = ''Y'' 
AND ad_client_id = @#AD_Client_ID@
',Updated=TO_TIMESTAMP('2024-10-11 16:08:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_StatusLine_ID=200023
;

-- Oct 11, 2024, 4:09:16 PM CEST
UPDATE AD_Message SET MsgText='Total Sales: {0,number,currency}',Updated=TO_TIMESTAMP('2024-10-11 16:09:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200902
;

