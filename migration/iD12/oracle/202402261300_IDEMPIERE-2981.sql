-- IDEMPIERE-2981 - Implement JSON Field type
SELECT register_migration_script('202402261300_IDEMPIERE-2981.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 26, 2024, 1:00:29 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200267,'JSON','JSON format values','D',0,0,'Y',TO_TIMESTAMP('2024-02-26 13:00:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-26 13:00:28','YYYY-MM-DD HH24:MI:SS'),100,'D','N','b6fcc751-edd8-4421-acd0-3cde02a9576d','N')
;

