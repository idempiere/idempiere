-- IDEMPIERE-5567 Trl
SELECT register_migration_script('202311261544_IDEMPIERE-5567_TestUU_Trl.sql') FROM dual;

-- Nov 26, 2023, 3:44:34 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2023-11-26 15:44:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215787
;

-- Nov 26, 2023, 3:44:34 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2023-11-26 15:44:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215788
;

-- Nov 26, 2023, 3:44:34 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2023-11-26 15:44:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215789
;

-- Nov 26, 2023, 3:44:34 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200401,'Test UU Based Table Trl','TestUU_Trl','7',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:34','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','D','Y','L','f9550679-8ca3-41b0-9cde-e0a548dcf810','N')
;

-- Nov 26, 2023, 3:44:35 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('TestUU_Trl',1000000,'N','N','Table TestUU_Trl','Y','Y',0,0,TO_TIMESTAMP('2023-11-26 15:44:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:34','YYYY-MM-DD HH24:MI:SS'),100,200472,'Y',1000000,1,200000,'92fb41f9-331d-4347-be48-bab548899ea6')
;

-- Nov 26, 2023, 3:44:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216115,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200401,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:35','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','9dba4404-cab0-45d0-a3cd-110254048910','N')
;

-- Nov 26, 2023, 3:44:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216116,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200401,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:35','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','1780d388-3915-4a54-a45a-ce91aa060628','N')
;

-- Nov 26, 2023, 3:44:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216117,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200401,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:35','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','e60eecc7-e025-411a-b021-937f67576e3c','N')
;

-- Nov 26, 2023, 3:44:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216118,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200401,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:36','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','16dc5467-d3bf-42d9-997c-9ef3810e9a93','N')
;

-- Nov 26, 2023, 3:44:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216119,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200401,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:36','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','2b729e86-ad3c-4903-9351-97ac067dc7c4','N')
;

-- Nov 26, 2023, 3:44:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216120,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200401,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:36','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','3530e79f-8bd4-4e00-9dc7-79552f4b1000','N')
;

-- Nov 26, 2023, 3:44:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216121,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200401,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:37','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','afb9d90e-74b1-40a6-836b-81ed1dd0c880','N')
;

-- Nov 26, 2023, 3:44:38 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216122,0.0,'Test UU',200401,'TestUU_UU',36,'N','Y','Y','N','N','N',200235,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:37','YYYY-MM-DD HH24:MI:SS'),100,203793,'N','N','D','N','8a59d366-92fd-49be-88c2-e6849ada566e','N','C')
;

-- Nov 26, 2023, 3:44:38 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203861,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:38','YYYY-MM-DD HH24:MI:SS'),100,'TestUU_Trl_UU','TestUU_Trl_UU','TestUU_Trl_UU','D','da895afb-ec26-46f9-b070-1e2272eb5c40')
;

-- Nov 26, 2023, 3:44:38 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216123,0.0,'TestUU_Trl_UU',200401,'TestUU_Trl_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:38','YYYY-MM-DD HH24:MI:SS'),100,203861,'Y','N','D','N','09d73322-2a14-4dc9-b7db-f64eb77082ea','N')
;

-- Nov 26, 2023, 3:44:39 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216124,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200401,'AD_Language',6,'N','Y','Y','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:38','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','6237c307-ae64-46af-ab3b-c1f96fa1a04c','N')
;

-- Nov 26, 2023, 3:44:39 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216125,0.0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200401,'IsTranslated','N',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:39','YYYY-MM-DD HH24:MI:SS'),100,420,'Y','N','D','N','26987a3f-db4e-4ad0-9670-7a5a51a279b8','N')
;

