-- Aug 7, 2014 6:38:48 PM CEST
-- IDEMPIERE-2127 Country Group Tax Configuration
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,WinHeight,IsBetaFunctionality,WinWidth,EntityType,Name,AD_Window_ID,AD_Window_UU,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,Created,AD_Client_ID) VALUES ('N','M','Y','N',0,'N',0,'D','Country Group',200061,'1fefdef3-761f-4ff3-9c99-08ba46f43960',TO_TIMESTAMP('2014-08-07 18:38:48','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,TO_TIMESTAMP('2014-08-07 18:38:48','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Aug 7, 2014 6:38:49 PM CEST
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Processing,DatabaseViewDrop,EntityType,AD_Org_ID,Created,Updated) VALUES ('N','N','N','7',0,200061,200146,'N','N','N','L','8e6372a8-8d02-4dfe-8a9e-bf0992b1037b','Y','Y','C_CountryGroup','Group of countries that share common needs like tax agreements','Country Group','Y',100,100,0,'N','N','D',0,TO_TIMESTAMP('2014-08-07 18:38:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-08-07 18:38:48','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:49 PM CEST
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID,Created) VALUES ('N',200000,'Y',1000000,'N','Y',200201,'Table C_CountryGroup','C_CountryGroup',1,'98cc9c43-62f7-4c73-adcf-b91f66d18d42',0,100,TO_TIMESTAMP('2014-08-07 18:38:49','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0,TO_TIMESTAMP('2014-08-07 18:38:49','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:50 PM CEST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('C_CountryGroup_ID',202763,'Country Group','Country Group','c268240e-a780-45a0-8cc3-b858e77f03ff',TO_TIMESTAMP('2014-08-07 18:38:49','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-08-07 18:38:49','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:50 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211620,'Y','N','N',0,'N',22,'N','Y','N','Y','3f8d2cde-07a6-4f27-bb3d-f77599d8994d','N','C_CountryGroup_ID','Country Group','N',TO_TIMESTAMP('2014-08-07 18:38:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:50','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202763,13,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:50 PM CEST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,211598,'N','N','N',0,'N',7,'N','N','N','Y','aa502ba8-6b62-4263-9b8c-ffa4e50a5160','Y','DateTo','End date of a date range','The Date To indicates the end date of a range (inclusive)','Date To','Y',TO_TIMESTAMP('2014-08-07 18:38:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:50','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',1582,15,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:50 PM CEST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,211599,'N','N','N',0,'N',7,'N','N','N','Y','69af9075-ec31-4c58-96ff-e8b2fd9f13eb','Y','DateFrom','Starting date for a range','The Date From indicates the starting date of a range.','Date From','Y',TO_TIMESTAMP('2014-08-07 18:38:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:50','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',1581,15,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:50 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211621,'Y','N','N',0,'N',22,'N','N','N','Y','8847c739-4c38-4872-9da7-b3b256f9c5ac','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2014-08-07 18:38:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:50','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADClient_CCountryGroup','N',102,19,200146,129,0,0,'D')
;

-- Aug 7, 2014 6:38:51 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211622,'Y','N','N',0,'N',22,'N','N','N','Y','088dac3e-19aa-49ef-9793-a01e259eefac','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2014-08-07 18:38:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADOrg_CCountryGroup','N',113,19,200146,104,0,0,'D')
;

-- Aug 7, 2014 6:38:51 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211623,'Y','N','N',0,'N',7,'N','N','N','Y','61feacf0-73ec-41d3-9649-65bdde38a0f4','N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2014-08-07 18:38:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',245,16,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:52 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211624,'Y','N','N',0,'N',22,'N','N','N','Y','c490a5da-9df6-47e4-b5b4-32ff4bf8838b','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2014-08-07 18:38:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','CreatedBy_CCountryGroup','N',246,18,110,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:52 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211625,'N','Y','N',0,'N',255,'Y','N','N','Y','81fe86b2-4174-4a0b-8d81-525d41dbd543','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_TIMESTAMP('2014-08-07 18:38:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',275,10,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:53 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211626,'N','N','N',0,'N',2000,'N','N','N','Y','34fe3e99-8149-442c-89ba-2ce90b8ecb43','Y','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',TO_TIMESTAMP('2014-08-07 18:38:53','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:53','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',326,14,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:53 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211627,'Y','N','N',0,'N',1,'N','N','N','Y','537067d3-3fd4-43b6-bc88-b04101036756','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2014-08-07 18:38:53','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:53','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',348,20,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:54 PM CEST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('C_CountryGroup_UU',202764,'C_CountryGroup_UU','C_CountryGroup_UU','d81199f0-55a1-4ffd-9112-6a53490c26c9',TO_TIMESTAMP('2014-08-07 18:38:54','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-08-07 18:38:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:55 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1.00,211628,'N','N','N','N',36,'N','N','N','Y','e47b3289-2a58-410e-9845-15090d5dda2e','Y','C_CountryGroup_UU','C_CountryGroup_UU','N',TO_TIMESTAMP('2014-08-07 18:38:54','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:54','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202764,10,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:55 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211629,'Y','Y','Y',1,'N',60,'Y','N','N','Y','56ad56aa-e287-4499-8417-67a745808e6f','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_TIMESTAMP('2014-08-07 18:38:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:55','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',469,10,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:55 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211630,'Y','N','N',0,'N',7,'N','N','N','Y','885457e7-02cb-425b-a828-5b1663c6089f','N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2014-08-07 18:38:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:55','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',607,16,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:56 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211631,'Y','N','N',0,'N',22,'N','N','N','Y','479b4f1c-aa5f-42f7-b1a6-f2327a9b100a','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2014-08-07 18:38:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:56','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','UpdatedBy_CCountryGroup','N',608,18,110,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:56 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211632,'Y','N','N',0,'N',40,'Y','N','N','Y','aed3744a-e41a-456f-b148-6576d1beb774','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',TO_TIMESTAMP('2014-08-07 18:38:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:56','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',620,10,200146,0,0,'D')
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,OrderByClause,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_Table_ID,Created,TreeDisplayedOn) VALUES ('N','N','Y',200061,10,'N','N','N','N','N','Y','N',0,'c694c2c6-c442-4c9d-82f9-44859442620a','D','Country Group',200156,'C_CountryGroup.Value',0,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,200146,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'B')
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,22,'N','N',0,'Y',203293,'N','Country Group','f5977e11-d585-4044-b46d-db46449ebddc','N','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211620,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,36,'N','N',0,'Y',203294,'N','C_CountryGroup_UU','2077505f-da07-4b44-be11-f24469f3e0b8','N','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211628,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,22,'N','N',10,'Y',203285,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','8af878fa-3c70-4503-aa4c-6d104f35ed2d','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,2,1,'N','N',211621,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,22,'N','N',20,'Y',203286,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','89df9804-fe49-4c48-94fb-6e2135ab8a49','Y','N','Y',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,4,'N',0,2,1,'N','N',211622,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,40,'N','N',30,'Y',203287,'N','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search key for the record in the format required - must be unique','Search Key','65083553-4eca-4c65-8dab-0113bd82bbcc','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,'N',0,2,1,'N','N',211632,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,1,'N','N',40,'Y',203295,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','67ad5233-de90-49e6-b510-fb4d98935d33','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,5,'N',0,2,1,'N','N',211627,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,60,'N','N',50,'Y',203288,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name','da3f4526-7d31-4011-96eb-5192ec2a593a','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,5,1,'N','N',211629,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,255,'N','N',60,'Y',203289,'N','A description is limited to 255 characters.','Optional short description of the record','Description','05d4c8ab-d909-4b13-a576-5db1ba6cdd38','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,1,'N',0,5,1,'N','N',211625,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,2000,'N','N',70,'Y',203290,'N','The Help field contains a hint, comment or help about the use of this item.','Comment or Hint','Comment/Help','b428b4e3-cb60-4bd5-9625-cbc75427c8df','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,1,'N',0,5,3,'N','N',211626,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,7,'N','N',80,'Y',203292,'N','The Date From indicates the starting date of a range.','Starting date for a range','Date From','4600f6d8-344a-4999-90d5-2aab8c32aeea','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,1,'N',0,2,1,'N','N',211599,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200156,7,'N','N',90,'Y',203291,'N','The Date To indicates the end date of a range (inclusive)','End date of a date range','Date To','2ccb27dd-4dcd-4453-9d71-55cb82fa7c2d','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,4,'N',0,2,1,'N','N',211598,'D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Processing,DatabaseViewDrop,EntityType,AD_Org_ID,Created,Updated) VALUES ('N','N','N','7',0,200061,200145,'N','N','N','L','157a6560-c411-4cde-900a-5b371b3c3abf','Y','Y','C_CountryGroupCountry','Country on Country Group','Y',100,100,0,'N','N','D',0,TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:57 PM CEST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('C_CountryGroupCountry_ID',202761,'Country on Country Group','Country on Country Group','37d2ae16-6b4a-4b1f-8479-64a26510d722',TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-08-07 18:38:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211607,'Y','N','N',0,'N',22,'N','Y','N','Y','71d552e8-a97a-4176-85cf-ce065d47ab3f','N','C_CountryGroupCountry_ID','Country on Country Group','N',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202761,13,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211600,'Y','N','N',0,'N',22,'N','N','N','Y','0718d6aa-ad29-4e2c-a7f2-c9a6e8a251b4','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADClient_CCountryGroupCountry','N',102,19,200145,129,0,0,'D')
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211601,'Y','N','N',0,'N',22,'N','N','N','Y','2b7d4ad0-1090-4e90-9eb2-c930fe01ba6b','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADOrg_CCountryGroupCountry','N',113,19,200145,104,0,0,'D')
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211602,'Y','N','N',0,'N',7,'N','N','N','Y','d0ae180d-3c70-49c4-bb15-bc08cf0dbceb','N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',245,16,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211603,'Y','N','N',0,'N',22,'N','N','N','Y','c385e769-88c7-4516-b3d2-cc4ea759a2e1','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','CreatedBy_CCountryGroupCountry','N',246,18,110,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211606,'Y','N','N',0,'N',1,'N','N','N','Y','8d4eed47-2d3a-44ed-9e99-ead3da4f28cb','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',348,20,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('C_CountryGroupCountry_UU',202762,'C_CountryGroupCountry_UU','C_CountryGroupCountry_UU','5ad83282-f9a0-4bc8-be3c-4916c5d409b9',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1.00,211608,'N','N','N','N',36,'N','N','N','Y','96764726-2170-4339-b345-206349ff1cb7','Y','C_CountryGroupCountry_UU','C_CountryGroupCountry_UU','N',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202762,10,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211610,'Y','N','N',0,'N',7,'N','N','N','Y','57d2c555-fc17-4871-a872-c8c0f4afa4ae','N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',607,16,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211611,'Y','N','N',0,'N',22,'N','N','N','Y','9280b039-7813-4684-aa61-4a237a54c260','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','UpdatedBy_CCountryGroupCountry','N',608,18,110,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:58 PM CEST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,211613,'N','N','N',0,'Y',10,'N','N','N','Y','c3270136-bab7-438d-8983-2e9bdc344c2a','N','C_Country_ID','Country ','The Country defines a Country.  Each Country must be defined before it can be used in any document.','Country','Y',TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','CCountry_CCountryGroupCountry','N',192,19,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,211615,'N','N','N',0,'Y',22,'N','N','N','Y','199cbfaa-9159-4444-9273-bf4b680b8b33','N','C_CountryGroup_ID','Country Group','N',TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','CCountryGroup_CCountryGroupCou','N',202763,19,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,211616,'N','N','N',0,'N',7,'N','N','N','Y','f9637306-8156-44c2-b1af-4c4e422d1321','Y','DateFrom','Starting date for a range','The Date From indicates the starting date of a range.','Date From','Y',TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',1581,15,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,211617,'N','N','N',0,'N',7,'N','N','N','Y','7fdb1dfb-e8f7-4f38-b7ae-b53242db29b3','Y','DateTo','End date of a date range','The Date To indicates the end date of a range (inclusive)','Date To','Y',TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',1582,15,200145,0,0,'D')
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_Column_ID,AD_Table_ID,Created,TreeDisplayedOn) VALUES ('N','N','Y',200061,20,'N','N','N','N','N','Y','N',1,'d987304b-12d1-484b-bcc2-49bb3bf8e94e','D','Country',200157,0,100,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,211615,200145,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),'B')
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200157,22,'N','N',0,'Y',203298,'N','Country on Country Group','a7613070-e5e5-40e7-bd5b-cbd2f423f5d6','N','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211607,'D',0,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200157,36,'N','N',0,'Y',203299,'N','C_CountryGroupCountry_UU','ec70be5c-b23b-4d9f-a539-866070732d1d','N','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211608,'D',0,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200157,22,'N','N',10,'Y',203296,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','0ba04afe-1c86-42b7-8b96-e64da1ddd1c7','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,2,1,'N','N',211600,'D',0,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200157,22,'N','N',20,'Y',203297,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','9ae4e778-7d80-48f3-b346-04a535a42c06','Y','N','Y',100,100,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,4,'N',0,2,1,'N','N',211601,'D',0,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200157,22,'N','N',30,'Y',203301,'N','Country Group','9067b557-c5cb-436f-990a-9e594abbdf8b','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,2,1,'N','N',211615,'D',0,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200157,10,'N','N',40,'Y',203300,'N','The Country defines a Country.  Each Country must be defined before it can be used in any document.','Country ','Country','9372ca61-92ec-4422-98a7-b5161d823ec5','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,'N',0,2,1,'N','N',211613,'D',0,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200157,7,'N','N',50,'Y',203302,'N','The Date From indicates the starting date of a range.','Starting date for a range','Date From','04a07e2b-119f-47ed-8495-59648d1094e8','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,1,'N',0,2,1,'N','N',211616,'D',0,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200157,7,'N','N',60,'Y',203303,'N','The Date To indicates the end date of a range (inclusive)','End date of a date range','Date To','b0bc259c-9c0b-49f2-9e43-9832994364e9','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,4,'N',0,2,1,'N','N',211617,'D',0,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:38:59 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200157,1,'N','N',70,'Y',203304,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','14f6cc2a-add6-4081-a9bd-9ab83b56612a','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,2,'N',0,2,1,'N','N',211606,'D',0,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:00 PM CEST
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Processing,DatabaseViewDrop,EntityType,AD_Org_ID,Created,Updated) VALUES ('N','N','N','7',0,200061,200147,'N','N','N','L','ccc44ed4-1591-4cc4-a327-74ba658bbce1','Y','Y','C_CountryGroup_Trl','Country Group Translation','Y',100,100,0,'N','N','D',0,TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-08-07 18:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:00 PM CEST
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID,Created) VALUES ('N',200000,'Y',1000000,'N','Y',200202,'Table C_CountryGroup_Trl','C_CountryGroup_Trl',1,'09cc848a-8a1f-41ba-bf84-c788973a36ba',0,100,TO_TIMESTAMP('2014-08-07 18:39:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0,TO_TIMESTAMP('2014-08-07 18:39:00','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:01 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211633,'Y','N','N',0,'N',22,'N','N','N','Y','b49ac5ee-a053-4e89-b5cd-c78c3c3b2095','N','AD_Client_ID','Client/Tenant for this installation.','@AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2014-08-07 18:39:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:00','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADClient_CCountryGroupTrl','N',102,19,200147,129,0,0,'D')
;

-- Aug 7, 2014 6:39:01 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211634,'Y','N','N',0,'Y',6,'N','N','N','Y','652b9dd4-7bc0-40f5-85ee-e43b9e250146','N','AD_Language','Language for this entity','The Language identifies the language to use for display and formatting','Language','Y',TO_TIMESTAMP('2014-08-07 18:39:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:01','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADLanguage_CCountryGroupTrl','N',109,18,106,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:01 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211635,'Y','N','N',0,'N',22,'N','N','N','Y','b53845b0-ad6e-470a-b68f-28accd8fe0d8','N','AD_Org_ID','Organizational entity within client','@AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2014-08-07 18:39:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:01','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','ADOrg_CCountryGroupTrl','N',113,19,200147,104,0,0,'D')
;

-- Aug 7, 2014 6:39:02 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211636,'Y','N','N',0,'Y',22,'N','N','N','Y','13e887b1-aa07-40be-a08e-8854cc304506','N','C_CountryGroup_ID','Country Group','Y',TO_TIMESTAMP('2014-08-07 18:39:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','CCountryGroup_CCountryGroupTrl','N',202763,19,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:02 PM CEST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('C_CountryGroup_Trl_UU',202765,'C_CountryGroup_Trl_UU','C_CountryGroup_Trl_UU','e2cd0f07-1865-42d8-8fe4-6c3d15dae86d',TO_TIMESTAMP('2014-08-07 18:39:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-08-07 18:39:02','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:03 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1.00,211637,'N','N','N','N',36,'N','N','N','Y','10bd517d-08c1-4141-8a2b-cd5edbf7c5d6','Y','C_CountryGroup_Trl_UU','C_CountryGroup_Trl_UU','N',TO_TIMESTAMP('2014-08-07 18:39:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',202765,10,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:03 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211638,'Y','N','N',0,'N',7,'N','N','N','Y','360f484a-7933-444c-a044-2e44979dc2d0','N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2014-08-07 18:39:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',245,16,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:04 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211639,'Y','N','N',0,'N',22,'N','N','N','Y','01c68652-33cd-4ec3-9bdc-e0fb3ccccc3a','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2014-08-07 18:39:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','CreatedBy_CCountryGroupTrl','N',246,18,110,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:04 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211640,'N','N','N',0,'N',255,'Y','N','N','Y','96d24f5d-c2a9-4952-bb6e-5f79084ed44b','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_TIMESTAMP('2014-08-07 18:39:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',275,10,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:05 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211641,'Y','N','N',0,'N',1,'N','N','N','Y','0843107f-9948-44dd-9d3d-0f7214bf090b','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2014-08-07 18:39:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',348,20,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:05 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211642,'Y','N','N',0,'N',1,'N','N','N','Y','59d98f6f-f37b-4b79-9523-cbcacdae8cef','Y','IsTranslated','This column is translated','The Translated checkbox indicates if this column is translated.','Translated','Y',TO_TIMESTAMP('2014-08-07 18:39:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',420,20,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:06 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',0,211643,'Y','N','Y',1,'N',60,'Y','N','N','Y','9e8e7e13-19ec-41ee-8a89-204510adedcf','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_TIMESTAMP('2014-08-07 18:39:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',469,10,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:06 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211644,'Y','N','N',0,'N',7,'N','N','N','Y','64015714-627c-4e45-a384-54f3e09c4e73','N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2014-08-07 18:39:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',607,16,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:08 PM CEST
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('Y',1,211645,'Y','N','N',0,'N',22,'N','N','N','Y','3cacf747-5d2a-432c-a9c9-52726c3c907f','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2014-08-07 18:39:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','UpdatedBy_CCountryGroupTrl','N',608,18,110,200147,0,0,'D')
;

-- Aug 7, 2014 6:39:08 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop) VALUES (0,0,201027,'93ab7d69-fc17-497b-a39f-c3fa5f7e07a3',TO_TIMESTAMP('2014-08-07 18:39:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CountryGroup_Trl_pkey',TO_TIMESTAMP('2014-08-07 18:39:08','YYYY-MM-DD HH24:MI:SS'),100,200147,'Y','Y','N','N')
;

-- Aug 7, 2014 6:39:09 PM CEST
INSERT INTO AD_IndexColumn (CreatedBy,AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,IsActive,Updated,UpdatedBy,SeqNo,AD_Column_ID,AD_TableIndex_ID,EntityType) VALUES (100,0,0,201250,'417a6858-e3ab-40a8-8b25-8dca6f64b42c',TO_TIMESTAMP('2014-08-07 18:39:09','YYYY-MM-DD HH24:MI:SS'),'Y',TO_TIMESTAMP('2014-08-07 18:39:09','YYYY-MM-DD HH24:MI:SS'),100,1,211634,201027,'D')
;

-- Aug 7, 2014 6:39:10 PM CEST
INSERT INTO AD_IndexColumn (CreatedBy,AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,IsActive,Updated,UpdatedBy,SeqNo,AD_Column_ID,AD_TableIndex_ID,EntityType) VALUES (100,0,0,201251,'3456398d-1a41-4725-9daa-6e1373ff37a1',TO_TIMESTAMP('2014-08-07 18:39:09','YYYY-MM-DD HH24:MI:SS'),'Y',TO_TIMESTAMP('2014-08-07 18:39:09','YYYY-MM-DD HH24:MI:SS'),100,2,211636,201027,'D')
;

-- Aug 7, 2014 6:39:10 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing) VALUES (0,0,201028,'cd6fa779-8b02-4051-b351-3318aaf0b7e8',TO_TIMESTAMP('2014-08-07 18:39:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','c_countrygroup_trl_uu_idx',TO_TIMESTAMP('2014-08-07 18:39:10','YYYY-MM-DD HH24:MI:SS'),100,200147,'N','Y','N')
;

-- Aug 7, 2014 6:39:11 PM CEST
INSERT INTO AD_IndexColumn (CreatedBy,AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,IsActive,Updated,UpdatedBy,SeqNo,AD_Column_ID,AD_TableIndex_ID,EntityType) VALUES (100,0,0,201252,'fa6fbb6b-43ef-48a6-b583-e796e55453a8',TO_TIMESTAMP('2014-08-07 18:39:10','YYYY-MM-DD HH24:MI:SS'),'Y',TO_TIMESTAMP('2014-08-07 18:39:10','YYYY-MM-DD HH24:MI:SS'),100,1,211637,201028,'D')
;

-- Aug 7, 2014 6:39:11 PM CEST
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_Column_ID,AD_Table_ID,Created,TreeDisplayedOn) VALUES ('N','N','Y',200061,30,'Y','N','N','N','N','Y','N',1,'7dc48a85-da2d-4fad-b05f-2b5ba0fbee94','D','Translation',200159,0,100,TO_TIMESTAMP('2014-08-07 18:39:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,211636,200147,TO_TIMESTAMP('2014-08-07 18:39:11','YYYY-MM-DD HH24:MI:SS'),'B')
;

-- Aug 7, 2014 6:39:12 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200159,22,'N','N',10,'Y',203316,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','3e75db5a-bbfd-4cb5-9a49-1e712fb062d2','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:11','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,2,1,'N','N',211633,'D',0,TO_TIMESTAMP('2014-08-07 18:39:11','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:12 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200159,22,'N','N',20,'Y',203317,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','f48bd143-45c8-40b3-a7f7-965b145a2c76','Y','N','Y',100,100,TO_TIMESTAMP('2014-08-07 18:39:12','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,4,'N',0,2,1,'N','N',211635,'D',0,TO_TIMESTAMP('2014-08-07 18:39:12','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:12 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200159,60,'N','N',30,'Y',203318,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name','5a4ff117-38e3-4ba8-a3ad-251bddec52b4','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:12','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,'N',0,5,1,'N','N',211643,'D',0,TO_TIMESTAMP('2014-08-07 18:39:12','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:13 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200159,255,'N','N',40,'Y',203319,'N','A description is limited to 255 characters.','Optional short description of the record','Description','be90691d-c53f-42ee-9325-9f3cc6c22240','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:12','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,5,1,'N','N',211640,'D',0,TO_TIMESTAMP('2014-08-07 18:39:12','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:13 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200159,6,'N','N',50,'Y',203320,'N','The Language identifies the language to use for display and formatting','Language for this entity','Language','f5121598-342a-4746-b8ad-22075d49f8a6','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:13','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,1,'N',0,2,1,'N','N',211634,'D',0,TO_TIMESTAMP('2014-08-07 18:39:13','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:14 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200159,22,'N','N',60,'Y',203321,'N','Country Group','a5b6a4bd-2b32-4b57-8a82-ad6292b79748','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:13','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,1,'N',0,2,1,'N','N',211636,'D',0,TO_TIMESTAMP('2014-08-07 18:39:13','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:14 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200159,1,'N','N',70,'Y',203322,'N','The Translated checkbox indicates if this column is translated.','This column is translated','Translated','fa57bf23-0c47-45dc-844b-a38222674d69','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:14','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,2,'N',0,2,1,'N','N',211642,'D',0,TO_TIMESTAMP('2014-08-07 18:39:14','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:15 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200159,1,'N','N',80,'Y',203323,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','66743757-2e55-468e-bc3d-11adea51ca09','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:14','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,2,'N',0,2,1,'N','N',211641,'D',0,TO_TIMESTAMP('2014-08-07 18:39:14','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:15 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200159,36,'N','N','Y',203324,'N','C_CountryGroup_Trl_UU','a8bf97c1-2ef3-4eea-b8df-6f73982510b1','N','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211637,'D',0,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:15 PM CEST
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_Column_ID,AD_Table_ID,Created,TreeDisplayedOn) VALUES ('N','N','Y',122,50,'N','N','N','N','N','Y','N',1,'fcd8431f-3d9a-4097-a91a-55ef9c54ee2a','D','Country Group',200158,0,100,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,211613,200145,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'),'B')
;

-- Aug 7, 2014 6:39:15 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200158,22,'N','N',0,'Y',203307,'N','Country on Country Group','73024efc-a669-4b32-868d-d79a656dea4b','N','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211607,'D',0,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:15 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200158,36,'N','N',0,'Y',203308,'N','C_CountryGroupCountry_UU','2681a64e-a63a-46d3-b849-1baa617ad0e6','N','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211608,'D',0,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:15 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200158,22,'N','N',10,'Y',203305,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','ecad6fdf-6991-418d-b689-ae4f19aad1ce','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,2,1,'N','N',211600,'D',0,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:15 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200158,22,'N','N',20,'Y',203306,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','8bc8f860-7ab6-41c2-a51b-d6e8811c3d39','Y','N','Y',100,100,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,4,'N',0,2,1,'N','N',211601,'D',0,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:15 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200158,10,'N','N',30,'Y',203309,'N','The Country defines a Country.  Each Country must be defined before it can be used in any document.','Country ','Country','9a72ecb0-8ac7-4d0f-8ff3-f5852563658f','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,'N',0,2,1,'N','N',211613,'D',0,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:15 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200158,22,'N','N',40,'Y',203310,'N','Country Group','4b27ebb4-6596-451e-b527-14517f8c0b99','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,2,1,'N','N',211615,'D',0,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:16 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200158,7,'N','N',50,'Y',203311,'N','The Date From indicates the starting date of a range.','Starting date for a range','Date From','f5343571-b422-45ab-a929-e9946c3690d1','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,1,'N',0,2,1,'N','N',211616,'D',0,TO_TIMESTAMP('2014-08-07 18:39:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:16 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200158,7,'N','N',60,'Y',203312,'N','The Date To indicates the end date of a range (inclusive)','End date of a date range','Date To','f724213a-b8a1-4d21-98e0-51cd473c37c5','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:16','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,4,'N',0,2,1,'N','N',211617,'D',0,TO_TIMESTAMP('2014-08-07 18:39:16','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:16 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200158,1,'N','N',70,'Y',203313,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','b1961e83-12bc-4937-926f-98a05aa7285c','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:16','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,2,'N',0,2,1,'N','N',211606,'D',0,TO_TIMESTAMP('2014-08-07 18:39:16','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:16 PM CEST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('C_CountryGroupTo_ID',202766,'Country Group To','Country Group To','cbd9493a-d0ce-498d-b678-617a78d579bb',TO_TIMESTAMP('2014-08-07 18:39:16','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-08-07 18:39:16','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:16 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Org_ID,CreatedBy,Updated,IsActive,UpdatedBy,AD_Client_ID,Created) VALUES (200092,'Country Group','D','735c864d-d595-4a2c-8b66-48ae13b42fb5','N','T',0,100,TO_TIMESTAMP('2014-08-07 18:39:16','YYYY-MM-DD HH24:MI:SS'),'Y',100,0,TO_TIMESTAMP('2014-08-07 18:39:16','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:17 PM CEST
INSERT INTO AD_Ref_Table (IsValueDisplayed,OrderByClause,AD_Ref_Table_UU,CreatedBy,Updated,UpdatedBy,AD_Org_ID,IsActive,AD_Client_ID,EntityType,AD_Display,AD_Key,AD_Reference_ID,AD_Table_ID,Created) VALUES ('Y','Value','8b8f1fc0-89a7-45b8-838f-8bbd7aa3ecc7',100,TO_TIMESTAMP('2014-08-07 18:39:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',0,'D',211629,211620,200092,200146,TO_TIMESTAMP('2014-08-07 18:39:17','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:17 PM CEST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,211646,'N','N','N',0,'N',10,'N','N','N','Y','2189127b-a51a-4101-91b1-a941310e5b07','Y','C_CountryGroupTo_ID','Country Group To','Y',TO_TIMESTAMP('2014-08-07 18:39:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','CCountryGroupTo_CTax','N',202766,18,200092,261,0,0,'D')
;

-- Aug 7, 2014 6:39:17 PM CEST
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('C_CountryGroupFrom_ID',202767,'Country Group From','Country Group From','0d390d89-829a-4672-8a67-b8454caee632',TO_TIMESTAMP('2014-08-07 18:39:17','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-08-07 18:39:17','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:18 PM CEST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'Y',0,211647,'N','N','N',0,'N',10,'N','N','N','Y','5675bb26-cc09-4982-9a4b-89cb3a51d730','Y','C_CountryGroupFrom_ID','Country Group From','Y',TO_TIMESTAMP('2014-08-07 18:39:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-08-07 18:39:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','CCountryGroupFrom_CTax','N',202767,18,200092,261,0,0,'D')
;

-- Aug 7, 2014 6:39:18 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',174,10,'N','N',182,'Y',203325,'N','Country Group From','eaee3a9c-d5d6-4b04-bc47-8ea18ddcdd9f','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:18','YYYY-MM-DD HH24:MI:SS'),'Y','Y',260,1,'N',0,2,1,'N','N',211647,'D',0,TO_TIMESTAMP('2014-08-07 18:39:18','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:19 PM CEST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',174,10,'N','N',184,'Y',203326,'N','Country Group To','44dc0c91-def6-4eb3-9f9a-90dbe460dc65','Y','N',100,100,TO_TIMESTAMP('2014-08-07 18:39:19','YYYY-MM-DD HH24:MI:SS'),'Y','Y',250,4,'N',0,2,1,'N','N',211646,'D',0,TO_TIMESTAMP('2014-08-07 18:39:19','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:20 PM CEST
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,"action",IsActive,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES (200061,200093,'N','N','N','D','Y','Country Group','1379437f-5644-4265-9c61-d93dbb3cf921','W','Y',100,TO_TIMESTAMP('2014-08-07 18:39:19','YYYY-MM-DD HH24:MI:SS'),100,0,0,TO_TIMESTAMP('2014-08-07 18:39:19','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 7, 2014 6:39:20 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 161,16, 10, 200093)
;

-- Aug 8, 2014 9:05:27 AM CEST
CREATE TABLE C_CountryGroup (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_CountryGroup_ID NUMERIC(10) NOT NULL, C_CountryGroup_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL, CreatedBy NUMERIC(10) NOT NULL, DateFrom TIMESTAMP DEFAULT NULL , DateTo TIMESTAMP DEFAULT NULL , Description VARCHAR(255) DEFAULT NULL , Help VARCHAR(2000) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, Value VARCHAR(40) NOT NULL, CONSTRAINT C_CountryGroup_Key PRIMARY KEY (C_CountryGroup_ID), CONSTRAINT C_CountryGroup_UU_idx UNIQUE (C_CountryGroup_UU))
;

-- Aug 8, 2014 9:05:28 AM CEST
ALTER TABLE C_CountryGroup ADD CONSTRAINT ADClient_CCountryGroup FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:05:28 AM CEST
ALTER TABLE C_CountryGroup ADD CONSTRAINT ADOrg_CCountryGroup FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:05:28 AM CEST
ALTER TABLE C_CountryGroup ADD CONSTRAINT CreatedBy_CCountryGroup FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:05:28 AM CEST
ALTER TABLE C_CountryGroup ADD CONSTRAINT UpdatedBy_CCountryGroup FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:16 AM CEST
CREATE TABLE C_CountryGroupCountry (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_CountryGroupCountry_ID NUMERIC(10) NOT NULL, C_CountryGroupCountry_UU VARCHAR(36) DEFAULT NULL , C_CountryGroup_ID NUMERIC(10) DEFAULT NULL , C_Country_ID NUMERIC(10) DEFAULT NULL , Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL, CreatedBy NUMERIC(10) NOT NULL, DateFrom TIMESTAMP DEFAULT NULL , DateTo TIMESTAMP DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_CountryGroupCountry_Key PRIMARY KEY (C_CountryGroupCountry_ID), CONSTRAINT C_CountryGroupCountry_UU_idx UNIQUE (C_CountryGroupCountry_UU))
;

-- Aug 8, 2014 9:06:16 AM CEST
ALTER TABLE C_CountryGroupCountry ADD CONSTRAINT ADClient_CCountryGroupCountry FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:16 AM CEST
ALTER TABLE C_CountryGroupCountry ADD CONSTRAINT ADOrg_CCountryGroupCountry FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:16 AM CEST
ALTER TABLE C_CountryGroupCountry ADD CONSTRAINT CCountryGroup_CCountryGroupCou FOREIGN KEY (C_CountryGroup_ID) REFERENCES c_countrygroup(c_countrygroup_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:16 AM CEST
ALTER TABLE C_CountryGroupCountry ADD CONSTRAINT CCountry_CCountryGroupCountry FOREIGN KEY (C_Country_ID) REFERENCES c_country(c_country_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:16 AM CEST
ALTER TABLE C_CountryGroupCountry ADD CONSTRAINT CreatedBy_CCountryGroupCountry FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:16 AM CEST
ALTER TABLE C_CountryGroupCountry ADD CONSTRAINT UpdatedBy_CCountryGroupCountry FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:52 AM CEST
CREATE TABLE C_CountryGroup_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_CountryGroup_ID NUMERIC(10) NOT NULL, C_CountryGroup_Trl_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_CountryGroup_Trl_UU_idx UNIQUE (C_CountryGroup_Trl_UU))
;

-- Aug 8, 2014 9:06:52 AM CEST
ALTER TABLE C_CountryGroup_Trl ADD CONSTRAINT ADClient_CCountryGroupTrl FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:52 AM CEST
ALTER TABLE C_CountryGroup_Trl ADD CONSTRAINT ADLanguage_CCountryGroupTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:52 AM CEST
ALTER TABLE C_CountryGroup_Trl ADD CONSTRAINT ADOrg_CCountryGroupTrl FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:52 AM CEST
ALTER TABLE C_CountryGroup_Trl ADD CONSTRAINT CCountryGroup_CCountryGroupTrl FOREIGN KEY (C_CountryGroup_ID) REFERENCES c_countrygroup(c_countrygroup_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:52 AM CEST
ALTER TABLE C_CountryGroup_Trl ADD CONSTRAINT CreatedBy_CCountryGroupTrl FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:06:52 AM CEST
ALTER TABLE C_CountryGroup_Trl ADD CONSTRAINT UpdatedBy_CCountryGroupTrl FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:07:04 AM CEST
ALTER TABLE C_CountryGroup_Trl ADD CONSTRAINT C_CountryGroup_Trl_pkey PRIMARY KEY (AD_Language,C_CountryGroup_ID)
;

-- Aug 8, 2014 9:07:41 AM CEST
ALTER TABLE C_Tax ADD COLUMN C_CountryGroupFrom_ID NUMERIC(10) DEFAULT NULL 
;

-- Aug 8, 2014 9:07:42 AM CEST
ALTER TABLE C_Tax ADD CONSTRAINT CCountryGroupFrom_CTax FOREIGN KEY (C_CountryGroupFrom_ID) REFERENCES c_countrygroup(c_countrygroup_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 9:07:49 AM CEST
ALTER TABLE C_Tax ADD COLUMN C_CountryGroupTo_ID NUMERIC(10) DEFAULT NULL 
;

-- Aug 8, 2014 9:07:50 AM CEST
ALTER TABLE C_Tax ADD CONSTRAINT CCountryGroupTo_CTax FOREIGN KEY (C_CountryGroupTo_ID) REFERENCES c_countrygroup(c_countrygroup_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 8, 2014 10:02:42 AM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2014-08-08 10:02:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203325
;

-- Aug 8, 2014 10:02:42 AM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2014-08-08 10:02:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203326
;

-- Aug 8, 2014 10:02:42 AM CEST
UPDATE AD_Field SET SeqNo=200, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2014-08-08 10:02:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=974
;

-- Aug 8, 2014 10:02:42 AM CEST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2014-08-08 10:02:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=976
;

-- Aug 8, 2014 10:02:42 AM CEST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2014-08-08 10:02:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=975
;

-- Aug 8, 2014 10:02:42 AM CEST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2014-08-08 10:02:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=977
;

-- Aug 8, 2014 10:02:42 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-08-08 10:02:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202401
;

-- Aug 8, 2014 10:03:48 AM CEST
UPDATE AD_Field SET IsCentrallyMaintained='N', Name='Country Group',Updated=TO_TIMESTAMP('2014-08-08 10:03:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203325
;

-- Aug 8, 2014 10:04:01 AM CEST
UPDATE AD_Field SET IsCentrallyMaintained='N', Name='To',Updated=TO_TIMESTAMP('2014-08-08 10:04:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203326
;

-- Aug 8, 2014 10:04:39 AM CEST
UPDATE AD_Field SET ReadOnlyLogic='@C_Country_ID@>0',Updated=TO_TIMESTAMP('2014-08-08 10:04:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203325
;

-- Aug 8, 2014 10:04:47 AM CEST
UPDATE AD_Field SET ReadOnlyLogic='@C_CountryGroupFrom_ID@>0',Updated=TO_TIMESTAMP('2014-08-08 10:04:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=974
;

-- Aug 8, 2014 10:05:10 AM CEST
UPDATE AD_Field SET ReadOnlyLogic='@To_Country_ID@>0',Updated=TO_TIMESTAMP('2014-08-08 10:05:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203326
;

-- Aug 8, 2014 10:05:16 AM CEST
UPDATE AD_Field SET ReadOnlyLogic='@C_CountryGroupTo_ID@>0',Updated=TO_TIMESTAMP('2014-08-08 10:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=976
;

-- Aug 8, 2014 10:13:23 AM CEST
UPDATE AD_Ref_Table SET OrderByClause='C_CountryGroup.Value',Updated=TO_TIMESTAMP('2014-08-08 10:13:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200092
;

-- Aug 3, 2014 11:51:36 AM CEST
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID,Created) VALUES ('N',200000,'Y',1000000,'N','Y',200200,'Table C_CountryGroupCountry','C_CountryGroupCountry',1,'1289bea1-9e97-412d-bf5e-108f6e9a7bee',0,100,TO_TIMESTAMP('2014-08-03 11:51:34','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0,TO_TIMESTAMP('2014-08-03 11:51:34','YYYY-MM-DD HH24:MI:SS'))
;

SELECT register_migration_script('201408071840_IDEMPIERE-2127.sql') FROM dual
;

