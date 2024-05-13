-- IDEMPIERE-5963 Implement Sub-Partitioning and Detach Partition
SELECT register_migration_script('202312261050_IDEMPIERE-5963.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 26, 2023, 10:50:32 AM MYT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200158,0,0,'Y',TO_TIMESTAMP('2023-12-26 10:50:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-26 10:50:30','YYYY-MM-DD HH24:MI:SS'),100,'Detach/re-attach Table Partition','Detach or re-attach table partition','Detach an attached table partition or re-attach a detached table partition','N','DetachOrReAttachPartition','N','org.idempiere.tablepartition.process.ChangePartitionStatus','4','D',0,0,'N','Y','N','d55b6a76-26f7-45a6-9117-a8a9cdb78e0f','PA')
;

-- Dec 26, 2023, 10:52:22 AM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203890,0,0,'Y',TO_TIMESTAMP('2023-12-26 10:52:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-26 10:52:21','YYYY-MM-DD HH24:MI:SS'),100,'IsPartitionAttached','Attached','Partition attached to table','Attached','D','f2ba716f-605e-4f68-9ae7-96a384f5902c')
;

-- Dec 26, 2023, 10:53:31 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216306,0,'Attached','Partition attached to table',200411,'IsPartitionAttached','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-12-26 10:53:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-26 10:53:30','YYYY-MM-DD HH24:MI:SS'),100,203890,'Y','N','D','N','N','N','Y','9217549b-ee10-4ca0-9322-82822314c180','N',0,'N','N','N','N')
;

-- Dec 26, 2023, 10:53:37 AM MYT
ALTER TABLE AD_TablePartition ADD IsPartitionAttached CHAR(1) DEFAULT 'Y' CHECK (IsPartitionAttached IN ('Y','N')) NOT NULL
;

-- Dec 26, 2023, 11:01:05 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,AD_Process_ID,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216307,0,'Process Now',200411,'Processing',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2023-12-26 11:01:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-26 11:01:04','YYYY-MM-DD HH24:MI:SS'),100,524,'Y',200158,'N','D','N','Y','N','Y','ddcbfcb0-e232-4ccd-876a-af4b89265ed1','N',0,'B','N','N','N')
;

-- Dec 26, 2023, 11:01:10 AM MYT
ALTER TABLE AD_TablePartition ADD Processing CHAR(1) DEFAULT NULL 
;

-- Dec 26, 2023, 11:02:50 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208096,'Attached','Partition attached to table',200381,216306,'Y',0,80,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-26 11:02:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-26 11:02:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','32e3959f-1ddf-4764-b2d2-e706e4b5a1b6','Y',60,2,2,1,'N','N','N','N')
;

-- Dec 26, 2023, 11:04:14 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208097,'Process Now',200381,216307,'Y',0,90,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-26 11:04:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-26 11:04:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8ade7442-7e4e-440a-8a79-86431c3164ac','Y',70,1,2,1,'N','N','N','N')
;

-- Dec 27, 2023, 10:55:25 AM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203891,0,0,'Y',TO_TIMESTAMP('2023-12-27 10:55:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 10:55:24','YYYY-MM-DD HH24:MI:SS'),100,'Parent_TablePartition_ID','Parent Partition','Parent table partition','Parent Partition','D','b8a4d585-9114-43c9-b5cb-36a65783844e')
;

-- Dec 27, 2023, 10:56:58 AM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200262,'AD_TablePartition','Table Partition','T',0,0,'Y',TO_TIMESTAMP('2023-12-27 10:56:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 10:56:56','YYYY-MM-DD HH24:MI:SS'),100,'D','N','71d7e81f-de03-4329-86d4-41c0f07fa488','N')
;

-- Dec 27, 2023, 11:00:04 AM MYT
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200262,200411,216289,216297,0,0,'Y',TO_TIMESTAMP('2023-12-27 11:00:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 11:00:04','YYYY-MM-DD HH24:MI:SS'),100,'N','D','e667c6e5-b53c-43c5-a85f-243d3b188458')
;

-- Dec 27, 2023, 11:00:23 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216308,0,'Parent Partition','Parent table partition',200411,'Parent_TablePartition_ID',10,'N','N','N','N','N',0,'N',30,200262,0,0,'Y',TO_TIMESTAMP('2023-12-27 11:00:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 11:00:21','YYYY-MM-DD HH24:MI:SS'),100,203891,'N','N','D','N','N','N','Y','43a932ca-0f17-48b7-be99-e7b4327a7a22','N',0,'N','N','N','N')
;

