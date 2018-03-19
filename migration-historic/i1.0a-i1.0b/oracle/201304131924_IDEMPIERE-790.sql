-- Apr 13, 2013 7:23:49 PM COT
-- IDEMPIERE-790 Voiding PO should unlink SO it was created from
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2013-04-13 19:23:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55322
;

-- Apr 13, 2013 7:24:14 PM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2013-04-13 19:24:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55323
;

SELECT register_migration_script('201304131924_IDEMPIERE-790.sql') FROM dual
;

