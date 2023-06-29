-- IDEMPIERE-5659
SELECT register_migration_script('202304031142_IDEMPIERE-5659.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 3, 2023, 11:40:52 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200385,'Document Base Type Group','Group of Document Base Type for Period Control','C_DocBaseGroup',0,'6',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:40:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:40:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','6be7f778-7e56-4368-bc25-b57829e5b281','N','N','N','N','N')
;

-- Apr 3, 2023, 11:40:52 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_DocBaseGroup',1000000,'N','N','Table C_DocBaseGroup','Y','Y',0,0,TO_TIMESTAMP('2023-04-03 11:40:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:40:52','YYYY-MM-DD HH24:MI:SS'),100,200455,'Y',1000000,1,200000,'62225c22-e942-480e-8c07-0b6b771df383')
;

-- Apr 3, 2023, 11:42:51 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215810,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200385,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:51','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','5342a6a2-f99e-4654-88ff-2ada2808414d','N')
;

-- Apr 3, 2023, 11:42:51 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215811,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200385,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:51','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','f74972ac-f6a3-4442-b068-3dd80f764c64','N')
;

-- Apr 3, 2023, 11:42:52 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215812,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200385,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:51','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','54de15c3-3a9b-40c1-b9b7-770b270f141e','N')
;

-- Apr 3, 2023, 11:42:52 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215813,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200385,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:52','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','78081b43-713f-4218-916d-3bd53dcd7427','N')
;

-- Apr 3, 2023, 11:42:52 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215814,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200385,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:52','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','38fe33af-41c7-4ee0-816e-04324130ba36','N')
;

-- Apr 3, 2023, 11:42:53 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215815,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200385,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:52','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','43e54e2a-e68e-4d55-8b2f-990063b495ed','N')
;

-- Apr 3, 2023, 11:42:53 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215816,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200385,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:53','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','5ccb2304-6894-4389-8bdc-25abd89c10eb','N')
;

-- Apr 3, 2023, 11:42:53 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203800,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:53','YYYY-MM-DD HH24:MI:SS'),100,'C_DocBaseGroup_ID','Document Base Type Group','Group of Document Base Type for Period Control','Document Base Type Group','D','82acb1ec-ce94-48c7-a240-454c4afaa57d')
;

-- Apr 3, 2023, 11:42:54 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215817,0.0,'Document Base Type Group','Group of Document Base Type for Period Control',200385,'C_DocBaseGroup_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:53','YYYY-MM-DD HH24:MI:SS'),100,203800,'N','N','D','N','11d610a4-c66c-4f69-9197-97c7921d6440','N')
;

-- Apr 3, 2023, 11:42:54 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203801,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:54','YYYY-MM-DD HH24:MI:SS'),100,'C_DocBaseGroup_UU','C_DocBaseGroup_UU','C_DocBaseGroup_UU','D','7a706bc2-6a60-4cb5-8ca7-8524f7ed355c')
;

-- Apr 3, 2023, 11:42:54 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215818,0.0,'C_DocBaseGroup_UU',200385,'C_DocBaseGroup_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:54','YYYY-MM-DD HH24:MI:SS'),100,203801,'Y','N','D','N','41c27aa8-1866-4a72-ab80-c243a098cfca','N')
;

