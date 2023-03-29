-- IDEMPIERE-5567 Support of UUID as Foreign Key (FHCA-4195)
SELECT register_migration_script('202303241637_IDEMPIERE-5567.sql') FROM dual;

-- Mar 24, 2023, 4:37:27 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200384,'Test UU Detail','TestUUDet','7',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','a0dd2706-936b-4520-a38a-5afdccb92ecf','N')
;

-- Mar 24, 2023, 4:37:27 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('TestUUDet',1000000,'N','N','Table TestUUDet','Y','Y',0,0,TO_TIMESTAMP('2023-03-24 16:37:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:27','YYYY-MM-DD HH24:MI:SS'),100,200454,'Y',1000000,1,200000,'24b75e22-fd49-4cd6-87e4-887f915bc660')
;

-- Mar 24, 2023, 4:37:28 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215795,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200384,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:27','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','d91c6d4c-ae37-4257-b99c-6c7bcabc1ccd','N')
;

-- Mar 24, 2023, 4:37:28 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215796,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200384,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','34378f01-63d9-47f1-8dbb-6010ea059ac1','N')
;

-- Mar 24, 2023, 4:37:28 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215797,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200384,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','f47ee517-9a13-4587-a204-028580011acf','N')
;

-- Mar 24, 2023, 4:37:29 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215798,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200384,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','226b0974-6e82-4f4e-b45f-26dc6d564768','N')
;

-- Mar 24, 2023, 4:37:29 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215799,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200384,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','72cc17f9-123a-46b6-b917-9b3346fb6f91','N')
;

-- Mar 24, 2023, 4:37:30 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215800,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200384,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','f6613f51-004b-436b-965a-fda212908640','N')
;

-- Mar 24, 2023, 4:37:30 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215801,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200384,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:30','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','89c118cb-eb52-4de6-9978-793091ae23b6','N')
;

-- Mar 24, 2023, 4:37:30 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203795,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:30','YYYY-MM-DD HH24:MI:SS'),100,'TestUUDet_UU','TestUUDet_UU','TestUUDet_UU','D','76076418-4f48-4d5f-862c-a7925a791b32')
;

-- Mar 24, 2023, 4:37:31 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215802,0.0,'TestUUDet_UU',200384,'TestUUDet_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:30','YYYY-MM-DD HH24:MI:SS'),100,203795,'Y','N','D','N','bd716d09-9915-4c16-a101-a1b71c4af014','N')
;

