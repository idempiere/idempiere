-- IDEMPIERE-5863 - When copying a BOM product, verified is copied leaving an invalid BOM marked as verified
SELECT register_migration_script('202309221355_IDEMPIERE-5863.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 22, 2023, 1:55:49 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2023-09-22 13:55:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4711
;

