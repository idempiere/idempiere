SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5132 Enable filling Purchase Order in Material Receipt
-- Dec 29, 2021, 7:26:07 PM CET
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_Order_ID@!0', IsToolbarButton=NULL,Updated=TO_DATE('2021-12-29 19:26:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3490
;

-- Dec 30, 2021, 11:44:51 AM CET
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-12-30 11:44:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3490
;

-- Dec 30, 2021, 12:12:11 PM CET
UPDATE AD_Field SET DisplayLogic=NULL, IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_OrderLine_ID@!0', IsToolbarButton=NULL,Updated=TO_DATE('2021-12-30 12:12:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3521
;

SELECT register_migration_script('202112291927_IDEMPIERE-5132.sql') FROM dual
;

