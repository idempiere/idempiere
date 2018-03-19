-- Jun 20, 2013 4:54:19 PM COT
-- IDEMPIERE-1084 Quote Convert - Conversion to to-many documents
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Description,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Org_ID,IsActive,AD_Client_ID) VALUES ('C_DocType.DocBaseType=''SOO'' AND C_DocType.DocSubTypeSO NOT IN (''OB'',''ON'',''RM'')',200045,'D','C_DocType Quote Convert','Target Document Types for Quote Convert','S','82d2bc56-2dff-42af-bcfc-3a74f345e7b1',100,100,TO_DATE('2013-06-20 16:54:17','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-06-20 16:54:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Jun 20, 2013 4:54:26 PM COT
-- IDEMPIERE-1084 Quote Convert - Conversion to to-many documents
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200045,Updated=TO_DATE('2013-06-20 16:54:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=375
;

SELECT register_migration_script('201306201723_IDEMPIERE-1084.sql') FROM dual
;

