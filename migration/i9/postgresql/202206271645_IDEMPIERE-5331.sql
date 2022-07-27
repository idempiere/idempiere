-- IDEMPIERE-5331 Create Production from Order Lines
SELECT register_migration_script('202206271645_IDEMPIERE-5331.sql') FROM dual;

-- Jun 27, 2022, 4:45:47 PM CEST
UPDATE AD_Process SET Name='Create Production from Order Line', Description='Create Production for single ordered product',Updated=TO_TIMESTAMP('2022-06-27 16:45:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200006
;

-- Jun 27, 2022, 4:46:09 PM CEST
UPDATE AD_Process SET Name='Create Shipment from Order Line',Updated=TO_TIMESTAMP('2022-06-27 16:46:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200007
;

-- Jun 27, 2022, 4:46:53 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200138,0,0,'Y',TO_TIMESTAMP('2022-06-27 16:46:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-27 16:46:53','YYYY-MM-DD HH24:MI:SS'),100,'Create Production from Order','Create Production for BOM ordered products','N','C_Order_CreateProduction','N','org.compiere.process.OrderCreateProduction','3','D',0,0,'N','S','N','4d1322d4-df18-4cab-a280-82b1c14f35fd')
;

-- Jun 27, 2022, 4:51:04 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2022-06-27 16:51:04','YYYY-MM-DD HH24:MI:SS'),100,'C_Order_CreateProduction','Y',200122,'C_Order_CreateProduction',TO_TIMESTAMP('2022-06-27 16:51:04','YYYY-MM-DD HH24:MI:SS'),100,'N','9ffb3433-7c04-4d35-bd31-681fa70feb29','W',186,200138,'@SQL=SELECT 1 FROM C_OrderLine ol JOIN M_Product p ON (ol.M_Product_ID=p.M_Product_ID) WHERE ol.C_Order_ID=@C_Order_ID:0@ AND ol.Processed=''Y'' AND p.IsBOM=''Y''',10,'D')
;