-- Apr 3, 2023, 11:42:55 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (215819,0.0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200385,'Value',40,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:54','YYYY-MM-DD HH24:MI:SS'),100,620,'Y','Y','D','N','79cba092-324d-476f-8ca9-dfed55a5ecdc',10,'N')
;

-- Apr 3, 2023, 11:42:55 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (215820,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200385,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:55','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','f6c5236d-277e-4bed-b7b9-c9fe7faf1183',20,'N')
;

-- Apr 3, 2023, 11:42:55 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215821,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200385,'Help',2000,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:42:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:42:55','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','9e8e9386-c817-45be-8113-703132930a56','N')
;

-- Apr 3, 2023, 11:44:20 AM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200140,'Document Base Type Group',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:19','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','N','N','N','53871d7c-681f-418e-a28f-e128772fb5d8')
;

-- Apr 3, 2023, 11:44:20 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200351,'Document Base Type Group',200140,10,'Y',200385,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','C_DocBaseGroup.Value','N',0,'N','D','Y','N','745e906f-4e34-43eb-84b8-bd2b484e3cb3')
;

-- Apr 3, 2023, 11:44:20 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207602,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200351,215810,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ed99ae54-bdf8-48e2-a657-a2ed40f4a972','Y',10,2)
;

-- Apr 3, 2023, 11:44:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207603,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200351,215811,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6dd8442c-6f48-4393-84d5-f363a670db9f','Y','N',4,2)
;

-- Apr 3, 2023, 11:44:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207604,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200351,215819,'Y',40,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eaefaf2e-f14e-41aa-a64d-da496bff266e','Y',20,2)
;

-- Apr 3, 2023, 11:44:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207605,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200351,215820,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9219ba57-cfa2-4811-9b3a-dd3909fcf412','Y',30,5)
;

-- Apr 3, 2023, 11:44:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207606,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200351,215821,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f0f6adba-b4be-4692-9994-d30f6539d11e','Y',40,5)
;

-- Apr 3, 2023, 11:44:22 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207607,'Document Base Type Group','Group of Document Base Type for Period Control',200351,215817,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8ee037a0-a54f-448f-98b6-88597ec351fa','N',2)
;

-- Apr 3, 2023, 11:44:22 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207608,'C_DocBaseGroup_UU',200351,215818,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e21dc874-5ddd-4906-80aa-27faa453dcc7','N',2)
;

-- Apr 3, 2023, 11:44:22 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207609,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200351,215816,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','18c20585-6f64-4f67-81fe-2b4b481c2c96','Y',50,2,2)
;

-- Apr 3, 2023, 11:44:23 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200226,'Document Base Type Group','W',200140,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:44:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:44:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','2fc1e2d9-cd0a-4bea-82d2-ed65e03c541e')
;

-- Apr 3, 2023, 11:44:23 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200226, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200226)
;

-- Apr 3, 2023, 11:44:23 AM CEST
UPDATE AD_Table SET AD_Window_ID=200140,Updated=TO_TIMESTAMP('2023-04-03 11:44:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200385
;

-- Apr 3, 2023, 11:44:47 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=5,Updated=TO_TIMESTAMP('2023-04-03 11:44:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207609
;

-- Apr 3, 2023, 11:44:47 AM CEST
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2023-04-03 11:44:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207605
;

-- Apr 3, 2023, 11:44:47 AM CEST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2023-04-03 11:44:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207606
;

-- Apr 3, 2023, 11:44:47 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-04-03 11:44:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207608
;

-- Apr 3, 2023, 11:44:47 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-04-03 11:44:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207607
;

-- Apr 3, 2023, 11:45:09 AM CEST
UPDATE AD_Field SET SeqNo=10, IsReadOnly='Y',Updated=TO_TIMESTAMP('2023-04-03 11:45:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207602
;

-- Apr 3, 2023, 11:46:55 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200386,'Document Base Type Group Line','Line Items of a Document Base Type Group',200140,'C_DocBaseGroupLine',0,'6',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:46:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:46:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','8c2fd0c3-9e15-4f0a-a172-2ab07c2e8479','N','N','N','N','N')
;

-- Apr 3, 2023, 11:46:56 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_DocBaseGroupLine',1000000,'N','N','Table C_DocBaseGroupLine','Y','Y',0,0,TO_TIMESTAMP('2023-04-03 11:46:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:46:55','YYYY-MM-DD HH24:MI:SS'),100,200456,'Y',1000000,1,200000,'3554dcfa-c2c6-402c-b601-5908118547d5')
;

-- Apr 3, 2023, 11:47:21 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215822,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200386,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:21','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','0a46ae5e-0241-43f9-b585-f74db226790e','N')
;

-- Apr 3, 2023, 11:47:22 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215823,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200386,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:21','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','5212274d-4887-4ebb-a2b6-7157b5e3332c','N')
;

-- Apr 3, 2023, 11:47:22 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215824,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200386,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','a7403de5-91b8-4843-8888-b9e67789b8b8','N')
;

-- Apr 3, 2023, 11:47:22 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215825,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200386,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','52adc84b-c116-448b-bfa5-6756d9f312db','N')
;

-- Apr 3, 2023, 11:47:22 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215826,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200386,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','cfd94688-231a-46f1-b1bb-83d4db62b8bd','N')
;

-- Apr 3, 2023, 11:47:23 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215827,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200386,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','b71b8129-d4d8-4379-a499-1f58d8e4244d','N')
;

-- Apr 3, 2023, 11:47:23 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215828,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200386,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:23','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','fc61f9bd-4103-423e-9b83-74e329e72afd','N')
;

-- Apr 3, 2023, 11:47:23 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203802,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:23','YYYY-MM-DD HH24:MI:SS'),100,'C_DocBaseGroupLine_ID','Document Base Type Group Line','Line Items of a Document Base Type Group','Document Base Type Group Line','D','b788c72f-9e80-4efa-8832-5dfa310a38e7')
;

-- Apr 3, 2023, 11:47:24 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215829,0.0,'Document Base Type Group Line','Line Items of a Document Base Type Group',200386,'C_DocBaseGroupLine_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:23','YYYY-MM-DD HH24:MI:SS'),100,203802,'N','N','D','N','200ce7df-99b3-4ffa-bc27-50953accc10f','N')
;

-- Apr 3, 2023, 11:47:24 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203803,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:24','YYYY-MM-DD HH24:MI:SS'),100,'C_DocBaseGroupLine_UU','C_DocBaseGroupLine_UU','C_DocBaseGroupLine_UU','D','b7a4b3a0-26cb-460e-a8be-42ee02ac904a')
;

-- Apr 3, 2023, 11:47:24 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215830,0.0,'C_DocBaseGroupLine_UU',200386,'C_DocBaseGroupLine_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:47:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:47:24','YYYY-MM-DD HH24:MI:SS'),100,203803,'Y','N','D','N','ec7242a6-a2a3-403c-aa03-53fa39e743f3','N')
;

