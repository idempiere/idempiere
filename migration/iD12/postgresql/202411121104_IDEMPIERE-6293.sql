-- IDEMPIERE-6293
SELECT register_migration_script('202411121104_IDEMPIERE-6293.sql') FROM dual;

-- Nov 12, 2024, 11:04:23 AM CET
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200421,'User defined Theme','AD_UserDef_Theme','6',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:22','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:22','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','N','N','D','Y','L','ab616ed6-becf-4ec4-b727-c0632e050b64','N')
;

-- Nov 12, 2024, 11:04:23 AM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Theme',1000000,'N','N','Table AD_UserDef_Theme','Y','Y',0,0,TO_TIMESTAMP('2024-11-12 11:04:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:23','YYYY-MM-DD HH24:MI:SS'),10,200491,'Y',1000000,1,200000,'a405ece0-4cbd-4cb8-b682-d2f0bd547d8c')
;

-- Nov 12, 2024, 11:04:23 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216894,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200421,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:23','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','1=1','D','N','7c96042d-325d-4f7f-aa2c-9721a07a76b7','N')
;

-- Nov 12, 2024, 11:04:23 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216895,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200421,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:23','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','a8f4e5e1-0e6d-4e30-a014-dfe4a6d7f448','N')
;

-- Nov 12, 2024, 11:04:24 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216896,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200421,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:23','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','7d9598dd-5d46-4591-9851-fd8d3d5a800b','N')
;

-- Nov 12, 2024, 11:04:24 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216897,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200421,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:24','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','6ab828ef-b7da-40fb-aeb4-b7b77d217a04','N')
;

-- Nov 12, 2024, 11:04:24 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216898,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200421,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:24','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','da8c9b8e-3a1c-4e45-9208-6be5cff06574','N')
;

-- Nov 12, 2024, 11:04:24 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216899,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200421,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:24','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','c1238059-8b97-4059-9ec5-c81b9cbaa2b9','N')
;

-- Nov 12, 2024, 11:04:25 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216900,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200421,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:24','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','69a09a75-530f-4055-b4d1-7abb847c59cc','N')
;

-- Nov 12, 2024, 11:04:25 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203959,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:25','YYYY-MM-DD HH24:MI:SS'),10,'AD_UserDef_Theme_ID','User defined Theme','User defined Theme','D','b4e7db97-e79e-45dd-acda-96ed59aec49a')
;

-- Nov 12, 2024, 11:04:25 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216901,0.0,'User defined Theme',200421,'AD_UserDef_Theme_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:25','YYYY-MM-DD HH24:MI:SS'),10,203959,'N','N','D','N','3e777b67-de76-4262-8662-a8b20f3d21f4','N')
;

-- Nov 12, 2024, 11:04:25 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203960,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:25','YYYY-MM-DD HH24:MI:SS'),10,'AD_UserDef_Theme_UU','AD_UserDef_Theme_UU','AD_UserDef_Theme_UU','D','9b3069f5-391e-4086-8602-fcc960cc3d2f')
;

-- Nov 12, 2024, 11:04:26 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216902,0.0,'AD_UserDef_Theme_UU',200421,'AD_UserDef_Theme_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:25','YYYY-MM-DD HH24:MI:SS'),10,203960,'Y','N','D','N','f6dfaa5c-ba70-44c7-89ab-97996ea09f0d','N')
;

-- Nov 12, 2024, 11:04:26 AM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201277,'95b4924d-b65a-4972-8f32-6dba9a6e331b',TO_TIMESTAMP('2024-11-12 11:04:26','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','AD_UserDef_Theme_UU_idx',TO_TIMESTAMP('2024-11-12 11:04:26','YYYY-MM-DD HH24:MI:SS'),10,200421,'Y','Y','N','N')
;

