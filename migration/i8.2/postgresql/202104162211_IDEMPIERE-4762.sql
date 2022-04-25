-- IDEMPIERE-4762 Add AD_StorageProvider_ID to AD_Attachment (FHCA-1165)
-- Apr 16, 2021, 9:52:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214420,0,'Storage Provider',254,'AD_StorageProvider_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-04-16 21:52:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-04-16 21:52:15','YYYY-MM-DD HH24:MI:SS'),100,200238,'N','N','D','N','N','N','Y','c6ce4bd2-7688-451c-89bd-ac02866671fb','Y',0,'N','N','N')
;

-- Apr 16, 2021, 9:53:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206604,'Storage Provider',173,214420,'Y',22,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-04-16 21:53:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-04-16 21:53:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c1e37d25-d4ed-4681-a102-34be0dc1b5a8','Y',100,2)
;

-- Apr 16, 2021, 9:53:53 PM CEST
UPDATE AD_Field SET SeqNo=10, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 21:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=960
;

-- Apr 16, 2021, 9:53:53 PM CEST
UPDATE AD_Field SET SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 21:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2039
;

-- Apr 16, 2021, 9:53:53 PM CEST
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 21:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=963
;

-- Apr 16, 2021, 9:53:53 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 21:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=964
;

-- Apr 16, 2021, 9:53:53 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 21:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3819
;

-- Apr 16, 2021, 9:53:53 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 21:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10074
;

-- Apr 16, 2021, 9:53:53 PM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 21:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206604
;

-- Apr 16, 2021, 9:53:53 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 21:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=961
;

-- Apr 16, 2021, 9:53:53 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 21:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204470
;

-- Apr 16, 2021, 9:53:53 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 21:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=959
;

-- Apr 16, 2021, 9:55:50 PM CEST
UPDATE AD_Column SET FKConstraintName='ADStorageProvider_ADAttachment', FKConstraintType='N',Updated=TO_TIMESTAMP('2021-04-16 21:55:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214420
;

-- Apr 16, 2021, 9:55:50 PM CEST
ALTER TABLE AD_Attachment ADD COLUMN AD_StorageProvider_ID NUMERIC(10) DEFAULT NULL 
;

-- Apr 16, 2021, 9:55:50 PM CEST
ALTER TABLE AD_Attachment ADD CONSTRAINT ADStorageProvider_ADAttachment FOREIGN KEY (AD_StorageProvider_ID) REFERENCES ad_storageprovider(ad_storageprovider_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 16, 2021, 11:17:37 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214421,0,'Storage Provider',461,'AD_StorageProvider_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-04-16 23:17:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-04-16 23:17:37','YYYY-MM-DD HH24:MI:SS'),100,200238,'N','N','D','N','N','N','Y','ffac0527-d6d3-4a92-84cb-c15f7ac076c5','Y',0,'N','N','N')
;

-- Apr 16, 2021, 11:17:39 PM CEST
UPDATE AD_Column SET FKConstraintName='ADStorageProvider_ADImage', FKConstraintType='N',Updated=TO_TIMESTAMP('2021-04-16 23:17:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214421
;

-- Apr 16, 2021, 11:17:39 PM CEST
ALTER TABLE AD_Image ADD COLUMN AD_StorageProvider_ID NUMERIC(10) DEFAULT NULL 
;

-- Apr 16, 2021, 11:17:39 PM CEST
ALTER TABLE AD_Image ADD CONSTRAINT ADStorageProvider_ADImage FOREIGN KEY (AD_StorageProvider_ID) REFERENCES ad_storageprovider(ad_storageprovider_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 16, 2021, 11:18:35 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214422,0,'Storage Provider',754,'AD_StorageProvider_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-04-16 23:18:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-04-16 23:18:34','YYYY-MM-DD HH24:MI:SS'),100,200238,'N','N','D','N','N','N','Y','d15193c9-69cb-48de-94b4-5afeb82f405a','Y',0,'N','N','N','N')
;

