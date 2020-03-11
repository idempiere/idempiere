SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4191
-- Feb 28, 2020, 2:24:36 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200117,0,0,'Y',TO_DATE('2020-02-28 14:24:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:24:35','YYYY-MM-DD HH24:MI:SS'),100,'Migrate Storage Provider','Migrate the storage provider for attachments, archives and/or images','N','MigrateStorageProvider','N','org.idempiere.process.MigrateStorageProvider','6','D',0,0,'N','N','Y','N','e88ade56-8e2f-4dcf-a29c-687b83ee31ed','P')
;

-- Feb 28, 2020, 2:24:49 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200173,'Migrate Storage Provider','Migrate the storage provider for attachments, archives and/or images','P',0,0,'Y',TO_DATE('2020-02-28 14:24:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:24:48','YYYY-MM-DD HH24:MI:SS'),100,'N',200117,'Y','N','D','Y','66ef5225-0a24-4471-abcb-9d127aa6e6f3')
;

-- Feb 28, 2020, 2:24:49 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200173, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200173)
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200069
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200070
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200067
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200068
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Feb 28, 2020, 2:25:18 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200173
;

-- Feb 28, 2020, 2:36:57 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200287,0,0,'Y',TO_DATE('2020-02-28 14:36:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:36:56','YYYY-MM-DD HH24:MI:SS'),100,'Client (All)',200117,10,19,'N',10,'N','AD_AllClients_V_ID','Y','D',203119,'0e5fb109-e45c-40c6-86bd-ddb870b3c54f','N')
;

-- Feb 28, 2020, 2:41:33 PM CET
UPDATE AD_Process_Para SET DefaultValue='@SQL=SELECT CASE WHEN @#AD_Client_ID@>0 THEN @#AD_Client_ID@ ELSE -1 END', ReadOnlyLogic='@#AD_Client_ID@>0',Updated=TO_DATE('2020-02-28 14:41:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200287
;

-- Feb 28, 2020, 2:42:41 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203404,0,0,'Y',TO_DATE('2020-02-28 14:41:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:41:52','YYYY-MM-DD HH24:MI:SS'),100,'Actual_StorageProvider_ID','Actual Storage Provider',NULL,NULL,'Actual Storage Provider','D','0cfa1388-b17c-4c16-8506-8209d566cbd9')
;

-- Feb 28, 2020, 2:43:45 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200288,0,0,'Y',TO_DATE('2020-02-28 14:43:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:43:45','YYYY-MM-DD HH24:MI:SS'),100,'Actual Storage Provider',200117,20,18,200023,'N',10,'N','Actual_StorageProvider_ID','Y','D',203404,'e8760265-8b93-4535-bc62-3267597b8148','N')
;

-- Feb 28, 2020, 2:44:40 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200289,0,0,'Y',TO_DATE('2020-02-28 14:44:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:44:40','YYYY-MM-DD HH24:MI:SS'),100,'Storage Provider',200117,30,19,'N',10,'Y','AD_StorageProvider_ID','Y','D',200238,'fcded692-5976-4c18-be93-1de330b2c0f7','N')
;

-- Feb 28, 2020, 2:45:25 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203405,0,0,'Y',TO_DATE('2020-02-28 14:45:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:45:09','YYYY-MM-DD HH24:MI:SS'),100,'IsMigrateAttachment','Migrate Attachment',NULL,NULL,'Migrate Attachment','D','d8cebb40-2e30-4561-9c0c-34ce599f602f')
;

-- Feb 28, 2020, 2:45:55 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200290,0,0,'Y',TO_DATE('2020-02-28 14:45:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:45:55','YYYY-MM-DD HH24:MI:SS'),100,'Migrate Attachment',200117,40,20,'N',1,'Y','N','IsMigrateAttachment','Y','D',203405,'90601452-26c5-40f4-89fe-9a3875973afa','N')
;

-- Feb 28, 2020, 2:46:10 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203406,0,0,'Y',TO_DATE('2020-02-28 14:46:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:46:00','YYYY-MM-DD HH24:MI:SS'),100,'IsMigrateArchive','Migrate Archive',NULL,NULL,'Migrate Archive','D','b7080f1a-398e-4a19-9ccf-03d22aa8e605')
;

-- Feb 28, 2020, 2:46:17 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200291,0,0,'Y',TO_DATE('2020-02-28 14:46:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:46:16','YYYY-MM-DD HH24:MI:SS'),100,'Migrate Archive',200117,50,20,'N',1,'Y','N','IsMigrateArchive','Y','D',203406,'a35d4b7a-2647-4ad1-a994-68b376ef696e','N')
;

