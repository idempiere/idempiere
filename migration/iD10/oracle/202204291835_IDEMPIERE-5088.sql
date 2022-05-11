-- IDEMPIERE-5088 Implement Bank Transfer as Transactional Document like Payment
SELECT register_migration_script('202204291835_IDEMPIERE-5088.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 29, 2022, 6:35:01 PM CEST
UPDATE AD_Process SET IsActive='Y', Name='Bank/Cash Transfer Process', Description='Bank/Cash Transfer let money transfer between Banks',Updated=TO_TIMESTAMP('2022-04-29 18:35:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53153
;

-- Apr 29, 2022, 6:35:01 PM CEST
UPDATE AD_Menu SET Name='Bank/Cash Transfer Process', Description='Bank/Cash Transfer let money transfer between Banks', IsActive='Y',Updated=TO_TIMESTAMP('2022-04-29 18:35:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53190
;

-- Apr 29, 2022, 7:08:32 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203588,0,0,'Y',TO_TIMESTAMP('2022-04-29 19:08:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-29 19:08:15','YYYY-MM-DD HH24:MI:SS'),100,'IsCreateBankTransferDoc','Create Bank Transfer Document',NULL,NULL,'Create Bank Transfer Document','D','13f16541-d2b5-451e-9c5a-ee44647f5aa8')
;

-- Apr 29, 2022, 7:09:29 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200385,0,0,'Y',TO_TIMESTAMP('2022-04-29 19:09:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-29 19:09:29','YYYY-MM-DD HH24:MI:SS'),100,'Create Bank Transfer Document',53153,130,20,'N',1,'Y','Y','IsCreateBankTransferDoc','Y','D',203588,'57fdbdce-fb7c-4acc-8db0-89d1ff02d309','N','N')
;

