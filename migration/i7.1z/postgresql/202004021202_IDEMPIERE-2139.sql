-- IDEMPIERE-2139 Column names (Reserved, Ordered) in window warehouse (tab storage) and product (locator) are not consistent
-- Apr 2, 2020, 11:59:24 AM CEST
UPDATE AD_Window SET IsSOTrx='Y',Updated=TO_TIMESTAMP('2020-04-02 11:59:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=140
;

SELECT register_migration_script('202004021202_IDEMPIERE-2139.sql') FROM dual
;

