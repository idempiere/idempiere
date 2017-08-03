-- Jul 21, 2016 5:51:17 PM MYT
-- 1006483 Ease edit of Field label, description and Help
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=204236
;

-- Jul 21, 2016 5:51:17 PM MYT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=204237
;

-- Jul 21, 2016 5:51:17 PM MYT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=204240
;

-- Jul 21, 2016 5:51:17 PM MYT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=204241
;

-- Jul 21, 2016 5:51:17 PM MYT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=204242
;

-- Jul 21, 2016 6:03:18 PM MYT
UPDATE AD_Field SET SeqNo=130, XPosition=2,Updated=TO_TIMESTAMP('2016-07-21 18:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204236
;

-- Jul 21, 2016 6:03:18 PM MYT
UPDATE AD_Field SET SeqNo=140, XPosition=5,Updated=TO_TIMESTAMP('2016-07-21 18:03:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204237
;

SELECT register_migration_script('201607211800_Ticket_1006483.sql') FROM dual
;

