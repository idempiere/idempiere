SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4856 Setting an attribute with type reference doesn't work in german
-- Jun 30, 2021, 3:29:43 PM CEST
UPDATE AD_Val_Rule SET Code='AD_Reference.AD_Reference_ID IN (10,11,12,13,14,15,16,17,18,19,20,22,24,25,27,29,30,31,32,33,34,36,37,38,39,40)',Updated=TO_DATE('2021-06-30 15:29:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200090
;

SELECT register_migration_script('202106301531_IDEMPIERE-4856.sql') FROM dual
;

