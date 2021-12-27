-- IDEMPIERE-5018 Vendor changed to customer when edited using Quick Entry
-- Oct 27, 2021, 12:54:13 PM CEST
UPDATE AD_Field SET DisplayLogic='@_ParentIsSOTrx_@=N & @C_BPartner_ID@>0 | @_QUICK_ENTRY_MODE_@!Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@_ParentIsSOTrx_@=N & @IsVendor@=Y', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-10-27 12:54:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9623
;

-- Oct 27, 2021, 12:54:47 PM CEST
UPDATE AD_Field SET DisplayLogic='@_ParentIsSOTrx_@=Y & @C_BPartner_ID@>0 | @_QUICK_ENTRY_MODE_@!Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@_ParentIsSOTrx_@=Y & @IsCustomer@=Y', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-10-27 12:54:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9614
;

SELECT register_migration_script('202110271258_IDEMPIERE-5018.sql') FROM dual
;

