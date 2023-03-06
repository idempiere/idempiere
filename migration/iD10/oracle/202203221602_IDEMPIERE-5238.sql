-- IDEMPIERE-5238
SELECT register_migration_script('202203221602_IDEMPIERE-5238.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 22, 2022, 4:02:23 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200202,'Record ID','D',0,0,'Y',TO_TIMESTAMP('2022-03-22 16:02:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-22 16:02:23','YYYY-MM-DD HH24:MI:SS'),100,'D','N','55330dab-f2b6-499d-af8b-187848c47a40')
;

