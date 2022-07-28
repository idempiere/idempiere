-- IDEMPIERE-3219 Reset Accounting can't reset documents without fact acct
SELECT register_migration_script('202203260025_IDEMPIERE-3219.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 26, 2022, 12:25:29 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203567,0,0,'Y',TO_TIMESTAMP('2022-03-26 00:24:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-26 00:24:59','YYYY-MM-DD HH24:MI:SS'),100,'AlsoWithoutPostings','Also Without Postings',NULL,NULL,'Also Without Postings','D','3b693bd3-2827-4788-b722-82dd8a6c9d22')
;

-- Mar 26, 2022, 12:26:04 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,Placeholder,Placeholder2,IsAutocomplete) VALUES (200384,0,0,'Y',TO_TIMESTAMP('2022-03-26 00:26:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-26 00:26:03','YYYY-MM-DD HH24:MI:SS'),100,'Also Without Postings',NULL,NULL,176,50,20,'N',1,'Y','N','AlsoWithoutPostings','N','D',203567,'@DeletePosting@=Y','c410828b-129c-4c9e-aa49-be37c53fa664','N',NULL,NULL,'N')
;

-- Mar 26, 2022, 12:36:34 AM CET
UPDATE AD_Process_Para SET DefaultValue='@#AD_Client_ID@', IsCentrallyMaintained='N', ReadOnlyLogic='1=1',Updated=TO_TIMESTAMP('2022-03-26 00:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=225
;

-- Mar 26, 2022, 12:36:50 AM CET
UPDATE AD_Process_Para SET DefaultValue='@#AD_Client_ID@', IsCentrallyMaintained='N', ReadOnlyLogic='1=1',Updated=TO_TIMESTAMP('2022-03-26 00:36:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=223
;

