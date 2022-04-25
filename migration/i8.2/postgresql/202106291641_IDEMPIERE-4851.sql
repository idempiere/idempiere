-- IDEMPIERE-4851 Tenant Admin can deactivate his own client.
-- Jun 29, 2021, 4:39:25 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2021-06-29 16:39:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=319
;

-- Jun 29, 2021, 4:40:25 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2021-06-29 16:40:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204272
;

SELECT register_migration_script('202106291641_IDEMPIERE-4851.sql') FROM dual
;

