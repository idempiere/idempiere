SET SQLBLANKLINES ON
SET DEFINE OFF

-- 30/10/2013 12:11:00 PM COT
-- IDEMPIERE-1443 leadconversion - can't translate
UPDATE AD_Field SET IsAllowCopy='N',Updated=TO_DATE('2013-10-30 12:11:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62137
;

-- 30/10/2013 12:12:23 PM COT
-- IDEMPIERE-1443 leadconversion - can't translate
UPDATE AD_Field SET IsAllowCopy='N',Updated=TO_DATE('2013-10-30 12:12:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62149
;

SELECT register_migration_script('201310301212_IDEMPIERE-1443.sql') FROM dual
;

