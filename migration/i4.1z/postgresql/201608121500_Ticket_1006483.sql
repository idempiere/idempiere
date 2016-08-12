-- Aug 12, 2016 4:20:00 PM MYT
-- 1006483 Ease edit of Field label, description and Help
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2016-08-12 16:20:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204236
;

-- Aug 12, 2016 4:20:08 PM MYT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2016-08-12 16:20:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204237
;

SELECT register_migration_script('201608121500_Ticket_1006483.sql') FROM dual
;

