-- IDEMPIERE-5943 Implement table partitioning support
SELECT register_migration_script('202312041549_IDEMPIERE-5943.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 4, 2023, 3:49:42 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203881,0,0,'Y',TO_TIMESTAMP('2023-12-04 15:49:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 15:49:41','YYYY-MM-DD HH24:MI:SS'),100,'IsPartition','Partition','Partition','D','71a4c045-f75b-435e-997f-ca453554d40f')
;

-- Dec 4, 2023, 3:51:05 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216282,0,'Partition',100,'IsPartition','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-12-04 15:51:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 15:51:04','YYYY-MM-DD HH24:MI:SS'),100,203881,'Y','N','D','N','N','N','Y','fae626e9-69df-411a-8d1d-a8e59b3b48df','Y',0,'N','N','N')
;

-- Dec 4, 2023, 3:51:39 PM MYT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2023-12-04 15:51:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216282
;

-- Dec 4, 2023, 3:51:47 PM MYT
ALTER TABLE AD_Table ADD IsPartition CHAR(1) DEFAULT 'N' CHECK (IsPartition IN ('Y','N')) NOT NULL
;

-- Dec 4, 2023, 3:52:20 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203882,0,0,'Y',TO_TIMESTAMP('2023-12-04 15:52:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 15:52:19','YYYY-MM-DD HH24:MI:SS'),100,'PartitioningMethod','Partitioning Method','Partitioning Method','D','5dc2d9dd-1e38-4985-a741-2f779891e4df')
;

-- Dec 4, 2023, 3:53:10 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200261,'AD_Column PartitioningMethod','L',0,0,'Y',TO_TIMESTAMP('2023-12-04 15:53:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 15:53:09','YYYY-MM-DD HH24:MI:SS'),100,'D','N','81b6431b-0afa-49bc-b5fe-be9a7b2481cf','N')
;

-- Dec 4, 2023, 3:53:22 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200684,'Range',200261,'R',0,0,'Y',TO_TIMESTAMP('2023-12-04 15:53:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 15:53:22','YYYY-MM-DD HH24:MI:SS'),100,'D','d8a5f9ab-574e-4926-93eb-e4a392c36e3c')
;

-- Dec 4, 2023, 3:53:33 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200685,'List',200261,'L',0,0,'Y',TO_TIMESTAMP('2023-12-04 15:53:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 15:53:32','YYYY-MM-DD HH24:MI:SS'),100,'D','d909c15e-9b97-4171-87bb-7de77cee4eb8')
;

-- Dec 4, 2023, 3:55:31 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216283,0,'Partitioning Method',101,'PartitioningMethod',2,'N','N','N','N','N',0,'N',17,200261,0,0,'Y',TO_TIMESTAMP('2023-12-04 15:55:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 15:55:30','YYYY-MM-DD HH24:MI:SS'),100,203882,'Y','N','D','N','N','@IsPartition@=''Y''','N','Y','b67a043a-019a-479d-81c4-5439a3447aaa','Y',0,'N','N','N')
;

-- Dec 4, 2023, 3:55:42 PM MYT
ALTER TABLE AD_Column ADD PartitioningMethod VARCHAR2(2 CHAR) DEFAULT NULL 
;

-- Dec 4, 2023, 3:56:10 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203883,0,0,'Y',TO_TIMESTAMP('2023-12-04 15:56:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 15:56:10','YYYY-MM-DD HH24:MI:SS'),100,'RangePartitionInterval','Range Partition Interval','Range Partition Interval','D','f14b1920-8c8f-4cb5-9f85-a579d854625d')
;

-- Dec 4, 2023, 3:59:04 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203884,0,0,'Y',TO_TIMESTAMP('2023-12-04 15:59:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 15:59:04','YYYY-MM-DD HH24:MI:SS'),100,'CreatePartition','Create/update partition','Create/update partition','D','356bc70e-12d7-478b-a70f-24adb47024af')
;

