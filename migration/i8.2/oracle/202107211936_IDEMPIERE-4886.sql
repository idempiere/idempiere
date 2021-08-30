SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4886 Synchronize multiple columns on ALTER
-- Jul 21, 2021, 7:22:56 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200381,0,0,'Y',TO_DATE('2021-07-21 19:22:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-07-21 19:22:55','YYYY-MM-DD HH24:MI:SS'),100,'Date From','Starting date for a range','The Date From indicates the starting date of a range.',181,10,16,'N',10,'N','@SQL=SELECT MAX(Updated) FROM AD_PInstance WHERE AD_Process_ID=181 AND Record_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Table_ID=@AD_Table_ID@)','DateFrom','Y','D',1581,'ac65ae25-b7bc-4605-9c87-fcc2604f5e1d','N','N')
;

SELECT register_migration_script('202107211936_IDEMPIERE-4886.sql') FROM dual
;

