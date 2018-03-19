SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 12, 2014 3:22:55 PM COT
-- IDEMPIERE-1150 Status Line window
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,WinHeight,IsBetaFunctionality,WinWidth,EntityType,Name,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,AD_Client_ID) VALUES ('N','M','Y','N',0,'N',0,'D','Status Line',200049,'8847fa98-d9d7-43b5-a910-f10f9034a7b0',TO_DATE('2014-01-12 15:22:52','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-01-12 15:22:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,0)
;

-- Jan 12, 2014 3:22:56 PM COT
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID,Processing,EntityType,AD_Org_ID) VALUES ('N','N','N','4',0,200049,200107,'N','N','Y','L','088ac05d-ec44-41ec-87f1-406da2cc4c34','Y','Y','AD_StatusLine','Status Line','Y',100,TO_DATE('2014-01-12 15:22:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:22:55','YYYY-MM-DD HH24:MI:SS'),0,'N','D',0)
;

-- Jan 12, 2014 3:22:58 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200155,'Table AD_StatusLine','AD_StatusLine',1,'1bc91406-9381-440a-a014-ce9d471fc650',0,TO_DATE('2014-01-12 15:22:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:22:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jan 12, 2014 3:23:01 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_StatusLine_ID',202635,'Status Line','Status Line','98650fe7-ec21-43e6-970e-fac282926066',TO_DATE('2014-01-12 15:22:58','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-01-12 15:22:58','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jan 12, 2014 3:23:05 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210898,'Y','N','N','N',22,'N','Y','N','Y','8f8b3b0b-c822-40e9-9762-ae63a4b1e3d8','N','AD_StatusLine_ID','Status Line','N',TO_DATE('2014-01-12 15:23:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202635,13,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:05 PM COT
CREATE TABLE AD_StatusLine (AD_StatusLine_ID NUMBER(10) NOT NULL, CONSTRAINT AD_StatusLine_Key PRIMARY KEY (AD_StatusLine_ID))
;

-- Jan 12, 2014 3:23:08 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210899,'Y','N','N','N',22,'N','N','1=1','N','Y','706e1423-ed75-4019-ba3f-37e6057f4b46','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2014-01-12 15:23:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADClient_ADStatusLine','N',102,19,200107,129,0,0,'D')
;

-- Jan 12, 2014 3:23:08 PM COT
ALTER TABLE AD_StatusLine ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Jan 12, 2014 3:23:10 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210900,'Y','N','N','N',22,'N','N','N','Y','63376a3d-e493-46d3-9d0b-3fcba268ccf9','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2014-01-12 15:23:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADOrg_ADStatusLine','N',113,19,200107,104,0,0,'D')
;

-- Jan 12, 2014 3:23:10 PM COT
ALTER TABLE AD_StatusLine ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Jan 12, 2014 3:23:12 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_StatusLine_UU',202636,'AD_StatusLine_UU','AD_StatusLine_UU','c014d151-29f5-4182-83d6-c0c752acdc67',TO_DATE('2014-01-12 15:23:10','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-01-12 15:23:10','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jan 12, 2014 3:23:15 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210901,'N','N','N','N',36,'N','N','N','Y','7694bf6d-043a-45a6-ace0-ba396d77bb86','Y','AD_StatusLine_UU','AD_StatusLine_UU','N',TO_DATE('2014-01-12 15:23:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202636,10,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:15 PM COT
ALTER TABLE AD_StatusLine ADD AD_StatusLine_UU VARCHAR2(36) DEFAULT NULL 
;

-- Jan 12, 2014 3:23:15 PM COT
ALTER TABLE AD_StatusLine ADD CONSTRAINT AD_StatusLine_UU_idx UNIQUE (AD_StatusLine_UU)
;

-- Jan 12, 2014 3:23:17 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210902,'Y','N','N','N',7,'N','N','N','Y','6d011fcb-a04e-4764-bdc1-5d99d274961f','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2014-01-12 15:23:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:15','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',245,16,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:17 PM COT
ALTER TABLE AD_StatusLine ADD Created DATE NOT NULL
;

-- Jan 12, 2014 3:23:19 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210903,'Y','N','N','N',22,'N','N','N','Y','0722a218-8972-481d-a2c6-fb35bba96c03','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2014-01-12 15:23:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','CreatedBy_ADStatusLine','N',246,18,110,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:19 PM COT
ALTER TABLE AD_StatusLine ADD CreatedBy NUMBER(10) NOT NULL
;

-- Jan 12, 2014 3:23:20 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210904,'Y','N','N',0,'N',40,'N','N','@EntityType@=D','N','Y','99e1b16a-694e-45ab-8838-de6f6213cc26','Y','EntityType','Dictionary Entity Type; Determines ownership and synchronization','D','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Entity Type','Y',TO_DATE('2014-01-12 15:23:19','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:19','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','EntityType_ADStatusLine','N',1682,18,389,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:20 PM COT
ALTER TABLE AD_StatusLine ADD EntityType VARCHAR2(40) DEFAULT 'D' NOT NULL
;

-- Jan 12, 2014 3:23:21 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210905,'Y','N','N','N',1,'N','N','N','Y','5f2b1bd6-167c-4615-92ff-4b7b404b752a','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2014-01-12 15:23:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',348,20,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:21 PM COT
ALTER TABLE AD_StatusLine ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jan 12, 2014 3:23:23 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210906,'Y','N','Y',1,'N',60,'Y','N','N','Y','9cfc31eb-769b-4402-b2ba-1e9061bc5e1b','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_DATE('2014-01-12 15:23:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',469,10,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:23 PM COT
ALTER TABLE AD_StatusLine ADD Name VARCHAR2(60) NOT NULL
;

-- Jan 12, 2014 3:23:25 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210907,'Y','N','N','N',7,'N','N','N','Y','9d6674e9-d2cc-4ddd-abd4-1fc041d1a81e','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2014-01-12 15:23:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',607,16,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:25 PM COT
ALTER TABLE AD_StatusLine ADD Updated DATE NOT NULL
;

-- Jan 12, 2014 3:23:27 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210908,'Y','N','N','N',22,'N','N','N','Y','f3c90cf1-75d1-431a-981b-4ee1a8fa1693','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2014-01-12 15:23:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','UpdatedBy_ADStatusLine','N',608,18,110,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:27 PM COT
ALTER TABLE AD_StatusLine ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Jan 12, 2014 3:23:29 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,210909,'Y','N','N',0,'N',22,'N','N','N','Y','b21ad355-68a2-4d40-b681-7f09e90f3140','Y','AD_Message_ID','System Message','Information and Error messages','Message','Y',TO_DATE('2014-01-12 15:23:27','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADMessage_ADStatusLine','N',1752,19,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:29 PM COT
ALTER TABLE AD_StatusLine ADD AD_Message_ID NUMBER(10) NOT NULL
;

-- Jan 12, 2014 3:23:31 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,210910,'Y','N','N',0,'N',2000,'N','N','N','Y','09ed0f8f-3ea3-4e03-9738-5dccaceeac66','Y','SQLStatement','SQLStatement','Y',TO_DATE('2014-01-12 15:23:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',50028,14,200107,0,0,'D')
;

-- Jan 12, 2014 3:23:31 PM COT
ALTER TABLE AD_StatusLine ADD SQLStatement VARCHAR2(2000) NOT NULL
;

-- Jan 12, 2014 3:23:33 PM COT
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_Table_ID) VALUES ('N','N','Y',200049,10,'N','N','N','N','N','Y','N',0,'0cd0bd95-f7c8-44a8-b8af-0a06c3c198d2','D','Status Line',200114,0,TO_DATE('2014-01-12 15:23:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:31','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,200107)
;

-- Jan 12, 2014 3:23:35 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200114,22,'N','N',0,'Y',202559,'N','Status Line','843a1fee-c479-496d-8c31-4065db96d145','N','N',100,TO_DATE('2014-01-12 15:23:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:33','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',210898,'D',0)
;

-- Jan 12, 2014 3:23:35 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200114,36,'N','N',0,'Y',202560,'N','AD_StatusLine_UU','e4413182-f072-4f49-89da-8cfeec9320c2','N','N',100,TO_DATE('2014-01-12 15:23:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:35','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',210901,'D',0)
;

-- Jan 12, 2014 3:23:36 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200114,22,'N','N',10,'Y',202561,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','5a9bfebe-6ebc-4d8f-b0f0-36e56d84c64d','Y','N',100,TO_DATE('2014-01-12 15:23:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:35','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',210899,'D',0)
;

-- Jan 12, 2014 3:23:36 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200114,22,'Y','N',20,'Y',202562,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','218d3b22-9140-4767-8377-5341a1835f23','Y','N','Y',100,TO_DATE('2014-01-12 15:23:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:36','YYYY-MM-DD HH24:MI:SS'),'Y','N',4,'N',0,2,1,'N','N',210900,'D',0)
;

-- Jan 12, 2014 3:23:37 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200114,60,'N','N',30,'Y',202563,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name','f9f9be63-f2be-49c0-a222-f70f344e9634','Y','N',100,TO_DATE('2014-01-12 15:23:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:36','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,5,1,'N','N',210906,'D',0)
;

-- Jan 12, 2014 3:23:38 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200114,22,'N','N',40,'Y',202564,'N','Information and Error messages','System Message','Message','8e401333-ae4a-49ad-b521-6b4ead4e0a0e','Y','N',100,TO_DATE('2014-01-12 15:23:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:37','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,'N',0,5,1,'N','N',210909,'D',0)
;

-- Jan 12, 2014 3:23:38 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200114,2000,'N','N',50,'Y',202565,'N','SQLStatement','6adc7d7f-573c-4728-b380-2ac97b2e1f30','Y','N',100,TO_DATE('2014-01-12 15:23:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:38','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,'N',0,5,8,'N','N',210910,'D',0)
;

-- Jan 12, 2014 3:23:39 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200114,10,'N','N',60,'Y',202566,'N','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Dictionary Entity Type; Determines ownership and synchronization','Entity Type','b87e9e3e-a3b0-47e2-9fe8-3d88ea06b9a6','Y','N',100,TO_DATE('2014-01-12 15:23:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:38','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,2,1,'N','N',210904,'D',0)
;

-- Jan 12, 2014 3:23:39 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200114,1,'Y','N',70,'Y',202567,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','03586f0e-8ac7-4b9b-b6c5-7c0f217259ec','Y','N',100,TO_DATE('2014-01-12 15:23:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:39','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,5,'N',0,2,1,'N','N',210905,'D',0)
;

-- Jan 12, 2014 3:23:40 PM COT
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID,Processing,EntityType,AD_Org_ID) VALUES ('N','N','N','4',0,200049,200108,'N','N','Y','L','0442ac38-5ff3-48c1-9c3c-2bb2d33d0846','Y','Y','AD_StatusLineUsedIn','Status Line used in','Y',100,TO_DATE('2014-01-12 15:23:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:39','YYYY-MM-DD HH24:MI:SS'),0,'N','D',0)
;

-- Jan 12, 2014 3:23:40 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200156,'Table AD_StatusLineUsedIn','AD_StatusLineUsedIn',1,'50c5eacc-8dbb-44f5-b185-1ecf8171cdf9',0,TO_DATE('2014-01-12 15:23:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:40','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Jan 12, 2014 3:23:41 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_StatusLineUsedIn_ID',202637,'AD_StatusLineUsedIn','AD_StatusLineUsedIn','254cf4f8-3aad-4390-8a8a-30f8f2e6eae7',TO_DATE('2014-01-12 15:23:40','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-01-12 15:23:40','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jan 12, 2014 3:23:41 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210911,'Y','N','N','N',22,'N','Y','N','Y','630ce21f-1b9d-4920-9409-5cab09dcd096','N','AD_StatusLineUsedIn_ID','AD_StatusLineUsedIn','N',TO_DATE('2014-01-12 15:23:41','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:41','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202637,13,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:41 PM COT
CREATE TABLE AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID NUMBER(10) NOT NULL, CONSTRAINT AD_StatusLineUsedIn_Key PRIMARY KEY (AD_StatusLineUsedIn_ID))
;

-- Jan 12, 2014 3:23:42 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210912,'Y','N','N','N',22,'N','N','1=1','N','Y','a9497823-8c58-45a2-bfe3-cb5d04843dd4','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2014-01-12 15:23:41','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:41','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADClient_ADStatusLineUsedIn','N',102,19,200108,129,0,0,'D')
;

-- Jan 12, 2014 3:23:42 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Jan 12, 2014 3:23:43 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210913,'Y','N','N','N',22,'N','N','N','Y','2f4dca6b-dd61-4547-b67c-f4a459b055fe','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2014-01-12 15:23:42','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:42','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADOrg_ADStatusLineUsedIn','N',113,19,200108,104,0,0,'D')
;

-- Jan 12, 2014 3:23:43 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Jan 12, 2014 3:23:43 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_StatusLineUsedIn_UU',202638,'AD_StatusLineUsedIn_UU','AD_StatusLineUsedIn_UU','7c48afac-dc95-4c12-9648-292bb52fe445',TO_DATE('2014-01-12 15:23:43','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-01-12 15:23:43','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jan 12, 2014 3:23:44 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210914,'N','N','N','N',36,'N','N','N','Y','ed3b4567-2c6b-4e83-aeae-64f63295b58a','Y','AD_StatusLineUsedIn_UU','AD_StatusLineUsedIn_UU','N',TO_DATE('2014-01-12 15:23:43','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:43','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202638,10,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:44 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD AD_StatusLineUsedIn_UU VARCHAR2(36) DEFAULT NULL 
;

-- Jan 12, 2014 3:23:44 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT AD_StatusLineUsedIn_UU_idx UNIQUE (AD_StatusLineUsedIn_UU)
;

-- Jan 12, 2014 3:23:44 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,210915,'Y','N','N',0,'Y',22,'N','N','N','Y','3b1528dc-c428-400c-8600-980ec93759e9','N','AD_StatusLine_ID','Status Line','Y',TO_DATE('2014-01-12 15:23:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:44','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADStatusLine_ADStatusLineUsedI','N',202635,30,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:44 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD AD_StatusLine_ID NUMBER(10) NOT NULL
;

-- Jan 12, 2014 3:23:45 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210916,'Y','N','N','N',7,'N','N','N','Y','b37ddd58-36c2-47a7-bd7f-0870c8e7dd20','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2014-01-12 15:23:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:44','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',245,16,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:45 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD Created DATE NOT NULL
;

-- Jan 12, 2014 3:23:46 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210917,'Y','N','N','N',22,'N','N','N','Y','d8dd22a4-568a-45ce-9f3b-112f58fd5341','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2014-01-12 15:23:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:45','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','CreatedBy_ADStatusLineUsedIn','N',246,18,110,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:46 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD CreatedBy NUMBER(10) NOT NULL
;

-- Jan 12, 2014 3:23:46 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210918,'Y','N','N','N',1,'N','N','N','Y','602735af-0851-4914-843b-e183e3770e8f','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2014-01-12 15:23:46','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:46','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',348,20,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:46 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jan 12, 2014 3:23:47 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210919,'Y','N','N','N',7,'N','N','N','Y','9d687961-5fc4-459c-ac62-408372e6400c','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2014-01-12 15:23:46','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:46','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',607,16,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:47 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD Updated DATE NOT NULL
;

-- Jan 12, 2014 3:23:48 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,210920,'Y','N','N','N',22,'N','N','N','Y','f66886c6-30d4-4a00-bbce-73229ca24ed3','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2014-01-12 15:23:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:47','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','UpdatedBy_ADStatusLineUsedIn','N',608,18,110,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:48 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Jan 12, 2014 3:23:49 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,210921,'N','N','N',0,'N',22,'N','N','N','Y','3779a8f3-ca5b-430c-b022-8fb876bc111e','Y','AD_Window_ID','Data entry or display window','The Window field identifies a unique Window in the system.','Window','Y',TO_DATE('2014-01-12 15:23:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADWindow_ADStatusLineUsedIn','N',143,19,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:49 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD AD_Window_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 12, 2014 3:23:50 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,210922,'N','N','N',0,'N',10,'N','N','N','Y','79c55587-62e5-47dc-aa63-e1e2d36f8aea','Y','AD_Tab_ID','Tab within a Window','The Tab indicates a tab that displays within a window.','Tab','Y',TO_DATE('2014-01-12 15:23:49','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:49','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADTab_ADStatusLineUsedIn','N',125,19,200108,163,0,0,'D')
;

-- Jan 12, 2014 3:23:50 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD AD_Tab_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 12, 2014 3:23:50 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,Name,Description,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('IsStatusLine',202639,'If checked the definition corresponds to a status line, when unchecked it corresponds to a help widget','Status Line','Defines if this record refers to a status line or to a help widget','Status Line','2ec77e53-9733-40fe-8579-9d2080be9ec5',TO_DATE('2014-01-12 15:23:50','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-01-12 15:23:50','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jan 12, 2014 3:23:51 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,210923,'Y','N','N',0,'N',1,'N','N','N','Y','fcae468b-c00f-4944-ba95-0929da77057e','Y','IsStatusLine','Defines if this record refers to a status line or to a help widget','Y','If checked the definition corresponds to a status line, when unchecked it corresponds to a help widget','Status Line','Y',TO_DATE('2014-01-12 15:23:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:50','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202639,20,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:51 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD IsStatusLine CHAR(1) DEFAULT 'Y' CHECK (IsStatusLine IN ('Y','N')) NOT NULL
;

-- Jan 12, 2014 3:23:52 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,210924,'N','N','N',0,'N',22,'N','N','N','Y','f5238112-0fbd-4ec5-9ad8-419baa7e7609','Y','SeqNo','Method of ordering records; lowest number comes first','The Sequence indicates the order of records','Sequence','Y',TO_DATE('2014-01-12 15:23:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',566,11,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:52 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD SeqNo NUMBER(10) DEFAULT NULL 
;

-- Jan 12, 2014 3:23:52 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,210925,'N','N','N',0,'N',10,'N','N','N','Y','d0fb6046-4e44-468f-9509-59312ad15065','Y','AD_Table_ID','Database Table information','The Database Table provides the information of the table definition','Table','Y',TO_DATE('2014-01-12 15:23:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:23:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADTable_ADStatusLineUsedIn','N',126,19,200108,0,0,'D')
;

-- Jan 12, 2014 3:23:52 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD AD_Table_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 12, 2014 3:23:53 PM COT
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_Table_ID) VALUES ('N','N','Y',200049,30,'N','N','N','N','N','Y','N',1,'c48e09b9-ca7a-4734-8385-da33d75f9b2b','D','Used In',200115,0,TO_DATE('2014-01-12 15:23:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,200108)
;

-- Jan 12, 2014 3:23:54 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,36,'N','N',0,'Y',202568,'N','AD_StatusLineUsedIn_UU','08519b29-fc8c-4d0f-832d-809c6e32d2cd','N','N',100,TO_DATE('2014-01-12 15:23:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:53','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',210914,'D',0)
;

-- Jan 12, 2014 3:23:55 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,22,'N','N',0,'Y',202569,'N','AD_StatusLineUsedIn','c61bd9d9-61fe-48db-922b-6f538d006734','N','N',100,TO_DATE('2014-01-12 15:23:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:54','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',210911,'D',0)
;

-- Jan 12, 2014 3:23:56 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,22,'N','N',10,'Y',202570,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','0143b368-78a3-49b4-935f-2ff6ed7e3ada','Y','N',100,TO_DATE('2014-01-12 15:23:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:55','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',210912,'D',0)
;

-- Jan 12, 2014 3:23:58 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,22,'Y','N',20,'Y',202571,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','64f4c901-a2d7-4d41-a13f-b85225256660','Y','N','Y',100,TO_DATE('2014-01-12 15:23:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:56','YYYY-MM-DD HH24:MI:SS'),'Y','N',4,'N',0,2,1,'N','N',210913,'D',0)
;

-- Jan 12, 2014 3:23:59 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,22,'N','N',30,'Y',202572,'N','Status Line','8d6bfcc5-7951-47ee-937c-3766a26fc4d7','Y','N',100,TO_DATE('2014-01-12 15:23:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:58','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,'N',0,5,1,'N','N',210915,'D',0)
;

-- Jan 12, 2014 3:24:00 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,10,'N','N',40,'Y',202573,'N','The Database Table provides the information of the table definition','@AD_Window_ID@=0','Database Table information','Table','6b573a8f-5dd7-43d1-bd88-20558297716a','Y','N',100,TO_DATE('2014-01-12 15:23:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:23:59','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,2,1,'N','N',210925,'D',0)
;

-- Jan 12, 2014 3:24:01 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,22,'N','N',50,'Y',202574,'N','The Window field identifies a unique Window in the system.','@AD_Table_ID@=0','Data entry or display window','Window','81b65c87-88a9-447d-be31-5bad473c675f','Y','N',100,TO_DATE('2014-01-12 15:24:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:24:00','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,'N',0,2,1,'N','N',210921,'D',0)
;

-- Jan 12, 2014 3:24:02 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,10,'N','N',60,'Y',202575,'N','The Tab indicates a tab that displays within a window.','@AD_Table_ID@=0','Tab within a Window','Tab','882010d2-2c6e-4b5c-b268-84e6bb1afbdd','Y','N',100,TO_DATE('2014-01-12 15:24:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:24:01','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,4,'N',0,2,1,'N','N',210922,'D',0)
;

-- Jan 12, 2014 3:24:03 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,1,'N','N',70,'Y',202576,'N','If checked the definition corresponds to a status line, when unchecked it corresponds to a help widget','Defines if this record refers to a status line or to a help widget','Status Line','eb939c76-a6df-4f0f-bded-8ef79c747b99','Y','N',100,TO_DATE('2014-01-12 15:24:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:24:02','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,2,'N',0,2,1,'N','N',210923,'D',0)
;

-- Jan 12, 2014 3:24:04 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,22,'N','N',80,'Y',202577,'N','The Sequence indicates the order of records','@IsStatusLine@=N','Method of ordering records; lowest number comes first','Sequence','48f82bf7-9967-4a3e-8f96-373ad7708f25','Y','N',100,TO_DATE('2014-01-12 15:24:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:24:03','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,4,'N',0,2,1,'N','N',210924,'D',0)
;

-- Jan 12, 2014 3:24:05 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID) VALUES ('N',200115,1,'N','N',90,'Y',202578,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','db7d1ee6-0bd9-43d7-86cb-c2395dedde4c','Y','N',100,TO_DATE('2014-01-12 15:24:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-12 15:24:04','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,2,'N',0,2,1,'N','N',210918,'D',0)
;

-- Jan 12, 2014 3:24:06 PM COT
INSERT INTO AD_StatusLine (AD_StatusLine_ID,AD_Client_ID,AD_Org_ID,AD_StatusLine_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Message_ID,SQLStatement) VALUES (200000,0,0,'6f551ab3-bbbd-431a-8a0d-168e48d3057c',TO_DATE('2014-01-12 15:24:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','OrderSummary',TO_DATE('2014-01-12 15:24:05','YYYY-MM-DD HH24:MI:SS'),100,377,'SELECT COUNT(DISTINCT C_OrderLine_ID) AS Lines,o.TotalLines,o.GrandTotal,c.ISO_Code, currencyBase(o.GrandTotal,o.C_Currency_ID,o.DateAcct, o.AD_Client_ID,o.AD_Org_ID) AS ConvAmt 
FROM C_Order o
INNER JOIN C_Currency c ON (o.C_Currency_ID=c.C_Currency_ID)
LEFT JOIN C_OrderLine l ON (o.C_Order_ID=l.C_Order_ID)
WHERE o.C_Order_ID=@C_Order_ID@
GROUP BY o.C_Currency_ID, c.ISO_Code, o.TotalLines, o.GrandTotal, o.DateAcct, o.AD_Client_ID, o.AD_Org_ID')
;

-- Jan 12, 2014 3:24:07 PM COT
INSERT INTO AD_StatusLine (AD_StatusLine_ID,AD_Client_ID,AD_Org_ID,AD_StatusLine_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Message_ID,SQLStatement) VALUES (200001,0,0,'cf2ade0c-a71b-4b86-8311-6afef2071e1d',TO_DATE('2014-01-12 15:24:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','InvoiceBatchSummary',TO_DATE('2014-01-12 15:24:06','YYYY-MM-DD HH24:MI:SS'),100,828,'SELECT COUNT(*), NVL(SUM(LineNetAmt),0), NVL(SUM(LineTotalAmt),0)
FROM C_InvoiceBatchLine
WHERE C_InvoiceBatch_ID=@C_InvoiceBatch_ID@ AND IsActive=''Y''')
;

-- Jan 12, 2014 3:24:08 PM COT
INSERT INTO AD_StatusLine (AD_StatusLine_ID,AD_Client_ID,AD_Org_ID,AD_StatusLine_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Message_ID,SQLStatement) VALUES (200002,0,0,'52d85f09-f71b-4f7b-abb1-a4161891bb36',TO_DATE('2014-01-12 15:24:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','InvoiceSummary',TO_DATE('2014-01-12 15:24:07','YYYY-MM-DD HH24:MI:SS'),100,377,'SELECT COUNT(DISTINCT C_InvoiceLine_ID) AS Lines,o.TotalLines,o.GrandTotal,c.ISO_Code, currencyBase(o.GrandTotal,o.C_Currency_ID,o.DateAcct, o.AD_Client_ID,o.AD_Org_ID) AS ConvAmt 
FROM C_Invoice o
INNER JOIN C_Currency c ON (o.C_Currency_ID=c.C_Currency_ID)
LEFT JOIN C_InvoiceLine l ON (o.C_Invoice_ID=l.C_Invoice_ID)
WHERE o.C_Invoice_ID=@C_Invoice_ID@
GROUP BY o.C_Currency_ID, c.ISO_Code, o.TotalLines, o.GrandTotal, o.DateAcct, o.AD_Client_ID, o.AD_Org_ID')
;

-- Jan 12, 2014 3:24:09 PM COT
INSERT INTO AD_StatusLine (AD_StatusLine_ID,AD_Client_ID,AD_Org_ID,AD_StatusLine_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Message_ID,SQLStatement) VALUES (200003,0,0,'aed8f503-ef80-4b4c-9947-99abf3667c66',TO_DATE('2014-01-12 15:24:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ExpenseSummary',TO_DATE('2014-01-12 15:24:08','YYYY-MM-DD HH24:MI:SS'),100,623,'SELECT COUNT(*) AS Lines, SUM(ConvertedAmt*Qty), '' ''
FROM S_TimeExpenseLine
WHERE S_TimeExpense_ID=@S_TimeExpense_ID@')
;

-- Jan 12, 2014 3:24:10 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200000,0,0,'15df6822-bf23-4943-89f0-647a4901c402',200000,TO_DATE('2014-01-12 15:24:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,259)
;

-- Jan 12, 2014 3:24:11 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200001,0,0,'60ec0af6-338c-4ddd-b073-152283b40925',200000,TO_DATE('2014-01-12 15:24:10','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:10','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,260)
;

-- Jan 12, 2014 3:24:12 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200002,0,0,'1aab8980-db93-4bb2-899e-941af8b25637',200000,TO_DATE('2014-01-12 15:24:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,200103)
;

-- Jan 12, 2014 3:24:12 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200003,0,0,'64e64e3f-2153-42a5-b077-65204d82966c',200000,TO_DATE('2014-01-12 15:24:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,200104)
;

-- Jan 12, 2014 3:24:13 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200004,0,0,'e4edfa4a-31e1-472c-a639-6162fa6771e3',200000,TO_DATE('2014-01-12 15:24:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,53296)
;

-- Jan 12, 2014 3:24:14 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200005,0,0,'ab2e8306-d1ad-4b29-a25e-fa59d5b77c34',200000,TO_DATE('2014-01-12 15:24:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,314)
;

-- Jan 12, 2014 3:24:15 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200006,0,0,'f4b7d51c-3ab6-48f2-9884-abd644655ebc',200001,TO_DATE('2014-01-12 15:24:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,767)
;

-- Jan 12, 2014 3:24:15 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200007,0,0,'eb0594d6-c14e-4b1c-9839-e60bd4f1b97d',200001,TO_DATE('2014-01-12 15:24:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,768)
;

-- Jan 12, 2014 3:24:16 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200008,0,0,'c1e3e096-8be2-43ca-84c3-b39bbf129238',200002,TO_DATE('2014-01-12 15:24:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,318)
;

-- Jan 12, 2014 3:24:16 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200009,0,0,'62ad5b5d-b969-49bf-bba1-8b8e24cfad00',200002,TO_DATE('2014-01-12 15:24:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,333)
;

-- Jan 12, 2014 3:24:17 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200010,0,0,'9e794307-756e-4bec-bd02-9cdae55570c3',200002,TO_DATE('2014-01-12 15:24:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,551)
;

-- Jan 12, 2014 3:24:18 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,IsStatusLine,SeqNo,AD_Table_ID) VALUES (200011,0,0,'10ad2e85-34b6-480c-8a6e-8934dd0aec23',200002,TO_DATE('2014-01-12 15:24:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,334)
;

-- Jan 12, 2014 3:24:18 PM COT
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Window_ID,AD_Tab_ID,IsStatusLine,SeqNo) VALUES (200012,0,0,'fcb6d37c-8015-4d91-b01c-8deb35e6b31a',200003,TO_DATE('2014-01-12 15:24:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-01-12 15:24:18','YYYY-MM-DD HH24:MI:SS'),100,235,412,'Y',0)
;

-- Jan 12, 2014 3:24:19 PM COT
UPDATE AD_Message SET MsgText='{0,choice,0#No Lines|1#1 Line|1<{0} Lines} - {1,number,#,##0.00} - Total: {2,number,#,##0.00} {3} = {4,number,#,##0.00}', Updated=TO_DATE('2014-01-12 15:24:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=377
;

UPDATE AD_Message_Trl SET MsgText='{0,choice,0#Sin Líneas|1#1 Línea|1<{0} Líneas} - {1,number,#,##0.00} -  Total: {2,number,#,##0.00}  {3} =  {4,number,#,##0.00}' WHERE AD_Message_ID=377 AND AD_Language LIKE 'es_%'
;

-- Jan 12, 2014 3:24:19 PM COT
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,Action,IsActive,CreatedBy,Updated,Created,UpdatedBy,AD_Client_ID,AD_Org_ID) VALUES (200049,200072,'N','N','N','D','Y','Status Line','39478137-c380-4d3b-9892-b305d91e9f5a','W','Y',100,TO_DATE('2014-01-12 15:24:19','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-01-12 15:24:19','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Jan 12, 2014 3:24:19 PM COT
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 153,19, 10, 200072)
;

-- Jan 12, 2014 3:33:34 PM COT
ALTER TABLE AD_StatusLine ADD CONSTRAINT ADClient_ADStatusLine FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:33:34 PM COT
ALTER TABLE AD_StatusLine ADD CONSTRAINT ADOrg_ADStatusLine FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:33:35 PM COT
ALTER TABLE AD_StatusLine ADD CONSTRAINT CreatedBy_ADStatusLine FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:33:35 PM COT
ALTER TABLE AD_StatusLine ADD CONSTRAINT EntityType_ADStatusLine FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:33:35 PM COT
ALTER TABLE AD_StatusLine ADD CONSTRAINT UpdatedBy_ADStatusLine FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:33:35 PM COT
ALTER TABLE AD_StatusLine ADD CONSTRAINT ADMessage_ADStatusLine FOREIGN KEY (AD_Message_ID) REFERENCES ad_message(ad_message_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:33:59 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT ADClient_ADStatusLineUsedIn FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:33:59 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT ADOrg_ADStatusLineUsedIn FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:33:59 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT ADStatusLine_ADStatusLineUsedI FOREIGN KEY (AD_StatusLine_ID) REFERENCES ad_statusline(ad_statusline_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:33:59 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT CreatedBy_ADStatusLineUsedIn FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:34:00 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT UpdatedBy_ADStatusLineUsedIn FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:34:00 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT ADWindow_ADStatusLineUsedIn FOREIGN KEY (AD_Window_ID) REFERENCES ad_window(ad_window_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:34:00 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT ADTab_ADStatusLineUsedIn FOREIGN KEY (AD_Tab_ID) REFERENCES ad_tab(ad_tab_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 12, 2014 3:34:00 PM COT
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT ADTable_ADStatusLineUsedIn FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201401121525_IDEMPIERE-1150.sql') FROM dual
;

