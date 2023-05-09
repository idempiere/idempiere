-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
SELECT register_migration_script('202303171334_IDEMPIERE-5567.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 17, 2023, 1:34:39 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200383,'Test UU Based Table','TestUU','7',0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','9827c04e-633e-44c2-a17f-d9bd56874b75','N')
;

-- Mar 17, 2023, 1:34:40 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('TestUU',1000000,'N','N','Table TestUU','Y','Y',0,0,TO_TIMESTAMP('2023-03-17 13:34:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:39','YYYY-MM-DD HH24:MI:SS'),100,200453,'Y',1000000,1,200000,'d9a6863f-41e8-4dcc-9af2-d37a98dd467f')
;

-- Mar 17, 2023, 1:34:40 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215778,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200383,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:40','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','48c9c712-f123-4531-957d-ed983667e86a','N')
;

-- Mar 17, 2023, 1:34:41 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215779,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200383,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:40','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','0cc337db-20e1-4e7a-bb51-4bc50cf4c6d2','N')
;

-- Mar 17, 2023, 1:34:41 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215780,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200383,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:41','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','7fd767de-9383-4733-b007-171c6011521e','N')
;

-- Mar 17, 2023, 1:34:42 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215781,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200383,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:41','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','b26ee963-280a-438f-9bf2-8ad6e9333d1d','N')
;

-- Mar 17, 2023, 1:34:42 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215782,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200383,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:42','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','c94550c9-6d87-46f3-b32b-1be64d9434e7','N')
;

-- Mar 17, 2023, 1:34:42 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215783,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200383,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:42','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','7ad894c2-b246-47bf-8060-f7257e8c5ede','N')
;

-- Mar 17, 2023, 1:34:43 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215784,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200383,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:42','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','56fdfbae-62af-4618-8442-81bf9c058081','N')
;

-- Mar 17, 2023, 1:34:43 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203793,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:43','YYYY-MM-DD HH24:MI:SS'),100,'TestUU_UU','TestUU_UU','TestUU_UU','D','b1f089f6-466f-4a40-89bf-0fbfa475301c')
;

-- Mar 17, 2023, 1:34:44 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215785,0.0,'TestUU_UU',200383,'TestUU_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:43','YYYY-MM-DD HH24:MI:SS'),100,203793,'Y','N','D','N','dc7709ed-c524-4610-aada-b67edf4ddf6a','N')
;

