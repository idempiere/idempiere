-- Jul 17, 2013 1:10:17 PM COT
-- IDEMPIERE-347 passwords hash
UPDATE AD_Column SET ReadOnlyLogic='@AD_User_ID@=0',Updated=TO_DATE('2013-07-17 13:10:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=417
;

SELECT register_migration_script('201307171313_IDEMPIERE-347.sql') FROM dual
;