-- Nov 12, 2024, 11:04:26 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201737,'d4e61ca3-92d4-4ce3-aa51-2aa6f022b296',TO_TIMESTAMP('2024-11-12 11:04:26','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2024-11-12 11:04:26','YYYY-MM-DD HH24:MI:SS'),10,216902,201277,10)
;

-- Nov 12, 2024, 11:04:26 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (216903,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200421,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:26','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:26','YYYY-MM-DD HH24:MI:SS'),10,469,'Y','Y','D','N','43c66006-2baf-4b94-8f42-2d4ec700820b',10,'N')
;

-- Nov 12, 2024, 11:04:27 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216904,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200421,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:04:26','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:04:26','YYYY-MM-DD HH24:MI:SS'),10,275,'Y','N','D','N','e74a2701-d926-4bb5-9d98-e924f13aca65','N')
;

-- Nov 12, 2024, 11:04:54 AM CET
UPDATE AD_Column SET AD_Val_Rule_ID=104, IsAllowCopy='N',Updated=TO_TIMESTAMP('2024-11-12 11:04:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216895
;

-- Nov 12, 2024, 11:05:32 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216905,0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200421,'AD_Role_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:05:32','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:05:32','YYYY-MM-DD HH24:MI:SS'),10,123,'N','N','D','N','N','N','Y','cef58ea9-7c13-4670-868c-a59cca787544','Y',0,'N','N','C','N','N')
;

-- Nov 12, 2024, 11:05:41 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216906,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200421,'AD_User_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:05:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:05:41','YYYY-MM-DD HH24:MI:SS'),10,138,'N','N','D','N','N','N','Y','98d13ae3-046d-4c17-a3ff-85224928a1af','Y',0,'N','N','N','N')
;

-- Nov 12, 2024, 11:06:00 AM CET
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2024-11-12 11:06:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216895
;

-- Nov 12, 2024, 11:06:04 AM CET
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2024-11-12 11:06:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216905
;

-- Nov 12, 2024, 11:06:06 AM CET
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2024-11-12 11:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216906
;

-- Nov 12, 2024, 11:06:38 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216908,0,'Theme','Theme name',200421,'Theme',60,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:06:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:06:37','YYYY-MM-DD HH24:MI:SS'),10,203010,'Y','N','D','N','N','N','Y','3ba6305b-0303-43d1-9b59-bcf3f04e5648','Y',0,'N','N','N','N','N')
;

-- Nov 12, 2024, 11:06:44 AM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADUserDefTheme', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-12 11:06:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216894
;

-- Nov 12, 2024, 11:06:44 AM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_ADUserDefTheme', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-12 11:06:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216895
;

