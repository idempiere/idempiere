-- IDEMPIERE-7231 Support Charge-based posting for manual (non-material) Cost Elements (Burden, Overhead, Resource, Outside Processing)
SELECT register_migration_script('202611252210_IDEMPIERE-7231.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 25, 2026, 10:11:00 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217677,0,'Cost Value','Value with Cost',623,'CostAmt',22,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2026-11-25 22:10:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-25 22:10:59','YYYY-MM-DD HH24:MI:SS'),100,2962,'N','N','D','N','N','N','Y','01a2130b-a56f-7796-bde3-8e088dca0b86','N',0,'N','N','N','N')
;

-- Nov 25, 2026, 10:11:12 PM MYT
ALTER TABLE C_ProjectIssue ADD CostAmt NUMBER DEFAULT NULL 
;

