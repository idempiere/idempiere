SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 5, 2016 3:45:37 PM MYT
-- 1006003 UI - add conditional styles for fields
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,AD_Table_UU,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Org_ID,Updated,IsCentrallyMaintained,IsDeleteable,Description,TableName,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Processing,DatabaseViewDrop,EntityType,Created,LoadSeq) VALUES ('N','N','N','4','62c0e07c-2d65-46ea-88f0-c12043609d19',200207,'N','N','N','L',0,TO_DATE('2016-05-05 15:45:31','YYYY-MM-DD HH24:MI:SS'),'Y','Y','CSS style for field and label','AD_Style','Style','Y',100,100,0,'N','N','D',TO_DATE('2016-05-05 15:45:31','YYYY-MM-DD HH24:MI:SS'),0)
;

-- May 5, 2016 3:45:38 PM MYT
INSERT INTO AD_Sequence (StartNewYear,AD_Sequence_ID,IsTableID,IsAudited,IsAutoSequence,AD_Org_ID,Description,Name,IncrementNo,AD_Sequence_UU,CreatedBy,Updated,IsActive,StartNo,AD_Client_ID,Created,UpdatedBy,CurrentNextSys,CurrentNext) VALUES ('N',200271,'Y','N','Y',0,'Table AD_Style','AD_Style',1,'1961d13a-b648-468e-b8d5-ff2ba4048414',100,TO_DATE('2016-05-05 15:45:37','YYYY-MM-DD HH24:MI:SS'),'Y',1000000,0,TO_DATE('2016-05-05 15:45:37','YYYY-MM-DD HH24:MI:SS'),100,200000,1000000)
;

-- May 5, 2016 3:47:57 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Table_ID) VALUES (212727,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','Y','8bcf854e-3f6c-47b7-9e2d-dc4d16dc69b7',TO_DATE('2016-05-05 15:47:55','YYYY-MM-DD HH24:MI:SS'),'N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 15:47:55','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',102,19,129,200207)
;

-- May 5, 2016 3:49:54 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Table_ID) VALUES (212728,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','N','360578e3-e130-4e5f-a9d1-291de4043006',TO_DATE('2016-05-05 15:49:48','YYYY-MM-DD HH24:MI:SS'),'N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 15:49:48','YYYY-MM-DD HH24:MI:SS'),'U','N','N','D',113,19,104,200207)
;

-- May 5, 2016 3:50:02 PM MYT
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2016-05-05 15:50:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212728
;

-- May 5, 2016 3:50:12 PM MYT
UPDATE AD_Column SET IsAllowLogging='N',Updated=TO_DATE('2016-05-05 15:50:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212727
;

-- May 5, 2016 3:52:29 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212729,0,'N',0,'N','N','N',0,'N',7,'N','N','N','N','c33532fa-67f2-4b6f-ab08-64e8440a1870',TO_DATE('2016-05-05 15:52:18','YYYY-MM-DD HH24:MI:SS'),'N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 15:52:18','YYYY-MM-DD HH24:MI:SS'),'D','N','N',245,16,200207)
;

-- May 5, 2016 3:54:40 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212730,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','N','f293ee4a-c595-4574-a6d3-c7d1a2c87c2b',TO_DATE('2016-05-05 15:54:34','YYYY-MM-DD HH24:MI:SS'),'N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 15:54:34','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',246,18,110,200207)
;

-- May 5, 2016 3:56:42 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212731,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','d4065bae-c0bb-431f-9efa-2e21c48826d2',TO_DATE('2016-05-05 15:56:35','YYYY-MM-DD HH24:MI:SS'),'Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 15:56:35','YYYY-MM-DD HH24:MI:SS'),'D','N','N',348,20,200207)
;

-- May 5, 2016 3:58:10 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212732,0,'N',0,'Y','N','N',0,'N',7,'N','N','N','N','e3a10443-053e-4a77-845c-817a992f7c33',TO_DATE('2016-05-05 15:58:05','YYYY-MM-DD HH24:MI:SS'),'N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 15:58:05','YYYY-MM-DD HH24:MI:SS'),'U','N','N',607,16,200207)
;

-- May 5, 2016 3:58:26 PM MYT
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2016-05-05 15:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212732
;

-- May 5, 2016 3:59:12 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212733,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','N','9f1e7995-7c62-4246-a31d-b39d390029b2',TO_DATE('2016-05-05 15:59:02','YYYY-MM-DD HH24:MI:SS'),'N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 15:59:02','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',608,18,110,200207)
;

-- May 5, 2016 4:24:10 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203005,'AD_Style_ID',TO_DATE('2016-05-05 16:24:05','YYYY-MM-DD HH24:MI:SS'),'Style','CSS style for field and label','Style','3702753a-9006-4223-bcb4-bb3377f5fbdd','Y',TO_DATE('2016-05-05 16:24:05','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- May 5, 2016 4:25:14 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212734,0,'N',0,'Y','N','N',0,'N',22,'N','Y','N','N','ec5deb0d-4074-4f2a-93f7-2e75aab5756f',TO_DATE('2016-05-05 16:25:07','YYYY-MM-DD HH24:MI:SS'),'N','AD_Style_ID','CSS style for field and label','Style','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 16:25:07','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203005,13,200207)
;

-- May 5, 2016 4:25:45 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203006,'AD_Style_UU',TO_DATE('2016-05-05 16:25:45','YYYY-MM-DD HH24:MI:SS'),'Style','CSS Style for field and label','Style','220f69f9-1be3-4cd4-b862-9889e84c39da','Y',TO_DATE('2016-05-05 16:25:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- May 5, 2016 4:26:36 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212735,0,'N',0,'Y','N','N',0,'N',36,'N','N','N','N','8e1de6a6-c6d4-4eed-812b-e40efbf3194c',TO_DATE('2016-05-05 16:26:30','YYYY-MM-DD HH24:MI:SS'),'N','AD_Style_UU','CSS Style for field and label','Style','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 16:26:30','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203006,10,200207)
;

