-- IDEMPIERE-7053: Synchronize column Account_ID on T_TrialBalance table not working
SELECT register_migration_script('202606261347_IDEMPIERE-7053.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

ALTER TABLE T_TrialBalance DROP CONSTRAINT t_trialbalance_pkey
;

-- Jun 26, 2026, 1:47:30 PM IST
UPDATE AD_Column SET FKConstraintName=NULL, FKConstraintType='D', IsMandatory='Y', Updated=TO_TIMESTAMP('2026-06-26 13:47:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12996
;

-- Jun 26, 2026, 1:47:33 PM IST
ALTER TABLE T_TrialBalance MODIFY Account_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 26, 2026, 1:48:17 PM IST
UPDATE AD_Column SET FKConstraintType='D',Updated=TO_TIMESTAMP('2026-06-26 13:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12976
;

-- Jun 26, 2026, 1:48:19 PM IST
ALTER TABLE T_TrialBalance MODIFY C_BPartner_ID NUMBER(10) DEFAULT NULL 
;

ALTER TABLE t_trialbalance ADD CONSTRAINT t_trialbalance_pkey PRIMARY KEY (ad_pinstance_id, fact_acct_id, account_id, ad_org_id)
;
