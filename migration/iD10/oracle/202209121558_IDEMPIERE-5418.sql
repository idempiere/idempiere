-- IDEMPIERE-5418
SELECT register_migration_script('202209121558_IDEMPIERE-5418.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 12, 2022, 3:58:34 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200361,'Chart Datasource Trl',53124,'AD_ChartDatasource_Trl',0,'6',0,0,'Y',TO_TIMESTAMP('2022-09-12 15:58:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 15:58:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','3ab4a856-21ab-4725-88a6-c390e70f328f','N','N','N','N','N')
;

-- Sep 12, 2022, 3:58:34 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_ChartDatasource_Trl',1000000,'N','N','Table AD_ChartDatasource_Trl','Y','Y',0,0,TO_TIMESTAMP('2022-09-12 15:58:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 15:58:34','YYYY-MM-DD HH24:MI:SS'),100,200429,'Y',1000000,1,200000,'06b87de0-351c-45d6-be61-d2970fe2cdf6')
;

-- Sep 12, 2022, 3:58:57 PM CEST
UPDATE AD_Table SET IsChangeLog='N',Updated=TO_TIMESTAMP('2022-09-12 15:58:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200361
;

-- Sep 12, 2022, 3:59:59 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215305,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200361,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-09-12 15:59:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 15:59:59','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','9507cdcf-8a0b-44a1-9776-5fafd6b2cb56','N',0,'N','N','D','N')
;

-- Sep 12, 2022, 4:00:02 PM CEST
CREATE TABLE AD_ChartDatasource_Trl (AD_Client_ID NUMBER(10) NOT NULL)
;

-- Sep 12, 2022, 4:00:37 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215306,0,'Chart Datasource',200361,'AD_ChartDatasource_ID',22,'N','Y','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:00:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:00:36','YYYY-MM-DD HH24:MI:SS'),100,54269,'N','N','D','N','N','N','Y','2d9f86a9-ce57-45b2-932b-4610818f99e7','Y',0,'N','N','N')
;

-- Sep 12, 2022, 4:00:40 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADChartDatasource_ADChartDatas', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-09-12 16:00:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215306
;

-- Sep 12, 2022, 4:00:40 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD AD_ChartDatasource_ID NUMBER(10) NOT NULL
;

-- Sep 12, 2022, 4:00:40 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD CONSTRAINT ADChartDatasource_ADChartDatas FOREIGN KEY (AD_ChartDatasource_ID) REFERENCES ad_chartdatasource(ad_chartdatasource_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 12, 2022, 4:01:12 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203660,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:01:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:01:12','YYYY-MM-DD HH24:MI:SS'),100,'AD_ChartDatasource_Trl_UU','AD_ChartDatasource_Trl_UU','AD_ChartDatasource_Trl_UU','D','bf502674-7faf-4cf8-85cd-2282be50287b')
;

-- Sep 12, 2022, 4:01:25 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215307,0,'AD_ChartDatasource_Trl_UU',200361,'AD_ChartDatasource_Trl_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:01:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:01:24','YYYY-MM-DD HH24:MI:SS'),100,203660,'Y','N','D','N','N','N','Y','05af1d8f-28a2-4a28-8361-20da06b49cbb','N',0,'N','N','N','N')
;

-- Sep 12, 2022, 4:01:27 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD AD_ChartDatasource_Trl_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Sep 12, 2022, 4:01:27 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD CONSTRAINT AD_ChartDatasource_Trl_UU_idx UNIQUE (AD_ChartDatasource_Trl_UU)
;

-- Sep 12, 2022, 4:02:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215308,0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200361,'AD_Language',6,'N','Y','Y','N','N',0,'N',18,106,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:02:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:02:15','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','N','N','Y','800807df-653a-4b1c-ae29-968052e3ec07','Y',0,'N','N','N','N')
;

-- Sep 12, 2022, 4:02:18 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADLanguage_ADChartDatasourceTr', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-09-12 16:02:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215308
;