-- May 5, 2016 4:28:20 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212736,0,'N',0,'Y','N','Y',0,'N',60,'Y','N','N','Y','53e27da5-2e4d-4277-a4a3-335bba26acc0',TO_DATE('2016-05-05 16:28:15','YYYY-MM-DD HH24:MI:SS'),'Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 16:28:15','YYYY-MM-DD HH24:MI:SS'),'D','N','N',469,10,200207)
;

-- May 5, 2016 4:28:44 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212737,0,'N',0,'N','N','N',0,'N',255,'Y','N','N','Y','f17b961c-fefa-4296-876f-32ffee9e9dfb',TO_DATE('2016-05-05 16:28:43','YYYY-MM-DD HH24:MI:SS'),'Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 16:28:43','YYYY-MM-DD HH24:MI:SS'),'D','N','N',275,10,200207)
;

-- May 5, 2016 4:29:27 PM MYT
CREATE TABLE AD_Style (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_Style_ID NUMBER(10) NOT NULL, AD_Style_UU VARCHAR2(36) NOT NULL, Created DATE DEFAULT SYSDATE, CreatedBy NUMBER(10) NOT NULL, Description VARCHAR2(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR2(60) NOT NULL, Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_Style_Key PRIMARY KEY (AD_Style_ID), CONSTRAINT AD_Style_UU_idx UNIQUE (AD_Style_UU))
;

-- May 5, 2016 5:12:27 PM MYT
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,AD_Table_UU,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Org_ID,Updated,IsCentrallyMaintained,IsDeleteable,Description,TableName,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Processing,DatabaseViewDrop,EntityType,Created,LoadSeq) VALUES ('N','N','N','4','bf55b7a7-9b67-460f-8a16-052f79b685c9',200208,'N','N','N','L',0,TO_DATE('2016-05-05 17:12:21','YYYY-MM-DD HH24:MI:SS'),'Y','Y','Style Line','AD_StyleLine','Style Line','Y',100,100,0,'N','N','D',TO_DATE('2016-05-05 17:12:21','YYYY-MM-DD HH24:MI:SS'),0)
;

-- May 5, 2016 5:12:28 PM MYT
INSERT INTO AD_Sequence (StartNewYear,AD_Sequence_ID,IsTableID,IsAudited,IsAutoSequence,AD_Org_ID,Description,Name,IncrementNo,AD_Sequence_UU,CreatedBy,Updated,IsActive,StartNo,AD_Client_ID,Created,UpdatedBy,CurrentNextSys,CurrentNext) VALUES ('N',200272,'Y','N','Y',0,'Table AD_StyleLine','AD_StyleLine',1,'80f71a3c-1bbd-47ff-93d0-a96116658892',100,TO_DATE('2016-05-05 17:12:28','YYYY-MM-DD HH24:MI:SS'),'Y',1000000,0,TO_DATE('2016-05-05 17:12:28','YYYY-MM-DD HH24:MI:SS'),100,200000,1000000)
;

-- May 5, 2016 5:12:56 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Table_ID) VALUES (212738,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','N','3fd07e9a-baad-433e-bd78-c6b79e564fa7',TO_DATE('2016-05-05 17:12:55','YYYY-MM-DD HH24:MI:SS'),'N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:12:55','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',102,19,129,200208)
;

-- May 5, 2016 5:13:19 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Table_ID) VALUES (212739,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','N','c8d28051-6207-4103-8e93-3c21f8696aaa',TO_DATE('2016-05-05 17:13:18','YYYY-MM-DD HH24:MI:SS'),'N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:13:18','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',113,19,104,200208)
;

-- May 5, 2016 5:13:47 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212740,0,'N',0,'Y','N','N',0,'N',7,'N','N','N','N','1699c4c2-c986-4b25-896a-f151684aa9e4',TO_DATE('2016-05-05 17:13:46','YYYY-MM-DD HH24:MI:SS'),'N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:13:46','YYYY-MM-DD HH24:MI:SS'),'D','N','N',245,16,200208)
;

-- May 5, 2016 5:14:10 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212741,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','N','03d58561-41e0-4a1b-b544-ea88aa6fa681',TO_DATE('2016-05-05 17:14:09','YYYY-MM-DD HH24:MI:SS'),'N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:14:09','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',246,18,110,200208)
;

-- May 5, 2016 5:14:35 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212742,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','5aa60942-60fe-4a22-9912-e91b90c6eca7',TO_DATE('2016-05-05 17:14:34','YYYY-MM-DD HH24:MI:SS'),'Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:14:34','YYYY-MM-DD HH24:MI:SS'),'D','N','N',348,20,200208)
;

-- May 5, 2016 5:14:59 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212743,0,'N',0,'Y','N','N',0,'N',7,'N','N','N','N','c930bde3-018f-4f34-b9f3-277b776c1523',TO_DATE('2016-05-05 17:14:58','YYYY-MM-DD HH24:MI:SS'),'N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:14:58','YYYY-MM-DD HH24:MI:SS'),'D','N','N',607,16,200208)
;

-- May 5, 2016 5:15:24 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212744,0,'N',0,'Y','N','N',0,'N',22,'N','N','N','N','4c5aa8a1-5e88-4afa-bcf9-ce17780e004a',TO_DATE('2016-05-05 17:15:24','YYYY-MM-DD HH24:MI:SS'),'N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:15:24','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',608,18,110,200208)
;

