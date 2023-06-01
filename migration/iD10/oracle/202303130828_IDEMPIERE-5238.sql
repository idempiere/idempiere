-- IDEMPIERE-5238
SELECT register_migration_script('202303130828_IDEMPIERE-5238.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 13, 2023, 8:28:48 AM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200232,'AD_Table Name','T',0,0,'Y',TO_TIMESTAMP('2023-03-13 08:28:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-13 08:28:47','YYYY-MM-DD HH24:MI:SS'),100,'D','N','c8dfa020-36ce-47c8-b273-6c9ad5053def','N')
;

-- Mar 13, 2023, 8:30:01 AM CET
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200232,100,100,102,0,0,'Y',TO_TIMESTAMP('2023-03-13 08:30:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-13 08:30:01','YYYY-MM-DD HH24:MI:SS'),100,'N','D','5d66cd09-46f0-4085-9460-7e79b270100b')
;

