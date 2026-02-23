-- IDEMPIERE-6387 -  Payment Selection window fails to update amounts and has incorrect field behavior
SELECT register_migration_script('202602051800_IDEMPIERE-6387.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 5, 2026, 6:00:40 PM CET
UPDATE AD_Column SET Callout='org.compiere.model.CalloutPaySelection.amounts',Updated=TO_TIMESTAMP('2026-02-05 18:00:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5640
;

-- Feb 5, 2026, 6:00:47 PM CET
UPDATE AD_Column SET Callout='org.compiere.model.CalloutPaySelection.amounts',Updated=TO_TIMESTAMP('2026-02-05 18:00:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12655
;

-- Feb 5, 2026, 6:00:58 PM CET
UPDATE AD_Column SET Callout='org.compiere.model.CalloutPaySelection.amounts',Updated=TO_TIMESTAMP('2026-02-05 18:00:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212955
;

-- Feb 5, 2026, 6:04:25 PM CET
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2026-02-05 18:04:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12655
;

-- Feb 5, 2026, 6:04:29 PM CET
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2026-02-05 18:04:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212955
;

-- Feb 9, 2026, 2:03:16 PM CET
UPDATE AD_Column SET Callout='org.compiere.model.CalloutPaySelection.amounts', IsUpdateable='Y',Updated=TO_TIMESTAMP('2026-02-09 14:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6221
;

-- Feb 9, 2026, 2:04:30 PM CET
UPDATE AD_Field SET Name='Over/Under Payment', Description='Over-Payment (unallocated) or Under-Payment (partial payment) Amount', Help='Overpayments (negative) are unallocated amounts and allow you to receive money for more than the particular invoice. 
Underpayments (positive) is a partial payment for the invoice. You do not write off the unpaid amount.', IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2026-02-09 14:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4939
;

-- Feb 9, 2026, 2:06:36 PM CET
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_TIMESTAMP('2026-02-09 14:06:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4939
;

-- Feb 9, 2026, 3:18:59 PM CET
UPDATE AD_Column SET DefaultValue='@SQL=SELECT getDate() FROM Dual', SeqNoSelection=10,Updated=TO_TIMESTAMP('2026-02-09 15:18:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5617
;

