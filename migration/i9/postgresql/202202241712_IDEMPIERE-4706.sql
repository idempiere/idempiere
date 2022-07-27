-- IDEMPIERE-4706 New field "Dynamic Validation (Lookup)" in AD_Column>AD_Val_Rule_Lookup_ID not working
SELECT register_migration_script('202202241712_IDEMPIERE-4706.sql') FROM dual;

-- Feb 24, 2022, 5:12:26 PM CET
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200154,'All Records','S','1=1',0,0,'Y',TO_TIMESTAMP('2022-02-24 17:12:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-02-24 17:12:26','YYYY-MM-DD HH24:MI:SS'),100,'D','0418b1b2-1832-448b-b430-36f28845eb2d')
;

-- Feb 24, 2022, 5:12:39 PM CET
UPDATE AD_Column SET AD_Val_Rule_Lookup_ID=200154,Updated=TO_TIMESTAMP('2022-02-24 17:12:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2202
;

-- Feb 24, 2022, 5:14:33 PM CET
UPDATE AD_Tab SET Parent_Column_ID=187,Updated=TO_TIMESTAMP('2022-02-24 17:14:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200269
;