-- Sep 12, 2022, 4:02:18 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD AD_Language VARCHAR2(6 CHAR) NOT NULL
;

-- Sep 12, 2022, 4:02:18 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD CONSTRAINT ADLanguage_ADChartDatasourceTr FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 12, 2022, 4:02:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215309,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200361,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:02:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:02:39','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','fcd1bbd3-87d6-4a6b-b639-f366d4da2a0c','N',0,'N','N','D','N')
;

-- Sep 12, 2022, 4:02:41 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Sep 12, 2022, 4:03:01 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215310,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200361,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:03:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:03:01','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','d0cd4a8d-e0e7-44a9-ab0a-815e02988ff9','N',0,'N','N','N')
;

-- Sep 12, 2022, 4:03:03 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- Sep 12, 2022, 4:03:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215311,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200361,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:03:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:03:17','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','38bd31ac-6203-43c1-bc73-8f54cc28e033','N',0,'N','N','D','N')
;

-- Sep 12, 2022, 4:03:19 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD CreatedBy NUMBER(10) NOT NULL
;

-- Sep 12, 2022, 4:05:34 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215314,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200361,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:05:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:05:33','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','f1a2a422-cc56-4b33-a5d2-2d2c6bb00bfc','N',0,'N','N','N')
;

-- Sep 12, 2022, 4:05:38 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Sep 12, 2022, 4:06:07 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215315,0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200361,'IsTranslated',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:06:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:06:07','YYYY-MM-DD HH24:MI:SS'),100,420,'Y','N','D','N','N','N','Y','bba3fcdb-5ddb-40f3-ae70-fbd5fd5396f3','Y',0,'N','N','N')
;

-- Sep 12, 2022, 4:06:08 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD IsTranslated CHAR(1) CHECK (IsTranslated IN ('Y','N')) NOT NULL
;

-- Sep 12, 2022, 4:06:25 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215316,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200361,'Name',60,'N','N','Y','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:06:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:06:25','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','4b244d17-b3be-4397-a00c-9f4b208ed515','Y',20,'N','N','N')
;

-- Sep 12, 2022, 4:06:26 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD Name VARCHAR2(60 CHAR) NOT NULL
;

-- Sep 12, 2022, 4:06:52 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215317,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200361,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:06:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:06:51','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','a90def38-572c-4b1e-af52-7f3f5138412a','N',0,'N','N','N')
;

-- Sep 12, 2022, 4:06:54 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- Sep 12, 2022, 4:07:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215318,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200361,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:07:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:07:10','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','fa0b922d-8f8f-4c10-99b5-f9cfb9437ff2','N',0,'N','N','D','N')
;

