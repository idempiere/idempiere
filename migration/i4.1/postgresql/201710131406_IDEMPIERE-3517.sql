-- IDEMPIERE-3517 Report Cube - OrgTrx Dimension is not displayed
-- Oct 13, 2017 2:04:42 PM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_OT@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-13 14:04:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2344
;

-- Oct 13, 2017 2:05:12 PM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_AY@=Y ', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-13 14:05:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3886
;

-- Oct 13, 2017 2:05:54 PM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_OT@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-13 14:05:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57023
;

-- Oct 13, 2017 2:06:02 PM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_AY@=Y ', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-13 14:06:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57013
;

SELECT register_migration_script('201710131406_IDEMPIERE-3517.sql') FROM dual
;

