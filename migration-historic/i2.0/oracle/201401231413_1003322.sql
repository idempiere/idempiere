SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 23, 2014 12:54:26 PM SGT
-- 1003322 2Pack enhancement for Extension Development
UPDATE AD_Field SET IsActive='N',Updated=TO_DATE('2014-01-23 12:54:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50152
;

SELECT register_migration_script('201401231413_1003322.sql') FROM dual
;