-- Dec 4, 2023, 4:02:43 PM MYT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,AD_Process_UU,AllowMultipleExecution) VALUES (200157,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:02:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:02:42','YYYY-MM-DD HH24:MI:SS'),100,'Create/update partition','N','AD_Table CreatePartition','N','org.idempiere.tablepartition.process.CreatePartition','4','D',0,0,'N','Y','5f9a2aa4-a18d-4629-b613-15d2436c4898','NA')
;

-- Dec 4, 2023, 4:04:16 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,AD_Process_ID,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216285,0,'Create/update partition',100,'CreatePartition',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:04:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:04:15','YYYY-MM-DD HH24:MI:SS'),100,203884,'Y',200157,'N','D','N','N','N','Y','65d73bf3-bf25-45dd-aa14-662f511fccb2','Y',0,'Y','N','N')
;

-- Dec 4, 2023, 4:04:33 PM MYT
ALTER TABLE AD_Table ADD CreatePartition CHAR(1) DEFAULT NULL 
;

-- Dec 4, 2023, 4:05:45 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203885,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:05:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:05:44','YYYY-MM-DD HH24:MI:SS'),100,'IsPartitionKey','Partition Key','Partition Key','D','bac735c9-addb-4dfa-81d7-4506cbad6ed0')
;

-- Dec 4, 2023, 4:06:12 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216286,0,'Partition Key',101,'IsPartitionKey','''N''',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:06:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:06:11','YYYY-MM-DD HH24:MI:SS'),100,203885,'Y','N','D','N','N','N','Y','248d95b0-6318-4821-9053-fa6138d8049b','Y',0,'N','N','N')
;

-- Dec 4, 2023, 4:06:19 PM MYT
ALTER TABLE AD_Column ADD IsPartitionKey CHAR(1) DEFAULT 'N' CHECK (IsPartitionKey IN ('Y','N')) NOT NULL
;

-- Dec 4, 2023, 4:08:38 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203886,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:08:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:08:38','YYYY-MM-DD HH24:MI:SS'),100,'SeqNoPartition','Partition Key Sequence','Partition Key Sequence','D','d9593a7f-cc70-4403-834e-0dca74044fdb')
;

-- Dec 4, 2023, 4:21:40 PM MYT
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200411,'Table Partition','AD_TablePartition',0,'4',0,0,'Y',TO_TIMESTAMP('2023-12-04 16:21:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:21:40','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','D','N','Y','L','N','Y','b778984a-9a96-4db4-a54f-8f47e6583f5e','N','N','N','N','N')
;

-- Dec 4, 2023, 4:21:41 PM MYT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_TablePartition',1000000,'N','N','Table AD_TablePartition','Y','Y',0,0,TO_TIMESTAMP('2023-12-04 16:21:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:21:41','YYYY-MM-DD HH24:MI:SS'),100,200482,'Y',1000000,1,200000,'25e2994d-bed5-4a71-a6da-7b1b96c6cb77')
;

-- Dec 4, 2023, 4:25:41 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216287,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200411,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:39','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','8aa0a7f1-d581-4075-b7dd-229c81528e5f','N',0,'N','N','D','N')
;

-- Dec 4, 2023, 4:25:42 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203887,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:42','YYYY-MM-DD HH24:MI:SS'),100,'AD_TablePartition_ID','Table Partition','Table Partition','D','1751f83e-723a-49a4-894d-eee7526a2878')
;

-- Dec 4, 2023, 4:25:43 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216289,0,'Table Partition',200411,'AD_TablePartition_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:41','YYYY-MM-DD HH24:MI:SS'),100,203887,'N','N','D','N','N','N','Y','2dca6112-15b8-4bdc-836d-29067967f910','N',0,'N','N','N','N')
;

-- Dec 4, 2023, 4:25:45 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203888,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:44','YYYY-MM-DD HH24:MI:SS'),100,'AD_TablePartition_UU','AD_TablePartition_UU','AD_TablePartition_UU','D','771b52d3-12ba-4c1f-b2ec-e1bfc4465173')
;

-- Dec 4, 2023, 4:25:45 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216291,0,'AD_TablePartition_UU',200411,'AD_TablePartition_UU',36,'N','N','N','N','N',0,'N',200231,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:44','YYYY-MM-DD HH24:MI:SS'),100,203888,'N','N','D','N','N','N','Y','b28719af-aa1e-4461-8519-135684688bc0','N',0,'N','N','N','N')
;

-- Dec 4, 2023, 4:25:46 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216292,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200411,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:45','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','cbeed504-0d75-453b-8b85-07e7db4586ee','N',0,'N','N','D','N')
;

