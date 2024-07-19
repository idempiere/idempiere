-- IDEMPIERE-5382 Allow just one MFA registration per mechanism (FHCA-3822)
SELECT register_migration_script('202208112323_IDEMPIERE-5382.sql') FROM dual;

-- Aug 11, 2022, 11:23:34 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200163,'MFA_Method not registered by user','S','NOT EXISTS (SELECT 1 FROM MFA_Registration r WHERE r.AD_User_ID=@#AD_User_ID@ AND r.MFA_Method_ID=MFA_Method.MFA_Method_ID AND IsValid=''Y'' AND AD_Client_ID IN (0,@#AD_Client_ID@) AND IsActive=''Y'')',0,0,'Y',TO_TIMESTAMP('2022-08-11 23:23:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-11 23:23:32','YYYY-MM-DD HH24:MI:SS'),100,'D','608b9cef-4d8e-4e34-b803-7129422b58b0')
;

-- Aug 11, 2022, 11:23:40 PM CEST
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200163,Updated=TO_TIMESTAMP('2022-08-11 23:23:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200350
;

-- Aug 11, 2022, 11:27:20 PM CEST
UPDATE AD_Column SET SeqNo=3,Updated=TO_TIMESTAMP('2022-08-11 23:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214468
;

-- Aug 11, 2022, 11:27:32 PM CEST
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=1,Updated=TO_TIMESTAMP('2022-08-11 23:27:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214475
;

