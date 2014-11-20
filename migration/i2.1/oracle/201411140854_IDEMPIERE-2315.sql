SET SQLBLANKLINES ON
SET DEFINE OFF

-- 14/11/2014 08:54:12 AM COT
-- IDEMPIERE-2315 Performance issue: Bill BPartner in Purchase Order as Table (full list)
UPDATE AD_Field SET AD_Reference_ID=30,Updated=TO_DATE('2014-11-14 08:54:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6505
;

SELECT register_migration_script('201411140854_IDEMPIERE-2315.sql') FROM dual
;

