-- IDEMPIERE-5288 org.zkoss.poi.POIXMLException attaching XLSX file
SELECT register_migration_script('202205101725_IDEMPIERE-5288.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 10, 2022, 5:25:40 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','<html>There was an error previewing this file.</html>',0,0,'Y',TO_TIMESTAMP('2022-05-10 17:25:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-10 17:25:40','YYYY-MM-DD HH24:MI:SS'),100,200749,'ErrorPreviewingFile','D','67f5c60d-50c0-467b-af04-d46a95555c57')
;