-- May 5, 2016 5:16:05 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212745,0,'N',0,'Y','N','N',0,'Y',22,'N','N','N','Y','fc298f20-274c-4dd8-97ae-f33821f3b833',TO_DATE('2016-05-05 17:16:04','YYYY-MM-DD HH24:MI:SS'),'N','AD_Style_ID','CSS style for field and label','Style','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:16:04','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203005,19,200208)
;

-- May 5, 2016 5:16:40 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203007,'AD_StyleLine_ID',TO_DATE('2016-05-05 17:16:38','YYYY-MM-DD HH24:MI:SS'),'Style Line','CSS Style Line','Style Line','5dd4b93d-bf6b-4a4a-9bc6-09c71e98a78c','Y',TO_DATE('2016-05-05 17:16:38','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- May 5, 2016 5:17:09 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203008,'AD_StyleLine_UU',TO_DATE('2016-05-05 17:17:09','YYYY-MM-DD HH24:MI:SS'),'Style Line','CSS Style Line','Style Line','cbac0adc-56fe-4c2c-b789-439347ca977a','Y',TO_DATE('2016-05-05 17:17:09','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- May 5, 2016 5:17:44 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212746,0,'N',0,'Y','N','N',0,'N',22,'N','Y','N','N','8820d8ac-3a70-4888-9512-e9ecd62666a5',TO_DATE('2016-05-05 17:17:38','YYYY-MM-DD HH24:MI:SS'),'N','AD_StyleLine_ID','CSS Style Line','Style Line','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:17:38','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203007,13,200208)
;

-- May 5, 2016 5:18:16 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212747,0,'N',0,'Y','N','N',0,'N',36,'N','N','N','N','dd6812da-56b5-4d80-84d4-b98b52e7ea03',TO_DATE('2016-05-05 17:18:15','YYYY-MM-DD HH24:MI:SS'),'N','AD_StyleLine_UU','CSS Style Line','Style Line','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:18:15','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203008,10,200208)
;

-- May 5, 2016 5:21:25 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203009,'InlineStyle',TO_DATE('2016-05-05 17:21:19','YYYY-MM-DD HH24:MI:SS'),'Inline Style','CSS Inline Style','Inline Style','6c16aa39-2133-413d-81ef-a8f119e7c25f','Y',TO_DATE('2016-05-05 17:21:19','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- May 5, 2016 5:22:23 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212748,0,'N',0,'Y','N','N',0,'N',255,'N','N','N','Y','5c3fbb51-adfe-4f18-a810-090bbb88af4b',TO_DATE('2016-05-05 17:22:22','YYYY-MM-DD HH24:MI:SS'),'Y','InlineStyle','CSS Inline Style','Inline Style','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:22:22','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203009,10,200208)
;

-- May 5, 2016 5:22:50 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212749,0,'N',0,'N','N','N',0,'N',2000,'N','N','N','Y','c377332c-9ee6-413f-a933-85b7fb94780a',TO_DATE('2016-05-05 17:22:49','YYYY-MM-DD HH24:MI:SS'),'Y','DisplayLogic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)','Display Logic','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:22:49','YYYY-MM-DD HH24:MI:SS'),'D','N','N',283,14,200208)
;

-- May 5, 2016 5:23:07 PM MYT
UPDATE AD_Column SET FieldLength=2000,Updated=TO_DATE('2016-05-05 17:23:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212748
;

-- May 5, 2016 5:24:07 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203010,'Theme',TO_DATE('2016-05-05 17:24:06','YYYY-MM-DD HH24:MI:SS'),'Theme','Theme name','Theme','2a436d7c-a51f-4b51-a5db-e3097db45fe6','Y',TO_DATE('2016-05-05 17:24:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- May 5, 2016 5:24:39 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212750,0,'N',0,'N','N','N',0,'N',60,'N','N','N','Y','d0264334-c102-41a9-825d-c6345907e11b',TO_DATE('2016-05-05 17:24:38','YYYY-MM-DD HH24:MI:SS'),'Y','Theme','Theme name','Theme','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:24:38','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203010,10,200208)
;

-- May 5, 2016 5:30:28 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212751,0,'N',0,'Y','N','Y',1,'N',22,'N','N','N','Y','ece590ce-221c-4fd7-b3fc-36dc046cf29c',TO_DATE('2016-05-05 17:30:22','YYYY-MM-DD HH24:MI:SS'),'Y','Line','Unique line for this document','@SQL=SELECT COALESCE(MAX(Line),0)+10 FROM AD_StyleLine WHERE AD_Style_ID =@AD_Style_ID@','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','Line No','N','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 17:30:22','YYYY-MM-DD HH24:MI:SS'),'D','N','N',439,11,200208)
;

