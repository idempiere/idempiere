-- IDEMPIERE-2869
-- Apr 5, 2020, 6:40:35 PM CEST
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-04-05 18:40:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6429
;

-- Apr 5, 2020, 6:42:56 PM CEST
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-04-05 18:42:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2291
;

SELECT register_migration_script('202004051844_IDEMPIERE-2869.sql') FROM dual
;

