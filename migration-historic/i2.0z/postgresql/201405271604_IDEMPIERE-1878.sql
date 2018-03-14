-- May 27, 2014 10:33:16 PM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Column SET IsSyncDatabase='Y', IsTranslated='Y', ColumnName='Name', AD_Org_ID=0, AD_Client_ID=0,Updated=TO_TIMESTAMP('2014-05-27 22:33:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7019
;

-- May 27, 2014 10:33:17 PM ICT
UPDATE AD_Column SET IsSyncDatabase='Y', IsTranslated='Y', ColumnName='Description', AD_Org_ID=0, AD_Client_ID=0,Updated=TO_TIMESTAMP('2014-05-27 22:33:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7025
;

-- May 27, 2014 10:33:23 PM ICT
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Processing,AD_Client_ID,Created) VALUES ('N','6',70,240,200130,'N','N','Y','D','L','f6afaadd-dc3a-4b1e-ac86-cf4f562e6dc3','Y','N','AD_PrintFormat_Trl','Data Print Format','Print Format Trl','Y',0,100,TO_TIMESTAMP('2014-05-27 22:33:17','YYYY-MM-DD HH24:MI:SS'),100,'N',0,TO_TIMESTAMP('2014-05-27 22:33:17','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:24 PM ICT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID,Created) VALUES ('N',200000,'Y',1000000,'N','Y',200177,'Table AD_PrintFormat_Trl','AD_PrintFormat_Trl',1,'5140cb57-062d-4516-b167-62a9086f6eb7',0,100,TO_TIMESTAMP('2014-05-27 22:33:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0,TO_TIMESTAMP('2014-05-27 22:33:23','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:25 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211259,'Y','N','N','Y',10,'N','N','N','Y','f9ac04a4-8316-444b-9498-a21ae57ff33d','N','AD_PrintFormat_ID','Data Print Format','0','The print format determines how data is rendered for print.','Print Format','Y',TO_TIMESTAMP('2014-05-27 22:33:24','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:24','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','adprintformat_trl','N',1790,19,200130)
;

-- May 27, 2014 10:33:25 PM ICT
CREATE TABLE AD_PrintFormat_Trl (AD_PrintFormat_ID NUMERIC(10) DEFAULT 0 NOT NULL, CONSTRAINT AD_PrintFormat_Trl_Key PRIMARY KEY (AD_PrintFormat_ID))
;

-- May 27, 2014 10:33:27 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES ('Y',0.0,211260,'Y','N','N','Y',6,'N','N','N','Y','eff27d6a-7790-487d-829d-cfa56eacb0f8','N','AD_Language','Language for this entity','The Language identifies the language to use for display and formatting','Language','Y',TO_TIMESTAMP('2014-05-27 22:33:26','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:26','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','adlanguage_adprintformtrl','N',109,18,106,200130)
;

-- May 27, 2014 10:33:27 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN AD_Language VARCHAR(6) NOT NULL
;

-- May 27, 2014 10:33:27 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID) VALUES ('Y',0.0,211261,'Y','N','N','N',10,'N','N','N','Y','7a497225-b391-4ed3-9521-c987218f4b1f','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2014-05-27 22:33:27','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',102,19,200130,129)
;

-- May 27, 2014 10:33:27 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN AD_Client_ID NUMERIC(10) NOT NULL
;

-- May 27, 2014 10:33:28 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID) VALUES ('Y',0.0,211262,'Y','N','N','N',10,'N','N','N','Y','61e40f14-4e0f-43f3-a43d-e5381e6a19f0','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2014-05-27 22:33:27','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',113,19,200130,104)
;

-- May 27, 2014 10:33:28 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN AD_Org_ID NUMERIC(10) NOT NULL
;

-- May 27, 2014 10:33:29 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211263,'Y','N','N','N',1,'N','N','N','Y','dc9ebff5-1a13-4978-bd6d-8a576a96db1f','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2014-05-27 22:33:28','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:28','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',348,20,200130)
;

-- May 27, 2014 10:33:29 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- May 27, 2014 10:33:30 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211264,'Y','N','N','N',29,'N','N','N','Y','b5c86f41-f3f3-449c-b8de-15c6185b00ee','N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2014-05-27 22:33:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',245,16,200130)
;

-- May 27, 2014 10:33:30 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- May 27, 2014 10:33:31 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES ('Y',0.0,211265,'Y','N','N','N',10,'N','N','N','Y','a7c8903f-1993-46e6-90c8-e26bb3c28559','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2014-05-27 22:33:30','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:30','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',246,18,110,200130)
;

-- May 27, 2014 10:33:31 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN CreatedBy NUMERIC(10) NOT NULL
;

-- May 27, 2014 10:33:32 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211266,'Y','N','N','N',29,'N','N','N','Y','0ff1758a-763b-4ea9-9d6e-552aff285f9a','N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2014-05-27 22:33:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',607,16,200130)
;

