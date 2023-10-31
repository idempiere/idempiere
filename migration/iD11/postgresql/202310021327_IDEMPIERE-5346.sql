-- IDEMPIERE-5346 SSO Support
SELECT register_migration_script('202310021327_IDEMPIERE-5346.sql') FROM dual;

-- Oct 2, 2023, 1:27:01 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200656,'OpenID Connect',200213,'OIDC',0,0,'Y',TO_TIMESTAMP('2023-10-02 13:27:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-02 13:27:00','YYYY-MM-DD HH24:MI:SS'),100,'D','e1913c90-dcac-4a0d-bd55-dfa3408654e8')
;