-- Dec 4, 2023, 4:25:47 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216293,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200411,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:46','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','89ef8f7b-0f27-4314-a9c2-163d90e630fb','N',0,'N','N','N','N')
;

-- Dec 4, 2023, 4:25:48 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216294,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200411,'CreatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:47','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','2f778d0a-ba9d-437b-ad54-74e43bd80b4a','N',0,'N','N','D','N')
;

-- Dec 4, 2023, 4:25:49 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216296,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200411,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:49','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','fc84d078-1b2c-4e8b-824d-bc22e45f0a7e','N',0,'N','N','N','N')
;

-- Dec 4, 2023, 4:25:50 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216297,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200411,'Name',60,'N','N','Y','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:49','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','9682330b-98e7-4668-84f5-92e44e16b4cd','Y',20,'N','N','N','N')
;

-- Dec 4, 2023, 4:25:51 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216298,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200411,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:50','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','e8c449c5-674a-4482-baef-74dc7af4ae70','N',0,'N','N','N','N')
;

-- Dec 4, 2023, 4:25:52 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216299,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200411,'UpdatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:25:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:25:51','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','683a0936-b0f2-4283-9191-481832116399','N',0,'N','N','D','N')
;

-- Dec 4, 2023, 4:30:01 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216300,0,'Table','Database Table information','The Database Table provides the information of the table definition',200411,'AD_Table_ID',10,'N','Y','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:30:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:30:00','YYYY-MM-DD HH24:MI:SS'),100,126,'N','N','D','N','N','N','Y','a8c6c6c3-c965-4b34-a274-c3b7ec6d3240','Y',0,'N','N','N','N')
;

-- Dec 4, 2023, 4:31:20 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203889,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:31:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:31:19','YYYY-MM-DD HH24:MI:SS'),100,'ExpressionPartition','Expression','SQL clause for partition','Expression','D','46974aa7-440e-4473-8092-cf80e3b98c2c')
;

-- Dec 4, 2023, 4:34:29 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216301,0,'Expression','SQL clause for partition',200411,'ExpressionPartition',250,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:34:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:34:29','YYYY-MM-DD HH24:MI:SS'),100,203889,'Y','N','D','N','N','N','Y','d90007d9-3737-4d8a-8acb-6beeec3fce2c','Y',0,'N','N','N')
;

-- Dec 4, 2023, 4:37:38 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208078,'IsPartition',100,216282,'Y',1,250,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 16:37:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:37:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d0e6d1e0-96a6-4f3d-8747-061b28c0ef47','Y',210,2,2)
;

-- Dec 4, 2023, 4:37:40 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208081,'Create/update partition',100,216285,'Y',1,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 16:37:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:37:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0ca9fea4-c0bf-4a97-b8a9-501667ce767c','Y',240,2,2)
;