-- Apr 16, 2021, 11:18:37 PM CEST
UPDATE AD_Column SET FKConstraintName='ADStorageProvider_ADArchive', FKConstraintType='N',Updated=TO_TIMESTAMP('2021-04-16 23:18:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214422
;

-- Apr 16, 2021, 11:18:37 PM CEST
ALTER TABLE AD_Archive ADD COLUMN AD_StorageProvider_ID NUMERIC(10) DEFAULT NULL 
;

-- Apr 16, 2021, 11:18:37 PM CEST
ALTER TABLE AD_Archive ADD CONSTRAINT ADStorageProvider_ADArchive FOREIGN KEY (AD_StorageProvider_ID) REFERENCES ad_storageprovider(ad_storageprovider_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 21, 2021, 5:36:53 PM CEST
UPDATE AD_Process_Para SET SeqNo=90,Updated=TO_TIMESTAMP('2021-04-21 17:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200293
;

-- Apr 21, 2021, 5:37:39 PM CEST
UPDATE AD_Process_Para SET DefaultValue='Y',Updated=TO_TIMESTAMP('2021-04-21 17:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200290
;

-- Apr 21, 2021, 5:37:43 PM CEST
UPDATE AD_Process_Para SET DefaultValue='Y',Updated=TO_TIMESTAMP('2021-04-21 17:37:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200291
;

-- Apr 21, 2021, 5:37:46 PM CEST
UPDATE AD_Process_Para SET DefaultValue='Y',Updated=TO_TIMESTAMP('2021-04-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200292
;

-- Apr 21, 2021, 5:39:08 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203483,0,0,'Y',TO_TIMESTAMP('2021-04-21 17:38:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-04-21 17:38:43','YYYY-MM-DD HH24:MI:SS'),100,'IsMigrateData','Migrate Data',NULL,NULL,'Migrate Data','D','cc8e6b76-fd73-4309-8fc6-2d9ead66d39d')
;

-- Apr 21, 2021, 5:39:16 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200340,0,0,'Y',TO_TIMESTAMP('2021-04-21 17:39:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-04-21 17:39:15','YYYY-MM-DD HH24:MI:SS'),100,'Migrate Data',200117,70,20,'N',1,'Y','Y','IsMigrateData','Y','D',203483,'c060a763-cdf5-4b44-9486-5be5fb523674','N','N')
;

-- Apr 21, 2021, 5:42:35 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,MandatoryLogic,IsAutocomplete) VALUES (200341,0,0,'Y',TO_TIMESTAMP('2021-04-21 17:42:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-04-21 17:42:35','YYYY-MM-DD HH24:MI:SS'),100,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200117,80,11,'Y',22,'N','Record_ID','Y','D',538,'c65e1cd9-1c1b-450c-a789-58feb9b7afe0','N',NULL,'N')
;

-- Apr 21, 2021, 5:54:28 PM CEST
UPDATE AD_Process SET Help='<p><span style="color:#ff0000"><b>WARNING: This process can be destructive, so please be sure that you have a backup of the database, as well as a backup of your old storage provider.</b></span></p>

<p>The process migrates files between storage providers.</p>

<ul><li><b>Client:</b> Optional, select a client to migrate, when empty it will migrate all clients with the Actual Storage Provider</li><li><b>Actual Storage Provider:</b> Alternatively, you can define here the storage provider to migrate</li><li><b>Storage Provider:</b> The new storage provider to migrate the files</li><li><b>Migrate Attachment:</b> Migrate the attachment files</li><li><b>Migrate Archive:</b> Migate the archive files</li><li><b>Migrate Image:</b> Migrate the image  files</li><li><b>Migrate Data:</b> When unchecked, just the storage provider is changed in client, but the files are not migrated (they can be migrated in a future execution of this same process)</li><li><b>Record ID Range:</b> Optionally you can define a range of IDs for the records to migrate, so you can run this process in parallel to migrate the data</li><li><b>Delete old/existing files:</b> If enabled, when a file is migrated the program tries to free space deleting the file from the previous storage provider.  <span style="color:#ff0000">Note that migrating from/to a DB storage provider is a destructive action that cannot be recovered, it implies deleting the old/existing files</span>.</li></ul>

<p>In case of failure or timeout, the process can be launched again, it commits on every file migrated.</p>',Updated=TO_TIMESTAMP('2021-04-21 17:54:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200117
;

-- set providers with actual values from client
UPDATE ad_attachment a SET ad_storageprovider_id = (SELECT ci.ad_storageprovider_id FROM ad_clientinfo ci WHERE ci.ad_client_id=a.ad_client_id)
WHERE a.ad_client_id IN (SELECT ad_client_id FROM ad_clientinfo WHERE ad_storageprovider_id IS NOT NULL);

UPDATE ad_image i SET ad_storageprovider_id = (SELECT ci.storageimage_id FROM ad_clientinfo ci WHERE ci.ad_client_id=i.ad_client_id)
WHERE ad_client_id IN (SELECT ad_client_id FROM ad_clientinfo WHERE storageimage_id IS NOT NULL);

UPDATE ad_archive a SET ad_storageprovider_id = (SELECT ci.storagearchive_id FROM ad_clientinfo ci WHERE ci.ad_client_id=a.ad_client_id)
WHERE ad_client_id IN (SELECT ad_client_id FROM ad_clientinfo WHERE storagearchive_id IS NOT NULL);

SELECT register_migration_script('202104162211_IDEMPIERE-4762.sql') FROM dual
;

