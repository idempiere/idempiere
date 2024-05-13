-- IDEMPIERE-5567 Evaluate support of Long ID (FHCA-4195)
SELECT register_migration_script('202302170238_IDEMPIERE-5567.sql') FROM dual;

-- Feb 17, 2023, 2:38:33 AM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200231,'UUID','Universally unique identifier','D',0,0,'Y',TO_TIMESTAMP('2023-02-17 02:38:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-17 02:38:33','YYYY-MM-DD HH24:MI:SS'),100,'D','N','2dbf9d9e-3e83-4927-b737-c1124918402c')
;

-- Mar 13, 2023, 8:42:24 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=13 | @IsKey@=Y',Updated=TO_TIMESTAMP('2023-03-13 20:42:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=161
;

-- Mar 17, 2023, 1:18:24 PM CET
UPDATE AD_Process_Para SET ReadOnlyLogic=NULL,Updated=TO_TIMESTAMP('2023-03-17 13:18:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200361
;

