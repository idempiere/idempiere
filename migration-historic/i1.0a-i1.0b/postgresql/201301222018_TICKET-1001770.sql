-- Jan 22, 2013 3:46:04 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Column SET Callout='org.adempiere.model.CalloutRMA.inoutline',Updated=TO_TIMESTAMP('2013-01-22 15:46:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10829
;

-- Jan 22, 2013 3:46:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Column SET Callout='org.adempiere.model.CalloutRMA.product',Updated=TO_TIMESTAMP('2013-01-22 15:46:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208397
;

-- Jan 22, 2013 3:46:31 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Column SET Callout='org.adempiere.model.CalloutRMA.charge',Updated=TO_TIMESTAMP('2013-01-22 15:46:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=52002
;

SELECT register_migration_script('201301222018_TICKET-1001770.sql') FROM dual
;