-- Apr 3, 2023, 11:48:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215831,0,'Document Base Type','Logical type of document','The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.',200386,'DocBaseType',3,'N','N','Y','N','N',0,'N',17,183,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:48:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:48:17','YYYY-MM-DD HH24:MI:SS'),100,865,'N','N','D','N','N','N','Y','6a7e18d8-504b-4bd4-8369-935ef925a9ff','Y',0,'N','N','N','N')
;

-- Apr 3, 2023, 11:48:35 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215832,0,'Document Base Type Group','Group of Document Base Type for Period Control',200386,'C_DocBaseGroup_ID',22,'N','Y','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:48:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:48:34','YYYY-MM-DD HH24:MI:SS'),100,203800,'N','N','D','N','N','N','Y','21e9a8e0-c556-4219-89bb-9dec3b940fc4','Y',0,'N','N','N','N')
;

-- Apr 3, 2023, 11:49:13 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200352,'Document Base Type Group Line',200140,20,'Y',200386,0,0,'Y',TO_TIMESTAMP('2023-04-03 11:49:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:49:13','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N',215832,'C_DocBaseGroupLine.Created DESC','N',1,'N','D','Y','N','cbbfe720-616d-4ef9-9137-72078a61f763')
;

-- Apr 3, 2023, 11:49:13 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207610,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200352,215822,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:49:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:49:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','29c94843-1b50-444e-8cb2-3d9130872bb4','Y',10,2)
;

