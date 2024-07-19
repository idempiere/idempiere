-- IDEMPIERE-5259 - Labels feature
SELECT register_migration_script('202205131118_IDEMPIERE-5259.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 13, 2022, 11:18:40 AM BRT
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200343,'Label Category','Category of a Label','AD_LabelCategory',0,'6',0,0,'Y',TO_TIMESTAMP('2022-05-13 11:18:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:18:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','N','N','D','N','Y','L','N','Y','8d7d25d9-ff82-4ae6-be5f-ba91b6b5f8f8','N','N','N','N')
;

-- May 13, 2022, 11:18:41 AM BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_LabelCategory',1000000,'N','N','Table AD_LabelCategory','Y','Y',0,0,TO_TIMESTAMP('2022-05-13 11:18:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:18:40','YYYY-MM-DD HH24:MI:SS'),10,200411,'Y',1000000,1,200000,'bab419bd-7722-48be-b218-17a90b6de0e4')
;

-- May 13, 2022, 11:20:49 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203589,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:20:49','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:20:49','YYYY-MM-DD HH24:MI:SS'),10,'AD_LabelCategory_ID','Label Category','Category of a Label','Identifies the category which this label belongs to.','Label Category','D','8dfa237a-1a47-4c54-964a-6456d1f24649')
;

-- May 13, 2022, 11:21:05 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203590,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:21:04','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:21:04','YYYY-MM-DD HH24:MI:SS'),10,'AD_LabelCategory_UU','Label Category','Category of a Label','Identifies the category which this label belongs to.','Label Category','D','dbd35027-2b0c-4e30-ae9e-7eb780c3190b')
;

-- May 13, 2022, 11:21:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214840,0,'Label Category','Category of a Label','Identifies the category which this label belongs to.',200343,'AD_LabelCategory_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:21:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:21:21','YYYY-MM-DD HH24:MI:SS'),10,203589,'N','N','D','N','N','N','Y','11e85825-5c7b-46cd-aef6-a4e905363c1b','N',0,'N','N','N','N')
;

-- May 13, 2022, 11:21:23 AM BRT
CREATE TABLE AD_LabelCategory (AD_LabelCategory_ID NUMBER(10) DEFAULT NULL , CONSTRAINT AD_LabelCategory_Key PRIMARY KEY (AD_LabelCategory_ID))
;

-- May 13, 2022, 11:21:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214841,0,'Label Category','Category of a Label','Identifies the category which this label belongs to.',200343,'AD_LabelCategory_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:21:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:21:34','YYYY-MM-DD HH24:MI:SS'),10,203590,'N','N','D','N','N','N','Y','5edbd6c7-cb89-4657-bd0d-2e961ae7bca3','N',0,'N','N','N','N')
;

-- May 13, 2022, 11:21:36 AM BRT
ALTER TABLE AD_LabelCategory ADD AD_LabelCategory_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 13, 2022, 11:21:37 AM BRT
ALTER TABLE AD_LabelCategory ADD CONSTRAINT AD_LabelCategory_UU_idx UNIQUE (AD_LabelCategory_UU)
;

-- May 13, 2022, 11:21:57 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214842,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200343,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:21:57','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:21:57','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','D','N','N','N','Y','8b76f511-26f1-43a2-8034-65505c1e728e','N',0,'N','N','D','N')
;

-- May 13, 2022, 11:21:59 AM BRT
ALTER TABLE AD_LabelCategory ADD AD_Client_ID NUMBER(10) DEFAULT NULL 
;

-- May 13, 2022, 11:22:09 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214843,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200343,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:22:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:22:08','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','N','N','Y','011208eb-83c1-49bd-9895-1eb80b414b4d','N',0,'N','N','D','N')
;

-- May 13, 2022, 11:22:10 AM BRT
ALTER TABLE AD_LabelCategory ADD AD_Org_ID NUMBER(10) DEFAULT NULL 
;

-- May 13, 2022, 11:22:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214844,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200343,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:22:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:22:21','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','N','N','Y','b4d3e4bc-55ab-4ad3-a115-d79adc0f2025','N',0,'N','N','N')
;

-- May 13, 2022, 11:22:24 AM BRT
ALTER TABLE AD_LabelCategory ADD Created DATE DEFAULT SYSDATE
;

-- May 13, 2022, 11:22:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214845,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200343,'CreatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:22:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:22:35','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','N','N','Y','fb3b4534-5fe9-4e1b-b36e-07ec19382443','N',0,'N','N','D','N')
;

-- May 13, 2022, 11:22:37 AM BRT
ALTER TABLE AD_LabelCategory ADD CreatedBy NUMBER(10) DEFAULT NULL 
;

-- May 13, 2022, 11:22:48 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214846,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200343,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:22:47','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:22:47','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','N','N','Y','b29b98a8-db2b-4036-948d-b83b110350f5','N',0,'N','N','N')
;

-- May 13, 2022, 11:22:49 AM BRT
ALTER TABLE AD_LabelCategory ADD Updated DATE DEFAULT SYSDATE
;

-- May 13, 2022, 11:23:11 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214847,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200343,'UpdatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:23:10','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:23:10','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','N','N','Y','c9f7cd50-4f77-4d80-aaf4-78653ab0214f','N',0,'N','N','D','N')
;

-- May 13, 2022, 11:23:13 AM BRT
ALTER TABLE AD_LabelCategory ADD UpdatedBy NUMBER(10) DEFAULT NULL 
;

-- May 13, 2022, 11:23:24 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214848,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200343,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:23:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:23:23','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','N','N','Y','bb86da86-ed0d-48c9-a279-66c71d3b8793','N',0,'N','N','N')
;

-- May 13, 2022, 11:23:26 AM BRT
ALTER TABLE AD_LabelCategory ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N'))
;

-- May 13, 2022, 11:26:09 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214849,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200343,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:26:09','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:26:09','YYYY-MM-DD HH24:MI:SS'),10,275,'Y','Y','D','N','N','N','Y','0a52d6ad-da73-40df-97ac-6d6a403efa65','Y',10,'N','N','N')
;

-- May 13, 2022, 11:26:11 AM BRT
ALTER TABLE AD_LabelCategory ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- May 13, 2022, 11:26:54 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214850,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200343,'Name',60,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:26:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:26:48','YYYY-MM-DD HH24:MI:SS'),10,469,'Y','Y','D','N','N','N','Y','e94eddd7-5311-4b90-95d3-bc94b27ff4ab','Y',20,'N','N','N')
;

-- May 13, 2022, 11:27:03 AM BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-05-13 11:27:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214850
;

-- May 13, 2022, 11:27:14 AM BRT
ALTER TABLE AD_LabelCategory ADD Name VARCHAR2(60 CHAR) NOT NULL
;

-- May 13, 2022, 11:27:58 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214851,0,'Label Style','Label CSS Style',200343,'AD_LabelStyle_ID',10,'N','N','N','N','N',0,'N',18,200121,0,0,'Y',TO_TIMESTAMP('2022-05-13 11:27:57','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 11:27:57','YYYY-MM-DD HH24:MI:SS'),10,203011,'Y','N','D','N','N','N','Y','3bcc854e-e087-4a77-991a-3623b233e841','Y',0,'N','N','N','N')
;

-- May 13, 2022, 11:28:00 AM BRT
UPDATE AD_Column SET FKConstraintName='ADLabelStyle_CLabelCategory', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-05-13 11:28:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214851
;

-- May 13, 2022, 11:28:00 AM BRT
ALTER TABLE AD_LabelCategory ADD AD_LabelStyle_ID NUMBER(10) DEFAULT NULL 
;

