SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 7, 2015 10:39:54 AM COT
-- IDEMPIERE-1492
UPDATE AD_Process SET Name='Bank/Cash Transfer', Description='Bank/Cash Transfer let money tranfer between Banks',Updated=TO_DATE('2015-01-07 10:39:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53153
;

-- Jan 7, 2015 10:39:54 AM COT
UPDATE AD_Menu SET Name='Bank/Cash Transfer', Description='Bank/Cash Transfer let money tranfer between Banks', IsActive='Y',Updated=TO_DATE('2015-01-07 10:39:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53190
;

-- Jan 7, 2015 10:43:38 AM COT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200115,0,0,'Y',TO_DATE('2015-01-07 10:43:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-07 10:43:37','YYYY-MM-DD HH24:MI:SS'),100,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',53153,120,19,130,'N',10,'Y','@#AD_Org_ID@','AD_Org_ID','Y','D',113,'cf69cf9d-aac5-430f-b290-d6d4ba70cf8e','N')
;

-- Jan 7, 2015 11:00:05 AM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Banks From and To must be different',0,0,'Y',TO_DATE('2015-01-07 11:00:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-07 11:00:04','YYYY-MM-DD HH24:MI:SS'),100,200329,'BankFromToMustDiffer','D','238c4118-870c-47b7-833a-f2d51f200ac6')
;

-- Jan 7, 2015 11:04:17 AM COT
UPDATE AD_Process_Para SET DefaultValue='@$C_Currency_ID@',Updated=TO_DATE('2015-01-07 11:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53256
;

SELECT register_migration_script('201501071044_IDEMPIERE-1492.sql') FROM dual
;