-- May 27, 2014 10:33:32 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- May 27, 2014 10:33:33 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES ('Y',0.0,211267,'Y','N','N','N',10,'N','N','N','Y','f6635c5b-d08e-4c11-91e8-e174ab9a6443','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2014-05-27 22:33:32','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:32','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',608,18,110,200130)
;

-- May 27, 2014 10:33:33 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN UpdatedBy NUMERIC(10) NOT NULL
;

-- May 27, 2014 10:33:34 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211268,'Y','N','Y','N',60,'Y','N','N','Y','2063175c-cd06-44d2-9a98-7864dfb763df','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_TIMESTAMP('2014-05-27 22:33:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',469,10,200130)
;

-- May 27, 2014 10:33:34 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN Name VARCHAR(60) NOT NULL
;

-- May 27, 2014 10:33:34 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211269,'N','N','N','N',255,'Y','N','N','Y','02dab09d-1d15-4698-b729-ec756656a1f4','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_TIMESTAMP('2014-05-27 22:33:34','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:34','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',275,10,200130)
;

-- May 27, 2014 10:33:35 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN Description VARCHAR(255) DEFAULT NULL 
;

-- May 27, 2014 10:33:35 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211270,'Y','N','N','N',1,'N','N','N','Y','a2912e1e-48ee-4389-acb8-52d64e5c0698','Y','IsTranslated','This column is translated','The Translated checkbox indicates if this column is translated.','Translated','Y',TO_TIMESTAMP('2014-05-27 22:33:35','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:35','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',420,20,200130)
;

-- May 27, 2014 10:33:35 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN IsTranslated CHAR(1) CHECK (IsTranslated IN ('Y','N')) NOT NULL
;

-- May 27, 2014 10:33:36 PM ICT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created,Updated) VALUES ('AD_PrintFormat_Trl_UU',202715,'AD_PrintFormat_Trl_UU','AD_PrintFormat_Trl_UU','ae168f8a-94f1-4327-ba4e-38c92616dc34',0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-05-27 22:33:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-05-27 22:33:36','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:37 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211271,'N','N','N','N',36,'N','N','N','Y','8919e165-e58c-4c5c-8a57-fa21c0391dff','N','AD_PrintFormat_Trl_UU','AD_PrintFormat_Trl_UU','N',TO_TIMESTAMP('2014-05-27 22:33:36','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2014-05-27 22:33:36','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',202715,10,200130)
;

-- May 27, 2014 10:33:37 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN AD_PrintFormat_Trl_UU VARCHAR(36) DEFAULT NULL 
;

-- May 27, 2014 10:33:37 PM ICT
ALTER TABLE AD_PrintFormat_Trl ADD CONSTRAINT AD_PrintFormat_Trl_UU_idx UNIQUE (AD_PrintFormat_Trl_UU)
;

-- May 27, 2014 10:33:38 PM ICT
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Column_ID,AD_Table_ID,AD_Client_ID,TreeDisplayedOn) VALUES ('N','N','Y',240,70,'Y','N','N','N','N','Y','N',1,'3c39505a-e38d-495d-aa7e-ce50e02e4208','D','Translate',200143,0,TO_TIMESTAMP('2014-05-27 22:33:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-05-27 22:33:37','YYYY-MM-DD HH24:MI:SS'),100,'Y',211259,200130,0,'B')
;

