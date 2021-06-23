SET SQLBLANKLINES ON
SET DEFINE OFF

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- 16-Jun-2021, 10:47:48 PM IST
UPDATE AD_Menu SET PredefinedContextVariables='IgnorePriceListInProductInfo=Y',Updated=TO_DATE('2021-06-16 22:47:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=132
;

-- 16-Jun-2021, 10:48:43 PM IST
UPDATE AD_Menu SET PredefinedContextVariables='IgnorePriceListInProductInfo=Y',Updated=TO_DATE('2021-06-16 22:48:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=181
;

-- 16-Jun-2021, 10:49:37 PM IST
UPDATE AD_Menu SET PredefinedContextVariables='IgnorePriceListInProductInfo=Y',Updated=TO_DATE('2021-06-16 22:49:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=503
;

-- 16-Jun-2021, 10:50:15 PM IST
UPDATE AD_Menu SET PredefinedContextVariables='IgnorePriceListInProductInfo=Y',Updated=TO_DATE('2021-06-16 22:50:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=179
;

SELECT register_migration_script('202106161301_IDEMPIERE-4837.sql') FROM dual
;