-- Nov 26, 2023, 3:44:39 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (216126,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200401,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:39','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','4c71cec2-96c2-489c-b160-208fb8c775b7',10,'N')
;

-- Nov 26, 2023, 3:44:40 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216127,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200401,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:39','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','N','D','N','c752348d-c243-473f-bec4-ff3698edb3da','N')
;

-- Nov 26, 2023, 3:44:40 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216128,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200401,'Help',2000,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:44:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:44:40','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','e6f341ee-bb79-425c-acf3-dc333084834e','N')
;

-- Nov 26, 2023, 3:44:40 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201264,'340c302a-9e94-4580-b0fa-2483f12c1f28',TO_TIMESTAMP('2023-11-26 15:44:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','TestUU_Trl_pkey',TO_TIMESTAMP('2023-11-26 15:44:40','YYYY-MM-DD HH24:MI:SS'),100,200401,'Y','Y','N','Y')
;

-- Nov 26, 2023, 3:44:41 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201712,'b8e0052c-2844-4fad-831f-b73dc1446f0e',TO_TIMESTAMP('2023-11-26 15:44:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-11-26 15:44:41','YYYY-MM-DD HH24:MI:SS'),100,216124,201264,10)
;

-- Nov 26, 2023, 3:44:41 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201713,'0661b58b-f207-48d3-af48-ebb85049adab',TO_TIMESTAMP('2023-11-26 15:44:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-11-26 15:44:41','YYYY-MM-DD HH24:MI:SS'),100,216122,201264,20)
;

-- Nov 26, 2023, 3:44:57 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_TestUUTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-11-26 15:44:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216115
;

-- Nov 26, 2023, 3:44:57 PM CET
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADLanguage_TestUUTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-11-26 15:44:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216124
;

-- Nov 26, 2023, 3:44:57 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_TestUUTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-11-26 15:44:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216116
;

-- Nov 26, 2023, 3:44:57 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_TestUUTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-11-26 15:44:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216118
;

-- Nov 26, 2023, 3:44:57 PM CET
UPDATE AD_Column SET FieldLength=36, IsUpdateable='N', FKConstraintName='TestUUUU_TestUUTrl', FKConstraintType='C',Updated=TO_TIMESTAMP('2023-11-26 15:44:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216122
;

-- Nov 26, 2023, 3:44:57 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_TestUUTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-11-26 15:44:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216120
;

-- Nov 26, 2023, 3:44:57 PM CET
CREATE TABLE TestUU_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , Help VARCHAR(2000) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, TestUU_Trl_UU VARCHAR(36) DEFAULT NULL , TestUU_UU VARCHAR(36) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT TestUU_Trl_UU_idx UNIQUE (TestUU_Trl_UU))
;

-- Nov 26, 2023, 3:44:57 PM CET
ALTER TABLE TestUU_Trl ADD CONSTRAINT ADClient_TestUUTrl FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 26, 2023, 3:44:57 PM CET
ALTER TABLE TestUU_Trl ADD CONSTRAINT ADLanguage_TestUUTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 26, 2023, 3:44:57 PM CET
ALTER TABLE TestUU_Trl ADD CONSTRAINT ADOrg_TestUUTrl FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 26, 2023, 3:44:57 PM CET
ALTER TABLE TestUU_Trl ADD CONSTRAINT CreatedBy_TestUUTrl FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 26, 2023, 3:44:57 PM CET
ALTER TABLE TestUU_Trl ADD CONSTRAINT TestUUUU_TestUUTrl FOREIGN KEY (TestUU_UU) REFERENCES TestUU(TestUU_UU) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Nov 26, 2023, 3:44:57 PM CET
ALTER TABLE TestUU_Trl ADD CONSTRAINT UpdatedBy_TestUUTrl FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 26, 2023, 3:45:03 PM CET
ALTER TABLE TestUU_Trl ADD CONSTRAINT TestUU_Trl_pkey PRIMARY KEY (AD_Language,TestUU_UU)
;

-- Nov 26, 2023, 3:45:28 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200371,'Test UU Based Table Trl',200138,30,'Y',200401,0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N',216122,'TestUU_Trl.AD_Language','N',1,'N','D','N','N','6eb8bbc8-8eae-4eb3-8b6d-9822e23ee57c')
;