-- Nov 12, 2024, 11:06:44 AM CET
UPDATE AD_Column SET FKConstraintName='ADRole_ADUserDefTheme', FKConstraintType='C',Updated=TO_TIMESTAMP('2024-11-12 11:06:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216905
;

-- Nov 12, 2024, 11:06:44 AM CET
UPDATE AD_Column SET FKConstraintName='ADUser_ADUserDefTheme', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-12 11:06:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216906
;

-- Nov 12, 2024, 11:06:44 AM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADUserDefTheme', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-12 11:06:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216897
;

-- Nov 12, 2024, 11:06:44 AM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADUserDefTheme', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-12 11:06:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216899
;

-- Nov 12, 2024, 11:06:44 AM CET
CREATE TABLE AD_UserDef_Theme (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Role_ID NUMERIC(10) DEFAULT NULL , AD_User_ID NUMERIC(10) DEFAULT NULL , AD_UserDef_Theme_ID NUMERIC(10) NOT NULL, AD_UserDef_Theme_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Theme VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_UserDef_Theme_Key PRIMARY KEY (AD_UserDef_Theme_ID), CONSTRAINT AD_UserDef_Theme_UU_idx UNIQUE (AD_UserDef_Theme_UU))
;

-- Nov 12, 2024, 11:06:44 AM CET
ALTER TABLE AD_UserDef_Theme ADD CONSTRAINT ADClient_ADUserDefTheme FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:06:44 AM CET
ALTER TABLE AD_UserDef_Theme ADD CONSTRAINT ADOrg_ADUserDefTheme FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:06:44 AM CET
ALTER TABLE AD_UserDef_Theme ADD CONSTRAINT ADRole_ADUserDefTheme FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:06:44 AM CET
ALTER TABLE AD_UserDef_Theme ADD CONSTRAINT ADUser_ADUserDefTheme FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:06:44 AM CET
ALTER TABLE AD_UserDef_Theme ADD CONSTRAINT CreatedBy_ADUserDefTheme FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:06:44 AM CET
ALTER TABLE AD_UserDef_Theme ADD CONSTRAINT UpdatedBy_ADUserDefTheme FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:07:10 AM CET
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200422,'User defined Theme Detail','AD_UserDef_Theme_Detail','6',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:10','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:10','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','N','N','D','Y','L','4eee2c91-4b84-45f5-89ef-53ea9e84b89b','N')
;

-- Nov 12, 2024, 11:07:11 AM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Theme_Detail',1000000,'N','N','Table AD_UserDef_Theme_Detail','Y','Y',0,0,TO_TIMESTAMP('2024-11-12 11:07:10','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:10','YYYY-MM-DD HH24:MI:SS'),10,200492,'Y',1000000,1,200000,'21b9f2d1-e4f9-4207-bbb6-d35f2fa412ee')
;

-- Nov 12, 2024, 11:07:11 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216909,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200422,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:11','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','1=1','D','N','dcfca430-ca95-45c0-ae55-d79b7b59108b','N')
;

-- Nov 12, 2024, 11:07:11 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216910,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200422,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:11','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','ad182d76-859a-4c65-b97a-55f24e9f3329','N')
;

-- Nov 12, 2024, 11:07:11 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216911,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200422,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:11','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','72d262c1-5391-47e6-bcdf-a843554b0b31','N')
;

-- Nov 12, 2024, 11:07:12 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216912,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200422,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:11','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','87fde674-31c4-4017-b2bd-9fddb32a7202','N')
;

-- Nov 12, 2024, 11:07:12 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216913,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200422,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:12','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:12','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','2291eafb-e1b4-4ff7-8e92-90c0ae466330','N')
;

-- Nov 12, 2024, 11:07:12 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216914,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200422,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:12','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:12','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','08954951-c771-4f05-9c0b-7455e540133b','N')
;

-- Nov 12, 2024, 11:07:12 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216915,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200422,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:12','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:12','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','c8a277cc-b300-4e6d-97a3-acfc418bc7e3','N')
;

-- Nov 12, 2024, 11:07:13 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203961,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:12','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:12','YYYY-MM-DD HH24:MI:SS'),10,'AD_UserDef_Theme_Detail_ID','User defined Theme Detail','User defined Theme Detail','D','9f528dc4-be55-4b73-bde5-ee0172de850e')
;

-- Nov 12, 2024, 11:07:13 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216916,0.0,'User defined Theme Detail',200422,'AD_UserDef_Theme_Detail_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:13','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:13','YYYY-MM-DD HH24:MI:SS'),10,203961,'N','N','D','N','26dd7c99-35fe-4f12-8279-3ca0f51d37a0','N')
;

-- Nov 12, 2024, 11:07:13 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203962,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:13','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:13','YYYY-MM-DD HH24:MI:SS'),10,'AD_UserDef_Theme_Detail_UU','AD_UserDef_Theme_Detail_UU','AD_UserDef_Theme_Detail_UU','D','d76e9d76-d49e-43f0-851a-d6a72360faac')
;

-- Nov 12, 2024, 11:07:13 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216917,0.0,'AD_UserDef_Theme_Detail_UU',200422,'AD_UserDef_Theme_Detail_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:13','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:13','YYYY-MM-DD HH24:MI:SS'),10,203962,'Y','N','D','N','31a83f58-3aec-4079-a038-e00e7745218d','N')
;

