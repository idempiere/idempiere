SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5051 PaymentExportClass must be advanced field
-- Nov 23, 2021, 1:54:33 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@#ShowAdvanced@=N', IsToolbarButton=NULL,Updated=TO_DATE('2021-11-23 13:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=60881
;

SELECT register_migration_script('202111231355_IDEMPIERE-5051.sql') FROM dual
;