-- Apr 3, 2023, 11:49:14 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207611,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200352,215823,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:49:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:49:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c721c37e-24b5-4da8-9fe7-254cced0dba0','Y','N',4,2)
;

-- Apr 3, 2023, 11:49:14 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207612,'Document Base Type Group','Group of Document Base Type for Period Control',200352,215832,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:49:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:49:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f8d4b3aa-adaf-4d3d-bf67-adf04501220f','Y',20,2)
;

-- Apr 3, 2023, 11:49:14 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207613,'Document Base Type Group Line','Line Items of a Document Base Type Group',200352,215829,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:49:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:49:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3f225d07-e648-4db7-9128-eb3bf241afa7','N',2)
;

-- Apr 3, 2023, 11:49:14 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207614,'C_DocBaseGroupLine_UU',200352,215830,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:49:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:49:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b5498f5d-642e-4ff4-b64e-2e3b0606466f','N',2)
;

-- Apr 3, 2023, 11:49:15 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207615,'Document Base Type','Logical type of document','The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.',200352,215831,'Y',3,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:49:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:49:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e7142793-7cb7-459e-9791-5f518c82c4ce','Y',30,2)
;

-- Apr 3, 2023, 11:49:15 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207616,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200352,215828,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-03 11:49:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 11:49:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b25e524c-9702-4cb6-9b4a-3cb6fa33ff00','Y',40,2,2)
;

