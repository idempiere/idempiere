-- IDEMPIERE-6533
SELECT register_migration_script('202505071237_IDEMPIERE-6533.sql') FROM dual;

-- May 7, 2025, 12:37:44 PM WIB
INSERT INTO AD_Form (AD_Form_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Classname,AccessLevel,EntityType,IsBetaFunctionality,AD_Form_UU) VALUES (200020,0,0,'Y',TO_TIMESTAMP('2025-05-07 12:37:43','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-05-07 12:37:43','YYYY-MM-DD HH24:MI:SS'),10,'Account Info','org.adempiere.webui.acct.WAcctViewer','3','D','N','63f4a62e-79bd-442e-becf-4f8f0fbb7594')
;