-- Feb 28, 2020, 2:46:30 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203407,0,0,'Y',TO_DATE('2020-02-28 14:46:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:46:21','YYYY-MM-DD HH24:MI:SS'),100,'IsMigrateImage','Migrate Image',NULL,NULL,'Migrate Image','D','da9b6551-af77-4e28-b788-bf94462cd342')
;

-- Feb 28, 2020, 2:46:33 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200292,0,0,'Y',TO_DATE('2020-02-28 14:46:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:46:33','YYYY-MM-DD HH24:MI:SS'),100,'Migrate Image',200117,60,20,'N',1,'Y','N','IsMigrateImage','Y','D',203407,'1c6fb7fb-fd93-48a6-8f30-3f8912880947','N')
;

-- Feb 28, 2020, 2:47:29 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200293,0,0,'Y',TO_DATE('2020-02-28 14:47:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-02-28 14:47:28','YYYY-MM-DD HH24:MI:SS'),100,'Delete old/existing records','Otherwise records will be added',200117,70,20,'N',1,'Y','N','DeleteOld','Y','D',1669,'2de2ab75-8533-4ff6-b01b-62f660c5d7a2','N')
;

-- Feb 28, 2020, 2:49:30 PM CET
UPDATE AD_Process_Para SET Name='Delete old/existing files', Description='Delete the records from the old storage provider after moved', Help='WARNING!  This option cannot be rolled back!  Be cautious, take backups.  If not enabled, the system administrator can/must remove manually the old files from the previous storage provider later.', IsCentrallyMaintained='N',Updated=TO_DATE('2020-02-28 14:49:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200293
;

-- Feb 28, 2020, 5:54:24 PM CET
UPDATE AD_Process_Para SET DisplayLogic='@AD_AllClients_V_ID:-1@=-1',Updated=TO_DATE('2020-02-28 17:54:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200288
;

-- Mar 4, 2020, 5:01:54 PM CET
UPDATE AD_Process SET Help='<p><span style="color:#ff0000"><b>WARNING: This process can be destructive, so please be sure that you have a backup of the database, as well as a backup of your old storage provider.</b></span></p>

<p>The process migrates files between storage providers.</p>

<ul><li><b>Client:</b> Optional, you can select a client to migrate, if empty it will try to migrate storage providers from all clients with the Actual Storage Provider selected below.</li><li><b>Actual Storage Provider:</b> If the client is empty, you define here the storage provider to migrate, if empty it migrates clients with the storage provider not set (this is by default DB).</li><li><b>Storage Provider:</b> The new storage provider to migrate the files.</li><li><b>Migrate Attachment:</b> If enabled, it migrates the attachment files to the new storage provider.</li><li><b>Migrate Archive:</b> If enabled, it migrates the archive files to the new storage provider.</li><li><b>Migrate Image:</b> If enabled, it migrates the image files to the new storage provider.</li><li><b>Delete old/existing files:</b> If enabled, after the files are migrated the program tries to free space deleting the files from the previous storage provider.  <span style="color:#ff0000">Note that migrating from/to a DB storage provider is a destructive action that cannot be recovered, it implies deleting the old/existing files</span>.</li></ul>

<p>Please note that during the migration the whole set of records in the table being migrated (attachment, archive, image) is locked, so operations on these records are not permitted.  Because of this, it is recommended to run this process in a <b>maintenance window</b> without users logged in the system.</p>

<p>In case of failure the attachments / archives / images that succeeded as a whole from a client are still migrated, but not partial records (which would result in data corruption if allowed).</p>
',Updated=TO_DATE('2020-03-04 17:01:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200117
;

-- Mar 4, 2020, 4:21:15 PM CET
UPDATE AD_Process_Para SET Name='Client', Description='Client/Tenant for this installation.', Help='A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.', AD_Reference_ID=18, AD_Reference_Value_ID=129, IsCentrallyMaintained='N',Updated=TO_DATE('2020-03-04 16:21:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200287
;

-- Mar 4, 2020, 4:23:12 PM CET
UPDATE AD_Process_Para SET AD_Reference_ID=19, AD_Reference_Value_ID=NULL,Updated=TO_DATE('2020-03-04 16:23:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200287
;

SELECT register_migration_script('202002281451_IDEMPIERE-4191.sql') FROM dual
;

