-- IDEMPIERE-4474 Automatic calculation of freight charges
-- Sep 25, 2020, 1:14:14 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203440,0,0,'Y',TO_TIMESTAMP('2020-09-25 13:13:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 13:13:58','YYYY-MM-DD HH24:MI:SS'),100,'MaxWeight','Max Weight',NULL,NULL,'Max Weight','D','cb6c78ea-eff8-431e-a693-212a8ae1bec9')
;

-- Sep 25, 2020, 1:15:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214319,0,'Max Weight',596,'MaxWeight',22,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2020-09-25 13:15:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 13:15:19','YYYY-MM-DD HH24:MI:SS'),100,203440,'Y','N','D','N','N','N','Y','f2efc63c-3424-4872-9f0f-1ca4166b3e5e','Y',0,'N','N','N','N')
;

-- Sep 25, 2020, 1:15:52 PM CEST
ALTER TABLE M_Freight ADD COLUMN MaxWeight NUMERIC DEFAULT NULL 
;

-- Sep 25, 2020, 1:16:33 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203441,0,0,'Y',TO_TIMESTAMP('2020-09-25 13:16:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 13:16:22','YYYY-MM-DD HH24:MI:SS'),100,'MaxDimension','Max Dimension',NULL,NULL,'Max Dimension','D','4916f1d7-5192-4007-a3e6-8987923a9806')
;

-- Sep 25, 2020, 1:16:40 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214320,0,'Max Dimension',596,'MaxDimension',22,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2020-09-25 13:16:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 13:16:39','YYYY-MM-DD HH24:MI:SS'),100,203441,'Y','N','D','N','N','N','Y','c3e76f59-2117-413d-ac63-200280af944c','Y',0,'N','N','N','N')
;

-- Sep 25, 2020, 1:16:44 PM CEST
ALTER TABLE M_Freight ADD COLUMN MaxDimension NUMERIC DEFAULT NULL 
;

-- Sep 25, 2020, 1:17:02 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206511,'Max Weight',513,214319,'Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-25 13:17:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 13:17:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fd2b8a36-61a5-4588-842e-bfbd4b0e6fb5','Y',140,2)
;

-- Sep 25, 2020, 1:17:02 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206512,'Max Dimension',513,214320,'Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-25 13:17:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 13:17:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','065672c7-55d8-4f92-a706-cd42a15033f6','Y',150,2)
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET SeqNo=10, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7052
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7063
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7055
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7058
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7053
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7059
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206511
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206512
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7061
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7062
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7054
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7060
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7056
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7057
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7051
;

-- Sep 25, 2020, 1:17:44 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-25 13:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204893
;

-- Sep 25, 2020, 1:20:28 PM CEST
INSERT INTO C_UOM (C_UOM_ID,Name,StdPrecision,CostingPrecision,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,UOMSymbol,X12DE355,IsDefault,UOMType,C_UOM_UU) VALUES (200001,'Centimeter',2,0,11,0,'Y',TO_TIMESTAMP('2020-09-25 13:20:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 13:20:28','YYYY-MM-DD HH24:MI:SS'),100,'cm','CM','N','LE','f058dfd3-89f5-46e8-b2b8-11df0505dffa')
;

