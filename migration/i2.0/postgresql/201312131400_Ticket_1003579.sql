-- Dec 13, 2013 1:43:47 PM COT
-- Ticket: 1003579 - Improve check for BOM child records with zero quantity
UPDATE AD_Column SET ValueMin='1',Updated=TO_TIMESTAMP('2013-12-13 13:43:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4723
;

SELECT register_migration_script('201312131400_Ticket_1003579.sql') FROM dual
;