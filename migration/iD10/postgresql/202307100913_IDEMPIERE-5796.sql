-- IDEMPIERE-5796
SELECT register_migration_script('202307100913_IDEMPIERE-5796.sql') FROM dual;

-- Jul 10, 2023, 9:15:43 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200387,'Model Generator Template','AD_ModelGeneratorTemplate','4',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:43','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:43','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','N','N','D','Y','L','fbc5362f-9360-44d9-b6d1-e10d197fcc01','N')
;

-- Jul 10, 2023, 9:15:44 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_ModelGeneratorTemplate',1000000,'N','N','Table AD_ModelGeneratorTemplate','Y','Y',0,0,TO_TIMESTAMP('2023-07-10 09:15:43','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:43','YYYY-MM-DD HH24:MI:SS'),10,200457,'Y',1000000,1,200000,'af959e08-417e-4561-8ace-974ecb4cd415')
;

-- Jul 10, 2023, 9:15:44 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215872,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200387,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:44','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','1=1','D','N','eb232dae-420d-452e-8b10-303b2590684e','N')
;

-- Jul 10, 2023, 9:15:44 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215873,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200387,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:44','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','07d892af-f0e5-4717-a073-e4240395a777','N')
;

-- Jul 10, 2023, 9:15:45 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215874,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200387,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:44','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','736c88f9-45f5-4ec5-853b-13728a0c436b','N')
;

-- Jul 10, 2023, 9:15:45 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215875,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200387,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:45','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','e8562639-5070-41b0-834d-a1a97054fd08','N')
;

-- Jul 10, 2023, 9:15:45 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215876,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200387,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:45','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','cc0521c8-05b3-4c26-a59f-df425551298c','N')
;

-- Jul 10, 2023, 9:15:46 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215877,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200387,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:45','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','42da35ed-8b6c-4fe0-86c2-20d8cec61ffa','N')
;

-- Jul 10, 2023, 9:15:46 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215878,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200387,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:46','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','379d922c-1453-4f0a-bfd0-7442a46dc472','N')
;

-- Jul 10, 2023, 9:15:46 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203815,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:46','YYYY-MM-DD HH24:MI:SS'),10,'AD_ModelGeneratorTemplate_ID','Model Generator Template',NULL,'Model Generator Template','D','0511f2b4-1846-4b91-aee1-fce177c6c0e2')
;

-- Jul 10, 2023, 9:15:47 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215879,0.0,'Model Generator Template',200387,'AD_ModelGeneratorTemplate_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:46','YYYY-MM-DD HH24:MI:SS'),10,203815,'N','N','D','N','fbc50caa-e280-496d-b28e-9b609c4d781b','N')
;

-- Jul 10, 2023, 9:15:47 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203816,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:47','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:47','YYYY-MM-DD HH24:MI:SS'),10,'AD_ModelGeneratorTemplate_UU','AD_ModelGeneratorTemplate_UU','AD_ModelGeneratorTemplate_UU','D','4fb0795c-575e-42b1-84dd-33e4b35aabbf')
;

-- Jul 10, 2023, 9:15:47 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215880,0.0,'AD_ModelGeneratorTemplate_UU',200387,'AD_ModelGeneratorTemplate_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:47','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:47','YYYY-MM-DD HH24:MI:SS'),10,203816,'Y','N','D','N','c6a5fbd5-9cb6-49dd-9e94-e1781f9a6662','N')
;

-- Jul 10, 2023, 9:15:47 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201256,'fe454d8b-b7ec-4004-b128-4463f6776625',TO_TIMESTAMP('2023-07-10 09:15:47','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','AD_ModelGeneratorTemplate_uu_idx',TO_TIMESTAMP('2023-07-10 09:15:47','YYYY-MM-DD HH24:MI:SS'),10,200387,'Y','Y','N','N')
;

-- Jul 10, 2023, 9:15:48 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201698,'7def4c90-cf49-454d-a712-c1483dc7f9a7',TO_TIMESTAMP('2023-07-10 09:15:47','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2023-07-10 09:15:47','YYYY-MM-DD HH24:MI:SS'),10,215880,201256,10)
;

