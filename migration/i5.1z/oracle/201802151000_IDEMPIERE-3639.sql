SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3639 Placeholders for every fields
-- Feb 15, 2018 8:42:55 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203163,0,0,'Y',TO_DATE('2018-02-15 08:42:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:42:54','YYYY-MM-DD HH24:MI:SS'),100,'Placeholder','Placeholder','Placeholder','D','dce47a52-1044-4ee0-aad3-31ae2325d1ec')
;

-- Feb 15, 2018 8:43:09 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203164,0,0,'Y',TO_DATE('2018-02-15 08:43:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:43:08','YYYY-MM-DD HH24:MI:SS'),100,'Placeholder2','Placeholder2','Placeholder2','D','5581e7dc-7238-49f5-91bc-cf8cd1184951')
;

-- Feb 15, 2018 8:43:20 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203165,0,0,'Y',TO_DATE('2018-02-15 08:43:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:43:19','YYYY-MM-DD HH24:MI:SS'),100,'PlaceholderAddress1','PlaceholderAddress1','PlaceholderAddress1','D','ac2963f4-53c6-4871-ae28-3db51ca45644')
;

-- Feb 15, 2018 8:43:34 AM CET
UPDATE AD_Element SET Name='Placeholder for Address 1', PrintName='Placeholder for Address 1',Updated=TO_DATE('2018-02-15 08:43:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203165
;

-- Feb 15, 2018 8:43:34 AM CET
UPDATE AD_Column SET ColumnName='PlaceholderAddress1', Name='Placeholder for Address 1', Description=NULL, Help=NULL WHERE AD_Element_ID=203165
;

-- Feb 15, 2018 8:43:35 AM CET
UPDATE AD_Process_Para SET ColumnName='PlaceholderAddress1', Name='Placeholder for Address 1', Description=NULL, Help=NULL, AD_Element_ID=203165 WHERE UPPER(ColumnName)='PLACEHOLDERADDRESS1' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 15, 2018 8:43:35 AM CET
UPDATE AD_Process_Para SET ColumnName='PlaceholderAddress1', Name='Placeholder for Address 1', Description=NULL, Help=NULL WHERE AD_Element_ID=203165 AND IsCentrallyMaintained='Y'
;

-- Feb 15, 2018 8:43:35 AM CET
UPDATE AD_InfoColumn SET ColumnName='PlaceholderAddress1', Name='Placeholder for Address 1', Description=NULL, Help=NULL WHERE AD_Element_ID=203165 AND IsCentrallyMaintained='Y'
;

-- Feb 15, 2018 8:43:35 AM CET
UPDATE AD_Field SET Name='Placeholder for Address 1', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203165) AND IsCentrallyMaintained='Y'
;

-- Feb 15, 2018 8:43:35 AM CET
UPDATE AD_PrintFormatItem SET PrintName='Placeholder for Address 1', Name='Placeholder for Address 1' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203165)
;

-- Feb 15, 2018 8:43:44 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203166,0,0,'Y',TO_DATE('2018-02-15 08:43:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:43:44','YYYY-MM-DD HH24:MI:SS'),100,'PlaceholderAddress2','Placeholder for Address 2','Placeholder for Address 2','D','0d9f6ef8-1c1c-47c2-a38a-8f2ce36f3d06')
;

-- Feb 15, 2018 8:43:54 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203167,0,0,'Y',TO_DATE('2018-02-15 08:43:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:43:54','YYYY-MM-DD HH24:MI:SS'),100,'PlaceholderAddress3','Placeholder for Address 3','Placeholder for Address 3','D','e80ab5ac-1e28-4f71-a8b3-e93902d7c11f')
;

-- Feb 15, 2018 8:44:05 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203168,0,0,'Y',TO_DATE('2018-02-15 08:44:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:44:04','YYYY-MM-DD HH24:MI:SS'),100,'PlaceholderAddress4','Placeholder for Address 4','Placeholder for Address 4','D','3fba6866-ce9f-4e90-a2be-3d21b533ffbd')
;

-- Feb 15, 2018 8:44:13 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203169,0,0,'Y',TO_DATE('2018-02-15 08:44:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:44:13','YYYY-MM-DD HH24:MI:SS'),100,'PlaceholderAddress5','Placeholder for Address 5','Placeholder for Address 5','D','d3389e94-d9f7-464a-8666-6b02b5c2f645')
;

-- Feb 15, 2018 8:44:29 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203170,0,0,'Y',TO_DATE('2018-02-15 08:44:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:44:29','YYYY-MM-DD HH24:MI:SS'),100,'PlaceholderComments','Placeholder for comments','Placeholder for comments','D','91ad32f2-f434-4144-b114-64f5634dbbaa')
;