-- May 27, 2014 10:33:39 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200143,36,'N','N',0,'Y',203039,'N','AD_PrintFormat_Trl_UU','abb5adb7-ba95-4027-9d7c-264ad30d77d3','N','N',100,0,100,TO_TIMESTAMP('2014-05-27 22:33:38','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211271,'D',TO_TIMESTAMP('2014-05-27 22:33:38','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:40 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200143,10,'N','N',10,'Y',203040,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','d35d06cd-dfb8-47a2-b819-71cd095cbf1a','Y','N',100,0,100,TO_TIMESTAMP('2014-05-27 22:33:39','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,2,1,'N','N',211261,'D',TO_TIMESTAMP('2014-05-27 22:33:39','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:41 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200143,10,'N','N',20,'Y',203041,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','a47b16bb-15c7-44cc-a6b0-a522e810a677','Y','N','Y',100,0,100,TO_TIMESTAMP('2014-05-27 22:33:40','YYYY-MM-DD HH24:MI:SS'),'Y','N',4,'N',0,2,1,'N','N',211262,'D',TO_TIMESTAMP('2014-05-27 22:33:40','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:42 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200143,10,'N','N',30,'Y',203042,'N','The print format determines how data is rendered for print.','Data Print Format','Print Format','d77ffb69-faae-4d58-a018-620c84392609','Y','N',100,0,100,TO_TIMESTAMP('2014-05-27 22:33:41','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,2,1,'N','N',211259,'D',TO_TIMESTAMP('2014-05-27 22:33:41','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:43 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200143,6,'N','N',40,'Y',203043,'N','The Language identifies the language to use for display and formatting','Language for this entity','Language','3fe13437-7fd4-4d30-a8f8-7443805ee8c2','Y','N',100,0,100,TO_TIMESTAMP('2014-05-27 22:33:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,1,'N',0,2,1,'N','N',211260,'D',TO_TIMESTAMP('2014-05-27 22:33:42','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:44 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200143,60,'N','N',50,'Y',203044,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name','5ac3896d-d640-471d-b429-9194266e11ee','Y','N',100,0,100,TO_TIMESTAMP('2014-05-27 22:33:43','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,'N',0,5,1,'N','N',211268,'D',TO_TIMESTAMP('2014-05-27 22:33:43','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:45 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200143,255,'N','N',60,'Y',203045,'N','A description is limited to 255 characters.','Optional short description of the record','Description','b4f2d4ad-29d6-4dc8-af15-6156c4bd392e','Y','N',100,0,100,TO_TIMESTAMP('2014-05-27 22:33:44','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,'N',0,5,1,'N','N',211269,'D',TO_TIMESTAMP('2014-05-27 22:33:44','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:45 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200143,1,'N','N',70,'Y',203046,'N','The Translated checkbox indicates if this column is translated.','This column is translated','Translated','3fd4e7d7-ce58-4eae-afc4-daec3090e45b','Y','N',100,0,100,TO_TIMESTAMP('2014-05-27 22:33:45','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,2,'N',0,2,1,'N','N',211270,'D',TO_TIMESTAMP('2014-05-27 22:33:45','YYYY-MM-DD HH24:MI:SS'))
;

-- May 27, 2014 10:33:46 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200143,1,'N','N',80,'Y',203047,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','518eb2fb-6cb8-4963-89d5-2bf0268ba49f','Y','N',100,0,100,TO_TIMESTAMP('2014-05-27 22:33:45','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,5,'N',0,2,1,'N','N',211263,'D',TO_TIMESTAMP('2014-05-27 22:33:45','YYYY-MM-DD HH24:MI:SS'))
;
SELECT register_migration_script('201405271604_IDEMPIERE-1878.sql') FROM dual
;