-- May 13, 2022, 11:28:00 AM BRT
ALTER TABLE AD_LabelCategory ADD CONSTRAINT ADLabelStyle_CLabelCategory FOREIGN KEY (AD_LabelStyle_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2022, 1:07:24 PM BRT
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2022-05-13 13:07:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214850
;

-- May 13, 2022, 1:10:05 PM BRT
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2022-05-13 13:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214849
;

-- May 13, 2022, 1:10:52 PM BRT
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200344,'Label Category Trl','Category of a Label Trl','AD_LabelCategory_Trl','6',0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:51','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:51','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','N','D','Y','L','e8d3027c-e842-4d4c-9bb6-c3d5c52ef152','N')
;

-- May 13, 2022, 1:10:52 PM BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_LabelCategory_Trl',1000000,'N','N','Table AD_LabelCategory_Trl','Y','Y',0,0,TO_TIMESTAMP('2022-05-13 13:10:52','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:52','YYYY-MM-DD HH24:MI:SS'),10,200412,'Y',1000000,1,200000,'f7a0f1d6-cf6e-4eb3-9ae8-f5ee7a09fc7a')
;

-- May 13, 2022, 1:10:53 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214852,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200344,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:52','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:52','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','1=1','D','N','e2d814e3-245c-4220-be46-36f11bce8992','N')
;

-- May 13, 2022, 1:10:53 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214853,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200344,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:53','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:53','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','87b323c2-d2f8-44a3-b422-c8cd32c657dc','N')
;

-- May 13, 2022, 1:10:54 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214854,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200344,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:53','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:53','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','e5341abe-0c1d-48c4-8ae7-94b1fbbac6a6','N')
;

-- May 13, 2022, 1:10:54 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214855,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200344,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:54','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:54','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','8e55dced-75f2-49d0-86b9-c2233e311b87','N')
;

-- May 13, 2022, 1:10:54 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214856,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200344,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:54','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:54','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','d0cddc95-ead3-4d9e-9596-969d013a0e62','N')
;

-- May 13, 2022, 1:10:55 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214857,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200344,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:55','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:55','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','96aa9b94-3afe-45b4-9854-f5aec213751d','N')
;

-- May 13, 2022, 1:10:55 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214858,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200344,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:55','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:55','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','4108a8d0-61dc-43c9-8b94-3d2d37500ffc','N')
;

-- May 13, 2022, 1:10:56 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214859,0.0,'Label Category','Category of a Label','Identifies the category which this label belongs to.',200344,'AD_LabelCategory_ID',10,'N','Y','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:55','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:55','YYYY-MM-DD HH24:MI:SS'),10,203589,'N','N','D','N','20022acb-0fd9-41a2-884b-ed64e7a524bb','N','C')
;

-- May 13, 2022, 1:10:56 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203591,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:56','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:56','YYYY-MM-DD HH24:MI:SS'),10,'AD_LabelCategory_Trl_UU','AD_LabelCategory_Trl_UU','AD_LabelCategory_Trl_UU','D','3bff663c-233f-4166-974f-cd4ea3aca21f')
;

-- May 13, 2022, 1:10:57 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214860,0.0,'AD_LabelCategory_Trl_UU',200344,'AD_LabelCategory_Trl_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:56','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:56','YYYY-MM-DD HH24:MI:SS'),10,203591,'Y','N','D','N','28f0df30-e82c-4da8-8e84-8a8f75c2dc93','N')
;

-- May 13, 2022, 1:10:58 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214861,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200344,'AD_Language',6,'N','Y','Y','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:57','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:57','YYYY-MM-DD HH24:MI:SS'),10,109,'N','N','D','N','00899065-fc92-4340-a290-066cba0915cc','N')
;

-- May 13, 2022, 1:10:58 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214862,0.0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200344,'IsTranslated','N',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:58','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:58','YYYY-MM-DD HH24:MI:SS'),10,420,'Y','N','D','N','093cb927-6ffd-4b7c-9bfd-dc28dbf3e773','N')
;

-- May 13, 2022, 1:10:59 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214863,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200344,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:58','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:58','YYYY-MM-DD HH24:MI:SS'),10,275,'Y','N','D','N','cb14847f-9f1b-435d-9fed-495e391c439e','N')
;

-- May 13, 2022, 1:10:59 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214864,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200344,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2022-05-13 13:10:59','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-13 13:10:59','YYYY-MM-DD HH24:MI:SS'),10,469,'Y','Y','D','N','24434a29-cd40-4c0f-bda6-aad5cd6e9753',10,'N')
;

-- May 13, 2022, 1:11:00 PM BRT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201118,'1f37e22e-4935-4273-b057-cb3bfd26d4c4',TO_TIMESTAMP('2022-05-13 13:10:59','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','AD_LabelCategory_Trl_pkey',TO_TIMESTAMP('2022-05-13 13:10:59','YYYY-MM-DD HH24:MI:SS'),10,200344,'Y','Y','N','Y')
;

-- May 13, 2022, 1:11:00 PM BRT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201493,'3e48e4a1-223b-4856-b1e6-2b1cbcca3e07',TO_TIMESTAMP('2022-05-13 13:11:00','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2022-05-13 13:11:00','YYYY-MM-DD HH24:MI:SS'),10,214861,201118,1)
;

-- May 13, 2022, 1:11:00 PM BRT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201494,'1e04a4ea-caff-4cf3-a544-e1e62fd1198c',TO_TIMESTAMP('2022-05-13 13:11:00','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2022-05-13 13:11:00','YYYY-MM-DD HH24:MI:SS'),10,214859,201118,2)
;

-- May 16, 2022, 9:47:36 AM BRT
CREATE TABLE AD_LabelCategory_Trl (AD_Client_ID NUMBER(10) NOT NULL, AD_LabelCategory_ID NUMBER(10) NOT NULL, AD_LabelCategory_Trl_UU VARCHAR2(36 CHAR) DEFAULT NULL , AD_Language VARCHAR2(6 CHAR) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description VARCHAR2(255 CHAR) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR2(60 CHAR) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_LabelCategory_Trl_UU_idx UNIQUE (AD_LabelCategory_Trl_UU))
;

-- May 16, 2022, 9:47:36 AM BRT
ALTER TABLE AD_LabelCategory_Trl ADD CONSTRAINT ADClient_ADLabelCategoryTrl FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 9:47:36 AM BRT
ALTER TABLE AD_LabelCategory_Trl ADD CONSTRAINT ADLabelCategory_ADLabelCategor FOREIGN KEY (AD_LabelCategory_ID) REFERENCES ad_labelcategory(ad_labelcategory_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 9:47:36 AM BRT
ALTER TABLE AD_LabelCategory_Trl ADD CONSTRAINT ADLanguage_ADLabelCategoryTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 9:47:36 AM BRT
ALTER TABLE AD_LabelCategory_Trl ADD CONSTRAINT ADOrg_ADLabelCategoryTrl FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 9:47:36 AM BRT
ALTER TABLE AD_LabelCategory_Trl ADD CONSTRAINT CreatedBy_ADLabelCategoryTrl FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 9:47:36 AM BRT
ALTER TABLE AD_LabelCategory_Trl ADD CONSTRAINT UpdatedBy_ADLabelCategoryTrl FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 9:48:43 AM BRT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing) VALUES (0,0,201119,'a3ee7ea1-7935-4687-98f7-d0afea3b7ce4',TO_TIMESTAMP('2022-05-16 09:48:42','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','ad_labelcategory_trl_uu_idx',TO_TIMESTAMP('2022-05-16 09:48:42','YYYY-MM-DD HH24:MI:SS'),10,200344,'N','Y','N')
;

-- May 16, 2022, 9:48:43 AM BRT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201495,'00fe8bcf-8178-49e2-a1a4-d1c80e41492e',TO_TIMESTAMP('2022-05-16 09:48:43','YYYY-MM-DD HH24:MI:SS'),10,'Y',TO_TIMESTAMP('2022-05-16 09:48:43','YYYY-MM-DD HH24:MI:SS'),10,214860,201119,1)
;

-- May 16, 2022, 9:48:43 AM BRT
ALTER TABLE AD_LabelCategory_Trl ADD CONSTRAINT AD_LabelCategory_Trl_pkey PRIMARY KEY (AD_Language,AD_LabelCategory_ID)
;

-- May 16, 2022, 9:51:11 AM BRT
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200345,'Label','Record Label','AD_Label',0,'6',0,0,'Y',TO_TIMESTAMP('2022-05-16 09:51:10','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:51:10','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','Y','N','D','N','Y','L','N','Y','a6c4c13f-73fc-4c78-be0f-4c0d052ddbd8','N','N','N','N')
;

