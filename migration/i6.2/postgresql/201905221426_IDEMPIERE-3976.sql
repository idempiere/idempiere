-- IDEMPIERE-3976 Scheduler in System cannot be assigned to a valid Supervisor (FHCA-963)
-- May 22, 2019, 2:25:16 PM CEST
UPDATE AD_Ref_Table SET WhereClause='(AD_User.AD_Client_ID=0 AND (AD_User.AD_User_ID=0 OR @#AD_Client_ID@=0)) OR EXISTS (SELECT * FROM C_BPartner bp WHERE AD_User.C_BPartner_ID=bp.C_BPartner_ID AND (bp.IsEmployee=''Y'' OR bp.IsSalesRep=''Y''))',Updated=TO_TIMESTAMP('2019-05-22 14:25:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=316
;

SELECT register_migration_script('201905221426_IDEMPIERE-3976.sql') FROM dual
;

