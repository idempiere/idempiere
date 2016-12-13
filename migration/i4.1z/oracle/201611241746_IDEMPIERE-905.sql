SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-905 Post-it functionality
-- Nov 24, 2016 5:45:40 PM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200089,'Post-it',0,0,'Y',TO_DATE('2016-11-24 17:45:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:40','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','f892195b-f1fe-46e9-9b4e-bc76c10c6e31')
;

-- Nov 24, 2016 5:45:41 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200215,'Post-it',200089,'AD_PostIt',0,'7',0,0,'Y',TO_DATE('2016-11-24 17:45:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:40','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','D','N','N','L','N','Y','817f3e09-c45c-426c-82ae-36be50eeffa4','N')
;

-- Nov 24, 2016 5:45:41 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_PostIt',1000000,'N','N','Table AD_PostIt','Y','Y',0,0,TO_DATE('2016-11-24 17:45:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:41','YYYY-MM-DD HH24:MI:SS'),100,200279,'Y',1000000,1,200000,'15a7484a-97cf-4372-95bf-71e1b0e54b63')
;

-- Nov 24, 2016 5:45:42 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203056,0,0,'Y',TO_DATE('2016-11-24 17:45:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:41','YYYY-MM-DD HH24:MI:SS'),100,'AD_Postit_ID','Post-it','Post-it','D','469aef37-8458-47d8-8c67-d437f2f008d7')
;

-- Nov 24, 2016 5:45:42 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212922,0,'Post-it',200215,'AD_Postit_ID',10,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_DATE('2016-11-24 17:45:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:42','YYYY-MM-DD HH24:MI:SS'),100,203056,'N','N','D','Y','N','N','Y','5cafeed3-f69a-49a7-9e55-3367f3cfa4c6','N',0,'N')
;

-- Nov 24, 2016 5:45:42 PM CET
CREATE TABLE AD_PostIt (AD_Postit_ID NUMBER(10) NOT NULL, CONSTRAINT AD_PostIt_Key PRIMARY KEY (AD_Postit_ID))
;

-- Nov 24, 2016 5:45:42 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212923,0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200215,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2016-11-24 17:45:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:42','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','a3ba33e5-12cc-49b3-937d-e1556017fdfd','N',0,'N')
;

-- Nov 24, 2016 5:45:42 PM CET
ALTER TABLE AD_PostIt ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Nov 24, 2016 5:45:43 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212924,0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200215,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2016-11-24 17:45:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:42','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','268c3174-3926-4dbd-afad-3ecdef03d19e','N',0,'N')
;

-- Nov 24, 2016 5:45:43 PM CET
ALTER TABLE AD_PostIt ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Nov 24, 2016 5:45:43 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212925,0,'Table','Database Table information','The Database Table provides the information of the table definition',200215,'AD_Table_ID',10,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_DATE('2016-11-24 17:45:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:43','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','Y','N','N','Y','d5628cb4-04fd-4365-a0f9-f7b555ae31aa','Y',0,'N')
;

-- Nov 24, 2016 5:45:43 PM CET
ALTER TABLE AD_PostIt ADD AD_Table_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 24, 2016 5:45:43 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212926,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200215,'Created',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2016-11-24 17:45:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:43','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','aafb5372-b3c7-4360-a157-98d663fcea8c','N',0,'N')
;

-- Nov 24, 2016 5:45:43 PM CET
ALTER TABLE AD_PostIt ADD Created DATE NOT NULL
;

-- Nov 24, 2016 5:45:44 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212927,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200215,'CreatedBy',10,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_DATE('2016-11-24 17:45:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:44','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','c6910bd9-1cfb-46ea-ba6e-2ce622f27efc','N',0,'N')
;

-- Nov 24, 2016 5:45:44 PM CET
ALTER TABLE AD_PostIt ADD CreatedBy NUMBER(10) NOT NULL
;

-- Nov 24, 2016 5:45:44 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212928,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200215,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2016-11-24 17:45:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:44','YYYY-MM-DD HH24:MI:SS'),100,348,'N','N','D','Y','N','N','Y','8f113935-c0ad-4f46-ac28-27092953d5db','N',0,'N')
;