-- May 5, 2016 5:30:55 PM MYT
UPDATE AD_Column SET IsUpdateable='N', FKConstraintType='N', FKConstraintName='ADStyle_ADStyleLine',Updated=TO_DATE('2016-05-05 17:30:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212745
;

-- May 5, 2016 5:30:55 PM MYT
CREATE TABLE AD_StyleLine (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_Style_ID NUMBER(10) NOT NULL, AD_StyleLine_ID NUMBER(10) NOT NULL, AD_StyleLine_UU VARCHAR2(36) NOT NULL, Created DATE DEFAULT SYSDATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, DisplayLogic VARCHAR2(2000) DEFAULT NULL , InlineStyle VARCHAR2(2000) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Line NUMBER(10) NOT NULL, Theme VARCHAR2(60) DEFAULT NULL , Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_StyleLine_Key PRIMARY KEY (AD_StyleLine_ID), CONSTRAINT AD_StyleLine_UU_idx UNIQUE (AD_StyleLine_UU))
;

-- May 5, 2016 5:30:55 PM MYT
ALTER TABLE AD_StyleLine ADD CONSTRAINT ADStyle_ADStyleLine FOREIGN KEY (AD_Style_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 5, 2016 5:35:45 PM MYT
INSERT INTO AD_Window (WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,Processing,AD_Org_ID,Name,AD_Window_ID,AD_Window_UU,IsActive,AD_Client_ID,Updated,CreatedBy,UpdatedBy,EntityType,Created) VALUES ('M','N','N','N',0,0,'N',0,'CSS Style',200086,'d4a9cc93-0129-4cd6-885b-59abc542fdd3','Y',0,TO_DATE('2016-05-05 17:35:44','YYYY-MM-DD HH24:MI:SS'),100,100,'D',TO_DATE('2016-05-05 17:35:44','YYYY-MM-DD HH24:MI:SS'))
;

-- May 5, 2016 5:37:16 PM MYT
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,AD_Tab_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,AD_Org_ID,Updated,Name,Description,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,EntityType,AD_Table_ID,TreeDisplayedOn,AD_Window_ID) VALUES ('N','N','Y',10,'N','N','N','N','N',200213,'Y','N',0,'6bab9a1b-d3d3-48ca-8fab-b1846bfe769b',0,TO_DATE('2016-05-05 17:37:15','YYYY-MM-DD HH24:MI:SS'),'CSS Style','CSS Inline Style Definitions',100,100,'Y',0,TO_DATE('2016-05-05 17:37:15','YYYY-MM-DD HH24:MI:SS'),'D',200207,'M',200086)
;

-- May 5, 2016 5:37:33 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204196,'N',22,'N','N',10,'Y','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,TO_DATE('2016-05-05 17:37:32','YYYY-MM-DD HH24:MI:SS'),'Client/Tenant for this installation.','Client','7b19f62c-cb83-440a-96d5-bdfe656a982f','Y','N',100,100,'Y','N',0,TO_DATE('2016-05-05 17:37:32','YYYY-MM-DD HH24:MI:SS'),2,212727,'D',200213)
;

-- May 5, 2016 5:37:34 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204197,'N',22,'N','N',20,'Y','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',0,TO_DATE('2016-05-05 17:37:34','YYYY-MM-DD HH24:MI:SS'),'Organizational entity within client','Organization','9dda2965-55fb-423c-94fd-5ded9c97e4b6','Y','N','Y',100,100,'Y','N',4,0,TO_DATE('2016-05-05 17:37:34','YYYY-MM-DD HH24:MI:SS'),2,212728,'D',200213)
;

-- May 5, 2016 5:37:35 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204198,'N',60,'N','N',30,'Y','N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',0,TO_DATE('2016-05-05 17:37:34','YYYY-MM-DD HH24:MI:SS'),'Alphanumeric identifier of the entity','Name','86b9c376-a048-4520-bb25-00e60287cf5b','Y','N',100,100,'Y',0,TO_DATE('2016-05-05 17:37:34','YYYY-MM-DD HH24:MI:SS'),5,212736,'D',200213)
;

-- May 5, 2016 5:37:36 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204199,'N',255,'N','N',40,'Y','N','A description is limited to 255 characters.',0,TO_DATE('2016-05-05 17:37:35','YYYY-MM-DD HH24:MI:SS'),'Optional short description of the record','Description','d77bea5f-9381-444b-8418-74b133203a3d','Y','N',100,100,'Y',0,TO_DATE('2016-05-05 17:37:35','YYYY-MM-DD HH24:MI:SS'),5,212737,'D',200213)
;

-- May 5, 2016 5:37:37 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204200,'N',22,'N','N',50,'Y','N',0,TO_DATE('2016-05-05 17:37:36','YYYY-MM-DD HH24:MI:SS'),'CSS style for field and label','Style','be3d6122-d90c-41e3-b43d-13280d4c5c56','N','N',100,100,'Y','N',0,TO_DATE('2016-05-05 17:37:36','YYYY-MM-DD HH24:MI:SS'),2,212734,'D',200213)
;

-- May 5, 2016 5:37:38 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204201,'N',36,'N','N',60,'Y','N',0,TO_DATE('2016-05-05 17:37:37','YYYY-MM-DD HH24:MI:SS'),'CSS Style for field and label','Style','84d69771-3a17-47fa-87d3-0d68a071c13e','Y','N',100,100,'Y',0,TO_DATE('2016-05-05 17:37:37','YYYY-MM-DD HH24:MI:SS'),2,212735,'D',200213)
;

-- May 5, 2016 5:37:38 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204202,'N',1,'N','N',70,'Y','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,TO_DATE('2016-05-05 17:37:38','YYYY-MM-DD HH24:MI:SS'),'The record is active in the system','Active','ba3a2ded-ccc0-4d3c-a148-26332dcffaf1','Y','N',100,100,'Y',2,0,TO_DATE('2016-05-05 17:37:38','YYYY-MM-DD HH24:MI:SS'),2,212731,'D',200213)
;

