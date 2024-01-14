-- IDEMPIERE-5991 log type for file download
SELECT register_migration_script('202401121109_IDEMPIERE-5991.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 12, 2024, 11:09:19 AM ICT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (nextidfunc(11,'N'),'FilePath','File path for download',200242,'F',0,0,'Y',TO_TIMESTAMP('2024-01-12 11:09:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-12 11:09:19','YYYY-MM-DD HH24:MI:SS'),100,'D','34c47b72-da68-4e87-a207-6bc75634b62e')
;

