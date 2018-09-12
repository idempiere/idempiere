-- Mar 26, 2018 12:53:01 PM CEST
-- IDEMPIERE-3705 Define customer or vendor by context when creating new BPs via QuickEntry
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, IsQuickEntry='Y', AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-03-26 12:53:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9614
;

-- Mar 26, 2018 12:53:05 PM CEST
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, IsQuickEntry='Y', AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-03-26 12:53:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9623
;

-- Mar 26, 2018 12:53:10 PM CEST
UPDATE AD_Field SET DisplayLogic='@_QUICK_ENTRY_MODE_@!Y', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-03-26 12:53:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9614
;

-- Mar 26, 2018 12:53:13 PM CEST
UPDATE AD_Field SET DisplayLogic='@_QUICK_ENTRY_MODE_@!Y', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-03-26 12:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9623
;

SELECT register_migration_script('201803261255_IDEMPIERE-3705.sql') FROM dual
;
