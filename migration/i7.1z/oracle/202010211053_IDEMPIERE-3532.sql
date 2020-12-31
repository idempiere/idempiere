SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3532 Remove hardcoded values for InfoInvoiceWindow (BPartnerID / IsSOTrx) and InfoPaymentWindow (IsSOTrx)
-- Oct 21, 2020, 10:47:33 AM CEST
UPDATE AD_InfoColumn SET DefaultValue='@SQL=SELECT CASE ''@IsSOTrx:X@'' WHEN ''X'' THEN '''' WHEN ''N'' THEN ''Y'' ELSE ''N'' END AS DefaultValue FROM DUAL',Updated=TO_DATE('2020-10-21 10:47:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200037
;

SELECT register_migration_script('202010211053_IDEMPIERE-3532.sql') FROM dual
;

