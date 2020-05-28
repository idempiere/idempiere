SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4245 Set GL Category automatically for GL Journal
-- Apr 22, 2020, 8:05:30 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutGLJournal.docType',Updated=TO_DATE('2020-04-22 20:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1625
;

-- Apr 22, 2020, 8:16:34 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutGLJournal.docType',Updated=TO_DATE('2020-04-22 20:16:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10760
;

SELECT register_migration_script('202004222017_IDEMPIERE-4245.sql') FROM dual
;

