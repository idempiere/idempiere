SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 27, 2014 3:38:22 PM CEST
-- IDEMPIERE-2100 automate recurring run
INSERT INTO AD_Window (Processing,WindowType,Help,IsSOTrx,IsDefault,IsBetaFunctionality,EntityType,Name,Description,AD_Window_ID,AD_Window_UU,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,AD_Client_ID,Created) VALUES ('N','M',NULL,'Y','N','N','D','Recurring Group','Recurring Group',200059,'a0423443-ee3d-48e9-b906-fdf8dfe764dc',TO_DATE('2014-07-27 15:38:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,0,TO_DATE('2014-07-27 15:38:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:38:59 PM CEST
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Processing,DatabaseViewDrop,EntityType,AD_Org_ID,Created,Updated) VALUES ('N','N','N','3',0,200059,200143,'N','N','N','L','1944f562-dc5f-436f-9b14-c9594ec4354b','Y','Y','C_RecurringGroup','Recurring Group','Y',100,100,0,'N','N','D',0,TO_DATE('2014-07-27 15:38:58','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-07-27 15:38:58','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:38:59 PM CEST
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID,Created) VALUES ('N',200000,'Y',1000000,'N','Y',200197,'Table C_RecurringGroup','C_RecurringGroup',1,'378d5cae-cb26-4361-aa39-c2c2beabd73f',0,100,TO_DATE('2014-07-27 15:38:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0,TO_DATE('2014-07-27 15:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:39:19 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211572,'Y','N','N',0,'N',22,'N','N','N','Y','2de9b71d-8841-4e8f-a346-d915a041fc03','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2014-07-27 15:39:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',102,19,200143,129,0,0,'D')
;

-- Jul 27, 2014 3:39:20 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211573,'Y','N','N',0,'N',22,'N','N','N','Y','23ef4714-e7d3-44d8-a97b-1eca3f92c32b','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2014-07-27 15:39:19','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:19','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',113,19,200143,104,0,0,'D')
;

-- Jul 27, 2014 3:39:20 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211574,'Y','N','N',0,'N',7,'N','N','N','Y','69dc704e-08cd-4a08-8a0f-36da6674b4df','N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2014-07-27 15:39:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',245,16,200143,0,0,'D')
;

-- Jul 27, 2014 3:39:21 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211575,'Y','N','N',0,'N',22,'N','N','N','Y','8e7d36c3-21cd-450e-83d1-ecfee46f465e','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2014-07-27 15:39:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',246,18,110,200143,0,0,'D')
;

-- Jul 27, 2014 3:39:21 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211576,'N','N','N',0,'N',255,'Y','N','N','Y','5ed28241-ee47-443f-81aa-8249399c4198','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_DATE('2014-07-27 15:39:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',275,10,200143,0,0,'D')
;

-- Jul 27, 2014 3:39:22 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211577,'N','N','N',0,'N',2000,'N','N','N','Y','fbf5fe45-59ac-4f18-ac44-74b665e17869','Y','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',TO_DATE('2014-07-27 15:39:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',326,14,200143,0,0,'D')
;

-- Jul 27, 2014 3:39:22 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211578,'Y','N','N',0,'N',1,'N','N','N','Y','231d8753-0a0b-470b-8b97-9b791c4817ab','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2014-07-27 15:39:22','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',348,20,200143,0,0,'D')
;