-- May 16, 2022, 9:51:12 AM BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Label',1000000,'N','N','Table AD_Label','Y','Y',0,0,TO_TIMESTAMP('2022-05-16 09:51:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:51:11','YYYY-MM-DD HH24:MI:SS'),10,200413,'Y',1000000,1,200000,'d8d6d09d-eae9-4ab6-a3ff-0a73e50f3a45')
;

-- May 16, 2022, 9:52:35 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203592,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:52:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:52:34','YYYY-MM-DD HH24:MI:SS'),10,'AD_Label_ID','Label','Record Label','Label','D','bc4f6ac2-ebb3-46e2-aaca-12efacf059cc')
;

-- May 16, 2022, 9:52:41 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203593,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:52:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:52:41','YYYY-MM-DD HH24:MI:SS'),10,'AD_Label_UU','Label','Record Label','Label','D','5d21d4cf-0aab-4340-a930-f9374a2dba1d')
;

-- May 16, 2022, 9:52:59 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214865,0,'Label','Record Label',200345,'AD_Label_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:52:58','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:52:58','YYYY-MM-DD HH24:MI:SS'),10,203592,'N','N','D','N','N','N','Y','5af55b82-b90e-415a-a9a4-4a6fce441ac0','N',0,'N','N','N','N')
;

-- May 16, 2022, 9:53:00 AM BRT
CREATE TABLE AD_Label (AD_Label_ID NUMBER(10) DEFAULT NULL , CONSTRAINT AD_Label_Key PRIMARY KEY (AD_Label_ID))
;

-- May 16, 2022, 9:53:10 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214866,0,'Label','Record Label',200345,'AD_Label_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:53:09','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:53:09','YYYY-MM-DD HH24:MI:SS'),10,203593,'N','N','D','N','N','N','Y','8d1b8d1c-1900-41cd-8c4e-97206633b5bd','N',0,'N','N','N','N')
;

-- May 16, 2022, 9:53:11 AM BRT
ALTER TABLE AD_Label ADD AD_Label_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 16, 2022, 9:53:11 AM BRT
ALTER TABLE AD_Label ADD CONSTRAINT AD_Label_UU_idx UNIQUE (AD_Label_UU)
;

-- May 16, 2022, 9:53:20 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214867,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200345,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:53:19','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:53:19','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','D','N','N','N','Y','4d84cd2e-c1e9-479a-851e-39bb3f584623','N',0,'N','N','D','N')
;

-- May 16, 2022, 9:53:21 AM BRT
ALTER TABLE AD_Label ADD AD_Client_ID NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 9:53:29 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214868,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200345,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:53:29','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:53:29','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','N','N','Y','ae938961-d6c5-4377-abeb-952e357c1c90','N',0,'N','N','D','N')
;

-- May 16, 2022, 9:53:31 AM BRT
ALTER TABLE AD_Label ADD AD_Org_ID NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 9:53:43 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214869,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200345,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:53:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:53:42','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','N','N','Y','451a7278-5b82-4ae6-b81e-e7a9266e65de','N',0,'N','N','N')
;

-- May 16, 2022, 9:53:44 AM BRT
ALTER TABLE AD_Label ADD Created DATE DEFAULT SYSDATE
;

-- May 16, 2022, 9:53:54 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214870,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200345,'CreatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:53:54','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:53:54','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','N','N','Y','cd1cfe10-6600-49b1-8f2e-c226b0fcadfa','N',0,'N','N','D','N')
;

-- May 16, 2022, 9:53:55 AM BRT
ALTER TABLE AD_Label ADD CreatedBy NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 9:54:07 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214871,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200345,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:54:06','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:54:06','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','N','N','Y','0190060d-869e-454a-892f-8511a9968084','N',0,'N','N','N')
;

-- May 16, 2022, 9:54:08 AM BRT
ALTER TABLE AD_Label ADD Updated DATE DEFAULT SYSDATE
;

-- May 16, 2022, 9:54:18 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214872,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200345,'UpdatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:54:17','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:54:17','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','N','N','Y','f757eafd-1872-4fd0-9ef4-e2ac111ef14a','N',0,'N','N','D','N')
;

-- May 16, 2022, 9:54:19 AM BRT
ALTER TABLE AD_Label ADD UpdatedBy NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 9:54:28 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214873,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200345,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:54:28','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:54:28','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','N','N','Y','6757a19f-fa5a-4909-974c-b0d9a690bb41','N',0,'N','N','N')
;

-- May 16, 2022, 9:54:29 AM BRT
ALTER TABLE AD_Label ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N'))
;

-- May 16, 2022, 9:54:49 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214874,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200345,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:54:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:54:48','YYYY-MM-DD HH24:MI:SS'),10,275,'Y','Y','D','N','N','N','Y','eb86b4a4-b1b3-4bfc-8c7c-6a3465308b56','Y',10,'N','N','N')
;

-- May 16, 2022, 9:54:50 AM BRT
ALTER TABLE AD_Label ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- May 16, 2022, 9:55:07 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214875,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200345,'Name',60,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:55:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:55:07','YYYY-MM-DD HH24:MI:SS'),10,469,'Y','Y','D','N','N','N','Y','0eeb6f0a-2e9b-406f-be8e-3eefd69f2794','Y',20,'N','N','N')
;

-- May 16, 2022, 9:55:12 AM BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-05-16 09:55:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214875
;

-- May 16, 2022, 9:55:14 AM BRT
ALTER TABLE AD_Label ADD Name VARCHAR2(60 CHAR) NOT NULL
;

-- May 16, 2022, 9:56:06 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214876,0,'Label Category','Category of a Label','Identifies the category which this label belongs to.',200345,'AD_LabelCategory_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:56:05','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:56:05','YYYY-MM-DD HH24:MI:SS'),10,203589,'Y','N','D','N','N','N','Y','00738df6-68db-4eeb-b282-252cdca5f012','Y',0,'N','N','N','N')
;

-- May 16, 2022, 9:56:08 AM BRT
UPDATE AD_Column SET FKConstraintName='ADLabelCategory_ADLabel', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-05-16 09:56:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214876
;

-- May 16, 2022, 9:56:08 AM BRT
ALTER TABLE AD_Label ADD AD_LabelCategory_ID NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 9:56:08 AM BRT
ALTER TABLE AD_Label ADD CONSTRAINT ADLabelCategory_ADLabel FOREIGN KEY (AD_LabelCategory_ID) REFERENCES ad_labelcategory(ad_labelcategory_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 9:56:29 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214877,0,'Label Style','Label CSS Style',200345,'AD_LabelStyle_ID',10,'N','N','N','N','N',0,'N',18,200121,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:56:28','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:56:28','YYYY-MM-DD HH24:MI:SS'),10,203011,'Y','N','D','N','N','N','Y','1f70261c-8a78-40de-82d9-ce6fd8f3a1d3','Y',0,'N','N','N','N')
;

-- May 16, 2022, 9:56:30 AM BRT
UPDATE AD_Column SET FKConstraintName='ADLabelStyle_ADLabel', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-05-16 09:56:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214877
;

-- May 16, 2022, 9:56:30 AM BRT
ALTER TABLE AD_Label ADD AD_LabelStyle_ID NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 9:56:30 AM BRT
ALTER TABLE AD_Label ADD CONSTRAINT ADLabelStyle_ADLabel FOREIGN KEY (AD_LabelStyle_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 9:57:32 AM BRT
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2022-05-16 09:57:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214874
;

-- May 16, 2022, 9:57:43 AM BRT
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2022-05-16 09:57:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214875
;

-- May 16, 2022, 9:58:20 AM BRT
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200346,'Label Trl','Record Label Trl','AD_Label_Trl','6',0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:19','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:19','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','N','D','Y','L','442fe197-6c17-4f78-be70-da69b541f604','N')
;

-- May 16, 2022, 9:58:20 AM BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Label_Trl',1000000,'N','N','Table AD_Label_Trl','Y','Y',0,0,TO_TIMESTAMP('2022-05-16 09:58:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:20','YYYY-MM-DD HH24:MI:SS'),10,200414,'Y',1000000,1,200000,'07bf956f-da74-41b3-aec7-1dfb08152eac')
;

-- May 16, 2022, 9:58:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214878,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200346,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:20','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','1=1','D','N','ee0fb99d-9a18-4b81-9ab5-dac4e0ca16db','N')
;

-- May 16, 2022, 9:58:21 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214879,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200346,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:21','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','25033204-c4b3-4ac5-ae41-d4e29e20eba5','N')
;

-- May 16, 2022, 9:58:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214880,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200346,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:21','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','f069e7c5-9721-4b0a-97b5-ca554adc9553','N')
;

-- May 16, 2022, 9:58:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214881,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200346,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:22','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:22','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','04551a6a-77f5-445c-9802-c41964a4fb86','N')
;

-- May 16, 2022, 9:58:23 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214882,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200346,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:22','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:22','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','12310eea-000f-4018-ac6a-fb22c8f25bd8','N')
;

-- May 16, 2022, 9:58:23 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214883,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200346,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:23','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','69703e1f-79d5-48ac-972d-65f4f94acf60','N')
;

-- May 16, 2022, 9:58:23 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214884,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200346,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:23','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','3ab8d9b7-070e-4080-8e3d-189a721fe064','N')
;

-- May 16, 2022, 9:58:24 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214885,0.0,'Label','Record Label',200346,'AD_Label_ID',10,'N','Y','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:23','YYYY-MM-DD HH24:MI:SS'),10,203592,'N','N','D','N','a8cae4fd-ae35-4a32-bb86-08baf356a3b5','N','C')
;

