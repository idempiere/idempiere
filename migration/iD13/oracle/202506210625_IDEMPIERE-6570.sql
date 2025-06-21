-- IDEMPIERE-6570 Improve attachment support for large file
SELECT register_migration_script('202506210625_IDEMPIERE-6570.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 21, 2025, 6:25:47 AM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200724,'Database with Large Object Support','Use blob for storage of big file and with lazy loading support',200019,'DB_LOB',0,0,'Y',TO_TIMESTAMP('2025-06-21 06:25:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-21 06:25:47','YYYY-MM-DD HH24:MI:SS'),100,'D','eea57fee-cb78-4344-ac0a-474508616dff')
;

