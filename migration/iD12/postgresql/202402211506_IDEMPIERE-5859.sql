-- IDEMPIERE-5859
SELECT register_migration_script('202402211506_IDEMPIERE-5859.sql') FROM dual;

-- Feb 21, 2024, 3:06:22 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200703,'Chosen Multiple Selection List',326,'C',0,0,'Y',TO_TIMESTAMP('2024-02-21 15:06:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-21 15:06:22','YYYY-MM-DD HH24:MI:SS'),100,'D','e596bc0d-980b-4751-8bbf-c7b5fdf20bfa')
;

