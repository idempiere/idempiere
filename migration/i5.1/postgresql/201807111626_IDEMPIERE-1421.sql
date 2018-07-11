-- IDEMPIERE-1421 Tax Group field is enabled in the window Customer
-- Jul 11, 2018 4:25:37 PM CEST
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-07-11 16:25:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62773
;

SELECT register_migration_script('201807111626_IDEMPIERE-1421.sql') FROM dual
;

