SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2556 User preferences window configurable
-- Apr 20, 2015 8:55:26 AM COT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202881,0,0,'Y',TO_DATE('2015-04-20 08:55:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-20 08:55:25','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserPreference_ID','AD_UserPreference_ID','AD_UserPreference_ID','D','5098593a-7542-4c49-acc1-30ac6ef6592a')
;

-- Apr 20, 2015 8:55:26 AM COT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202882,0,0,'Y',TO_DATE('2015-04-20 08:55:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-20 08:55:26','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserPreference_UU','AD_UserPreference_UU','AD_UserPreference_UU','D','0d6981dd-ceaf-495c-b8ca-11169009a230')
;

-- IDEMPIERE-2556 User preferences window configurable
-- Apr 18, 2015 1:39:54 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop) VALUES (200174,'User Preference','AD_UserPreference',0,'7',0,0,'Y',TO_DATE('2015-04-18 01:39:54','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:39:54','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','N','N','D','N','N','L','N','Y','b007ed8b-09b4-4d98-92d3-e0df7a6ee79c','N','N')
;

-- Apr 18, 2015 1:40:55 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212159,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200174,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-04-18 01:40:54','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:54','YYYY-MM-DD HH24:MI:SS'),0,102,'N','N','D','Y','N','N','Y','fcaf04ec-34cb-448b-bf07-f646f5ee50bd','N','N','N')
;

-- Apr 18, 2015 1:40:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212160,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200174,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-04-18 01:40:55','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:55','YYYY-MM-DD HH24:MI:SS'),0,113,'N','N','D','Y','N','N','Y','5b18c7ce-e5ad-4a58-904b-e38e0f2e47fd','N','N','N')
;

-- Apr 18, 2015 1:40:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212161,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200174,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2015-04-18 01:40:56','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:56','YYYY-MM-DD HH24:MI:SS'),0,245,'N','N','D','Y','N','N','Y','27578d87-33b0-4ea0-80b1-43e7d9f3cc8a','N','N','N')
;

-- Apr 18, 2015 1:40:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212162,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200174,'CreatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2015-04-18 01:40:56','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:56','YYYY-MM-DD HH24:MI:SS'),0,246,'N','N','D','Y','N','N','Y','b6c4231e-f066-4cc0-91c1-86ff083ad818','N','N','N')
;

-- Apr 18, 2015 1:40:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212163,1,'Description','Optional short description of the record','A description is limited to 255 characters.',200174,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-04-18 01:40:56','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:56','YYYY-MM-DD HH24:MI:SS'),0,275,'Y','Y','D','Y','N','N','Y','4830a3fb-be29-4ca8-9812-4103787b076b','Y','N','N')
;

-- Apr 18, 2015 1:40:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212164,1,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200174,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2015-04-18 01:40:57','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:57','YYYY-MM-DD HH24:MI:SS'),0,326,'Y','N','D','Y','N','N','Y','39204b78-92fc-4155-98c2-f5cb3bd149b1','Y','N','N')
;

-- Apr 18, 2015 1:40:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212165,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200174,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-04-18 01:40:57','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:57','YYYY-MM-DD HH24:MI:SS'),0,348,'Y','N','D','Y','N','N','Y','dd04b15b-1e84-444d-bb00-3983bd6598d2','N','N','N')
;

-- Apr 18, 2015 1:40:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212166,1,'User Preference',200174,'AD_UserPreference_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_DATE('2015-04-18 01:40:58','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:58','YYYY-MM-DD HH24:MI:SS'),0,202881,'N','N','D','Y','N','N','Y','59ca020c-b0cb-4c82-9ad2-887c193cf533','N','N','N')
;

-- Apr 18, 2015 1:40:59 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212167,1.00,'AD_UserPreference_UU',200174,'AD_UserPreference_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2015-04-18 01:40:58','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:58','YYYY-MM-DD HH24:MI:SS'),0,202882,'Y','N','D','N','N','N','Y','03e2b5f6-a80e-4d76-bda3-0969ce4bdbc6','N','N','N')
;

-- Apr 18, 2015 1:40:59 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212168,1,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200174,'Name',60,'N','N','Y','N','Y',1,'N',10,0,0,'Y',TO_DATE('2015-04-18 01:40:59','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:59','YYYY-MM-DD HH24:MI:SS'),0,469,'Y','Y','D','Y','N','N','Y','ff3c1474-9dd3-4f6c-ba7a-3787ff019178','Y','N','N')
;