-- Nov 24, 2016 5:45:44 PM CET
ALTER TABLE AD_PostIt ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Nov 24, 2016 5:45:45 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212929,0,'Description',200215,'Text',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2016-11-24 17:45:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:44','YYYY-MM-DD HH24:MI:SS'),100,53475,'Y','N','D','Y','N','N','Y','afcb6eb7-4141-421f-8386-ae0cd00bd832','Y',0,'N')
;

-- Nov 24, 2016 5:45:45 PM CET
ALTER TABLE AD_PostIt ADD Text VARCHAR2(2000) DEFAULT NULL 
;

-- Nov 24, 2016 5:45:45 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212930,0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200215,'Record_ID',10,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_DATE('2016-11-24 17:45:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:45','YYYY-MM-DD HH24:MI:SS'),100,538,'Y','N','D','Y','N','N','Y','3846e3ae-5ae7-43ef-9f64-1426371d1732','Y',0,'N')
;

-- Nov 24, 2016 5:45:45 PM CET
ALTER TABLE AD_PostIt ADD Record_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 24, 2016 5:45:46 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212931,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200215,'Updated',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2016-11-24 17:45:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:45','YYYY-MM-DD HH24:MI:SS'),100,607,'Y','N','D','Y','N','N','Y','a38f1c45-13f4-491e-b897-286cc3f99131','N',0,'N')
;

-- Nov 24, 2016 5:45:46 PM CET
ALTER TABLE AD_PostIt ADD Updated DATE NOT NULL
;

-- Nov 24, 2016 5:45:46 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton) VALUES (212932,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200215,'UpdatedBy',10,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_DATE('2016-11-24 17:45:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:46','YYYY-MM-DD HH24:MI:SS'),100,608,'Y','N','D','Y','N','N','Y','601e1653-02d2-40cd-8572-b87b65c7b2cd','N',0,'N')
;

-- Nov 24, 2016 5:45:46 PM CET
ALTER TABLE AD_PostIt ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Nov 24, 2016 5:45:47 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203057,0,0,'Y',TO_DATE('2016-11-24 17:45:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:46','YYYY-MM-DD HH24:MI:SS'),100,'AD_PostIt_UU','AD_PostIt_UU','AD_PostIt_UU','D','7a8d19a8-3e03-4c27-9c4b-2ffe32199d81')
;

-- Nov 24, 2016 5:45:47 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton) VALUES (212933,1,'AD_PostIt_UU',200215,'AD_PostIt_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2016-11-24 17:45:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:47','YYYY-MM-DD HH24:MI:SS'),100,203057,'Y','N','D','Y','N','N','Y','ad482a89-b32e-4cba-9d95-6b79ad401fa0','N','N')
;

-- Nov 24, 2016 5:45:47 PM CET
ALTER TABLE AD_PostIt ADD AD_PostIt_UU VARCHAR2(36) DEFAULT NULL 
;

-- Nov 24, 2016 5:45:47 PM CET
ALTER TABLE AD_PostIt ADD CONSTRAINT AD_PostIt_UU_idx UNIQUE (AD_PostIt_UU)
;

-- Nov 24, 2016 5:45:47 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200220,'Post-it',200089,10,'N',200215,0,0,'Y',TO_DATE('2016-11-24 17:45:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:47','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','715973a5-5d22-4d36-8241-6ff369cac595')
;

