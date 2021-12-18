SET SQLBLANKLINES ON
SET DEFINE OFF

-- Adding Access tab on Document Status (Activity)
-- Jun 28, 2021, 10:03:55 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200278,'Document Status Access','PA_DocumentStatusAccess',0,'7',0,0,'Y',TO_DATE('2021-06-28 22:03:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:03:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','c77c16a1-b2fd-492d-ac1d-3afcce935568','N','N','N')
;

-- Jun 28, 2021, 10:03:56 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('PA_DocumentStatusAccess',1000000,'N','N','Table PA_DocumentStatusAccess','Y','Y',0,0,TO_DATE('2021-06-28 22:03:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:03:55','YYYY-MM-DD HH24:MI:SS'),100,200347,'Y',1000000,1,200000,'2acedd5c-5629-4413-80bf-d8771566cac7')
;

-- Jun 28, 2021, 10:03:56 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203519,0,0,'Y',TO_DATE('2021-06-28 22:03:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:03:56','YYYY-MM-DD HH24:MI:SS'),100,'PA_DocumentStatusAccess_ID','Document Status Access','Document Status Access','D','15432575-63eb-44f7-a095-426f28718de9')
;

-- Jun 28, 2021, 10:03:57 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214521,0.0,'Document Status Access',200278,'PA_DocumentStatusAccess_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_DATE('2021-06-28 22:03:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:03:56','YYYY-MM-DD HH24:MI:SS'),100,203519,'N','N','D','Y','N','N','Y','3aa7cda0-c0ab-416a-a9bd-c838a8435d03','N','N','N','N','N')
;

-- Jun 28, 2021, 10:03:57 PM IST
CREATE TABLE PA_DocumentStatusAccess (PA_DocumentStatusAccess_ID NUMBER(10) NOT NULL, CONSTRAINT PA_DocumentStatusAccess_Key PRIMARY KEY (PA_DocumentStatusAccess_ID))
;

-- Jun 28, 2021, 10:03:58 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214522,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200278,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2021-06-28 22:03:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:03:57','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','90cd7685-034c-4ddf-b604-e5987d398d4c','N','N','N','D','N')
;

-- Jun 28, 2021, 10:03:58 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Jun 28, 2021, 10:03:59 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214523,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200278,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N','N',30,0,0,'Y',TO_DATE('2021-06-28 22:03:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:03:58','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','08b018c5-8f84-4ebb-acd9-abe5d8101066','N','N','N','D','N')
;

-- Jun 28, 2021, 10:03:59 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Jun 28, 2021, 10:04:00 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214524,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200278,'Created','SYSDATE',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2021-06-28 22:03:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:03:59','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','2e96760d-6841-486d-b9c1-615c720e183e','N','N','N','N','N')
;

-- Jun 28, 2021, 10:04:00 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- Jun 28, 2021, 10:04:00 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214525,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200278,'CreatedBy',22,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2021-06-28 22:04:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:00','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','2b89ef3e-af6a-465a-b23d-b2c4001c1dfb','N','N','N','D','N')
;

-- Jun 28, 2021, 10:04:00 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD CreatedBy NUMBER(10) NOT NULL
;

-- Jun 28, 2021, 10:04:01 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214526,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200278,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_DATE('2021-06-28 22:04:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:00','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','66d964d7-ca07-42f1-8378-38c16ba15613','N','N','N','N','N')
;

-- Jun 28, 2021, 10:04:01 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jun 28, 2021, 10:04:02 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214527,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200278,'Updated','SYSDATE',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2021-06-28 22:04:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:01','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','162c1c8f-6db6-4a55-afe5-a6096159eb0b','N','N','N','N','N')
;

-- Jun 28, 2021, 10:04:02 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- Jun 28, 2021, 10:04:02 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214528,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200278,'UpdatedBy',22,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2021-06-28 22:04:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:02','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','71859f0d-7527-490e-801b-c4842cf87691','N','N','N','D','N')
;

-- Jun 28, 2021, 10:04:02 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Jun 28, 2021, 10:04:03 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203520,0,0,'Y',TO_DATE('2021-06-28 22:04:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:03','YYYY-MM-DD HH24:MI:SS'),100,'PA_DocumentStatusAccess_UU','PA_DocumentStatusAccess_UU','PA_DocumentStatusAccess_UU','D','29a600bf-6a44-49b6-ab05-a8d3b953b686')
;

-- Jun 28, 2021, 10:04:04 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214529,1.00,'PA_DocumentStatusAccess_UU',200278,'PA_DocumentStatusAccess_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2021-06-28 22:04:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:03','YYYY-MM-DD HH24:MI:SS'),100,203520,'Y','N','D','Y','N','N','Y','776c05d3-8716-4a17-9f7e-b60f3090d7bd','N','N','N','N','N')
;

