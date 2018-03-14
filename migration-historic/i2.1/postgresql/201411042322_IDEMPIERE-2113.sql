-- Oct 29, 2014 7:34:07 PM COT
-- IDEMPIERE-2113 Enable import button for end users
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,WinHeight,IsBetaFunctionality,WinWidth,EntityType,Name,AD_Window_ID,AD_Window_UU,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,AD_Client_ID,Created) VALUES ('N','M','Y','N',0,'N',0,'D','Import Template',200063,'4e7ba78d-2a32-410f-8d8a-f1cdf7169421',TO_TIMESTAMP('2014-10-29 19:34:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,0,TO_TIMESTAMP('2014-10-29 19:34:06','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:34:22 PM COT
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Processing,DatabaseViewDrop,EntityType,AD_Org_ID,Created,Updated) VALUES ('N','N','N','7',0,200063,200153,'N','N','Y','L','9ca97d7d-d28e-4dd1-9204-9fcec7dddeb1','Y','Y','AD_ImportTemplate','Import Template','Y',100,100,0,'N','N','D',0,TO_TIMESTAMP('2014-10-29 19:34:22','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-10-29 19:34:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:34:23 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,CreatedBy,UpdatedBy,Updated,IsActive,StartNo,AD_Client_ID,Created) VALUES ('N',200000,'Y',1000000,'N','Y',200209,'Table AD_ImportTemplate','AD_ImportTemplate',1,'701ace15-f75d-42ef-8019-7c90221a9c52',0,100,100,TO_TIMESTAMP('2014-10-29 19:34:22','YYYY-MM-DD HH24:MI:SS'),'Y',1000000,0,TO_TIMESTAMP('2014-10-29 19:34:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:38:46 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES ('N',1,211767,'Y','N','N','N',22,'N','N','N','Y','a68d2cca-d10b-4449-a3a3-f923b964e469','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2014-10-29 19:38:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:45','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',102,19,200153,129,0,0,'D','N')
;

-- Oct 29, 2014 7:38:46 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES ('N',1,211768,'Y','N','N','N',22,'N','N','N','Y','19c0a6f0-7403-4b08-8e17-e8eb6c6a9fe6','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2014-10-29 19:38:46','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:46','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',113,19,200153,104,0,0,'D','N')
;

-- Oct 29, 2014 7:38:46 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('AD_ImportTemplate_ID',202793,'Import Template','Import Template','1e789d85-c0ca-4e42-991a-4c8c7bbe72ce',TO_TIMESTAMP('2014-10-29 19:38:46','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-10-29 19:38:46','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:38:47 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('N',1,211769,'Y','N','N','N',22,'N','Y','N','Y','f5f11211-e9cf-479a-9cd5-a43c57e4bc26','N','AD_ImportTemplate_ID','Import Template','N',TO_TIMESTAMP('2014-10-29 19:38:46','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:46','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202793,13,200153,0,0,'D')
;

-- Oct 29, 2014 7:38:47 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('AD_ImportTemplate_UU',202794,'AD_ImportTemplate_UU','AD_ImportTemplate_UU','93e7a635-c727-40fa-98b0-4704d07daba5',TO_TIMESTAMP('2014-10-29 19:38:47','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-10-29 19:38:47','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:38:47 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('N',1.00,211770,'N','N','N','N',36,'N','N','N','Y','55879be1-dd16-465e-b262-0e48056995e5','Y','AD_ImportTemplate_UU','AD_ImportTemplate_UU','N',TO_TIMESTAMP('2014-10-29 19:38:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:47','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202794,10,200153,0,0,'D')
;

-- Oct 29, 2014 7:38:47 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('N',1,211771,'Y','N','N','N',7,'N','N','N','Y','c177ec13-08ac-4dac-8d47-0f4a5677cb94','N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2014-10-29 19:38:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:47','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',245,16,200153,0,0,'D')
;

-- Oct 29, 2014 7:38:48 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('N',1,211772,'Y','N','N','N',22,'N','N','N','Y','4b2fa6e3-ba3d-4600-9da7-84292abf5f92','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2014-10-29 19:38:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:47','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',246,18,110,200153,0,0,'D')
;

-- Oct 29, 2014 7:38:48 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('N',1,211773,'N','N','N','N',255,'Y','N','N','Y','b7a246ce-3610-4177-b400-8afb46d75042','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_TIMESTAMP('2014-10-29 19:38:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',275,10,200153,0,0,'D')
;

-- Oct 29, 2014 7:38:48 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('N',1,211774,'Y','N','N','N',1,'N','N','N','Y','90fc3332-1b46-438e-9331-fc6a1412efa0','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2014-10-29 19:38:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',348,20,200153,0,0,'D')
;

-- Oct 29, 2014 7:38:49 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('N',1,211775,'Y','N','Y',1,'N',60,'Y','N','N','Y','29facf3f-e3b8-4278-a338-3cdbc10f66e8','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_TIMESTAMP('2014-10-29 19:38:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',469,10,200153,0,0,'D')
;

-- Oct 29, 2014 7:38:49 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('N',1,211776,'Y','N','N','N',7,'N','N','N','Y','b30444f7-2e96-4d4a-8943-419825051492','N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2014-10-29 19:38:49','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:49','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',607,16,200153,0,0,'D')
;

-- Oct 29, 2014 7:38:49 PM COT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES ('N',1,211777,'Y','N','N','N',22,'N','N','N','Y','3414a680-d4f5-42f4-9e81-0f1ff12d4d7c','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2014-10-29 19:38:49','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:38:49','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',608,18,110,200153,0,0,'D')
;

-- Oct 29, 2014 7:39:56 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211778,'N','N','N',0,'N',22,'N','N','N','Y','a301bc32-f6af-42da-848b-41b15d0dd8dc','Y','AD_Window_ID','Data entry or display window','The Window field identifies a unique Window in the system.','Window','Y',TO_TIMESTAMP('2014-10-29 19:39:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:39:55','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',143,19,200153,0,0,'D','N')
;

-- Oct 29, 2014 7:40:07 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211779,'N','N','N',0,'N',10,'N','N','N','Y','c7469d2b-f38e-4860-b42d-6a1c92a27b29','Y','AD_Tab_ID','Tab within a Window','The Tab indicates a tab that displays within a window.','Tab','Y',TO_TIMESTAMP('2014-10-29 19:40:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:40:07','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',125,19,200153,163,0,0,'D','N')
;

-- Oct 29, 2014 7:40:56 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('CharacterSet',202795,'Character Set','Character Set','d143d958-7f99-4be3-9f19-8d0012d9b7d7',TO_TIMESTAMP('2014-10-29 19:40:55','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-10-29 19:40:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:41:40 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'N',0,211780,'N','N','N',0,'N',20,'N','N','N','Y','1240cae1-0d8d-4306-b6d6-df18cc918d9a','Y','CharacterSet','Character Set','Y',TO_TIMESTAMP('2014-10-29 19:41:39','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:41:39','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202795,10,200153,0,0,'D')
;

-- Oct 29, 2014 7:42:32 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('CSVHeader',202796,'CSV Header','CSV Header','ebb82ae8-73ad-479a-9859-b7a45dd72259',TO_TIMESTAMP('2014-10-29 19:42:31','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-10-29 19:42:31','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:42:45 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'N',0,211781,'N','N','N',0,'N',2000,'N','N','N','Y','ebec370b-ef9f-41c0-9728-37ec364077ff','Y','CSVHeader','CSV Header','Y',TO_TIMESTAMP('2014-10-29 19:42:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:42:45','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202796,10,200153,0,0,'D')
;

-- Oct 29, 2014 7:43:12 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('CSVAliasHeader',202797,'CSV Alias Header','CSV Alias Header','f38e026b-28e5-46f7-bcef-f9148b2014dc',TO_TIMESTAMP('2014-10-29 19:43:11','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-10-29 19:43:11','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:43:25 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211782,'N','N','N',0,'N',2000,'N','N','N','Y','727ce74b-2c18-49ce-a5e0-c42812a1d20c','Y','CSVAliasHeader','CSV Alias Header','Y',TO_TIMESTAMP('2014-10-29 19:43:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:43:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202797,10,200153,0,0,'D','N')
;

-- Oct 29, 2014 7:43:42 PM COT
UPDATE AD_Column SET FKConstraintName='ADClient_ADImportTemplate', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:43:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211767
;

-- Oct 29, 2014 7:43:42 PM COT
UPDATE AD_Column SET FKConstraintName='ADOrg_ADImportTemplate', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:43:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211768
;

-- Oct 29, 2014 7:43:42 PM COT
UPDATE AD_Column SET FKConstraintName='ADTab_ADImportTemplate', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:43:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211779
;

-- Oct 29, 2014 7:43:42 PM COT
UPDATE AD_Column SET FKConstraintName='ADWindow_ADImportTemplate', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:43:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211778
;

-- Oct 29, 2014 7:43:43 PM COT
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADImportTemplate', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211772
;

-- Oct 29, 2014 7:43:43 PM COT
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADImportTemplate', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211777
;

-- Oct 29, 2014 7:43:43 PM COT
CREATE TABLE AD_ImportTemplate (AD_Client_ID NUMERIC(10) NOT NULL, AD_ImportTemplate_ID NUMERIC(10) NOT NULL, AD_ImportTemplate_UU VARCHAR(36) DEFAULT NULL , AD_Org_ID NUMERIC(10) NOT NULL, AD_Tab_ID NUMERIC(10) DEFAULT NULL , AD_Window_ID NUMERIC(10) DEFAULT NULL , CharacterSet VARCHAR(20) DEFAULT NULL , Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL, CreatedBy NUMERIC(10) NOT NULL, CSVAliasHeader VARCHAR(2000) DEFAULT NULL , CSVHeader VARCHAR(2000) DEFAULT NULL , Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_ImportTemplate_Key PRIMARY KEY (AD_ImportTemplate_ID), CONSTRAINT AD_ImportTemplate_UU_idx UNIQUE (AD_ImportTemplate_UU))
;

-- Oct 29, 2014 7:43:43 PM COT
ALTER TABLE AD_ImportTemplate ADD CONSTRAINT ADClient_ADImportTemplate FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:43:43 PM COT
ALTER TABLE AD_ImportTemplate ADD CONSTRAINT ADOrg_ADImportTemplate FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:43:43 PM COT
ALTER TABLE AD_ImportTemplate ADD CONSTRAINT ADTab_ADImportTemplate FOREIGN KEY (AD_Tab_ID) REFERENCES ad_tab(ad_tab_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:43:43 PM COT
ALTER TABLE AD_ImportTemplate ADD CONSTRAINT ADWindow_ADImportTemplate FOREIGN KEY (AD_Window_ID) REFERENCES ad_window(ad_window_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:43:43 PM COT
ALTER TABLE AD_ImportTemplate ADD CONSTRAINT CreatedBy_ADImportTemplate FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:43:43 PM COT
ALTER TABLE AD_ImportTemplate ADD CONSTRAINT UpdatedBy_ADImportTemplate FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:44:16 PM COT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,CreatedBy,IsActive,Name,UpdatedBy,IsCreateConstraint,IsUnique,AD_Table_ID,EntityType,Created,Updated,Processing) VALUES (0,0,201029,'8366ba0f-e1f5-444a-8218-ff53dff18e25',100,'Y','ad_importtemplate_uu_idx',100,'N','Y',200153,'D',TO_TIMESTAMP('2014-10-29 19:44:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-10-29 19:44:15','YYYY-MM-DD HH24:MI:SS'),'N')
;

-- Oct 29, 2014 7:44:16 PM COT
INSERT INTO AD_IndexColumn (CreatedBy,AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,IsActive,UpdatedBy,SeqNo,Created,Updated,AD_Column_ID,AD_TableIndex_ID) VALUES (100,0,0,201254,'fa33c80a-8ce6-4354-b707-7fd0766eac0d','Y',100,1,TO_TIMESTAMP('2014-10-29 19:44:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-10-29 19:44:16','YYYY-MM-DD HH24:MI:SS'),211770,201029)
;

-- Oct 29, 2014 7:46:37 PM COT
INSERT INTO AD_Tab (ImportFields,Processing,AD_Window_ID,IsSingleRow,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_Table_ID,Created,TreeDisplayedOn) VALUES ('N','N',200063,'Y',10,'N','N','N','N','N','Y','N',0,'3159d841-8fa1-4337-a546-a4d3bfafc4b4','D','Import Template',200167,0,100,TO_TIMESTAMP('2014-10-29 19:46:36','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,200153,TO_TIMESTAMP('2014-10-29 19:46:36','YYYY-MM-DD HH24:MI:SS'),'B')
;

-- Oct 29, 2014 7:46:40 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,22,'N','N',10,'Y',203447,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','8ae12e54-80e8-47d3-ac46-a100b5d930f3','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:39','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,0,2,211767,'D',0,TO_TIMESTAMP('2014-10-29 19:46:39','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:40 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,22,'N','N',20,'Y',203448,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','cca7110d-50f9-4cd1-b5ac-28390dc95c15','Y','N','Y',100,100,TO_TIMESTAMP('2014-10-29 19:46:40','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,4,0,2,211768,'D',0,TO_TIMESTAMP('2014-10-29 19:46:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:40 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,60,'N','N',30,'Y',203449,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name','65ee8529-ab50-4611-a9bc-6226e184c35c','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:40','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,0,5,211775,'D',0,TO_TIMESTAMP('2014-10-29 19:46:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:40 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,255,'N','N',40,'Y',203450,'N','A description is limited to 255 characters.','Optional short description of the record','Description','48ec102e-f6fe-434b-8ccd-1d5dba370c10','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:40','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,0,5,211773,'D',0,TO_TIMESTAMP('2014-10-29 19:46:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:41 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,22,'N','N','Y',203451,'N','Import Template','2f89e030-1286-4777-8c06-9d36311d47c7','N','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:40','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,211769,'D',0,TO_TIMESTAMP('2014-10-29 19:46:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:41 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,36,'N','N','Y',203452,'N','AD_ImportTemplate_UU','745d1182-5425-4467-b687-b05b68c3930c','N','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:41','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,211770,'D',0,TO_TIMESTAMP('2014-10-29 19:46:41','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:41 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,22,'N','N',50,'Y',203453,'N','The Window field identifies a unique Window in the system.','Data entry or display window','Window','bd029bf2-6147-48ab-b099-c4d78537b749','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:41','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,0,2,211778,'D',0,TO_TIMESTAMP('2014-10-29 19:46:41','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:41 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,10,'N','N',60,'Y',203454,'N','The Tab indicates a tab that displays within a window.','Tab within a Window','Tab','3c0d9d71-3fbe-405e-8a86-077a179cb009','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:41','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,0,2,211779,'D',0,TO_TIMESTAMP('2014-10-29 19:46:41','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:42 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,20,'N','N',70,'Y',203455,'N','Character Set','d68bae68-bb0d-40e4-91d4-b494ca3bc28f','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:41','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,0,2,211780,'D',0,TO_TIMESTAMP('2014-10-29 19:46:41','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:42 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,2000,'N','N',80,'Y',203456,'N','CSV Header','defceac6-b945-46f6-a31f-667b8fe3af46','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,0,5,211781,'D',0,TO_TIMESTAMP('2014-10-29 19:46:42','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:42 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,2000,'N','N',90,'Y',203457,'N','CSV Alias Header','62a021ba-0312-46e8-b440-c429e2de11f6','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,0,5,211782,'D',0,TO_TIMESTAMP('2014-10-29 19:46:42','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:46:42 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200167,1,'N','N',100,'Y',203458,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','ff24da67-465c-4344-9c6d-107e9cc81a2d','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:46:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,2,0,2,211774,'D',0,TO_TIMESTAMP('2014-10-29 19:46:42','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:47:02 PM COT
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2014-10-29 19:47:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203454
;

-- Oct 29, 2014 7:47:02 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-10-29 19:47:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203452
;

-- Oct 29, 2014 7:47:02 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-10-29 19:47:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203451
;

-- Oct 29, 2014 7:47:57 PM COT
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Processing,DatabaseViewDrop,EntityType,AD_Org_ID,Created,Updated) VALUES ('N','N','N','7',0,200063,200154,'N','N','N','L','31cc0aec-6aed-48d2-94a2-131999823079','Y','Y','AD_ImportTemplateAccess','Import Template Access','Y',100,100,0,'N','N','D',0,TO_TIMESTAMP('2014-10-29 19:47:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-10-29 19:47:56','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:47:57 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,CreatedBy,UpdatedBy,Updated,IsActive,StartNo,AD_Client_ID,Created) VALUES ('N',200000,'Y',1000000,'N','Y',200210,'Table AD_ImportTemplateAccess','AD_ImportTemplateAccess',1,'95a39113-33bd-4f9b-b7a2-ddde6f50961a',0,100,100,TO_TIMESTAMP('2014-10-29 19:47:57','YYYY-MM-DD HH24:MI:SS'),'Y',1000000,0,TO_TIMESTAMP('2014-10-29 19:47:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:49:02 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211783,'N','N','N',0,'N',22,'N','N','N','Y','4af37f40-a64c-4595-9e03-046e0a38683e','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2014-10-29 19:49:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:01','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',102,19,200154,129,0,0,'D','N')
;

-- Oct 29, 2014 7:49:02 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211784,'N','N','N',0,'N',22,'N','N','N','Y','24547bb5-0c8f-4baa-a21a-2412f80e35d5','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2014-10-29 19:49:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',113,19,200154,104,0,0,'D','N')
;

-- Oct 29, 2014 7:49:02 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211785,'N','N','N',0,'N',22,'N','N','N','Y','bd07f0dd-5882-495f-9ae6-fc98f2d29919','N','AD_Role_ID','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.','Role','Y',TO_TIMESTAMP('2014-10-29 19:49:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',123,19,200154,0,0,'D','N')
;

-- Oct 29, 2014 7:49:03 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211786,'N','N','N',0,'N',22,'N','N','N','Y','26373bfa-05bd-44a1-b98f-249736a4d1e2','N','AD_User_ID','User within the system - Internal or Business Partner Contact','-1','The User identifies a unique user in the system. This could be an internal user or a business partner contact','User/Contact','Y',TO_TIMESTAMP('2014-10-29 19:49:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',138,30,110,200154,0,0,'D','N')
;

-- Oct 29, 2014 7:49:03 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'N',0,211787,'Y','N','N',0,'N',7,'N','N','N','Y','22098c1b-4d2e-45a4-a61a-20e0e63d4e54','N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2014-10-29 19:49:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',245,16,200154,0,0,'D')
;

-- Oct 29, 2014 7:49:03 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211788,'N','N','N',0,'N',22,'N','N','N','Y','2b02e943-27a9-4fee-aef3-56abcc178085','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2014-10-29 19:49:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',246,18,110,200154,0,0,'D','N')
;

-- Oct 29, 2014 7:49:04 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'N',0,211789,'N','N','N',0,'N',1,'N','N','N','Y','76fe1243-cd5f-418f-a160-8e2f449171e1','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2014-10-29 19:49:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',348,20,200154,0,0,'D')
;

-- Oct 29, 2014 7:49:04 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('AD_ImportTemplateAccess_ID',202798,'Import Template Access','Import Template Access','b89d66eb-0d30-41cf-9c1b-50fa6bf32655',TO_TIMESTAMP('2014-10-29 19:49:04','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-10-29 19:49:04','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:49:04 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'N',0,211790,'Y','N','N',0,'N',22,'N','Y','N','Y','6807f501-7e84-4a11-baf1-02aa6c9e6c6e','N','AD_ImportTemplateAccess_ID','Import Template Access','N',TO_TIMESTAMP('2014-10-29 19:49:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202798,13,200154,0,0,'D')
;

-- Oct 29, 2014 7:49:04 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('AD_ImportTemplateAccess_UU',202799,'AD_ImportTemplateAccess_UU','AD_ImportTemplateAccess_UU','7955a0e6-7f4b-4aef-aed7-be62893b2f8c',TO_TIMESTAMP('2014-10-29 19:49:04','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-10-29 19:49:04','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:49:05 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'N',0,211791,'N','N','N',0,'N',36,'N','N','N','Y','fdfc8ac5-3e31-4cb2-a059-1dfa44d3cf76','N','AD_ImportTemplateAccess_UU','AD_ImportTemplateAccess_UU','N',TO_TIMESTAMP('2014-10-29 19:49:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202799,10,200154,0,0,'D')
;

-- Oct 29, 2014 7:49:05 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211792,'N','N','N',0,'Y',22,'N','N','N','Y','3258811a-6add-4d45-b916-fee3861dabcc','N','PA_DashboardContent_ID','Dashboard Content','Y',TO_TIMESTAMP('2014-10-29 19:49:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',51006,19,200154,0,0,'D','N')
;

-- Oct 29, 2014 7:49:05 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'N',0,211793,'Y','N','N',0,'N',7,'N','N','N','Y','e9e14e96-da06-484d-b097-cf773351d24c','N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2014-10-29 19:49:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',607,16,200154,0,0,'D')
;

-- Oct 29, 2014 7:49:05 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211794,'N','N','N',0,'N',22,'N','N','N','Y','8a486d42-3bb0-4ffc-ac8a-8c5668f081d8','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2014-10-29 19:49:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:49:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',608,18,110,200154,0,0,'D','N')
;

-- Oct 29, 2014 7:49:59 PM COT
UPDATE AD_Column SET IsUpdateable='N', ColumnName='AD_ImportTemplate_ID', Description=NULL, Help=NULL, Name='Import Template', AD_Element_ID=202793,Updated=TO_TIMESTAMP('2014-10-29 19:49:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211792
;

-- Oct 29, 2014 7:50:43 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,Description,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('IsAllowInsert',202800,'Allow Insert',NULL,'Allow Insert','2cc10cf3-6dd0-48bc-9bf1-3a4901ea2085',TO_TIMESTAMP('2014-10-29 19:50:42','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-10-29 19:50:42','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:50:54 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('IsAllowMerge',202801,'Allow Merge','Allow Merge','9e642c38-9a48-45fd-a652-68a1e62884f7',TO_TIMESTAMP('2014-10-29 19:50:54','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-10-29 19:50:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:51:08 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('IsAllowUpdate',202802,'Allow Update','Allow Update','2aa5523b-35f0-4f53-a0ed-271a1d200adf',TO_TIMESTAMP('2014-10-29 19:51:07','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-10-29 19:51:07','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:51:19 PM COT
UPDATE AD_Column SET FieldLength=1, IsUpdateable='Y', ColumnName='IsAllowInsert', Description=NULL, DefaultValue='Y', Help=NULL, Name='Allow Insert', AD_Element_ID=202800, AD_Reference_ID=20, AD_Reference_Value_ID=NULL, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2014-10-29 19:51:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211786
;

-- Oct 29, 2014 7:51:30 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'N',0,211795,'N','N','N',0,'N',1,'N','N','N','Y','c73d9978-6703-401e-ae04-e67cee28ec35','Y','IsAllowMerge','Y','Allow Merge','Y',TO_TIMESTAMP('2014-10-29 19:51:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:51:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202801,20,200154,0,0,'D')
;

-- Oct 29, 2014 7:51:35 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType,FKConstraintType) VALUES (0,'N',0,211796,'N','N','N',0,'N',1,'N','N','N','Y','c3ce0b40-1ec7-4bda-9be7-045c3d641e6b','Y','IsAllowUpdate','Y','Allow Update','Y',TO_TIMESTAMP('2014-10-29 19:51:35','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-10-29 19:51:35','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',202802,20,200154,0,0,'D','N')
;

-- Oct 29, 2014 7:51:51 PM COT
UPDATE AD_Column SET FKConstraintName='ADClient_ADImportTemplateAcces', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:51:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211783
;

-- Oct 29, 2014 7:51:51 PM COT
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADImportTemplate_ADImportTempl', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:51:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211792
;

-- Oct 29, 2014 7:51:51 PM COT
UPDATE AD_Column SET FKConstraintName='ADOrg_ADImportTemplateAccess', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:51:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211784
;

-- Oct 29, 2014 7:51:52 PM COT
UPDATE AD_Column SET FKConstraintName='ADRole_ADImportTemplateAccess', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211785
;

-- Oct 29, 2014 7:51:52 PM COT
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADImportTemplateAcce', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211788
;

-- Oct 29, 2014 7:51:52 PM COT
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADImportTemplateAcce', FKConstraintType='N',Updated=TO_TIMESTAMP('2014-10-29 19:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211794
;

-- Oct 29, 2014 7:51:52 PM COT
CREATE TABLE AD_ImportTemplateAccess (AD_Client_ID NUMERIC(10) DEFAULT NULL , AD_ImportTemplateAccess_ID NUMERIC(10) NOT NULL, AD_ImportTemplateAccess_UU VARCHAR(36) DEFAULT NULL , AD_ImportTemplate_ID NUMERIC(10) DEFAULT NULL , AD_Org_ID NUMERIC(10) DEFAULT NULL , AD_Role_ID NUMERIC(10) DEFAULT NULL , Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL, CreatedBy NUMERIC(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')), IsAllowInsert CHAR(1) DEFAULT 'Y' CHECK (IsAllowInsert IN ('Y','N')), IsAllowMerge CHAR(1) DEFAULT 'Y' CHECK (IsAllowMerge IN ('Y','N')), IsAllowUpdate CHAR(1) DEFAULT 'Y' CHECK (IsAllowUpdate IN ('Y','N')), Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL, UpdatedBy NUMERIC(10) DEFAULT NULL , CONSTRAINT AD_ImportTemplateAccess_Key PRIMARY KEY (AD_ImportTemplateAccess_ID), CONSTRAINT AD_ImportTemplateAccess_UU_idx UNIQUE (AD_ImportTemplateAccess_UU))
;

-- Oct 29, 2014 7:51:52 PM COT
ALTER TABLE AD_ImportTemplateAccess ADD CONSTRAINT ADClient_ADImportTemplateAcces FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:51:52 PM COT
ALTER TABLE AD_ImportTemplateAccess ADD CONSTRAINT ADImportTemplate_ADImportTempl FOREIGN KEY (AD_ImportTemplate_ID) REFERENCES ad_importtemplate(ad_importtemplate_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:51:52 PM COT
ALTER TABLE AD_ImportTemplateAccess ADD CONSTRAINT ADOrg_ADImportTemplateAccess FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:51:52 PM COT
ALTER TABLE AD_ImportTemplateAccess ADD CONSTRAINT ADRole_ADImportTemplateAccess FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:51:52 PM COT
ALTER TABLE AD_ImportTemplateAccess ADD CONSTRAINT CreatedBy_ADImportTemplateAcce FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:51:52 PM COT
ALTER TABLE AD_ImportTemplateAccess ADD CONSTRAINT UpdatedBy_ADImportTemplateAcce FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 29, 2014 7:52:08 PM COT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,CreatedBy,IsActive,Name,UpdatedBy,IsCreateConstraint,IsUnique,AD_Table_ID,EntityType,Created,Updated,Processing) VALUES (0,0,201030,'a144e4f0-adf4-4589-9b53-ea1c6bfa34bc',100,'Y','ad_importtemplateaccess_uu_idx',100,'N','Y',200154,'D',TO_TIMESTAMP('2014-10-29 19:52:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-10-29 19:52:07','YYYY-MM-DD HH24:MI:SS'),'N')
;

-- Oct 29, 2014 7:52:08 PM COT
INSERT INTO AD_IndexColumn (CreatedBy,AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,IsActive,UpdatedBy,SeqNo,Created,Updated,AD_Column_ID,AD_TableIndex_ID) VALUES (100,0,0,201255,'30d3191c-d73c-4a3e-9e9f-74487045ced0','Y',100,1,TO_TIMESTAMP('2014-10-29 19:52:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-10-29 19:52:08','YYYY-MM-DD HH24:MI:SS'),211791,201030)
;

-- Oct 29, 2014 7:53:49 PM COT
INSERT INTO AD_Tab (ImportFields,Processing,AD_Window_ID,IsSingleRow,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_Column_ID,AD_Table_ID,Created,TreeDisplayedOn) VALUES ('N','N',200063,'Y',20,'N','N','N','N','N','Y','N',1,'fa6ec748-a733-4ab9-94a6-eb7c388fbb69','D','Import Template Access',200168,0,100,TO_TIMESTAMP('2014-10-29 19:53:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,211792,200154,TO_TIMESTAMP('2014-10-29 19:53:48','YYYY-MM-DD HH24:MI:SS'),'B')
;

-- Oct 29, 2014 7:53:53 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200168,22,'N','N',10,'Y',203459,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','6cff991b-3f72-45b7-8d39-50b9d7756b63','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:53:53','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,0,2,211783,'D',0,TO_TIMESTAMP('2014-10-29 19:53:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:53:53 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200168,22,'N','N',20,'Y',203460,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','9453cf50-3dd4-4152-95f8-cc26bf87590a','Y','N','Y',100,100,TO_TIMESTAMP('2014-10-29 19:53:53','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,4,0,2,211784,'D',0,TO_TIMESTAMP('2014-10-29 19:53:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:53:53 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200168,22,'N','N',30,'Y',203461,'N','The Role determines security and access a user who has this Role will have in the System.','Responsibility Role','Role','0bf19755-a237-41a7-8483-418587d6ff75','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:53:53','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,0,2,211785,'D',0,TO_TIMESTAMP('2014-10-29 19:53:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:53:54 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200168,1,'N','N',40,'Y',203462,'N','Allow Insert','8b29f253-9f7b-4d97-bbb2-1246ec51b707','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:53:53','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,2,0,2,211786,'D',0,TO_TIMESTAMP('2014-10-29 19:53:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:53:54 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200168,22,'N','N','Y',203463,'N','Import Template Access','2cd5390b-dec3-45b8-88b0-a6a9bf9c7f38','N','N',100,100,TO_TIMESTAMP('2014-10-29 19:53:54','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,211790,'D',0,TO_TIMESTAMP('2014-10-29 19:53:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:53:54 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200168,36,'N','N','Y',203464,'N','AD_ImportTemplateAccess_UU','41fad25d-e32e-4cce-831c-c4c5aa709b55','N','N',100,100,TO_TIMESTAMP('2014-10-29 19:53:54','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,211791,'D',0,TO_TIMESTAMP('2014-10-29 19:53:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:53:54 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200168,22,'N','N',50,'Y',203465,'N','Import Template','cbe5d6c4-3c1d-4e6d-a705-0eb613f3124c','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:53:54','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,0,2,211792,'D',0,TO_TIMESTAMP('2014-10-29 19:53:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:53:55 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200168,1,'N','N',60,'Y',203466,'N','Allow Merge','8f422234-5cc3-4cc6-8c20-8d04f3069a22','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:53:54','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,2,0,2,211795,'D',0,TO_TIMESTAMP('2014-10-29 19:53:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:53:55 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200168,1,'N','N',70,'Y',203467,'N','Allow Update','63ec11ce-c1b9-4ed6-bbda-0bd0e545b31d','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:53:55','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,2,0,2,211796,'D',0,TO_TIMESTAMP('2014-10-29 19:53:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:53:55 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200168,1,'N','N',80,'Y',203468,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','6b477202-85a6-41fa-90b6-a64ed915fb27','Y','N',100,100,TO_TIMESTAMP('2014-10-29 19:53:55','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,2,0,2,211789,'D',0,TO_TIMESTAMP('2014-10-29 19:53:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 7:54:54 PM COT
UPDATE AD_Field SET SeqNo=30, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2014-10-29 19:54:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203465
;

-- Oct 29, 2014 7:54:54 PM COT
UPDATE AD_Field SET SeqNo=40, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2014-10-29 19:54:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203461
;

-- Oct 29, 2014 7:54:54 PM COT
UPDATE AD_Field SET SeqNo=50, ColumnSpan=1,Updated=TO_TIMESTAMP('2014-10-29 19:54:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203462
;

-- Oct 29, 2014 7:54:54 PM COT
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=3, ColumnSpan=1,Updated=TO_TIMESTAMP('2014-10-29 19:54:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203466
;

-- Oct 29, 2014 7:54:54 PM COT
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=4, ColumnSpan=1,Updated=TO_TIMESTAMP('2014-10-29 19:54:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203467
;

-- Oct 29, 2014 7:54:54 PM COT
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=5,Updated=TO_TIMESTAMP('2014-10-29 19:54:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203468
;

-- Oct 29, 2014 7:54:54 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-10-29 19:54:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203464
;

-- Oct 29, 2014 7:54:54 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-10-29 19:54:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203463
;

-- Oct 29, 2014 8:05:37 PM COT
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,IsActive,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES (200095,'Y','N','N','D','N','CSV Import','3f0151f1-c384-49bf-bd3f-2263a0e0ae72','Y',100,TO_TIMESTAMP('2014-10-29 20:05:36','YYYY-MM-DD HH24:MI:SS'),100,0,0,TO_TIMESTAMP('2014-10-29 20:05:36','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 8:05:37 PM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200095, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200095)
;

-- Oct 29, 2014 8:06:15 PM COT
UPDATE AD_Menu SET AD_Window_ID=200063, IsSummary='N', IsSOTrx='Y', Name='Import Template', "action"='W',Updated=TO_TIMESTAMP('2014-10-29 20:06:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200095
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=222
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=223
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=185
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=340
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53264
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53206
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=339
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=338
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53282
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=363
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=376
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=382
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=486
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=425
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=378
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=374
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53284
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=423
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53263
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=373
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=424
;

-- Oct 29, 2014 8:07:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200095
;

-- Oct 29, 2014 9:42:40 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID,Updated) VALUES ('M','CSV Import File Loader',200326,'D','9e568b5d-ccf6-4bc8-940b-ee539805712e','CSVImport','Y',100,100,TO_TIMESTAMP('2014-10-29 21:42:39','YYYY-MM-DD HH24:MI:SS'),0,0,TO_TIMESTAMP('2014-10-29 21:42:39','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2014 9:46:46 PM COT
INSERT INTO AD_ToolBarButton ("action",SeqNo,CreatedBy,KeyStroke_Modifiers,AD_ToolBarButton_ID,Name,ComponentName,AD_Org_ID,IsCustomization,KeyStroke_KeyCode,UpdatedBy,Created,Updated,IsActive,AD_Client_ID,AD_ToolBarButton_UU,IsAdvancedButton,IsAddSeparator) VALUES ('W',270,100,0,200081,'zk Window - CSV File Import','CSVImport',0,'N',0,100,TO_TIMESTAMP('2014-10-29 21:46:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-10-29 21:46:45','YYYY-MM-DD HH24:MI:SS'),'Y',0,'42b3879c-3e27-44c2-9c2c-b64b6d43d2fa','N','N')
;

-- Nov 4, 2014 8:19:40 PM COT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2014-11-04 20:19:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211779
;

-- Nov 4, 2014 8:19:43 PM COT
INSERT INTO t_alter_column values('ad_importtemplate','AD_Tab_ID','NUMERIC(10)',null,null)
;

-- Nov 4, 2014 8:19:43 PM COT
INSERT INTO t_alter_column values('ad_importtemplate','AD_Tab_ID',null,'NOT NULL',null)
;

-- Nov 4, 2014 8:19:43 PM COT
ALTER TABLE AD_ImportTemplate DROP CONSTRAINT adtab_adimporttemplate
;

-- Nov 4, 2014 8:19:43 PM COT
ALTER TABLE AD_ImportTemplate ADD CONSTRAINT ADTab_ADImportTemplate FOREIGN KEY (AD_Tab_ID) REFERENCES ad_tab(ad_tab_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 4, 2014 8:19:51 PM COT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2014-11-04 20:19:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211778
;

-- Nov 4, 2014 8:19:52 PM COT
INSERT INTO t_alter_column values('ad_importtemplate','AD_Window_ID','NUMERIC(10)',null,null)
;

-- Nov 4, 2014 8:19:52 PM COT
INSERT INTO t_alter_column values('ad_importtemplate','AD_Window_ID',null,'NOT NULL',null)
;

-- Nov 4, 2014 8:19:52 PM COT
ALTER TABLE AD_ImportTemplate DROP CONSTRAINT adwindow_adimporttemplate
;

-- Nov 4, 2014 8:19:52 PM COT
ALTER TABLE AD_ImportTemplate ADD CONSTRAINT ADWindow_ADImportTemplate FOREIGN KEY (AD_Window_ID) REFERENCES ad_window(ad_window_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 4, 2014 8:19:57 PM COT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2014-11-04 20:19:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211780
;

-- Nov 4, 2014 8:19:59 PM COT
INSERT INTO t_alter_column values('ad_importtemplate','CharacterSet','VARCHAR(20)',null,null)
;

-- Nov 4, 2014 8:19:59 PM COT
INSERT INTO t_alter_column values('ad_importtemplate','CharacterSet',null,'NOT NULL',null)
;

-- Nov 4, 2014 8:20:13 PM COT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2014-11-04 20:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211781
;

-- Nov 4, 2014 8:20:15 PM COT
INSERT INTO t_alter_column values('ad_importtemplate','CSVHeader','VARCHAR(2000)',null,null)
;

-- Nov 4, 2014 8:20:15 PM COT
INSERT INTO t_alter_column values('ad_importtemplate','CSVHeader',null,'NOT NULL',null)
;

-- Nov 4, 2014 8:43:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203465
;

-- Nov 4, 2014 8:43:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203460
;

-- Nov 4, 2014 8:43:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203459
;

-- Nov 4, 2014 8:43:10 PM COT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=203461
;

-- Nov 4, 2014 8:43:10 PM COT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=203462
;

-- Nov 4, 2014 8:43:10 PM COT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=203466
;

-- Nov 4, 2014 8:43:10 PM COT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=203467
;

-- Nov 4, 2014 8:43:10 PM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=203468
;

-- Nov 4, 2014 9:07:37 PM COT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutImportTemplate.characterSet',Updated=TO_TIMESTAMP('2014-11-04 21:07:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211780
;

-- Nov 4, 2014 11:20:18 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,CreatedBy,UpdatedBy,Created,AD_Client_ID,EntityType,AD_Org_ID,Updated) VALUES ('E','CSV Header doesn''t match template',200327,'49bcc54d-8b87-4227-9382-547517265005','WrongCSVHeader','Y',100,100,TO_TIMESTAMP('2014-11-04 23:20:18','YYYY-MM-DD HH24:MI:SS'),0,'D',0,TO_TIMESTAMP('2014-11-04 23:20:18','YYYY-MM-DD HH24:MI:SS'))
;

SELECT register_migration_script('201411042322_IDEMPIERE-2113.sql') FROM dual
;