-- Mar 24, 2023, 4:37:31 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (215803,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200384,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:31','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','dfb02d82-8abd-4903-9b0f-aa03acfb8c57',10,'N')
;

-- Mar 24, 2023, 4:37:31 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215804,0.0,'Sales Representative','Sales Representative or Company Agent','The Sales Representative indicates the Sales Rep for this Region.  Any Sales Rep must be a valid internal user.',200384,'SalesRep_ID',10,'N','N','Y','N','N','N',30,190,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:31','YYYY-MM-DD HH24:MI:SS'),100,1063,'Y','N','D','N','125cc090-2a67-4aac-836e-79e1fd939c81','N')
;

-- Mar 24, 2023, 4:37:32 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215805,0.0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200384,'AD_User_ID',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:37:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:37:31','YYYY-MM-DD HH24:MI:SS'),100,138,'Y','N','D','N','8539cc97-e3c6-4e40-b5f7-1fc075b4a886','N')
;

-- Mar 24, 2023, 4:38:56 PM CET
UPDATE AD_Element SET Name='Test UU', PrintName='Test UU',Updated=TO_TIMESTAMP('2023-03-24 16:38:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203793
;

-- Mar 24, 2023, 4:38:56 PM CET
UPDATE AD_Column SET ColumnName='TestUU_UU', Name='Test UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203793
;

-- Mar 24, 2023, 4:38:56 PM CET
UPDATE AD_Process_Para SET ColumnName='TestUU_UU', Name='Test UU', Description=NULL, Help=NULL, AD_Element_ID=203793 WHERE UPPER(ColumnName)='TESTUU_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 24, 2023, 4:38:56 PM CET
UPDATE AD_Process_Para SET ColumnName='TestUU_UU', Name='Test UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203793 AND IsCentrallyMaintained='Y'
;

-- Mar 24, 2023, 4:38:56 PM CET
UPDATE AD_InfoColumn SET ColumnName='TestUU_UU', Name='Test UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203793 AND IsCentrallyMaintained='Y'
;

-- Mar 24, 2023, 4:38:56 PM CET
UPDATE AD_Field SET Name='Test UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203793) AND IsCentrallyMaintained='Y'
;

-- Mar 24, 2023, 4:38:56 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Test UU', Name='Test UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203793)
;

-- Mar 24, 2023, 4:39:33 PM CET
UPDATE AD_Column SET Name='Test UU', Description=NULL, Help=NULL, ColumnName='TestUU_UU', FieldLength=36, AD_Reference_ID=200234, AD_Reference_Value_ID=NULL, AD_Element_ID=203793,Updated=TO_TIMESTAMP('2023-03-24 16:39:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215805
;

-- Mar 24, 2023, 4:40:40 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203796,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:40:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:40:09','YYYY-MM-DD HH24:MI:SS'),100,'AltTestUU_UU','Alternate Test UU',NULL,NULL,'Alternate Test UU','D','1056f895-a7b0-49c0-b60e-1e5e702a19b1')
;

-- Mar 24, 2023, 4:41:07 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200236,'Test UU','T',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:41:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:41:07','YYYY-MM-DD HH24:MI:SS'),100,'D','N','3eaddbd9-67d0-4e16-ae0b-4a6acee3a1e6','N')
;

-- Mar 24, 2023, 4:42:05 PM CET
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,OrderByClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200236,200383,215785,215785,'TestUU.Name',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:42:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:42:05','YYYY-MM-DD HH24:MI:SS'),100,'N','D','00dc355b-14fe-4a48-aa7f-fb7a7b659ba1')
;

-- Mar 24, 2023, 4:42:24 PM CET
UPDATE AD_Column SET Name='Alternate Test UU', Description=NULL, Help=NULL, ColumnName='AltTestUU_UU', FieldLength=36, AD_Reference_ID=200235, AD_Reference_Value_ID=200236, AD_Element_ID=203796,Updated=TO_TIMESTAMP('2023-03-24 16:42:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215804
;

-- Mar 24, 2023, 4:42:33 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_TestUUDet', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-03-24 16:42:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215795
;

-- Mar 24, 2023, 4:42:33 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_TestUUDet', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-03-24 16:42:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215796
;

-- Mar 24, 2023, 4:42:33 PM CET
UPDATE AD_Column SET FKConstraintName='AltTestUUUU_TestUUDet', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-03-24 16:42:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215804
;

-- Mar 24, 2023, 4:42:33 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_TestUUDet', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-03-24 16:42:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215798
;

-- Mar 24, 2023, 4:42:33 PM CET
UPDATE AD_Column SET FKConstraintName='TestUUUU_TestUUDet', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-03-24 16:42:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215805
;

-- Mar 24, 2023, 4:42:33 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_TestUUDet', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-03-24 16:42:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215800
;

-- Mar 24, 2023, 4:42:33 PM CET
CREATE TABLE TestUUDet (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AltTestUU_UU VARCHAR(36) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, TestUUDet_UU VARCHAR(36) DEFAULT NULL , TestUU_UU VARCHAR(36) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT TestUUDet_UU_idx PRIMARY KEY (TestUUDet_UU))
;

-- Mar 24, 2023, 4:42:33 PM CET
ALTER TABLE TestUUDet ADD CONSTRAINT ADClient_TestUUDet FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2023, 4:42:33 PM CET
ALTER TABLE TestUUDet ADD CONSTRAINT ADOrg_TestUUDet FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2023, 4:42:33 PM CET
ALTER TABLE TestUUDet ADD CONSTRAINT AltTestUUUU_TestUUDet FOREIGN KEY (AltTestUU_UU) REFERENCES TestUU(TestUU_UU) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2023, 4:42:33 PM CET
ALTER TABLE TestUUDet ADD CONSTRAINT CreatedBy_TestUUDet FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2023, 4:42:33 PM CET
ALTER TABLE TestUUDet ADD CONSTRAINT TestUUUU_TestUUDet FOREIGN KEY (TestUU_UU) REFERENCES TestUU(TestUU_UU) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2023, 4:42:33 PM CET
ALTER TABLE TestUUDet ADD CONSTRAINT UpdatedBy_TestUUDet FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2023, 4:43:02 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200349,'Test UU Detail',200138,20,'Y',200384,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:01','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N',215805,'TestUUDet.Name','N',1,'N','D','Y','N','0c329e35-319d-401f-8be0-50bf1224e93b')
;

-- Mar 24, 2023, 4:43:02 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207582,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200349,215795,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c5d3b3f4-ad2c-4d5f-b389-6ce51b1d967a','Y',10,2)
;

-- Mar 24, 2023, 4:43:02 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207583,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200349,215796,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7247c80b-0079-4f1d-9f95-3ac8173b11c0','Y','Y',20,4,2)
;

-- Mar 24, 2023, 4:43:03 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207584,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200349,215803,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','db0f229a-b22f-413f-94e7-8564ec05f5e8','Y',30,5)
;

-- Mar 24, 2023, 4:43:03 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207585,'TestUUDet_UU',200349,215802,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e305c9af-7e70-4bce-bbdc-8a9822096ec1','N',2)
;

-- Mar 24, 2023, 4:43:03 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207586,'Alternate Test UU',200349,215804,'Y',36,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f0cfbddf-17ea-431c-9404-968a68b97f1b','Y',40,2)
;

-- Mar 24, 2023, 4:43:04 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207587,'Test UU',200349,215805,'Y',36,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a1ced8df-f59e-4f50-8e98-8ab46781d92e','Y',50,2)
;

-- Mar 24, 2023, 4:43:04 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207588,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200349,215801,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','42acf576-76b4-41d3-8ee1-2683e002308d','Y',60,2,2)
;

-- Mar 24, 2023, 4:43:04 PM CET
UPDATE AD_Table SET AD_Window_ID=200138,Updated=TO_TIMESTAMP('2023-03-24 16:43:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200384
;

-- Mar 24, 2023, 4:43:27 PM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200139,'Test UU Detail',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:27','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','d00d4825-3c3f-4fdb-b9fb-cfde86348020')
;

-- Mar 24, 2023, 4:43:27 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200350,'Test UU Detail',200139,10,'Y',200384,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','TestUUDet.Name','N',0,'N','D','Y','N','36b10541-db9c-4de4-b4de-2329979f4dff')
;

-- Mar 24, 2023, 4:43:28 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207589,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200350,215795,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','19c3b52e-5514-4e95-a30d-5e3bd82ca49a','Y',10,2)
;

-- Mar 24, 2023, 4:43:28 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207590,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200350,215796,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ffa6d972-4bab-499f-aada-f7770e9e056a','Y','Y',20,4,2)
;

-- Mar 24, 2023, 4:43:28 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207591,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200350,215803,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7419f61f-5227-4b7a-8ce8-17fbd4beb18b','Y',30,5)
;

-- Mar 24, 2023, 4:43:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207592,'TestUUDet_UU',200350,215802,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0dd84068-8f30-49ab-a8ee-9e5494e32a82','N',2)
;

-- Mar 24, 2023, 4:43:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207593,'Alternate Test UU',200350,215804,'Y',36,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','19a98247-e893-4dd8-a825-e76ae45576c0','Y',40,2)
;

-- Mar 24, 2023, 4:43:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207594,'Test UU',200350,215805,'Y',36,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3c5bf017-2dec-4ae3-88e9-b74f25e210f2','Y',50,2)
;

-- Mar 24, 2023, 4:43:30 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207595,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200350,215801,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c66bb88f-0819-47e4-90d7-1d7542efb934','Y',60,2,2)
;

-- Mar 24, 2023, 4:43:30 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200225,'Test UU Detail','W',200139,0,0,'Y',TO_TIMESTAMP('2023-03-24 16:43:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:43:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','acf261b2-7b3d-4a6d-8e02-4a9d37e968c1')
;

-- Mar 24, 2023, 4:43:30 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200225, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200225)
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200225
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200218
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200168
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200169
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200221
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200222
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=21,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=22,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=23,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=24,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=25,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=26,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=27,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200161
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=28,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=29,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Mar 24, 2023, 4:44:09 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=30,Updated=TO_TIMESTAMP('2023-03-24 16:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200177
;

-- Mar 24, 2023, 4:45:47 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2023-03-24 16:45:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207587
;

-- Mar 24, 2023, 4:45:47 PM CET
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2023-03-24 16:45:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207584
;

-- Mar 24, 2023, 4:45:47 PM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2023-03-24 16:45:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207586
;

-- Mar 24, 2023, 4:45:47 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-03-24 16:45:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207585
;

-- Mar 24, 2023, 4:46:00 PM CET
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2023-03-24 16:46:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215804
;

-- Mar 24, 2023, 4:46:02 PM CET
INSERT INTO t_alter_column values('testuudet','AltTestUU_UU','VARCHAR(36)',null,'NULL')
;

-- Mar 24, 2023, 4:46:02 PM CET
INSERT INTO t_alter_column values('testuudet','AltTestUU_UU',null,'NULL',null)
;

-- Mar 24, 2023, 4:46:41 PM CET
INSERT INTO TestUUDet (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,TestUUDet_UU,Name,TestUU_UU) VALUES (0,0,TO_TIMESTAMP('2023-03-24 16:46:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 16:46:41','YYYY-MM-DD HH24:MI:SS'),100,'Y','07218035-18bc-4593-b76d-d498fafc9f0b','Detail Record','4e148b89-bdd9-48a6-8a8a-7609092f965c')
;

-- Mar 24, 2023, 5:02:33 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2023-03-24 17:02:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207594
;

-- Mar 24, 2023, 5:02:33 PM CET
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2023-03-24 17:02:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207591
;

-- Mar 24, 2023, 5:02:33 PM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2023-03-24 17:02:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207593
;

-- Mar 24, 2023, 5:02:33 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-03-24 17:02:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207592
;

-- Mar 29, 2023, 8:16:07 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203799,0,0,'Y',TO_TIMESTAMP('2023-03-29 20:15:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-29 20:15:52','YYYY-MM-DD HH24:MI:SS'),100,'TestUU_UUs','Multi TestUU',NULL,NULL,'Multi TestUU','D','fa2ddd35-2dfe-4771-ad64-a276e878427c')
;

-- Mar 29, 2023, 8:16:45 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215809,0.0,'Multi TestUU',200384,'TestUU_UUs',2000,'N','N','Y','N','N',0,'N',200162,200236,0,0,'Y',TO_TIMESTAMP('2023-03-29 20:16:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-29 20:16:44','YYYY-MM-DD HH24:MI:SS'),100,203799,'Y','N','D','N','N','N','Y','efa1b7d2-8200-4bba-861b-87725ccf2099','Y','N','N','N','N')
;

-- Mar 29, 2023, 8:17:07 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2023-03-29 20:17:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215809
;

-- Mar 29, 2023, 8:17:09 PM CEST
ALTER TABLE TestUUDet ADD COLUMN TestUU_UUs VARCHAR(2000) DEFAULT NULL 
;

-- Mar 29, 2023, 8:17:31 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207599,'Multi TestUU',200349,215809,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-29 20:17:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-29 20:17:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c1927d34-4a3e-4207-9f0a-e0748be9ad67','Y',70,5)
;

-- Mar 29, 2023, 8:17:47 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=1,Updated=TO_TIMESTAMP('2023-03-29 20:17:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207599
;

-- Mar 29, 2023, 8:17:47 PM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2023-03-29 20:17:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207588
;

-- Mar 29, 2023, 8:18:17 PM CEST
UPDATE AD_Element SET Name='Multi Test UU', PrintName='Multi Test UU',Updated=TO_TIMESTAMP('2023-03-29 20:18:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203799
;

-- Mar 29, 2023, 8:18:17 PM CEST
UPDATE AD_Column SET ColumnName='TestUU_UUs', Name='Multi Test UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203799
;

-- Mar 29, 2023, 8:18:17 PM CEST
UPDATE AD_Process_Para SET ColumnName='TestUU_UUs', Name='Multi Test UU', Description=NULL, Help=NULL, AD_Element_ID=203799 WHERE UPPER(ColumnName)='TESTUU_UUS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 29, 2023, 8:18:17 PM CEST
UPDATE AD_Process_Para SET ColumnName='TestUU_UUs', Name='Multi Test UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203799 AND IsCentrallyMaintained='Y'
;

-- Mar 29, 2023, 8:18:17 PM CEST
UPDATE AD_InfoColumn SET ColumnName='TestUU_UUs', Name='Multi Test UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203799 AND IsCentrallyMaintained='Y'
;

-- Mar 29, 2023, 8:18:17 PM CEST
UPDATE AD_Field SET Name='Multi Test UU', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203799) AND IsCentrallyMaintained='Y'
;

-- Mar 29, 2023, 8:18:17 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Multi Test UU', Name='Multi Test UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203799)
;

-- Mar 29, 2023, 8:18:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207600,'Multi Test UU',200350,215809,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-29 20:18:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-29 20:18:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e35c3192-8704-490f-a79a-88b746588d64','Y',70,5)
;

-- Mar 29, 2023, 8:18:42 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=1,Updated=TO_TIMESTAMP('2023-03-29 20:18:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207600
;

-- Mar 29, 2023, 8:18:42 PM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2023-03-29 20:18:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207595
;

