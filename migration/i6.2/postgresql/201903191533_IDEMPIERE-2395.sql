-- IDEMPIERE-2395
-- Mar 19, 2019, 3:24:55 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203300,0,0,'Y',TO_TIMESTAMP('2019-03-19 15:24:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-19 15:24:31','YYYY-MM-DD HH24:MI:SS'),100,'IsCleanChangeLog','Clean Change Log',NULL,NULL,'Clean Change Log','D','c6e68794-2989-4a46-9151-a94a3254cf93')
;

-- Mar 19, 2019, 3:25:19 PM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200269,0,0,'Y',TO_TIMESTAMP('2019-03-19 15:25:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-19 15:25:18','YYYY-MM-DD HH24:MI:SS'),100,'Clean Change Log',200102,10,20,'N',1,'Y','N','IsCleanChangeLog','Y','D',203300,'459a7f88-ec79-47cf-9c7b-7429ac565f55','N')
;

SELECT register_migration_script('201903191533_IDEMPIERE-2395.sql') FROM dual
;

