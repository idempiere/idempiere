-- IDEMPIERE-5295 Trial Balance Report creates wrong Opening Balance + IDEMPIERE-5523
SELECT register_migration_script('202212231121_IDEMPIERE-5295.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 23, 2022, 11:21:17 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203776,0,0,'Y',TO_TIMESTAMP('2022-12-23 11:21:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-23 11:21:17','YYYY-MM-DD HH24:MI:SS'),100,'T_TrialBalance_UU','T_TrialBalance_UU','T_TrialBalance_UU','D','894664e1-e97e-4327-84a7-6df464a387ef')
;

-- Dec 23, 2022, 11:21:18 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215730,1.0,'T_TrialBalance_UU',753,'T_TrialBalance_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-12-23 11:21:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-23 11:21:17','YYYY-MM-DD HH24:MI:SS'),100,203776,'Y','N','D','N','ea2b4818-490a-4a29-9795-a1967c3fb31a','N')
;

-- Dec 23, 2022, 11:21:18 AM CET
ALTER TABLE T_TrialBalance ADD T_TrialBalance_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Dec 23, 2022, 11:21:18 AM CET
ALTER TABLE T_TrialBalance ADD CONSTRAINT T_TrialBalance_UU_idx UNIQUE (T_TrialBalance_UU)
;