-- Jul 27, 2014 3:39:23 PM CEST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('C_RecurringGroup_ID',202755,'Recurring Group','Recurring Group','8218dacd-886a-4da3-ab22-11a1e69af26c',TO_DATE('2014-07-27 15:39:22','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_DATE('2014-07-27 15:39:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:39:23 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211579,'Y','N','N',0,'N',22,'N','Y','N','Y','e95457fb-4005-4228-83c5-42b490901cb3','N','C_RecurringGroup_ID','Recurring Group','N',TO_DATE('2014-07-27 15:39:22','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202755,13,200143,0,0,'D')
;

-- Jul 27, 2014 3:39:24 PM CEST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('C_RecurringGroup_UU',202756,'C_RecurringGroup_UU','C_RecurringGroup_UU','2b32a293-73cc-4d62-a69d-fcf0ca4548b3',TO_DATE('2014-07-27 15:39:23','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_DATE('2014-07-27 15:39:23','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:39:24 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('N',1.00,211580,'N','N','N','N',36,'N','N','N','Y','83c90228-e685-4587-9bac-7b43cf892683','Y','C_RecurringGroup_UU','C_RecurringGroup_UU','N',TO_DATE('2014-07-27 15:39:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202756,10,200143,0,0,'D')
;

-- Jul 27, 2014 3:39:25 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211581,'Y','N','Y',1,'N',60,'Y','N','N','Y','960a9aa1-5cba-44c2-83d4-e04f994b41c4','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_DATE('2014-07-27 15:39:24','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:24','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',469,10,200143,0,0,'D')
;

-- Jul 27, 2014 3:39:25 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211582,'Y','N','N',0,'N',7,'N','N','N','Y','6744c168-47be-413e-8f69-5012d7a92681','N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2014-07-27 15:39:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',607,16,200143,0,0,'D')
;

-- Jul 27, 2014 3:39:26 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211583,'Y','N','N',0,'N',22,'N','N','N','Y','b7257d72-b570-4437-a6f2-6f10ba1d369a','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2014-07-27 15:39:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',608,18,110,200143,0,0,'D')
;

-- Jul 27, 2014 3:39:26 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211584,'Y','N','N',0,'N',40,'Y','N','N','Y','b4580922-c238-4cba-9bbd-81c841473331','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',TO_DATE('2014-07-27 15:39:26','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:39:26','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',620,10,200143,0,0,'D')
;

-- Jul 27, 2014 3:40:21 PM CEST
UPDATE AD_Column SET FKConstraintName='ADClient_CRecurringGroup', FKConstraintType='N',Updated=TO_DATE('2014-07-27 15:40:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211572
;

-- Jul 27, 2014 3:40:21 PM CEST
UPDATE AD_Column SET FKConstraintName='ADOrg_CRecurringGroup', FKConstraintType='N',Updated=TO_DATE('2014-07-27 15:40:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211573
;

-- Jul 27, 2014 3:40:21 PM CEST
UPDATE AD_Column SET FKConstraintName='CreatedBy_CRecurringGroup', FKConstraintType='N',Updated=TO_DATE('2014-07-27 15:40:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211575
;

-- Jul 27, 2014 3:40:21 PM CEST
UPDATE AD_Column SET FKConstraintName='UpdatedBy_CRecurringGroup', FKConstraintType='N',Updated=TO_DATE('2014-07-27 15:40:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211583
;

-- Jul 27, 2014 3:40:21 PM CEST
CREATE TABLE C_RecurringGroup (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE DEFAULT SYSDATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, C_RecurringGroup_ID NUMBER(10) NOT NULL, C_RecurringGroup_UU VARCHAR2(36) DEFAULT NULL , Description VARCHAR2(255) DEFAULT NULL , Help VARCHAR2(2000) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR2(60) NOT NULL, Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, Value VARCHAR2(40) NOT NULL, CONSTRAINT C_RecurringGroup_Key PRIMARY KEY (C_RecurringGroup_ID), CONSTRAINT C_RecurringGroup_UU_idx UNIQUE (C_RecurringGroup_UU))
;

-- Jul 27, 2014 3:40:22 PM CEST
ALTER TABLE C_RecurringGroup ADD CONSTRAINT ADClient_CRecurringGroup FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 27, 2014 3:40:23 PM CEST
ALTER TABLE C_RecurringGroup ADD CONSTRAINT ADOrg_CRecurringGroup FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 27, 2014 3:40:23 PM CEST
ALTER TABLE C_RecurringGroup ADD CONSTRAINT CreatedBy_CRecurringGroup FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 27, 2014 3:40:23 PM CEST
ALTER TABLE C_RecurringGroup ADD CONSTRAINT UpdatedBy_CRecurringGroup FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 27, 2014 3:42:42 PM CEST
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,OrderByClause,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_Table_ID,Created,TreeDisplayedOn) VALUES ('N','N','Y',200059,10,'N','N','N','N','N','Y','N',0,'0753afa4-468a-442e-823a-b3888c06e364','D','Recurring Group',200154,'C_RecurringGroup.Value',0,100,TO_DATE('2014-07-27 15:42:41','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,200143,TO_DATE('2014-07-27 15:42:41','YYYY-MM-DD HH24:MI:SS'),'B')
;

-- Jul 27, 2014 3:42:49 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200154,22,'N','N',10,'Y',203267,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','2ebbca32-8b4e-47fb-9eae-643c218fcf50','Y','N',100,100,TO_DATE('2014-07-27 15:42:48','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,211572,'D',0,TO_DATE('2014-07-27 15:42:48','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:42:49 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200154,22,'N','N',20,'Y',203268,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','4cece287-8ac7-45ae-8a72-fa39bd1209f9','Y','N','Y',100,100,TO_DATE('2014-07-27 15:42:49','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,4,0,2,211573,'D',0,TO_DATE('2014-07-27 15:42:49','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:42:50 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200154,40,'N','N',30,'Y',203269,'N','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search key for the record in the format required - must be unique','Search Key','d47bf6ee-6ada-48c1-a95b-0f33e5f0b853','Y','N',100,100,TO_DATE('2014-07-27 15:42:49','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,0,2,211584,'D',0,TO_DATE('2014-07-27 15:42:49','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:42:50 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200154,60,'N','N',40,'Y',203270,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name','354b3045-b347-4df7-91f6-7e2e2e6d51d9','Y','N',100,100,TO_DATE('2014-07-27 15:42:50','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,0,5,211581,'D',0,TO_DATE('2014-07-27 15:42:50','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:42:50 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200154,255,'N','N',50,'Y',203271,'N','A description is limited to 255 characters.','Optional short description of the record','Description','1aedc3ba-150f-4789-92c0-e25875aaf80c','Y','N',100,100,TO_DATE('2014-07-27 15:42:50','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,0,5,211576,'D',0,TO_DATE('2014-07-27 15:42:50','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:42:51 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,NumLines,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200154,2000,'N','N',60,'Y',203272,'N','The Help field contains a hint, comment or help about the use of this item.','Comment or Hint','Comment/Help','ff1a0a0e-af73-4ac2-bce3-3c08737a9142','Y','N',100,100,TO_DATE('2014-07-27 15:42:50','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,0,5,3,211577,'D',0,TO_DATE('2014-07-27 15:42:50','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:42:51 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200154,22,'N','N','Y',203273,'N','Recurring Group','0825bba9-1b97-4b22-bbb5-f48c10fecb1a','N','N',100,100,TO_DATE('2014-07-27 15:42:51','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,211579,'D',0,TO_DATE('2014-07-27 15:42:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:42:52 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200154,36,'N','N','Y',203274,'N','C_RecurringGroup_UU','fbfff773-85f1-4db2-90bc-0a8e9ba529ff','N','N',100,100,TO_DATE('2014-07-27 15:42:51','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,211580,'D',0,TO_DATE('2014-07-27 15:42:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:42:52 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200154,1,'N','N',70,'Y',203275,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','2409f5a6-90ff-4542-b7f6-bace00af6850','Y','N',100,100,TO_DATE('2014-07-27 15:42:52','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,2,0,2,211578,'D',0,TO_DATE('2014-07-27 15:42:52','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:44:10 PM CEST
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,Action,IsActive,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES (200059,200091,'N','N','N','D','Y','Recurring Group','d5f941b4-c5ca-435b-9559-eb4aef349b9a','W','Y',100,TO_DATE('2014-07-27 15:44:10','YYYY-MM-DD HH24:MI:SS'),100,0,0,TO_DATE('2014-07-27 15:44:10','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:44:10 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200091, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200091)
;

-- Jul 27, 2014 3:44:31 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=441
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=149
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50010
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200010
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=171
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200021
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=437
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=240
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=361
;

-- Jul 27, 2014 3:44:32 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200091
;

-- Jul 27, 2014 3:44:35 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=441
;

-- Jul 27, 2014 3:44:35 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=149
;

-- Jul 27, 2014 3:44:35 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50010
;

-- Jul 27, 2014 3:44:35 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200010
;

-- Jul 27, 2014 3:44:35 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=171
;

-- Jul 27, 2014 3:44:35 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200021
;

-- Jul 27, 2014 3:44:35 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=437
;

-- Jul 27, 2014 3:44:35 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=240
;

-- Jul 27, 2014 3:44:35 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=361
;

-- Jul 27, 2014 3:44:35 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200091
;

-- Jul 27, 2014 3:44:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=441
;

-- Jul 27, 2014 3:44:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=149
;

-- Jul 27, 2014 3:44:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50010
;

-- Jul 27, 2014 3:44:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200010
;

-- Jul 27, 2014 3:44:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=171
;

-- Jul 27, 2014 3:44:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200021
;

-- Jul 27, 2014 3:44:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=437
;

-- Jul 27, 2014 3:44:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=240
;

-- Jul 27, 2014 3:44:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200091
;

-- Jul 27, 2014 3:44:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=361
;

-- Jul 27, 2014 3:53:33 PM CEST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (3,'N',0,211585,'N','N','N',0,'N',22,'Y','N','N','Y','8385c833-aed2-40ca-bf23-82a5abacc46d','Y','C_RecurringGroup_ID','Recurring Group','Y',TO_DATE('2014-07-27 15:53:33','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-07-27 15:53:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202755,19,574,0,0,'D')
;

-- Jul 27, 2014 3:53:46 PM CEST
UPDATE AD_Column SET FKConstraintName='CRecurringGroup_CRecurring', FKConstraintType='N',Updated=TO_DATE('2014-07-27 15:53:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211585
;

-- Jul 27, 2014 3:53:46 PM CEST
ALTER TABLE C_Recurring ADD C_RecurringGroup_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 27, 2014 3:53:46 PM CEST
ALTER TABLE C_Recurring ADD CONSTRAINT CRecurringGroup_CRecurring FOREIGN KEY (C_RecurringGroup_ID) REFERENCES c_recurringgroup(c_recurringgroup_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 27, 2014 3:54:37 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',479,22,'N','N',220,'Y',203276,'N','Recurring Group','9ea93d07-5cd1-4e23-9088-3c5be8047633','Y','N',100,100,TO_DATE('2014-07-27 15:54:37','YYYY-MM-DD HH24:MI:SS'),'Y','Y',220,0,2,211585,'D',0,TO_DATE('2014-07-27 15:54:37','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=6679
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=6838
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=6676
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=6666
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=6667
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=6662
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=6675
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=203276
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=6661
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=6665
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=8188
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=6671
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=6668
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=6669
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=6663
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=6664
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=6673
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=6674
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=6678
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=6677
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=6670
;

-- Jul 27, 2014 3:55:12 PM CEST
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=6672
;

-- Jul 27, 2014 3:56:05 PM CEST
UPDATE AD_Field SET SeqNo=10,Updated=TO_DATE('2014-07-27 15:56:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6679
;

-- Jul 27, 2014 3:56:05 PM CEST
UPDATE AD_Field SET SeqNo=20,Updated=TO_DATE('2014-07-27 15:56:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6666
;

-- Jul 27, 2014 3:56:05 PM CEST
UPDATE AD_Field SET SeqNo=30,Updated=TO_DATE('2014-07-27 15:56:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6667
;

-- Jul 27, 2014 3:56:05 PM CEST
UPDATE AD_Field SET SeqNo=40,Updated=TO_DATE('2014-07-27 15:56:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6662
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6675
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203276
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=5,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6661
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6665
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8188
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6671
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6668
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6669
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6663
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6664
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6673
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6674
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6678
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6677
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6670
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=200,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6672
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6838
;

-- Jul 27, 2014 3:56:06 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2014-07-27 15:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6676
;

-- Jul 27, 2014 4:00:26 PM CEST
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Description,Name,AD_Org_ID,UpdatedBy,IsActive,CreatedBy,Classname,Value,AD_Client_ID,Created,Updated) VALUES ('N',200074,'N','N','ba956f25-b184-4087-a016-089b44efd3bc','1','N','N',0,0,'Y','D','Recurring Run','Recurring Run',0,100,'Y',100,'org.idempiere.process.RecurringRun','RecurringRun',0,TO_DATE('2014-07-27 16:00:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-07-27 16:00:25','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 4:00:53 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,Action,IsActive,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES (200092,'N','Y','N',200074,'D','Y','Recurring Run','638e78d4-2251-4f47-8ecd-044ed2a76e6b','P','Y',100,TO_DATE('2014-07-27 16:00:52','YYYY-MM-DD HH24:MI:SS'),100,0,0,TO_DATE('2014-07-27 16:00:52','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 4:00:53 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200092, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200092)
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=441
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=149
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50010
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200010
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=171
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200021
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=437
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=240
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200091
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=361
;

-- Jul 27, 2014 4:01:05 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200092
;

-- Jul 27, 2014 4:02:22 PM CEST
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,IsMandatory,EntityType,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Element_ID,AD_Reference_ID,Created) VALUES ('N',200103,'efc5b701-03e9-4168-9032-85c9bb63a1f2',200074,'N','D','Recurring Group','C_RecurringGroup_ID',10,'Y',10,'Y',100,TO_DATE('2014-07-27 16:02:22','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,202755,19,TO_DATE('2014-07-27 16:02:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 4:03:11 PM CEST
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,IsMandatory,EntityType,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Element_ID,AD_Reference_ID,Created) VALUES ('N',200104,'47a3eeab-a973-43ba-8918-d6f7be36c885',200074,'N','D','Cut Date','Cut_Date',0,'Y',20,'Y',100,TO_DATE('2014-07-27 16:03:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,202239,15,TO_DATE('2014-07-27 16:03:11','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 4:05:36 PM CEST
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Val_Rule_ID,Created) VALUES ('N',200105,'3a8c401b-4e19-4cc6-8082-7e53694aeae4','You find the current status in the Document Status field. The options are listed in a popup',200074,'N','D','Document Action','DocAction','The targeted status of the document',2,'Y',30,'CO','Y',100,TO_DATE('2014-07-27 16:05:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,287,17,135,219,TO_DATE('2014-07-27 16:05:36','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 4:08:53 PM CEST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,Description,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('Prm_Comment',202757,'Parameter Comment','To replace the tag @Prm_Comment@ on the description of the documents being generated with the text you fill on the parameter','Parameter Comment','cb33b325-2605-4534-90f2-a7390934377f',TO_DATE('2014-07-27 16:08:52','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_DATE('2014-07-27 16:08:52','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 4:09:25 PM CEST
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Element_ID,AD_Reference_ID,Created) VALUES ('N',200106,'bce2494f-5c8b-4b14-8016-eaea0b6d6641',200074,'N','D','Parameter Comment','Prm_Comment','To replace the tag @Prm_Comment@ on the description of the documents being generated with the text you fill on the parameter',255,'Y',40,'Y',100,TO_DATE('2014-07-27 16:09:24','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,202757,10,TO_DATE('2014-07-27 16:09:24','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 27, 2014 4:11:05 PM CEST
UPDATE AD_Process_Para SET EntityType='D', FieldLength=10,Updated=TO_DATE('2014-07-27 16:11:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200104
;

-- Jul 27, 2014 4:19:48 PM CEST
UPDATE AD_Process_Para SET DefaultValue='@#Date@',Updated=TO_DATE('2014-07-27 16:19:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200104
;

-- Jul 27, 2014 6:10:06 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2014-07-27 18:10:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8690
;

-- Jul 27, 2014 6:10:11 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2014-07-27 18:10:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8678
;

-- Jul 27, 2014 6:10:17 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2014-07-27 18:10:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8696
;

-- Jul 27, 2014 6:10:25 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2014-07-27 18:10:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8691
;

-- Jul 27, 2014 6:10:39 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2014-07-27 18:10:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8695
;

-- Jul 27, 2014 6:11:14 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2014-07-27 18:11:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8680
;

-- Jul 27, 2014 6:11:37 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2014-07-27 18:11:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8687
;

SELECT register_migration_script('201407271545_IDEMPIERE-2100.sql') FROM dual
;

