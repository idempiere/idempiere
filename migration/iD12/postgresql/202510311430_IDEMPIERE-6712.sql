-- IDEMPIERE-6712 Improve algorithm for password hashing and salt (DAD-103)
SELECT register_migration_script('202510311430_IDEMPIERE-6712.sql') FROM dual;

-- Oct 31, 2025, 2:30:12 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200285,0,0,TO_TIMESTAMP('2025-10-31 14:30:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-10-31 14:30:11','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','USER_PASSWORD_HASH_ALGORITHM','PBKDF2','Password hash algorithm. SHA-512, PBKDF2 or Argon2.','D','S','019a38f5-9e1d-787e-9050-17d6b00cfd6c')
;

-- Oct 31, 2025, 2:37:07 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (204021,0,0,'Y',TO_TIMESTAMP('2025-10-31 14:37:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-31 14:37:06','YYYY-MM-DD HH24:MI:SS'),100,'PasswordHashAlgorithm','Password Hash Algorithm','Algorithm use to perform hashing of password','Password Hash Algorithm','D','019a38fb-f295-72b8-9e99-7e605c9ed89a')
;

-- Oct 31, 2025, 2:38:49 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (204022,0,0,'Y',TO_TIMESTAMP('2025-10-31 14:38:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-31 14:38:48','YYYY-MM-DD HH24:MI:SS'),100,'SaltAlgorithm','Salt Algorithm','Secure random algorithm use to generate password salt','Salt Algorithm','D','019a38fd-80fe-7fd0-bd63-90d20ee4350f')
;

-- Oct 31, 2025, 2:40:21 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217165,0,'Password Hash Algorithm','Algorithm use to perform hashing of password',114,'PasswordHashAlgorithm',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-10-31 14:40:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-31 14:40:20','YYYY-MM-DD HH24:MI:SS'),100,204021,'Y','N','D','N','N','N','N','019a38fe-e9a0-7912-9409-fb5111b4609d','N',0,'N','N','N','N')
;

-- Oct 31, 2025, 2:40:50 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217166,0,'Salt Algorithm','Secure random algorithm use to generate password salt',114,'SaltAlgorithm',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-10-31 14:40:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-31 14:40:49','YYYY-MM-DD HH24:MI:SS'),100,204022,'Y','N','D','N','N','N','Y','019a38ff-5a9b-785f-9c96-091d5e8f3c1d','N',0,'N','N','N','N')
;

-- Oct 31, 2025, 2:41:09 PM MYT
UPDATE AD_Column SET IsAllowLogging='Y',Updated=TO_TIMESTAMP('2025-10-31 14:41:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217165
;

-- Oct 31, 2025, 2:42:21 PM MYT
ALTER TABLE AD_User ADD COLUMN PasswordHashAlgorithm VARCHAR(40) DEFAULT NULL 
;

-- Oct 31, 2025, 2:42:30 PM MYT
ALTER TABLE AD_User ADD COLUMN SaltAlgorithm VARCHAR(40) DEFAULT NULL 
;

-- Oct 31, 2025, 2:44:31 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200276,'PasswordHashAlgorithm List','L',0,0,'Y',TO_TIMESTAMP('2025-10-31 14:44:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-31 14:44:30','YYYY-MM-DD HH24:MI:SS'),100,'D','N','019a3902-b9ce-7c1a-b2f9-9b2b0d4e758e','N')
;

-- Oct 31, 2025, 2:44:46 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200739,'SHA-512',200276,'SHA-512',0,0,'Y',TO_TIMESTAMP('2025-10-31 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-31 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,'D','019a3902-f50e-7dea-8b7a-1ecf1f22c82a')
;

-- Oct 31, 2025, 2:45:00 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200740,'PBKDF2',200276,'PBKDF2',0,0,'Y',TO_TIMESTAMP('2025-10-31 14:45:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-31 14:45:00','YYYY-MM-DD HH24:MI:SS'),100,'D','019a3903-2d69-7a70-b7bc-3a77c2e7d17c')
;

-- Oct 31, 2025, 2:45:14 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200741,'Argon2',200276,'Argon2',0,0,'Y',TO_TIMESTAMP('2025-10-31 14:45:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-31 14:45:14','YYYY-MM-DD HH24:MI:SS'),100,'D','019a3903-643d-77f4-bd70-136907779475')
;

-- Oct 31, 2025, 2:45:52 PM MYT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200498,0,0,'Y',TO_TIMESTAMP('2025-10-31 14:45:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-31 14:45:51','YYYY-MM-DD HH24:MI:SS'),100,'Password Hash Algorithm','Algorithm use to perform hashing of password',53259,10,17,200276,'N',40,'Y','PBKDF2','PasswordHashAlgorithm','Y','D',204021,'019a3903-f5e9-7526-a87e-441a8f9fafe9','N','N','D','N')
;

-- Oct 31, 2025, 2:47:25 PM MYT
UPDATE AD_Column SET AD_Reference_ID=17, AD_Reference_Value_ID=200276, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2025-10-31 14:47:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217165
;

