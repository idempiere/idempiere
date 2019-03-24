SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3916 Copy Template
-- Mar 19, 2019, 3:57:52 PM BRT
UPDATE AD_Process SET Name='Copy Client', Description='Process to copy a client', Help='This process can be used to copy a client from an external database to the current database, or to duplicate a template client within the current database.',Updated=TO_DATE('2019-03-19 15:57:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200110
;

-- Mar 19, 2019, 3:57:52 PM BRT
UPDATE AD_Menu SET Name='Copy Client', Description='Process to copy a client', IsActive='Y',Updated=TO_DATE('2019-03-19 15:57:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200168
;

-- Mar 19, 2019, 3:59:09 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203301,0,0,'Y',TO_DATE('2019-03-19 15:58:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-19 15:58:39','YYYY-MM-DD HH24:MI:SS'),100,'IsCopyClient','Copy Template Client',NULL,NULL,'Copy Template Client','D','a5e530c4-15aa-4e5e-9d43-afb7b7528ce1')
;

-- Mar 19, 2019, 3:59:42 PM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200270,0,0,'Y',TO_DATE('2019-03-19 15:59:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-19 15:59:42','YYYY-MM-DD HH24:MI:SS'),100,'Copy Template Client',200110,5,20,'N',1,'Y','N','IsCopyClient','Y','D',203301,'c7f81809-5948-47fd-8a37-a6614266c104','N')
;

-- Mar 19, 2019, 4:00:55 PM BRT
UPDATE AD_Process_Para SET IsMandatory='N', DisplayLogic='IsCopyClient=N', MandatoryLogic='IsCopyClient=N',Updated=TO_DATE('2019-03-19 16:00:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200256
;

-- Mar 19, 2019, 4:01:02 PM BRT
UPDATE AD_Process_Para SET DisplayLogic='IsCopyClient=N',Updated=TO_DATE('2019-03-19 16:01:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200257
;

-- Mar 19, 2019, 4:01:04 PM BRT
UPDATE AD_Process_Para SET DisplayLogic='IsCopyClient=N',Updated=TO_DATE('2019-03-19 16:01:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200258
;

-- Mar 19, 2019, 4:01:29 PM BRT
UPDATE AD_Process_Para SET DisplayLogic='IsCopyClient=N',Updated=TO_DATE('2019-03-19 16:01:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200261
;

-- Mar 19, 2019, 4:01:43 PM BRT
UPDATE AD_Process_Para SET DisplayLogic='IsCopyClient=N',Updated=TO_DATE('2019-03-19 16:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200263
;

-- Mar 19, 2019, 4:03:09 PM BRT
UPDATE AD_Process_Para SET SeqNo=110,Updated=TO_DATE('2019-03-19 16:03:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200263
;

-- Mar 19, 2019, 4:03:17 PM BRT
UPDATE AD_Process_Para SET SeqNo=100,Updated=TO_DATE('2019-03-19 16:03:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200262
;

-- Mar 19, 2019, 4:03:21 PM BRT
UPDATE AD_Process_Para SET SeqNo=90,Updated=TO_DATE('2019-03-19 16:03:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200261
;

-- Mar 19, 2019, 4:03:28 PM BRT
UPDATE AD_Process_Para SET SeqNo=80,Updated=TO_DATE('2019-03-19 16:03:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200260
;

-- Mar 19, 2019, 4:03:32 PM BRT
UPDATE AD_Process_Para SET SeqNo=70,Updated=TO_DATE('2019-03-19 16:03:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200259
;

-- Mar 19, 2019, 4:03:41 PM BRT
UPDATE AD_Process_Para SET SeqNo=40,Updated=TO_DATE('2019-03-19 16:03:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200258
;

-- Mar 19, 2019, 4:03:45 PM BRT
UPDATE AD_Process_Para SET SeqNo=30,Updated=TO_DATE('2019-03-19 16:03:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200257
;

-- Mar 19, 2019, 4:03:48 PM BRT
UPDATE AD_Process_Para SET SeqNo=20,Updated=TO_DATE('2019-03-19 16:03:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200256
;

-- Mar 19, 2019, 4:03:53 PM BRT
UPDATE AD_Process_Para SET SeqNo=10,Updated=TO_DATE('2019-03-19 16:03:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200270
;

-- Mar 19, 2019, 4:06:44 PM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,MandatoryLogic) VALUES (200271,0,0,'Y',TO_DATE('2019-03-19 16:06:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-19 16:06:44','YYYY-MM-DD HH24:MI:SS'),100,'Client Name','Client in which current session user logged in',200110,50,10,'N',60,'N','ClientName','Y','D',200186,'@IsCopyClient@=Y','edbacdb3-9a07-490a-ba53-33d0cab63c47','N','@IsCopyClient@=Y')
;

-- Mar 19, 2019, 4:07:17 PM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,MandatoryLogic) VALUES (200272,0,0,'Y',TO_DATE('2019-03-19 16:07:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-19 16:07:16','YYYY-MM-DD HH24:MI:SS'),100,'Client Key','Key of the Client',200110,60,10,'N',40,'N','ClientValue','Y','D',2097,'@IsCopyClient@=Y','55b77a95-1564-41d2-9177-97fbcf264e66','N','@IsCopyClient@=Y')
;

-- Mar 19, 2019, 4:07:45 PM BRT
UPDATE AD_Process_Para SET DisplayLogic='@IsCopyClient@=N', MandatoryLogic='@IsCopyClient@=N',Updated=TO_DATE('2019-03-19 16:07:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200256
;

-- Mar 19, 2019, 4:07:51 PM BRT
UPDATE AD_Process_Para SET DisplayLogic='@IsCopyClient@=N',Updated=TO_DATE('2019-03-19 16:07:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200257
;

-- Mar 19, 2019, 4:07:56 PM BRT
UPDATE AD_Process_Para SET DisplayLogic='@IsCopyClient@=N',Updated=TO_DATE('2019-03-19 16:07:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200258
;

-- Mar 19, 2019, 4:08:11 PM BRT
UPDATE AD_Process_Para SET DisplayLogic='@IsCopyClient@=N',Updated=TO_DATE('2019-03-19 16:08:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200261
;

-- Mar 19, 2019, 4:08:21 PM BRT
UPDATE AD_Process_Para SET DisplayLogic='@IsCopyClient@=N',Updated=TO_DATE('2019-03-19 16:08:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200263
;

-- Mar 19, 2019, 4:09:44 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203302,0,0,'Y',TO_DATE('2019-03-19 16:09:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-19 16:09:00','YYYY-MM-DD HH24:MI:SS'),100,'IsSkipSomeValidations','Skip Some Validations',NULL,NULL,'Skip Some Validations','D','b061fb74-6d5f-49dd-a7ff-2e94eeca9fe4')
;

-- Mar 19, 2019, 4:10:39 PM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted) VALUES (200273,0,0,'Y',TO_DATE('2019-03-19 16:10:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-19 16:10:38','YYYY-MM-DD HH24:MI:SS'),100,'Skip Some Validations',200110,120,20,'N',1,'Y','N','IsSkipSomeValidations','Y','D',203302,'@IsCopyClient@=Y','976f2e77-2354-4724-89a8-d13176211649','N')
;

SELECT register_migration_script('201903191614_IDEMPIERE-3916_CopyClient.sql') FROM dual
;

