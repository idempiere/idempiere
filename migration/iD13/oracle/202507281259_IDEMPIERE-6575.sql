-- IDEMPIERE-6575
SELECT register_migration_script('202507281259_IDEMPIERE-6575.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 28, 2025, 12:59:31 PM CEST
UPDATE AD_Tab SET DisplayLogic='@StartNewYear@=''Y'' | @IsOrgLevelSequence@=Y | @Prefix@ ~ ''.*/K.*'' | @Suffix@ ~ ''.*/K.*''',Updated=TO_TIMESTAMP('2025-07-28 12:59:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200001
;