-- Jun 28, 2021, 10:04:04 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD PA_DocumentStatusAccess_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Jun 28, 2021, 10:04:04 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD CONSTRAINT PA_DocumentStatusAccess_UU_idx UNIQUE (PA_DocumentStatusAccess_UU)
;

-- Jun 28, 2021, 10:04:05 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214530,0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200278,'AD_Role_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-06-28 22:04:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:04','YYYY-MM-DD HH24:MI:SS'),100,123,'Y','N','D','Y','N','N','Y','b903f587-a2ca-4b78-93d1-7827fc001662','Y',0,'N','N','ADRole_PADocumentStatusAccess','C','N')
;

-- Jun 28, 2021, 10:04:05 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD AD_Role_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 28, 2021, 10:04:05 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214531,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200278,'AD_User_ID',10,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_DATE('2021-06-28 22:04:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:05','YYYY-MM-DD HH24:MI:SS'),100,138,'Y','N','D','Y','N','N','Y','4cf1e3b0-8a54-4d92-82d8-1459b163862e','Y',0,'N','N','ADUser_PADocumentStatusAccess','N','N')
;

-- Jun 28, 2021, 10:04:05 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD AD_User_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 28, 2021, 10:04:06 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214532,0,'Document Status',200278,'PA_DocumentStatus_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-06-28 22:04:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:05','YYYY-MM-DD HH24:MI:SS'),100,203069,'N','N','D','Y','N','N','Y','86869fbf-ad42-408c-991a-ccb1db786a40','Y',0,'N','N','PADocumentStatus_PADocStatAccs','N','N')
;

-- Jun 28, 2021, 10:04:06 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD PA_DocumentStatus_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 28, 2021, 10:04:06 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201088,'6ca2a538-7e1f-4ad9-ac6b-12bcbedc82f9',TO_DATE('2021-06-28 22:04:06','YYYY-MM-DD HH24:MI:SS'),100,'Unique constraint on document status, User id and Role id','D','Y','DocStats_Role_User_Uniq_Idx',TO_DATE('2021-06-28 22:04:06','YYYY-MM-DD HH24:MI:SS'),100,200278,'N','Y','N','N','N')
;

-- Jun 28, 2021, 10:04:06 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201425,'9636df4f-654c-4172-a4ce-f3624d7b1a92',TO_DATE('2021-06-28 22:04:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-28 22:04:06','YYYY-MM-DD HH24:MI:SS'),100,214532,201088,0)
;

-- Jun 28, 2021, 10:04:06 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201426,'85280741-04c9-4b91-8ba9-fae0aacb240c',TO_DATE('2021-06-28 22:04:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-28 22:04:06','YYYY-MM-DD HH24:MI:SS'),100,201088,'COALESCE(AD_Role_ID,0)',0)
;

-- Jun 28, 2021, 10:04:06 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201427,'538c291c-b909-45fd-9224-e2c83db32681',TO_DATE('2021-06-28 22:04:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-06-28 22:04:06','YYYY-MM-DD HH24:MI:SS'),100,201088,'COALESCE(Ad_User_ID,0)',0)
;

-- Jun 28, 2021, 10:04:07 PM IST
CREATE UNIQUE INDEX DocStats_Role_User_Uniq_Idx ON PA_DocumentStatusAccess (PA_DocumentStatus_ID,COALESCE(AD_Role_ID,0),COALESCE(Ad_User_ID,0))
;