-- May 5, 2016 5:48:53 PM MYT
UPDATE AD_Field SET SeqNo=30, ColumnSpan=2,Updated=TO_DATE('2016-05-05 17:48:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204198
;

-- May 5, 2016 5:48:54 PM MYT
UPDATE AD_Field SET SeqNo=40, NumLines=2,Updated=TO_DATE('2016-05-05 17:48:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204199
;

-- May 5, 2016 5:48:54 PM MYT
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2016-05-05 17:48:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204202
;

-- May 5, 2016 5:48:54 PM MYT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_DATE('2016-05-05 17:48:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204201
;

-- May 5, 2016 5:48:54 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2016-05-05 17:48:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204200
;

-- May 5, 2016 5:49:42 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=204201
;

-- May 5, 2016 5:49:42 PM MYT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=204198
;

-- May 5, 2016 5:49:42 PM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=204199
;

-- May 5, 2016 5:49:42 PM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=204202
;

-- May 5, 2016 5:50:36 PM MYT
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,AD_Tab_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,AD_Org_ID,Updated,Name,Description,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,EntityType,AD_Table_ID,TreeDisplayedOn,AD_Window_ID) VALUES ('N','N','Y',20,'N','N','N','N','N',200214,'Y','N',1,'f8aec122-5e12-4e5b-a03b-fff56904ee27',0,TO_DATE('2016-05-05 17:50:35','YYYY-MM-DD HH24:MI:SS'),'Style Line','CSS Style Lines',100,100,'Y',0,TO_DATE('2016-05-05 17:50:35','YYYY-MM-DD HH24:MI:SS'),'D',200208,'M',200086)
;

-- May 5, 2016 5:50:46 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204203,'N',22,'N','N',10,'Y','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,TO_DATE('2016-05-05 17:50:45','YYYY-MM-DD HH24:MI:SS'),'Client/Tenant for this installation.','Client','cf88352d-4374-4359-ab1b-c1933b2e4a71','Y','N',100,100,'Y','N',0,TO_DATE('2016-05-05 17:50:45','YYYY-MM-DD HH24:MI:SS'),2,212738,'D',200214)
;

-- May 5, 2016 5:50:47 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204204,'N',22,'N','N',20,'Y','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',0,TO_DATE('2016-05-05 17:50:46','YYYY-MM-DD HH24:MI:SS'),'Organizational entity within client','Organization','faf5445c-9480-4405-a1e3-86635eb44b3b','Y','N','Y',100,100,'Y','N',4,0,TO_DATE('2016-05-05 17:50:46','YYYY-MM-DD HH24:MI:SS'),2,212739,'D',200214)
;

-- May 5, 2016 5:50:47 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204205,'N',22,'N','N',30,'Y','N',0,TO_DATE('2016-05-05 17:50:47','YYYY-MM-DD HH24:MI:SS'),'CSS style for field and label','Style','ca836a67-91c6-4de8-90e2-298f0aaf3b58','Y','N',100,100,'Y',0,TO_DATE('2016-05-05 17:50:47','YYYY-MM-DD HH24:MI:SS'),2,212745,'D',200214)
;

-- May 5, 2016 5:50:48 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204206,'N',22,'N','N',40,'Y','N',0,TO_DATE('2016-05-05 17:50:47','YYYY-MM-DD HH24:MI:SS'),'CSS Style Line','Style Line','4ca079aa-331f-44f4-bb45-6af66c97da1c','N','N',100,100,'Y','N',0,TO_DATE('2016-05-05 17:50:47','YYYY-MM-DD HH24:MI:SS'),2,212746,'D',200214)
;

-- May 5, 2016 5:50:49 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204207,'N',36,'N','N',50,'Y','N',0,TO_DATE('2016-05-05 17:50:48','YYYY-MM-DD HH24:MI:SS'),'CSS Style Line','Style Line','47c2b8e7-52b6-4d78-add1-2fb8c211c804','Y','N',100,100,'Y',0,TO_DATE('2016-05-05 17:50:48','YYYY-MM-DD HH24:MI:SS'),2,212747,'D',200214)
;

-- May 5, 2016 5:50:50 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204208,'N',2000,'N','N',60,'Y','N',0,TO_DATE('2016-05-05 17:50:49','YYYY-MM-DD HH24:MI:SS'),'CSS Inline Style','Inline Style','7696c649-df25-4938-ad91-7034a96a479c','Y','N',100,100,'Y',0,TO_DATE('2016-05-05 17:50:49','YYYY-MM-DD HH24:MI:SS'),5,212748,'D',200214)
;

-- May 5, 2016 5:50:51 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,NumLines,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204209,'N',2000,'N','N',70,'Y','N','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)',0,TO_DATE('2016-05-05 17:50:50','YYYY-MM-DD HH24:MI:SS'),'If the Field is displayed, the result determines if the field is actually displayed','Display Logic','7deca1bb-f53f-4585-ad4c-92ed64a9f73e','Y','N',100,100,'Y',0,TO_DATE('2016-05-05 17:50:50','YYYY-MM-DD HH24:MI:SS'),5,3,212749,'D',200214)
;

-- May 5, 2016 5:50:52 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204210,'N',60,'N','N',80,'Y','N',0,TO_DATE('2016-05-05 17:50:51','YYYY-MM-DD HH24:MI:SS'),'Theme name','Theme','c426c14b-cc2a-4b2b-87f4-efe4fa58add6','Y','N',100,100,'Y',0,TO_DATE('2016-05-05 17:50:51','YYYY-MM-DD HH24:MI:SS'),5,212750,'D',200214)
;

-- May 5, 2016 5:50:52 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204211,'N',22,'N','N',90,'Y','N','Indicates the unique line for a document.  It will also control the display order of the lines within a document.',0,TO_DATE('2016-05-05 17:50:52','YYYY-MM-DD HH24:MI:SS'),'Unique line for this document','Line No','b9841829-52f8-419c-97dd-9c20287b0374','Y','N',100,100,'Y',0,TO_DATE('2016-05-05 17:50:52','YYYY-MM-DD HH24:MI:SS'),2,212751,'D',200214)
;

