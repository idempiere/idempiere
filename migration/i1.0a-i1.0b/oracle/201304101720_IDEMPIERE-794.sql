-- Apr 10, 2013 5:13:51 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=271,Updated=TO_DATE('2013-04-10 17:13:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=204815
;

-- Apr 10, 2013 5:14:38 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=290,Updated=TO_DATE('2013-04-10 17:14:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=204935
;

-- Apr 12, 2013 8:04:22 PM COT
-- IDEMPIERE-794 Ticket #1001025 - Expand the views to provide more information
UPDATE AD_Column SET AD_Reference_Value_ID=200037, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-04-12 20:04:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=204935
;

SELECT register_migration_script('201304101720_IDEMPIERE-794.sql') FROM dual
;

