-- IDEMPIERE-5052 Date Min/Max Validation wrong with 5 digit years
-- Nov 30, 2021, 5:14:36 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=11 | @AD_Reference_ID@=12 | @AD_Reference_ID@=15 | @AD_Reference_ID@=22 | @AD_Reference_ID@=29 | @AD_Reference_ID@=37 | @AD_Reference_ID@=10', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-11-30 17:14:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2574
;

-- Nov 30, 2021, 5:14:41 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=11 | @AD_Reference_ID@=12 | @AD_Reference_ID@=15 | @AD_Reference_ID@=22 | @AD_Reference_ID@=29 | @AD_Reference_ID@=37 | @AD_Reference_ID@=10', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-11-30 17:14:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2573
;

SELECT register_migration_script('202111301716_IDEMPIERE-5052.sql') FROM dual
;