-- Dec 4, 2023, 5:58:50 PM MYT
UPDATE AD_Field SET DisplayLogic='@IsPartition@=Y',Updated=TO_TIMESTAMP('2023-12-04 17:58:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208079
;

-- Dec 4, 2023, 6:02:19 PM MYT
UPDATE AD_Column SET IsToolbarButton='N',Updated=TO_TIMESTAMP('2023-12-04 18:02:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216285
;

-- Dec 4, 2023, 6:03:28 PM MYT
UPDATE AD_Field SET DisplayLogic='@IsPartition@=Y',Updated=TO_TIMESTAMP('2023-12-04 18:03:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208081
;

-- Dec 4, 2023, 6:06:42 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208082,'Partition Key',101,216286,'Y',1,530,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 18:06:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:06:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f37e6afb-66b4-4fc4-96b6-411675c109a8','Y',480,2,2)
;

-- Dec 4, 2023, 6:08:21 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216302,0,'Partition Key Sequence',101,'SeqNoPartition',14,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2023-12-04 18:08:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:08:20','YYYY-MM-DD HH24:MI:SS'),100,203886,'Y','N','D','N','N','N','Y','6fe55ecb-5be5-43bc-a347-15ba40b1e88e','Y',0,'N','N','N')
;

-- Dec 4, 2023, 6:08:28 PM MYT
ALTER TABLE AD_Column ADD SeqNoPartition NUMBER(10) DEFAULT NULL 
;

-- Dec 4, 2023, 6:09:25 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208083,'Partition Key Sequence',101,216302,'Y',14,540,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 18:09:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:09:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7f43d839-4d4c-46df-9bd4-5a564265a7f9','Y',490,2)
;

-- Dec 4, 2023, 6:10:12 PM MYT
UPDATE AD_Field SET DisplayLogic='@IsPartition@=Y',Updated=TO_TIMESTAMP('2023-12-04 18:10:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208082
;

-- Dec 4, 2023, 6:10:38 PM MYT
UPDATE AD_Field SET DisplayLogic='@IsPartition@=Y & @IsPartitionKey@=Y',Updated=TO_TIMESTAMP('2023-12-04 18:10:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208083
;

-- Dec 4, 2023, 6:31:40 PM MYT
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2023-12-04 18:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208083
;

-- Dec 4, 2023, 6:35:00 PM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,DisplayLogic,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200381,'Table Partition',100,120,'Y',200411,0,0,'Y',TO_TIMESTAMP('2023-12-04 18:34:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:34:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','N','N',1,'N','D','@IsPartition@=''Y''','N','N','6eecaed6-a84a-4d43-adbc-954917c76d2a','B','N','Y',0)
;

-- Dec 4, 2023, 6:35:11 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208084,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200381,216287,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 18:35:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:35:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','40f081a2-c503-467c-926b-d963f7c01312','N',2)
;

-- Dec 4, 2023, 6:35:12 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208085,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200381,216292,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 18:35:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:35:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','737d9a62-d5f2-412d-9a9a-420d2f32c06d','Y','N',4,2)
;

-- Dec 4, 2023, 6:35:13 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208086,'Table','Database Table information','The Database Table provides the information of the table definition',200381,216300,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 18:35:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:35:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d2c0143c-2da2-43c5-8950-54c066f562a4','Y',10,2)
;

-- Dec 4, 2023, 6:35:14 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208087,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200381,216297,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 18:35:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:35:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b0cbc492-2be7-49f3-ad7f-c553037c8d0d','Y',20,5)
;

-- Dec 4, 2023, 6:35:14 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208088,'Table Partition',200381,216289,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 18:35:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:35:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4f8e1c9e-205a-43d6-884b-e8503eef6d86','N',2)
;

-- Dec 4, 2023, 6:35:16 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208089,'AD_TablePartition_UU',200381,216291,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 18:35:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:35:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','12666f96-7ead-472f-a9a0-b78ba5b5b30a','N',2)
;

-- Dec 4, 2023, 6:35:16 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208090,'Expression','SQL clause for partition',200381,216301,'Y',250,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 18:35:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:35:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','85314375-dd91-411e-b8fe-89649a84e039','Y',30,5)
;

-- Dec 4, 2023, 6:35:17 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208091,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200381,216296,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 18:35:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 18:35:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aa8e85d5-3cc6-4cc7-ab6a-0c36b5f1a8ec','Y',40,2,2)
;

-- Dec 4, 2023, 6:37:58 PM MYT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2023-12-04 18:37:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216301
;

-- Dec 4, 2023, 6:38:11 PM MYT
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADTable_ADTablePartition', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-12-04 18:38:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216300
;

-- Dec 4, 2023, 6:38:12 PM MYT
CREATE TABLE AD_TablePartition (AD_Client_ID NUMBER(10) DEFAULT NULL , AD_Org_ID NUMBER(10) DEFAULT NULL , AD_Table_ID NUMBER(10) NOT NULL, AD_TablePartition_ID NUMBER(10) DEFAULT NULL , AD_TablePartition_UU VARCHAR2(36 CHAR) DEFAULT NULL , Created DATE DEFAULT SYSDATE, CreatedBy NUMBER(10) DEFAULT NULL , ExpressionPartition VARCHAR2(250 CHAR) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')), Name VARCHAR2(60 CHAR) NOT NULL, Updated DATE DEFAULT SYSDATE, UpdatedBy NUMBER(10) DEFAULT NULL , CONSTRAINT AD_TablePartition_Key PRIMARY KEY (AD_TablePartition_ID), CONSTRAINT AD_TablePartition_UU_idx UNIQUE (AD_TablePartition_UU))
;

-- Dec 4, 2023, 6:38:12 PM MYT
ALTER TABLE AD_TablePartition ADD CONSTRAINT ADTable_ADTablePartition FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

