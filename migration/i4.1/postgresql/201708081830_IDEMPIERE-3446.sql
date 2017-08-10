-- IDEMPIERE-3446 Define the workflow approver dynamically
-- Aug 8, 2017 6:16:04 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200376,'Manual','Manual List',304,'M',0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:03','YYYY-MM-DD HH24:MI:SS'),100,'D','a9c99476-070e-4377-960d-19dbe7dff024')
;

-- Aug 8, 2017 6:16:04 PM BRT
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200226,'Workflow Activity Approver','Approvers of the Workflow Process Activity',298,'AD_WF_ActivityApprover',145,'7',0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','D','N','L','Y','e6e1ed38-4935-44cd-9740-b5c631062229','N')
;

-- Aug 8, 2017 6:16:05 PM BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_WF_ActivityApprover',1000000,'N','N','Table AD_WF_ActivityApprover','Y','Y',0,0,TO_TIMESTAMP('2017-08-08 18:16:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:04','YYYY-MM-DD HH24:MI:SS'),100,200291,'Y',1000000,1,200000,'c6b5803d-773c-465c-8541-18c5e659bf44')
;

-- Aug 8, 2017 6:16:06 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203132,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:05','YYYY-MM-DD HH24:MI:SS'),100,'AD_WF_ActivityApprover_ID','Workflow Activity Approver','Workflow Activity Approver','D','559e0c04-8a72-42bf-a85f-37bb6cb2bbbd')
;

-- Aug 8, 2017 6:16:07 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213223,1,'Workflow Activity Approver',200226,'AD_WF_ActivityApprover_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:07','YYYY-MM-DD HH24:MI:SS'),100,203132,'N','N','D','Y','N','N','Y','fee3c48f-1c60-4298-aac8-8bf8f028b13d','N','N','N','N')
;

-- Aug 8, 2017 6:16:08 PM BRT
CREATE TABLE AD_WF_ActivityApprover (AD_WF_ActivityApprover_ID NUMERIC(10) NOT NULL, CONSTRAINT AD_WF_ActivityApprover_Key PRIMARY KEY (AD_WF_ActivityApprover_ID))
;

-- Aug 8, 2017 6:16:09 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213224,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200226,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:08','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','78b69227-4782-40e4-ba68-2161894ec669','N','N','N','D')
;

-- Aug 8, 2017 6:16:09 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD COLUMN AD_Client_ID NUMERIC(10) NOT NULL
;

-- Aug 8, 2017 6:16:09 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213225,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200226,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:09','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','3f24f5a5-6841-4774-867b-58500aff75c8','N','N','N','D')
;

-- Aug 8, 2017 6:16:09 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD COLUMN AD_Org_ID NUMERIC(10) NOT NULL
;

-- Aug 8, 2017 6:16:10 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213226,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200226,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:10','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','d47875c9-fbd3-49f9-a593-103918b68a51','N','N','N','N')
;

-- Aug 8, 2017 6:16:11 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD COLUMN Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Aug 8, 2017 6:16:11 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213227,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200226,'CreatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:11','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','4c14993e-fa5c-4680-be68-816680dbbd92','N','N','N','D')
;

-- Aug 8, 2017 6:16:11 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD COLUMN CreatedBy NUMERIC(10) NOT NULL
;

-- Aug 8, 2017 6:16:12 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203133,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:12','YYYY-MM-DD HH24:MI:SS'),100,'AD_WF_ActivityApprover_UU','AD_WF_ActivityApprover_UU','AD_WF_ActivityApprover_UU','D','3d203220-d98b-4e35-bfb3-981bb8a31aee')
;

-- Aug 8, 2017 6:16:13 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213228,1.00,'AD_WF_ActivityApprover_UU',200226,'AD_WF_ActivityApprover_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:12','YYYY-MM-DD HH24:MI:SS'),100,203133,'Y','N','D','Y','N','N','Y','ad670aa0-2b6a-484e-9696-7c922e6c4d62','N','N','N','N')
;

-- Aug 8, 2017 6:16:13 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD COLUMN AD_WF_ActivityApprover_UU VARCHAR(36) DEFAULT NULL 
;

-- Aug 8, 2017 6:16:13 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD CONSTRAINT AD_WF_ActivityApprover_UU_idx UNIQUE (AD_WF_ActivityApprover_UU)
;

-- Aug 8, 2017 6:16:14 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213229,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200226,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:13','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','44103c1a-bb91-43d2-9a84-f129f784fc06','N','N','N','N')
;

-- Aug 8, 2017 6:16:14 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD COLUMN IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Aug 8, 2017 6:16:15 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213230,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200226,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:14','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','c14b694f-2fd6-45cb-bf36-7c2911955e59','N','N','N','N')
;

-- Aug 8, 2017 6:16:15 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD COLUMN Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Aug 8, 2017 6:16:16 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213231,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200226,'UpdatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:15','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','26992d33-c633-4372-80de-7b584316625e','N','N','N','D')
;

-- Aug 8, 2017 6:16:16 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD COLUMN UpdatedBy NUMERIC(10) NOT NULL
;