-- May 5, 2016 5:50:53 PM MYT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (204212,'N',1,'N','N',100,'Y','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,TO_DATE('2016-05-05 17:50:52','YYYY-MM-DD HH24:MI:SS'),'The record is active in the system','Active','ca50314b-8758-4e34-9843-00535be7b0f1','Y','N',100,100,'Y',2,0,TO_DATE('2016-05-05 17:50:52','YYYY-MM-DD HH24:MI:SS'),2,212742,'D',200214)
;

-- May 5, 2016 5:52:43 PM MYT
UPDATE AD_Field SET SeqNo=40, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2016-05-05 17:52:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204211
;

-- May 5, 2016 5:52:43 PM MYT
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2016-05-05 17:52:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204208
;

-- May 5, 2016 5:52:44 PM MYT
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2016-05-05 17:52:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204209
;

-- May 5, 2016 5:52:44 PM MYT
UPDATE AD_Field SET SeqNo=70, ColumnSpan=2,Updated=TO_DATE('2016-05-05 17:52:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204210
;

-- May 5, 2016 5:52:44 PM MYT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2016-05-05 17:52:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204212
;

-- May 5, 2016 5:52:44 PM MYT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_DATE('2016-05-05 17:52:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204207
;

-- May 5, 2016 5:52:45 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2016-05-05 17:52:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204206
;

-- May 5, 2016 5:53:24 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=204207
;

-- May 5, 2016 5:53:24 PM MYT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=204205
;

-- May 5, 2016 5:53:24 PM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=204211
;

-- May 5, 2016 5:53:24 PM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=204208
;

-- May 5, 2016 5:53:24 PM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=204209
;

-- May 5, 2016 5:53:24 PM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=204210
;

-- May 5, 2016 5:53:24 PM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=204212
;

-- May 5, 2016 5:54:30 PM MYT
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,AD_Menu_UU,IsSOTrx,IsReadOnly,IsCentrallyMaintained,Name,Description,Action,IsActive,CreatedBy,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,EntityType,AD_Window_ID) VALUES (200141,'N','9e7fd038-8a70-4eb3-b893-064bc4fa6c4f','N','N','Y','CSS Style','CSS Style','W','Y',100,0,0,TO_DATE('2016-05-05 17:54:30','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2016-05-05 17:54:30','YYYY-MM-DD HH24:MI:SS'),100,'D',200086)
;

-- May 5, 2016 5:54:31 PM MYT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200141, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=116 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200141)
;

-- May 5, 2016 5:54:31 PM MYT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200141, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200141)
;