-- Nov 12, 2024, 11:07:14 AM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201278,'345fed2c-f557-4dd2-aad0-1e82d9367bee',TO_TIMESTAMP('2024-11-12 11:07:13','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','AD_UserDef_Theme_Detail_UU_idx',TO_TIMESTAMP('2024-11-12 11:07:13','YYYY-MM-DD HH24:MI:SS'),10,200422,'Y','Y','N','N')
;

-- Nov 12, 2024, 11:07:14 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201738,'c5f10b43-0388-44d9-9b51-a47add5f813f',TO_TIMESTAMP('2024-11-12 11:07:14','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2024-11-12 11:07:14','YYYY-MM-DD HH24:MI:SS'),10,216917,201278,10)
;

-- Nov 12, 2024, 11:07:50 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216918,0,'User defined Theme',200422,'AD_UserDef_Theme_ID',22,'N','Y','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:07:50','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:07:50','YYYY-MM-DD HH24:MI:SS'),10,203959,'N','N','D','N','N','N','Y','bfea1c0a-4703-476f-a481-cc96d87ccf7e','Y',0,'N','N','N','N','N')
;

-- Nov 12, 2024, 11:08:06 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216919,0,'Current Value',200422,'CurrentValue',255,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:06','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:06','YYYY-MM-DD HH24:MI:SS'),10,203781,'Y','N','D','N','N','N','Y','a2f06745-a128-462e-a15a-ede4814dc39e','Y',0,'N','N','N','N','N')
;

-- Nov 12, 2024, 11:08:15 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216920,0,'New Value','New field value','New data entered in the field',200422,'NewValue',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:15','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:15','YYYY-MM-DD HH24:MI:SS'),10,2065,'Y','N','D','N','N','N','Y','2a2b5482-6f22-4353-ba8b-990a8a614524','Y',0,'N','N','N','N')
;

-- Nov 12, 2024, 11:08:20 AM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADUserDefThemeDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-12 11:08:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216909
;

-- Nov 12, 2024, 11:08:20 AM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADUserDefThemeDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-12 11:08:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216910
;

-- Nov 12, 2024, 11:08:20 AM CET
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADUserDefTheme_ADUserDefThemeDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-12 11:08:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216918
;

-- Nov 12, 2024, 11:08:20 AM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADUserDefThemeDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-12 11:08:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216912
;

-- Nov 12, 2024, 11:08:20 AM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADUserDefThemeDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-12 11:08:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216914
;

-- Nov 12, 2024, 11:08:20 AM CET
CREATE TABLE AD_UserDef_Theme_Detail (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_UserDef_Theme_Detail_ID NUMERIC(10) NOT NULL, AD_UserDef_Theme_Detail_UU VARCHAR(36) DEFAULT NULL , AD_UserDef_Theme_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, CurrentValue VARCHAR(255) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, NewValue VARCHAR(255) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_UserDef_Theme_Detail_Key PRIMARY KEY (AD_UserDef_Theme_Detail_ID), CONSTRAINT AD_UserDef_Theme_Detail_UU_idx UNIQUE (AD_UserDef_Theme_Detail_UU))
;

