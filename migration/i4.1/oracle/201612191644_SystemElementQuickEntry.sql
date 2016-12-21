SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3272
-- Dec 19, 2016 4:43:42 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsQuickEntry='Y', IsToolbarButton=NULL,Updated=TO_DATE('2016-12-19 16:43:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1397
;

-- Dec 19, 2016 4:43:48 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsQuickEntry='Y', IsToolbarButton=NULL,Updated=TO_DATE('2016-12-19 16:43:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1400
;

-- Dec 19, 2016 4:43:51 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsQuickEntry='Y', IsToolbarButton=NULL,Updated=TO_DATE('2016-12-19 16:43:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3270
;

-- Dec 19, 2016 4:43:55 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsQuickEntry='Y', IsToolbarButton=NULL,Updated=TO_DATE('2016-12-19 16:43:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1398
;

-- Dec 19, 2016 4:43:57 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsQuickEntry='Y', IsToolbarButton=NULL,Updated=TO_DATE('2016-12-19 16:43:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1401
;

-- Dec 19, 2016 4:44:02 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsQuickEntry='Y', IsToolbarButton=NULL,Updated=TO_DATE('2016-12-19 16:44:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5127
;

SELECT register_migration_script('201612191644_SystemElementQuickEntry.sql') FROM dual
;