-- Sep 12, 2022, 4:07:11 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Sep 12, 2022, 4:08:32 PM CEST
UPDATE AD_Tab SET SeqNo=40,Updated=TO_TIMESTAMP('2022-09-12 16:08:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200132
;

-- Sep 12, 2022, 4:08:36 PM CEST
UPDATE AD_Tab SET SeqNo=30,Updated=TO_TIMESTAMP('2022-09-12 16:08:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53340
;

-- Sep 12, 2022, 4:10:03 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200329,'Datasource Translation',53124,20,'Y',200361,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:10:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:10:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',2,'N','D','Y','N','b83aeaa9-d0be-40d8-8c12-d87df5d184c9','B','N','Y',0)
;

-- Sep 12, 2022, 4:10:17 PM CEST
UPDATE AD_Tab SET SeqNo=20,Updated=TO_TIMESTAMP('2022-09-12 16:10:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53340
;

-- Sep 12, 2022, 4:10:21 PM CEST
UPDATE AD_Tab SET SeqNo=30,Updated=TO_TIMESTAMP('2022-09-12 16:10:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200329
;

-- Sep 12, 2022, 4:10:38 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207204,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200329,215305,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 16:10:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:10:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d04e878b-37c8-40dc-a3bb-fee1a35c5d6b','Y',10,2)
;

-- Sep 12, 2022, 4:10:39 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207205,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200329,215309,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 16:10:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:10:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0dbe9b33-1697-43e5-bf84-ca96a7f16ada','Y','N',4,2)
;

-- Sep 12, 2022, 4:10:39 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207206,'Chart Datasource',200329,215306,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 16:10:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:10:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6f61d1ff-f165-4202-918a-0cc0ae26a6a6','Y',20,2)
;

-- Sep 12, 2022, 4:10:39 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207207,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200329,215308,'Y',6,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 16:10:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:10:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','42c90238-9d14-480e-8418-e7e7e85e386f','Y',30,2)
;

-- Sep 12, 2022, 4:10:39 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207208,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200329,215316,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 16:10:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:10:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e3acd1ba-f5b8-47bb-ae3e-36ebd944e5d1','Y',40,5)
;

-- Sep 12, 2022, 4:10:40 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207211,'AD_ChartDatasource_Trl_UU',200329,215307,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 16:10:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:10:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e2adee95-cb5b-4f07-982f-a8c811e8b201','N',2)
;

-- Sep 12, 2022, 4:10:41 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207212,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200329,215315,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 16:10:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:10:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c7a92592-a285-4e1c-a57f-c9b3273ef037','Y',70,2,2)
;

-- Sep 12, 2022, 4:10:41 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207213,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200329,215314,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 16:10:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:10:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ca783c6c-a8ec-4e9c-9955-a43828e99077','Y',80,2,2)
;

-- Sep 12, 2022, 4:16:25 PM CEST
UPDATE AD_Field SET SeqNo=10, IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 16:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207204
;

-- Sep 12, 2022, 4:16:25 PM CEST
UPDATE AD_Field SET SeqNo=20, IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 16:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207205
;

-- Sep 12, 2022, 4:16:25 PM CEST
UPDATE AD_Field SET SeqNo=30, IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 16:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207206
;

-- Sep 12, 2022, 4:16:25 PM CEST
UPDATE AD_Field SET SeqNo=40, IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 16:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207207
;

-- Sep 12, 2022, 4:16:25 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 16:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207212
;

-- Sep 12, 2022, 4:16:25 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 16:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207213
;

-- Sep 12, 2022, 4:20:30 PM CEST
UPDATE AD_Column SET IsTranslated='Y', IsToolbarButton='N',Updated=TO_TIMESTAMP('2022-09-12 16:20:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59678
;

-- Sep 13, 2022, 11:13:31 AM CEST
UPDATE AD_Tab SET IsTranslationTab='Y',Updated=TO_TIMESTAMP('2022-09-13 11:13:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200329
;

-- Sep 13, 2022, 11:16:59 AM CEST
UPDATE AD_Tab SET AD_Column_ID=215306,Updated=TO_TIMESTAMP('2022-09-13 11:16:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200329
;

-- Sep 13, 2022, 11:17:17 AM CEST
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2022-09-13 11:17:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200329
;

-- Sep 13, 2022, 11:20:49 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADChartDatasourceADChartDatas',Updated=TO_TIMESTAMP('2022-09-13 11:20:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215306
;

-- Sep 13, 2022, 11:21:11 AM CEST
ALTER TABLE AD_ChartDatasource_Trl MODIFY AD_ChartDatasource_ID NUMBER(10)
;

-- Sep 13, 2022, 11:21:11 AM CEST
ALTER TABLE AD_ChartDatasource_Trl DROP CONSTRAINT adchartdatasource_adchartdatas
;

-- Sep 13, 2022, 11:21:11 AM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD CONSTRAINT ADChartDatasourceADChartDatas FOREIGN KEY (AD_ChartDatasource_ID) REFERENCES ad_chartdatasource(ad_chartdatasource_id) DEFERRABLE INITIALLY DEFERRED
;

