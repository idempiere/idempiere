-- Apr 18, 2013 6:40:49 PM COT
-- IDEMPIERE-851 fitnesse improvements
UPDATE AD_Column SET IsAllowLogging='N',Updated=TO_DATE('2013-04-18 18:40:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5903
;

-- Apr 18, 2013 6:42:14 PM COT
-- IDEMPIERE-851 fitnesse improvements
UPDATE AD_Column SET IsAllowLogging='N',Updated=TO_DATE('2013-04-18 18:42:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11353
;


SELECT register_migration_script('2010304181900_IDEMPIERE-851.sql') FROM dual
;

