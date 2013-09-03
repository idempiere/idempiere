-- Sep 3, 2013 12:18:09 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=80,Updated=TO_TIMESTAMP('2013-09-03 12:18:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202389
;

-- Sep 3, 2013 12:18:10 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=90,Updated=TO_TIMESTAMP('2013-09-03 12:18:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202390
;

-- Sep 3, 2013 12:18:53 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=240,Updated=TO_TIMESTAMP('2013-09-03 12:18:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202402
;

SELECT register_migration_script('201309031235_IDEMPIERE-1269.sql') FROM dual
;