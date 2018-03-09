SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 1, 2018 10:02:34 AM CET
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Val_Rule SET Code='AD_User.AD_Client_ID=@#AD_Client_ID@ AND AD_User.IsLocked=''Y''',Updated=TO_DATE('2018-03-01 10:02:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200067
;

SELECT register_migration_script('201803011003_IDEMPIERE-1800.sql') FROM dual
;