-- May 16, 2022, 9:58:24 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203594,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:24','YYYY-MM-DD HH24:MI:SS'),10,'AD_Label_Trl_UU','AD_Label_Trl_UU','AD_Label_Trl_UU','D','2ca2cab5-651f-4c6e-80d7-963f2b8ec440')
;

-- May 16, 2022, 9:58:25 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214886,0.0,'AD_Label_Trl_UU',200346,'AD_Label_Trl_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:24','YYYY-MM-DD HH24:MI:SS'),10,203594,'Y','N','D','N','2a254844-432c-40f0-b11d-43dc26a587d8','N')
;

-- May 16, 2022, 9:58:25 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214887,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200346,'AD_Language',6,'N','Y','Y','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:25','YYYY-MM-DD HH24:MI:SS'),10,109,'N','N','D','N','4950a32e-f1b2-4dab-920b-4d88e706d5db','N')
;

-- May 16, 2022, 9:58:26 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214888,0.0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200346,'IsTranslated','N',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:25','YYYY-MM-DD HH24:MI:SS'),10,420,'Y','N','D','N','8f4cfdfc-52ae-4273-9259-2e36af0095b0','N')
;

-- May 16, 2022, 9:58:26 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214889,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200346,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:26','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:26','YYYY-MM-DD HH24:MI:SS'),10,275,'Y','N','D','N','7a18dcc3-e375-4a82-a957-090d8bb4db7b','N')
;

-- May 16, 2022, 9:58:27 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214890,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200346,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2022-05-16 09:58:26','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 09:58:26','YYYY-MM-DD HH24:MI:SS'),10,469,'Y','Y','D','N','5e09f949-cbed-407d-a216-3d2d676a3f2c',10,'N')
;

-- May 16, 2022, 10:07:42 AM BRT
CREATE TABLE AD_Label_Trl (AD_Client_ID NUMBER(10) NOT NULL, AD_Label_ID NUMBER(10) NOT NULL, AD_Label_Trl_UU VARCHAR2(36 CHAR) DEFAULT NULL , AD_Language VARCHAR2(6 CHAR) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description VARCHAR2(255 CHAR) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR2(60 CHAR) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_Label_Trl_UU_idx UNIQUE (AD_Label_Trl_UU))
;

-- May 16, 2022, 10:07:42 AM BRT
ALTER TABLE AD_Label_Trl ADD CONSTRAINT ADClient_ADLabelTrl FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 10:07:42 AM BRT
ALTER TABLE AD_Label_Trl ADD CONSTRAINT ADLabel_ADLabelTrl FOREIGN KEY (AD_Label_ID) REFERENCES ad_label(ad_label_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 10:07:42 AM BRT
ALTER TABLE AD_Label_Trl ADD CONSTRAINT ADLanguage_ADLabelTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 10:07:42 AM BRT
ALTER TABLE AD_Label_Trl ADD CONSTRAINT ADOrg_ADLabelTrl FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 10:07:42 AM BRT
ALTER TABLE AD_Label_Trl ADD CONSTRAINT CreatedBy_ADLabelTrl FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 10:07:42 AM BRT
ALTER TABLE AD_Label_Trl ADD CONSTRAINT UpdatedBy_ADLabelTrl FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 10:08:05 AM BRT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing) VALUES (0,0,201121,'9ca26156-5f14-43f2-9516-381a85a27dba',TO_TIMESTAMP('2022-05-16 10:08:04','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','ad_label_trl_uu_idx',TO_TIMESTAMP('2022-05-16 10:08:04','YYYY-MM-DD HH24:MI:SS'),10,200346,'N','Y','N')
;

-- May 16, 2022, 10:08:05 AM BRT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201498,'2f522b7c-9487-4a35-8463-03bfc45771ed',TO_TIMESTAMP('2022-05-16 10:08:05','YYYY-MM-DD HH24:MI:SS'),10,'Y',TO_TIMESTAMP('2022-05-16 10:08:05','YYYY-MM-DD HH24:MI:SS'),10,214886,201121,1)
;

-- May 16, 2022, 10:08:05 AM BRT
ALTER TABLE AD_Label_Trl ADD CONSTRAINT AD_Label_Trl_pkey PRIMARY KEY (AD_Language,AD_Label_ID)
;

-- May 16, 2022, 10:12:09 AM BRT
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200347,'Label Assignment','AD_LabelAssignment',0,'6',0,0,'Y',TO_TIMESTAMP('2022-05-16 10:12:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:12:08','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','Y','N','D','N','Y','L','N','Y','7df38426-2bad-4064-879a-548d47606959','N','N','N','N')
;

-- May 16, 2022, 10:12:09 AM BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_LabelAssignment',1000000,'N','N','Table AD_LabelAssignment','Y','Y',0,0,TO_TIMESTAMP('2022-05-16 10:12:09','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:12:09','YYYY-MM-DD HH24:MI:SS'),10,200415,'Y',1000000,1,200000,'7bd27d64-cc9a-466d-8a09-39aa7cfdd5cf')
;

-- May 16, 2022, 10:12:36 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203595,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:12:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:12:35','YYYY-MM-DD HH24:MI:SS'),10,'AD_LabelAssignment_ID','Label Assignment','Label Assignment','D','5c954ef7-2e95-445a-9fda-40ec3c679c6e')
;

-- May 16, 2022, 10:12:46 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203596,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:12:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:12:45','YYYY-MM-DD HH24:MI:SS'),10,'AD_LabelAssignment_UU','Label Assignment','Label Assignment','D','c2023c8f-0c59-49d6-99f3-5646e49c56a6')
;

-- May 16, 2022, 10:12:59 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214891,0,'Label Assignment',200347,'AD_LabelAssignment_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:12:59','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:12:59','YYYY-MM-DD HH24:MI:SS'),10,203595,'N','N','D','N','N','N','Y','45d996a0-7eb2-476c-b917-6de84d34cb7f','N',0,'N','N','N','N')
;

-- May 16, 2022, 10:13:01 AM BRT
CREATE TABLE AD_LabelAssignment (AD_LabelAssignment_ID NUMBER(10) DEFAULT NULL , CONSTRAINT AD_LabelAssignment_Key PRIMARY KEY (AD_LabelAssignment_ID))
;

-- May 16, 2022, 10:13:10 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214892,0,'Label Assignment',200347,'AD_LabelAssignment_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:13:09','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:13:09','YYYY-MM-DD HH24:MI:SS'),10,203596,'N','N','D','N','N','N','Y','a07174cc-3eff-475a-a285-16b71515d426','N',0,'N','N','N','N')
;

