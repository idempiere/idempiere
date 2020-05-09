SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4283 QuickInfo showing the wrong orders by default on Generate PO from Sales Order
-- May 9, 2020, 6:34:13 PM CEST
UPDATE AD_Menu SET IsSOTrx='Y',Updated=TO_DATE('2020-05-09 18:34:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=335
;

SELECT register_migration_script('202005091838_IDEMPIERE-4283.sql') FROM dual
;
