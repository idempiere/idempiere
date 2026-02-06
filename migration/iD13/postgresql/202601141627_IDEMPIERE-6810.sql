-- IDEMPIERE-6810 Make Global Document Search Extensible
SELECT register_migration_script('202601141627_IDEMPIERE-6810.sql') FROM dual;

-- Jan 14, 2026, 4:27:15 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=1,Updated=TO_TIMESTAMP('2026-01-14 16:27:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56714
;

-- Jan 14, 2026, 4:27:15 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, XPosition=1,Updated=TO_TIMESTAMP('2026-01-14 16:27:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56717
;

-- Jan 14, 2026, 4:27:15 PM MYT
UPDATE AD_Field SET SeqNo=160, ColumnSpan=2,Updated=TO_TIMESTAMP('2026-01-14 16:27:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208524
;

-- Jan 14, 2026, 4:27:15 PM MYT
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-01-14 16:27:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208525
;

-- Jan 14, 2026, 4:36:53 PM MYT
UPDATE AD_Field SET Description='SQL query or where clause', Help='SELECT SQL query for Query search type, where clause (without the WHERE keyword) for other search type', DisplayLogic=NULL,Updated=TO_TIMESTAMP('2026-01-14 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100,IsCentrallyMaintained='N' WHERE AD_Field_ID=56710
;