-- Aug 8, 2017 6:16:17 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (213232,0,'Workflow Activity','Workflow Activity','The Workflow Activity is the actual Workflow Node in a Workflow Process instance',200226,'AD_WF_Activity_ID',22,'N','Y','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:16','YYYY-MM-DD HH24:MI:SS'),100,2307,'N','N','D','Y','N','N','Y','5382008f-687c-4828-86cb-16226e32432c','Y',0,'N','N','ADWFActivity_ADWFActivityAppro','C')
;

-- Aug 8, 2017 6:16:17 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD COLUMN AD_WF_Activity_ID NUMERIC(10) NOT NULL
;

-- Aug 8, 2017 6:16:18 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (213233,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200226,164,'AD_User_ID',22,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:17','YYYY-MM-DD HH24:MI:SS'),100,138,'Y','N','D','Y','N','N','Y','02bffd80-4df3-46fc-a426-1bc5b8fca3a9','Y',0,'N','N','ADUser_ADWFActivityApprover','N')
;

-- Aug 8, 2017 6:16:18 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD COLUMN AD_User_ID NUMERIC(10) NOT NULL
;

-- Aug 8, 2017 6:16:19 PM BRT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201058,'91502b94-7f41-4bc5-b7c7-08417ccf3ed1',TO_TIMESTAMP('2017-08-08 18:16:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_ActivityApprover01',TO_TIMESTAMP('2017-08-08 18:16:18','YYYY-MM-DD HH24:MI:SS'),100,200226,'N','Y','N','N','N')
;

-- Aug 8, 2017 6:16:19 PM BRT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201345,'27b2b5cb-3191-4fb0-8ea1-36b843084fee',TO_TIMESTAMP('2017-08-08 18:16:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-08-08 18:16:19','YYYY-MM-DD HH24:MI:SS'),100,213232,201058,10)
;

-- Aug 8, 2017 6:16:20 PM BRT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201346,'bb95cfc3-7eaf-4b60-98bf-8ae309ce55a2',TO_TIMESTAMP('2017-08-08 18:16:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-08-08 18:16:20','YYYY-MM-DD HH24:MI:SS'),100,213233,201058,20)
;

-- Aug 8, 2017 6:16:20 PM BRT
CREATE UNIQUE INDEX AD_WF_ActivityApprover01 ON AD_WF_ActivityApprover (AD_WF_Activity_ID,AD_User_ID)
;

-- Aug 8, 2017 6:16:21 PM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200230,'Approver',298,20,'Y',200226,0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','Y','N','4c965421-0c87-4703-b433-243991bd1628','B')
;

-- Aug 8, 2017 6:16:23 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205207,'AD_WF_ActivityApprover_UU',200230,213228,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','04c2a8fc-dc5f-41e1-aa27-81a141d4c3f2','N',1,2,1,'N','N','N')
;

-- Aug 8, 2017 6:16:24 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205208,'Workflow Activity Approver',200230,213223,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f60eb7d8-0f3c-4ec7-bae6-51ae45e815fa','N',1,2,1,'N','N','N')
;

-- Aug 8, 2017 6:16:25 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205209,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200230,213224,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:24','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','92ce5bb5-6a37-4091-b310-de5dcd9ce603','N',10,1,2,1,'N','N','N')
;

-- Aug 8, 2017 6:16:26 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205210,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200230,213225,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:25','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','50c4e884-caf0-4138-8bb3-280046ac0dc6','Y','N',20,4,2,1,'N','N','N')
;

-- Aug 8, 2017 6:16:27 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205211,'Workflow Activity','Workflow Activity','The Workflow Activity is the actual Workflow Node in a Workflow Process instance',200230,213232,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','448533e5-3dde-4782-a77b-f0c95ede180f','Y',30,1,2,1,'N','N','N')
;

-- Aug 8, 2017 6:16:27 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205212,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200230,213233,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cc73baef-8a0e-4dcd-b544-2ee9f1c419f3','Y',40,4,2,1,'N','N','N')
;

-- Aug 8, 2017 6:16:28 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205213,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200230,213229,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-08 18:16:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-08 18:16:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','194ceea8-bf9f-419b-b96d-6b7f16197e9c','Y',50,2,2,1,'N','N','N')
;

