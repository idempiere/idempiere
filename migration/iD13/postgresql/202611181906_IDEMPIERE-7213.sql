-- IDEMPIERE-7213 - Allow creation of View Components from an existing Database View (reverse of DatabaseViewValidate)
SELECT register_migration_script('202611181906_IDEMPIERE-7213.sql') FROM dual;

-- Nov 18, 2026, 7:06:52 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200530,0,0,'Y',TO_TIMESTAMP('2026-11-18 19:06:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-18 19:06:51','YYYY-MM-DD HH24:MI:SS'),100,'Remove PostgreSQL casts','Remove the PostgreSQL type casts (::type) so the view definition can be used on Oracle. The process log lists where casts were removed, review them ',200174,30,20,'N',1,'N','Y','IsRemoveCasts','N','D','@#DBType@=PostgreSQL','01a1efd7-12f7-7304-86f6-9754765a0d79','N','N','D','N')
;

-- Nov 18, 2026, 7:07:09 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','PostgreSQL casts removed, review: {0}',0,0,'Y',TO_TIMESTAMP('2026-11-18 19:07:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-18 19:07:09','YYYY-MM-DD HH24:MI:SS'),100,201075,'ViewCastsRemoved','D','01a1efd7-56ad-739d-9fa9-bb581e716022')
;

