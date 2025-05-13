-- IDEMPIERE-6363
SELECT register_migration_script('202412301631_IDEMPIERE-6363.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF


-- Dec 30, 2024, 4:34:34 PM BRT
UPDATE AD_Val_Rule SET Code='M_MatchInv.C_InvoiceLine_ID IN (SELECT C_InvoiceLine.C_InvoiceLine_ID FROM C_InvoiceLine WHERE A_Processed=''Y'')',Updated=TO_TIMESTAMP('2024-12-30 16:34:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52086
;