-- May 5, 2016 5:55:32 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- May 5, 2016 5:55:32 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- May 5, 2016 5:55:32 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- May 5, 2016 5:55:32 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- May 5, 2016 5:55:32 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- May 5, 2016 5:55:32 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- May 5, 2016 5:55:32 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000087
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000081
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000050
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000156
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000144
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000151
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000155
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000159
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000188
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000167
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000175
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000171
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=25, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000163
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=26, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000162
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=27, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000174
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=28, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000177
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=29, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000170
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=30, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000165
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53203
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=586
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=138
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=139
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200065
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200063
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=249
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200072
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=27, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- May 5, 2016 5:55:33 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=28, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- May 5, 2016 5:56:42 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203011,'AD_LabelStyle_ID',TO_DATE('2016-05-05 17:56:31','YYYY-MM-DD HH24:MI:SS'),'Label Style','Label CSS Style','Label Style','6d8e94d8-8764-4282-8403-b45e3a3ae60f','Y',TO_DATE('2016-05-05 17:56:31','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- May 5, 2016 5:57:21 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203012,'AD_FieldStyle_ID',TO_DATE('2016-05-05 17:57:20','YYYY-MM-DD HH24:MI:SS'),'Field Style','Field CSS Style ','Field Style','24c92b13-3a10-4d0d-984e-c3bee1816214','Y',TO_DATE('2016-05-05 17:57:20','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- May 5, 2016 5:59:02 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,AD_Org_ID,Description,ValidationType,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType) VALUES (200121,'AD_Style','b305070d-fe5b-4f1f-be86-e247b03b5723','N',0,'CSS Style','T',TO_DATE('2016-05-05 17:59:01','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_DATE('2016-05-05 17:59:01','YYYY-MM-DD HH24:MI:SS'),'D')
;

-- May 5, 2016 5:59:43 PM MYT
INSERT INTO AD_Ref_Table (IsValueDisplayed,AD_Client_ID,AD_Org_ID,Created,AD_Ref_Table_UU,AD_Table_ID,Updated,IsActive,CreatedBy,UpdatedBy,EntityType,AD_Display,AD_Key,AD_Reference_ID) VALUES ('N',0,0,TO_DATE('2016-05-05 17:59:43','YYYY-MM-DD HH24:MI:SS'),'be9c63c0-8404-4651-ab7f-7e666bd0b869',200207,TO_DATE('2016-05-05 17:59:43','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,'D',212736,212734,200121)
;

-- May 5, 2016 6:00:08 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212752,0,'N',0,'N','N','N',0,'N',10,'N','N','N','Y','369780f4-db2e-4754-ae62-f9e9709deea8',TO_DATE('2016-05-05 18:00:07','YYYY-MM-DD HH24:MI:SS'),'Y','AD_LabelStyle_ID','Label CSS Style','Label Style','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 18:00:07','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203011,18,200121,107)
;

-- May 5, 2016 6:00:14 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADLabelStyle_ADField',Updated=TO_DATE('2016-05-05 18:00:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212752
;

-- May 5, 2016 6:00:14 PM MYT
ALTER TABLE AD_Field ADD AD_LabelStyle_ID NUMBER(10) DEFAULT NULL 
;

-- May 5, 2016 6:00:15 PM MYT
ALTER TABLE AD_Field ADD CONSTRAINT ADLabelStyle_ADField FOREIGN KEY (AD_LabelStyle_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 5, 2016 6:01:10 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212753,0,'N',0,'N','N','N',0,'N',10,'N','N','N','Y','19bff665-ff23-4833-a825-073718edd435',TO_DATE('2016-05-05 18:01:04','YYYY-MM-DD HH24:MI:SS'),'Y','AD_FieldStyle_ID','Field CSS Style ','Field Style','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 18:01:04','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203012,18,200121,107)
;

-- May 5, 2016 6:01:17 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADFieldStyle_ADField',Updated=TO_DATE('2016-05-05 18:01:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212753
;

-- May 5, 2016 6:01:17 PM MYT
ALTER TABLE AD_Field ADD AD_FieldStyle_ID NUMBER(10) DEFAULT NULL 
;

-- May 5, 2016 6:01:18 PM MYT
ALTER TABLE AD_Field ADD CONSTRAINT ADFieldStyle_ADField FOREIGN KEY (AD_FieldStyle_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 5, 2016 6:02:29 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212754,0,'N',0,'N','N','N',0,'N',10,'N','N','N','Y','aa21533a-7a10-4e67-9b5d-97531d242cb3',TO_DATE('2016-05-05 18:02:23','YYYY-MM-DD HH24:MI:SS'),'Y','AD_LabelStyle_ID','Label CSS Style','Label Style','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 18:02:23','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203011,18,200121,464)
;

-- May 5, 2016 6:02:35 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADLabelStyle_ADUserDefField',Updated=TO_DATE('2016-05-05 18:02:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212754
;

-- May 5, 2016 6:02:35 PM MYT
ALTER TABLE AD_UserDef_Field ADD AD_LabelStyle_ID NUMBER(10) DEFAULT NULL 
;

-- May 5, 2016 6:02:36 PM MYT
ALTER TABLE AD_UserDef_Field ADD CONSTRAINT ADLabelStyle_ADUserDefField FOREIGN KEY (AD_LabelStyle_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 5, 2016 6:04:46 PM MYT
ALTER TABLE AD_UserDef_Field MODIFY AD_LabelStyle_ID NUMBER(10) DEFAULT NULL 
;

-- May 5, 2016 6:05:20 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212755,0,'N',0,'N','N','N',0,'N',10,'N','N','N','Y','a3699bf0-2187-457c-857d-e8c28bb91cb4',TO_DATE('2016-05-05 18:05:18','YYYY-MM-DD HH24:MI:SS'),'Y','AD_FieldStyle_ID','Field CSS Style ','Field Style','Y','Y',100,100,'N','N',0,0,TO_DATE('2016-05-05 18:05:18','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203012,18,200121,464)
;

-- May 5, 2016 6:05:32 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADFieldStyle_ADUserDefField',Updated=TO_DATE('2016-05-05 18:05:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212755
;

-- May 5, 2016 6:05:32 PM MYT
ALTER TABLE AD_UserDef_Field ADD AD_FieldStyle_ID NUMBER(10) DEFAULT NULL 
;

-- May 5, 2016 6:05:32 PM MYT
ALTER TABLE AD_UserDef_Field ADD CONSTRAINT ADFieldStyle_ADUserDefField FOREIGN KEY (AD_FieldStyle_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 5, 2016 6:07:17 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,204213,'N',0,'N','N',410,'Y','N',0,TO_DATE('2016-05-05 18:07:16','YYYY-MM-DD HH24:MI:SS'),'Label CSS Style','Label Style','d9230bcf-4626-463d-a352-0b599ddae2ea','Y','N',100,100,'Y','Y',400,1,'N',0,TO_DATE('2016-05-05 18:07:16','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',212752,'D',107)
;

-- May 5, 2016 6:07:42 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,204214,'N',0,'N','N',420,'Y','N',0,TO_DATE('2016-05-05 18:07:41','YYYY-MM-DD HH24:MI:SS'),'Field CSS Style ','Field Style','10a0d3f9-1f8c-4a23-9279-105086672ba8','Y','N',100,100,'Y','Y',410,4,'N',0,TO_DATE('2016-05-05 18:07:41','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',212753,'D',107)
;

-- May 5, 2016 6:09:24 PM MYT
UPDATE AD_Field SET SeqNo=250,Updated=TO_DATE('2016-05-05 18:09:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=141
;

-- May 5, 2016 6:09:25 PM MYT
UPDATE AD_Field SET SeqNo=260,Updated=TO_DATE('2016-05-05 18:09:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- May 5, 2016 6:09:25 PM MYT
UPDATE AD_Field SET SeqNo=270,Updated=TO_DATE('2016-05-05 18:09:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- May 5, 2016 6:09:25 PM MYT
UPDATE AD_Field SET SeqNo=280, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2016-05-05 18:09:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- May 5, 2016 6:09:25 PM MYT
UPDATE AD_Field SET SeqNo=290, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2016-05-05 18:09:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204213
;

-- May 5, 2016 6:09:26 PM MYT
UPDATE AD_Field SET SeqNo=300, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2016-05-05 18:09:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204214
;

-- May 5, 2016 6:09:26 PM MYT
UPDATE AD_Field SET SeqNo=310,Updated=TO_DATE('2016-05-05 18:09:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- May 5, 2016 6:09:26 PM MYT
UPDATE AD_Field SET SeqNo=320,Updated=TO_DATE('2016-05-05 18:09:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- May 5, 2016 6:09:26 PM MYT
UPDATE AD_Field SET SeqNo=330,Updated=TO_DATE('2016-05-05 18:09:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- May 5, 2016 6:09:26 PM MYT
UPDATE AD_Field SET SeqNo=340,Updated=TO_DATE('2016-05-05 18:09:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- May 5, 2016 6:09:27 PM MYT
UPDATE AD_Field SET SeqNo=350,Updated=TO_DATE('2016-05-05 18:09:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- May 5, 2016 6:09:27 PM MYT
UPDATE AD_Field SET SeqNo=360,Updated=TO_DATE('2016-05-05 18:09:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- May 5, 2016 6:09:27 PM MYT
UPDATE AD_Field SET SeqNo=370,Updated=TO_DATE('2016-05-05 18:09:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- May 5, 2016 6:09:27 PM MYT
UPDATE AD_Field SET SeqNo=380,Updated=TO_DATE('2016-05-05 18:09:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- May 5, 2016 6:09:27 PM MYT
UPDATE AD_Field SET SeqNo=390,Updated=TO_DATE('2016-05-05 18:09:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- May 5, 2016 6:09:28 PM MYT
UPDATE AD_Field SET SeqNo=400,Updated=TO_DATE('2016-05-05 18:09:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- May 5, 2016 6:09:28 PM MYT
UPDATE AD_Field SET SeqNo=410,Updated=TO_DATE('2016-05-05 18:09:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- May 5, 2016 6:09:28 PM MYT
UPDATE AD_Field SET SeqNo=420,Updated=TO_DATE('2016-05-05 18:09:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- May 5, 2016 6:09:28 PM MYT
UPDATE AD_Field SET SeqNo=430,Updated=TO_DATE('2016-05-05 18:09:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

-- May 5, 2016 6:10:56 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,204215,'N',0,'N','N',280,'Y','N',0,TO_DATE('2016-05-05 18:10:56','YYYY-MM-DD HH24:MI:SS'),'Label CSS Style','Label Style','c8cb7dd4-a36d-42cc-ae7f-d0e737ff4a5d','Y','N',100,100,'Y','Y',260,1,'N',0,TO_DATE('2016-05-05 18:10:56','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',212754,'D',395)
;

-- May 5, 2016 6:11:22 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,204216,'N',0,'N','N',290,'Y','N',0,TO_DATE('2016-05-05 18:11:21','YYYY-MM-DD HH24:MI:SS'),'Field CSS Style ','Field Style','b36dc9cf-96bd-418f-a296-270541b7897c','Y','N',100,100,'Y','Y',270,4,'N',0,TO_DATE('2016-05-05 18:11:21','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',212755,'D',395)
;

-- May 5, 2016 6:12:30 PM MYT
UPDATE AD_Field SET SeqNo=180, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2016-05-05 18:12:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204215
;

-- May 5, 2016 6:12:30 PM MYT
UPDATE AD_Field SET SeqNo=190, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2016-05-05 18:12:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204216
;

-- May 5, 2016 6:12:30 PM MYT
UPDATE AD_Field SET SeqNo=200,Updated=TO_DATE('2016-05-05 18:12:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200858
;

-- May 5, 2016 6:12:31 PM MYT
UPDATE AD_Field SET SeqNo=210,Updated=TO_DATE('2016-05-05 18:12:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200856
;

-- May 5, 2016 6:12:31 PM MYT
UPDATE AD_Field SET SeqNo=220,Updated=TO_DATE('2016-05-05 18:12:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200855
;

-- May 5, 2016 6:12:31 PM MYT
UPDATE AD_Field SET SeqNo=230,Updated=TO_DATE('2016-05-05 18:12:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5054
;

-- May 5, 2016 6:12:31 PM MYT
UPDATE AD_Field SET SeqNo=240,Updated=TO_DATE('2016-05-05 18:12:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200849
;

-- May 5, 2016 6:12:31 PM MYT
UPDATE AD_Field SET SeqNo=250,Updated=TO_DATE('2016-05-05 18:12:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200851
;

-- May 5, 2016 6:12:32 PM MYT
UPDATE AD_Field SET SeqNo=260,Updated=TO_DATE('2016-05-05 18:12:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200852
;

-- May 5, 2016 6:12:32 PM MYT
UPDATE AD_Field SET SeqNo=270,Updated=TO_DATE('2016-05-05 18:12:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200854
;

-- May 5, 2016 6:12:32 PM MYT
UPDATE AD_Field SET SeqNo=280,Updated=TO_DATE('2016-05-05 18:12:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5051
;

-- May 5, 2016 6:12:32 PM MYT
UPDATE AD_Field SET SeqNo=290,Updated=TO_DATE('2016-05-05 18:12:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
;

CREATE OR REPLACE VIEW ad_field_v AS 
 SELECT t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, f.name, f.description, f.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, c.vformat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid, f.seqnogrid, c.seqnoselection, f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, c.formatpattern, f.isadvancedfield, f.isdefaultfocus, c.ad_chart_id, f.ad_labelstyle_id, f.ad_fieldstyle_id
   FROM ad_field f
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

CREATE OR REPLACE VIEW ad_field_vt AS 
 SELECT trl.ad_language, t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, trl.name, trl.description, trl.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, c.vformat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fgt.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid, f.seqnogrid, c.seqnoselection, f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, c.formatpattern, f.isadvancedfield, f.isdefaultfocus, c.ad_chart_id, f.ad_labelstyle_id, f.ad_fieldstyle_id
   FROM ad_field f
   JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language = fgt.ad_language
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

SELECT register_migration_script('201605061800_Ticket_1006003.sql') FROM dual
;