-- Dec 27, 2023, 11:00:28 AM MYT
UPDATE AD_Column SET FKConstraintName='ParentTablePartition_ADTablePa', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-12-27 11:00:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216308
;

-- Dec 27, 2023, 11:00:28 AM MYT
ALTER TABLE AD_TablePartition ADD Parent_TablePartition_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 27, 2023, 11:00:28 AM MYT
ALTER TABLE AD_TablePartition ADD CONSTRAINT ParentTablePartition_ADTablePa FOREIGN KEY (Parent_TablePartition_ID) REFERENCES ad_tablepartition(ad_tablepartition_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 27, 2023, 11:02:48 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208098,'Parent Partition','Parent table partition',200381,216308,'Y',0,100,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-27 11:02:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 11:02:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cbd9fb43-e055-4e99-9d23-562d1ed515a6','Y',80,1,2,1,'N','N','N','N')
;

-- Dec 27, 2023, 11:03:46 AM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1,Updated=TO_TIMESTAMP('2023-12-27 11:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208098
;

-- Dec 27, 2023, 11:03:46 AM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=5,Updated=TO_TIMESTAMP('2023-12-27 11:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208097
;

-- Dec 27, 2023, 11:03:46 AM MYT
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-12-27 11:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208091
;

-- Dec 27, 2023, 11:03:46 AM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-12-27 11:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208089
;

-- Dec 27, 2023, 11:03:46 AM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-12-27 11:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208088
;

-- Dec 27, 2023, 1:39:36 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2023-12-27 13:39:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216301
;

-- Dec 27, 2023, 1:39:43 PM MYT
UPDATE AD_Column SET IsMandatory='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2023-12-27 13:39:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216296
;

-- Dec 27, 2023, 1:39:49 PM MYT
UPDATE AD_Column SET IsMandatory='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2023-12-27 13:39:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216306
;

-- Dec 27, 2023, 1:39:55 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2023-12-27 13:39:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216297
;

-- Dec 27, 2023, 1:40:04 PM MYT
UPDATE AD_Column SET IsAlwaysUpdateable='N',Updated=TO_TIMESTAMP('2023-12-27 13:40:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216307
;

-- Dec 27, 2023, 1:40:52 PM MYT
UPDATE AD_Tab SET IsReadOnly='N',Updated=TO_TIMESTAMP('2023-12-27 13:40:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200381
;

-- Dec 27, 2023, 2:20:41 PM MYT
UPDATE AD_Column SET IsMandatory='Y', IsUpdateable='Y',Updated=TO_TIMESTAMP('2023-12-27 14:20:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216306
;

-- Dec 27, 2023, 2:20:59 PM MYT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2023-12-27 14:20:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208096
;

-- Dec 28, 2023, 1:55:33 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Can''t detach or re-attach default partition',0,0,'Y',TO_TIMESTAMP('2023-12-28 13:55:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-28 13:55:32','YYYY-MM-DD HH24:MI:SS'),100,200859,'CantDetachReattachDefaultPartition','D','375e3278-6231-4486-a8ef-8a978ce57698')
;

-- Dec 28, 2023, 4:11:58 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The partition {0} has been successfully detached from table {1}',0,0,'Y',TO_TIMESTAMP('2023-12-28 16:11:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-28 16:11:57','YYYY-MM-DD HH24:MI:SS'),100,200860,'PartitionDetachFromTable','D','3b92cf36-e6e4-401b-8663-5897e54b8966')
;

-- Dec 28, 2023, 4:12:21 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The partition {0} has been successfully re-attached to table {1}',0,0,'Y',TO_TIMESTAMP('2023-12-28 16:12:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-28 16:12:21','YYYY-MM-DD HH24:MI:SS'),100,200861,'PartitionReAttachToTable','D','4a3c84d0-fc35-4d62-b5ab-3ba018453783')
;

-- Dec 29, 2023, 5:45:23 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','A maximum of two columns can be specified as partition keys. The first column defines the primary partition, and the second (optional) column defines the subpartition',0,0,'Y',TO_TIMESTAMP('2023-12-29 17:45:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-29 17:45:17','YYYY-MM-DD HH24:MI:SS'),100,200862,'OnlyTwoPartitionKeyAllowed','D','8b27d206-d764-4291-80ce-b00b135daa32')
;
