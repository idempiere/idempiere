-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Mar 15, 2015 10:28:22 PM ICT
UPDATE AD_Process_Para SET IsCentrallyMaintained='N', IsEncrypted='Y',Updated=TO_TIMESTAMP('2015-03-15 22:28:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50008
;

-- Mar 15, 2015 10:36:26 PM ICT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted) VALUES (200121,0,0,'Y',TO_TIMESTAMP('2015-03-15 22:36:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-03-15 22:36:25','YYYY-MM-DD HH24:MI:SS'),100,'Inbox As Root Folder','True if other folder (request, error,..) occupy in inbox folder','Some email server as outlook, every folder occupy in inbox, with web mail as google, we easy create my folder outside inbox folder.
this field define where request, error,.. occupy.',50012,65,20,'N',1,'N','Y','p_NestInbox','N','D','b20ee48e-dbb5-4da2-aadb-cdfe40e02124','N')
;

-- Mar 15, 2015 10:39:37 PM ICT
UPDATE AD_Process_Para SET Description='Mail folder, where process will take email and make request', Help=E'folder can define as hierarchy, use "\\" to separate folder. example customer\\vietnam
will read email from folder vietnam under folder customer', IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2015-03-15 22:39:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50009
;

-- Mar 15, 2015 10:42:54 PM ICT
UPDATE AD_Process_Para SET Description='Mail folder to push unsuccess email  ', Help=E'folder can define as hierarchy, use "\\" to separate folder. example customer\\error\\vietnam
will puss email can''t process to folder vietnam under folder error under folder customer', IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2015-03-15 22:42:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50011
;

-- Mar 15, 2015 10:46:55 PM ICT
UPDATE AD_Process_Para SET Description='Mail folder, where process will take email and make request', Help=E'folder can define as hierarchy, use "\\" to separate folder. example customer\\vietnam
will read email from folder vietnam under folder customer', IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2015-03-15 22:46:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50010
;

-- Mar 15, 2015 10:48:26 PM ICT
UPDATE AD_Process_Para SET Description='After take email form inbox folder, and process it success, email will move to this folder', Help=E'folder can define as hierarchy, use "\\" to separate folder. example customer\\vietnam
will read email from folder vietnam under folder customer
after take email form inbox folder, and process it success, email will move to this folder',Updated=TO_TIMESTAMP('2015-03-15 22:48:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50009
;
SELECT register_migration_script('201503151604-IDEMPIERE-2244.sql') FROM dual
;
