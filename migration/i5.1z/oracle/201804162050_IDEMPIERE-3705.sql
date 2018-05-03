SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 16, 2018 8:50:16 PM CEST
-- AP2-15 Define customer or vendor by context when creating new BPs via QuickEntry
UPDATE AD_Menu SET IsSOTrx='Y',Updated=TO_DATE('2018-04-16 20:50:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=328
;

-- Apr 16, 2018 8:50:44 PM CEST
UPDATE AD_Menu SET IsSOTrx='N',Updated=TO_DATE('2018-04-16 20:50:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=335
;

SELECT register_migration_script('201804162050_IDEMPIERE-3705.sql') FROM dual
;