-- Apr 18, 2015 1:41:00 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212169,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200174,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2015-04-18 01:40:59','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:40:59','YYYY-MM-DD HH24:MI:SS'),0,607,'N','N','D','Y','N','N','Y','16ce9482-583d-456e-9cfd-dbd05863669c','N','N','N')
;

-- Apr 18, 2015 1:41:00 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212170,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200174,'UpdatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2015-04-18 01:41:00','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:41:00','YYYY-MM-DD HH24:MI:SS'),0,608,'N','N','D','Y','N','N','Y','daeff8dc-f07d-4c69-b44d-b4151bb9b5a8','N','N','N')
;

-- Apr 18, 2015 1:41:00 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212171,1,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200174,'Value',40,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-04-18 01:41:00','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:41:00','YYYY-MM-DD HH24:MI:SS'),0,620,'Y','Y','D','Y','N','N','Y','a80889b7-d5f1-4bfc-9762-bdf1555d3a32','Y','N','N')
;

-- Apr 18, 2015 1:41:32 AM CEST
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=212163
;

-- Apr 18, 2015 1:41:32 AM CEST
DELETE FROM AD_Column WHERE AD_Column_ID=212163
;

-- Apr 18, 2015 1:41:33 AM CEST
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=212164
;

-- Apr 18, 2015 1:41:33 AM CEST
DELETE FROM AD_Column WHERE AD_Column_ID=212164
;

-- Apr 18, 2015 1:41:33 AM CEST
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=212168
;

-- Apr 18, 2015 1:41:33 AM CEST
DELETE FROM AD_Column WHERE AD_Column_ID=212168
;

-- Apr 18, 2015 1:41:34 AM CEST
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=212171
;

-- Apr 18, 2015 1:41:34 AM CEST
DELETE FROM AD_Column WHERE AD_Column_ID=212171
;

-- Apr 18, 2015 1:42:24 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212172,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200174,'AD_User_ID',22,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_DATE('2015-04-18 01:42:23','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:42:23','YYYY-MM-DD HH24:MI:SS'),0,138,'N','N','D','N','N','N','Y','7301ad7b-7c37-4291-af51-42cfef6b3f13','Y',0,'N','N')
;

-- Apr 18, 2015 1:45:45 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202879,0,0,'Y',TO_DATE('2015-04-18 01:45:44','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:45:44','YYYY-MM-DD HH24:MI:SS'),0,'AutoCommit','Automatic Commit','Automatic Commit','D','7989bd5a-1364-455e-9c6c-6c20ebca1926')
;

-- Apr 18, 2015 1:46:16 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202880,0,0,'Y',TO_DATE('2015-04-18 01:46:15','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:46:15','YYYY-MM-DD HH24:MI:SS'),0,'AutoNew','Automatic New Record','Automatic New Record','D','a8e7b2da-3e35-49a8-ada6-562e0a53008e')
;

-- Apr 18, 2015 1:46:59 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212173,0,'Automatic Commit',200174,'AutoCommit',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-04-18 01:46:58','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:46:58','YYYY-MM-DD HH24:MI:SS'),0,202879,'Y','N','D','N','N','N','Y','8dca64cc-afcd-449a-8414-5eb3f88837c6','Y',0,'N','N')
;

-- Apr 18, 2015 1:47:14 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212174,0,'Automatic New Record',200174,'AutoNew',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-04-18 01:47:13','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:47:13','YYYY-MM-DD HH24:MI:SS'),0,202880,'Y','N','D','N','N','N','Y','43de1985-4cb4-41cf-9b12-1e18c9c4fd11','Y',0,'N','N')
;

