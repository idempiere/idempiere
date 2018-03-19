-- Jan 25, 2014 2:39:55 PM COT
-- IDEMPIERE-452 Control dates
UPDATE AD_Column SET Callout='org.compiere.model.CalloutEngine.checkPeriodOpen',Updated=TO_TIMESTAMP('2014-01-25 14:39:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3552
;

-- Jan 25, 2014 2:40:28 PM COT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutEngine.checkPeriodOpen',Updated=TO_TIMESTAMP('2014-01-25 14:40:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3579
;

-- Jan 25, 2014 2:40:49 PM COT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutEngine.checkPeriodOpen',Updated=TO_TIMESTAMP('2014-01-25 14:40:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3608
;

-- Jan 25, 2014 2:41:13 PM COT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutEngine.checkPeriodOpen',Updated=TO_TIMESTAMP('2014-01-25 14:41:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14527
;

SELECT register_migration_script('201401251441_IDEMPIERE-452.sql') FROM dual
;

