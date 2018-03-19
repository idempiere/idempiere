-- Mar 21, 2014 8:22:37 PM CET
-- IDEMPIERE-1216
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200111,'6f00794a-f435-4cc0-9fd2-f929ffd890bd',131,'2',TO_TIMESTAMP('2014-03-21 20:22:34','YYYY-MM-DD HH24:MI:SS'),100,'General Ledger Category','D','Y','Y','Y','N','N','N','N',95,'GL Category translation','N','L','GL_Category_Trl',TO_TIMESTAMP('2014-03-21 20:22:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:22:37 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200159,'2fb7d254-9d82-4bf5-81c6-995bc4fcaa24',TO_TIMESTAMP('2014-03-21 20:22:37','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table GL_Category_Trl',1,'Y','N','Y','Y','GL_Category_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:22:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:22:46 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,210989,'dae5d723-2fe3-4d09-a616-7e33a8a9722d',102,0,19,200111,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:22:46','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:22:46','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:22:47 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,210990,'6341de0e-d565-453d-9517-d2a8639c46ac',113,0,19,200111,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:22:46','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:22:46','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:22:47 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,210991,'c4c222b0-2796-4616-81fe-4241243cd12f',245,0,16,200111,'Created',TO_TIMESTAMP('2014-03-21 20:22:47','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:22:47','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:22:48 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,210992,'9dc774e7-30a8-4199-8426-452bead3c28f',246,0,18,110,200111,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:22:47','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:22:47','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:22:48 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,210993,'d0087d4a-de50-4941-bfaf-65d9ce149b2d',348,0,20,200111,'IsActive',TO_TIMESTAMP('2014-03-21 20:22:48','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:22:48','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:22:49 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,210994,'c88fd2ac-265f-445d-a9f5-1528960095ec',607,0,16,200111,'Updated',TO_TIMESTAMP('2014-03-21 20:22:48','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:22:48','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:22:49 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,210995,'750d6a4c-cc28-4a8c-8390-15ec35b31570',608,0,18,110,200111,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:22:49','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:22:49','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:22:49 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,210996,'1605afe8-01ea-4c57-8a94-37a4e6f65a3a',109,0,18,106,200111,'AD_Language',TO_TIMESTAMP('2014-03-21 20:22:49','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:22:49','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:22:50 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,210997,'11647915-145e-4936-b8fd-8625dd43a721',420,0,20,200111,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:22:49','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:22:49','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:22:50 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202675,'1adc5e38-0f7d-49ab-aeaa-aaf2f1f3ebf9',0,'GL_Category_Trl_UU',TO_TIMESTAMP('2014-03-21 20:22:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_Category_Trl_UU','GL_Category_Trl_UU',TO_TIMESTAMP('2014-03-21 20:22:50','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:22:51 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,210998,'cd6f0819-8435-4e95-8499-509917453a48',202675,0,10,200111,'GL_Category_Trl_UU',TO_TIMESTAMP('2014-03-21 20:22:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_Category_Trl_UU',TO_TIMESTAMP('2014-03-21 20:22:50','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:22:51 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,210999,'06346bb5-6b54-4cec-857f-c76289f090db',309,0,30,200111,'GL_Category_ID',TO_TIMESTAMP('2014-03-21 20:22:51','YYYY-MM-DD HH24:MI:SS'),100,'General Ledger Category','D','C',22,'The General Ledger Category is an optional, user defined method of grouping journal lines.','Y','N','N','N','N','Y','Y','N','N','N','GL Category',TO_TIMESTAMP('2014-03-21 20:22:51','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:23:29 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:23:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1538
;

-- Mar 21, 2014 8:24:06 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,211000,'63a0a564-36f2-4fa8-aff2-90cae0d1fc0c',469,0,10,200111,'Name',TO_TIMESTAMP('2014-03-21 20:24:06','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','Y','N','N','N','N','Y','N','N','N','Y','Name',0,0,TO_TIMESTAMP('2014-03-21 20:24:06','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 21, 2014 8:24:10 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_GLCategoryTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 20:24:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210989
;

-- Mar 21, 2014 8:24:10 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_GLCategoryTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 20:24:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210996
;

-- Mar 21, 2014 8:24:10 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_GLCategoryTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 20:24:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210990
;

-- Mar 21, 2014 8:24:10 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_GLCategoryTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 20:24:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210992
;

-- Mar 21, 2014 8:24:10 PM CET
UPDATE AD_Column SET FKConstraintName='GLCategory_GLCategoryTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 20:24:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210999
;

-- Mar 21, 2014 8:24:10 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_GLCategoryTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 20:24:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210995
;

-- Mar 21, 2014 8:24:10 PM CET
CREATE TABLE GL_Category_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, GL_Category_ID NUMERIC(10) NOT NULL, GL_Category_Trl_UU VARCHAR(36) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT GL_Category_Trl_Key PRIMARY KEY (AD_Language, GL_Category_ID), CONSTRAINT GL_Category_Trl_UU_idx UNIQUE (GL_Category_Trl_UU))
;

-- Mar 21, 2014 8:24:10 PM CET
ALTER TABLE GL_Category_Trl ADD CONSTRAINT ADClient_GLCategoryTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 8:24:10 PM CET
ALTER TABLE GL_Category_Trl ADD CONSTRAINT ADLanguage_GLCategoryTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 8:24:10 PM CET
ALTER TABLE GL_Category_Trl ADD CONSTRAINT ADOrg_GLCategoryTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 8:24:11 PM CET
ALTER TABLE GL_Category_Trl ADD CONSTRAINT CreatedBy_GLCategoryTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 8:24:11 PM CET
ALTER TABLE GL_Category_Trl ADD CONSTRAINT GLCategory_GLCategoryTrl FOREIGN KEY (GL_Category_ID) REFERENCES GL_CATEGORY(GL_CATEGORY_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 8:24:11 PM CET
ALTER TABLE GL_Category_Trl ADD CONSTRAINT UpdatedBy_GLCategoryTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 8:24:59 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,210999,0,200121,'a3ed1762-3d79-484f-b74e-6324739ddb4f',200111,131,TO_TIMESTAMP('2014-03-21 20:24:58','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','Y','N','Y','N','Y','Translation','N',20,1,TO_TIMESTAMP('2014-03-21 20:24:58','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:25:01 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210989,202701,'6494d405-e96a-4030-8101-66c2caf62643',0,200121,2,TO_TIMESTAMP('2014-03-21 20:25:01','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:25:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:25:01 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,210990,202702,'9cd14319-88ca-4e5c-9f13-c4d05a16bc21',0,200121,2,TO_TIMESTAMP('2014-03-21 20:25:01','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:25:01','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:25:02 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211000,202703,'a965c238-84f3-4b7e-87f1-b88df064f690',0,200121,5,TO_TIMESTAMP('2014-03-21 20:25:01','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:25:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:25:02 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210996,202704,'c68f69f9-ce48-433d-aa5a-ec20abb9dd9b',0,200121,2,TO_TIMESTAMP('2014-03-21 20:25:02','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',40,TO_TIMESTAMP('2014-03-21 20:25:02','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:25:03 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,210997,202705,'d3b144d7-2765-4251-8b10-03f09f63b8b1',0,200121,2,TO_TIMESTAMP('2014-03-21 20:25:02','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',50,TO_TIMESTAMP('2014-03-21 20:25:02','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:25:03 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210998,202706,'327d7c7a-cfe7-43d6-b025-9cea4879fbbc',0,200121,2,TO_TIMESTAMP('2014-03-21 20:25:03','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','GL_Category_Trl_UU',60,TO_TIMESTAMP('2014-03-21 20:25:03','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:25:04 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210999,202707,'77be2282-a9db-46d7-b66d-6d9342e12210',0,200121,2,TO_TIMESTAMP('2014-03-21 20:25:03','YYYY-MM-DD HH24:MI:SS'),100,'General Ledger Category',22,'D','The General Ledger Category is an optional, user defined method of grouping journal lines.','Y','Y','Y','N','N','N','N','N','GL Category',70,TO_TIMESTAMP('2014-03-21 20:25:03','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:25:04 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,210993,202708,'ec70c1fd-94cf-44e1-a893-46c6b2f8cb21',0,200121,2,TO_TIMESTAMP('2014-03-21 20:25:04','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',80,TO_TIMESTAMP('2014-03-21 20:25:04','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:25:08 PM CET
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2014-03-21 20:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200121
;

-- Mar 21, 2014 8:26:47 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:26:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202707
;

-- Mar 21, 2014 8:26:47 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:26:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202705
;

-- Mar 21, 2014 8:26:47 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:26:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202708
;

-- Mar 21, 2014 8:26:47 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:26:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202703
;

-- Mar 21, 2014 8:26:47 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:26:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202706
;

-- Mar 21, 2014 8:26:58 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:26:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202704
;

-- Mar 21, 2014 8:27:50 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:27:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1777
;

-- Mar 21, 2014 8:27:58 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:27:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1776
;

-- Mar 21, 2014 8:28:17 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200112,'0c430151-d0f1-420a-ac9f-5d75e3723f27',144,'3',TO_TIMESTAMP('2014-03-21 20:28:17','YYYY-MM-DD HH24:MI:SS'),100,'Category of a Product','D','Y','Y','Y','N','N','N','N',75,'Product Category translation','N','L','M_Product_Category_Trl',TO_TIMESTAMP('2014-03-21 20:28:17','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:28:18 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200160,'38442386-f935-45af-bbb7-4f019eceda9b',TO_TIMESTAMP('2014-03-21 20:28:17','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table M_Product_Category_Trl',1,'Y','N','Y','Y','M_Product_Category_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:28:17','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:28:22 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211001,'632983e9-fc19-49e0-9c4f-be6c476a92bc',102,0,19,200112,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:28:22','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:28:22','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:28:23 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211002,'f9073efa-462c-4569-abf8-e38da1ffbbaa',113,0,19,200112,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:28:22','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:28:22','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:28:23 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211003,'018eacd2-2520-4bbc-8fad-a86721093e17',245,0,16,200112,'Created',TO_TIMESTAMP('2014-03-21 20:28:23','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:28:23','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:28:24 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211004,'14312dd7-70f9-405e-a437-8e43481771d9',246,0,18,110,200112,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:28:23','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:28:23','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:28:24 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211005,'83985643-1987-48f8-8fa7-7f4f09fbf95d',348,0,20,200112,'IsActive',TO_TIMESTAMP('2014-03-21 20:28:24','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:28:24','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:28:24 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211006,'8e8de0bd-cf7a-4e37-b0a7-9b462b12823c',607,0,16,200112,'Updated',TO_TIMESTAMP('2014-03-21 20:28:24','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:28:24','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:28:25 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211007,'9a5d5a99-3ced-4ffa-8efd-3a5bb1ba5943',608,0,18,110,200112,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:28:24','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:28:24','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:28:25 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211008,'6273da22-bcb6-4a01-a6b0-6ec2b28e66ca',109,0,18,106,200112,'AD_Language',TO_TIMESTAMP('2014-03-21 20:28:25','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:28:25','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:28:26 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211009,'5706fc4a-31dc-4451-b9c2-a350d12fed94',420,0,20,200112,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:28:25','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:28:25','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:28:26 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211010,'e9943dfc-6a12-445c-b888-d78dbe36dfac',275,0,10,200112,'Description',TO_TIMESTAMP('2014-03-21 20:28:26','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record','D',255,'A description is limited to 255 characters.','Y','N','Y','Y','N','N','N','N','N','N','N','Y','N','N','N','Y','Description',TO_TIMESTAMP('2014-03-21 20:28:26','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:28:27 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211011,'d7fd5a2b-41bf-4ddb-b449-d9b0ee15cc66',469,0,10,200112,'Name',TO_TIMESTAMP('2014-03-21 20:28:26','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','Y','N','N','N','Y','Name',1,TO_TIMESTAMP('2014-03-21 20:28:26','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:28:27 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202676,'2c02e19e-9c1e-4177-be3c-f96e0a182909',0,'M_Product_Category_Trl_UU',TO_TIMESTAMP('2014-03-21 20:28:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Product_Category_Trl_UU','M_Product_Category_Trl_UU',TO_TIMESTAMP('2014-03-21 20:28:27','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:28:28 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211012,'d10f6459-aeac-41dd-832e-074f03d8cdeb',202676,0,10,200112,'M_Product_Category_Trl_UU',TO_TIMESTAMP('2014-03-21 20:28:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Product_Category_Trl_UU',TO_TIMESTAMP('2014-03-21 20:28:27','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:28:28 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211013,'db4b501d-a574-4743-ab81-c7818bc86115',453,0,30,200112,'M_Product_Category_ID',TO_TIMESTAMP('2014-03-21 20:28:28','YYYY-MM-DD HH24:MI:SS'),100,'Category of a Product','D','C',22,'Identifies the category which this product belongs to.  Product categories are used for pricing and selection.','Y','N','N','N','N','Y','Y','N','N','N','Product Category',TO_TIMESTAMP('2014-03-21 20:28:28','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:29:31 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,211013,0,200122,'ed52b38e-a01a-443b-8a50-88ddf46b259b',200112,144,TO_TIMESTAMP('2014-03-21 20:29:31','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','N','N','Y','N','Y','Translation','N',40,1,TO_TIMESTAMP('2014-03-21 20:29:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:29:34 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211001,202709,'d33f03a6-026d-4d9b-bdf3-277a9b47e34b',0,200122,2,TO_TIMESTAMP('2014-03-21 20:29:34','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:29:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:29:34 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211002,202710,'81be15cb-f41a-4361-bd1e-1376142f4108',0,200122,2,TO_TIMESTAMP('2014-03-21 20:29:34','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:29:34','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:29:35 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211011,202711,'7b47e481-bc44-4d89-846a-d509f29345d4',0,200122,5,TO_TIMESTAMP('2014-03-21 20:29:34','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:29:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:29:35 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211010,202712,'7b71e310-3236-4024-94d3-e58a92a949a1',0,200122,5,TO_TIMESTAMP('2014-03-21 20:29:35','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',255,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',40,TO_TIMESTAMP('2014-03-21 20:29:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:29:36 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211008,202713,'8adc4e56-68d6-41e0-9d6d-6a114bd14cb7',0,200122,2,TO_TIMESTAMP('2014-03-21 20:29:35','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',50,TO_TIMESTAMP('2014-03-21 20:29:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:29:36 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211009,202714,'1ba9b622-9839-4ab2-9ab0-492ffb2e956a',0,200122,2,TO_TIMESTAMP('2014-03-21 20:29:36','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',60,TO_TIMESTAMP('2014-03-21 20:29:36','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:29:37 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211012,202715,'5b8e7e03-a053-4bbb-bd6a-2ffc1a49f366',0,200122,2,TO_TIMESTAMP('2014-03-21 20:29:36','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','M_Product_Category_Trl_UU',70,TO_TIMESTAMP('2014-03-21 20:29:36','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:29:37 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211013,202716,'87776289-b91d-473c-b8aa-43c27b8ae7bd',0,200122,2,TO_TIMESTAMP('2014-03-21 20:29:37','YYYY-MM-DD HH24:MI:SS'),100,'Category of a Product',22,'D','Identifies the category which this product belongs to.  Product categories are used for pricing and selection.','Y','Y','Y','N','N','N','N','N','Product Category',80,TO_TIMESTAMP('2014-03-21 20:29:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:29:37 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211005,202717,'b9d16e7d-467f-4cb5-9412-886fc153ad43',0,200122,2,TO_TIMESTAMP('2014-03-21 20:29:37','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',90,TO_TIMESTAMP('2014-03-21 20:29:37','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:29:52 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:29:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202713
;

-- Mar 21, 2014 8:30:37 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:30:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202716
;

-- Mar 21, 2014 8:30:37 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:30:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202713
;

-- Mar 21, 2014 8:30:37 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:30:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202717
;

-- Mar 21, 2014 8:30:37 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:30:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202714
;

-- Mar 21, 2014 8:30:37 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:30:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202711
;

-- Mar 21, 2014 8:30:37 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2014-03-21 20:30:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202712
;

-- Mar 21, 2014 8:30:37 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:30:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202715
;

-- Mar 21, 2014 8:31:14 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:31:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8106
;

-- Mar 21, 2014 8:31:20 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:31:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8107
;

-- Mar 21, 2014 8:31:32 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:31:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8105
;

-- Mar 21, 2014 8:31:52 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200113,'45af1d3d-2244-443f-8f13-984f043eaf71',252,'3',TO_TIMESTAMP('2014-03-21 20:31:52','YYYY-MM-DD HH24:MI:SS'),100,'Group of Assets','D','Y','Y','Y','N','N','N','N',70,'Asset Group translation','N','L','A_Asset_Group_Trl',TO_TIMESTAMP('2014-03-21 20:31:52','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:31:53 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200161,'04c9d044-f247-418b-92fa-f5353f39f99d',TO_TIMESTAMP('2014-03-21 20:31:52','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table A_Asset_Group_Trl',1,'Y','N','Y','Y','A_Asset_Group_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:31:52','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:31:59 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211014,'0a91c23d-3f5d-4c45-af5d-306d8b1c7c90',102,0,19,200113,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:31:59','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:31:59','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:00 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211015,'372b6cec-dd23-47ba-b1c2-f567ec2a5973',113,0,19,200113,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:31:59','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:31:59','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:00 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211016,'0aca7338-1acb-47d4-8512-f5ecc868895a',245,0,16,200113,'Created',TO_TIMESTAMP('2014-03-21 20:32:00','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:32:00','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:01 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211017,'1dc51870-9eff-437c-ad57-076e51b2b63c',246,0,18,110,200113,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:32:00','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:32:00','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:01 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211018,'bd4f49fa-35a2-4c46-9d00-392273528f14',348,0,20,200113,'IsActive',TO_TIMESTAMP('2014-03-21 20:32:01','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:32:01','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:01 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211019,'73be4e71-bd45-4442-a4af-06de9455431b',607,0,16,200113,'Updated',TO_TIMESTAMP('2014-03-21 20:32:01','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:32:01','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:02 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211020,'a98d5743-dee7-42bb-be48-e25903e18781',608,0,18,110,200113,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:32:01','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:32:01','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:02 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211021,'e2b49424-1cf6-47ad-a6a3-d5b4bec3b0af',109,0,18,106,200113,'AD_Language',TO_TIMESTAMP('2014-03-21 20:32:02','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:32:02','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:03 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211022,'56ff1a10-73c5-4f3d-a249-ddc6020c0d0f',420,0,20,200113,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:32:02','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:32:02','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:03 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211023,'fa52b109-ca75-4487-adab-4eba5bfbcc5b',275,0,10,200113,'Description',TO_TIMESTAMP('2014-03-21 20:32:03','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record','D',255,'A description is limited to 255 characters.','Y','N','Y','Y','N','N','N','N','N','N','N','N','Y','N','N','Y','Description',0,TO_TIMESTAMP('2014-03-21 20:32:03','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 21, 2014 8:32:04 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211024,'0d7bac8e-777a-49d5-98ae-819bf635b54c',326,0,14,200113,'Help',TO_TIMESTAMP('2014-03-21 20:32:03','YYYY-MM-DD HH24:MI:SS'),100,'Comment or Hint','D',2000,'The Help field contains a hint, comment or help about the use of this item.','Y','N','Y','Y','N','N','N','N','N','N','N','N','Y','N','N','Y','Comment/Help',0,TO_TIMESTAMP('2014-03-21 20:32:03','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 21, 2014 8:32:04 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211025,'7dece6de-6240-43d9-8b5c-12a9a770deb7',469,0,10,200113,'Name',TO_TIMESTAMP('2014-03-21 20:32:04','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','N','Y','N','N','Y','Name',2,TO_TIMESTAMP('2014-03-21 20:32:04','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 21, 2014 8:32:05 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202677,'3166c5e8-b6b5-4e4b-8e52-1f1f9cfd57cd',0,'A_Asset_Group_Trl_UU',TO_TIMESTAMP('2014-03-21 20:32:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Group_Trl_UU','A_Asset_Group_Trl_UU',TO_TIMESTAMP('2014-03-21 20:32:04','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:32:05 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211026,'0be1399d-a4ce-4fa8-9f6a-6cb4d2c53e62',202677,0,10,200113,'A_Asset_Group_Trl_UU',TO_TIMESTAMP('2014-03-21 20:32:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Group_Trl_UU',TO_TIMESTAMP('2014-03-21 20:32:05','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:06 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211027,'fdae86ee-4aa7-414c-8cc3-c6af1db57ccc',1929,0,30,200113,'A_Asset_Group_ID',TO_TIMESTAMP('2014-03-21 20:32:05','YYYY-MM-DD HH24:MI:SS'),100,'Group of Assets','D','C',22,'The group of assets determines default accounts.  If an asset group is selected in the product category, assets are created when delivering the asset.','Y','N','N','N','N','Y','Y','N','N','N','Asset Group',TO_TIMESTAMP('2014-03-21 20:32:05','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:32:58 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,211027,0,200123,'7a331165-5e30-486c-a949-31daa9326d97',200113,252,TO_TIMESTAMP('2014-03-21 20:32:57','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','N','N','Y','N','Y','Translation','N',30,1,TO_TIMESTAMP('2014-03-21 20:32:57','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:33:00 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211014,202718,'0afb5293-931a-48e2-be2b-1717db7f1b65',0,200123,2,TO_TIMESTAMP('2014-03-21 20:32:59','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:32:59','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:33:00 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211015,202719,'e3467d3a-0f29-4040-818e-05f471cc963a',0,200123,2,TO_TIMESTAMP('2014-03-21 20:33:00','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:33:00','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:33:01 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211025,202720,'c00952b9-2a0b-4920-8f66-ba28e552cc1c',0,200123,5,TO_TIMESTAMP('2014-03-21 20:33:00','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:33:00','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:33:01 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211023,202721,'73dbdeb6-8352-42ce-bd3d-e985da38f338',0,200123,5,TO_TIMESTAMP('2014-03-21 20:33:01','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',255,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',40,TO_TIMESTAMP('2014-03-21 20:33:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:33:02 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,NumLines,SeqNo,Updated,UpdatedBy) VALUES (0,211024,202722,'84df730b-cb54-42b4-ad25-56e82e829972',0,200123,5,TO_TIMESTAMP('2014-03-21 20:33:01','YYYY-MM-DD HH24:MI:SS'),100,'Comment or Hint',2000,'D','The Help field contains a hint, comment or help about the use of this item.','Y','Y','Y','N','N','N','N','N','Comment/Help',3,50,TO_TIMESTAMP('2014-03-21 20:33:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:33:02 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211021,202723,'7a643ce1-f830-4682-a230-af3ccf4093b8',0,200123,2,TO_TIMESTAMP('2014-03-21 20:33:02','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',60,TO_TIMESTAMP('2014-03-21 20:33:02','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:33:02 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211022,202724,'19eff860-3296-4b13-bc7a-71f48af6045e',0,200123,2,TO_TIMESTAMP('2014-03-21 20:33:02','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',70,TO_TIMESTAMP('2014-03-21 20:33:02','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:33:03 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211026,202725,'c5961ee2-1d15-480a-8b90-be6d56376ab1',0,200123,2,TO_TIMESTAMP('2014-03-21 20:33:02','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','A_Asset_Group_Trl_UU',80,TO_TIMESTAMP('2014-03-21 20:33:02','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:33:03 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211027,202726,'bdde1025-08cb-4f75-8032-d7dea78e3cea',0,200123,2,TO_TIMESTAMP('2014-03-21 20:33:03','YYYY-MM-DD HH24:MI:SS'),100,'Group of Assets',22,'D','The group of assets determines default accounts.  If an asset group is selected in the product category, assets are created when delivering the asset.','Y','Y','Y','N','N','N','N','N','Asset Group',90,TO_TIMESTAMP('2014-03-21 20:33:03','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:33:04 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211018,202727,'14ad73c2-7757-452b-aacd-7564d84f6228',0,200123,2,TO_TIMESTAMP('2014-03-21 20:33:03','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',100,TO_TIMESTAMP('2014-03-21 20:33:03','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:33:38 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:33:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202726
;

-- Mar 21, 2014 8:33:38 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:33:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202723
;

-- Mar 21, 2014 8:33:38 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:33:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202727
;

-- Mar 21, 2014 8:33:38 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:33:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202724
;

-- Mar 21, 2014 8:33:38 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:33:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202720
;

-- Mar 21, 2014 8:33:38 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2014-03-21 20:33:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202721
;

-- Mar 21, 2014 8:33:38 PM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2014-03-21 20:33:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202722
;

-- Mar 21, 2014 8:33:38 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:33:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202725
;

-- Mar 21, 2014 8:33:59 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:33:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202723
;

-- Mar 21, 2014 8:34:30 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6230
;

-- Mar 21, 2014 8:34:49 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200114,'caf54952-5dff-43e1-9432-80245fc3d4de',225,'4',TO_TIMESTAMP('2014-03-21 20:34:48','YYYY-MM-DD HH24:MI:SS'),100,'Color for backgrounds or indicators','D','Y','Y','Y','N','N','N','N',45,'System Color Translation','N','L','AD_Color_Trl',TO_TIMESTAMP('2014-03-21 20:34:48','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:34:49 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200162,'444b1091-4d6b-4aa2-8931-e7b80ea2e003',TO_TIMESTAMP('2014-03-21 20:34:49','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table AD_Color_Trl',1,'Y','N','Y','Y','AD_Color_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:34:49','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:34:53 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211028,'9c0bbfcf-3a45-4872-af1f-3793f9043927',102,0,19,200114,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:34:53','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:34:53','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:34:54 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211029,'b1af5186-1b5e-432f-817a-f200bf8963cd',113,0,19,200114,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:34:53','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:34:53','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:34:54 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211030,'14eef8b5-b163-404f-ac3b-5aa427dcee3b',245,0,16,200114,'Created',TO_TIMESTAMP('2014-03-21 20:34:54','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:34:54','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:34:55 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211031,'e32e273e-e7b3-4d4f-96c2-1e497cc9eb8e',246,0,18,110,200114,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:34:54','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:34:54','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:34:55 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211032,'e934d87a-3783-4354-a333-6f64724a9e94',348,0,20,200114,'IsActive',TO_TIMESTAMP('2014-03-21 20:34:55','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:34:55','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:34:55 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211033,'d901f6eb-d1b8-4df8-a1a2-04dc0fd795e4',607,0,16,200114,'Updated',TO_TIMESTAMP('2014-03-21 20:34:55','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:34:55','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:34:56 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211034,'06087b93-f8e1-4f60-89a7-06add1857610',608,0,18,110,200114,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:34:55','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:34:55','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:34:56 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211035,'4ad190a6-9ec3-4711-9acf-bfb687cd2dd2',109,0,18,106,200114,'AD_Language',TO_TIMESTAMP('2014-03-21 20:34:56','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:34:56','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:34:57 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211036,'1076c513-ca27-4cd7-9c8f-b38ecda4a3f3',420,0,20,200114,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:34:56','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:34:56','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:34:57 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211037,'86ca30df-dd47-4aa2-aede-aec945325744',469,0,10,200114,'Name',TO_TIMESTAMP('2014-03-21 20:34:57','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','Y','N','N','N','Y','Name',1,TO_TIMESTAMP('2014-03-21 20:34:57','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:34:58 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202678,'406d013b-ece6-4b94-bced-8d634fb1b6ec',0,'AD_Color_Trl_UU',TO_TIMESTAMP('2014-03-21 20:34:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Color_Trl_UU','AD_Color_Trl_UU',TO_TIMESTAMP('2014-03-21 20:34:57','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:34:58 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211038,'9e84d280-936c-4234-95e6-3a2288149fc6',202678,0,10,200114,'AD_Color_Trl_UU',TO_TIMESTAMP('2014-03-21 20:34:58','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Color_Trl_UU',TO_TIMESTAMP('2014-03-21 20:34:58','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:34:59 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211039,'8ea96105-791f-4427-badc-73bc928f99ca',1636,0,30,200114,'AD_Color_ID',TO_TIMESTAMP('2014-03-21 20:34:58','YYYY-MM-DD HH24:MI:SS'),100,'Color for backgrounds or indicators','D','C',22,'Y','N','N','N','N','Y','Y','N','N','N','System Color',TO_TIMESTAMP('2014-03-21 20:34:58','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:35:20 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,0,200124,'98b2feb1-0a37-43a6-942a-56f67b9df925',200114,225,TO_TIMESTAMP('2014-03-21 20:35:20','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','Y','N','Y','N','Y','Translation','N',20,1,TO_TIMESTAMP('2014-03-21 20:35:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:35:22 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211028,202728,'a97955a7-1ce1-4400-8375-3b41baa06f4a',0,200124,2,TO_TIMESTAMP('2014-03-21 20:35:22','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:35:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:35:23 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211029,202729,'a67a7a69-e319-430f-bd5d-37a94999909c',0,200124,2,TO_TIMESTAMP('2014-03-21 20:35:22','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:35:22','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:35:23 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211037,202730,'263ff35f-697b-4c68-8726-af7e34471e4c',0,200124,5,TO_TIMESTAMP('2014-03-21 20:35:23','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:35:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:35:24 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211035,202731,'de4fb0b9-b99e-4a99-a242-6eadf1f4fc54',0,200124,2,TO_TIMESTAMP('2014-03-21 20:35:23','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',40,TO_TIMESTAMP('2014-03-21 20:35:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:35:24 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211036,202732,'270068e5-e504-4000-9a70-2fc88c550251',0,200124,2,TO_TIMESTAMP('2014-03-21 20:35:24','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',50,TO_TIMESTAMP('2014-03-21 20:35:24','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:35:24 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211038,202733,'e5b650e7-33d2-4e4d-b97d-0855fa3835f0',0,200124,2,TO_TIMESTAMP('2014-03-21 20:35:24','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','AD_Color_Trl_UU',60,TO_TIMESTAMP('2014-03-21 20:35:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:35:25 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211039,202734,'e09d3c7a-e9bb-438f-b8e6-c2758b0d8406',0,200124,2,TO_TIMESTAMP('2014-03-21 20:35:24','YYYY-MM-DD HH24:MI:SS'),100,'Color for backgrounds or indicators',22,'D','Y','Y','Y','N','N','N','N','N','System Color',70,TO_TIMESTAMP('2014-03-21 20:35:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:35:25 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211032,202735,'cac0d4a2-1f45-4370-b41f-2ff5b45ca1a2',0,200124,2,TO_TIMESTAMP('2014-03-21 20:35:25','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',80,TO_TIMESTAMP('2014-03-21 20:35:25','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:35:56 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202734
;

-- Mar 21, 2014 8:35:57 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:35:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202735
;

-- Mar 21, 2014 8:35:57 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:35:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202732
;

-- Mar 21, 2014 8:35:57 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:35:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202730
;

-- Mar 21, 2014 8:35:57 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:35:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202733
;

-- Mar 21, 2014 8:36:05 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:36:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202731
;

-- Mar 21, 2014 8:37:00 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:37:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6979
;

-- Mar 21, 2014 8:37:12 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200115,'c66a3093-b077-4c06-b30a-9cd803e999f2',238,'6',TO_TIMESTAMP('2014-03-21 20:37:11','YYYY-MM-DD HH24:MI:SS'),100,'Color used for printing and display','D','Y','Y','Y','N','N','N','N',55,'Print Color','N','L','AD_PrintColor_Trl',TO_TIMESTAMP('2014-03-21 20:37:11','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:37:12 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200163,'0886bcaa-e201-41c0-b52f-9c2c4eac6743',TO_TIMESTAMP('2014-03-21 20:37:12','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table AD_PrintColor_Trl',1,'Y','N','Y','Y','AD_PrintColor_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:37:12','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:37:16 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211040,'4dc1f59f-4245-422e-8e0d-be717a29ef4f',102,0,19,200115,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:37:16','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:37:16','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:17 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211041,'1e04923b-ef53-4f09-b8a6-95f32ca9f103',113,0,19,200115,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:37:17','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:37:17','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:17 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211042,'5e579f1b-88fa-4b07-9b02-260538d53a0f',245,0,16,200115,'Created',TO_TIMESTAMP('2014-03-21 20:37:17','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:37:17','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:18 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211043,'48003267-cb7b-48f3-85eb-15e3b88c52c6',246,0,18,110,200115,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:37:17','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:37:17','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:18 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211044,'06d38dca-6e5b-42d2-a323-f1b1fb068a9e',348,0,20,200115,'IsActive',TO_TIMESTAMP('2014-03-21 20:37:18','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:37:18','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:19 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211045,'25cd4d5c-6e14-4faa-9a32-4026c41576c2',607,0,16,200115,'Updated',TO_TIMESTAMP('2014-03-21 20:37:18','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:37:18','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:19 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211046,'4d60dc0f-72dd-4825-9dfa-b11fcfc1ff52',608,0,18,110,200115,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:37:19','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:37:19','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:19 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211047,'3ddee238-5654-40e3-a291-ab8760ed499c',109,0,18,106,200115,'AD_Language',TO_TIMESTAMP('2014-03-21 20:37:19','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:37:19','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:20 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211048,'8814e031-854b-4f0c-8a51-48ea8125929c',420,0,20,200115,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:37:19','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:37:19','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:20 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211049,'1857c418-3674-485f-86b8-d14f2e2372dc',469,0,10,200115,'Name',TO_TIMESTAMP('2014-03-21 20:37:20','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','Y','N','N','N','Y','Name',1,TO_TIMESTAMP('2014-03-21 20:37:20','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:37:21 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202679,'4c272d97-fd65-44f0-8cbd-5cc9e59cad36',0,'AD_PrintColor_Trl_UU',TO_TIMESTAMP('2014-03-21 20:37:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintColor_Trl_UU','AD_PrintColor_Trl_UU',TO_TIMESTAMP('2014-03-21 20:37:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:37:21 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211050,'51ee997a-9f8d-44e3-9fa7-687ed7589088',202679,0,10,200115,'AD_PrintColor_Trl_UU',TO_TIMESTAMP('2014-03-21 20:37:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintColor_Trl_UU',TO_TIMESTAMP('2014-03-21 20:37:21','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:23 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211051,'e569c5fe-0d14-461e-9e0d-5b2a7fc2ee86',1788,0,30,200115,'AD_PrintColor_ID',TO_TIMESTAMP('2014-03-21 20:37:21','YYYY-MM-DD HH24:MI:SS'),100,'Color used for printing and display','D','C',22,'Colors used for printing and display','Y','N','N','N','N','Y','Y','N','N','N','Print Color',TO_TIMESTAMP('2014-03-21 20:37:21','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:37:51 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,211051,0,200125,'0e4d0c6c-c476-4652-a102-2ed60189470c',200115,238,TO_TIMESTAMP('2014-03-21 20:37:51','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','Y','N','Y','N','Y','Translation','N',20,1,TO_TIMESTAMP('2014-03-21 20:37:51','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:37:53 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211040,202736,'a8f4e701-1a43-4095-b2df-ca76b0470d41',0,200125,2,TO_TIMESTAMP('2014-03-21 20:37:53','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:37:53','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:37:54 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211041,202737,'4fd46aba-50b3-4d1c-85de-a46e98cc8177',0,200125,2,TO_TIMESTAMP('2014-03-21 20:37:53','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:37:53','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:37:54 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211049,202738,'d37b5917-77c7-4071-a7b1-3c9441432bc0',0,200125,5,TO_TIMESTAMP('2014-03-21 20:37:54','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:37:54','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:37:55 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211047,202739,'9bbf6d10-1258-46b6-bd1f-9e0f418db996',0,200125,2,TO_TIMESTAMP('2014-03-21 20:37:54','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',40,TO_TIMESTAMP('2014-03-21 20:37:54','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:37:55 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211048,202740,'0635862c-e5ad-4e94-9f80-e48e409e88dc',0,200125,2,TO_TIMESTAMP('2014-03-21 20:37:55','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',50,TO_TIMESTAMP('2014-03-21 20:37:55','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:37:56 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211050,202741,'755f6733-a7f3-47c6-a4f8-d3c9423e2ffd',0,200125,2,TO_TIMESTAMP('2014-03-21 20:37:55','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','AD_PrintColor_Trl_UU',60,TO_TIMESTAMP('2014-03-21 20:37:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:37:57 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211051,202742,'e0395254-75b9-4f2a-b902-51c0332df9fa',0,200125,2,TO_TIMESTAMP('2014-03-21 20:37:56','YYYY-MM-DD HH24:MI:SS'),100,'Color used for printing and display',22,'D','Colors used for printing and display','Y','Y','Y','N','N','N','N','N','Print Color',70,TO_TIMESTAMP('2014-03-21 20:37:56','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:37:57 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211044,202743,'4e601d5c-7e71-4942-8fa3-57c9ef1be57a',0,200125,2,TO_TIMESTAMP('2014-03-21 20:37:57','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',80,TO_TIMESTAMP('2014-03-21 20:37:57','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:38:01 PM CET
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2014-03-21 20:38:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200125
;

-- Mar 21, 2014 8:38:29 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:38:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202742
;

-- Mar 21, 2014 8:38:29 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:38:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202743
;

-- Mar 21, 2014 8:38:29 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:38:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202740
;

-- Mar 21, 2014 8:38:29 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:38:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202738
;

-- Mar 21, 2014 8:38:29 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:38:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202741
;

-- Mar 21, 2014 8:38:37 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:38:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202739
;

-- Mar 21, 2014 8:38:56 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:38:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8769
;

-- Mar 21, 2014 8:39:06 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:39:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3466
;

-- Mar 21, 2014 8:39:13 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:39:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3465
;

-- Mar 21, 2014 8:39:37 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200116,'49c578dd-91ea-4b51-b094-dd75a39056b8',134,'2',TO_TIMESTAMP('2014-03-21 20:39:36','YYYY-MM-DD HH24:MI:SS'),100,'Business Activity','D','Y','Y','Y','N','N','N','N',100,'Activity Translation','N','L','C_Activity_Trl',TO_TIMESTAMP('2014-03-21 20:39:36','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:39:37 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200164,'7ae85e9c-baed-47b3-bec2-7f0e58226b2a',TO_TIMESTAMP('2014-03-21 20:39:37','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table C_Activity_Trl',1,'Y','N','Y','Y','C_Activity_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:39:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:39:41 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211052,'27395053-7d31-4a80-a914-d593c0dc9955',102,0,19,200116,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:39:40','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:39:40','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:39:41 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211053,'1f5f33a2-fab1-4df0-b1bd-b5f6a8eb4edb',113,0,19,200116,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:39:41','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:39:41','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:39:42 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211054,'b71a3033-af7a-49c4-b4d0-65b271bb3d70',245,0,16,200116,'Created',TO_TIMESTAMP('2014-03-21 20:39:41','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:39:41','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:39:42 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211055,'c509dc0d-707b-4f2f-a638-57fce26e3f00',246,0,18,110,200116,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:39:42','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:39:42','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:39:43 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211056,'d92a7e9e-88cf-449b-85ce-c880bffb977a',348,0,20,200116,'IsActive',TO_TIMESTAMP('2014-03-21 20:39:42','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:39:42','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:39:43 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211057,'484c84db-6591-43be-8dca-a97225c07ada',607,0,16,200116,'Updated',TO_TIMESTAMP('2014-03-21 20:39:43','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:39:43','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:39:43 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211058,'7fae3779-8168-4f27-82d2-558ae9486d22',608,0,18,110,200116,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:39:43','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:39:43','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:39:44 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211059,'ca8ec1c8-326a-4e36-975e-93184cf5fbba',109,0,18,106,200116,'AD_Language',TO_TIMESTAMP('2014-03-21 20:39:43','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:39:43','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:39:44 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211060,'a1957dca-e67d-4a3e-b7e6-23423b0668a6',420,0,20,200116,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:39:44','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:39:44','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:39:45 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211061,'ce3f94da-66ab-4be2-9e9a-b13570e30078',275,0,10,200116,'Description',TO_TIMESTAMP('2014-03-21 20:39:44','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record','D',255,'A description is limited to 255 characters.','Y','N','Y','Y','N','N','N','N','N','N','N','Y','N','N','N','Y','Description',TO_TIMESTAMP('2014-03-21 20:39:44','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:39:45 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211062,'7979c051-5a7f-42e9-97e6-9eb8dcf8d9b1',326,0,14,200116,'Help',TO_TIMESTAMP('2014-03-21 20:39:45','YYYY-MM-DD HH24:MI:SS'),100,'Comment or Hint','D',2000,'The Help field contains a hint, comment or help about the use of this item.','Y','N','Y','Y','N','N','N','N','N','N','N','N','N','N','N','Y','Comment/Help',0,TO_TIMESTAMP('2014-03-21 20:39:45','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:39:46 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211063,'77116f73-895d-42ad-981f-3c5542bdf9f1',469,0,10,200116,'Name',TO_TIMESTAMP('2014-03-21 20:39:45','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','Y','N','N','N','Y','Name',1,TO_TIMESTAMP('2014-03-21 20:39:45','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:39:46 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202680,'1db79546-c54e-4642-b48c-1507e5182da4',0,'C_Activity_Trl_UU',TO_TIMESTAMP('2014-03-21 20:39:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Activity_Trl_UU','C_Activity_Trl_UU',TO_TIMESTAMP('2014-03-21 20:39:46','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:39:47 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211064,'6bacfb68-472c-40b7-bb77-00a904f4fbfb',202680,0,10,200116,'C_Activity_Trl_UU',TO_TIMESTAMP('2014-03-21 20:39:46','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Activity_Trl_UU',TO_TIMESTAMP('2014-03-21 20:39:46','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:39:47 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211065,'ea9abc21-bb06-4b11-aa64-a7e365696556',1005,0,30,200116,'C_Activity_ID',TO_TIMESTAMP('2014-03-21 20:39:47','YYYY-MM-DD HH24:MI:SS'),100,'Business Activity','D','C',22,'Activities indicate tasks that are performed and used to utilize Activity based Costing','Y','N','N','N','N','Y','Y','N','N','N','Activity',TO_TIMESTAMP('2014-03-21 20:39:47','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:40:09 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,211065,0,200126,'3412b725-151b-46aa-8086-9977e875be97',200116,134,TO_TIMESTAMP('2014-03-21 20:40:08','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','Y','N','Y','N','Y','Translation','N',20,1,TO_TIMESTAMP('2014-03-21 20:40:08','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:40:11 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211052,202744,'0587ebf0-ab11-472d-8aea-a1eece4a8ffb',0,200126,2,TO_TIMESTAMP('2014-03-21 20:40:10','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:40:10','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:40:11 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211053,202745,'1191e6e3-b730-4154-bafb-da3bb67d1982',0,200126,2,TO_TIMESTAMP('2014-03-21 20:40:11','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:40:11','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:40:12 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211063,202746,'29d0a71d-ea95-48e3-8ecc-736585de6153',0,200126,5,TO_TIMESTAMP('2014-03-21 20:40:11','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:40:11','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:40:12 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211061,202747,'eb5490d5-5dee-42d8-ba4b-e4933567df8e',0,200126,5,TO_TIMESTAMP('2014-03-21 20:40:12','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',255,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',40,TO_TIMESTAMP('2014-03-21 20:40:12','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:40:13 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,NumLines,SeqNo,Updated,UpdatedBy) VALUES (0,211062,202748,'53cbd266-e4f5-4e1b-8892-28f7b027d679',0,200126,5,TO_TIMESTAMP('2014-03-21 20:40:12','YYYY-MM-DD HH24:MI:SS'),100,'Comment or Hint',2000,'D','The Help field contains a hint, comment or help about the use of this item.','Y','Y','Y','N','N','N','N','N','Comment/Help',3,50,TO_TIMESTAMP('2014-03-21 20:40:12','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:40:13 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211059,202749,'dca7aeb5-b7b0-4997-b50f-b0c0b582ee1e',0,200126,2,TO_TIMESTAMP('2014-03-21 20:40:13','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',60,TO_TIMESTAMP('2014-03-21 20:40:13','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:40:13 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211060,202750,'29c99b05-2e7b-4778-afc9-40390c9bc351',0,200126,2,TO_TIMESTAMP('2014-03-21 20:40:13','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',70,TO_TIMESTAMP('2014-03-21 20:40:13','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:40:14 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211064,202751,'200c629a-8b50-4194-a9c2-01f99df0fd31',0,200126,2,TO_TIMESTAMP('2014-03-21 20:40:13','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','C_Activity_Trl_UU',80,TO_TIMESTAMP('2014-03-21 20:40:13','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:40:14 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211065,202752,'c3379b99-8ac2-4e4f-8151-c8a1eb095e2b',0,200126,2,TO_TIMESTAMP('2014-03-21 20:40:14','YYYY-MM-DD HH24:MI:SS'),100,'Business Activity',22,'D','Activities indicate tasks that are performed and used to utilize Activity based Costing','Y','Y','Y','N','N','N','N','N','Activity',90,TO_TIMESTAMP('2014-03-21 20:40:14','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:40:15 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211056,202753,'552e264b-ea9f-426d-a083-d58a8bd74730',0,200126,2,TO_TIMESTAMP('2014-03-21 20:40:14','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',100,TO_TIMESTAMP('2014-03-21 20:40:14','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:40:58 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:40:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202752
;

-- Mar 21, 2014 8:40:58 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:40:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202749
;

-- Mar 21, 2014 8:40:58 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:40:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202753
;

-- Mar 21, 2014 8:40:58 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:40:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202750
;

-- Mar 21, 2014 8:40:58 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:40:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202746
;

-- Mar 21, 2014 8:40:58 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2014-03-21 20:40:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202747
;

-- Mar 21, 2014 8:40:58 PM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2014-03-21 20:40:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202748
;

-- Mar 21, 2014 8:40:58 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:40:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202751
;

-- Mar 21, 2014 8:41:13 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:41:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202750
;

-- Mar 21, 2014 8:42:00 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:42:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2579
;

-- Mar 21, 2014 8:42:12 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:42:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2578
;

-- Mar 21, 2014 8:42:45 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200117,'15f1958f-d13e-4a71-8fdb-38d087c4f080',149,'3',TO_TIMESTAMP('2014-03-21 20:42:44','YYYY-MM-DD HH24:MI:SS'),100,'Marketing Campaign','D','Y','Y','Y','N','N','N','N',95,'Campaign translation','N','L','C_Campaign_Trl',TO_TIMESTAMP('2014-03-21 20:42:44','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:42:45 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200165,'6f42a5ad-44dc-4e73-a867-2c5f377b92d2',TO_TIMESTAMP('2014-03-21 20:42:45','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table C_Campaign_Trl',1,'Y','N','Y','Y','C_Campaign_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:42:45','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:43:21 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,0,200127,'6c2a0f70-81f5-41cf-8036-2b94e724f706',200117,149,TO_TIMESTAMP('2014-03-21 20:43:21','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','Y','N','Y','N','Y','Translation','N',30,1,TO_TIMESTAMP('2014-03-21 20:43:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:43:43 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211066,'a3d23966-9da5-45f3-91d4-5ae4aee81880',102,0,19,200117,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:43:43','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:43:43','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:44 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211067,'3c7ec255-0005-4699-8df6-48790863148b',113,0,19,200117,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:43:43','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:43:43','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:44 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211068,'f11c250a-ae13-4806-acda-1b0fdd25f091',245,0,16,200117,'Created',TO_TIMESTAMP('2014-03-21 20:43:44','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:43:44','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:45 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211069,'ef0c4c23-faa3-4361-8848-8fde44570a3b',246,0,18,110,200117,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:43:44','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:43:44','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:45 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211070,'9d42dd74-e7a4-40ce-87a6-85518cec419a',348,0,20,200117,'IsActive',TO_TIMESTAMP('2014-03-21 20:43:45','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:43:45','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:45 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211071,'ce8a0e17-1dde-4880-aec0-413acc29b1b6',607,0,16,200117,'Updated',TO_TIMESTAMP('2014-03-21 20:43:45','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:43:45','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:46 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211072,'0a69ce19-f574-4228-bdca-c9878c6a8d2d',608,0,18,110,200117,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:43:45','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:43:45','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:46 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211073,'d918e1c0-4f29-4fea-af0f-fc28d35fb8f4',109,0,18,106,200117,'AD_Language',TO_TIMESTAMP('2014-03-21 20:43:46','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:43:46','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:47 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211074,'6358acd0-a5c0-4112-9202-e1fb13efd979',420,0,20,200117,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:43:46','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:43:46','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:47 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211075,'e6449620-1184-4595-927d-dbc2e7683ddd',275,0,10,200117,'Description',TO_TIMESTAMP('2014-03-21 20:43:47','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record','D',255,'A description is limited to 255 characters.','Y','N','Y','Y','N','N','N','N','N','N','N','Y','N','N','N','Y','Description',TO_TIMESTAMP('2014-03-21 20:43:47','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:43:48 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211076,'376cbd9b-e2f9-4faf-9bd0-276353c10b49',469,0,10,200117,'Name',TO_TIMESTAMP('2014-03-21 20:43:47','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','Y','N','N','N','Y','Name',1,TO_TIMESTAMP('2014-03-21 20:43:47','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:43:48 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202681,'c69fdf31-4d43-497c-b23a-87f6a1950db3',0,'C_Campaign_Trl_UU',TO_TIMESTAMP('2014-03-21 20:43:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Campaign_Trl_UU','C_Campaign_Trl_UU',TO_TIMESTAMP('2014-03-21 20:43:48','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:43:49 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211077,'8ff3e454-abfc-47e2-b1d3-f65597ebe955',202681,0,10,200117,'C_Campaign_Trl_UU',TO_TIMESTAMP('2014-03-21 20:43:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Campaign_Trl_UU',TO_TIMESTAMP('2014-03-21 20:43:48','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:49 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211078,'32189847-321d-4839-b035-2bc5ca5868d9',550,0,30,200117,'C_Campaign_ID',TO_TIMESTAMP('2014-03-21 20:43:49','YYYY-MM-DD HH24:MI:SS'),100,'Marketing Campaign','D','C',22,'The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.','Y','N','N','N','N','Y','Y','N','N','N','Campaign',TO_TIMESTAMP('2014-03-21 20:43:49','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:43:59 PM CET
UPDATE AD_Tab SET AD_Column_ID=211078, IsInsertRecord='N',Updated=TO_TIMESTAMP('2014-03-21 20:43:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200127
;

-- Mar 21, 2014 8:44:07 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211066,202754,'9b2eae0a-02ce-492d-ae2e-50ad48af42a7',0,200127,2,TO_TIMESTAMP('2014-03-21 20:44:06','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:44:06','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:44:07 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211067,202755,'9d05d964-947f-4f01-b0c2-bca3224feda7',0,200127,2,TO_TIMESTAMP('2014-03-21 20:44:07','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:44:07','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:44:07 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211076,202756,'1a8dab89-bfa0-4a23-8a8a-f7347505c1fe',0,200127,5,TO_TIMESTAMP('2014-03-21 20:44:07','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:44:07','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:44:08 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211075,202757,'7349a817-80db-4268-b872-6f1e08bfe388',0,200127,5,TO_TIMESTAMP('2014-03-21 20:44:07','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',255,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',40,TO_TIMESTAMP('2014-03-21 20:44:07','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:44:08 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211073,202758,'5e84407f-0ceb-4e23-8e3a-26e558bb5bff',0,200127,2,TO_TIMESTAMP('2014-03-21 20:44:08','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',50,TO_TIMESTAMP('2014-03-21 20:44:08','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:44:09 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211074,202759,'cf7c5c73-5773-488b-9a2d-895789960c0d',0,200127,2,TO_TIMESTAMP('2014-03-21 20:44:08','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',60,TO_TIMESTAMP('2014-03-21 20:44:08','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:44:09 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211077,202760,'9999b70a-955f-4e03-8a96-7da8ef901050',0,200127,2,TO_TIMESTAMP('2014-03-21 20:44:09','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','C_Campaign_Trl_UU',70,TO_TIMESTAMP('2014-03-21 20:44:09','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:44:09 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211078,202761,'6ee38df3-a727-4b68-8eba-e13bd4243b5d',0,200127,2,TO_TIMESTAMP('2014-03-21 20:44:09','YYYY-MM-DD HH24:MI:SS'),100,'Marketing Campaign',22,'D','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.','Y','Y','Y','N','N','N','N','N','Campaign',80,TO_TIMESTAMP('2014-03-21 20:44:09','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:44:10 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211070,202762,'e5a03ed9-45f0-40db-9c06-535ebf885149',0,200127,2,TO_TIMESTAMP('2014-03-21 20:44:09','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',90,TO_TIMESTAMP('2014-03-21 20:44:09','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:44:38 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:44:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202761
;

-- Mar 21, 2014 8:44:38 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:44:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202758
;

-- Mar 21, 2014 8:44:38 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:44:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202762
;

-- Mar 21, 2014 8:44:38 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:44:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202759
;

-- Mar 21, 2014 8:44:38 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:44:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202756
;

-- Mar 21, 2014 8:44:38 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2014-03-21 20:44:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202757
;

-- Mar 21, 2014 8:44:38 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:44:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202760
;

-- Mar 21, 2014 8:44:48 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:44:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202758
;

-- Mar 21, 2014 8:45:56 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:45:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=864
;

-- Mar 21, 2014 8:46:09 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200118,'c0cadd6c-d7da-4aa8-84cb-783a0a8d4da5',122,'6',TO_TIMESTAMP('2014-03-21 20:46:08','YYYY-MM-DD HH24:MI:SS'),100,'Identifies a geographical Region','D','Y','Y','Y','N','N','N','N',60,'Region','N','L','C_Region_Trl',TO_TIMESTAMP('2014-03-21 20:46:08','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:46:09 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200166,'32492e46-5d03-487c-8542-f51476c9f9bc',TO_TIMESTAMP('2014-03-21 20:46:09','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table C_Region_Trl',1,'Y','N','Y','Y','C_Region_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:46:09','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:46:14 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211079,'e4ac0dad-5016-4739-b6c3-35de5642755c',102,0,19,200118,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:46:13','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:46:13','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:46:14 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211080,'aa0f7d7f-1ef0-483a-a89c-7ba32ad2b3a8',113,0,19,200118,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:46:14','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:46:14','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:46:15 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211081,'61082201-aba1-43ae-8859-54669eb9dd48',245,0,16,200118,'Created',TO_TIMESTAMP('2014-03-21 20:46:14','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:46:14','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:46:15 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211082,'99d2a8c5-d69b-45ae-8dc2-55b0051f6e5c',246,0,18,110,200118,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:46:15','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:46:15','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:46:16 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211083,'db60c9a3-80e0-4b42-a388-25232ac31b38',348,0,20,200118,'IsActive',TO_TIMESTAMP('2014-03-21 20:46:15','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:46:15','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:46:16 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211084,'9cd6aa8a-4fd1-4951-8bab-84c33bbaee02',607,0,16,200118,'Updated',TO_TIMESTAMP('2014-03-21 20:46:16','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:46:16','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:46:16 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211085,'acad6415-c0ce-407b-b07a-aaf189693ffa',608,0,18,110,200118,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:46:16','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:46:16','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:46:17 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211086,'f0a7ce0c-3376-47c3-bc21-0c86249d7b3d',109,0,18,106,200118,'AD_Language',TO_TIMESTAMP('2014-03-21 20:46:16','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:46:16','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:46:17 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211087,'ab4f6053-c98b-41a3-8889-f74597ad71fa',420,0,20,200118,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:46:17','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:46:17','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:46:18 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211088,'3e7c396d-2e11-4757-a7bf-4d499c558c1e',469,0,10,200118,'Name',TO_TIMESTAMP('2014-03-21 20:46:17','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','Y','N','N','N','Y','Name',1,TO_TIMESTAMP('2014-03-21 20:46:17','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:46:18 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202682,'c007566d-ddd5-4cc9-9fb2-5362687a550e',0,'C_Region_Trl_UU',TO_TIMESTAMP('2014-03-21 20:46:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Region_Trl_UU','C_Region_Trl_UU',TO_TIMESTAMP('2014-03-21 20:46:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:46:19 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211089,'d3d89d8e-b451-4c4c-9486-c1a23e40d966',202682,0,10,200118,'C_Region_Trl_UU',TO_TIMESTAMP('2014-03-21 20:46:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Region_Trl_UU',TO_TIMESTAMP('2014-03-21 20:46:18','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:46:19 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211090,'0ef5cc19-b452-4d20-8071-2c6654642244',209,0,30,200118,'C_Region_ID',TO_TIMESTAMP('2014-03-21 20:46:19','YYYY-MM-DD HH24:MI:SS'),100,'Identifies a geographical Region','D','C',22,'The Region identifies a unique Region for this Country.','Y','N','N','N','N','Y','Y','N','N','N','Region',TO_TIMESTAMP('2014-03-21 20:46:19','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:47:18 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,211090,0,200128,'ea1090a1-7e04-49e8-b165-b93f1f32b323',200118,122,TO_TIMESTAMP('2014-03-21 20:47:18','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','N','N','Y','N','Y','Translation','N',38,2,TO_TIMESTAMP('2014-03-21 20:47:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:47:32 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211079,202763,'78710e2a-bda6-4c13-bd1d-2d396413904f',0,200128,2,TO_TIMESTAMP('2014-03-21 20:47:32','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:47:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:47:32 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211080,202764,'b7d59a99-775e-42b5-9876-f3ff012165d7',0,200128,2,TO_TIMESTAMP('2014-03-21 20:47:32','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:47:32','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:47:33 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211088,202765,'63a69be8-9064-44a8-a5f4-0844acb09b5a',0,200128,5,TO_TIMESTAMP('2014-03-21 20:47:32','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:47:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:47:33 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211086,202766,'5c02d5b8-121e-4d3e-a146-aeeb787758f4',0,200128,2,TO_TIMESTAMP('2014-03-21 20:47:33','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',40,TO_TIMESTAMP('2014-03-21 20:47:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:47:34 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211087,202767,'23a56945-3c93-4d33-b86e-2eee91abfa4e',0,200128,2,TO_TIMESTAMP('2014-03-21 20:47:33','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',50,TO_TIMESTAMP('2014-03-21 20:47:33','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:47:34 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211089,202768,'37734d92-9b52-47b8-b0b3-ececda089f5f',0,200128,2,TO_TIMESTAMP('2014-03-21 20:47:34','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','C_Region_Trl_UU',60,TO_TIMESTAMP('2014-03-21 20:47:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:47:35 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211090,202769,'ee49e7e4-a2d8-48ff-a00e-593070da50df',0,200128,2,TO_TIMESTAMP('2014-03-21 20:47:34','YYYY-MM-DD HH24:MI:SS'),100,'Identifies a geographical Region',22,'D','The Region identifies a unique Region for this Country.','Y','Y','Y','N','N','N','N','N','Region',70,TO_TIMESTAMP('2014-03-21 20:47:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:47:35 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211083,202770,'a7a9d129-4016-46ca-a1d7-f35feac51b45',0,200128,2,TO_TIMESTAMP('2014-03-21 20:47:35','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',80,TO_TIMESTAMP('2014-03-21 20:47:35','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:47:58 PM CET
UPDATE AD_Tab SET SeqNo=33,Updated=TO_TIMESTAMP('2014-03-21 20:47:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200128
;

-- Mar 21, 2014 8:48:22 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:48:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202769
;

-- Mar 21, 2014 8:48:22 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:48:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202770
;

-- Mar 21, 2014 8:48:22 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:48:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202767
;

-- Mar 21, 2014 8:48:22 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:48:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202765
;

-- Mar 21, 2014 8:48:22 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:48:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202768
;

-- Mar 21, 2014 8:48:33 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:48:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202766
;

-- Mar 21, 2014 8:49:32 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1832
;

-- Mar 21, 2014 8:49:39 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:49:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1831
;

-- Mar 21, 2014 8:50:25 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200119,'8c770851-3a89-4ac9-b550-c7d2b41dd146',152,'3',TO_TIMESTAMP('2014-03-21 20:50:25','YYYY-MM-DD HH24:MI:SS'),100,'Sales coverage region','D','Y','Y','Y','N','N','N','N',70,'Sales Region translatin','N','L','C_SalesRegion_Trl',TO_TIMESTAMP('2014-03-21 20:50:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:50:25 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200167,'7c76256a-6d18-41ce-b112-b278236b6900',TO_TIMESTAMP('2014-03-21 20:50:25','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table C_SalesRegion_Trl',1,'Y','N','Y','Y','C_SalesRegion_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:50:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:50:30 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211091,'38cf016c-e08e-4ab4-8869-40913bc799b9',102,0,19,200119,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:50:29','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:50:29','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:50:30 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211092,'7644de64-7e6e-4676-ab40-9eaa5ffac996',113,0,19,200119,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:50:30','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:50:30','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:50:30 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211093,'a5660fbe-3a15-4646-90c7-1cdb60bfc43e',245,0,16,200119,'Created',TO_TIMESTAMP('2014-03-21 20:50:30','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:50:30','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:50:31 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211094,'800ca556-1550-42cf-bb47-b582097e97ee',246,0,18,110,200119,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:50:30','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:50:30','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:50:31 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211095,'75ceaacf-9421-4a2e-825b-bc65f5d50a81',348,0,20,200119,'IsActive',TO_TIMESTAMP('2014-03-21 20:50:31','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:50:31','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:50:32 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211096,'09ffe7e6-d52e-4894-8a7c-5f34c0567250',607,0,16,200119,'Updated',TO_TIMESTAMP('2014-03-21 20:50:31','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:50:31','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:50:32 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211097,'4dab5d23-5784-4003-b1e2-07baf0789bab',608,0,18,110,200119,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:50:32','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:50:32','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:50:32 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211098,'7dbadfbd-96e5-49f7-a725-e506cbe0d0d4',109,0,18,106,200119,'AD_Language',TO_TIMESTAMP('2014-03-21 20:50:32','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:50:32','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:50:33 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211099,'0e3374b5-a4c7-427f-bffa-9e6b1d5e12bf',420,0,20,200119,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:50:33','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:50:33','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:50:33 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211100,'5405438a-9524-4311-8a29-ffbae7bc4d27',275,0,10,200119,'Description',TO_TIMESTAMP('2014-03-21 20:50:33','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record','D',255,'A description is limited to 255 characters.','Y','N','Y','Y','N','N','N','N','N','N','N','Y','N','N','N','Y','Description',TO_TIMESTAMP('2014-03-21 20:50:33','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:50:34 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211101,'4eb75491-67b0-4809-a6d8-90049d10c409',469,0,10,200119,'Name',TO_TIMESTAMP('2014-03-21 20:50:33','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','Y','N','N','N','Y','Name',1,TO_TIMESTAMP('2014-03-21 20:50:33','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:50:34 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202683,'7415a530-b8ab-4282-a307-aba5a3bc946b',0,'C_SalesRegion_Trl_UU',TO_TIMESTAMP('2014-03-21 20:50:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_SalesRegion_Trl_UU','C_SalesRegion_Trl_UU',TO_TIMESTAMP('2014-03-21 20:50:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:50:35 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211102,'9c18a02e-c888-4634-805c-7656f451c8b8',202683,0,10,200119,'C_SalesRegion_Trl_UU',TO_TIMESTAMP('2014-03-21 20:50:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_SalesRegion_Trl_UU',TO_TIMESTAMP('2014-03-21 20:50:34','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:50:35 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211103,'f7262c59-7c63-4c72-ad12-be046253d62f',210,0,30,200119,'C_SalesRegion_ID',TO_TIMESTAMP('2014-03-21 20:50:35','YYYY-MM-DD HH24:MI:SS'),100,'Sales coverage region','D','C',22,'The Sales Region indicates a specific area of sales coverage.','Y','N','N','N','N','Y','Y','N','N','N','Sales Region',TO_TIMESTAMP('2014-03-21 20:50:35','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:51:18 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,211103,0,200129,'e54f0037-c27f-4197-9080-a0182ab0e6bb',200119,152,TO_TIMESTAMP('2014-03-21 20:51:17','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','N','N','Y','N','Y','Translation','N',20,1,TO_TIMESTAMP('2014-03-21 20:51:17','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:51:20 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211091,202771,'5d6043e5-392b-48e0-8796-26941c78ae09',0,200129,2,TO_TIMESTAMP('2014-03-21 20:51:20','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:51:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:51:20 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211092,202772,'86f52ff2-54a6-4e5f-908c-97943e544a18',0,200129,2,TO_TIMESTAMP('2014-03-21 20:51:20','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:51:20','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:51:21 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211101,202773,'76966473-087b-4fac-acde-1db84c4e5335',0,200129,5,TO_TIMESTAMP('2014-03-21 20:51:20','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:51:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:51:21 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211100,202774,'53fc066d-584c-466e-aacf-c3a348c76903',0,200129,5,TO_TIMESTAMP('2014-03-21 20:51:21','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',255,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',40,TO_TIMESTAMP('2014-03-21 20:51:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:51:22 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211098,202775,'16f07669-ed09-436e-8e8a-d85e58162968',0,200129,2,TO_TIMESTAMP('2014-03-21 20:51:21','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',50,TO_TIMESTAMP('2014-03-21 20:51:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:51:22 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211099,202776,'3d025f15-f703-4bd0-9c2f-ee692333d09a',0,200129,2,TO_TIMESTAMP('2014-03-21 20:51:22','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',60,TO_TIMESTAMP('2014-03-21 20:51:22','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:51:23 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211102,202777,'6af2b311-6dc3-45a5-ac22-4dbc0ca3f630',0,200129,2,TO_TIMESTAMP('2014-03-21 20:51:22','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','C_SalesRegion_Trl_UU',70,TO_TIMESTAMP('2014-03-21 20:51:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:51:23 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211103,202778,'5ea32c40-c730-435c-8451-2c8064336c93',0,200129,2,TO_TIMESTAMP('2014-03-21 20:51:23','YYYY-MM-DD HH24:MI:SS'),100,'Sales coverage region',22,'D','The Sales Region indicates a specific area of sales coverage.','Y','Y','Y','N','N','N','N','N','Sales Region',80,TO_TIMESTAMP('2014-03-21 20:51:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:51:23 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211095,202779,'5047d1df-a9d6-4275-b44d-6d2c7ec17235',0,200129,2,TO_TIMESTAMP('2014-03-21 20:51:23','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',90,TO_TIMESTAMP('2014-03-21 20:51:23','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:51:52 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202778
;

-- Mar 21, 2014 8:51:52 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202775
;

-- Mar 21, 2014 8:51:52 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202779
;

-- Mar 21, 2014 8:51:52 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202776
;

-- Mar 21, 2014 8:51:52 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202773
;

-- Mar 21, 2014 8:51:52 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2014-03-21 20:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202774
;

-- Mar 21, 2014 8:51:52 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202777
;

-- Mar 21, 2014 8:52:03 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:52:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202776
;

-- Mar 21, 2014 8:52:28 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:52:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2109
;

-- Mar 21, 2014 8:52:39 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:52:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2108
;

-- Mar 21, 2014 8:52:57 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200120,'c6ac1af5-6080-404e-808b-3fda92f60bfe',146,'3',TO_TIMESTAMP('2014-03-21 20:52:57','YYYY-MM-DD HH24:MI:SS'),100,'Unique identifier of a Price List','D','Y','Y','Y','N','N','N','N',60,'Price List','N','L','M_PriceList_Trl',TO_TIMESTAMP('2014-03-21 20:52:57','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:52:58 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200168,'f8432e6c-1d03-41b9-85be-22811e7650a0',TO_TIMESTAMP('2014-03-21 20:52:57','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table M_PriceList_Trl',1,'Y','N','Y','Y','M_PriceList_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:52:57','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:53:04 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211104,'e2a4c82a-9b6d-4fd6-96fb-95984eea11c7',102,0,19,200120,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:53:03','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:53:03','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:04 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211105,'61e0f3f6-4136-4c45-9a16-4f3379cc5080',113,0,19,200120,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:53:04','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:53:04','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:05 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211106,'dbf94c28-659e-4549-8110-c1a7b7ae04e9',245,0,16,200120,'Created',TO_TIMESTAMP('2014-03-21 20:53:04','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:53:04','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:05 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211107,'430c48b5-8197-4e3f-99fa-70adbfc81133',246,0,18,110,200120,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:53:05','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:53:05','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:06 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211108,'e8051022-4bd0-4ab6-a7d8-e361e6ed603f',348,0,20,200120,'IsActive',TO_TIMESTAMP('2014-03-21 20:53:05','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:53:05','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:06 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211109,'7bf165d7-8700-47aa-9358-20233c2aa7f9',607,0,16,200120,'Updated',TO_TIMESTAMP('2014-03-21 20:53:06','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:53:06','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:06 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211110,'15d2ca47-50fe-482d-85e6-17209d90dbc0',608,0,18,110,200120,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:53:06','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:53:06','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:07 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211111,'2812c40a-4ef4-49de-9d4e-596d8848db39',109,0,18,106,200120,'AD_Language',TO_TIMESTAMP('2014-03-21 20:53:06','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:53:06','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:07 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211112,'5c8ef673-d80a-4e56-9a4a-b6153e9857fb',420,0,20,200120,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:53:07','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:53:07','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:08 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211113,'9e3ebf0e-0390-44c6-be6c-896ef356c448',275,0,10,200120,'Description',TO_TIMESTAMP('2014-03-21 20:53:07','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record','D',255,'A description is limited to 255 characters.','Y','N','Y','Y','N','N','N','N','N','N','N','Y','N','N','N','Y','Description',TO_TIMESTAMP('2014-03-21 20:53:07','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:53:08 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211114,'9a1130e4-59fa-45ef-ac87-6c3ea3e6385a',469,0,10,200120,'Name',TO_TIMESTAMP('2014-03-21 20:53:08','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','Y','N','N','N','Y','Name',1,TO_TIMESTAMP('2014-03-21 20:53:08','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 21, 2014 8:53:09 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202684,'79f309c9-8304-47b7-9c40-996916c17e0b',0,'M_PriceList_Trl_UU',TO_TIMESTAMP('2014-03-21 20:53:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PriceList_Trl_UU','M_PriceList_Trl_UU',TO_TIMESTAMP('2014-03-21 20:53:08','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:53:09 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211115,'9279f159-bf53-4611-8bfe-d461d2eb4cdb',202684,0,10,200120,'M_PriceList_Trl_UU',TO_TIMESTAMP('2014-03-21 20:53:09','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PriceList_Trl_UU',TO_TIMESTAMP('2014-03-21 20:53:09','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:10 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211116,'b6b66043-4529-4c88-b9ca-4cc2f8cb323e',449,0,30,200120,'M_PriceList_ID',TO_TIMESTAMP('2014-03-21 20:53:09','YYYY-MM-DD HH24:MI:SS'),100,'Unique identifier of a Price List','D','C',22,'Price Lists are used to determine the pricing, margin and cost of items purchased or sold.','Y','N','N','N','N','Y','Y','N','N','N','Price List',TO_TIMESTAMP('2014-03-21 20:53:09','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:53:52 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,0,200130,'c735747e-6b24-401d-9c70-f3a23036391a',200120,146,TO_TIMESTAMP('2014-03-21 20:53:52','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','N','N','Y','N','Y','Translation','N',50,1,TO_TIMESTAMP('2014-03-21 20:53:52','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:53:54 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211104,202780,'384c017b-ada2-4b16-b1ec-e6ceab24970f',0,200130,2,TO_TIMESTAMP('2014-03-21 20:53:54','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:53:54','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:53:55 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211105,202781,'dd33427c-5dce-438d-9235-9fc61fc5114e',0,200130,2,TO_TIMESTAMP('2014-03-21 20:53:54','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:53:54','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:53:55 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211114,202782,'fe36c15c-874e-4d2f-8b89-232bf27cab06',0,200130,5,TO_TIMESTAMP('2014-03-21 20:53:55','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:53:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:53:55 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211113,202783,'1bb29acf-37e9-4437-ab75-b00d7dcee37e',0,200130,5,TO_TIMESTAMP('2014-03-21 20:53:55','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',255,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',40,TO_TIMESTAMP('2014-03-21 20:53:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:53:56 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211111,202784,'9031de78-4132-4ce3-8c31-0421cb2f5fac',0,200130,2,TO_TIMESTAMP('2014-03-21 20:53:55','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',50,TO_TIMESTAMP('2014-03-21 20:53:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:53:56 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211112,202785,'65ee50ae-97d5-4bbf-94bb-a83ba41af576',0,200130,2,TO_TIMESTAMP('2014-03-21 20:53:56','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',60,TO_TIMESTAMP('2014-03-21 20:53:56','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:53:57 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211115,202786,'4a6042b3-e37b-4e11-90e1-7b984462a063',0,200130,2,TO_TIMESTAMP('2014-03-21 20:53:56','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','M_PriceList_Trl_UU',70,TO_TIMESTAMP('2014-03-21 20:53:56','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:53:57 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211116,202787,'18ce0ab4-8d2d-4c6a-96f3-1697c79e9717',0,200130,2,TO_TIMESTAMP('2014-03-21 20:53:57','YYYY-MM-DD HH24:MI:SS'),100,'Unique identifier of a Price List',22,'D','Price Lists are used to determine the pricing, margin and cost of items purchased or sold.','Y','Y','Y','N','N','N','N','N','Price List',80,TO_TIMESTAMP('2014-03-21 20:53:57','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:53:57 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211108,202788,'7093ef13-fa92-4fb8-b0ac-dafa1913e784',0,200130,2,TO_TIMESTAMP('2014-03-21 20:53:57','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',90,TO_TIMESTAMP('2014-03-21 20:53:57','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:54:22 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:54:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202787
;

-- Mar 21, 2014 8:54:22 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:54:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202784
;

-- Mar 21, 2014 8:54:22 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:54:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202788
;

-- Mar 21, 2014 8:54:22 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:54:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202785
;

-- Mar 21, 2014 8:54:22 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:54:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202782
;

-- Mar 21, 2014 8:54:22 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2014-03-21 20:54:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202783
;

-- Mar 21, 2014 8:54:22 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:54:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202786
;

-- Mar 21, 2014 8:54:50 PM CET
UPDATE AD_Tab SET AD_Column_ID=211116,Updated=TO_TIMESTAMP('2014-03-21 20:54:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200130
;

-- Mar 21, 2014 8:55:15 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:55:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2995
;

-- Mar 21, 2014 8:55:29 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200121,'795f7e48-1cc0-4c13-9c13-a6d7d70c7a4d',146,'3',TO_TIMESTAMP('2014-03-21 20:55:28','YYYY-MM-DD HH24:MI:SS'),100,'Identifies a unique instance of a Price List','D','Y','Y','Y','N','N','N','N',95,'Price List Version translation','N','L','M_PriceList_Version_Trl',TO_TIMESTAMP('2014-03-21 20:55:28','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:55:29 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200169,'84870477-b31d-4785-9ce8-f930818746b5',TO_TIMESTAMP('2014-03-21 20:55:29','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table M_PriceList_Version_Trl',1,'Y','N','Y','Y','M_PriceList_Version_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:55:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:55:33 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211117,'4fd0e3af-fd10-484c-aebe-851a44a3a3f2',102,0,19,200121,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:55:32','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:55:32','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:55:33 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211118,'7e034ab6-2854-4912-a149-fde740114bf1',113,0,19,200121,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:55:33','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:55:33','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:55:34 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211119,'97865619-4de1-46a9-b96d-dc78babe3a12',245,0,16,200121,'Created',TO_TIMESTAMP('2014-03-21 20:55:33','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:55:33','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:55:34 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211120,'7f0efdc8-d44d-46c3-961f-a5c85c8ffe81',246,0,18,110,200121,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:55:34','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:55:34','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:55:34 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211121,'60e4f624-0010-48ea-8839-aa51250a4536',348,0,20,200121,'IsActive',TO_TIMESTAMP('2014-03-21 20:55:34','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:55:34','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:55:35 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211122,'dde88a75-67b2-4bcd-b6d4-dc20e0c5ce06',607,0,16,200121,'Updated',TO_TIMESTAMP('2014-03-21 20:55:34','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:55:34','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:55:35 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211123,'7051e69c-20d2-487b-9964-24e0753e104b',608,0,18,110,200121,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:55:35','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:55:35','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:55:36 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211124,'bfefa419-1d82-4b78-959b-ff3760a276a1',109,0,18,106,200121,'AD_Language',TO_TIMESTAMP('2014-03-21 20:55:35','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:55:35','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:55:36 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211125,'2f9f26ea-b7eb-4bcd-af34-cc61042b96e2',420,0,20,200121,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:55:36','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:55:36','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:55:37 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211126,'446954bb-8ba2-4077-8a71-1849dc15c9ad',469,0,10,200121,'Name',TO_TIMESTAMP('2014-03-21 20:55:36','YYYY-MM-DD HH24:MI:SS'),100,'@#Date@','Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','Y','N','N','N','Y','Name',1,TO_TIMESTAMP('2014-03-21 20:55:36','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 21, 2014 8:55:37 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202685,'d474fec8-7435-446b-babd-85bf079666d6',0,'M_PriceList_Version_Trl_UU',TO_TIMESTAMP('2014-03-21 20:55:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PriceList_Version_Trl_UU','M_PriceList_Version_Trl_UU',TO_TIMESTAMP('2014-03-21 20:55:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:55:37 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211127,'334dcc53-a78e-490c-94af-05f2276d5f24',202685,0,10,200121,'M_PriceList_Version_Trl_UU',TO_TIMESTAMP('2014-03-21 20:55:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PriceList_Version_Trl_UU',TO_TIMESTAMP('2014-03-21 20:55:37','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:55:38 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211128,'1fd7a69f-2656-47da-85d6-a8f48ce2cf6a',450,0,30,200121,'M_PriceList_Version_ID',TO_TIMESTAMP('2014-03-21 20:55:37','YYYY-MM-DD HH24:MI:SS'),100,'Identifies a unique instance of a Price List','D','C',22,'Each Price List can have multiple versions.  The most common use is to indicate the dates that a Price List is valid for.','Y','N','N','N','N','Y','Y','N','N','N','Price List Version',TO_TIMESTAMP('2014-03-21 20:55:37','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:56:06 PM CET
UPDATE AD_Tab SET SeqNo=60,Updated=TO_TIMESTAMP('2014-03-21 20:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200130
;

-- Mar 21, 2014 8:56:35 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,211128,0,200131,'93afc34d-b69d-4cdb-b9f0-a2761ed7437d',200121,146,TO_TIMESTAMP('2014-03-21 20:56:35','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','N','N','Y','N','Y','Translation','N',50,2,TO_TIMESTAMP('2014-03-21 20:56:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:56:37 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211117,202789,'b65b7688-d590-483a-9f70-9fa23068de80',0,200131,2,TO_TIMESTAMP('2014-03-21 20:56:37','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:56:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:56:38 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211118,202790,'85e1fa56-0f87-4c55-a6b5-6e86a1fd4200',0,200131,2,TO_TIMESTAMP('2014-03-21 20:56:37','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:56:37','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:56:38 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211126,202791,'543541b7-f7be-4dab-bffd-6c44129fc500',0,200131,5,TO_TIMESTAMP('2014-03-21 20:56:38','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:56:38','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:56:39 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211124,202792,'1a6f3a44-c05b-4df4-aa74-5d9d79d6e7f7',0,200131,2,TO_TIMESTAMP('2014-03-21 20:56:38','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',40,TO_TIMESTAMP('2014-03-21 20:56:38','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:56:39 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211125,202793,'7f659e20-b121-4a9e-a9a2-1fc97c86f667',0,200131,2,TO_TIMESTAMP('2014-03-21 20:56:39','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',50,TO_TIMESTAMP('2014-03-21 20:56:39','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:56:40 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211127,202794,'0655e62b-4749-4401-94a6-3f534dbab92e',0,200131,2,TO_TIMESTAMP('2014-03-21 20:56:39','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','M_PriceList_Version_Trl_UU',60,TO_TIMESTAMP('2014-03-21 20:56:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:56:40 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211128,202795,'e92c4147-4c61-48b3-927a-3c1510be51b4',0,200131,2,TO_TIMESTAMP('2014-03-21 20:56:40','YYYY-MM-DD HH24:MI:SS'),100,'Identifies a unique instance of a Price List',22,'D','Each Price List can have multiple versions.  The most common use is to indicate the dates that a Price List is valid for.','Y','Y','Y','N','N','N','N','N','Price List Version',70,TO_TIMESTAMP('2014-03-21 20:56:40','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:56:40 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211121,202796,'396f0b3c-fa6a-46d7-b88c-0e647e2465e8',0,200131,2,TO_TIMESTAMP('2014-03-21 20:56:40','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',80,TO_TIMESTAMP('2014-03-21 20:56:40','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:57:04 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:57:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202795
;

-- Mar 21, 2014 8:57:04 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:57:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202796
;

-- Mar 21, 2014 8:57:04 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:57:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202793
;

-- Mar 21, 2014 8:57:04 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:57:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202791
;

-- Mar 21, 2014 8:57:04 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:57:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202794
;

-- Mar 21, 2014 8:57:12 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:57:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202792
;

-- Mar 21, 2014 8:57:20 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:57:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202784
;

-- Mar 21, 2014 8:57:42 PM CET
UPDATE AD_Column SET IsToolbarButton='N', IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:57:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59697
;

-- Mar 21, 2014 8:57:53 PM CET
UPDATE AD_Column SET IsToolbarButton='N', IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:57:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59696
;

-- Mar 21, 2014 8:58:07 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,CopyColumnsFromTable,Created,CreatedBy,Description,EntityType,Help,ImportTable,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200122,'2034b77d-71d5-45d6-8c1e-01d634495dbf',53124,'4','N',TO_TIMESTAMP('2014-03-21 20:58:06','YYYY-MM-DD HH24:MI:SS'),100,'Chart definition','D','Charts are for the graphical display of information','N','Y','Y','N','N','N','N','N',0,'Chart Translation','N','L','AD_Chart_Trl',TO_TIMESTAMP('2014-03-21 20:58:06','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:58:07 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200170,'8ff51e44-54e4-4053-87e8-fdebea160d27',TO_TIMESTAMP('2014-03-21 20:58:07','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table AD_Chart_Trl',1,'Y','N','Y','Y','AD_Chart_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 20:58:07','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:58:13 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211129,'9d715e44-c159-4a6e-9f57-7eb60665c78a',102,0,19,200122,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 20:58:12','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 20:58:12','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:13 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211130,'b4b5e905-d5fe-4435-94a5-ab518acbe7d8',113,0,19,200122,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 20:58:13','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 20:58:13','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:13 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211131,'7c17f255-27ae-4c23-8633-3b3a0b49c3dd',245,0,16,200122,'Created',TO_TIMESTAMP('2014-03-21 20:58:13','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 20:58:13','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:14 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211132,'9b491e98-50ce-405c-b6ae-96787a6cfddd',246,0,18,110,200122,'CreatedBy',TO_TIMESTAMP('2014-03-21 20:58:13','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 20:58:13','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:14 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211133,'0d2f201a-6688-4320-944a-7864a35b2b31',348,0,20,200122,'IsActive',TO_TIMESTAMP('2014-03-21 20:58:14','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 20:58:14','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:15 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211134,'7c54db22-a06c-4377-a5a4-1f4b10292d58',607,0,16,200122,'Updated',TO_TIMESTAMP('2014-03-21 20:58:14','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 20:58:14','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:15 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211135,'6cc63758-b439-4a3d-badd-a6c7b5c48f7e',608,0,18,110,200122,'UpdatedBy',TO_TIMESTAMP('2014-03-21 20:58:15','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 20:58:15','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:15 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211136,'646868f2-e2d0-4f69-82e4-25cb82d01a3e',109,0,18,106,200122,'AD_Language',TO_TIMESTAMP('2014-03-21 20:58:15','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 20:58:15','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:16 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211137,'3dd8b5e1-cc2f-4df8-9fdf-7699f17a3b50',420,0,20,200122,'IsTranslated',TO_TIMESTAMP('2014-03-21 20:58:15','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 20:58:15','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:16 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211138,'768760d2-da80-44d6-915b-81c4c52f3692',275,0,10,200122,'Description',TO_TIMESTAMP('2014-03-21 20:58:16','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record','D',255,'A description is limited to 255 characters.','Y','N','Y','Y','N','N','N','N','N','N','N','N','N','N','N','Y','Description',0,TO_TIMESTAMP('2014-03-21 20:58:16','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 21, 2014 8:58:17 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211139,'e4716ef2-20f9-46e4-87df-bbb01caaecad',469,0,10,200122,'Name',TO_TIMESTAMP('2014-03-21 20:58:16','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','N','N','N','N','Y','Name',0,TO_TIMESTAMP('2014-03-21 20:58:16','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 21, 2014 8:58:17 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202686,'a7dd070c-0098-450b-a6c6-45c4aaf9c551',0,'AD_Chart_Trl_UU',TO_TIMESTAMP('2014-03-21 20:58:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Chart_Trl_UU','AD_Chart_Trl_UU',TO_TIMESTAMP('2014-03-21 20:58:17','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:58:18 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211140,'a540c170-ccdd-4843-837c-e9dd58d811eb',202686,0,10,200122,'AD_Chart_Trl_UU',TO_TIMESTAMP('2014-03-21 20:58:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Chart_Trl_UU',TO_TIMESTAMP('2014-03-21 20:58:17','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:18 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FKConstraintType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211141,'4989a7af-31e0-4bc9-83e6-ac3e370f39f4',54268,0,30,200122,'AD_Chart_ID',TO_TIMESTAMP('2014-03-21 20:58:18','YYYY-MM-DD HH24:MI:SS'),100,'D','C',22,'Y','N','N','N','N','Y','Y','N','N','N','Chart',TO_TIMESTAMP('2014-03-21 20:58:18','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 8:58:44 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,211141,0,200132,'a4808408-ab7d-43b8-aac5-87ccae3bdab3',200122,53124,TO_TIMESTAMP('2014-03-21 20:58:43','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','N','N','Y','N','Y','Translation','N',30,1,TO_TIMESTAMP('2014-03-21 20:58:43','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:58:46 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211129,202797,'1c7c6aaf-8b69-4b84-8b60-d1026eac8bf1',0,200132,2,TO_TIMESTAMP('2014-03-21 20:58:46','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 20:58:46','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:58:46 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211130,202798,'9d1808c8-d3bc-4a81-805e-768afa60a461',0,200132,2,TO_TIMESTAMP('2014-03-21 20:58:46','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 20:58:46','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 8:58:47 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211139,202799,'9f13ee91-6e32-4ba1-9e8a-ac916078cef0',0,200132,5,TO_TIMESTAMP('2014-03-21 20:58:46','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-21 20:58:46','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:58:47 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211138,202800,'f84ac901-42b1-46d6-a716-bf69341e324e',0,200132,5,TO_TIMESTAMP('2014-03-21 20:58:47','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',255,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',40,TO_TIMESTAMP('2014-03-21 20:58:47','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:58:48 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211136,202801,'0369d569-c751-491f-a1d4-6c6cb804b6ce',0,200132,2,TO_TIMESTAMP('2014-03-21 20:58:47','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',50,TO_TIMESTAMP('2014-03-21 20:58:47','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:58:48 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211137,202802,'66f46e1e-2994-4635-a6e4-0d26317caef7',0,200132,2,TO_TIMESTAMP('2014-03-21 20:58:48','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',60,TO_TIMESTAMP('2014-03-21 20:58:48','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:58:48 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211140,202803,'3ec34d03-1a2d-4baf-af0b-5fd8224247b6',0,200132,2,TO_TIMESTAMP('2014-03-21 20:58:48','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','AD_Chart_Trl_UU',70,TO_TIMESTAMP('2014-03-21 20:58:48','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:58:49 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211141,202804,'aa056e84-1cb6-44f5-beac-5b34b10b149f',0,200132,2,TO_TIMESTAMP('2014-03-21 20:58:48','YYYY-MM-DD HH24:MI:SS'),100,22,'D','Y','Y','Y','N','N','N','N','N','Chart',80,TO_TIMESTAMP('2014-03-21 20:58:48','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 8:58:49 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211133,202805,'e0df8d32-ad8f-4544-ad98-b71eaf1e74c5',0,200132,2,TO_TIMESTAMP('2014-03-21 20:58:49','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',90,TO_TIMESTAMP('2014-03-21 20:58:49','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 8:59:11 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:59:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202804
;

-- Mar 21, 2014 8:59:11 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 20:59:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202801
;

-- Mar 21, 2014 8:59:11 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:59:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202805
;

-- Mar 21, 2014 8:59:11 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 20:59:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202802
;

-- Mar 21, 2014 8:59:11 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 20:59:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202799
;

-- Mar 21, 2014 8:59:11 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2014-03-21 20:59:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202800
;

-- Mar 21, 2014 8:59:11 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 20:59:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202803
;

-- Mar 21, 2014 8:59:18 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 20:59:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202801
;

-- Mar 21, 2014 8:59:44 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-21 20:59:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200985
;

-- Mar 21, 2014 9:01:15 PM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,CopyColumnsFromTable,Created,CreatedBy,Description,EntityType,ImportTable,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200123,'34e3fcc8-bc7e-4cf9-b5b5-bc81c925f1dc',200023,'6','N',TO_TIMESTAMP('2014-03-21 21:01:15','YYYY-MM-DD HH24:MI:SS'),100,'Broadcast Messages for system users','D','N','Y','Y','Y','N','N','N','N',0,'Broadcast Message translation','N','L','AD_BroadcastMessage_Trl',TO_TIMESTAMP('2014-03-21 21:01:15','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 9:01:16 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200171,'dc2d1eef-3c59-4221-b66d-a4e867921835',TO_TIMESTAMP('2014-03-21 21:01:15','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table AD_BroadcastMessage_Trl',1,'Y','N','Y','Y','AD_BroadcastMessage_Trl','N',1000000,TO_TIMESTAMP('2014-03-21 21:01:15','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 9:01:21 PM CET
UPDATE AD_Table SET AD_Window_ID=200023,Updated=TO_TIMESTAMP('2014-03-21 21:01:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200038
;

-- Mar 21, 2014 9:01:31 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211142,'78d5882c-5d4b-492e-ba73-c6cb7edec7f9',102,0,19,200123,'AD_Client_ID',TO_TIMESTAMP('2014-03-21 21:01:30','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-21 21:01:30','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:01:31 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211143,'60ff92d0-41d5-4276-bcf3-92b4e4ee4357',113,0,19,200123,'AD_Org_ID',TO_TIMESTAMP('2014-03-21 21:01:31','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-21 21:01:31','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:01:31 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211144,'a6a0a8e5-e7d4-43cb-b396-697fffe44d8f',245,0,16,200123,'Created',TO_TIMESTAMP('2014-03-21 21:01:31','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-21 21:01:31','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:01:32 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211145,'b0e7554f-2004-4664-8906-a06556588f22',246,0,18,110,200123,'CreatedBy',TO_TIMESTAMP('2014-03-21 21:01:31','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-21 21:01:31','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:01:32 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211146,'84e05483-4b12-41c3-8a77-0fffb84ce100',348,0,20,200123,'IsActive',TO_TIMESTAMP('2014-03-21 21:01:32','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-21 21:01:32','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:01:33 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211147,'15febcea-3e0b-4dbc-b2ec-6b7b7794a13e',607,0,16,200123,'Updated',TO_TIMESTAMP('2014-03-21 21:01:32','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-21 21:01:32','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:01:33 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211148,'56d09c7b-62b0-4be3-b891-90a5f38fd8e5',608,0,18,110,200123,'UpdatedBy',TO_TIMESTAMP('2014-03-21 21:01:33','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-21 21:01:33','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:01:33 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211149,'19565687-4c49-42ff-bee3-ecb974ebf8a2',109,0,18,106,200123,'AD_Language',TO_TIMESTAMP('2014-03-21 21:01:33','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-21 21:01:33','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:01:34 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211150,'d43d2522-3aeb-4e3d-9aac-38cf7c63cd7c',420,0,20,200123,'IsTranslated',TO_TIMESTAMP('2014-03-21 21:01:33','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-21 21:01:33','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:01:34 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211151,'ed2f9362-bff3-4a8e-b7a1-15ce0ba452f8',200243,0,34,200123,'BroadcastMessage',TO_TIMESTAMP('2014-03-21 21:01:34','YYYY-MM-DD HH24:MI:SS'),100,'Broadcast Message','D',2000,'Y','N','Y','Y','N','N','N','N','Y','N','N','N','N','N','N','Y','Broadcast Message',TO_TIMESTAMP('2014-03-21 21:01:34','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 21, 2014 9:01:35 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202687,'c7967ebf-5983-48cb-9b83-e5dbb12cb5fe',0,'AD_BroadcastMessage_Trl_UU',TO_TIMESTAMP('2014-03-21 21:01:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_BroadcastMessage_Trl_UU','AD_BroadcastMessage_Trl_UU',TO_TIMESTAMP('2014-03-21 21:01:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 9:01:35 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211152,'fab80a00-0f56-44ce-b0c4-579fb71a604e',202687,0,10,200123,'AD_BroadcastMessage_Trl_UU',TO_TIMESTAMP('2014-03-21 21:01:35','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_BroadcastMessage_Trl_UU',TO_TIMESTAMP('2014-03-21 21:01:35','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:01:36 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211153,'5539800e-d265-4760-8b3a-b24f38a59063',200251,0,30,200123,'AD_BroadcastMessage_ID',TO_TIMESTAMP('2014-03-21 21:01:35','YYYY-MM-DD HH24:MI:SS'),100,'Broadcast Message','D','C',22,'Y','N','N','N','N','Y','Y','N','N','N','Broadcast Message',TO_TIMESTAMP('2014-03-21 21:01:35','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 21, 2014 9:02:16 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,211153,0,200133,'e767052e-480f-4c9d-b9a0-73395fcb8ce8',200123,200023,TO_TIMESTAMP('2014-03-21 21:02:16','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','N','N','Y','N','Y','Translation','N',30,1,TO_TIMESTAMP('2014-03-21 21:02:16','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 9:02:18 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211142,202806,'f7837fce-070c-4aab-ba3b-b2a5e9752160',0,200133,2,TO_TIMESTAMP('2014-03-21 21:02:18','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-21 21:02:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 9:02:19 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211143,202807,'9b5164b6-0725-4185-b1db-117dfcc5d729',0,200133,2,TO_TIMESTAMP('2014-03-21 21:02:19','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-21 21:02:19','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 21, 2014 9:02:19 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211149,202808,'e52e22f0-fca3-4622-a512-b0688e8db93d',0,200133,2,TO_TIMESTAMP('2014-03-21 21:02:19','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',30,TO_TIMESTAMP('2014-03-21 21:02:19','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 9:02:20 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211150,202809,'6aed7bac-aa24-4ef2-989b-4266e588bbc4',0,200133,2,TO_TIMESTAMP('2014-03-21 21:02:19','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',40,TO_TIMESTAMP('2014-03-21 21:02:19','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 9:02:20 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,NumLines,SeqNo,Updated,UpdatedBy) VALUES (0,211151,202810,'f8a88d87-4b6e-4d7c-8e72-8d8c9271350e',0,200133,5,TO_TIMESTAMP('2014-03-21 21:02:20','YYYY-MM-DD HH24:MI:SS'),100,'Broadcast Message',2000,'D','Y','Y','Y','N','N','N','N','N','Broadcast Message',8,50,TO_TIMESTAMP('2014-03-21 21:02:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 9:02:21 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211152,202811,'b91b55ae-5778-4b61-95ee-6efc6f7fb0f8',0,200133,2,TO_TIMESTAMP('2014-03-21 21:02:20','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','AD_BroadcastMessage_Trl_UU',60,TO_TIMESTAMP('2014-03-21 21:02:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 9:02:21 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211153,202812,'9f868808-f587-4d5a-8daa-4f7b38372bf1',0,200133,2,TO_TIMESTAMP('2014-03-21 21:02:21','YYYY-MM-DD HH24:MI:SS'),100,'Broadcast Message',22,'D','Y','Y','Y','N','N','N','N','N','Broadcast Message',70,TO_TIMESTAMP('2014-03-21 21:02:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 21, 2014 9:02:21 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211146,202813,'c282064a-8c59-4373-acd9-cacdab4788b2',0,200133,2,TO_TIMESTAMP('2014-03-21 21:02:21','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',80,TO_TIMESTAMP('2014-03-21 21:02:21','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 21, 2014 9:02:41 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-21 21:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202812
;

-- Mar 21, 2014 9:02:41 PM CET
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2014-03-21 21:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202808
;

-- Mar 21, 2014 9:02:41 PM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-21 21:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202813
;

-- Mar 21, 2014 9:02:41 PM CET
UPDATE AD_Field SET ColumnSpan=1, SeqNo=60,Updated=TO_TIMESTAMP('2014-03-21 21:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202809
;

-- Mar 21, 2014 9:02:41 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-21 21:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202810
;

-- Mar 21, 2014 9:02:41 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-21 21:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202811
;

-- Mar 21, 2014 9:02:49 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 21:02:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202808
;

-- Mar 21, 2014 9:03:45 PM CET
UPDATE AD_Table SET Name='Sales Region translation',Updated=TO_TIMESTAMP('2014-03-21 21:03:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200119
;

-- Mar 21, 2014 9:05:26 PM CET
UPDATE AD_Tab SET AD_Column_ID=211039,Updated=TO_TIMESTAMP('2014-03-21 21:05:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200124
;

-- Mar 21, 2014 9:06:16 PM CET
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2014-03-21 21:06:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200124
;

-- Mar 21, 2014 9:06:31 PM CET
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2014-03-21 21:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200126
;

-- Mar 21, 2014 9:08:49 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 21:08:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202775
;

-- Mar 21, 2014 9:09:07 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-21 21:09:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202749
;

-- Mar 21, 2014 9:10:12 PM CET
UPDATE AD_Column SET FKConstraintName='AAssetGroup_AAssetGroupTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211027
;

-- Mar 21, 2014 9:10:12 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_AAssetGroupTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211014
;

-- Mar 21, 2014 9:10:12 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_AAssetGroupTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211021
;

-- Mar 21, 2014 9:10:12 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_AAssetGroupTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211015
;

-- Mar 21, 2014 9:10:12 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_AAssetGroupTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211017
;

-- Mar 21, 2014 9:10:12 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_AAssetGroupTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211020
;

-- Mar 21, 2014 9:10:12 PM CET
CREATE TABLE A_Asset_Group_Trl (A_Asset_Group_ID NUMERIC(10) NOT NULL, A_Asset_Group_Trl_UU VARCHAR(36) DEFAULT NULL , AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , Help VARCHAR(2000) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT A_Asset_Group_Trl_Key PRIMARY KEY (A_Asset_Group_ID, AD_Language), CONSTRAINT A_Asset_Group_Trl_UU_idx UNIQUE (A_Asset_Group_Trl_UU))
;

-- Mar 21, 2014 9:10:13 PM CET
ALTER TABLE A_Asset_Group_Trl ADD CONSTRAINT AAssetGroup_AAssetGroupTrl FOREIGN KEY (A_Asset_Group_ID) REFERENCES A_ASSET_GROUP(A_ASSET_GROUP_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:13 PM CET
ALTER TABLE A_Asset_Group_Trl ADD CONSTRAINT ADClient_AAssetGroupTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:13 PM CET
ALTER TABLE A_Asset_Group_Trl ADD CONSTRAINT ADLanguage_AAssetGroupTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:13 PM CET
ALTER TABLE A_Asset_Group_Trl ADD CONSTRAINT ADOrg_AAssetGroupTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:13 PM CET
ALTER TABLE A_Asset_Group_Trl ADD CONSTRAINT CreatedBy_AAssetGroupTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:13 PM CET
ALTER TABLE A_Asset_Group_Trl ADD CONSTRAINT UpdatedBy_AAssetGroupTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:40 PM CET
UPDATE AD_Column SET FKConstraintName='ADBroadcastMessage_ADBroadcast', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211153
;

-- Mar 21, 2014 9:10:40 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_ADBroadcastMessageTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211142
;

-- Mar 21, 2014 9:10:40 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_ADBroadcastMessageT', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211149
;

-- Mar 21, 2014 9:10:40 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_ADBroadcastMessageTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211143
;

-- Mar 21, 2014 9:10:40 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADBroadcastMessageTr', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211145
;

-- Mar 21, 2014 9:10:40 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADBroadcastMessageTr', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211148
;

-- Mar 21, 2014 9:10:40 PM CET
CREATE TABLE AD_BroadcastMessage_Trl (AD_BroadcastMessage_ID NUMERIC(10) NOT NULL, AD_BroadcastMessage_Trl_UU VARCHAR(36) DEFAULT NULL , AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, BroadcastMessage VARCHAR(2000) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_BroadcastMessage_Trl_Key PRIMARY KEY (AD_BroadcastMessage_ID, AD_Language), CONSTRAINT AD_BroadcastMessage_Trl_UU_idx UNIQUE (AD_BroadcastMessage_Trl_UU))
;

-- Mar 21, 2014 9:10:40 PM CET
ALTER TABLE AD_BroadcastMessage_Trl ADD CONSTRAINT ADBroadcastMessage_ADBroadcast FOREIGN KEY (AD_BroadcastMessage_ID) REFERENCES AD_BROADCASTMESSAGE(AD_BROADCASTMESSAGE_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:40 PM CET
ALTER TABLE AD_BroadcastMessage_Trl ADD CONSTRAINT ADClient_ADBroadcastMessageTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:40 PM CET
ALTER TABLE AD_BroadcastMessage_Trl ADD CONSTRAINT ADLanguage_ADBroadcastMessageT FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:40 PM CET
ALTER TABLE AD_BroadcastMessage_Trl ADD CONSTRAINT ADOrg_ADBroadcastMessageTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:40 PM CET
ALTER TABLE AD_BroadcastMessage_Trl ADD CONSTRAINT CreatedBy_ADBroadcastMessageTr FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:40 PM CET
ALTER TABLE AD_BroadcastMessage_Trl ADD CONSTRAINT UpdatedBy_ADBroadcastMessageTr FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:54 PM CET
UPDATE AD_Column SET FKConstraintName='ADChart_ADChartTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211141
;

-- Mar 21, 2014 9:10:54 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_ADChartTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211129
;

-- Mar 21, 2014 9:10:54 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_ADChartTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211136
;

-- Mar 21, 2014 9:10:54 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_ADChartTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211130
;

-- Mar 21, 2014 9:10:54 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADChartTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211132
;

-- Mar 21, 2014 9:10:54 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADChartTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211135
;

-- Mar 21, 2014 9:10:54 PM CET
CREATE TABLE AD_Chart_Trl (AD_Chart_ID NUMERIC(10) NOT NULL, AD_Chart_Trl_UU VARCHAR(36) DEFAULT NULL , AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_Chart_Trl_Key PRIMARY KEY (AD_Chart_ID, AD_Language), CONSTRAINT AD_Chart_Trl_UU_idx UNIQUE (AD_Chart_Trl_UU))
;

-- Mar 21, 2014 9:10:55 PM CET
ALTER TABLE AD_Chart_Trl ADD CONSTRAINT ADChart_ADChartTrl FOREIGN KEY (AD_Chart_ID) REFERENCES AD_CHART(AD_CHART_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:55 PM CET
ALTER TABLE AD_Chart_Trl ADD CONSTRAINT ADClient_ADChartTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:55 PM CET
ALTER TABLE AD_Chart_Trl ADD CONSTRAINT ADLanguage_ADChartTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:55 PM CET
ALTER TABLE AD_Chart_Trl ADD CONSTRAINT ADOrg_ADChartTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:55 PM CET
ALTER TABLE AD_Chart_Trl ADD CONSTRAINT CreatedBy_ADChartTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:10:55 PM CET
ALTER TABLE AD_Chart_Trl ADD CONSTRAINT UpdatedBy_ADChartTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:15 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_ADColorTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211028
;

-- Mar 21, 2014 9:11:15 PM CET
UPDATE AD_Column SET FKConstraintName='ADColor_ADColorTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211039
;

-- Mar 21, 2014 9:11:15 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_ADColorTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211035
;

-- Mar 21, 2014 9:11:15 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_ADColorTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211029
;

-- Mar 21, 2014 9:11:15 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADColorTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211031
;

-- Mar 21, 2014 9:11:15 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADColorTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211034
;

-- Mar 21, 2014 9:11:15 PM CET
CREATE TABLE AD_Color_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Color_ID NUMERIC(10) NOT NULL, AD_Color_Trl_UU VARCHAR(36) DEFAULT NULL , AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_Color_Trl_Key PRIMARY KEY (AD_Color_ID, AD_Language), CONSTRAINT AD_Color_Trl_UU_idx UNIQUE (AD_Color_Trl_UU))
;

-- Mar 21, 2014 9:11:15 PM CET
ALTER TABLE AD_Color_Trl ADD CONSTRAINT ADClient_ADColorTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:15 PM CET
ALTER TABLE AD_Color_Trl ADD CONSTRAINT ADColor_ADColorTrl FOREIGN KEY (AD_Color_ID) REFERENCES AD_COLOR(AD_COLOR_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:15 PM CET
ALTER TABLE AD_Color_Trl ADD CONSTRAINT ADLanguage_ADColorTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:15 PM CET
ALTER TABLE AD_Color_Trl ADD CONSTRAINT ADOrg_ADColorTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:15 PM CET
ALTER TABLE AD_Color_Trl ADD CONSTRAINT CreatedBy_ADColorTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:15 PM CET
ALTER TABLE AD_Color_Trl ADD CONSTRAINT UpdatedBy_ADColorTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:30 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_ADPrintColorTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211040
;

-- Mar 21, 2014 9:11:30 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_ADPrintColorTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211047
;

-- Mar 21, 2014 9:11:30 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_ADPrintColorTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211041
;

-- Mar 21, 2014 9:11:30 PM CET
UPDATE AD_Column SET FKConstraintName='ADPrintColor_ADPrintColorTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211051
;

-- Mar 21, 2014 9:11:30 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADPrintColorTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211043
;

-- Mar 21, 2014 9:11:30 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADPrintColorTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211046
;

-- Mar 21, 2014 9:11:30 PM CET
CREATE TABLE AD_PrintColor_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_PrintColor_ID NUMERIC(10) NOT NULL, AD_PrintColor_Trl_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_PrintColor_Trl_Key PRIMARY KEY (AD_Language, AD_PrintColor_ID), CONSTRAINT AD_PrintColor_Trl_UU_idx UNIQUE (AD_PrintColor_Trl_UU))
;

-- Mar 21, 2014 9:11:30 PM CET
ALTER TABLE AD_PrintColor_Trl ADD CONSTRAINT ADClient_ADPrintColorTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:30 PM CET
ALTER TABLE AD_PrintColor_Trl ADD CONSTRAINT ADLanguage_ADPrintColorTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:30 PM CET
ALTER TABLE AD_PrintColor_Trl ADD CONSTRAINT ADOrg_ADPrintColorTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:30 PM CET
ALTER TABLE AD_PrintColor_Trl ADD CONSTRAINT ADPrintColor_ADPrintColorTrl FOREIGN KEY (AD_PrintColor_ID) REFERENCES AD_PRINTCOLOR(AD_PRINTCOLOR_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:30 PM CET
ALTER TABLE AD_PrintColor_Trl ADD CONSTRAINT CreatedBy_ADPrintColorTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:30 PM CET
ALTER TABLE AD_PrintColor_Trl ADD CONSTRAINT UpdatedBy_ADPrintColorTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:44 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_CActivityTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211052
;

-- Mar 21, 2014 9:11:44 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_CActivityTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211059
;

-- Mar 21, 2014 9:11:44 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_CActivityTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211053
;

-- Mar 21, 2014 9:11:44 PM CET
UPDATE AD_Column SET FKConstraintName='CActivity_CActivityTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211065
;

-- Mar 21, 2014 9:11:44 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_CActivityTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211055
;

-- Mar 21, 2014 9:11:44 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_CActivityTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211058
;

-- Mar 21, 2014 9:11:44 PM CET
CREATE TABLE C_Activity_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_Activity_ID NUMERIC(10) NOT NULL, C_Activity_Trl_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , Help VARCHAR(2000) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_Activity_Trl_Key PRIMARY KEY (AD_Language, C_Activity_ID), CONSTRAINT C_Activity_Trl_UU_idx UNIQUE (C_Activity_Trl_UU))
;

-- Mar 21, 2014 9:11:44 PM CET
ALTER TABLE C_Activity_Trl ADD CONSTRAINT ADClient_CActivityTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:44 PM CET
ALTER TABLE C_Activity_Trl ADD CONSTRAINT ADLanguage_CActivityTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:44 PM CET
ALTER TABLE C_Activity_Trl ADD CONSTRAINT ADOrg_CActivityTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:44 PM CET
ALTER TABLE C_Activity_Trl ADD CONSTRAINT CActivity_CActivityTrl FOREIGN KEY (C_Activity_ID) REFERENCES C_ACTIVITY(C_ACTIVITY_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:44 PM CET
ALTER TABLE C_Activity_Trl ADD CONSTRAINT CreatedBy_CActivityTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:44 PM CET
ALTER TABLE C_Activity_Trl ADD CONSTRAINT UpdatedBy_CActivityTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:57 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_CCampaignTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211066
;

-- Mar 21, 2014 9:11:57 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_CCampaignTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211073
;

-- Mar 21, 2014 9:11:57 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_CCampaignTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211067
;

-- Mar 21, 2014 9:11:57 PM CET
UPDATE AD_Column SET FKConstraintName='CCampaign_CCampaignTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211078
;

-- Mar 21, 2014 9:11:57 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_CCampaignTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211069
;

-- Mar 21, 2014 9:11:57 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_CCampaignTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:11:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211072
;

-- Mar 21, 2014 9:11:57 PM CET
CREATE TABLE C_Campaign_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_Campaign_ID NUMERIC(10) NOT NULL, C_Campaign_Trl_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_Campaign_Trl_Key PRIMARY KEY (AD_Language, C_Campaign_ID), CONSTRAINT C_Campaign_Trl_UU_idx UNIQUE (C_Campaign_Trl_UU))
;

-- Mar 21, 2014 9:11:57 PM CET
ALTER TABLE C_Campaign_Trl ADD CONSTRAINT ADClient_CCampaignTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:57 PM CET
ALTER TABLE C_Campaign_Trl ADD CONSTRAINT ADLanguage_CCampaignTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:57 PM CET
ALTER TABLE C_Campaign_Trl ADD CONSTRAINT ADOrg_CCampaignTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:57 PM CET
ALTER TABLE C_Campaign_Trl ADD CONSTRAINT CCampaign_CCampaignTrl FOREIGN KEY (C_Campaign_ID) REFERENCES C_CAMPAIGN(C_CAMPAIGN_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:57 PM CET
ALTER TABLE C_Campaign_Trl ADD CONSTRAINT CreatedBy_CCampaignTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:11:57 PM CET
ALTER TABLE C_Campaign_Trl ADD CONSTRAINT UpdatedBy_CCampaignTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:08 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_CRegionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211079
;

-- Mar 21, 2014 9:12:08 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_CRegionTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211086
;

-- Mar 21, 2014 9:12:08 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_CRegionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211080
;

-- Mar 21, 2014 9:12:08 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_CRegionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211082
;

-- Mar 21, 2014 9:12:08 PM CET
UPDATE AD_Column SET FKConstraintName='CRegion_CRegionTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211090
;

-- Mar 21, 2014 9:12:08 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_CRegionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211085
;

-- Mar 21, 2014 9:12:08 PM CET
CREATE TABLE C_Region_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, C_Region_ID NUMERIC(10) NOT NULL, C_Region_Trl_UU VARCHAR(36) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_Region_Trl_Key PRIMARY KEY (AD_Language, C_Region_ID), CONSTRAINT C_Region_Trl_UU_idx UNIQUE (C_Region_Trl_UU))
;

-- Mar 21, 2014 9:12:08 PM CET
ALTER TABLE C_Region_Trl ADD CONSTRAINT ADClient_CRegionTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:08 PM CET
ALTER TABLE C_Region_Trl ADD CONSTRAINT ADLanguage_CRegionTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:08 PM CET
ALTER TABLE C_Region_Trl ADD CONSTRAINT ADOrg_CRegionTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:08 PM CET
ALTER TABLE C_Region_Trl ADD CONSTRAINT CreatedBy_CRegionTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:08 PM CET
ALTER TABLE C_Region_Trl ADD CONSTRAINT CRegion_CRegionTrl FOREIGN KEY (C_Region_ID) REFERENCES C_REGION(C_REGION_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:08 PM CET
ALTER TABLE C_Region_Trl ADD CONSTRAINT UpdatedBy_CRegionTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:18 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_CSalesRegionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211091
;

-- Mar 21, 2014 9:12:18 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_CSalesRegionTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211098
;

-- Mar 21, 2014 9:12:18 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_CSalesRegionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211092
;

-- Mar 21, 2014 9:12:18 PM CET
UPDATE AD_Column SET FKConstraintName='CSalesRegion_CSalesRegionTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211103
;

-- Mar 21, 2014 9:12:18 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_CSalesRegionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211094
;

-- Mar 21, 2014 9:12:18 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_CSalesRegionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211097
;

-- Mar 21, 2014 9:12:18 PM CET
CREATE TABLE C_SalesRegion_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_SalesRegion_ID NUMERIC(10) NOT NULL, C_SalesRegion_Trl_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_SalesRegion_Trl_Key PRIMARY KEY (AD_Language, C_SalesRegion_ID), CONSTRAINT C_SalesRegion_Trl_UU_idx UNIQUE (C_SalesRegion_Trl_UU))
;

-- Mar 21, 2014 9:12:18 PM CET
ALTER TABLE C_SalesRegion_Trl ADD CONSTRAINT ADClient_CSalesRegionTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:18 PM CET
ALTER TABLE C_SalesRegion_Trl ADD CONSTRAINT ADLanguage_CSalesRegionTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:18 PM CET
ALTER TABLE C_SalesRegion_Trl ADD CONSTRAINT ADOrg_CSalesRegionTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:18 PM CET
ALTER TABLE C_SalesRegion_Trl ADD CONSTRAINT CSalesRegion_CSalesRegionTrl FOREIGN KEY (C_SalesRegion_ID) REFERENCES C_SALESREGION(C_SALESREGION_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:18 PM CET
ALTER TABLE C_SalesRegion_Trl ADD CONSTRAINT CreatedBy_CSalesRegionTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:18 PM CET
ALTER TABLE C_SalesRegion_Trl ADD CONSTRAINT UpdatedBy_CSalesRegionTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:35 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_MPriceListTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211104
;

-- Mar 21, 2014 9:12:35 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_MPriceListTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211111
;

-- Mar 21, 2014 9:12:35 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_MPriceListTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211105
;

-- Mar 21, 2014 9:12:35 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_MPriceListTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211107
;

-- Mar 21, 2014 9:12:35 PM CET
UPDATE AD_Column SET FKConstraintName='MPriceList_MPriceListTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211116
;

-- Mar 21, 2014 9:12:35 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_MPriceListTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211110
;

-- Mar 21, 2014 9:12:35 PM CET
CREATE TABLE M_PriceList_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, M_PriceList_ID NUMERIC(10) NOT NULL, M_PriceList_Trl_UU VARCHAR(36) DEFAULT NULL , Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT M_PriceList_Trl_Key PRIMARY KEY (AD_Language, M_PriceList_ID), CONSTRAINT M_PriceList_Trl_UU_idx UNIQUE (M_PriceList_Trl_UU))
;

-- Mar 21, 2014 9:12:35 PM CET
ALTER TABLE M_PriceList_Trl ADD CONSTRAINT ADClient_MPriceListTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:35 PM CET
ALTER TABLE M_PriceList_Trl ADD CONSTRAINT ADLanguage_MPriceListTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:35 PM CET
ALTER TABLE M_PriceList_Trl ADD CONSTRAINT ADOrg_MPriceListTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:35 PM CET
ALTER TABLE M_PriceList_Trl ADD CONSTRAINT CreatedBy_MPriceListTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:35 PM CET
ALTER TABLE M_PriceList_Trl ADD CONSTRAINT MPriceList_MPriceListTrl FOREIGN KEY (M_PriceList_ID) REFERENCES M_PRICELIST(M_PRICELIST_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:35 PM CET
ALTER TABLE M_PriceList_Trl ADD CONSTRAINT UpdatedBy_MPriceListTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:48 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_MProductCategoryTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211001
;

-- Mar 21, 2014 9:12:48 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_MProductCategoryTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211008
;

-- Mar 21, 2014 9:12:48 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_MProductCategoryTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211002
;

-- Mar 21, 2014 9:12:48 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_MProductCategoryTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211004
;

-- Mar 21, 2014 9:12:48 PM CET
UPDATE AD_Column SET FKConstraintName='MProductCategory_MProductCateg', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211013
;

-- Mar 21, 2014 9:12:48 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_MProductCategoryTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211007
;

-- Mar 21, 2014 9:12:48 PM CET
CREATE TABLE M_Product_Category_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, M_Product_Category_ID NUMERIC(10) NOT NULL, M_Product_Category_Trl_UU VARCHAR(36) DEFAULT NULL , Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT M_Product_Category_Trl_Key PRIMARY KEY (AD_Language, M_Product_Category_ID), CONSTRAINT M_Product_Category_Trl_UU_idx UNIQUE (M_Product_Category_Trl_UU))
;

-- Mar 21, 2014 9:12:48 PM CET
ALTER TABLE M_Product_Category_Trl ADD CONSTRAINT ADClient_MProductCategoryTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:48 PM CET
ALTER TABLE M_Product_Category_Trl ADD CONSTRAINT ADLanguage_MProductCategoryTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:48 PM CET
ALTER TABLE M_Product_Category_Trl ADD CONSTRAINT ADOrg_MProductCategoryTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:48 PM CET
ALTER TABLE M_Product_Category_Trl ADD CONSTRAINT CreatedBy_MProductCategoryTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:48 PM CET
ALTER TABLE M_Product_Category_Trl ADD CONSTRAINT MProductCategory_MProductCateg FOREIGN KEY (M_Product_Category_ID) REFERENCES M_PRODUCT_CATEGORY(M_PRODUCT_CATEGORY_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:48 PM CET
ALTER TABLE M_Product_Category_Trl ADD CONSTRAINT UpdatedBy_MProductCategoryTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:58 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_MPriceListVersionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211117
;

-- Mar 21, 2014 9:12:58 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_MPriceListVersionTr', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211124
;

-- Mar 21, 2014 9:12:58 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_MPriceListVersionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211118
;

-- Mar 21, 2014 9:12:58 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_MPriceListVersionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211120
;

-- Mar 21, 2014 9:12:58 PM CET
UPDATE AD_Column SET FKConstraintName='MPriceListVersion_MPriceListVe', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211128
;

-- Mar 21, 2014 9:12:58 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_MPriceListVersionTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-21 21:12:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211123
;

-- Mar 21, 2014 9:12:58 PM CET
CREATE TABLE M_PriceList_Version_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, M_PriceList_Version_ID NUMERIC(10) NOT NULL, M_PriceList_Version_Trl_UU VARCHAR(36) DEFAULT NULL , Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT M_PriceList_Version_Trl_Key PRIMARY KEY (AD_Language, M_PriceList_Version_ID), CONSTRAINT M_PriceList_Version_Trl_UU_idx UNIQUE (M_PriceList_Version_Trl_UU))
;

-- Mar 21, 2014 9:12:58 PM CET
ALTER TABLE M_PriceList_Version_Trl ADD CONSTRAINT ADClient_MPriceListVersionTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:58 PM CET
ALTER TABLE M_PriceList_Version_Trl ADD CONSTRAINT ADLanguage_MPriceListVersionTr FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:58 PM CET
ALTER TABLE M_PriceList_Version_Trl ADD CONSTRAINT ADOrg_MPriceListVersionTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:58 PM CET
ALTER TABLE M_PriceList_Version_Trl ADD CONSTRAINT CreatedBy_MPriceListVersionTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:58 PM CET
ALTER TABLE M_PriceList_Version_Trl ADD CONSTRAINT MPriceListVersion_MPriceListVe FOREIGN KEY (M_PriceList_Version_ID) REFERENCES M_PRICELIST_VERSION(M_PRICELIST_VERSION_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 21, 2014 9:12:58 PM CET
ALTER TABLE M_PriceList_Version_Trl ADD CONSTRAINT UpdatedBy_MPriceListVersionTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 22, 2014 1:28:46 PM CET
-- IDEMPIERE-1216
UPDATE AD_Column SET IsToolbarButton='N', IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-22 13:28:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59906
;

-- Mar 22, 2014 1:28:53 PM CET
UPDATE AD_Column SET IsToolbarButton='N', IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-22 13:28:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59907
;

-- Mar 22, 2014 1:29:21 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,211154,'4e9770a2-8b7b-4096-9c1f-10a7080c2740',54322,0,10,200122,'DomainLabel',TO_TIMESTAMP('2014-03-22 13:29:20','YYYY-MM-DD HH24:MI:SS'),100,'Label for the domain axis.','D',60,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','Domain Label',0,0,TO_TIMESTAMP('2014-03-22 13:29:20','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 22, 2014 1:29:23 PM CET
ALTER TABLE AD_Chart_Trl ADD COLUMN DomainLabel VARCHAR(60) DEFAULT NULL 
;

-- Mar 22, 2014 1:29:37 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,211155,'b9ea198a-3942-4161-b259-e159438c5821',54321,0,10,200122,'RangeLabel',TO_TIMESTAMP('2014-03-22 13:29:37','YYYY-MM-DD HH24:MI:SS'),100,'Label for the range axis.','D',60,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','Range Label',0,0,TO_TIMESTAMP('2014-03-22 13:29:37','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 22, 2014 1:29:39 PM CET
ALTER TABLE AD_Chart_Trl ADD COLUMN RangeLabel VARCHAR(60) DEFAULT NULL 
;

-- Mar 22, 2014 1:30:05 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211154,202814,'df62a3b5-296f-4d6c-b408-5ec3011854dc',0,200132,5,TO_TIMESTAMP('2014-03-22 13:30:05','YYYY-MM-DD HH24:MI:SS'),100,'Label for the domain axis.',60,'D','Y','Y','Y','N','N','N','N','N','Domain Label',90,TO_TIMESTAMP('2014-03-22 13:30:05','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 22, 2014 1:30:06 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211155,202815,'8a63cc9e-c4a8-469d-b284-2a4f8b807612',0,200132,5,TO_TIMESTAMP('2014-03-22 13:30:05','YYYY-MM-DD HH24:MI:SS'),100,'Label for the range axis.',60,'D','Y','Y','Y','N','N','N','N','N','Range Label',100,TO_TIMESTAMP('2014-03-22 13:30:05','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 22, 2014 1:30:27 PM CET
UPDATE AD_Field SET ColumnSpan=2, SeqNo=90,Updated=TO_TIMESTAMP('2014-03-22 13:30:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202814
;

-- Mar 22, 2014 1:30:27 PM CET
UPDATE AD_Field SET ColumnSpan=2, IsDisplayed='Y', SeqNo=100, XPosition=4,Updated=TO_TIMESTAMP('2014-03-22 13:30:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202815
;

-- Mar 22, 2014 1:30:46 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202805
;

-- Mar 22, 2014 1:30:47 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202804
;

-- Mar 22, 2014 1:30:47 PM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202801
;

-- Mar 22, 2014 1:30:47 PM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202799
;

-- Mar 22, 2014 1:30:47 PM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202800
;

-- Mar 22, 2014 1:30:47 PM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202814
;

-- Mar 22, 2014 1:30:47 PM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202815
;

-- Mar 22, 2014 1:30:47 PM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202802
;

SELECT register_migration_script('201403212121_IDEMPIERE-1216.sql') FROM dual
;
-- Mar 24, 2014 9:02:07 AM CET
-- IDEMPIERE-1216
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-24 09:02:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=62157
;

-- Mar 24, 2014 9:02:14 AM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2014-03-24 09:02:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=62161
;

-- Mar 24, 2014 9:02:33 AM CET
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,Help,ImportTable,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200124,'e79f3ab6-c676-4788-9fa2-e62a9bdfe65b',53154,'3',TO_TIMESTAMP('2014-03-24 09:02:33','YYYY-MM-DD HH24:MI:SS'),100,'Stages of the sales process','D','Define what stages your sales process will move through','N','Y','Y','N','N','N','N','N','Sales Stage translation','N','L','C_SalesStage_Trl',TO_TIMESTAMP('2014-03-24 09:02:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2014 9:02:34 AM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200172,'08dc9e05-0974-4cb4-afec-113eb33503ad',TO_TIMESTAMP('2014-03-24 09:02:34','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table C_SalesStage_Trl',1,'Y','N','Y','Y','C_SalesStage_Trl','N',1000000,TO_TIMESTAMP('2014-03-24 09:02:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2014 9:03:17 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,Updated,UpdatedBy,Version) VALUES (0,211156,'9e400172-f21d-44a3-af59-529fe66f2d81',102,0,19,200124,'AD_Client_ID',TO_TIMESTAMP('2014-03-24 09:03:17','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N','N','Y','N','N','N','N','Client','1=1',TO_TIMESTAMP('2014-03-24 09:03:17','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:18 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211157,'c6654cf0-0ea3-43b9-a295-9457d75f27ec',113,0,19,200124,'AD_Org_ID',TO_TIMESTAMP('2014-03-24 09:03:17','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N','N','Y','N','N','N','N','Organization',TO_TIMESTAMP('2014-03-24 09:03:17','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:18 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211158,'91bb0043-9b2b-4b7f-a435-dc67738c6c78',245,0,16,200124,'Created',TO_TIMESTAMP('2014-03-24 09:03:18','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','N','N','N','Y','N','N','N','N','Created',TO_TIMESTAMP('2014-03-24 09:03:18','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:18 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211159,'620baf77-eb97-4608-96e6-81e3804129a7',246,0,18,110,200124,'CreatedBy',TO_TIMESTAMP('2014-03-24 09:03:18','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','N','N','N','Y','N','N','N','N','Created By',TO_TIMESTAMP('2014-03-24 09:03:18','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:19 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211160,'93768e30-d272-4209-a0b0-18cbc6a56218',348,0,20,200124,'IsActive',TO_TIMESTAMP('2014-03-24 09:03:19','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','N','N','Y','N','N','N','Y','Active',TO_TIMESTAMP('2014-03-24 09:03:19','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:19 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211161,'9cb00aec-fcaa-4460-9d8c-41c8f3a66701',607,0,16,200124,'Updated',TO_TIMESTAMP('2014-03-24 09:03:19','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','N','N','N','Y','N','N','N','N','Updated',TO_TIMESTAMP('2014-03-24 09:03:19','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:20 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211162,'26602d03-5b53-4e79-82cb-a7d61947a95e',608,0,18,110,200124,'UpdatedBy',TO_TIMESTAMP('2014-03-24 09:03:19','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','N','N','N','Y','N','N','N','N','Updated By',TO_TIMESTAMP('2014-03-24 09:03:19','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:20 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211163,'44e7c685-9072-47c9-8a77-d9f99c1a81dc',109,0,18,106,200124,'AD_Language',TO_TIMESTAMP('2014-03-24 09:03:20','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity','D',6,'The Language identifies the language to use for display and formatting','Y','N','N','N','N','Y','Y','N','N','N','Language',TO_TIMESTAMP('2014-03-24 09:03:20','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:21 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211164,'2a6c9fca-e99e-49e5-afc1-b1ba91b970fd',420,0,20,200124,'IsTranslated',TO_TIMESTAMP('2014-03-24 09:03:20','YYYY-MM-DD HH24:MI:SS'),100,'N','This column is translated','D',1,'The Translated checkbox indicates if this column is translated.','Y','N','N','N','N','Y','N','N','N','Y','Translated',TO_TIMESTAMP('2014-03-24 09:03:20','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:21 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211165,'fedc5395-0859-4fa8-a69a-3bd2c5823893',275,0,10,200124,'Description',TO_TIMESTAMP('2014-03-24 09:03:21','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record','D',255,'A description is limited to 255 characters.','Y','N','Y','Y','N','N','N','N','N','N','N','Y','Y','N','N','Y','Description',TO_TIMESTAMP('2014-03-24 09:03:21','YYYY-MM-DD HH24:MI:SS'),100,1)
;

-- Mar 24, 2014 9:03:22 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,211166,'a7e8b380-b26c-4f25-85ed-29fe1a25f3ee',469,0,10,200124,'Name',TO_TIMESTAMP('2014-03-24 09:03:21','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','N','Y','Y','N','N','Y','N','Y','N','N','Y','Y','N','N','Y','Name',1,TO_TIMESTAMP('2014-03-24 09:03:21','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 24, 2014 9:03:22 AM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202688,'2ecfb6c7-31df-4b6b-a2c4-3ed700444702',0,'C_SalesStage_Trl_UU',TO_TIMESTAMP('2014-03-24 09:03:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_SalesStage_Trl_UU','C_SalesStage_Trl_UU',TO_TIMESTAMP('2014-03-24 09:03:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2014 9:03:23 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211167,'b662cb48-9e5c-41bd-a095-9a992a0802e1',202688,0,10,200124,'C_SalesStage_Trl_UU',TO_TIMESTAMP('2014-03-24 09:03:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_SalesStage_Trl_UU',TO_TIMESTAMP('2014-03-24 09:03:22','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:23 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,211168,'1f2d48de-ce81-4f90-8f9a-b9d1874b0290',55289,0,30,200124,'C_SalesStage_ID',TO_TIMESTAMP('2014-03-24 09:03:23','YYYY-MM-DD HH24:MI:SS'),100,'Stages of the sales process','D','C',22,'Define what stages your sales process will move through','Y','N','N','N','N','Y','Y','N','N','N','Sales Stage',TO_TIMESTAMP('2014-03-24 09:03:23','YYYY-MM-DD HH24:MI:SS'),100,0.0)
;

-- Mar 24, 2014 9:03:38 AM CET
UPDATE AD_Column SET FKConstraintName='ADClient_CSalesStageTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-24 09:03:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211156
;

-- Mar 24, 2014 9:03:39 AM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_CSalesStageTrl', FKConstraintType='N', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-24 09:03:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211163
;

-- Mar 24, 2014 9:03:39 AM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_CSalesStageTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-24 09:03:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211157
;

-- Mar 24, 2014 9:03:40 AM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_CSalesStageTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-24 09:03:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211159
;

-- Mar 24, 2014 9:03:40 AM CET
UPDATE AD_Column SET FKConstraintName='CSalesStage_CSalesStageTrl', FKConstraintType='C', IsToolbarButton='N', IsUpdateable='N',Updated=TO_TIMESTAMP('2014-03-24 09:03:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211168
;

-- Mar 24, 2014 9:03:40 AM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_CSalesStageTrl', FKConstraintType='N', IsAllowCopy='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2014-03-24 09:03:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211162
;

-- Mar 24, 2014 9:03:40 AM CET
CREATE TABLE C_SalesStage_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, C_SalesStage_ID NUMERIC(10) NOT NULL, C_SalesStage_Trl_UU VARCHAR(36) DEFAULT NULL , Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_SalesStage_Trl_Key PRIMARY KEY (AD_Language, C_SalesStage_ID), CONSTRAINT C_SalesStage_Trl_UU_idx UNIQUE (C_SalesStage_Trl_UU))
;

-- Mar 24, 2014 9:03:41 AM CET
ALTER TABLE C_SalesStage_Trl ADD CONSTRAINT ADClient_CSalesStageTrl FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2014 9:03:41 AM CET
ALTER TABLE C_SalesStage_Trl ADD CONSTRAINT ADLanguage_CSalesStageTrl FOREIGN KEY (AD_Language) REFERENCES AD_LANGUAGE(AD_LANGUAGE) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2014 9:03:41 AM CET
ALTER TABLE C_SalesStage_Trl ADD CONSTRAINT ADOrg_CSalesStageTrl FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2014 9:03:41 AM CET
ALTER TABLE C_SalesStage_Trl ADD CONSTRAINT CreatedBy_CSalesStageTrl FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2014 9:03:41 AM CET
ALTER TABLE C_SalesStage_Trl ADD CONSTRAINT CSalesStage_CSalesStageTrl FOREIGN KEY (C_SalesStage_ID) REFERENCES C_SALESSTAGE(C_SALESSTAGE_ID) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2014 9:03:41 AM CET
ALTER TABLE C_SalesStage_Trl ADD CONSTRAINT UpdatedBy_CSalesStageTrl FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 24, 2014 9:03:59 AM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,211168,0,200134,'4bfef99a-78a8-4b17-872d-ab7950d0c7a5',200124,53154,TO_TIMESTAMP('2014-03-24 09:03:58','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','N','N','Y','N','Y','Translation','N',30,1,TO_TIMESTAMP('2014-03-24 09:03:58','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2014 9:04:01 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211156,202816,'ff0488e7-e947-4811-ba0d-a4fb7e91b946',0,200134,2,TO_TIMESTAMP('2014-03-24 09:04:01','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_TIMESTAMP('2014-03-24 09:04:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2014 9:04:02 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211157,202817,'de4036ba-9e3e-4dc8-96ac-a496a8bde0ae',0,200134,2,TO_TIMESTAMP('2014-03-24 09:04:01','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','Organization',20,TO_TIMESTAMP('2014-03-24 09:04:01','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Mar 24, 2014 9:04:02 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211166,202818,'40f97dee-3386-4a8e-8aea-84610af19d2a',0,200134,5,TO_TIMESTAMP('2014-03-24 09:04:02','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',30,TO_TIMESTAMP('2014-03-24 09:04:02','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2014 9:04:02 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211165,202819,'0984c47a-6a3b-49ec-92af-134cc611d1be',0,200134,5,TO_TIMESTAMP('2014-03-24 09:04:02','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',255,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',40,TO_TIMESTAMP('2014-03-24 09:04:02','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2014 9:04:03 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211163,202820,'0b18568a-bda9-47ed-8c7d-9623a4421498',0,200134,2,TO_TIMESTAMP('2014-03-24 09:04:02','YYYY-MM-DD HH24:MI:SS'),100,'Language for this entity',6,'D','The Language identifies the language to use for display and formatting','Y','Y','Y','N','N','N','N','N','Language',50,TO_TIMESTAMP('2014-03-24 09:04:02','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2014 9:04:03 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211164,202821,'a742bd4b-0372-4aca-a1a3-d107de1a547e',0,200134,2,TO_TIMESTAMP('2014-03-24 09:04:03','YYYY-MM-DD HH24:MI:SS'),100,'This column is translated',1,'D','The Translated checkbox indicates if this column is translated.','Y','Y','Y','N','N','N','N','N','Translated',60,TO_TIMESTAMP('2014-03-24 09:04:03','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 24, 2014 9:04:04 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211167,202822,'860942a1-df87-4eaa-93e8-609bcd0a9aa6',0,200134,2,TO_TIMESTAMP('2014-03-24 09:04:03','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','C_SalesStage_Trl_UU',70,TO_TIMESTAMP('2014-03-24 09:04:03','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2014 9:04:04 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211168,202823,'aca37eda-3151-4cd6-bad5-a239c0119104',0,200134,2,TO_TIMESTAMP('2014-03-24 09:04:04','YYYY-MM-DD HH24:MI:SS'),100,'Stages of the sales process',22,'D','Define what stages your sales process will move through','Y','Y','Y','N','N','N','N','N','Sales Stage',80,TO_TIMESTAMP('2014-03-24 09:04:04','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 24, 2014 9:04:04 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211160,202824,'7c055e01-6f14-4a59-80ce-3ba2a4c4794d',0,200134,2,TO_TIMESTAMP('2014-03-24 09:04:04','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',90,TO_TIMESTAMP('2014-03-24 09:04:04','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Mar 24, 2014 9:04:38 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2014-03-24 09:04:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202823
;

-- Mar 24, 2014 9:04:38 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=1,Updated=TO_TIMESTAMP('2014-03-24 09:04:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202820
;

-- Mar 24, 2014 9:04:38 AM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2014-03-24 09:04:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202824
;

-- Mar 24, 2014 9:04:38 AM CET
UPDATE AD_Field SET ColumnSpan=1, IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2014-03-24 09:04:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202821
;

-- Mar 24, 2014 9:04:38 AM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2014-03-24 09:04:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202818
;

-- Mar 24, 2014 9:04:38 AM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2014-03-24 09:04:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202819
;

-- Mar 24, 2014 9:04:38 AM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-24 09:04:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202822
;

-- Mar 24, 2014 9:04:49 AM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-03-24 09:04:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202820
;

-- Mar 24, 2014 9:05:10 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202824
;

-- Mar 24, 2014 9:05:10 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202823
;

-- Mar 24, 2014 9:05:10 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202817
;

-- Mar 24, 2014 9:05:10 AM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202820
;

-- Mar 24, 2014 9:05:10 AM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202818
;

-- Mar 24, 2014 9:05:10 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202819
;

-- Mar 24, 2014 9:05:10 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202821
;

