-- Nov 30, 2012 5:06:08 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('StorageArchive',200257,'D','StorageArchive','Storage Archive','766f13f0-dd9f-4a36-8540-f9f990a81f25',0,TO_DATE('2012-11-30 17:06:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-30 17:06:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 30, 2012 5:06:08 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200257 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 30, 2012 5:11:05 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Element SET ColumnName='StorageArchive_ID', Name='StorageArchive_ID', PrintName='Storage Archive_ID',Updated=TO_DATE('2012-11-30 17:11:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200257
;

-- Nov 30, 2012 5:11:05 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200257
;

-- Nov 30, 2012 5:11:05 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET ColumnName='StorageArchive_ID', Name='StorageArchive_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200257
;

-- Nov 30, 2012 5:11:05 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Process_Para SET ColumnName='StorageArchive_ID', Name='StorageArchive_ID', Description=NULL, Help=NULL, AD_Element_ID=200257 WHERE UPPER(ColumnName)='STORAGEARCHIVE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 30, 2012 5:11:05 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Process_Para SET ColumnName='StorageArchive_ID', Name='StorageArchive_ID', Description=NULL, Help=NULL WHERE AD_Element_ID=200257 AND IsCentrallyMaintained='Y'
;

-- Nov 30, 2012 5:11:05 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET Name='StorageArchive_ID', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200257) AND IsCentrallyMaintained='Y'
;

-- Nov 30, 2012 5:11:05 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_PrintFormatItem pi SET PrintName='Storage Archive_ID', Name='StorageArchive_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200257)
;

-- Nov 30, 2012 5:11:22 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,227,201007,'U','N','N','N',0,'N',22,'N',18,'N',200257,'N','Y','764723f1-4251-4153-8198-0615453fa358','Y','N','StorageArchive_ID','StorageArchive_ID','Y',TO_DATE('2012-11-30 17:11:21','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-30 17:11:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 30, 2012 5:11:22 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=201007 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 30, 2012 5:16:08 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200023,'AD_StorageProvider_ID','D','2dc5386f-d9db-4758-a03e-e8695a286ff2','N','AD_StorageProvider_ID','T',0,0,100,TO_DATE('2012-11-30 17:16:07','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2012-11-30 17:16:07','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Nov 30, 2012 5:16:08 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200023 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Nov 30, 2012 5:17:00 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Ref_Table (IsValueDisplayed,AD_Reference_ID,AD_Key,AD_Display,EntityType,AD_Table_ID,AD_Ref_Table_UU,CreatedBy,Updated,Created,AD_Client_ID,UpdatedBy,AD_Org_ID,IsActive) VALUES ('N',200023,200961,200969,'D',200037,'2d31b980-72b5-4c2e-964b-91fa288f0a12',100,TO_DATE('2012-11-30 17:17:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-30 17:17:00','YYYY-MM-DD HH24:MI:SS'),0,100,0,'Y')
;

-- Nov 30, 2012 5:17:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET AD_Reference_Value_ID=200023,Updated=TO_DATE('2012-11-30 17:17:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=201007
;

-- Nov 30, 2012 5:18:10 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
ALTER TABLE AD_ClientInfo ADD StorageArchive_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 30, 2012 5:20:25 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (1,1,0,'N',169,0,'N','N',201007,240,'Y',200949,'N','D','StorageArchive_ID','40744096-6d57-48e7-8931-6c237ee9ac3c','Y','N',100,0,TO_DATE('2012-11-30 17:20:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-30 17:20:24','YYYY-MM-DD HH24:MI:SS'),'Y','Y',320,1,'N')
;

-- Nov 30, 2012 5:20:25 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200949 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET ColumnSpan=2, SeqNo=120, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200949
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9201
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1564
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1563
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1562
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=170,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1565
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=180,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1566
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=190,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1567
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=200,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10319
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=210,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10320
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=220,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57531
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=230,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57534
;

-- Nov 30, 2012 5:20:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=240,Updated=TO_DATE('2012-11-30 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57535
;

-- Nov 30, 2012 5:30:06 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Ref_Table SET IsValueDisplayed='Y', AD_Display=200961,Updated=TO_DATE('2012-11-30 17:30:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200023
;

-- Nov 30, 2012 5:34:49 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Ref_Table SET IsValueDisplayed='N',Updated=TO_DATE('2012-11-30 17:34:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200023
;

INSERT INTO ad_storageprovider
            (ad_client_id,
             ad_org_id,
             ad_storageprovider_id,
             ad_storageprovider_uu,
             created,
             createdby,
             folder,
             isactive,
             method,
             name,
             password,
             updated,
             updatedby,
             url,
             username)
SELECT 
             ad_client_id,
             0,
             nextidfunc(200033,'N'),
             generate_uuid(),
             sysdate,
             100,
             coalesce(windowsarchivepath, unixarchivepath),
             'Y',
             'FileSystem',
             'Folder',
             null,
             sysdate,
             100,
             null,
             null
FROM ad_client
WHERE storearchiveonfilesystem='Y' AND (windowsarchivepath is not null or unixarchivepath is not null)
;

UPDATE ad_clientinfo
   SET storagearchive_id = (SELECT ad_storageprovider_id FROM ad_storageprovider JOIN ad_client ON ad_client.ad_client_id=ad_storageprovider.ad_client_id
                                WHERE ad_storageprovider.ad_client_id=ad_clientinfo.ad_client_id
				  AND coalesce(ad_client.windowsarchivepath, ad_client.unixarchivepath)=ad_storageprovider.folder)
WHERE ad_clientinfo.ad_client_id IN
  (SELECT ad_client_id FROM ad_client WHERE storearchiveonfilesystem='Y' AND (windowsarchivepath is not null or unixarchivepath is not null))
;

-- Dec 5, 2012 6:49:08 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-12-05 18:49:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50215
;

-- Dec 5, 2012 6:49:14 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-12-05 18:49:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50216
;

-- Dec 5, 2012 6:49:18 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-12-05 18:49:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50214
;

-- Dec 5, 2012 6:55:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Field SET IsCentrallyMaintained='N', Name='Attachment Store',Updated=TO_DATE('2012-12-05 18:55:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200948
;

-- Dec 5, 2012 6:55:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200948
;

-- Dec 5, 2012 6:56:36 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Element SET Name='Archive Store', PrintName='Archive Store',Updated=TO_DATE('2012-12-05 18:56:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200257
;

-- Dec 5, 2012 6:56:36 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200257
;

-- Dec 5, 2012 6:56:36 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Column SET ColumnName='StorageArchive_ID', Name='Archive Store', Description=NULL, Help=NULL WHERE AD_Element_ID=200257
;

-- Dec 5, 2012 6:56:36 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Process_Para SET ColumnName='StorageArchive_ID', Name='Archive Store', Description=NULL, Help=NULL, AD_Element_ID=200257 WHERE UPPER(ColumnName)='STORAGEARCHIVE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 5, 2012 6:56:36 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Process_Para SET ColumnName='StorageArchive_ID', Name='Archive Store', Description=NULL, Help=NULL WHERE AD_Element_ID=200257 AND IsCentrallyMaintained='Y'
;

-- Dec 5, 2012 6:56:36 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_Field SET Name='Archive Store', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200257) AND IsCentrallyMaintained='Y'
;

-- Dec 5, 2012 6:56:36 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario / Implement archive part
UPDATE AD_PrintFormatItem pi SET PrintName='Archive Store', Name='Archive Store' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200257)
;

SELECT register_migration_script('201212051000_IDEMPIERE_390.sql') FROM dual
;

