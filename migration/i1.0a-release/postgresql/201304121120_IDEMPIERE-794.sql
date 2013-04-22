-- Apr 12, 2013 10:41:36 AM COT
UPDATE AD_Column SET AD_Reference_Value_ID=170,Updated=TO_TIMESTAMP('2013-04-12 10:41:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=205479
;

-- Apr 13, 2013 10:53:48 AM COT
-- IDEMPIERE-794 Ticket #1001025 - Expand the views to provide more information
UPDATE AD_Column SET AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 10:53:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=205479
;

SELECT register_migration_script('201304121120_IDEMPIERE-794.sql') FROM dual
;
