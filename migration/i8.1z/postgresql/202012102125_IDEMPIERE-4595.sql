-- IDEMPIERE-4595 Autofill process parameters with smart defaults
-- Dec 10, 2020, 9:19:04 PM CET
UPDATE AD_Column SET Callout='org.compiere.model.Callout_AD_Process_Para.element',Updated=TO_TIMESTAMP('2020-12-10 21:19:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7729
;

-- Dec 10, 2020, 9:19:29 PM CET
UPDATE AD_Column SET Callout='org.compiere.model.Callout_AD_Process_Para.columnName', SeqNoSelection=10,Updated=TO_TIMESTAMP('2020-12-10 21:19:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4017
;

SELECT register_migration_script('202012102125_IDEMPIERE-4595.sql') FROM dual
;