-- Nov 12, 2024, 11:08:20 AM CET
ALTER TABLE AD_UserDef_Theme_Detail ADD CONSTRAINT ADClient_ADUserDefThemeDetail FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:08:20 AM CET
ALTER TABLE AD_UserDef_Theme_Detail ADD CONSTRAINT ADOrg_ADUserDefThemeDetail FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:08:20 AM CET
ALTER TABLE AD_UserDef_Theme_Detail ADD CONSTRAINT ADUserDefTheme_ADUserDefThemeDetail FOREIGN KEY (AD_UserDef_Theme_ID) REFERENCES ad_userdef_theme(ad_userdef_theme_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:08:20 AM CET
ALTER TABLE AD_UserDef_Theme_Detail ADD CONSTRAINT CreatedBy_ADUserDefThemeDetail FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:08:20 AM CET
ALTER TABLE AD_UserDef_Theme_Detail ADD CONSTRAINT UpdatedBy_ADUserDefThemeDetail FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2024, 11:08:39 AM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200151,'User defined Theme',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:39','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:39','YYYY-MM-DD HH24:MI:SS'),10,'M','N','D','N','N','N','af946bc7-bca1-419f-aad1-6c76258c1c46')
;

-- Nov 12, 2024, 11:08:39 AM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200386,'User defined Theme',200151,10,'Y',200421,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:39','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:39','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','AD_UserDef_Theme.Name','N',0,'N','D','Y','N','f6a03d64-e626-45fc-8a98-6bbabbb9f217')
;

-- Nov 12, 2024, 11:08:40 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208526,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200386,216894,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:39','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:39','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','ee6b3aee-a83c-4ffd-971b-3cab1da491ad','Y',10,2)
;

-- Nov 12, 2024, 11:08:40 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208527,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200386,216895,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','fc418fd0-263e-4800-8102-43145a653569','Y','N',4,2)
;

-- Nov 12, 2024, 11:08:40 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208528,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200386,216903,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','43205b61-e8b0-416c-a6e5-2f9c1a859d7d','Y',20,5)
;

-- Nov 12, 2024, 11:08:40 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208529,'Description','Optional short description of the record','A description is limited to 255 characters.',200386,216904,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','68a4f8c4-84a4-46d9-b9c7-fb45db2979d4','Y',30,5)
;

-- Nov 12, 2024, 11:08:41 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208530,'User defined Theme',200386,216901,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','fedeafa0-4f03-4c3a-bf54-2a90c3e9964e','N',2)
;

-- Nov 12, 2024, 11:08:41 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208531,'AD_UserDef_Theme_UU',200386,216902,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','f4fd9f32-bd13-4e7f-a0d4-92847f56d757','N',2)
;

-- Nov 12, 2024, 11:08:41 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208532,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200386,216905,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','4bf467a1-2670-4124-967e-8638dea66065','Y',40,2)
;

-- Nov 12, 2024, 11:08:41 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208533,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200386,216906,'Y',22,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','5dbbfb08-ddbb-47bc-a87d-9b2c04c79923','Y',50,2)
;

-- Nov 12, 2024, 11:08:42 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208534,'Theme','Theme name',200386,216908,'Y',60,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','8b0c94cb-bc78-4062-a00f-78193195693f','Y',60,5)
;

-- Nov 12, 2024, 11:08:42 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208535,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200386,216900,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:42','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','3a851792-c66a-4919-9eb4-c60ea4641712','Y',70,2,2)
;

-- Nov 12, 2024, 11:08:42 AM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200238,'User defined Theme','W',200151,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:08:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:08:42','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','D','a3b9c510-1c23-4910-84de-6b52e63ed9d9')
;

-- Nov 12, 2024, 11:08:42 AM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 10, statement_timestamp(), 10,t.AD_Tree_ID, 200238, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200238)
;