-- Jul 10, 2023, 9:15:48 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (215881,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200387,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:15:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:15:48','YYYY-MM-DD HH24:MI:SS'),10,469,'Y','Y','D','N','ffb6f4b3-a5eb-4dbc-b145-79f6577028e8',10,'N')
;

-- Jul 10, 2023, 9:16:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215882,0,'Folder','A folder on a local or remote system to store data into','We store files in folders, especially media files.',200387,'Folder',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:16:16','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:16:16','YYYY-MM-DD HH24:MI:SS'),10,3012,'Y','N','D','N','N','N','Y','0921ecb7-602b-4a3f-bb7a-d40833311206','Y',0,'N','N','N')
;

-- Jul 10, 2023, 9:16:37 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215883,0,'DB Table Name','Name of the table in the database','The DB Table Name indicates the name of the table in database.',200387,'TableName',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:16:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:16:37','YYYY-MM-DD HH24:MI:SS'),10,587,'Y','Y','D','N','N',NULL,'N','Y','bc675bac-63a6-4f20-be07-b0bd1a44237c','Y',20,'N','N','N','N')
;

-- Jul 10, 2023, 9:16:50 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203817,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:16:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:16:44','YYYY-MM-DD HH24:MI:SS'),10,'ColumnEntityType','Column Entity Type',NULL,NULL,'Column Entity Type','D','22ad1194-cfdc-4582-bd51-a2d7a4a46f14')
;

-- Jul 10, 2023, 9:17:03 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215884,0,'Column Entity Type',200387,'ColumnEntityType',20,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:17:03','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:17:03','YYYY-MM-DD HH24:MI:SS'),10,203817,'Y','N','D','N','N','N','Y','420b64ca-4e0a-4a8b-8488-08381bbe94df','Y',0,'N','N','N')
;

-- Jul 10, 2023, 9:17:26 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203818,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:17:17','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:17:17','YYYY-MM-DD HH24:MI:SS'),10,'PackageName','Package Name',NULL,NULL,'Package Name','D','262c6963-8b1e-4d7d-9c20-98be2868f4f5')
;

-- Jul 10, 2023, 9:17:34 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215885,0,'Package Name',200387,'PackageName',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:17:33','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:17:33','YYYY-MM-DD HH24:MI:SS'),10,203818,'Y','N','D','N','N','N','Y','76784d8d-5d05-48eb-b96e-6a63386e3215','Y',0,'N','N','N')
;

-- Jul 10, 2023, 9:17:47 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203819,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:17:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:17:40','YYYY-MM-DD HH24:MI:SS'),10,'TableEntityType','Table Entity Type',NULL,NULL,'Table Entity Type','D','86a1747f-f3ca-4a32-ba6b-e4461eb99f77')
;

-- Jul 10, 2023, 9:17:52 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215886,0,'Table Entity Type',200387,'TableEntityType',20,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:17:52','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:17:52','YYYY-MM-DD HH24:MI:SS'),10,203819,'Y','N','D','N','N','N','Y','0df44055-c22d-4f63-ad7a-c8706fb2861e','Y',0,'N','N','N')
;

-- Jul 10, 2023, 9:18:31 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADModelGeneratorTempl', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-07-10 09:18:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=215872
;

-- Jul 10, 2023, 9:18:31 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADModelGeneratorTemplate', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-07-10 09:18:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=215873
;

-- Jul 10, 2023, 9:18:31 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADModelGeneratorTemp', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-07-10 09:18:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=215875
;

-- Jul 10, 2023, 9:18:31 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADModelGeneratorTemp', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-07-10 09:18:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=215877
;

-- Jul 10, 2023, 9:18:31 AM CEST
CREATE TABLE AD_ModelGeneratorTemplate (AD_Client_ID NUMERIC(10) NOT NULL, AD_ModelGeneratorTemplate_ID NUMERIC(10) NOT NULL, AD_ModelGeneratorTemplate_UU VARCHAR(36) DEFAULT NULL , AD_Org_ID NUMERIC(10) NOT NULL, ColumnEntityType VARCHAR(20) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Folder VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, PackageName VARCHAR(60) DEFAULT NULL , TableEntityType VARCHAR(20) DEFAULT NULL , TableName VARCHAR(60) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_ModelGeneratorTemplate_Key PRIMARY KEY (AD_ModelGeneratorTemplate_ID), CONSTRAINT AD_ModelGeneratorTemplateuuidx UNIQUE (AD_ModelGeneratorTemplate_UU))
;

-- Jul 10, 2023, 9:18:31 AM CEST
ALTER TABLE AD_ModelGeneratorTemplate ADD CONSTRAINT ADClient_ADModelGeneratorTempl FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 10, 2023, 9:18:31 AM CEST
ALTER TABLE AD_ModelGeneratorTemplate ADD CONSTRAINT ADOrg_ADModelGeneratorTemplate FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 10, 2023, 9:18:31 AM CEST
ALTER TABLE AD_ModelGeneratorTemplate ADD CONSTRAINT CreatedBy_ADModelGeneratorTemp FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 10, 2023, 9:18:31 AM CEST
ALTER TABLE AD_ModelGeneratorTemplate ADD CONSTRAINT UpdatedBy_ADModelGeneratorTemp FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 10, 2023, 9:18:45 AM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200141,'Model Generator Template',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:45','YYYY-MM-DD HH24:MI:SS'),10,'M','N','D','N','N','N','03d9636a-892c-4663-8839-19618b7a0055')
;

-- Jul 10, 2023, 9:18:45 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200353,'Model Generator Template',200141,10,'Y',200387,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:45','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','AD_ModelGeneratorTemplate.Name','N',0,'N','D','Y','N','1134c289-64e4-4adf-8a04-34f875147bcd')
;

-- Jul 10, 2023, 9:18:46 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207689,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200353,215872,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:45','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','e0b49823-457d-4d52-8934-398450d5044e','N',2)
;

-- Jul 10, 2023, 9:18:46 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207690,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200353,215873,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:46','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','404401b5-1291-477a-a96e-069ca16289ca','Y','N',4,2)
;

-- Jul 10, 2023, 9:18:46 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207691,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200353,215881,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:46','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','a37ace1d-5f41-48d3-8089-9684ea972a87','Y',10,5)
;

-- Jul 10, 2023, 9:18:47 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207692,'Model Generator Template',200353,215879,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:46','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','3d776ac5-36e5-4549-8554-7eef75b1d618','N',2)
;

-- Jul 10, 2023, 9:18:47 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207693,'AD_ModelGeneratorTemplate_UU',200353,215880,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:47','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:47','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','494728f1-3500-46a7-93d7-102f9d5a7eea','N',2)
;

-- Jul 10, 2023, 9:18:47 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207694,'Folder','A folder on a local or remote system to store data into','We store files in folders, especially media files.',200353,215882,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:47','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:47','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','6534b52f-4abf-42fe-9319-49d9e7841b8d','Y',20,5)
;

-- Jul 10, 2023, 9:18:48 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207695,'DB Table Name','Name of the table in the database','The DB Table Name indicates the name of the table in database.',200353,215883,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:47','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:47','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','d249d485-9152-463b-9818-ec1217007003','Y',30,5)
;

-- Jul 10, 2023, 9:18:48 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207696,'Column Entity Type',200353,215884,'Y',20,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:48','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','4a480bf9-4c34-40f8-af2a-6d767a401e2b','Y',40,2)
;

-- Jul 10, 2023, 9:18:48 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207697,'Package Name',200353,215885,'Y',60,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:48','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','6f7e1377-39f9-4bdc-91d4-2678e966961f','Y',50,5)
;

-- Jul 10, 2023, 9:18:49 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207698,'Table Entity Type',200353,215886,'Y',20,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:48','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','415fe084-6fb3-4419-86b5-3a6d163ae3f6','Y',60,2)
;

-- Jul 10, 2023, 9:18:49 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207699,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200353,215878,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:49','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:49','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','640a9c98-57bf-456b-ad29-1e945d76f1f8','Y',70,2,2)
;

-- Jul 10, 2023, 9:18:49 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200227,'Model Generator Template','W',200141,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:18:49','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:18:49','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','D','2064a6f0-0300-4fc5-9c91-a4252b6de727')
;

-- Jul 10, 2023, 9:18:49 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 10, statement_timestamp(), 10,t.AD_Tree_ID, 200227, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200227)
;

