-- IDEMPIERE-5668
SELECT register_migration_script('202304250949_IDEMPIERE-5668.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 25, 2023, 9:49:32 AM BRT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=NULL,Updated=TO_TIMESTAMP('2023-04-25 09:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50002
;

-- Apr 25, 2023, 9:49:49 AM BRT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=NULL,Updated=TO_TIMESTAMP('2023-04-25 09:49:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50001
;

-- Apr 25, 2023, 9:49:53 AM BRT
DELETE FROM AD_Val_Rule WHERE AD_Val_Rule_UU='d1e9c6fc-5a01-41d5-bdaf-4f9f76b8eccd'
;

-- Apr 25, 2023, 9:50:39 AM BRT
DELETE FROM AD_Process_Para WHERE AD_Process_Para_UU='61319c51-d825-44bc-9244-ffe44c82ca82'
;

-- Apr 25, 2023, 9:51:13 AM BRT
UPDATE AD_Process_Para SET SeqNo=5,Updated=TO_TIMESTAMP('2023-04-25 09:51:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50004
;

-- Apr 25, 2023, 9:51:27 AM BRT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=NULL,Updated=TO_TIMESTAMP('2023-04-25 09:51:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50004
;

-- Apr 25, 2023, 9:55:19 AM BRT
UPDATE AD_Process SET Description='WARNING! when executing the process, all Role to access records will be lost, being replaced by Role from records',Updated=TO_TIMESTAMP('2023-04-25 09:55:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=50010
;

-- Apr 25, 2023, 9:55:19 AM BRT
UPDATE AD_Menu SET Name='Copy Role', Description='WARNING! when executing the process, all Role to access records will be lost, being replaced by Role from records', IsActive='Y',Updated=TO_TIMESTAMP('2023-04-25 09:55:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=50007
;

-- Apr 25, 2023, 10:19:33 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203807,0,0,'Y',TO_TIMESTAMP('2023-04-25 10:19:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-25 10:19:32','YYYY-MM-DD HH24:MI:SS'),100,'AD_Role_ID_From','Role From','Role that will be copied all accesses','Inform the role that you want to copy the access information','Role From','D','b8c55d50-a3e9-4448-ab48-420b3792fe00')
;

-- Apr 25, 2023, 10:29:08 AM BRT
DELETE FROM AD_Process_Para WHERE AD_Process_Para_UU='c91ae734-af0a-410b-8493-6c9333786c1f'
;

-- Apr 25, 2023, 10:29:35 AM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200436,0,0,'Y',TO_TIMESTAMP('2023-04-25 10:29:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-25 10:29:34','YYYY-MM-DD HH24:MI:SS'),100,'Role From','Role that will be copied all accesses','Inform the role that you want to copy the access information',50010,10,18,53317,'N',0,'N','AD_Role_ID_From','Y','D',203807,'5f991e98-4cf2-4390-9233-f9baa9457e1c','N','N','D','N')
;

-- Apr 25, 2023, 10:33:01 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203808,0,0,'Y',TO_TIMESTAMP('2023-04-25 10:33:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-25 10:33:01','YYYY-MM-DD HH24:MI:SS'),100,'AD_Role_ID_To','Role To','Role that will receive the copy of access permissions','Inform the role that will receive access information','Role To','D','19b55f83-b362-416b-b301-8e43b4700db2')
;

-- Apr 25, 2023, 10:33:33 AM BRT
DELETE FROM AD_Process_Para WHERE AD_Process_Para_UU='d701cb36-ab0f-4dac-aeb4-6aa5b935950c'
;

-- Apr 25, 2023, 10:33:56 AM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200437,0,0,'Y',TO_TIMESTAMP('2023-04-25 10:33:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-25 10:33:56','YYYY-MM-DD HH24:MI:SS'),100,'Role To','Role that will receive the copy of access permissions','Inform the role that will receive access information',50010,15,18,53317,'N',0,'N','AD_Role_ID_To','Y','D',203808,'4b94a03d-515b-4f1a-86a4-fc6991d922b3','N','N','D','N')
;

-- Apr 25, 2023, 10:35:03 AM BRT
UPDATE AD_Process_Para SET IsMandatory='Y',Updated=TO_TIMESTAMP('2023-04-25 10:35:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200436
;

-- Apr 25, 2023, 10:35:11 AM BRT
UPDATE AD_Process_Para SET IsMandatory='Y',Updated=TO_TIMESTAMP('2023-04-25 10:35:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200437
;
