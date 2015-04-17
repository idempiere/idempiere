SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2558:don't allow use old password when change password
-- Apr 6, 2015 1:54:49 AM ICT
UPDATE AD_Field SET IsActive='N',Updated=TO_DATE('2015-04-06 01:54:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200080
;
SELECT register_migration_script('201504061604-IDEMPIERE-2558.sql') FROM dual
;

