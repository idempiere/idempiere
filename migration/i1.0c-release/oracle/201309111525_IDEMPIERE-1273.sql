-- Sep 11, 2013 3:25:16 PM COT
-- IDEMPIERE-1273 Invoice Payment Schedule" window isn't suitable
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_DATE('2013-09-11 15:25:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=501
;

-- Sep 11, 2013 3:25:23 PM COT
-- IDEMPIERE-1273 Invoice Payment Schedule" window isn't suitable
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_DATE('2013-09-11 15:25:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=666
;

SELECT register_migration_script('201309111525_IDEMPIERE-1273.sql') FROM dual
;
