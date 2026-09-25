-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603241146_IDEMPIERE-6908.sql') FROM dual;

-- Mar 24, 2026, 11:46:09 AM GMT+08:00
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200764,'Error','Installation or activation failed',200284,'ER',0,0,'Y',TO_TIMESTAMP('2026-03-24 11:46:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 11:46:08','YYYY-MM-DD HH24:MI:SS'),100,'D','019d1df3-2dd0-7c21-a87c-d00d343d0128')
;

-- Mar 24, 2026, 11:46:45 AM GMT+08:00
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200765,'Installing','Installation is in progress',200284,'IP',0,0,'Y',TO_TIMESTAMP('2026-03-24 11:46:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 11:46:44','YYYY-MM-DD HH24:MI:SS'),100,'D','019d1df3-b89c-7632-a50f-6a31fd6561cb')
;

