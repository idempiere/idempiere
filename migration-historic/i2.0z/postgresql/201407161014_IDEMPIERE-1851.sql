-- Mar 24, 2014 2:07:01 PM CET
-- https://idempiere.atlassian.net/browse/IDEMPIERE-1851
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Process_ID,AD_Reference_Value_ID) VALUES ('N',1682,200076,'e9ad57d5-86b3-45a1-bd01-6b4079b31a10','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',18,'N','D','Entity Type','EntityType','Dictionary Entity Type; Determines ownership and synchronization',0,'Y',10,'Y',100,TO_TIMESTAMP('2014-03-24 14:07:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-03-24 14:07:00','YYYY-MM-DD HH24:MI:SS'),0,'N',0,174,389)
;

-- Mar 24, 2014 2:08:12 PM CET
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Process_ID) VALUES ('N',200077,'5cc8670c-0715-4351-9c5e-760f902f6ef6',16,'N','D','CreatedSince','CreatedSince',7,'N',20,'Y',100,TO_TIMESTAMP('2014-03-24 14:08:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-03-24 14:08:11','YYYY-MM-DD HH24:MI:SS'),0,'N',0,174)
;

-- Mar 24, 2014 2:08:24 PM CET
UPDATE AD_Process_Para SET Name='Created Since',Updated=TO_TIMESTAMP('2014-03-24 14:08:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200077
;

SELECT register_migration_script('201407161014_IDEMPIERE-1851.sql') FROM dual
;