-- Apr 18, 2015 1:47:40 AM CEST
UPDATE AD_Column SET FKConstraintName='ADClient_ADUserPreference', FKConstraintType='N',Updated=TO_DATE('2015-04-18 01:47:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=212159
;

-- Apr 18, 2015 1:47:40 AM CEST
UPDATE AD_Column SET FKConstraintName='ADOrg_ADUserPreference', FKConstraintType='N',Updated=TO_DATE('2015-04-18 01:47:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=212160
;

-- Apr 18, 2015 1:47:40 AM CEST
UPDATE AD_Column SET FKConstraintName='ADUser_ADUserPreference', FKConstraintType='N',Updated=TO_DATE('2015-04-18 01:47:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=212172
;

-- Apr 18, 2015 1:47:40 AM CEST
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADUserPreference', FKConstraintType='N',Updated=TO_DATE('2015-04-18 01:47:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=212162
;

-- Apr 18, 2015 1:47:41 AM CEST
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADUserPreference', FKConstraintType='N',Updated=TO_DATE('2015-04-18 01:47:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=212170
;

-- Apr 18, 2015 1:47:41 AM CEST
CREATE TABLE AD_UserPreference (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_User_ID NUMBER(10) NOT NULL, AD_UserPreference_ID NUMBER(10) NOT NULL, AD_UserPreference_UU VARCHAR2(36) DEFAULT NULL , AutoCommit CHAR(1) DEFAULT NULL  CHECK (AutoCommit IN ('Y','N')), AutoNew CHAR(1) DEFAULT NULL  CHECK (AutoNew IN ('Y','N')), Created DATE DEFAULT SYSDATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_UserPreference_Key PRIMARY KEY (AD_UserPreference_ID), CONSTRAINT AD_UserPreference_UU_idx UNIQUE (AD_UserPreference_UU))
;

-- Apr 18, 2015 1:47:41 AM CEST
ALTER TABLE AD_UserPreference ADD CONSTRAINT ADClient_ADUserPreference FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 18, 2015 1:47:41 AM CEST
ALTER TABLE AD_UserPreference ADD CONSTRAINT ADOrg_ADUserPreference FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 18, 2015 1:47:41 AM CEST
ALTER TABLE AD_UserPreference ADD CONSTRAINT ADUser_ADUserPreference FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 18, 2015 1:47:41 AM CEST
ALTER TABLE AD_UserPreference ADD CONSTRAINT CreatedBy_ADUserPreference FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 18, 2015 1:47:41 AM CEST
ALTER TABLE AD_UserPreference ADD CONSTRAINT UpdatedBy_ADUserPreference FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 18, 2015 1:49:31 AM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,Description,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200073,'User Preference','This window is use to set up the preferences entries for each user.',0,0,'Y',TO_DATE('2015-04-18 01:49:31','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:49:31','YYYY-MM-DD HH24:MI:SS'),0,'M','N','D','Y','N',0,0,'N','69306fa5-a87a-4090-a641-8fa685bdaa34')
;

-- Apr 18, 2015 1:49:41 AM CEST
UPDATE AD_Table SET AD_Window_ID=200073,Updated=TO_DATE('2015-04-18 01:49:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Table_ID=200174
;

-- Apr 18, 2015 1:50:12 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200189,'User Preference',200073,10,'Y',200174,0,0,'Y',TO_DATE('2015-04-18 01:50:11','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:50:11','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N','N','N','N',0,'N','D','Y','N','29b168d0-ccf3-46eb-b036-d33de1660f8e','B')
;

-- Apr 18, 2015 1:50:19 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203791,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200189,212159,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2015-04-18 01:50:18','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:50:18','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','4df42a7c-b811-4865-b188-afeb3b372b3a','Y',10,2)
;

-- Apr 18, 2015 1:50:19 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203792,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200189,212160,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2015-04-18 01:50:19','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:50:19','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','36c83f6d-b48c-41ff-b589-0c294dc75664','Y','Y',20,4,2)
;

-- Apr 18, 2015 1:50:19 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203793,'User Preference',200189,212166,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2015-04-18 01:50:19','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:50:19','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','042216e3-3afe-40de-bcc2-5daa36debcd7','N',2)
;

-- Apr 18, 2015 1:50:20 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203794,'AD_UserPreference_UU',200189,212167,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2015-04-18 01:50:19','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:50:19','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','edbe466d-ecce-4590-a19f-21346b307ad1','N',2)
;

-- Apr 18, 2015 1:50:20 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203795,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200189,212172,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2015-04-18 01:50:20','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:50:20','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','690a77df-bed2-4006-8286-0e23ddbd4a57','Y',30,2)
;

-- Apr 18, 2015 1:50:20 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203796,'Automatic Commit',200189,212173,'Y',1,40,'N','N','N','N',0,0,'Y',TO_DATE('2015-04-18 01:50:20','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:50:20','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','12511838-ebd8-437b-abda-7a0c6645278e','Y',40,2,2)
;

-- Apr 18, 2015 1:50:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203797,'Automatic New Record',200189,212174,'Y',1,50,'N','N','N','N',0,0,'Y',TO_DATE('2015-04-18 01:50:21','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:50:21','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','45a82a73-134d-445a-b16c-e94fd39996e5','Y',50,2,2)
;

-- Apr 18, 2015 1:50:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203798,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200189,212165,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2015-04-18 01:50:21','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:50:21','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','0a3ab290-8222-4223-aa62-554f3c4b58de','Y',60,2,2)
;

-- Apr 18, 2015 1:50:55 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2015-04-18 01:50:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203794
;

-- Apr 18, 2015 1:50:55 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2015-04-18 01:50:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203793
;

-- Apr 18, 2015 1:51:07 AM CEST
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_DATE('2015-04-18 01:51:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203797
;

-- Apr 18, 2015 1:51:10 AM CEST
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_DATE('2015-04-18 01:51:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203796
;

-- Apr 18, 2015 1:52:56 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200109,'User Preference','W',200073,0,0,'Y',TO_DATE('2015-04-18 01:52:55','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:52:55','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N','D','Y','8d876c3e-17a9-4bf2-846e-4dd694055b95')
;

-- Apr 18, 2015 1:52:56 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 0, SysDate, 0,t.AD_Tree_ID, 200109, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200109)
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=114
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=108
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200071
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200109
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=115
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53225
;

-- Apr 18, 2015 1:53:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53226
;

-- Apr 18, 2015 1:54:12 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','More Preferences',0,0,'Y',TO_DATE('2015-04-18 01:54:11','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-04-18 01:54:11','YYYY-MM-DD HH24:MI:SS'),0,200350,'MorePreferences','D','213ecc81-49d0-489d-bb1e-2752b4d2ffae')
;

-- Apr 20, 2015 10:30:31 AM COT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU,StartNewMonth,IsOrgLevelSequence) VALUES ('AD_UserPreference',1000000,'N','N','Table AD_UserPreference','Y','Y',0,0,TO_DATE('2015-04-20 10:30:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-20 10:30:31','YYYY-MM-DD HH24:MI:SS'),100,200230,'Y',1000000,1,200000,'abaceddc-0be0-407d-ba83-aa20103127b7','N','N')
;

-- IDEMPIERE-2556 User preferences window configurable
-- Apr 20, 2015 10:11:12 PM CEST
UPDATE AD_Tab SET WhereClause='AD_User_ID=@#AD_User_ID@ AND AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2015-04-20 22:11:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=200189
;

-- Apr 20, 2015 10:11:33 PM CEST
UPDATE AD_Column SET DefaultValue='Y',Updated=TO_DATE('2015-04-20 22:11:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=212173
;

-- Apr 20, 2015 10:11:35 PM CEST
ALTER TABLE AD_UserPreference MODIFY AutoCommit CHAR(1) DEFAULT 'Y'
;

-- Apr 20, 2015 10:11:41 PM CEST
UPDATE AD_Column SET DefaultValue='Y',Updated=TO_DATE('2015-04-20 22:11:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=212174
;

-- Apr 20, 2015 10:11:43 PM CEST
ALTER TABLE AD_UserPreference MODIFY AutoNew CHAR(1) DEFAULT 'Y'
;

-- Apr 23, 2015 5:12:40 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201033,'44ac19d8-71af-40d9-a786-972c57a7bec0',TO_DATE('2015-04-23 17:12:39','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','ad_userpreference_user_idx',TO_DATE('2015-04-23 17:12:39','YYYY-MM-DD HH24:MI:SS'),0,200174,'N','Y','N','N','N')
;

-- Apr 23, 2015 5:12:56 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201258,'52b7953f-564d-49bf-b090-f1df9821c3c4',TO_DATE('2015-04-23 17:12:56','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_DATE('2015-04-23 17:12:56','YYYY-MM-DD HH24:MI:SS'),0,212172,201033,10)
;

-- Apr 23, 2015 5:14:40 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201259,'7bf0c71a-b50f-44d3-ac62-a3c37fc61d95',TO_DATE('2015-04-23 17:14:40','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_DATE('2015-04-23 17:14:40','YYYY-MM-DD HH24:MI:SS'),0,212159,201033,20)
;

-- Apr 23, 2015 5:14:55 PM CEST
CREATE UNIQUE INDEX ad_userpreference_user_idx ON AD_UserPreference (AD_User_ID,AD_Client_ID)
;

SELECT register_migration_script('201504231737_IDEMPIERE-2556.sql') FROM dual
;

