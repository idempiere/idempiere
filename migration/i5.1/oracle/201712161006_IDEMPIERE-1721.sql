SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1721 Window Position, tab Remuneration, refers to a disabled window
-- Dec 16, 2017 10:04:11 AM CET
UPDATE AD_Window SET IsActive='Y', IsBetaFunctionality='N',Updated=TO_DATE('2017-12-16 10:04:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=353
;

-- Dec 16, 2017 10:04:11 AM CET
UPDATE AD_Menu SET Name='Remuneration', Description='Maintain Remuneration', IsActive='Y',Updated=TO_DATE('2017-12-16 10:04:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=532
;

SELECT register_migration_script('201712161006_IDEMPIERE-1721.sql') FROM dual
;