-- Nov 24, 2016 5:45:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry) VALUES (204344,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200220,212928,'N',1,0,'N','N','N','N',0,0,'Y',TO_DATE('2016-11-24 17:45:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a697ef4c-a87e-42b4-8d93-338ec0e65df8','N',0,1,1,1,'N')
;

-- Nov 24, 2016 5:45:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry) VALUES (204345,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200220,212923,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2016-11-24 17:45:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f63b0185-31a4-42a8-8102-e6a26efc4673','Y',10,1,1,1,'N')
;

-- Nov 24, 2016 5:45:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry) VALUES (204346,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200220,212924,'Y',10,20,'Y','N','N','N',0,0,'Y',TO_DATE('2016-11-24 17:45:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6953b9b3-d4ed-44a0-af7b-f6ffbb136d31','Y','Y',20,1,1,1,'N')
;

-- Nov 24, 2016 5:45:49 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry) VALUES (204347,'Table','Database Table information','The Database Table provides the information of the table definition',200220,212925,'Y',10,30,'N','N','N','N',0,0,'Y',TO_DATE('2016-11-24 17:45:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','23249d8e-93d2-403e-9425-5a48198bada3','Y',30,1,1,1,'N')
;

-- Nov 24, 2016 5:45:49 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry) VALUES (204348,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200220,212930,'Y',10,40,'N','N','N','N',0,0,'Y',TO_DATE('2016-11-24 17:45:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aa0d4cc6-00b3-4df7-bf98-cd5cc4b288fe','Y',40,1,1,1,'N')
;

-- Nov 24, 2016 5:45:50 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry) VALUES (204349,'Description',200220,212929,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_DATE('2016-11-24 17:45:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a72006bb-ed45-4988-9b92-1203f1e7950a','Y',50,1,1,1,'N')
;

-- Nov 24, 2016 5:45:50 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry) VALUES (204350,'Post-it',200220,212922,'N',10,'N','N','N','N',0,0,'Y',TO_DATE('2016-11-24 17:45:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','458b8179-2e74-4b75-ba2e-ae19587ba6b3','N',1,1,1,'N')
;

-- Nov 24, 2016 5:45:50 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Post-it',0,0,'Y',TO_DATE('2016-11-24 17:45:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:50','YYYY-MM-DD HH24:MI:SS'),100,200411,'PostIt','D','1b48e86b-6fb8-4e45-961b-0c8a9611339f')
;

-- Nov 24, 2016 5:45:51 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Created by {0} / {1}',0,0,'Y',TO_DATE('2016-11-24 17:45:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:50','YYYY-MM-DD HH24:MI:SS'),100,200412,'PostItCreated','D','1f0e605a-c851-4786-a5b4-de63ad980ee5')
;

-- Nov 24, 2016 5:45:51 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Updated by {0} / {1}',0,0,'Y',TO_DATE('2016-11-24 17:45:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:51','YYYY-MM-DD HH24:MI:SS'),100,200413,'PostItUpdated','D','575b0ae3-81b3-4d36-97ab-8c636957f74c')
;

-- Nov 24, 2016 5:45:51 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200144,'Post-it','W',200089,0,0,'Y',TO_DATE('2016-11-24 17:45:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-11-24 17:45:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','Y','1262283c-4b52-4a6f-976c-09213d27b0e5')
;

-- Nov 24, 2016 5:45:51 PM CET
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 566,0, 10, 200144)
;

-- Nov 24, 2016 5:45:52 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_ADPostIt', FKConstraintType='N',Updated=TO_DATE('2016-11-24 17:45:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212923
;

-- Nov 24, 2016 5:45:52 PM CET
ALTER TABLE AD_PostIt ADD CONSTRAINT ADClient_ADPostIt FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 24, 2016 5:45:52 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_ADPostIt', FKConstraintType='N',Updated=TO_DATE('2016-11-24 17:45:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212924
;

-- Nov 24, 2016 5:45:52 PM CET
ALTER TABLE AD_PostIt ADD CONSTRAINT ADOrg_ADPostIt FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 24, 2016 5:45:52 PM CET
UPDATE AD_Column SET FKConstraintName='ADTable_ADPostIt', FKConstraintType='N',Updated=TO_DATE('2016-11-24 17:45:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212925
;

-- Nov 24, 2016 5:45:52 PM CET
ALTER TABLE AD_PostIt ADD CONSTRAINT ADTable_ADPostIt FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 24, 2016 5:45:52 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADPostIt', FKConstraintType='N',Updated=TO_DATE('2016-11-24 17:45:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212927
;

-- Nov 24, 2016 5:45:52 PM CET
ALTER TABLE AD_PostIt ADD CONSTRAINT CreatedBy_ADPostIt FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 24, 2016 5:45:52 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADPostIt', FKConstraintType='N',Updated=TO_DATE('2016-11-24 17:45:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212932
;

-- Nov 24, 2016 5:45:52 PM CET
ALTER TABLE AD_PostIt ADD CONSTRAINT UpdatedBy_ADPostIt FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201611241746_IDEMPIERE-905.sql') FROM dual
;