-- May 16, 2022, 10:13:11 AM BRT
ALTER TABLE AD_LabelAssignment ADD AD_LabelAssignment_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 16, 2022, 10:13:11 AM BRT
ALTER TABLE AD_LabelAssignment ADD CONSTRAINT AD_LabelAssignment_UU_idx UNIQUE (AD_LabelAssignment_UU)
;

-- May 16, 2022, 10:13:22 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214893,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200347,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:13:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:13:21','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','D','N','N','N','Y','5d2299a5-8ae0-44fb-8d5a-ca95335584af','N',0,'N','N','D','N')
;

-- May 16, 2022, 10:13:24 AM BRT
ALTER TABLE AD_LabelAssignment ADD AD_Client_ID NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 10:13:34 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214894,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200347,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:13:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:13:34','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','N','N','Y','e01e9b5b-06af-496e-926a-9592d774f5f9','N',0,'N','N','D','N')
;

-- May 16, 2022, 10:13:36 AM BRT
ALTER TABLE AD_LabelAssignment ADD AD_Org_ID NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 10:13:46 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214895,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200347,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:13:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:13:45','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','N','N','Y','fdb743ce-ef92-4854-b565-6ecbf359557d','N',0,'N','N','N')
;

-- May 16, 2022, 10:13:47 AM BRT
ALTER TABLE AD_LabelAssignment ADD Created DATE DEFAULT SYSDATE
;

-- May 16, 2022, 10:13:57 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214896,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200347,'CreatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:13:56','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:13:56','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','N','N','Y','c1c1e5dc-148e-4cc7-98ad-a29a48e3efc7','N',0,'N','N','D','N')
;

-- May 16, 2022, 10:13:58 AM BRT
ALTER TABLE AD_LabelAssignment ADD CreatedBy NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 10:14:12 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214897,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200347,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:14:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:14:11','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','N','N','Y','32890a45-51c0-4fad-8a8d-8c79b0739994','N',0,'N','N','N')
;

-- May 16, 2022, 10:14:13 AM BRT
ALTER TABLE AD_LabelAssignment ADD Updated DATE DEFAULT SYSDATE
;

-- May 16, 2022, 10:14:24 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214898,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200347,'UpdatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:14:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:14:23','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','N','N','Y','0cf50ce3-6270-450a-b146-905245b87b2e','N',0,'N','N','D','N')
;

-- May 16, 2022, 10:14:25 AM BRT
ALTER TABLE AD_LabelAssignment ADD UpdatedBy NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 10:14:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214899,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200347,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:14:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:14:36','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','N','N','Y','6129cecb-56fe-4aa7-8a79-c02e3fba89be','N',0,'N','N','N')
;

-- May 16, 2022, 10:14:38 AM BRT
ALTER TABLE AD_LabelAssignment ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N'))
;

-- May 16, 2022, 10:15:08 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214900,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200347,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:15:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:15:07','YYYY-MM-DD HH24:MI:SS'),10,275,'Y','Y','D','N','N','N','Y','aeac2b6d-7410-4a49-b1d5-68842e54b074','Y',10,'N','N','N')
;

-- May 16, 2022, 10:15:09 AM BRT
ALTER TABLE AD_LabelAssignment ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- May 16, 2022, 10:15:23 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214901,0,'Label','Record Label',200347,'AD_Label_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:15:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:15:23','YYYY-MM-DD HH24:MI:SS'),10,203592,'N','N','D','N','N','N','Y','0bde1e53-70e3-4015-9598-0e97f3e433a6','Y',0,'N','N','N','N')
;

-- May 16, 2022, 10:15:25 AM BRT
UPDATE AD_Column SET FKConstraintName='ADLabel_ADLabelAssignment', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-05-16 10:15:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214901
;

-- May 16, 2022, 10:15:25 AM BRT
ALTER TABLE AD_LabelAssignment ADD AD_Label_ID NUMBER(10) NOT NULL
;

-- May 16, 2022, 10:15:25 AM BRT
ALTER TABLE AD_LabelAssignment ADD CONSTRAINT ADLabel_ADLabelAssignment FOREIGN KEY (AD_Label_ID) REFERENCES ad_label(ad_label_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 10:15:42 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214902,0,'Table','Database Table information','The Database Table provides the information of the table definition',200347,'AD_Table_ID',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:15:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:15:42','YYYY-MM-DD HH24:MI:SS'),10,126,'N','N','D','N','N','N','Y','b1261ad0-f068-4785-ac4e-3ac8b78af0cd','Y',0,'N','N','N','N')
;

-- May 16, 2022, 10:15:44 AM BRT
UPDATE AD_Column SET FKConstraintName='ADTable_ADLabelAssignment', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-05-16 10:15:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214902
;

-- May 16, 2022, 10:15:44 AM BRT
ALTER TABLE AD_LabelAssignment ADD AD_Table_ID NUMBER(10) NOT NULL
;

-- May 16, 2022, 10:15:44 AM BRT
ALTER TABLE AD_LabelAssignment ADD CONSTRAINT ADTable_ADLabelAssignment FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 10:16:01 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214903,0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200347,'Record_ID',22,'N','N','Y','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:16:00','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:16:00','YYYY-MM-DD HH24:MI:SS'),10,538,'N','N','D','N','N','N','Y','9a4e7ee6-82ea-4aae-b987-b1e5763bf1ca','Y',0,'Y','N','N')
;

-- May 16, 2022, 10:16:03 AM BRT
ALTER TABLE AD_LabelAssignment ADD Record_ID NUMBER(10) NOT NULL
;

-- May 16, 2022, 10:25:49 AM BRT
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200348,'Label Category Table Access','AD_LabelCategoryTable',0,'6',0,0,'Y',TO_TIMESTAMP('2022-05-16 10:25:49','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:25:49','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','N','N','D','N','Y','L','N','Y','5e3cdf5b-9a02-4318-9315-431ffe458e1a','N','N','N','N')
;

-- May 16, 2022, 10:25:50 AM BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_LabelCategoryTable',1000000,'N','N','Table AD_LabelCategoryTable','Y','Y',0,0,TO_TIMESTAMP('2022-05-16 10:25:49','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:25:49','YYYY-MM-DD HH24:MI:SS'),10,200416,'Y',1000000,1,200000,'6a24fbc3-31d2-4ea6-a328-0c064367553c')
;

-- May 16, 2022, 10:26:11 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203597,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:26:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:26:11','YYYY-MM-DD HH24:MI:SS'),10,'AD_LabelCategoryTable_ID','Label Category Table Access','Label Category Table Access','D','13a0865c-948a-4aa1-894e-b77b10bd2181')
;

-- May 16, 2022, 10:26:17 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203598,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:26:16','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:26:16','YYYY-MM-DD HH24:MI:SS'),10,'AD_LabelCategoryTable_UU','Label Category Table Access','Label Category Table Access','D','580fab2c-f4e0-4fcc-9374-95a0c0f29eac')
;

-- May 16, 2022, 10:26:28 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214904,0,'Label Category Table Access',200348,'AD_LabelCategoryTable_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:26:27','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:26:27','YYYY-MM-DD HH24:MI:SS'),10,203597,'N','N','D','N','N','N','Y','38e7ea83-c3b3-40eb-8785-0da28239205f','N',0,'N','N','N','N')
;

-- May 16, 2022, 10:26:30 AM BRT
CREATE TABLE AD_LabelCategoryTable (AD_LabelCategoryTable_ID NUMBER(10) DEFAULT NULL , CONSTRAINT AD_LabelCategoryTable_Key PRIMARY KEY (AD_LabelCategoryTable_ID))
;

-- May 16, 2022, 10:26:38 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214905,0,'Label Category Table Access',200348,'AD_LabelCategoryTable_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:26:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:26:37','YYYY-MM-DD HH24:MI:SS'),10,203598,'N','N','D','N','N','N','Y','b2c0bd4e-7654-4d51-b81e-2dbfd29e6488','N',0,'N','N','N','N')
;

-- May 16, 2022, 10:26:39 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD AD_LabelCategoryTable_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 16, 2022, 10:26:39 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD CONSTRAINT AD_LabelCategoryTable_UU_idx UNIQUE (AD_LabelCategoryTable_UU)
;

