-- IDEMPIERE-6087 Users cannot delete their own User Queries
SELECT register_migration_script('202404041759_IDEMPIERE-6087.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 4, 2024, 5:59:29 PM CEST
UPDATE AD_Tab SET WhereClause='(''@#ShowAdvanced:N@''=''Y'' OR AD_User_ID=@#AD_User_ID@)', OrderByClause='AD_UserQuery.Name', ReadOnlyLogic=NULL,Updated=TO_TIMESTAMP('2024-04-04 17:59:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200275
;

-- Apr 4, 2024, 6:00:09 PM CEST
UPDATE AD_Field SET ReadOnlyLogic='@#ShowAdvanced@=N',Updated=TO_TIMESTAMP('2024-04-04 18:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206303
;

-- Apr 4, 2024, 6:00:13 PM CEST
UPDATE AD_Field SET ReadOnlyLogic='@#ShowAdvanced@=N',Updated=TO_TIMESTAMP('2024-04-04 18:00:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206309
;

-- Apr 4, 2024, 6:00:17 PM CEST
UPDATE AD_Field SET ReadOnlyLogic='@#ShowAdvanced@=N',Updated=TO_TIMESTAMP('2024-04-04 18:00:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206308
;

-- Apr 4, 2024, 6:00:20 PM CEST
UPDATE AD_Field SET ReadOnlyLogic='@#ShowAdvanced@=N',Updated=TO_TIMESTAMP('2024-04-04 18:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206306
;

-- Apr 4, 2024, 6:00:26 PM CEST
UPDATE AD_Field SET ReadOnlyLogic='@#ShowAdvanced@=N',Updated=TO_TIMESTAMP('2024-04-04 18:00:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206304
;

-- Apr 4, 2024, 6:00:35 PM CEST
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_TIMESTAMP('2024-04-04 18:00:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206305
;