-- Nov 12, 2024, 11:08:42 AM CET
UPDATE AD_Table SET AD_Window_ID=200151,Updated=TO_TIMESTAMP('2024-11-12 11:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Table_ID=200421
;

-- Nov 12, 2024, 11:09:07 AM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200387,'User defined Theme Detail',200151,20,'Y',200422,0,0,'Y',TO_TIMESTAMP('2024-11-12 11:09:06','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:09:06','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N',216918,'AD_UserDef_Theme_Detail.Created DESC','N',1,'N','D','Y','N','2a8f4233-9526-42fe-803b-a075373108e3')
;

-- Nov 12, 2024, 11:09:07 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208536,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200387,216909,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:09:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:09:07','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','efc14f83-496f-4a02-bc69-5120955adb85','Y',10,2)
;

-- Nov 12, 2024, 11:09:07 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208537,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200387,216910,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:09:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:09:07','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','da8fea11-70bd-45ee-aedc-34283df16d36','Y','N',4,2)
;

-- Nov 12, 2024, 11:09:07 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208538,'User defined Theme',200387,216918,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:09:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:09:07','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','4a743126-233b-41bf-94a9-7012b1682d63','Y',20,2)
;

-- Nov 12, 2024, 11:09:08 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208539,'User defined Theme Detail',200387,216916,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:09:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:09:07','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','8e9a6ae4-7204-4883-a3dd-35b3b58d2848','N',2)
;

-- Nov 12, 2024, 11:09:08 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208540,'AD_UserDef_Theme_Detail_UU',200387,216917,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:09:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:09:08','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','ef789578-2c3a-4ef3-b118-71cf868142a0','N',2)
;

-- Nov 12, 2024, 11:09:08 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208541,'Current Value',200387,216919,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:09:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:09:08','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','ca9d6e86-393d-497d-be0e-244817e7fdc6','Y',30,5)
;

-- Nov 12, 2024, 11:09:08 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208542,'New Value','New field value','New data entered in the field',200387,216920,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:09:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:09:08','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','0389167e-983f-4211-81cc-94cecfd68a5a','Y',40,5)
;

-- Nov 12, 2024, 11:09:08 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208543,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200387,216915,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 11:09:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 11:09:08','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','adb0cf42-3ddc-40b6-aa7a-101254adeaad','Y',50,2,2)
;

-- Nov 12, 2024, 11:09:09 AM CET
UPDATE AD_Table SET AD_Window_ID=200151,Updated=TO_TIMESTAMP('2024-11-12 11:09:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Table_ID=200422
;

-- Nov 12, 2024, 11:10:06 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2024-11-12 11:10:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208532
;

-- Nov 12, 2024, 11:10:06 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2024-11-12 11:10:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208533
;

-- Nov 12, 2024, 11:10:06 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=1, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-11-12 11:10:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208534
;

-- Nov 12, 2024, 11:10:06 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=5,Updated=TO_TIMESTAMP('2024-11-12 11:10:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208535
;

-- Nov 12, 2024, 11:10:06 AM CET
UPDATE AD_Field SET SeqNo=70, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-11-12 11:10:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208528
;

-- Nov 12, 2024, 11:10:06 AM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2024-11-12 11:10:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208529
;

-- Nov 12, 2024, 11:10:06 AM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-11-12 11:10:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208531
;

-- Nov 12, 2024, 11:10:06 AM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-11-12 11:10:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208530
;

-- Nov 12, 2024, 11:10:31 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=5,Updated=TO_TIMESTAMP('2024-11-12 11:10:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208543
;

-- Nov 12, 2024, 11:10:31 AM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2024-11-12 11:10:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208541
;

-- Nov 12, 2024, 11:10:31 AM CET
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2024-11-12 11:10:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208542
;

-- Nov 12, 2024, 11:10:31 AM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-11-12 11:10:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208540
;

-- Nov 12, 2024, 11:10:31 AM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-11-12 11:10:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208539
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200230
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200072
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=27,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=28,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200150
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=29,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200174
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=30,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=31,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=32,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=33,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200143
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=34,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=35,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200198
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=36,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200206
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=37,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200207
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=38,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200208
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=39,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200227
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=40,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200228
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=41,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200238
;

-- Nov 12, 2024, 11:11:25 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=42,Updated=TO_TIMESTAMP('2024-11-12 11:11:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Nov 12, 2024, 12:26:43 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216921,0,'Stylesheet','CSS (Stylesheet) used','Base Stylesheet (.css file) to use - if empty, the default (standard.css) is used. The Style sheet can be a URL.',200421,'Stylesheet',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-11-12 12:26:43','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 12:26:43','YYYY-MM-DD HH24:MI:SS'),10,3036,'Y','N','D','N','N','N','Y','93a0ecf3-afdd-4cd3-8226-8edceef393f2','Y',0,'N','N','N','N')
;

-- Nov 12, 2024, 12:26:44 PM CET
ALTER TABLE AD_UserDef_Theme ADD COLUMN Stylesheet VARCHAR(60) DEFAULT NULL 
;

-- Nov 12, 2024, 12:27:09 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208544,'Stylesheet','CSS (Stylesheet) used','Base Stylesheet (.css file) to use - if empty, the default (standard.css) is used. The Style sheet can be a URL.',200386,216921,'Y',60,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 12:27:09','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 12:27:09','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','U','57a0e641-eb4c-4976-bb5e-19882f0965f0','Y',80,5)
;

-- Nov 12, 2024, 12:27:25 PM CET
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2024-11-12 12:27:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208544
;

-- Nov 12, 2024, 12:27:49 PM CET
UPDATE AD_Field SET SeqNo=90, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-11-12 12:27:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208544
;

-- Nov 22, 2024, 1:44:20 PM CET
UPDATE AD_Window SET Name='Theme Customization',Updated=TO_TIMESTAMP('2024-11-22 13:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Window_ID=200151
;

-- Nov 22, 2024, 1:44:20 PM CET
UPDATE AD_Menu SET Name='Theme Customization', Description=NULL, IsActive='Y',Updated=TO_TIMESTAMP('2024-11-22 13:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Menu_ID=200238
;

-- Nov 22, 2024, 1:44:26 PM CET
UPDATE AD_Tab SET Name='Theme Customization',Updated=TO_TIMESTAMP('2024-11-22 13:44:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tab_ID=200386
;

-- Nov 22, 2024, 1:44:29 PM CET
UPDATE AD_Tab SET Name='Theme Customization Detail',Updated=TO_TIMESTAMP('2024-11-22 13:44:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tab_ID=200387
;

-- Nov 22, 2024, 1:44:44 PM CET
UPDATE AD_Element SET Name='Theme Customization Detail', PrintName='Theme Customization Detail',Updated=TO_TIMESTAMP('2024-11-22 13:44:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Element_ID=203961
;

-- Nov 22, 2024, 1:44:44 PM CET
UPDATE AD_Column SET ColumnName='AD_UserDef_Theme_Detail_ID', Name='Theme Customization Detail', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203961
;

-- Nov 22, 2024, 1:44:45 PM CET
UPDATE AD_Process_Para SET ColumnName='AD_UserDef_Theme_Detail_ID', Name='Theme Customization Detail', Description=NULL, Help=NULL, AD_Element_ID=203961 WHERE UPPER(ColumnName)='AD_USERDEF_THEME_DETAIL_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 22, 2024, 1:44:45 PM CET
UPDATE AD_Process_Para SET ColumnName='AD_UserDef_Theme_Detail_ID', Name='Theme Customization Detail', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203961 AND IsCentrallyMaintained='Y'
;

-- Nov 22, 2024, 1:44:45 PM CET
UPDATE AD_InfoColumn SET ColumnName='AD_UserDef_Theme_Detail_ID', Name='Theme Customization Detail', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203961 AND IsCentrallyMaintained='Y'
;

-- Nov 22, 2024, 1:44:45 PM CET
UPDATE AD_Field SET Name='Theme Customization Detail', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203961) AND IsCentrallyMaintained='Y'
;

-- Nov 22, 2024, 1:44:45 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Theme Customization Detail', Name='Theme Customization Detail' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203961)
;

-- Nov 22, 2024, 1:44:54 PM CET
UPDATE AD_Element SET Name='Theme Customization', PrintName='Theme Customization',Updated=TO_TIMESTAMP('2024-11-22 13:44:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Element_ID=203959
;

-- Nov 22, 2024, 1:44:54 PM CET
UPDATE AD_Column SET ColumnName='AD_UserDef_Theme_ID', Name='Theme Customization', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203959
;

-- Nov 22, 2024, 1:44:54 PM CET
UPDATE AD_Process_Para SET ColumnName='AD_UserDef_Theme_ID', Name='Theme Customization', Description=NULL, Help=NULL, AD_Element_ID=203959 WHERE UPPER(ColumnName)='AD_USERDEF_THEME_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 22, 2024, 1:44:54 PM CET
UPDATE AD_Process_Para SET ColumnName='AD_UserDef_Theme_ID', Name='Theme Customization', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203959 AND IsCentrallyMaintained='Y'
;

-- Nov 22, 2024, 1:44:54 PM CET
UPDATE AD_InfoColumn SET ColumnName='AD_UserDef_Theme_ID', Name='Theme Customization', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203959 AND IsCentrallyMaintained='Y'
;

-- Nov 22, 2024, 1:44:54 PM CET
UPDATE AD_Field SET Name='Theme Customization', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203959) AND IsCentrallyMaintained='Y'
;

-- Nov 22, 2024, 1:44:54 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Theme Customization', Name='Theme Customization' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203959)
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=30,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200238
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=31,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=32,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=33,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=34,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200143
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=35,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=36,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200198
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=37,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200206
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=38,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200207
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=39,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200208
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=40,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200227
;

-- Nov 22, 2024, 1:45:19 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=41,Updated=TO_TIMESTAMP('2024-11-22 13:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200228
;

-- Nov 22, 2024, 1:45:44 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2024-11-22 13:45:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216920
;

-- Nov 22, 2024, 1:45:46 PM CET
INSERT INTO t_alter_column values('ad_userdef_theme_detail','NewValue','VARCHAR(255)',null,null)
;

-- Nov 22, 2024, 1:45:46 PM CET
INSERT INTO t_alter_column values('ad_userdef_theme_detail','NewValue',null,'NOT NULL',null)
;

-- Nov 22, 2024, 1:46:04 PM CET
UPDATE AD_Tab SET IsAdvancedTab='Y',Updated=TO_TIMESTAMP('2024-11-22 13:46:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tab_ID=200387
;

-- Nov 22, 2024, 1:46:17 PM CET
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_TIMESTAMP('2024-11-22 13:46:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216905
;

-- Nov 22, 2024, 1:46:19 PM CET
INSERT INTO t_alter_column values('ad_userdef_theme','AD_Role_ID','NUMERIC(10)',null,'NULL')
;

-- Nov 22, 2024, 1:46:24 PM CET
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_TIMESTAMP('2024-11-22 13:46:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=216906
;

-- Nov 22, 2024, 1:46:25 PM CET
INSERT INTO t_alter_column values('ad_userdef_theme','AD_User_ID','NUMERIC(10)',null,'NULL')
;

-- Nov 24, 2024, 5:21:00 PM CET
UPDATE AD_Column SET DefaultValue='@SQL=SELECT get_sysconfig(''ZK_THEME'',null,0,0) FROM Dual',Updated=TO_TIMESTAMP('2024-11-24 17:21:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216908
;

-- Nov 24, 2024, 5:27:29 PM CET
UPDATE AD_Tab SET IsAdvancedTab='Y',Updated=TO_TIMESTAMP('2024-11-24 17:27:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200386
;

-- Nov 25, 2024, 5:17:16 PM MYT
UPDATE AD_Column SET FieldLength=512,Updated=TO_TIMESTAMP('2024-11-25 17:17:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216921
;

-- Nov 25, 2024, 5:17:29 PM MYT
INSERT INTO t_alter_column values('ad_userdef_theme','Stylesheet','VARCHAR(512)',null,'NULL')
;

-- Nov 25, 2024, 5:18:14 PM MYT
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2024-11-25 17:18:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208544
;