-- Nov 26, 2023, 3:45:28 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207950,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200371,216115,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','89695be2-6d4f-4e9f-8ae5-bb31149269f3','Y',10,2)
;

-- Nov 26, 2023, 3:45:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207951,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200371,216116,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e256cee8-00ac-48ac-b1e4-22bae6ad4188','Y','Y',20,4,2)
;

-- Nov 26, 2023, 3:45:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207952,'Test UU',200371,216122,'Y',36,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7c6645af-8d3f-497f-bc66-612e53186386','Y',30,2)
;

-- Nov 26, 2023, 3:45:30 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207953,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200371,216124,'Y',6,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e986bf2e-21df-41db-b606-a24900a74f93','Y',40,2)
;

-- Nov 26, 2023, 3:45:30 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207954,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200371,216126,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8b5421ac-c314-48ad-b3f1-bfab1ea6ed8a','Y',50,5)
;

-- Nov 26, 2023, 3:45:30 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207955,'Description','Optional short description of the record','A description is limited to 255 characters.',200371,216127,'Y',255,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8cdde0c5-37ae-4ae5-8d57-702a40527a9a','Y',60,5)
;

-- Nov 26, 2023, 3:45:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207956,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200371,216128,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','294b6600-250a-48f0-9502-21a2b2961085','Y',70,5)
;

-- Nov 26, 2023, 3:45:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207957,'TestUU_Trl_UU',200371,216123,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7581c45a-2510-4d92-9a47-c160f0edcf0b','N',2)
;

-- Nov 26, 2023, 3:45:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207958,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200371,216125,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fc51a42a-234f-42a2-8689-ca5e4d751f7b','Y',80,2,2)
;

-- Nov 26, 2023, 3:45:32 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207959,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200371,216121,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 15:45:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 15:45:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','14d0bc41-1c29-4bd3-af25-030040ed1524','Y',90,2,2)
;

-- Nov 26, 2023, 3:45:32 PM CET
UPDATE AD_Table SET AD_Window_ID=200138,Updated=TO_TIMESTAMP('2023-11-26 15:45:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200401
;

-- Nov 26, 2023, 3:45:48 PM CET
UPDATE AD_Tab SET SeqNo=30,Updated=TO_TIMESTAMP('2023-11-26 15:45:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200349
;

-- Nov 26, 2023, 3:45:52 PM CET
UPDATE AD_Tab SET SeqNo=20,Updated=TO_TIMESTAMP('2023-11-26 15:45:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200371
;

INSERT INTO testuu_trl (ad_client_id, ad_language, ad_org_id, created, createdby, description, help, isactive, istranslated, name, testuu_trl_uu, testuu_uu, updated, updatedby) VALUES(0, 'es_CO', 0, TO_TIMESTAMP('2023-11-26 15:52:23','YYYY-MM-DD HH24:MI:SS'), 100, NULL, NULL, 'Y', 'N', 'Test Record in System', 'c0becbd2-08bc-4c8a-9c03-1895647c16a8', '4e148b89-bdd9-48a6-8a8a-7609092f965c', TO_TIMESTAMP('2023-11-26 15:52:23','YYYY-MM-DD HH24:MI:SS'), 100);

INSERT INTO testuu_trl (ad_client_id, ad_language, ad_org_id, created, createdby, description, help, isactive, istranslated, name, testuu_trl_uu, testuu_uu, updated, updatedby) VALUES(11, 'es_CO', 0, TO_TIMESTAMP('2023-11-26 15:52:23','YYYY-MM-DD HH24:MI:SS'), 100, 'Lorem ipsum dolor sit amet', 'consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut', 'Y', 'N', 'Test Record in GardenWorld', 'a7ed6616-fe23-4883-a33c-37d05a954acb', '8858ecc2-cf1d-405f-987f-793536037e76', TO_TIMESTAMP('2023-11-26 15:52:23','YYYY-MM-DD HH24:MI:SS'), 100);