-- Sep 25, 2020, 1:20:41 PM CEST
UPDATE C_UOM SET UOMType='WE',Updated=TO_TIMESTAMP('2020-09-25 13:20:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=50001
;

-- Sep 25, 2020, 1:21:15 PM CEST
UPDATE C_UOM SET UOMType='WE',Updated=TO_TIMESTAMP('2020-09-25 13:21:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=50002
;

-- Sep 25, 2020, 1:21:22 PM CEST
UPDATE C_UOM SET UOMType='VL',Updated=TO_TIMESTAMP('2020-09-25 13:21:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=50000
;

-- Sep 25, 2020, 1:21:26 PM CEST
UPDATE C_UOM SET UOMType='VL',Updated=TO_TIMESTAMP('2020-09-25 13:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=50003
;

-- Sep 25, 2020, 1:21:59 PM CEST
UPDATE C_UOM SET UOMType='OT',Updated=TO_TIMESTAMP('2020-09-25 13:21:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_UOM_ID=109
;

-- Sep 25, 2020, 1:23:53 PM CEST
INSERT INTO C_Charge (C_Charge_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,ChargeAmt,IsSameTax,C_TaxCategory_ID,IsSameCurrency,IsTaxIncluded,C_Charge_UU) VALUES (200000,11,0,'Y',TO_TIMESTAMP('2020-09-25 13:23:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 13:23:53','YYYY-MM-DD HH24:MI:SS'),100,'Freight Charges',0,'N',107,'N','N','82f26cd9-a60a-49c9-aeeb-3a4d33648d5d')
;

-- Sep 25, 2020, 1:23:53 PM CEST
INSERT INTO C_Charge_Acct (C_Charge_ID, C_AcctSchema_ID, AD_Client_ID,AD_Org_ID,IsActive, Created,CreatedBy,Updated,UpdatedBy ,Ch_Expense_Acct,C_Charge_Acct_UU) SELECT 200000, p.C_AcctSchema_ID, p.AD_Client_ID,0,'Y', statement_timestamp(),100,statement_timestamp(),100,p.Ch_Expense_Acct,generate_uuid() FROM C_AcctSchema_Default p WHERE p.AD_Client_ID=11 AND NOT EXISTS (SELECT * FROM C_Charge_Acct e WHERE e.C_AcctSchema_ID=p.C_AcctSchema_ID AND e.C_Charge_ID=200000)
;

-- Sep 25, 2020, 1:24:44 PM CEST
INSERT INTO C_ValidCombination (C_ValidCombination_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_AcctSchema_ID,Account_ID,Combination,IsFullyQualified,Description,C_ValidCombination_UU) VALUES (200017,11,0,'Y',TO_TIMESTAMP('2020-09-25 13:24:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 13:24:44','YYYY-MM-DD HH24:MI:SS'),100,101,434,'*-54000-_-_-_-_','Y','*-Freight in-_-_-_-_','6302914b-7148-4bf7-b41f-efbd07698430')
;

-- Sep 25, 2020, 1:24:47 PM CEST
UPDATE C_Charge_Acct SET Ch_Expense_Acct=200017,Updated=TO_TIMESTAMP('2020-09-25 13:24:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Charge_ID=200000 AND C_AcctSchema_ID=101
;

-- Sep 25, 2020, 1:25:07 PM CEST
UPDATE AD_ClientInfo SET C_UOM_Weight_ID=50001, C_UOM_Length_ID=200001, M_ProductFreight_ID=NULL, C_ChargeFreight_ID=200000,Updated=TO_TIMESTAMP('2020-09-25 13:25:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Client_ID=11
;

-- Sep 25, 2020, 1:27:00 PM CEST
UPDATE M_Product SET Weight=10.00, ShelfWidth=15, ShelfHeight=50, ShelfDepth=15,Updated=TO_TIMESTAMP('2020-09-25 13:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Product_ID=128
;

-- Sep 25, 2020, 1:27:45 PM CEST
UPDATE M_Product SET Weight=1, ShelfWidth=30, ShelfHeight=5, ShelfDepth=20,Updated=TO_TIMESTAMP('2020-09-25 13:27:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Product_ID=50008
;

-- Sep 25, 2020, 1:29:40 PM CEST
UPDATE M_Product SET Weight=1, ShelfWidth=30, ShelfHeight=20, ShelfDepth=100,Updated=TO_TIMESTAMP('2020-09-25 13:29:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Product_ID=138
;

-- Sep 25, 2020, 1:30:34 PM CEST
UPDATE C_AcctSchema SET C_Period_ID=200104,Updated=TO_TIMESTAMP('2020-09-25 13:30:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_AcctSchema_ID=101
;

-- Sep 25, 2020, 1:47:01 PM CEST
UPDATE M_Freight SET C_Country_ID=100, To_Country_ID=100, MaxWeight=19.958, MaxDimension=419.1,Updated=TO_TIMESTAMP('2020-09-25 13:47:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Freight_ID=100
;

-- Sep 25, 2020, 1:48:04 PM CEST
INSERT INTO M_Freight (M_Freight_ID,AD_Client_ID,M_FreightCategory_ID,CreatedBy,UpdatedBy,Created,M_Shipper_ID,C_Currency_ID,Updated,FreightAmt,IsActive,ValidFrom,C_Country_ID,To_Country_ID,AD_Org_ID,M_Freight_UU,MaxWeight,MaxDimension) VALUES (200000,11,100,100,100,TO_TIMESTAMP('2020-09-25 13:48:03','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2020-09-25 13:48:03','YYYY-MM-DD HH24:MI:SS'),14.21,'Y',TO_TIMESTAMP('2003-06-01','YYYY-MM-DD'),100,100,11,'82a6f1c5-5ea8-4ad2-9413-4e0cf02f5f32',9.979,419.1)
;

-- Sep 25, 2020, 1:48:49 PM CEST
INSERT INTO M_Freight (M_Freight_ID,AD_Client_ID,M_FreightCategory_ID,CreatedBy,UpdatedBy,Created,M_Shipper_ID,C_Currency_ID,Updated,FreightAmt,IsActive,ValidFrom,C_Country_ID,To_Country_ID,AD_Org_ID,M_Freight_UU,MaxWeight,MaxDimension) VALUES (200001,11,100,100,100,TO_TIMESTAMP('2020-09-25 13:48:48','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2020-09-25 13:48:48','YYYY-MM-DD HH24:MI:SS'),23.90,'Y',TO_TIMESTAMP('2003-06-01','YYYY-MM-DD'),100,100,11,'ba69860f-4f9e-4040-8fe1-dfdbc3e2c37f',29.937,419.1)
;

-- Sep 25, 2020, 1:53:32 PM CEST
INSERT INTO M_ShippingProcessorCfg (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,HostAddress,HostPort,IsActive,M_ShippingProcessorCfg_ID,M_ShippingProcessorCfg_UU,Name,ProxyPort,ShippingProcessorClass,Updated,UpdatedBy) VALUES (11,0,TO_TIMESTAMP('2020-09-25 13:53:31','YYYY-MM-DD HH24:MI:SS'),100,'Based on data from M_Freight table','0.0.0.0',0,'Y',200000,'c086fbe0-773b-481d-9171-8eb95e1c78d5','Freight Table Shipment Processor',0,'org.adempiere.model.MFreightShipmentProcessor',TO_TIMESTAMP('2020-09-25 13:53:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 25, 2020, 1:54:14 PM CEST
INSERT INTO M_ShipperCfg (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,IsInternational,IsOnline,IsResidential,IsSaturdayDelivery,M_ShipperCfg_ID,M_ShipperCfg_UU,Name,Updated,UpdatedBy,M_ShippingProcessorCfg_ID,CopyFrom) VALUES (11,0,TO_TIMESTAMP('2020-09-25 13:54:14','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N','N','N',200000,'9c303cda-94c4-446d-8328-7806818817c5','Freight Table Shipment Processor',TO_TIMESTAMP('2020-09-25 13:54:14','YYYY-MM-DD HH24:MI:SS'),100,200000,'N')
;

-- Sep 25, 2020, 1:54:36 PM CEST
UPDATE M_Shipper SET M_ShipperCfg_ID=200000, Updated=TO_TIMESTAMP('2020-09-25 13:54:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Shipper_ID=100
;

-- Sep 25, 2020, 1:56:24 PM CEST
INSERT INTO M_ShippingProcessor (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_ShippingProcessor_ID,M_ShippingProcessor_UU,Updated,UpdatedBy,ConnectionPassword,UserID,M_ShippingProcessorCfg_ID,Name) VALUES (11,0,TO_TIMESTAMP('2020-09-25 13:56:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',200000,'99a1cb04-2aa7-4a89-b051-2bbdc0f5943f',TO_TIMESTAMP('2020-09-25 13:56:23','YYYY-MM-DD HH24:MI:SS'),100,'n/r','n/r',200000,'Freight Table Shipment Processor')
;

-- Sep 25, 2020, 1:56:33 PM CEST
UPDATE M_Shipper SET M_ShippingProcessor_ID=200000,Updated=TO_TIMESTAMP('2020-09-25 13:56:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Shipper_ID=100
;

-- Sep 25, 2020, 9:06:35 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','COULD NOT FIND FREIGHT DEFINED FOR: Shipper {0} - Freight Category {1} - Date {2,date,short} - Weight {3,number,#,##0.00} - Dimension {4,number,#,##0.00} - Origin Country {5} - Destination Country {6} - Origin Region {7} - Destination Region {8}',0,0,'Y',TO_TIMESTAMP('2020-09-25 21:06:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 21:06:34','YYYY-MM-DD HH24:MI:SS'),100,200639,'FreightNotFound','D','03990c13-c085-4d1b-bb6f-6ff0c69ef2bc')
;

-- Sep 25, 2020, 9:06:55 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Found freight record [{9}] with price {10,number,#,##0.00} for: Shipper {0} - Freight Category {1} - Date {2,date,short} - Weight {3,number,#,##0.00} - Dimension {4,number,#,##0.00} - Origin Country {5} - Destination Country {6} - Origin Region {7} - Destination Region {8}',0,0,'Y',TO_TIMESTAMP('2020-09-25 21:06:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-25 21:06:55','YYYY-MM-DD HH24:MI:SS'),100,200640,'FreightFound','D','4c399b7e-b1b8-49a3-892d-55e9469094f6')
;

SELECT register_migration_script('202009251357_IDEMPIERE-4474.sql') FROM dual
;

