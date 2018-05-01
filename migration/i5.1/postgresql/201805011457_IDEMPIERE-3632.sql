-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
-- May 1, 2018 7:55:19 AM COT
UPDATE AD_Column SET AD_Reference_ID=14,Updated=TO_TIMESTAMP('2018-05-01 07:55:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3376
;

-- May 1, 2018 7:56:13 AM COT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-05-01 07:56:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7543
;

-- May 1, 2018 7:56:38 AM COT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-05-01 07:56:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2577
;

SELECT register_migration_script('201805011457_IDEMPIERE-3632.sql') FROM dual
;