-- Feb 15, 2018 8:44:43 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203171,0,0,'Y',TO_DATE('2018-02-15 08:44:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:44:42','YYYY-MM-DD HH24:MI:SS'),100,'PlaceholderCity','Placeholder for city','Placeholder for city','U','2fd28347-9a06-47e3-8007-faeb45e06396')
;

-- Feb 15, 2018 8:44:56 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203172,0,0,'Y',TO_DATE('2018-02-15 08:44:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:44:56','YYYY-MM-DD HH24:MI:SS'),100,'PlaceholderPostal','Placeholder for postal','Placeholder for postal','D','127bbca7-f8d0-4c63-87ca-852b6a12c9df')
;

-- Feb 15, 2018 8:45:27 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203173,0,0,'Y',TO_DATE('2018-02-15 08:45:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:45:27','YYYY-MM-DD HH24:MI:SS'),100,'PlaceholderPostal_Add','Placeholder for additional zip','Placeholder for additional zip','D','da7a5677-cc49-4070-8480-2b4ef5dc3392')
;

-- Feb 15, 2018 8:45:49 AM CET
UPDATE AD_Element SET EntityType='D',Updated=TO_DATE('2018-02-15 08:45:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203171
;

-- Feb 15, 2018 8:47:44 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213357,0,'Placeholder',101,'Placeholder',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:47:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:47:43','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','eb0d7055-6d11-4901-8e58-fcc8ee80194a','Y',0,'N','N')
;

-- Feb 15, 2018 8:47:47 AM CET
ALTER TABLE AD_Column ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:48:14 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213358,0,'Placeholder',752,'Placeholder',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:48:14','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','dfb286ad-882f-4515-b05e-af9a0921a792','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:48:16 AM CET
ALTER TABLE AD_Column_Trl ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:48:47 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213359,0,'Placeholder',276,'Placeholder',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:48:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:48:46','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','fb0ce9bc-7f3c-4185-9ceb-7cf1c7274410','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:48:49 AM CET
ALTER TABLE AD_Element ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:49:09 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213360,0,'Placeholder',277,'Placeholder',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:49:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:49:09','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','a1c3acd3-e6ca-4e10-b59c-6fc3b5761871','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:49:11 AM CET
ALTER TABLE AD_Element_Trl ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:49:45 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213361,0,'Placeholder',107,'Placeholder',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:49:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:49:44','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','35a9f1a5-53bc-407a-83e2-05af0c3b14a9','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:49:46 AM CET
ALTER TABLE AD_Field ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:50:13 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213362,0,'Placeholder',127,'Placeholder',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:50:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:50:12','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','2c8ff064-9e42-4716-ac2a-1ff96b484b55','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:50:14 AM CET
ALTER TABLE AD_Field_Trl ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:50:58 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213363,0,'Placeholder',897,'Placeholder',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:50:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:50:58','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','7a2c11bc-eb8b-4f30-9a49-04e8c09c506f','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:50:59 AM CET
ALTER TABLE AD_InfoColumn ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:51:17 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213364,0,'Placeholder',898,'Placeholder',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:51:17','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','7c4eb0dd-f8ae-4812-a49f-5e1a4bcf3db1','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:51:18 AM CET
ALTER TABLE AD_InfoColumn_Trl ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:51:48 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213365,0,'Placeholder',464,'Placeholder',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:51:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:51:48','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','6f31b87a-c166-4e3a-b85b-ee4044ba6eec','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:51:50 AM CET
ALTER TABLE AD_UserDef_Field ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:52:20 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213366,0,'Placeholder for Address 1',170,'PlaceholderAddress1',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:52:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:52:20','YYYY-MM-DD HH24:MI:SS'),100,203165,'Y','N','D','N','N','N','Y','641e8ab2-f015-4a7c-a824-1f38c5123534','Y',0,'N','N')
;

-- Feb 15, 2018 8:52:22 AM CET
ALTER TABLE C_Country ADD PlaceholderAddress1 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:52:32 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213367,0,'Placeholder for Address 2',170,'PlaceholderAddress2',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:52:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:52:32','YYYY-MM-DD HH24:MI:SS'),100,203166,'Y','N','D','N','N','N','Y','726d955d-52d6-4c3b-9c42-51e6123ca86b','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:52:33 AM CET
ALTER TABLE C_Country ADD PlaceholderAddress2 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:52:45 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213368,0,'Placeholder for Address 3',170,'PlaceholderAddress3',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:52:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:52:45','YYYY-MM-DD HH24:MI:SS'),100,203167,'Y','N','D','N','N','N','Y','07fa2411-fb82-4322-be08-bfe58c976ba6','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:52:46 AM CET
ALTER TABLE C_Country ADD PlaceholderAddress3 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:52:56 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213369,0,'Placeholder for Address 4',170,'PlaceholderAddress4',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:52:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:52:56','YYYY-MM-DD HH24:MI:SS'),100,203168,'Y','N','D','N','N','N','Y','254221bc-c76e-4e4f-85a2-eb5b50bda85b','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:52:57 AM CET
ALTER TABLE C_Country ADD PlaceholderAddress4 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:53:08 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213370,0,'Placeholder for Address 5',170,'PlaceholderAddress5',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:53:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:53:08','YYYY-MM-DD HH24:MI:SS'),100,203169,'Y','N','D','N','N','N','Y','2f540f08-6cdc-4a05-961b-5818c20172f0','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:53:10 AM CET
ALTER TABLE C_Country ADD PlaceholderAddress5 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:53:31 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213371,0,'Placeholder for city',170,'PlaceholderCity',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:53:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:53:31','YYYY-MM-DD HH24:MI:SS'),100,203171,'Y','N','D','N','N','N','Y','fb51c3d1-fcb8-4282-96ae-98d0bafb4dd0','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:53:32 AM CET
ALTER TABLE C_Country ADD PlaceholderCity NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:53:45 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213372,0,'Placeholder for comments',170,'PlaceholderComments',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:53:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:53:45','YYYY-MM-DD HH24:MI:SS'),100,203170,'Y','N','D','N','N','N','Y','ff8b7786-ab0b-4e86-bfe5-564f0bc35e21','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:53:47 AM CET
ALTER TABLE C_Country ADD PlaceholderComments NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:54:02 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213373,0,'Placeholder for postal',170,'PlaceholderPostal',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:54:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:54:01','YYYY-MM-DD HH24:MI:SS'),100,203172,'Y','N','D','N','N','N','Y','32f1504c-f59e-4657-8a43-b21add9a2915','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:54:03 AM CET
ALTER TABLE C_Country ADD PlaceholderPostal NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:54:13 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213374,0,'Placeholder for additional zip',170,'PlaceholderPostal_Add',255,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:54:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:54:12','YYYY-MM-DD HH24:MI:SS'),100,203173,'Y','N','D','N','N','N','Y','92b89177-2ca5-422d-977b-21eb132610b1','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:54:14 AM CET
ALTER TABLE C_Country ADD PlaceholderPostal_Add NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:55:13 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213375,0,'Placeholder for Address 1',616,'PlaceholderAddress1',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:55:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:55:12','YYYY-MM-DD HH24:MI:SS'),100,203165,'Y','N','D','N','N','N','Y','5ca70d51-ce73-46bc-8031-603ac3a3f302','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:55:14 AM CET
ALTER TABLE C_Country_Trl ADD PlaceholderAddress1 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:55:24 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213376,0,'Placeholder for Address 2',616,'PlaceholderAddress2',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:55:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:55:23','YYYY-MM-DD HH24:MI:SS'),100,203166,'Y','N','D','N','N','N','Y','3f8f686b-04b2-41d0-979d-3813810cc157','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:55:25 AM CET
ALTER TABLE C_Country_Trl ADD PlaceholderAddress2 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:55:34 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213377,0,'Placeholder for Address 3',616,'PlaceholderAddress3',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:55:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:55:34','YYYY-MM-DD HH24:MI:SS'),100,203167,'Y','N','D','N','N','N','Y','cc9f1306-b930-48b3-bf67-4b63f083b218','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:55:36 AM CET
ALTER TABLE C_Country_Trl ADD PlaceholderAddress3 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:55:54 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213378,0,'Placeholder for Address 4',616,'PlaceholderAddress4',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:55:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:55:54','YYYY-MM-DD HH24:MI:SS'),100,203168,'Y','N','D','N','N','N','Y','a5e26d17-df50-4e01-9dd1-546a35d8a418','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:55:55 AM CET
ALTER TABLE C_Country_Trl ADD PlaceholderAddress4 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:56:07 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213379,0,'Placeholder for Address 5',616,'PlaceholderAddress5',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:56:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:56:07','YYYY-MM-DD HH24:MI:SS'),100,203169,'Y','N','D','N','N','N','Y','150bad59-84a6-412c-9bb6-14c30a7939b4','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:56:08 AM CET
ALTER TABLE C_Country_Trl ADD PlaceholderAddress5 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:56:29 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213380,0,'Placeholder for city',616,'PlaceholderCity',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:56:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:56:28','YYYY-MM-DD HH24:MI:SS'),100,203171,'Y','N','D','N','N','N','Y','8a87fbe6-cc60-46b7-b52b-2aae034ae268','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:56:30 AM CET
ALTER TABLE C_Country_Trl ADD PlaceholderCity NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:56:39 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213381,0,'Placeholder for comments',616,'PlaceholderComments',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:56:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:56:39','YYYY-MM-DD HH24:MI:SS'),100,203170,'Y','N','D','N','N','N','Y','40d89415-4bfc-4c05-b873-9041bc3c06d9','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:56:41 AM CET
ALTER TABLE C_Country_Trl ADD PlaceholderComments NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:56:53 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213382,0,'Placeholder for postal',616,'PlaceholderPostal',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:56:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:56:53','YYYY-MM-DD HH24:MI:SS'),100,203172,'Y','N','D','N','N','N','Y','80b14333-e1f6-4f21-b6d9-750808aa8b11','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:56:55 AM CET
ALTER TABLE C_Country_Trl ADD PlaceholderPostal NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:57:04 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213383,0,'Placeholder for additional zip',616,'PlaceholderPostal_Add',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:57:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:57:03','YYYY-MM-DD HH24:MI:SS'),100,203173,'Y','N','D','N','N','N','Y','8cdf49b6-8ed3-436f-b495-5ece1128e672','Y',0,'N','N','N')
;

-- IDEMPIERE-3639 Placeholders for every fields
-- Feb 17, 2018 8:39:48 PM CET
ALTER TABLE C_Country_Trl ADD PlaceholderPostal_Add NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:58:25 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213384,0,'Placeholder',285,'Placeholder',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:58:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:58:25','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','1129bac4-8bcf-452f-857d-cd5a14288b66','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:58:27 AM CET
ALTER TABLE AD_Process_Para ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:58:36 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213385,0,'Placeholder2',285,'Placeholder2',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:58:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:58:35','YYYY-MM-DD HH24:MI:SS'),100,203164,'Y','N','U','N','N','N','Y','e8bba41c-fd44-4bff-920c-d381b7ff666d','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:58:37 AM CET
ALTER TABLE AD_Process_Para ADD Placeholder2 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:59:09 AM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_DATE('2018-02-15 08:59:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213384
;

-- Feb 15, 2018 8:59:13 AM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_DATE('2018-02-15 08:59:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213385
;

-- Feb 15, 2018 8:59:33 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213386,0,'Placeholder',286,'Placeholder',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:59:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:59:32','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','N','N','Y','d44d88ca-c081-4db5-846e-b15df94f696e','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:59:34 AM CET
ALTER TABLE AD_Process_Para_Trl ADD Placeholder NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 8:59:44 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213387,0,'Placeholder2',286,'Placeholder2',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2018-02-15 08:59:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 08:59:44','YYYY-MM-DD HH24:MI:SS'),100,203164,'Y','N','U','N','N','N','Y','6a5439ee-1a4a-4609-b80f-2e5d3d76976d','Y',0,'N','N','N')
;

-- Feb 15, 2018 8:59:45 AM CET
ALTER TABLE AD_Process_Para_Trl ADD Placeholder2 NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 15, 2018 9:00:04 AM CET
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2018-02-15 09:00:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213387
;

-- Feb 15, 2018 9:00:20 AM CET
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2018-02-15 09:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213385
;

-- Feb 15, 2018 9:02:58 AM CET
INSERT INTO AD_FieldGroup (AD_FieldGroup_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,EntityType,FieldGroupType,IsCollapsedByDefault,AD_FieldGroup_UU) VALUES (200022,0,0,'Y',TO_DATE('2018-02-15 09:02:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:02:57','YYYY-MM-DD HH24:MI:SS'),100,'Placeholders','D','L','N','3b18e724-14b5-4df0-9dc1-315761a531ed')
;

-- Feb 15, 2018 9:04:00 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205316,'Placeholder for Address 1',135,213366,'Y',255,290,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:04:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:04:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2d72ff23-4287-4cf5-b731-62e98d84de77','Y',290,5)
;

-- Feb 15, 2018 9:04:01 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205317,'Placeholder for Address 2',135,213367,'Y',255,300,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:04:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:04:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2dcfb87f-45b4-41a6-a4e3-a8dcd25c518f','Y',300,5)
;

-- Feb 15, 2018 9:04:01 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205318,'Placeholder for Address 3',135,213368,'Y',255,310,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:04:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:04:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','784ffbe1-cfbc-4b4f-824a-4e8d9c9f5cce','Y',310,5)
;

-- Feb 15, 2018 9:04:02 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205319,'Placeholder for Address 4',135,213369,'Y',255,320,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:04:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:04:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d6c0fe5e-7228-4590-9009-d7036dff9f4d','Y',320,5)
;

-- Feb 15, 2018 9:04:02 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205320,'Placeholder for Address 5',135,213370,'Y',255,330,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:04:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:04:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7f88e47e-5b03-45c1-823f-b7b2d9f84712','Y',330,5)
;

-- Feb 15, 2018 9:04:02 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205321,'Placeholder for city',135,213371,'Y',255,340,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:04:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:04:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f54ade3b-264e-4f76-8baf-5dd5ccf9b579','Y',340,5)
;

-- Feb 15, 2018 9:04:03 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205322,'Placeholder for comments',135,213372,'Y',255,350,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:04:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:04:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4bfa37bc-a311-4a16-9a00-a5344d91360c','Y',350,5)
;

-- Feb 15, 2018 9:04:03 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205323,'Placeholder for postal',135,213373,'Y',255,360,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:04:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:04:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9830db56-12f2-4732-bd17-881c7bcaf9cd','Y',360,5)
;

-- Feb 15, 2018 9:04:04 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205324,'Placeholder for additional zip',135,213374,'Y',255,370,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:04:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:04:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e1fb8a9a-5c59-43f3-a578-c81d150fa880','Y',370,5)
;

-- Feb 15, 2018 9:05:30 AM CET
UPDATE AD_Field SET SeqNo=290, AD_FieldGroup_ID=200022, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205316
;

-- Feb 15, 2018 9:05:30 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205317
;

-- Feb 15, 2018 9:05:30 AM CET
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205318
;

-- Feb 15, 2018 9:05:30 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205319
;

-- Feb 15, 2018 9:05:30 AM CET
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205320
;

-- Feb 15, 2018 9:05:30 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205323
;

-- Feb 15, 2018 9:05:30 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205324
;

-- Feb 15, 2018 9:05:31 AM CET
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:05:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205321
;

-- Feb 15, 2018 9:05:31 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:05:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205322
;

-- Feb 15, 2018 9:05:31 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:05:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204713
;

-- Feb 15, 2018 9:06:15 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205325,'Placeholder for Address 1',549,213375,'Y',255,110,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:06:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:06:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fdc49fce-a794-42e0-b924-94ab9b952973','Y',110,5)
;

-- Feb 15, 2018 9:06:15 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205326,'Placeholder for Address 2',549,213376,'Y',255,120,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:06:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:06:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e8346316-55ba-48e1-8311-b3b0ed69984a','Y',120,5)
;

-- Feb 15, 2018 9:06:16 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205327,'Placeholder for Address 3',549,213377,'Y',255,130,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:06:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:06:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3cddf8dc-4811-4448-b991-fd7463cdaee2','Y',130,5)
;

-- Feb 15, 2018 9:06:16 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205328,'Placeholder for Address 4',549,213378,'Y',255,140,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:06:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:06:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0d6c6f00-53a6-4f90-8b5a-8818005a4553','Y',140,5)
;

-- Feb 15, 2018 9:06:16 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205329,'Placeholder for Address 5',549,213379,'Y',255,150,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:06:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:06:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','83bea2ba-067f-4e25-9f70-1a90b2b4a4e5','Y',150,5)
;

-- Feb 15, 2018 9:06:17 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205330,'Placeholder for city',549,213380,'Y',255,160,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:06:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:06:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9d9846cd-ce14-4772-8e98-675badf9a002','Y',160,5)
;

-- Feb 15, 2018 9:06:17 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205331,'Placeholder for comments',549,213381,'Y',255,170,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:06:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:06:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ab6e777c-abc0-47af-b117-639d167dbee9','Y',170,5)
;

-- Feb 15, 2018 9:06:18 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205332,'Placeholder for postal',549,213382,'Y',255,180,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:06:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:06:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b387e623-b9fc-4fc9-b11a-1d3d206835a6','Y',180,5)
;

-- Feb 15, 2018 9:06:18 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205333,'Placeholder for additional zip',549,213383,'Y',255,190,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:06:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:06:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','81ff4669-f77c-49f8-8b4a-31878481d517','Y',190,5)
;

-- Feb 15, 2018 9:07:20 AM CET
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7839
;

-- Feb 15, 2018 9:07:20 AM CET
UPDATE AD_Field SET SeqNo=100, AD_FieldGroup_ID=200022, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205325
;

-- Feb 15, 2018 9:07:21 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205326
;

-- Feb 15, 2018 9:07:21 AM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205327
;

-- Feb 15, 2018 9:07:21 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205328
;

-- Feb 15, 2018 9:07:21 AM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205329
;

-- Feb 15, 2018 9:07:21 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205332
;

-- Feb 15, 2018 9:07:21 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205333
;

-- Feb 15, 2018 9:07:21 AM CET
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205330
;

-- Feb 15, 2018 9:07:21 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205331
;

-- Feb 15, 2018 9:07:21 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:07:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204714
;

-- Feb 15, 2018 9:07:55 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205334,'Placeholder',203,213359,'Y',255,150,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:07:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:07:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','67ddd45a-3085-41d9-a687-9f06bdfe78c1','Y',150,5)
;

-- Feb 15, 2018 9:08:04 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205335,'Placeholder',204,213360,'Y',255,150,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:08:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:08:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6ba5a4ec-4143-4ff7-a8a9-0044cb990221','Y',150,5)
;

-- Feb 15, 2018 9:08:19 AM CET
UPDATE AD_Field SET SeqNo=10, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1396
;

-- Feb 15, 2018 9:08:19 AM CET
UPDATE AD_Field SET SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2061
;

-- Feb 15, 2018 9:08:19 AM CET
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1397
;

-- Feb 15, 2018 9:08:19 AM CET
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1400
;

-- Feb 15, 2018 9:08:19 AM CET
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3270
;

-- Feb 15, 2018 9:08:19 AM CET
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1398
;

-- Feb 15, 2018 9:08:19 AM CET
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1401
;

-- Feb 15, 2018 9:08:19 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205334
;

-- Feb 15, 2018 9:08:19 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204483
;

-- Feb 15, 2018 9:08:19 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1395
;

-- Feb 15, 2018 9:08:28 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205335
;

-- Feb 15, 2018 9:08:28 AM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4952
;

-- Feb 15, 2018 9:08:29 AM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4953
;

-- Feb 15, 2018 9:08:29 AM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4950
;

-- Feb 15, 2018 9:08:29 AM CET
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4951
;

-- Feb 15, 2018 9:08:29 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:08:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204484
;

-- Feb 15, 2018 9:14:41 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205336,'Placeholder',844,213363,'Y',255,270,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:14:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:14:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aa7adaeb-420a-4e44-9518-70d9579befa8','Y',180,5)
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205336
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13592
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13596
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13602
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201626
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203049
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201719
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203471
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201720
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203048
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201635
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;

-- Feb 15, 2018 9:15:12 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204520
;

-- Feb 15, 2018 9:15:24 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205337,'Placeholder',845,213364,'Y',255,90,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:15:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:15:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','172ffca9-c73a-425f-a390-6bdbfac7d1cf','Y',90,5)
;

-- Feb 15, 2018 9:15:33 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205337
;

-- Feb 15, 2018 9:15:33 AM CET
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13615
;

-- Feb 15, 2018 9:15:33 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:15:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204521
;

-- Feb 15, 2018 9:16:27 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205338,'Placeholder',246,213384,'Y',255,280,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:16:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:16:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5ecfe138-3f2d-40a9-8cef-bb5670c7be9f','Y',280,5)
;

-- Feb 15, 2018 9:16:28 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205339,'Placeholder2',246,213385,'Y',255,290,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:16:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:16:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5b02ac45-a289-4ad8-a916-5f15a8effc6b','Y',290,5)
;

-- Feb 15, 2018 9:16:35 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205340,'Placeholder',247,213386,'Y',255,100,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:16:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:16:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dee1dcaf-925a-4a0b-8eed-ffcee2994aa2','Y',100,5)
;

-- Feb 15, 2018 9:16:36 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205341,'Placeholder2',247,213387,'Y',255,110,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:16:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:16:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fed60d9a-e212-4f49-b30e-1df78c9b4541','Y',110,5)
;

-- Feb 15, 2018 9:17:22 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205338
;

-- Feb 15, 2018 9:17:22 AM CET
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2543
;

-- Feb 15, 2018 9:17:22 AM CET
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4576
;

-- Feb 15, 2018 9:17:22 AM CET
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2547
;

-- Feb 15, 2018 9:17:22 AM CET
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5817
;

-- Feb 15, 2018 9:17:22 AM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3110
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5818
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2539
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2540
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2907
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2901
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2903
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200097
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2904
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2544
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205339
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2902
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4398
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2906
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2905
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56333
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56334
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204372
;

-- Feb 15, 2018 9:17:23 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204570
;

-- Feb 15, 2018 9:17:32 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:17:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204571
;

-- Feb 15, 2018 9:18:03 AM CET
UPDATE AD_Field SET DisplayLogic='@IsRange@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:18:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205339
;

-- Feb 15, 2018 9:18:17 AM CET
UPDATE AD_Field SET DisplayLogic='@IsRange@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:18:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205341
;

-- Feb 15, 2018 9:18:57 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205342,'Placeholder',101,213357,'Y',255,480,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:18:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:18:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dea75868-1cb0-49bf-ad39-157ff2e477ba','Y',450,5)
;

-- Feb 15, 2018 9:19:06 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205343,'Placeholder',681,213358,'Y',255,80,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:19:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:19:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4dc74c03-4d53-40ef-af7e-e47ccc5c49b7','Y',80,5)
;

-- Feb 15, 2018 9:19:17 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205343
;

-- Feb 15, 2018 9:19:17 AM CET
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10938
;

-- Feb 15, 2018 9:19:17 AM CET
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10935
;

-- Feb 15, 2018 9:19:17 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204482
;

-- Feb 15, 2018 9:19:35 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205342
;

-- Feb 15, 2018 9:19:35 AM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=250
;

-- Feb 15, 2018 9:19:35 AM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=155
;

-- Feb 15, 2018 9:19:35 AM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=158
;

-- Feb 15, 2018 9:19:35 AM CET
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=170
;

-- Feb 15, 2018 9:19:36 AM CET
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=172
;

-- Feb 15, 2018 9:19:36 AM CET
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56374
;

-- Feb 15, 2018 9:19:36 AM CET
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=310
;

-- Feb 15, 2018 9:19:36 AM CET
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2526
;

-- Feb 15, 2018 9:19:36 AM CET
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204220
;

-- Feb 15, 2018 9:19:36 AM CET
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Feb 15, 2018 9:19:36 AM CET
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:19:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56279
;

-- Feb 15, 2018 9:19:57 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205344,'Placeholder',395,213365,'Y',255,310,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:19:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:19:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2619ebb7-01d4-426c-9475-09f0abe31fc9','Y',300,5)
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205344
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5044
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5050
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5053
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5052
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5056
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5055
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11252
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200857
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200850
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200853
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204215
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204216
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200858
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200856
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200855
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204221
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5054
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200849
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200851
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200852
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203499
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200854
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5051
;

-- Feb 15, 2018 9:20:13 AM CET
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
;

-- Feb 15, 2018 9:20:31 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205345,'Placeholder',107,213361,'Y',255,450,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:20:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:20:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','94aae929-609b-4c67-9c02-4ee911ce4d17','Y',420,5)
;

-- Feb 15, 2018 9:20:41 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205346,'Placeholder',115,213362,'Y',255,100,'N','N','N','N',0,0,'Y',TO_DATE('2018-02-15 09:20:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-02-15 09:20:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','31fe042c-03cc-446f-b9a3-3e08756c9bbc','Y',100,5)
;

-- Feb 15, 2018 9:21:00 AM CET
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=127
;

-- Feb 15, 2018 9:21:00 AM CET
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=128
;

-- Feb 15, 2018 9:21:00 AM CET
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=129
;

-- Feb 15, 2018 9:21:00 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205345
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=130
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5808
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4259
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1551
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6432
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=132
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200276
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200771
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59620
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=924
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=133
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59621
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=137
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200274
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=138
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202362
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=142
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8343
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=140
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202341
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=141
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- Feb 15, 2018 9:21:01 AM CET
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204213
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204214
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203500
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Feb 15, 2018 9:21:02 AM CET
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

-- Feb 15, 2018 9:21:10 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-02-15 09:21:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204511
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=1396
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2061
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=1395
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=1397
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=1400
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=3270
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=1398
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=1401
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=205334
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=1399
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=5127
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=4948
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=4949
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=4946
;

-- Feb 15, 2018 9:24:38 AM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=4947
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=1404
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2069
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=1402
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=1403
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=1405
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=1409
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=1406
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=3271
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=1407
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=1408
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=205335
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=4952
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=4953
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=4950
;

-- Feb 15, 2018 9:24:49 AM CET
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=4951
;

-- Feb 15, 2018 9:25:16 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=205336
;

-- Feb 15, 2018 9:25:16 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201636
;

-- Feb 15, 2018 9:25:16 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201635
;

-- Feb 15, 2018 9:25:16 AM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=201719
;

-- Feb 15, 2018 9:25:16 AM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=201720
;

-- Feb 15, 2018 9:25:16 AM CET
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=203048
;

-- Feb 15, 2018 9:25:16 AM CET
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=203049
;

-- Feb 15, 2018 9:25:16 AM CET
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=203471
;

-- Feb 15, 2018 9:25:23 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13608
;

-- Feb 15, 2018 9:25:23 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13614
;

-- Feb 15, 2018 9:25:23 AM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=13611
;

-- Feb 15, 2018 9:25:23 AM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=13612
;

-- Feb 15, 2018 9:25:23 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=13613
;

-- Feb 15, 2018 9:25:23 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=13610
;

-- Feb 15, 2018 9:25:23 AM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=13609
;

-- Feb 15, 2018 9:25:23 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=205337
;

-- Feb 15, 2018 9:25:23 AM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=13615
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2535
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2536
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2538
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=2537
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=2546
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=2541
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=2542
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=205338
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=2543
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=5817
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=4576
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=2547
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=3110
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=5818
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=2539
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=2540
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=2907
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=2901
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=200097
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=2903
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=2904
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=2544
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=2902
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=4398
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=2906
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=2905
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=56333
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=56334
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=204372
;

-- Feb 15, 2018 9:25:52 AM CET
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=205339
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=205342
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=250
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=155
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=158
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=170
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=172
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=310
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=56279
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=56374
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=2526
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=200648
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=171
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=2574
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=2573
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=160
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=161
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=162
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=166
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=2370
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=169
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=10128
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=4941
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=50188
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=168
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=159
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=825
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=4940
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=204220
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=167
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=5121
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=56317
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=62467
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y' WHERE AD_Field_ID=202518
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y' WHERE AD_Field_ID=202519
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=420,IsDisplayedGrid='Y' WHERE AD_Field_ID=5122
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=430,IsDisplayedGrid='Y' WHERE AD_Field_ID=200288
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=440,IsDisplayedGrid='Y' WHERE AD_Field_ID=202257
;

-- Feb 15, 2018 9:26:26 AM CET
UPDATE AD_Field SET SeqNoGrid=450,IsDisplayedGrid='Y' WHERE AD_Field_ID=59619
;

-- Feb 15, 2018 9:26:35 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=10939
;

-- Feb 15, 2018 9:26:35 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=10933
;

-- Feb 15, 2018 9:26:35 AM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=10936
;

-- Feb 15, 2018 9:26:35 AM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=10934
;

-- Feb 15, 2018 9:26:35 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=10937
;

-- Feb 15, 2018 9:26:35 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=205343
;

-- Feb 15, 2018 9:26:35 AM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=10938
;

-- Feb 15, 2018 9:26:35 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=10935
;

-- Feb 15, 2018 9:26:58 AM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=205344
;

-- Feb 15, 2018 9:26:58 AM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=5050
;

-- Feb 15, 2018 9:26:58 AM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=5051
;

-- Feb 15, 2018 9:26:58 AM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=5052
;

-- Feb 15, 2018 9:26:58 AM CET
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=5053
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=5054
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=5056
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=5057
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200857
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=200850
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=5055
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=11252
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=200853
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=200858
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=200856
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=200855
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=200849
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=200851
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=200852
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=200854
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=204215
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=204216
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=204221
;

-- Feb 15, 2018 9:26:59 AM CET
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=203499
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=6432
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=205345
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=274
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=130
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=5808
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=4259
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=1551
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=132
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200276
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=924
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=133
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=136
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=142
;

-- Feb 15, 2018 9:27:13 AM CET
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=59620
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=59621
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=137
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=200274
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=139
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=202362
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=138
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=8343
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=140
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=141
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=202341
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=13425
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=54401
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=54402
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=13424
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=62468
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=200771
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=53280
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=200837
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=200350
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=200348
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=200838
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y' WHERE AD_Field_ID=200834
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y' WHERE AD_Field_ID=200349
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=420,IsDisplayedGrid='Y' WHERE AD_Field_ID=200835
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=430,IsDisplayedGrid='Y' WHERE AD_Field_ID=200836
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=440,IsDisplayedGrid='Y' WHERE AD_Field_ID=204213
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=450,IsDisplayedGrid='Y' WHERE AD_Field_ID=203500
;

-- Feb 15, 2018 9:27:14 AM CET
UPDATE AD_Field SET SeqNoGrid=460,IsDisplayedGrid='Y' WHERE AD_Field_ID=204214
;

CREATE OR REPLACE VIEW ad_field_v AS
 SELECT t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, f.name, f.description, f.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, COALESCE(f.VFormat, c.VFormat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid, f.seqnogrid, c.seqnoselection, f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, c.formatpattern, f.isadvancedfield, f.isdefaultfocus, c.ad_chart_id, f.ad_labelstyle_id, f.ad_fieldstyle_id, c.pa_dashboardcontent_id, COALESCE(f.placeholder, c.placeholder) AS placeholder
   FROM ad_field f
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

CREATE OR REPLACE VIEW ad_field_vt AS
 SELECT trl.ad_language, t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, trl.name, trl.description, trl.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, COALESCE(f.VFormat, c.VFormat) AS VFormat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable, COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fgt.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid, f.seqnogrid, c.seqnoselection, f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, c.formatpattern, f.isadvancedfield, f.isdefaultfocus, c.ad_chart_id, f.ad_labelstyle_id, f.ad_fieldstyle_id, c.pa_dashboardcontent_id, COALESCE(trl.placeholder, ct.placeholder) AS placeholder
   FROM ad_field f
   JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language = fgt.ad_language
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   LEFT JOIN ad_column_trl ct ON f.ad_column_id = ct.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y' AND c.isactive = 'Y'
;

update ad_process_para set placeholder = (select msgtext from ad_message where ad_message_id = 200438) where isrange='Y';

update ad_process_para set placeholder2 = (select msgtext from ad_message where ad_message_id = 200439) where isrange='Y';

update ad_process_para_trl set placeholder = (select msgtext from ad_message_trl where ad_message_id = 200438 and ad_process_para_trl.ad_language = ad_message_trl.ad_language) where ad_process_para_id in (select ad_process_para_id from ad_process_para where isrange='Y');

update ad_process_para_trl set placeholder2 = (select msgtext from ad_message_trl where ad_message_id = 200439 and ad_process_para_trl.ad_language = ad_message_trl.ad_language) where ad_process_para_id in (select ad_process_para_id from ad_process_para where isrange='Y');

SELECT register_migration_script('201802151000_IDEMPIERE-3639.sql') FROM dual
;
