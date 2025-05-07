-- 
SELECT register_migration_script('202503041500_IDEMPIERE-6441.sql') FROM dual;

-- Mar 04, 2025, 3:00:39 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204003,0,0,'Y',TO_TIMESTAMP('2025-03-04 14:59:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-04 14:59:19','YYYY-MM-DD HH24:MI:SS'),100,'FallbackRecordsWhenFKNotFound','Fallback Records when FK not found',NULL,'Accept pairs of table=idOrUuid separated by commas.  When there is more than one missing key, the table can also be set as table.foreignUuid=idOrUuid','Fallback Records when FK not found','D','5be4500d-bbab-41e1-964b-59eebf8102c1')
;

-- Mar 04, 2025, 3:00:58 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200495,0,0,'Y',TO_TIMESTAMP('2025-03-04 15:00:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-04 15:00:57','YYYY-MM-DD HH24:MI:SS'),100,'Fallback Records when FK not found','Accept pairs of table=idOrUuid separated by commas.  When there is more than one missing key, the table can also be set as table.foreignUuid=idOrUuid',200110,130,10,'N',4000,'N','FallbackRecordsWhenFKNotFound','Y','D',204003,'47eccf20-1686-49b5-ae35-7717fcbe3574','N','N','D','N')
;

ALTER TABLE t_moveclient ADD identifier VARCHAR(4000) NULL
;

