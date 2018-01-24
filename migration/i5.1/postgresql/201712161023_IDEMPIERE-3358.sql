-- IDEMPIERE-3358 Dictionary fixes
-- Dec 16, 2017 10:22:29 AM CET
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-12-16 10:22:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202750
;

-- Dec 16, 2017 10:22:42 AM CET
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-12-16 10:22:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202776
;

SELECT register_migration_script('201712161023_IDEMPIERE-3358.sql') FROM dual
;

