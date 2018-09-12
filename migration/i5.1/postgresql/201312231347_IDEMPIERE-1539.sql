-- Dec 23, 2013 1:36:38 PM COT
-- IDEMPIERE-1539
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,EntityType,AD_Client_ID,AD_Org_ID) VALUES (200168,200061,'9562f4db-97a9-4df5-99d0-b2f5bc0e2b4c','Full Like','LIKE',TO_TIMESTAMP('2013-12-23 13:36:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-12-23 13:36:48','YYYY-MM-DD HH24:MI:SS'),100,'Y','D',0,0)
;

SELECT register_migration_script('201312231347_IDEMPIERE-1539.sql') FROM dual
;