-- Mar 17, 2023, 1:34:44 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (215786,0.0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200383,'Value',40,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:44','YYYY-MM-DD HH24:MI:SS'),100,620,'Y','Y','D','N','b92de84e-ccbf-4a10-aa52-e91650636d4e',10,'N')
;

-- Mar 17, 2023, 1:34:44 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (215787,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200383,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:44','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','674c6f2b-91b6-4d04-816e-40c772853c7d',20,'N')
;

-- Mar 17, 2023, 1:34:45 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215788,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200383,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:44','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','N','D','N','4f383051-d64b-4457-ba7b-6386699fcda6','N')
;

-- Mar 17, 2023, 1:34:45 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215789,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200383,'Help',2000,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:34:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:34:45','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','d9291e97-85da-4817-816c-7efc9971dcce','N')
;

-- Mar 17, 2023, 1:35:40 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_TestUU', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-03-17 13:35:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215778
;

-- Mar 17, 2023, 1:35:40 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_TestUU', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-03-17 13:35:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215779
;

-- Mar 17, 2023, 1:35:40 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_TestUU', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-03-17 13:35:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215781
;

-- Mar 17, 2023, 1:35:40 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_TestUU', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-03-17 13:35:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215783
;

-- Mar 21, 2023, 12:00:02 PM CET
CREATE TABLE TestUU (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description VARCHAR2(255 CHAR) DEFAULT NULL , Help VARCHAR2(2000 CHAR) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR2(60 CHAR) NOT NULL, TestUU_UU VARCHAR2(36 CHAR) DEFAULT NULL , Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, Value VARCHAR2(40 CHAR) DEFAULT NULL , CONSTRAINT TestUU_UU_idx PRIMARY KEY (TestUU_UU))
;

-- Mar 17, 2023, 1:35:40 PM CET
ALTER TABLE TestUU ADD CONSTRAINT ADClient_TestUU FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 17, 2023, 1:35:40 PM CET
ALTER TABLE TestUU ADD CONSTRAINT ADOrg_TestUU FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 17, 2023, 1:35:40 PM CET
ALTER TABLE TestUU ADD CONSTRAINT CreatedBy_TestUU FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 17, 2023, 1:35:40 PM CET
ALTER TABLE TestUU ADD CONSTRAINT UpdatedBy_TestUU FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 17, 2023, 1:36:10 PM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200138,'Test UU Based Table',0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:10','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','2921802a-9dc1-4f96-82c2-49c5a3e0cba7')
;

-- Mar 17, 2023, 1:36:11 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200348,'Test UU Based Table',200138,10,'Y',200383,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','TestUU.Value','N',0,'N','D','Y','N','c3f2631d-4c03-479a-b117-c3b63ce7d88a')
;

-- Mar 17, 2023, 1:36:11 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207573,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200348,215778,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6d183212-b625-4279-a774-75879a79357e','Y',10,2)
;

-- Mar 17, 2023, 1:36:12 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207574,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200348,215779,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4d4b86aa-db82-4c2f-86fa-c95272048099','Y','Y',20,4,2)
;

-- Mar 17, 2023, 1:36:12 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207575,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200348,215786,'Y',40,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3785369b-0696-41fd-a3dd-33badee4e29c','Y',30,2)
;

-- Mar 17, 2023, 1:36:12 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207576,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200348,215787,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','55284ece-1182-4892-8bc0-5cb3ff8eb8a4','Y',40,5)
;

-- Mar 17, 2023, 1:36:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207577,'Description','Optional short description of the record','A description is limited to 255 characters.',200348,215788,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6e93839b-99b9-4d99-b573-3ad4d7111254','Y',50,5)
;

-- Mar 17, 2023, 1:36:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207578,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200348,215789,'Y',2000,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','546d1673-1e8b-44c9-bba1-d1d99069029c','Y',60,5)
;

-- Mar 17, 2023, 1:36:14 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207579,'TestUU_UU',200348,215785,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c1031159-ed74-4653-b230-73646a37f206','N',2)
;

-- Mar 17, 2023, 1:36:14 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207580,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200348,215784,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b1bd71c5-8051-4dd0-9fb9-f76cecf30279','Y',70,2,2)
;

-- Mar 17, 2023, 1:36:14 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200224,'Test UU Based Table','W',200138,0,0,'Y',TO_TIMESTAMP('2023-03-17 13:36:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 13:36:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','290332f2-20a2-455f-8b07-28758c4d8f47')
;

-- Mar 17, 2023, 1:36:14 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200224, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200224)
;

-- Mar 17, 2023, 1:36:14 PM CET
UPDATE AD_Table SET AD_Window_ID=200138,Updated=TO_TIMESTAMP('2023-03-17 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200383
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200224
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200218
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200168
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200169
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200221
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200222
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=21,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=22,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=23,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=24,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=25,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=26,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200161
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=27,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=28,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Mar 17, 2023, 1:36:54 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=29,Updated=TO_TIMESTAMP('2023-03-17 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200177
;

-- Mar 17, 2023, 7:37:47 PM CET
INSERT INTO TestUU (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,TestUU_UU,Value,Name) VALUES (0,0,TO_TIMESTAMP('2023-03-17 19:37:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 19:37:47','YYYY-MM-DD HH24:MI:SS'),100,'Y','4e148b89-bdd9-48a6-8a8a-7609092f965c','TRS','Test Record in System')
;

-- Mar 17, 2023, 7:38:31 PM CET
INSERT INTO TestUU (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,TestUU_UU,Value,Name) VALUES (11,0,TO_TIMESTAMP('2023-03-17 19:38:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-17 19:38:31','YYYY-MM-DD HH24:MI:SS'),100,'Y','8858ecc2-cf1d-405f-987f-793536037e76','TRGW','Test Record in GardenWorld')
;