-- Aug 8, 2017 6:16:29 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD CONSTRAINT ADWFActivity_ADWFActivityAppro FOREIGN KEY (AD_WF_Activity_ID) REFERENCES ad_wf_activity(ad_wf_activity_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2017 6:16:29 PM BRT
ALTER TABLE AD_WF_ActivityApprover ADD CONSTRAINT ADUser_ADWFActivityApprover FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2017 6:39:27 PM BRT
UPDATE PA_DocumentStatus SET WhereClause='AD_WF_Activity.Processed=''N'' AND AD_WF_Activity.WFState=''OS'' AND (
/* Owner of Activity */
AD_WF_Activity.AD_User_ID=@#AD_User_ID@
/* Invoker (if no invoker = all) */
OR EXISTS (SELECT * FROM AD_WF_Responsible r WHERE AD_WF_Activity.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID
AND r.ResponsibleType=''H'' AND COALESCE(r.AD_User_ID,0)=0 AND COALESCE(r.AD_Role_ID,0)=0 AND (AD_WF_Activity.AD_User_ID=@#AD_User_ID@ OR AD_WF_Activity.AD_User_ID IS NULL))
/* Responsible User */
OR EXISTS (SELECT * FROM AD_WF_Responsible r WHERE AD_WF_Activity.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID
AND r.ResponsibleType=''H'' AND r.AD_User_ID=@#AD_User_ID@)
/* Responsible Role */
OR EXISTS (SELECT * FROM AD_WF_Responsible r INNER JOIN AD_User_Roles ur ON (r.AD_Role_ID=ur.AD_Role_ID)
WHERE AD_WF_Activity.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID AND r.ResponsibleType=''R'' AND ur.AD_User_ID=@#AD_User_ID@ AND ur.isActive=''Y'')
/* Manual Responsible */
OR EXISTS (SELECT * FROM AD_WF_ActivityApprover r WHERE AD_WF_Activity.AD_WF_Activity_ID=r.AD_WF_Activity_ID AND r.AD_User_ID=@#AD_User_ID@ AND r.isActive=''Y'')
) AND AD_WF_Activity.AD_Client_ID=@#AD_Client_ID@',Updated=TO_TIMESTAMP('2017-08-08 18:39:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200004
;

-- Aug 10, 2017 10:42:59 AM BRT
UPDATE AD_Tab SET SeqNo=40, AD_Column_ID=NULL, AD_Process_ID=NULL, AD_Image_ID=NULL, AD_ColumnSortYesNo_ID=NULL, AD_ColumnSortOrder_ID=NULL, Included_Tab_ID=NULL, Parent_Column_ID=NULL, AD_CtxHelp_ID=NULL,Updated=TO_TIMESTAMP('2017-08-10 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=581
;

-- Aug 10, 2017 10:42:59 AM BRT
UPDATE AD_Tab SET SeqNo=50, AD_Process_ID=NULL, AD_Image_ID=NULL, AD_ColumnSortYesNo_ID=NULL, AD_ColumnSortOrder_ID=NULL, Included_Tab_ID=NULL, Parent_Column_ID=NULL, AD_CtxHelp_ID=NULL,Updated=TO_TIMESTAMP('2017-08-10 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=582
;

-- Aug 10, 2017 10:43:00 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,DisplayLogic,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200231,'Approver',297,30,'Y',200226,0,0,'Y',TO_TIMESTAMP('2017-08-10 10:42:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-10 10:42:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','N','N',2,'N','D','1=1','N','N','805402e4-3226-4e52-9926-0217c1af2c4c','B')
;

-- Aug 10, 2017 10:43:01 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205214,'AD_WF_ActivityApprover_UU',200231,213228,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-10 10:43:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-10 10:43:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f37c320b-b7cb-46f3-a5f3-d66d4e26a8bd','N',1,2,1,'N','N','N')
;

-- Aug 10, 2017 10:43:02 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205215,'Workflow Activity Approver',200231,213223,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-10 10:43:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-10 10:43:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eca0834e-a6b5-4d88-a80c-7c4115717154','N',1,2,1,'N','N','N')
;

-- Aug 10, 2017 10:43:03 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205216,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200231,213224,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-10 10:43:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-10 10:43:02','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','7a92cab3-567a-4f67-b67e-48fcf561e8f5','Y',10,1,2,1,'N','N','N')
;

-- Aug 10, 2017 10:43:03 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205217,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200231,213225,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-10 10:43:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-10 10:43:03','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','f34baace-c472-475e-999c-623ae4449608','Y','Y',20,4,2,1,'N','N','N')
;

-- Aug 10, 2017 10:43:04 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205218,'Workflow Activity','Workflow Activity','The Workflow Activity is the actual Workflow Node in a Workflow Process instance',200231,213232,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-10 10:43:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-10 10:43:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0e4a2b1a-03f4-4af2-8cea-1497f31d1d0f','Y',30,1,2,1,'N','N','N')
;

-- Aug 10, 2017 10:43:04 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205219,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200231,213233,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-10 10:43:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-10 10:43:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','16f0f237-049a-4ccd-a146-97f1909d986f','Y',40,4,2,1,'N','N','N')
;

-- Aug 10, 2017 10:43:05 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205220,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200231,213229,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-08-10 10:43:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-08-10 10:43:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b62672fe-d27a-4ba7-a048-b344d74d6404','Y',50,2,2,1,'N','N','N')
;

-- Aug 10, 2017 10:43:05 AM BRT
UPDATE AD_Tab SET SeqNo=60, AD_Column_ID=NULL, AD_Process_ID=NULL, AD_Image_ID=NULL, AD_ColumnSortYesNo_ID=NULL, AD_ColumnSortOrder_ID=NULL, Included_Tab_ID=NULL, Parent_Column_ID=NULL, AD_CtxHelp_ID=NULL,Updated=TO_TIMESTAMP('2017-08-10 10:43:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=580
;

SELECT register_migration_script('201708081830_IDEMPIERE-3446.sql') FROM dual
;
