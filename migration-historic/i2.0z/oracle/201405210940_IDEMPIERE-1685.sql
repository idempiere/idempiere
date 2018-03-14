SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 21, 2014 9:33:38 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Process_Para SET IsMandatory='N',Updated=TO_DATE('2014-05-21 09:33:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53296
;

-- May 21, 2014 9:34:55 AM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Reference_ID,Created) VALUES ('N',200084,'91039e02-6882-44c3-85bb-c19f1c64404a',53161,'Y','D','Use Default CoA','UseDefaultCoA','Use Default Chart of Accounts',1,'N',175,'N','Y',100,TO_DATE('2014-05-21 09:34:54','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,20,TO_DATE('2014-05-21 09:34:54','YYYY-MM-DD HH24:MI:SS'))
;

-- May 21, 2014 9:35:08 AM COT
UPDATE AD_Process_Para SET DisplayLogic='@UseDefaultCoA@=N',Updated=TO_DATE('2014-05-21 09:35:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53296
;

-- May 21, 2014 9:36:38 AM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Reference_ID,Created) VALUES ('N',200085,'8dade641-2744-4373-9087-b52e62ff43e7','Define if this client will use activity accounting dimension.  This can be changed later in Accounting Schema window of the client.',53161,'Y','D','Activity Accounting','IsUseSalesRegionDimension','Use Activity accounting dimension',1,'N',174,'N','Y',100,TO_DATE('2014-05-21 09:36:38','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,20,TO_DATE('2014-05-21 09:36:38','YYYY-MM-DD HH24:MI:SS'))
;

-- May 21, 2014 9:37:18 AM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Reference_ID,Created) VALUES ('N',200086,'a8406ff5-13e5-4166-9ece-1a758935533b',53161,'Y','D','Inactivate Defaults','InactivateDefaults','Inactivate Defaults after Created',1,'N',185,'N','Y',100,TO_DATE('2014-05-21 09:37:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,20,TO_DATE('2014-05-21 09:37:18','YYYY-MM-DD HH24:MI:SS'))
;

-- May 21, 2014 9:37:46 AM COT
UPDATE AD_Process_Para SET SeqNo=280,Updated=TO_DATE('2014-05-21 09:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53407
;

-- May 21, 2014 9:37:49 AM COT
UPDATE AD_Process_Para SET SeqNo=270,Updated=TO_DATE('2014-05-21 09:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53352
;

-- May 21, 2014 9:37:52 AM COT
UPDATE AD_Process_Para SET SeqNo=260,Updated=TO_DATE('2014-05-21 09:37:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53351
;

-- May 21, 2014 9:37:57 AM COT
UPDATE AD_Process_Para SET SeqNo=250,Updated=TO_DATE('2014-05-21 09:37:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53350
;

-- May 21, 2014 9:38:03 AM COT
UPDATE AD_Process_Para SET SeqNo=240,Updated=TO_DATE('2014-05-21 09:38:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53349
;

-- May 21, 2014 9:38:12 AM COT
UPDATE AD_Process_Para SET SeqNo=230,Updated=TO_DATE('2014-05-21 09:38:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200086
;

-- May 21, 2014 9:38:15 AM COT
UPDATE AD_Process_Para SET SeqNo=220,Updated=TO_DATE('2014-05-21 09:38:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53296
;

-- May 21, 2014 9:38:20 AM COT
UPDATE AD_Process_Para SET SeqNo=210,Updated=TO_DATE('2014-05-21 09:38:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200084
;

-- May 21, 2014 9:38:24 AM COT
UPDATE AD_Process_Para SET SeqNo=200,Updated=TO_DATE('2014-05-21 09:38:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200085
;

-- May 21, 2014 9:38:28 AM COT
UPDATE AD_Process_Para SET SeqNo=190,Updated=TO_DATE('2014-05-21 09:38:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53295
;

-- May 21, 2014 9:38:33 AM COT
UPDATE AD_Process_Para SET SeqNo=180,Updated=TO_DATE('2014-05-21 09:38:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53294
;

-- May 21, 2014 9:38:36 AM COT
UPDATE AD_Process_Para SET SeqNo=170,Updated=TO_DATE('2014-05-21 09:38:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53293
;

-- May 21, 2014 9:38:41 AM COT
UPDATE AD_Process_Para SET SeqNo=160,Updated=TO_DATE('2014-05-21 09:38:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53292
;

-- May 21, 2014 9:38:45 AM COT
UPDATE AD_Process_Para SET SeqNo=150,Updated=TO_DATE('2014-05-21 09:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53291
;

-- May 21, 2014 9:38:51 AM COT
UPDATE AD_Process_Para SET SeqNo=140,Updated=TO_DATE('2014-05-21 09:38:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53353
;

-- May 21, 2014 9:38:54 AM COT
UPDATE AD_Process_Para SET SeqNo=130,Updated=TO_DATE('2014-05-21 09:38:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53348
;

-- May 21, 2014 9:38:59 AM COT
UPDATE AD_Process_Para SET SeqNo=120,Updated=TO_DATE('2014-05-21 09:38:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53290
;

-- May 21, 2014 9:39:03 AM COT
UPDATE AD_Process_Para SET SeqNo=110,Updated=TO_DATE('2014-05-21 09:39:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53289
;

-- May 21, 2014 9:39:07 AM COT
UPDATE AD_Process_Para SET SeqNo=100,Updated=TO_DATE('2014-05-21 09:39:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53288
;

-- May 21, 2014 9:39:11 AM COT
UPDATE AD_Process_Para SET SeqNo=90,Updated=TO_DATE('2014-05-21 09:39:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53287
;

-- May 21, 2014 9:39:14 AM COT
UPDATE AD_Process_Para SET SeqNo=80,Updated=TO_DATE('2014-05-21 09:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53286
;

-- May 21, 2014 9:39:19 AM COT
UPDATE AD_Process_Para SET SeqNo=70,Updated=TO_DATE('2014-05-21 09:39:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200075
;

-- May 21, 2014 9:39:24 AM COT
UPDATE AD_Process_Para SET SeqNo=60,Updated=TO_DATE('2014-05-21 09:39:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53285
;

-- May 21, 2014 9:39:28 AM COT
UPDATE AD_Process_Para SET SeqNo=50,Updated=TO_DATE('2014-05-21 09:39:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200074
;

SELECT register_migration_script('201405210940_IDEMPIERE-1685.sql') FROM dual
;