-- May 16, 2022, 10:26:48 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214906,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200348,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:26:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:26:48','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','D','N','N','N','Y','1cf99e59-2efd-4a7f-81d7-6c340a2ead7f','N',0,'N','N','D','N')
;

-- May 16, 2022, 10:26:50 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD AD_Client_ID NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 10:26:59 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214907,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200348,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:26:58','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:26:58','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','N','N','Y','74386679-a151-46e4-b9f6-48b9f38b14f8','N',0,'N','N','D','N')
;

-- May 16, 2022, 10:27:00 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD AD_Org_ID NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 10:27:10 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214908,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200348,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:27:10','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:27:10','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','N','N','Y','7322cd98-d6d6-44a3-9027-7172bcb6b480','N',0,'N','N','N')
;

-- May 16, 2022, 10:27:12 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD Created DATE DEFAULT SYSDATE
;

-- May 16, 2022, 10:27:20 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214909,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200348,'CreatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:27:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:27:20','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','N','N','Y','c1d2993f-6272-449b-9c1f-676f9d838c34','N',0,'N','N','D','N')
;

-- May 16, 2022, 10:27:23 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD CreatedBy NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 10:27:35 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214910,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200348,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:27:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:27:34','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','N','N','Y','c58b4041-0395-4ba0-a481-8855b502c472','N',0,'N','N','N')
;

-- May 16, 2022, 10:27:36 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD Updated DATE DEFAULT SYSDATE
;

-- May 16, 2022, 10:27:45 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214911,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200348,'UpdatedBy',22,'N','N','N','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:27:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:27:44','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','N','N','Y','9cf8519b-4ca8-46a1-b5ae-c16d06cd0755','N',0,'N','N','D','N')
;

-- May 16, 2022, 10:27:47 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD UpdatedBy NUMBER(10) DEFAULT NULL 
;

-- May 16, 2022, 10:27:58 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214912,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200348,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:27:57','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:27:57','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','N','N','Y','016ebe05-22d4-47b2-b30b-2cb66a80019b','N',0,'N','N','N')
;

-- May 16, 2022, 10:27:59 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N'))
;

-- May 16, 2022, 10:28:11 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214913,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200348,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:28:10','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:28:10','YYYY-MM-DD HH24:MI:SS'),10,275,'Y','Y','D','N','N','N','Y','134039b3-5286-4501-b927-1efa79479248','Y',10,'N','N','N')
;

-- May 16, 2022, 10:28:13 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- May 16, 2022, 10:28:34 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214914,0,'Label Category','Category of a Label','Identifies the category which this label belongs to.',200348,'AD_LabelCategory_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:28:33','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:28:33','YYYY-MM-DD HH24:MI:SS'),10,203589,'N','N','D','N','N','N','Y','5c59f9a1-062d-4b3a-a022-00ec3fc86347','Y',0,'N','N','N','N')
;

-- May 16, 2022, 10:28:36 AM BRT
UPDATE AD_Column SET FKConstraintName='ADLABELCATEGORY_ADLABCATTABLE', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-05-16 10:28:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214914
;

-- May 16, 2022, 10:30:49 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD AD_LabelCategory_ID NUMBER(10) NOT NULL
;

-- May 16, 2022, 10:30:49 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD CONSTRAINT ADLABELCATEGORY_ADLABCATTABLE FOREIGN KEY (AD_LabelCategory_ID) REFERENCES ad_labelcategory(ad_labelcategory_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 10:31:23 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214915,0,'Table','Database Table information','The Database Table provides the information of the table definition',200348,'AD_Table_ID',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:31:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:31:23','YYYY-MM-DD HH24:MI:SS'),10,126,'Y','N','D','N','N','N','Y','b6afe6dc-5244-489e-9b28-db6276ebb8e7','Y',0,'N','N','N','N')
;

-- May 16, 2022, 10:31:25 AM BRT
UPDATE AD_Column SET FKConstraintName='ADTable_ADLabelCategoryTable', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-05-16 10:31:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214915
;

-- May 16, 2022, 10:31:25 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD AD_Table_ID NUMBER(10) NOT NULL
;

-- May 16, 2022, 10:31:25 AM BRT
ALTER TABLE AD_LabelCategoryTable ADD CONSTRAINT ADTable_ADLabelCategoryTable FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 16, 2022, 10:57:56 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203599,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:57:55','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:57:55','YYYY-MM-DD HH24:MI:SS'),10,'IsCanBeUsedInAllTables','Can Be Used in All Tables','Can Be Used in All Tables','D','619a9643-c41a-4f6e-b2b3-5067c25a47ae')
;

-- May 16, 2022, 10:59:13 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214916,0,'Can Be Used in All Tables',200343,'IsCanBeUsedInAllTables','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-05-16 10:59:13','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 10:59:13','YYYY-MM-DD HH24:MI:SS'),10,203599,'Y','N','D','N','N','N','Y','03f1d286-e8ee-43e2-b5fd-40aba1fdbb3e','Y',0,'N','N','N','N')
;

-- May 16, 2022, 10:59:16 AM BRT
ALTER TABLE AD_LabelCategory ADD IsCanBeUsedInAllTables CHAR(1) DEFAULT 'Y' CHECK (IsCanBeUsedInAllTables IN ('Y','N'))
;

-- May 16, 2022, 11:03:32 AM BRT
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200128,'Label Category',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:32','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:32','YYYY-MM-DD HH24:MI:SS'),10,'M','N','D','N','N','N','a7916cbd-120a-49ce-9f13-e95e0c22821a')
;

-- May 16, 2022, 11:03:33 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200317,'Label Category',200128,10,'Y',200343,0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:33','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:33','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','AD_LabelCategory.Name','N',0,'N','D','Y','N','92db7d06-609b-445b-818c-6a0175a4de1f')
;

-- May 16, 2022, 11:03:34 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207019,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200317,214842,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:33','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:33','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','0f82c372-a445-43dc-bab3-1b008aaf752d','Y',10,2)
;

-- May 16, 2022, 11:03:34 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207020,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200317,214843,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:34','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','64b19dba-4554-4a70-83aa-44e034029ae4','Y','N',4,2)
;

-- May 16, 2022, 11:03:35 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207021,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200317,214850,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:34','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','a0917d0e-4a3a-4a69-b794-1961cbeb7a1f','Y',20,5)
;

-- May 16, 2022, 11:03:35 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207022,'Description','Optional short description of the record','A description is limited to 255 characters.',200317,214849,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:35','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','e3578198-ba01-4a83-a7f3-d00656cf5ce4','Y',30,5)
;

-- May 16, 2022, 11:03:35 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207023,'Label Category','Category of a Label','Identifies the category which this label belongs to.',200317,214840,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:35','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','66859407-fee4-428b-95f9-900ba257c5ab','N',2)
;

-- May 16, 2022, 11:03:36 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207024,'Label Category','Category of a Label','Identifies the category which this label belongs to.',200317,214841,'Y',36,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:35','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','9697a1f8-b182-4eb4-9502-04ad8011e8a6','Y',40,2)
;

-- May 16, 2022, 11:03:36 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207025,'Label Style','Label CSS Style',200317,214851,'Y',10,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:36','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','35ca9a73-c404-4273-9b1a-9836f8259343','Y',50,2)
;

-- May 16, 2022, 11:03:37 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207026,'Can Be Used in All Tables',200317,214916,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:36','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','6d604f0e-ad5e-4b2b-af28-70ac66f6e4a9','Y',60,2,2)
;

-- May 16, 2022, 11:03:38 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207027,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200317,214848,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:37','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','87ffd0de-f376-4714-825e-15434831fb16','Y',70,2,2)
;

-- May 16, 2022, 11:03:38 AM BRT
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200206,'Label Category','W',200128,0,0,'Y',TO_TIMESTAMP('2022-05-16 11:03:38','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:03:38','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','D','01036ef5-96ef-48d9-8353-799c4884bb35')
;

-- May 16, 2022, 11:03:38 AM BRT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 10, getDate(), 10,t.AD_Tree_ID, 200206, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200206)
;

