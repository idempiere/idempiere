-- IDEMPIERE-3961 GL Journal - Switching accounting schema removes PERIOD
-- May 7, 2019, 5:20:41 PM SGT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutGLJournal.acctSchema',Updated=TO_TIMESTAMP('2019-05-07 17:20:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1632
;

SELECT register_migration_script('201905071815_IDEMPIERE-3961.sql') FROM dual
;