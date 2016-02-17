-- IDEMPIERE-2985 : Recurring : implement Payment
-- Dec 23, 2015 2:43:32 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200345,'Payment',282,'P',0,0,'Y',TO_TIMESTAMP('2015-12-23 14:43:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-12-23 14:43:31','YYYY-MM-DD HH24:MI:SS'),100,'D','b3e77f8d-0d0d-4bf5-bb42-d998fb0c728c')
;

SELECT register_migration_script('201512231444_IDEMPIERE-2985.sql') FROM dual
;