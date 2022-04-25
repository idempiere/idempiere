SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 11, 2022, 4:40:02 PM CET
UPDATE AD_Form SET Name='Accounting Fact Reconciliation (manual)',Updated=TO_DATE('2022-02-11 16:40:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=53016
;

-- Feb 11, 2022, 4:40:03 PM CET
UPDATE AD_Menu SET Name='Accounting Fact Reconciliation (manual)', Description=NULL, IsActive='Y',Updated=TO_DATE('2022-02-11 16:40:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53289
;

SELECT register_migration_script('202202111643_IDEMPIERE-4788.sql') FROM dual;