-- Apr 3, 2023, 11:49:40 AM CEST
UPDATE AD_Field SET SeqNo=10, IsReadOnly='Y',Updated=TO_TIMESTAMP('2023-04-03 11:49:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207610
;

-- Apr 3, 2023, 11:49:40 AM CEST
UPDATE AD_Field SET SeqNo=30, IsReadOnly='Y',Updated=TO_TIMESTAMP('2023-04-03 11:49:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207612
;

-- Apr 3, 2023, 11:49:40 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=5,Updated=TO_TIMESTAMP('2023-04-03 11:49:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207616
;

-- Apr 3, 2023, 11:49:40 AM CEST
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2023-04-03 11:49:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207615
;

-- Apr 3, 2023, 11:49:40 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-04-03 11:49:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207614
;

-- Apr 3, 2023, 11:49:40 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-04-03 11:49:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207613
;

-- Apr 3, 2023, 11:49:52 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_CPeriodDocGroup', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-04-03 11:49:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215810
;

-- Apr 3, 2023, 11:49:52 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_CPeriodDocGroup', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-04-03 11:49:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215811
;

-- Apr 3, 2023, 11:49:52 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_CPeriodDocGroup', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-04-03 11:49:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215813
;

-- Apr 3, 2023, 11:49:52 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_CPeriodDocGroup', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-04-03 11:49:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215815
;

-- Apr 3, 2023, 11:49:52 AM CEST
CREATE TABLE C_DocBaseGroup (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_DocBaseGroup_ID NUMBER(10) NOT NULL, C_DocBaseGroup_UU VARCHAR2(36 CHAR) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Help VARCHAR2(2000 CHAR) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR2(60 CHAR) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, Value VARCHAR2(40 CHAR) DEFAULT NULL , CONSTRAINT C_DocBaseGroup_Key PRIMARY KEY (C_DocBaseGroup_ID), CONSTRAINT C_DocBaseGroup_UU_idx UNIQUE (C_DocBaseGroup_UU))
;

-- Apr 3, 2023, 11:49:52 AM CEST
ALTER TABLE C_DocBaseGroup ADD CONSTRAINT ADClient_CPeriodDocGroup FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2023, 11:49:52 AM CEST
ALTER TABLE C_DocBaseGroup ADD CONSTRAINT ADOrg_CPeriodDocGroup FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2023, 11:49:52 AM CEST
ALTER TABLE C_DocBaseGroup ADD CONSTRAINT CreatedBy_CPeriodDocGroup FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2023, 11:49:52 AM CEST
ALTER TABLE C_DocBaseGroup ADD CONSTRAINT UpdatedBy_CPeriodDocGroup FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2023, 11:50:01 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_CPeriodDocGroupLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-04-03 11:50:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215822
;

-- Apr 3, 2023, 11:50:01 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_CPeriodDocGroupLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-04-03 11:50:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215823
;

-- Apr 3, 2023, 11:50:01 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='CPeriodDocGroup_CPeriodDocGrou', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-04-03 11:50:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215832
;

-- Apr 3, 2023, 11:50:01 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_CPeriodDocGroupLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-04-03 11:50:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215825
;

-- Apr 3, 2023, 11:50:01 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_CPeriodDocGroupLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-04-03 11:50:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215827
;

-- Apr 3, 2023, 11:50:01 AM CEST
CREATE TABLE C_DocBaseGroupLine (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_DocBaseGroupLine_ID NUMBER(10) NOT NULL, C_DocBaseGroupLine_UU VARCHAR2(36 CHAR) DEFAULT NULL , C_DocBaseGroup_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, DocBaseType VARCHAR2(3 CHAR) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT C_DocBaseGroupLine_Key PRIMARY KEY (C_DocBaseGroupLine_ID), CONSTRAINT C_DocBaseGroupLine_UU_idx UNIQUE (C_DocBaseGroupLine_UU))
;

-- Apr 3, 2023, 11:50:01 AM CEST
ALTER TABLE C_DocBaseGroupLine ADD CONSTRAINT ADClient_CPeriodDocGroupLine FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2023, 11:50:01 AM CEST
ALTER TABLE C_DocBaseGroupLine ADD CONSTRAINT ADOrg_CPeriodDocGroupLine FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2023, 11:50:01 AM CEST
ALTER TABLE C_DocBaseGroupLine ADD CONSTRAINT CPeriodDocGroup_CPeriodDocGrou FOREIGN KEY (C_DocBaseGroup_ID) REFERENCES C_DocBaseGroup(C_DocBaseGroup_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2023, 11:50:01 AM CEST
ALTER TABLE C_DocBaseGroupLine ADD CONSTRAINT CreatedBy_CPeriodDocGroupLine FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2023, 11:50:01 AM CEST
ALTER TABLE C_DocBaseGroupLine ADD CONSTRAINT UpdatedBy_CPeriodDocGroupLine FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2023, 12:33:09 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Document Base Type must be unique for the Document Base Type Group.','A Document Base Type Group Line with this Document Base Type already exists.',0,0,'Y',TO_TIMESTAMP('2023-04-03 12:33:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 12:33:09','YYYY-MM-DD HH24:MI:SS'),100,200828,'PeriodDocGroupLineUniqueDocBaseTypeError','D','d543ef24-6ae1-4b78-a75a-b73822c1ecca')
;

-- Apr 3, 2023, 12:35:17 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200174,'C_DocBaseGroupLine Document Base Type','S','AD_Ref_List.Value NOT IN (SELECT DocBaseType FROM C_DocBaseGroupLine WHERE C_DocBaseGroup_ID =@C_DocBaseGroup_ID@)',0,0,'Y',TO_TIMESTAMP('2023-04-03 12:35:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 12:35:17','YYYY-MM-DD HH24:MI:SS'),100,'D','89f8acf2-512f-401f-8271-3c45b8dec03a')
;

-- Apr 3, 2023, 12:35:28 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200174,Updated=TO_TIMESTAMP('2023-04-03 12:35:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215831
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=4,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200226
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=5,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=384
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=6,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=111
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=7,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=106
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=8,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=117
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=9,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=418
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=10,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=102
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=11,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=103
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=12,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=270
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=13,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=121
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=14,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=476
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=15,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=409
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=16,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=151
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=17,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53087
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=18,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=464
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=19,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=124
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=20,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=123
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=21,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=547
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=22,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53189
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=23,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=174
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=24,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=254
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=25,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=120
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=26,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=135
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=27,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=550
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=28,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=551
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=29,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=306
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=30,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53093
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=31,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53091
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=32,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=417
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=33,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=307
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=34,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=393
;

-- Apr 3, 2023, 12:37:44 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=35,Updated=TO_TIMESTAMP('2023-04-03 12:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53248
;

-- Apr 3, 2023, 12:37:47 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=3,Updated=TO_TIMESTAMP('2023-04-03 12:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200226
;

-- Apr 3, 2023, 12:37:47 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=4,Updated=TO_TIMESTAMP('2023-04-03 12:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=105
;

-- Apr 3, 2023, 12:40:34 PM CEST
UPDATE AD_InfoWindow SET FromClause='C_PeriodControl pc
JOIN C_Period p ON (pc.C_Period_ID=p.C_Period_ID)
JOIN C_Year y ON (p.C_Year_ID=y.C_Year_ID)
LEFT JOIN C_DocBaseGroupLine gl ON (gl.DocBaseType = pc.DocBaseType)', IsValid='Y',Updated=TO_TIMESTAMP('2023-04-03 12:40:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200019
;

-- Apr 3, 2023, 12:43:53 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete,IsQueryAfterChange,IsRange) VALUES (200281,0,0,'Y',TO_TIMESTAMP('2023-04-03 12:43:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 12:43:53','YYYY-MM-DD HH24:MI:SS'),100,'Document Base Type Group','Group of Document Base Type for Period Control',200019,'D','gl.C_DocBaseGroup_ID',90,'N','Y',203800,19,'e1364242-d7e9-45c3-9649-16a66574b387','Y','C_DocBaseGroup_ID','=','N',80,'N','N','Y','N','N','N')
;

-- Apr 3, 2023, 12:45:34 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200434,0,0,'Y',TO_TIMESTAMP('2023-04-03 12:45:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-03 12:45:34','YYYY-MM-DD HH24:MI:SS'),100,'Document Base Type Group','Group of Document Base Type for Period Control',167,10,19,'N',22,'N','C_DocBaseGroup_ID','Y','D',203800,'@C_Period_ID@>0','91179629-0224-44f0-bf7c-45eb91dd0b20','N','N','D','N')
;

-- Apr 4, 2023, 8:33:08 AM CEST
UPDATE AD_Message SET Value='DocBaseGroupLineUniqueDocBaseTypeError',Updated=TO_TIMESTAMP('2023-04-04 08:33:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200828
;

-- Apr 4, 2023, 8:34:28 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,AD_Message_ID,TableIndexDrop,IsKey) VALUES (0,0,201180,'a7751a2c-2e7d-41a7-a29e-e2f552467421',TO_TIMESTAMP('2023-04-04 08:34:27','YYYY-MM-DD HH24:MI:SS'),100,'Document Base Type must be unique per Document Base Group','D','Y','c_docbasegroupline_docbasegroup',TO_TIMESTAMP('2023-04-04 08:34:27','YYYY-MM-DD HH24:MI:SS'),100,200386,'N','Y','N',200828,'N','N')
;

-- Apr 4, 2023, 8:35:19 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201617,'c508a21d-38fa-4500-a92b-399f12e6e936',TO_TIMESTAMP('2023-04-04 08:35:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-04 08:35:18','YYYY-MM-DD HH24:MI:SS'),100,215832,201180,10)
;

-- Apr 4, 2023, 8:35:27 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201618,'00c81404-eeb7-4bcc-b878-cdf6140a9fae',TO_TIMESTAMP('2023-04-04 08:35:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-04 08:35:27','YYYY-MM-DD HH24:MI:SS'),100,215831,201180,20)
;

-- Apr 4, 2023, 8:35:27 AM CEST
CREATE UNIQUE INDEX c_docbasegroupline_docbasegroup ON C_DocBaseGroupLine (C_DocBaseGroup_ID,DocBaseType)
;

