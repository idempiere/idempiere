-- Jun 5, 2013 9:55:17 AM COT
-- IDEMPIERE-962  Misspelled words and/or sentences 
UPDATE AD_Tab SET Name='Activity Dimension', Description='Maintain Activity Accounting Dimension Tree',Updated=TO_DATE('2013-06-05 09:55:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=517
;

SELECT register_migration_script('20130605095600_IDEMPIERE-962.sql') FROM dual
;