-- May 16, 2022, 11:03:38 AM BRT
UPDATE AD_Table SET AD_Window_ID=200128,Updated=TO_TIMESTAMP('2022-05-16 11:03:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Table_ID=200343
;

-- May 16, 2022, 11:06:49 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:06:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207027
;

-- May 16, 2022, 11:06:49 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:06:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207026
;

-- May 16, 2022, 11:06:49 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:06:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207025
;

-- May 16, 2022, 11:06:49 AM BRT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:06:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207024
;

-- May 16, 2022, 11:06:49 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:06:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207023
;

-- May 16, 2022, 11:09:21 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200318,'Table Access',200128,20,'Y',200348,0,0,'Y',TO_TIMESTAMP('2022-05-16 11:09:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:09:20','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','N','N','N',1,'N','D','Y','N','1b3a9732-0f05-4fbd-9c48-2664563cc582','B','N','Y',0)
;

-- May 16, 2022, 11:11:08 AM BRT
UPDATE AD_Tab SET DisplayLogic='@IsCanBeUsedInAllTables@=N',Updated=TO_TIMESTAMP('2022-05-16 11:11:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tab_ID=200318
;

-- May 16, 2022, 11:11:19 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207028,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200318,214906,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:11:17','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:11:17','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','46a7b222-2580-412b-b79a-787ff886721c','Y',10,2)
;

-- May 16, 2022, 11:11:19 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207029,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200318,214907,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:11:19','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:11:19','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','728b5ddd-198c-4ca4-aafe-09778240878b','Y','N',4,2)
;

-- May 16, 2022, 11:11:20 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207030,'Description','Optional short description of the record','A description is limited to 255 characters.',200318,214913,'Y',255,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:11:19','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:11:19','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','88a338a1-e0d2-4266-a293-cbaef0e2ec9d','Y',20,5)
;

-- May 16, 2022, 11:11:20 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207031,'Label Category Table Access',200318,214904,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:11:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:11:20','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','c310fd39-aef7-4b36-b816-d7bce40e523b','N',2)
;

-- May 16, 2022, 11:11:21 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207032,'Label Category Table Access',200318,214905,'Y',36,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:11:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:11:20','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','79c5c200-2fb8-4e0b-bf12-591f8d18a033','Y',30,2)
;

-- May 16, 2022, 11:11:21 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207033,'Label Category','Category of a Label','Identifies the category which this label belongs to.',200318,214914,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:11:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:11:21','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','ee89f5d4-9e32-4ba9-a7b1-6075bf08a945','Y',40,2)
;

-- May 16, 2022, 11:11:22 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207034,'Table','Database Table information','The Database Table provides the information of the table definition',200318,214915,'Y',10,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:11:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:11:21','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','ac6824cf-4311-465a-a1ac-4c47a4e009cb','Y',50,2)
;

-- May 16, 2022, 11:11:22 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207035,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200318,214912,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:11:22','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:11:22','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','862cab79-4cd0-4132-9b25-4b114e3b9121','Y',60,2,2)
;

-- May 16, 2022, 11:13:18 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:13:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207033
;

-- May 16, 2022, 11:13:18 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:13:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207035
;

-- May 16, 2022, 11:13:18 AM BRT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:13:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207032
;

-- May 16, 2022, 11:13:18 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:13:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207031
;

-- May 16, 2022, 11:14:37 AM BRT
UPDATE AD_Tab SET AD_Column_ID=214914, Parent_Column_ID=214840,Updated=TO_TIMESTAMP('2022-05-16 11:14:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tab_ID=200318
;

-- May 16, 2022, 11:15:10 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=35,Updated=TO_TIMESTAMP('2022-05-16 11:15:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200206
;

-- May 16, 2022, 11:15:10 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=36,Updated=TO_TIMESTAMP('2022-05-16 11:15:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- May 16, 2022, 11:19:14 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200319,'Translation',200128,30,'Y',200344,0,0,'Y',TO_TIMESTAMP('2022-05-16 11:19:13','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:19:13','YYYY-MM-DD HH24:MI:SS'),10,'N','N','Y','N',214859,'N','N',0,'N','D','N','N','8d58160e-5e05-4895-9e3f-671bf61bf87d','B','N','Y',0)
;

-- May 16, 2022, 11:19:25 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207036,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200319,214852,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:19:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:19:25','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','5fe9045e-1c5d-44ca-b684-403f1887e1e6','Y',10,2)
;

-- May 16, 2022, 11:19:26 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207037,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200319,214853,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:19:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:19:25','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','f35e3e14-99a2-4b6e-8808-42aa52d819a7','Y','N',4,2)
;

-- May 16, 2022, 11:19:26 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207038,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200319,214861,'Y',6,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:19:26','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:19:26','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','0fcc713c-d774-49dd-935f-0fe8046329b1','Y',20,2)
;

-- May 16, 2022, 11:19:27 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207039,'Label Category','Category of a Label','Identifies the category which this label belongs to.',200319,214859,'Y',10,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:19:26','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:19:26','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','3eb034cd-8b50-464b-9955-40e96e465233','Y',30,2)
;

-- May 16, 2022, 11:19:27 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207040,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200319,214864,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:19:27','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:19:27','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','8a9953b2-f3e7-4982-a0ca-8d79f1220420','Y',40,5)
;

-- May 16, 2022, 11:19:28 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207041,'Description','Optional short description of the record','A description is limited to 255 characters.',200319,214863,'Y',255,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:19:27','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:19:27','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','524b73fb-b2e3-4355-b07b-6cc8612c045f','Y',50,5)
;

-- May 16, 2022, 11:19:28 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207042,'AD_LabelCategory_Trl_UU',200319,214860,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:19:28','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:19:28','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','e329a63e-2eb3-4c98-abb5-f41077fd511d','N',2)
;

-- May 16, 2022, 11:19:28 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207043,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200319,214862,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:19:28','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:19:28','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','fd45054c-4231-4298-86c0-c6c515940035','Y',60,2,2)
;

-- May 16, 2022, 11:19:29 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207044,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200319,214858,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:19:28','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:19:28','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','4cd72939-a9dc-4451-80fa-0e474f9d24b8','Y',70,2,2)
;

-- May 16, 2022, 11:20:48 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:20:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207039
;

-- May 16, 2022, 11:20:48 AM BRT
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:20:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207038
;

-- May 16, 2022, 11:20:48 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:20:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207044
;

-- May 16, 2022, 11:20:48 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:20:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207043
;

-- May 16, 2022, 11:20:48 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:20:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207040
;

-- May 16, 2022, 11:20:48 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:20:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207041
;

-- May 16, 2022, 11:20:48 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:20:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207042
;

-- May 16, 2022, 11:21:20 AM BRT
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:21:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207028
;

-- May 16, 2022, 11:21:52 AM BRT
UPDATE AD_Field SET IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207028
;

-- May 16, 2022, 11:22:05 AM BRT
UPDATE AD_Field SET IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:22:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207029
;

-- May 16, 2022, 11:22:28 AM BRT
UPDATE AD_Field SET IsReadOnly='Y', IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:22:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207019
;

-- May 16, 2022, 11:22:36 AM BRT
UPDATE AD_Field SET IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:22:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207020
;

-- May 16, 2022, 11:23:43 AM BRT
UPDATE AD_Table SET AD_Window_ID=200128,Updated=TO_TIMESTAMP('2022-05-16 11:23:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Table_ID=200348
;

-- May 16, 2022, 11:24:04 AM BRT
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200129,'Label',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:03','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:03','YYYY-MM-DD HH24:MI:SS'),10,'M','N','D','N','N','N','0bce0ec1-c6ee-4a1d-8bf1-6948590be93a')
;

-- May 16, 2022, 11:24:04 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200320,'Label',200129,10,'Y',200345,0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:04','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:04','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','AD_Label.Name','N',0,'N','D','Y','N','703d7d2d-03bf-41d6-aabb-ac8244243125')
;

-- May 16, 2022, 11:24:05 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207045,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200320,214867,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:04','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:04','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','27197aa7-b9b2-4e74-b7a0-4b344a492268','Y',10,2)
;

-- May 16, 2022, 11:24:05 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207046,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200320,214868,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:05','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:05','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','9726e0c5-76cf-40f1-a816-6bf4fd47bfd2','Y','N',4,2)
;

-- May 16, 2022, 11:24:06 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207047,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200320,214875,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:05','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:05','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','6520bfa8-fbb3-489d-87a2-91604c39dbe4','Y',20,5)
;

-- May 16, 2022, 11:24:06 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207048,'Description','Optional short description of the record','A description is limited to 255 characters.',200320,214874,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:06','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:06','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','a08016ad-5b98-4d5e-9853-c6f16bfdb894','Y',30,5)
;

-- May 16, 2022, 11:24:07 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207049,'Label','Record Label',200320,214865,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:06','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:06','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','9d67783e-e0cd-4ae9-930a-599c6fac8ac0','N',2)
;

-- May 16, 2022, 11:24:07 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207050,'Label','Record Label',200320,214866,'Y',36,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:07','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','15cfe237-2563-469f-a938-5ad0a31b7b1f','Y',40,2)
;

-- May 16, 2022, 11:24:07 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207051,'Label Category','Category of a Label','Identifies the category which this label belongs to.',200320,214876,'Y',22,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:07','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','75b5d10e-c25e-42c2-a083-5c5b31b763b3','Y',50,2)
;

-- May 16, 2022, 11:24:08 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207052,'Label Style','Label CSS Style',200320,214877,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:07','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','1fa1c09b-4b4d-4e81-92b8-c50ef5fe36c8','Y',60,2)
;

-- May 16, 2022, 11:24:08 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207053,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200320,214873,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:08','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','f6e61fec-ed11-405f-85e9-1192e2c0b6a2','Y',70,2,2)
;

-- May 16, 2022, 11:24:09 AM BRT
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200207,'Label','W',200129,0,0,'Y',TO_TIMESTAMP('2022-05-16 11:24:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:24:08','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','D','614bbf32-a32b-42c4-abb8-758c2f3c0d08')
;

-- May 16, 2022, 11:24:09 AM BRT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 10, getDate(), 10,t.AD_Tree_ID, 200207, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200207)
;

-- May 16, 2022, 11:24:09 AM BRT
UPDATE AD_Table SET AD_Window_ID=200129,Updated=TO_TIMESTAMP('2022-05-16 11:24:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Table_ID=200345
;

-- May 16, 2022, 11:25:25 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=36,Updated=TO_TIMESTAMP('2022-05-16 11:25:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200207
;

-- May 16, 2022, 11:25:25 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=37,Updated=TO_TIMESTAMP('2022-05-16 11:25:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- May 16, 2022, 11:26:25 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:26:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207053
;

-- May 16, 2022, 11:26:25 AM BRT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:26:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207050
;

-- May 16, 2022, 11:26:25 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:26:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207049
;

-- May 16, 2022, 11:26:41 AM BRT
UPDATE AD_Field SET IsReadOnly='Y', IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:26:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207045
;

-- May 16, 2022, 11:26:50 AM BRT
UPDATE AD_Field SET IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:26:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207046
;

-- May 16, 2022, 11:30:10 AM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200321,'Translation',200129,20,'Y',200346,0,0,'Y',TO_TIMESTAMP('2022-05-16 11:30:04','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:30:04','YYYY-MM-DD HH24:MI:SS'),10,'N','N','Y','N',214885,'N','N',1,'N','D','N','N','71acff37-8644-417a-b91b-b62164ab196b','B','N','Y',0)
;

-- May 16, 2022, 11:30:21 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207054,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200321,214878,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:30:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:30:20','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','4bd3b69a-c3ed-4305-b366-3850292809af','Y',10,2)
;

-- May 16, 2022, 11:30:21 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207055,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200321,214879,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:30:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:30:21','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','4cde7581-ad87-4160-9dc6-bf31c3ebba23','Y','N',4,2)
;

-- May 16, 2022, 11:30:22 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207056,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200321,214887,'Y',6,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:30:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:30:21','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','94a7e605-8f08-416b-ae34-d94c1a2234ea','Y',20,2)
;

-- May 16, 2022, 11:30:23 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207057,'Label','Record Label',200321,214885,'Y',10,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:30:22','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:30:22','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','e1e04055-79db-4b81-97ae-b06b0ddb1cc2','Y',30,2)
;

-- May 16, 2022, 11:30:23 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207058,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200321,214890,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:30:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:30:23','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','d8adc616-6fa4-4988-b67d-3dddec43478c','Y',40,5)
;

-- May 16, 2022, 11:30:23 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207059,'Description','Optional short description of the record','A description is limited to 255 characters.',200321,214889,'Y',255,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:30:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:30:23','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','bac47250-6155-4b50-ac46-ea6b4ddce877','Y',50,5)
;

-- May 16, 2022, 11:30:24 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207060,'AD_Label_Trl_UU',200321,214886,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:30:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:30:23','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','57161acb-c6bb-402a-8895-178fa89bc8c1','N',2)
;

-- May 16, 2022, 11:30:25 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207061,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200321,214888,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:30:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:30:24','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','c7a21981-6ec2-4d91-837a-29a614da3d2c','Y',60,2,2)
;

-- May 16, 2022, 11:30:25 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207062,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200321,214884,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-16 11:30:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-05-16 11:30:25','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','84b5aa87-1611-4f2a-9217-c2c56fa8c237','Y',70,2,2)
;

-- May 16, 2022, 11:31:05 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:31:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207057
;

-- May 16, 2022, 11:31:05 AM BRT
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:31:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207056
;

-- May 16, 2022, 11:31:05 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:31:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207062
;

-- May 16, 2022, 11:31:05 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:31:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207061
;

-- May 16, 2022, 11:31:05 AM BRT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:31:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207058
;

-- May 16, 2022, 11:31:05 AM BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:31:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207059
;

-- May 16, 2022, 11:31:05 AM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-05-16 11:31:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207060
;

-- May 16, 2022, 11:31:32 AM BRT
UPDATE AD_Tab SET TabLevel=1,Updated=TO_TIMESTAMP('2022-05-16 11:31:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tab_ID=200319
;

-- May 25, 2022, 1:11:55 PM BRT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,Action,IsAdvancedButton,IsAddSeparator,EntityType,IsShowMore) VALUES (0,0,TO_TIMESTAMP('2022-05-25 13:11:54','YYYY-MM-DD HH24:MI:SS'),10,'Label','Y',200121,'Window - Label',TO_TIMESTAMP('2022-05-25 13:11:54','YYYY-MM-DD HH24:MI:SS'),10,'N',0,0,'e17bd1a3-5913-4f9b-9b70-5aa2d0ea0b0f','W','N','N','D','N')
;

-- Jun 3, 2022, 10:56:26 AM BRT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201123,'8ff87816-69a2-4cce-a02a-e9e6bb749c6c',TO_TIMESTAMP('2022-06-03 10:56:25','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','ad_labelassignment_tablerecord',TO_TIMESTAMP('2022-06-03 10:56:25','YYYY-MM-DD HH24:MI:SS'),10,200347,'N','N','N','N','N')
;

-- Jun 3, 2022, 10:56:44 AM BRT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201501,'1b116c7d-8d69-4b19-8a65-fa480341e1a1',TO_TIMESTAMP('2022-06-03 10:56:43','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2022-06-03 10:56:43','YYYY-MM-DD HH24:MI:SS'),10,214902,201123,10)
;

-- Jun 3, 2022, 10:56:50 AM BRT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201502,'c20a08a9-68d4-4a0c-aec2-37ede64dc3f4',TO_TIMESTAMP('2022-06-03 10:56:49','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2022-06-03 10:56:49','YYYY-MM-DD HH24:MI:SS'),10,214903,201123,20)
;

-- Jun 3, 2022, 10:56:57 AM BRT
CREATE INDEX ad_labelassignment_tablerecord ON AD_LabelAssignment (AD_Table_ID,Record_ID)
;

-- Jun 3, 2022, 10:59:45 AM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Type to Search or Create',0,0,'Y',TO_TIMESTAMP('2022-06-03 10:59:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-03 10:59:44','YYYY-MM-DD HH24:MI:SS'),10,200759,'TypeToSearchOrCreate','D','47d27771-32b3-4daa-92dc-8ef6318716b1')
;