-- Jul 10, 2023, 9:18:49 AM CEST
UPDATE AD_Table SET AD_Window_ID=200141,Updated=TO_TIMESTAMP('2023-07-10 09:18:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Table_ID=200387
;

-- Jul 10, 2023, 9:19:34 AM CEST
UPDATE AD_Field SET SeqNo=30, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-07-10 09:19:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207691
;

-- Jul 10, 2023, 9:19:34 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=6, ColumnSpan=1,Updated=TO_TIMESTAMP('2023-07-10 09:19:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207699
;

-- Jul 10, 2023, 9:19:34 AM CEST
UPDATE AD_Field SET SeqNo=50, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-07-10 09:19:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207694
;

-- Jul 10, 2023, 9:19:34 AM CEST
UPDATE AD_Field SET SeqNo=60, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-07-10 09:19:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207695
;

-- Jul 10, 2023, 9:19:34 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-07-10 09:19:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207697
;

-- Jul 10, 2023, 9:19:34 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=4,Updated=TO_TIMESTAMP('2023-07-10 09:19:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207696
;

-- Jul 10, 2023, 9:19:34 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-07-10 09:19:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207693
;

-- Jul 10, 2023, 9:19:34 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-07-10 09:19:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207692
;

-- Jul 10, 2023, 9:20:41 AM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200154,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:20:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:20:41','YYYY-MM-DD HH24:MI:SS'),10,'Generate Model','N','GenerateModel','N','org.idempiere.process.GenerateModel','4','D',0,0,'N','Y','N','5d3ccc79-089d-485c-af7e-b1d7e79a088a','P')
;

-- Jul 10, 2023, 9:21:09 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200439,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:21:09','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:21:09','YYYY-MM-DD HH24:MI:SS'),10,'Model Generator Template',200154,10,19,'N',22,'N','AD_ModelGeneratorTemplate_ID','Y','D',203815,'205ebbbb-15d9-4b88-b51f-12dc244d3361','N','N','D','N')
;

-- Jul 10, 2023, 9:22:35 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200440,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:22:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:22:35','YYYY-MM-DD HH24:MI:SS'),10,'Folder','A folder on a local or remote system to store data into','We store files in folders, especially media files.',200154,20,10,'N',255,'Y','Folder','Y','D',3012,'844c2ec6-8fdb-475b-be5f-b777e9d0195d','N','N','D','N')
;

-- Jul 10, 2023, 9:22:44 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200441,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:22:43','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:22:43','YYYY-MM-DD HH24:MI:SS'),10,'DB Table Name','Name of the table in the database','The DB Table Name indicates the name of the table in database.',200154,30,10,'N',27,'Y',NULL,'TableName','Y','D',587,'6069d087-e62c-4032-aab2-77ec74fc3cd6','N','N','D','N')
;

-- Jul 10, 2023, 9:22:51 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200442,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:22:51','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:22:51','YYYY-MM-DD HH24:MI:SS'),10,'Package Name',200154,40,10,'N',60,'Y','PackageName','Y','D',203818,'7aeb8885-a5c1-4660-829b-5aa2da831274','N','N','D','N')
;

-- Jul 10, 2023, 9:22:59 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200443,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:22:58','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:22:58','YYYY-MM-DD HH24:MI:SS'),10,'Table Entity Type',200154,50,10,'N',20,'Y','TableEntityType','Y','D',203819,'ce80d469-64fa-425a-b95f-975c315fd9c2','N','N','D','N')
;

-- Jul 10, 2023, 9:23:04 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200444,0,0,'Y',TO_TIMESTAMP('2023-07-10 09:23:04','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:23:04','YYYY-MM-DD HH24:MI:SS'),10,'Column Entity Type',200154,60,10,'N',20,'N','ColumnEntityType','Y','D',203817,'e7cc8411-1c55-40f7-b11c-1c5edc48b1cb','N','N','D','N')
;

-- Jul 10, 2023, 9:23:51 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=38,Updated=TO_TIMESTAMP('2023-07-10 09:23:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200227
;

-- Jul 10, 2023, 9:23:51 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=39,Updated=TO_TIMESTAMP('2023-07-10 09:23:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Jul 10, 2023, 9:24:07 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200228,'Generate Model','P',0,0,'Y',TO_TIMESTAMP('2023-07-10 09:24:06','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-10 09:24:06','YYYY-MM-DD HH24:MI:SS'),10,'N',200154,'N','N','D','Y','4976012a-2141-488d-a313-fe3e07cace16')
;

-- Jul 10, 2023, 9:24:07 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 10, statement_timestamp(), 10,t.AD_Tree_ID, 200228, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200228)
;

-- Jul 10, 2023, 9:24:34 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=39,Updated=TO_TIMESTAMP('2023-07-10 09:24:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200228
;

-- Jul 10, 2023, 9:24:34 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=40,Updated=TO_TIMESTAMP('2023-07-10 09:24:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Jul 10, 2023, 9:25:38 AM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2023-07-10 09:25:38','YYYY-MM-DD HH24:MI:SS'),10,'Generate Model','Y',200130,'Generate Model',TO_TIMESTAMP('2023-07-10 09:25:38','YYYY-MM-DD HH24:MI:SS'),10,'N','377fe2bc-d17c-4952-b549-faaa88ba773e','W',100,200154,'@IsView@=N & @#DeveloperMode@ = Y',30,'D')
;

-- Jul 10, 2023, 9:27:00 AM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2023-07-10 09:27:00','YYYY-MM-DD HH24:MI:SS'),10,'Generate Model','Y',200131,'Generate Model',TO_TIMESTAMP('2023-07-10 09:27:00','YYYY-MM-DD HH24:MI:SS'),10,'N','cb91ee8b-1271-4f45-9556-01240345b225','W',102,200154,'@ValidationType@ = L & @#DeveloperMode@ = Y',10,'D')
;

-- Jul 12, 2023, 6:50:28 AM CEST
UPDATE AD_Process_Para SET Name='Table Like', Description='You can use % or a comma separated list of table names (case sensitive)', ColumnName='TableLike', AD_Element_ID=NULL,Updated=TO_TIMESTAMP('2023-07-12 06:50:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Process_Para_ID=200441
;

-- Jul 12, 2023, 7:03:28 AM CEST
UPDATE AD_Field SET Description=NULL, Help='You can use % or a comma separated list of table names (case sensitive)
Using ''@TableName@'' will change to current table when executing the process', IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2023-07-12 07:03:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207695
;

-- Jul 12, 2023, 3:52:47 PM CEST
UPDATE AD_Process_Para SET AD_Reference_ID=200162, AD_Reference_Value_ID=389,Updated=TO_TIMESTAMP('2023-07-12 15:52:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Process_Para_ID=200443
;

-- Jul 12, 2023, 3:52:55 PM CEST
UPDATE AD_Process_Para SET AD_Reference_ID=200162, AD_Reference_Value_ID=389,Updated=TO_TIMESTAMP('2023-07-12 15:52:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Process_Para_ID=200444
;

-- Jul 13, 2023, 1:55:59 PM CEST
UPDATE AD_Column SET FieldLength=2000,Updated=TO_TIMESTAMP('2023-07-13 13:55:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215883
;

-- Jul 13, 2023, 1:56:04 PM CEST
INSERT INTO t_alter_column values('ad_modelgeneratortemplate','TableName','VARCHAR(2000)',null,'NULL')
;

-- Jul 13, 2023, 1:56:50 PM CEST
UPDATE AD_Process_Para SET Description='You can use % or a comma separated list of table names enclosed within single quotes (case sensitive)', FieldLength=2000,Updated=TO_TIMESTAMP('2023-07-13 13:56:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200441
;

-- Jul 13, 2023, 2:14:18 PM CEST
UPDATE AD_Process_Para SET SeqNo=41,Updated=TO_TIMESTAMP('2023-07-13 14:14:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200441
;

-- Jul 13, 2023, 2:14:22 PM CEST
UPDATE AD_Process_Para SET SeqNo=30,Updated=TO_TIMESTAMP('2023-07-13 14:14:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200442
;

-- Jul 13, 2023, 2:14:25 PM CEST
UPDATE AD_Process_Para SET SeqNo=40,Updated=TO_TIMESTAMP('2023-07-13 14:14:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200441
;

-- Jul 13, 2023, 2:14:53 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203820,0,0,'Y',TO_TIMESTAMP('2023-07-13 14:14:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-07-13 14:14:41','YYYY-MM-DD HH24:MI:SS'),100,'IsGenerateInterface','Generate Interface',NULL,NULL,'Generate Interface','D','011f0493-36d7-4bc7-a7d8-7ac01662ba67')
;

-- Jul 13, 2023, 2:15:07 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200445,0,0,'Y',TO_TIMESTAMP('2023-07-13 14:15:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-07-13 14:15:07','YYYY-MM-DD HH24:MI:SS'),100,'Generate Interface',200154,70,20,'N',1,'Y','Y','IsGenerateInterface','Y','D',203820,'a681b7c6-56b4-465e-a750-ebd0874d308d','N','N','D','N')
;

-- Jul 13, 2023, 2:15:23 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203821,0,0,'Y',TO_TIMESTAMP('2023-07-13 14:15:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-07-13 14:15:12','YYYY-MM-DD HH24:MI:SS'),100,'IsGenerateClass','Generate Class',NULL,NULL,'Generate Class','D','5534d687-c084-4ea7-8943-842f6ad05b2c')
;

-- Jul 13, 2023, 2:15:33 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200446,0,0,'Y',TO_TIMESTAMP('2023-07-13 14:15:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-07-13 14:15:33','YYYY-MM-DD HH24:MI:SS'),100,'Generate Class',200154,80,20,'N',1,'Y','Y','IsGenerateClass','Y','D',203821,'f439bed8-22bb-4627-a9b9-8626a95844a1','N','N','D','N')
;

