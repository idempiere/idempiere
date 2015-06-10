-- Jun 6, 2015 2:29:41 PM CEST
-- IDEMPIERE-2663 Value of DatePrinted should not be copied when copying a record
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2015-06-06 14:29:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3719
;

-- Jun 6, 2015 2:29:57 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2015-06-06 14:29:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3808
;

-- Jun 6, 2015 2:30:12 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2015-06-06 14:30:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3784
;



SELECT register_migration_script('201506061430_IDEMPIERE-2663.sql') FROM dual
;

