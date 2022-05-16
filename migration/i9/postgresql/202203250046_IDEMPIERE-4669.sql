-- IDEMPIERE-4669 Adding RfQ responses manually is prohibited, because the field for the RfQ is read only
SELECT register_migration_script('202203250046_IDEMPIERE-4669.sql') FROM dual;

-- Mar 25, 2022, 12:46:06 AM CET
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_RfQ_ID@>0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-25 00:46:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9362
;

-- Mar 25, 2022, 12:46:33 AM CET
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_RfQLine_ID@>0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-25 00:46:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9389
;

-- Mar 25, 2022, 12:47:00 AM CET
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_ID=19, ReadOnlyLogic='@C_RfQLineQty_ID@>0',Updated=TO_TIMESTAMP('2022-03-25 00:47:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9407
;