-- Jun 28, 2021, 10:04:07 PM IST
UPDATE AD_Tab SET SeqNo=30, AD_Column_ID=NULL, AD_Process_ID=NULL, AD_Image_ID=NULL, AD_ColumnSortYesNo_ID=NULL, AD_ColumnSortOrder_ID=NULL, Included_Tab_ID=NULL, Parent_Column_ID=NULL, AD_CtxHelp_ID=NULL,Updated=TO_DATE('2021-06-28 22:04:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200223
;

-- Jun 28, 2021, 10:04:07 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200295,'Document Status Access',200090,20,'Y',200278,0,0,'Y',TO_DATE('2021-06-28 22:04:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:07','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',214532,'N','N',1,'N','D','Y','Y','38656724-adc7-4b47-8269-ed9073707c20','B','N','Y',0)
;

-- Jun 28, 2021, 10:04:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206695,'Document Status Access',200295,214521,'N',22,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ad1a292e-022f-432c-a4f1-d6f649ca9679','N',1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:09 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206696,'PA_DocumentStatusAccess_UU',200295,214529,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ab1bf4cc-c5e8-4ade-bf9f-0f7a8459c8ba','N',1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206697,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200295,214522,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ec539de7-6203-4b1c-abac-e6d946ef2642','Y',10,1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206698,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200295,214523,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4daf236b-79d8-419f-b7da-d5a022168111','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206699,'Document Status',200295,214532,'Y',10,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','78885dcc-7533-402b-84d9-8b9318ea5b7b','Y',50,1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206700,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200295,214530,'Y',22,40,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','76718549-c538-43b2-af11-6ca4206bacb9','Y',30,1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206701,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200295,214531,'Y',10,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','52c87cf4-7af9-4f82-88cc-6467444e8901','Y',40,4,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206702,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200295,214526,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e127991c-0e31-4def-95f2-4cb82ea4d552','Y',60,2,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:14 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200296,'Document Status Access',111,130,'Y',200278,0,0,'Y',TO_DATE('2021-06-28 22:04:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:13','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',214530,'N','N',1,'N','D','Y','N','46432a91-ca35-4a60-8b75-4c4c00121f12','B','N','Y',0)
;

-- Jun 28, 2021, 10:04:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206703,'Document Status Access',200296,214521,'N',22,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1b548fdc-0bc6-48d9-a201-ec24347df1f4','N',1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206704,'PA_DocumentStatusAccess_UU',200296,214529,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a3938290-b85e-48a4-9e8c-598261be977f','N',1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:16 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206705,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200296,214522,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','64e91a77-9e2f-47d8-922c-52cbcc4f458f','Y',10,1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206706,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200296,214523,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','518a56cd-9702-4ff2-b86f-5e4f606f7a50','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206707,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200296,214530,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c8c77dc9-f4ad-4de5-8de2-6d6396352d2f','Y',30,1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:18 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206708,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200296,214531,'Y',10,40,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e9df54c8-a0bf-4b23-a594-8f6a212bc5fb','Y',40,4,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:19 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206709,'Document Status',200296,214532,'Y',10,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4a67368d-af76-40b6-a4cb-6ef1d06a40a6','Y',50,1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:19 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206710,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200296,214526,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b0c78b0c-2732-4490-bd2d-12ac8c8cef90','Y',60,2,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:20 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200297,'Document Status Access',108,100,'Y',200278,0,0,'Y',TO_DATE('2021-06-28 22:04:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:19','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',214531,'N','N',1,'N','D','Y','N','5dc2b3d5-02ef-4231-a9f3-3ebdfa35c445','B','N','Y',0)
;

-- Jun 28, 2021, 10:04:21 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206711,'Document Status Access',200297,214521,'N',22,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','29ce5d99-2ec5-402d-bf74-244a39fdbf1a','N',1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:21 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206712,'PA_DocumentStatusAccess_UU',200297,214529,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c84e30b3-e40e-4412-910d-f93ff7cbe183','N',1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:22 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206713,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200297,214522,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','943eb734-bfac-40ef-b227-1daa80c19b7e','Y',10,1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:23 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206714,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200297,214523,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c7483ec4-fec1-44f2-a136-fd49efa624ce','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:23 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206715,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200297,214531,'Y',10,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','66803ea0-631d-4490-b75f-1e469244c68b','Y',40,1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:24 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206716,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200297,214530,'Y',22,40,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ff94eee9-7f61-444c-95dc-22a38acd2b65','Y',30,4,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206717,'Document Status',200297,214532,'Y',10,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','72ecb105-9587-42ad-a68b-03a80a1bdb4a','Y',50,1,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206718,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200297,214526,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-28 22:04:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-28 22:04:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6c262c2b-6c1c-4a56-a3fa-78b8717f411e','Y',60,2,2,1,'N','N','N','N')
;

-- Jun 28, 2021, 10:04:26 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD CONSTRAINT ADRole_PADocumentStatusAccess FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Jun 28, 2021, 10:04:26 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD CONSTRAINT ADUser_PADocumentStatusAccess FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 28, 2021, 10:04:26 PM IST
ALTER TABLE PA_DocumentStatusAccess ADD CONSTRAINT PADocumentStatus_PADocStatAccs FOREIGN KEY (PA_DocumentStatus_ID) REFERENCES pa_documentstatus(pa_documentstatus_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 28, 2021, 10:05:00 PM IST
Insert Into PA_DocumentStatusAccess (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatus_ID,PA_DocumentStatusAccess_ID,PA_DocumentStatusAccess_UU) ( SELECT AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,PA_DocumentStatus_ID,(nextidfunc((SELECT AD_Sequence_ID FROM AD_Sequence WHERE Name = 'PA_DocumentStatusAccess'), 'N')), generate_uuid() FROM PA_DocumentStatus WHERE AD_Role_ID>0 OR AD_User_ID>0 )
;

-- Nov 23, 2021, 8:28:12 PM IST
UPDATE AD_Field SET IsDisplayed='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_DATE('2021-11-23 20:28:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204404
;

-- Nov 23, 2021, 8:28:33 PM IST
UPDATE AD_Field SET IsDisplayed='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_DATE('2021-11-23 20:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204405
;

SELECT register_migration_script('202106282230_IDEMPIERE-4836.sql') FROM dual
;
