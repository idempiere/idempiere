SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3215 Sales Order/Proposal BP shipper, cause inability to complete
-- Feb 12, 2020, 11:14:32 PM CET
UPDATE AD_Field SET DisplayLogic='@OrderType@=''SO'' | @DeliveryViaRule@=''S'' | @DeliveryViaRule@=''''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-02-12 23:14:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1108
;

-- Feb 12, 2020, 8:59:02 PM CET
UPDATE AD_Field SET DisplayLogic='@DeliveryViaRule@=''S''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-02-12 20:59:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1109
;

-- Feb 12, 2020, 8:59:28 PM CET
UPDATE AD_Field SET DisplayLogic='@DeliveryViaRule@=''S''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-02-12 20:59:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56446
;

SELECT register_migration_script('202002122100_IDEMPIERE-3215.sql') FROM dual
;

