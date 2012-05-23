-- Mar 19, 2012 2:15:08 AM AST
-- IDEMPIERE-162 Fix Role Access Update to honour Existing permissions
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,FieldLength,AD_Process_ID,IsCentrallyMaintained,AD_Reference_ID,SeqNo,IsMandatory,DefaultValue,EntityType,Name,ColumnName,Description,IsActive,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID) VALUES ('N',200007,0,295,'Y',20,30,'N','Y','D','Reset Existing Access','ResetAccess','Reset Existing Access','Y',0,100,TO_DATE('2012-03-19 02:15:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-03-19 02:15:08','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Mar 19, 2012 2:15:08 AM AST
-- IDEMPIERE-162 Fix Role Access Update to honour Existing permissions
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200007 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='839_IDEMPIERE-162.sql'
WHERE LastMigrationScriptApplied<'839_IDEMPIERE-162.sql'
   OR LastMigrationScriptApplied IS NULL
;
