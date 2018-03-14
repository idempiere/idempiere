-- Feb 4, 2015 8:41:37 AM COT
-- IDEMPIERE-2410 Add Phase parameter to Generate PO from Project process
UPDATE AD_Process SET Updated=TO_TIMESTAMP('2015-02-04 08:43:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=225
;

-- Feb 4, 2015 8:43:14 AM COT
UPDATE AD_Process_Para SET SeqNo=40,Updated=TO_TIMESTAMP('2015-02-04 08:43:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=367
;

-- Feb 4, 2015 8:43:14 AM COT
UPDATE AD_Process_Para SET SeqNo=30,Updated=TO_TIMESTAMP('2015-02-04 08:43:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=354
;

-- Feb 4, 2015 8:43:15 AM COT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200117,0,0,'Y',TO_TIMESTAMP('2015-02-04 08:43:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-04 08:43:14','YYYY-MM-DD HH24:MI:SS'),100,'Project Phase','Phase of a Project',225,20,19,'N',165,10,'N','C_ProjectPhase_ID','Y','D',2073,'aed3df93-775d-4f37-9b17-160d6288de79','N')
;

SELECT register_migration_script('201502040847_IDEMPIERE-2410.sql') FROM dual
;

