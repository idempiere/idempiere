-- IDEMPIERE-1963 Implement Generate Shipments (manual) as Info Window
SELECT register_migration_script('202207191251_IDEMPIERE-1963.sql') FROM dual;

-- Jul 19, 2022, 12:51:13 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200162,'List - DocAction - Complete, Prepare or None','S','AD_Ref_List.Value IN (''CO'',''PR'',''--'')',0,0,'Y',TO_TIMESTAMP('2022-07-19 12:51:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 12:51:12','YYYY-MM-DD HH24:MI:SS'),100,'D','e352deb6-cef5-4ede-ad2b-189463190c0d')
;

-- Jul 19, 2022, 12:55:40 PM CEST
UPDATE AD_InfoWindow SET IsShowInDashboard='N',Updated=TO_TIMESTAMP('2022-07-19 12:55:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200008
;

-- Jul 19, 2022, 12:56:36 PM CEST
UPDATE AD_Form SET IsActive='N',Updated=TO_TIMESTAMP('2022-07-19 12:56:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=110
;

-- Jul 19, 2022, 12:56:36 PM CEST
UPDATE AD_Menu SET Name='Generate Shipments (manual)', Description='Select and generate shipments', IsActive='N',Updated=TO_TIMESTAMP('2022-07-19 12:56:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=346
;

-- Jul 19, 2022, 12:59:21 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='@#M_Warehouse_ID@',Updated=TO_TIMESTAMP('2022-07-19 12:59:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200117
;

-- Jul 19, 2022, 12:59:54 PM CEST
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200162,FieldLength=2,Updated=TO_TIMESTAMP('2022-07-19 12:59:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200394
;

-- Jul 19, 2022, 1:12:52 PM CEST
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200162,Updated=TO_TIMESTAMP('2022-07-19 13:12:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200397
;
