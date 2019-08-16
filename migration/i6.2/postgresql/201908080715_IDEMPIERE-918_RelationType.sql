-- IDEMPIERE-918 - RelationType
-- 8 August 2019 at  07:10:25 CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200171,'RelType C_Invoice -> C_Invoice (CM)','T',0,0,'Y',TO_TIMESTAMP('2019-08-08 07:10:25','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2019-08-08 07:10:25','YYYY-MM-DD HH24:MI:SS'),0,'D','N','0c256942-4836-4cef-9fb1-e5bb4554aa00')
;

-- 8 August 2019 at  07:10:49 CEST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200171,318,3484,3484,'C_Invoice.RelatedInvoice_ID = @C_Invoice_ID@',0,0,'Y',TO_TIMESTAMP('2019-08-08 07:10:49','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2019-08-08 07:10:49','YYYY-MM-DD HH24:MI:SS'),0,'N','D','93d883dc-5a38-4887-babd-5f691390ea38')
;

-- 8 August 2019 at  07:11:05 CEST
INSERT INTO AD_RelationType (AD_Client_ID,AD_Org_ID,AD_RelationType_ID,Created,CreatedBy,IsActive,Name,Updated,UpdatedBy,AD_Reference_Source_ID,AD_Reference_Target_ID,IsDirected,Type,AD_RelationType_UU) VALUES (0,0,200000,TO_TIMESTAMP('2019-08-08 07:11:04','YYYY-MM-DD HH24:MI:SS'),0,'Y','Invoice -> Credit Memo (using RelatedInvoice_ID field)',TO_TIMESTAMP('2019-08-08 07:11:04','YYYY-MM-DD HH24:MI:SS'),0,200171,200171,'N','I','9c8aec77-a6f5-4154-8d63-5cd285f316b9')
;

SELECT register_migration_script('201908080715_IDEMPIERE-918_RelationType.sql') FROM dual
;