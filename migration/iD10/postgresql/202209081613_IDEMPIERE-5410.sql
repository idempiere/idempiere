-- IDEMPIERE-5410-orders
SELECT register_migration_script('202209081613_IDEMPIERE-5410.sql') FROM dual;

-- Sep 8, 2022, 4:13:31 PM CEST
INSERT INTO C_OrderSource (C_OrderSource_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Value,Name,C_OrderSource_UU) VALUES (200000,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:13:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:13:31','YYYY-MM-DD HH24:MI:SS'),100,'1000000','Mail','38db4939-af6b-41d6-ac8a-5c7b7369802f')
;

-- Sep 8, 2022, 4:13:31 PM CEST
INSERT INTO C_OrderSource (C_OrderSource_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Value,Name,C_OrderSource_UU) VALUES (200001,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:13:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:13:31','YYYY-MM-DD HH24:MI:SS'),100,'1000001','Web','2053009f-69fc-4899-9fcb-cbf1a07794d8')
;

-- Sep 8, 2022, 4:13:32 PM CEST
INSERT INTO C_OrderSource (C_OrderSource_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Value,Name,C_OrderSource_UU) VALUES (200002,11,0,'Y',TO_TIMESTAMP('2022-09-08 16:13:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:13:31','YYYY-MM-DD HH24:MI:SS'),100,'1000002','Phone','af8dd247-74c0-4a40-98e3-f0bf9ab2039c')
;

-- Sep 8, 2022, 4:13:32 PM CEST
INSERT INTO C_OrderSource (C_OrderSource_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Value,Name,C_OrderSource_UU) VALUES (200003,11,0,'Y',TO_TIMESTAMP('2022-09-08 16:13:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:13:32','YYYY-MM-DD HH24:MI:SS'),100,'1000003','Call','2348c097-daae-42b0-b5a6-c6b98f947e89')
;

-- Sep 8, 2022, 4:32:11 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200004,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:10','YYYY-MM-DD HH24:MI:SS'),100,'50077','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',50004,0,'N',50001,'Y','A','I','P','N','N','N','N','N',50004,'N',50001,'N',114,'N',0,0,0,0,200003,0,'N','bad9e8ef-6d46-487b-bb0f-cbbc863a790b','N','N')
;

-- Sep 8, 2022, 4:32:11 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200005,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:11','YYYY-MM-DD HH24:MI:SS'),100,200004,10,TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),137,100,50002,1,0,0,0,100,3,3,109,50004,0,50001,3,2.7,0.00,0,'N','N',3,1,0,0,0,'3945e7c4-97df-4709-9e1d-c89a16254ecf','N','N')
;

-- Sep 8, 2022, 4:32:11 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:11 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:12 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200006,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:12','YYYY-MM-DD HH24:MI:SS'),100,200004,20,TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),147,100,50002,1,0,0,0,100,15,15,109,50004,0,50001,15,15,0.00,0,'N','N',15,1,0,0,0,'ed8289ff-2bed-425f-a054-eadab019dec4','N','N')
;

-- Sep 8, 2022, 4:32:12 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:12 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:13 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200007,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:12','YYYY-MM-DD HH24:MI:SS'),100,200004,30,TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),136,100,50002,1,0,0,0,100,20,20,109,50004,0,50001,20,18,0.00,0,'N','N',20,1,0,0,0,'b4f3a1a3-2a7b-4cdc-9bd8-dc25713c927a','N','N')
;

-- Sep 8, 2022, 4:32:13 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:13 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:13 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200008,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:13','YYYY-MM-DD HH24:MI:SS'),100,200004,40,TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),129,100,50002,1,0,0,0,100,40,38,109,50004,0,50001,38,36,5.00,0,'N','N',38,1,0,0,0,'88aeb9c1-83d2-4152-a51f-a5d59dd77bbf','N','N')
;

-- Sep 8, 2022, 4:32:13 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:13 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:14 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200009,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:14','YYYY-MM-DD HH24:MI:SS'),100,200004,50,TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),130,100,50002,6,0,0,0,100,50,47.5,109,50004,0,50001,285.0,45,5.00,0,'N','N',47.5,6,0,0,0,'e532b934-294a-4532-a35e-df0aec9e2813','N','N')
;

-- Sep 8, 2022, 4:32:14 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:14 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:15 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200010,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:14','YYYY-MM-DD HH24:MI:SS'),100,200004,60,TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-23','YYYY-MM-DD'),124,100,50002,1,0,0,0,100,60,57,109,50004,0,50001,57,54,5.00,0,'N','N',57,1,0,0,0,'8346219d-2bc5-45e9-a992-69d4e77daadf','N','N')
;

-- Sep 8, 2022, 4:32:15 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:15 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:32:15 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200005,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:15','YYYY-MM-DD HH24:MI:SS'),100,'50076','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-07-09','YYYY-MM-DD'),TO_TIMESTAMP('2022-07-09','YYYY-MM-DD'),TO_TIMESTAMP('2022-07-09','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',50009,0,'N',50004,'Y','A','I','P','N','N','N','N','N',50009,'N',50004,'N',114,'N',0,0,0,0,200003,0,'N','aff9e1f2-eba7-4a10-ba6f-ada639ec39d9','N','N')
;

-- Sep 8, 2022, 4:32:16 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200011,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:16','YYYY-MM-DD HH24:MI:SS'),100,200005,10,TO_TIMESTAMP('2022-07-09','YYYY-MM-DD'),TO_TIMESTAMP('2022-07-09','YYYY-MM-DD'),140,100,50002,8,0,0,0,100,12,10.8,109,50009,0,50004,86.4,9.6,10.00,0,'N','N',10.8,8,0,0,0,'44a1e016-f353-4036-8162-1396d71301f9','N','N')
;

-- Sep 8, 2022, 4:32:16 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:16 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:17 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200012,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:17','YYYY-MM-DD HH24:MI:SS'),100,200005,20,TO_TIMESTAMP('2022-07-09','YYYY-MM-DD'),TO_TIMESTAMP('2022-07-09','YYYY-MM-DD'),50007,100,50002,1,0,0,0,100,35.00,33.00,109,50009,0,50004,33.00,30.00,5.71,0,'N','N',33.00,1,0,0,0,'5c84bd39-656e-4429-8dcf-6d87fafa5952','N','N')
;

-- Sep 8, 2022, 4:32:17 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:17 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:17 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200013,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:17','YYYY-MM-DD HH24:MI:SS'),100,200005,30,TO_TIMESTAMP('2022-07-09','YYYY-MM-DD'),TO_TIMESTAMP('2022-07-09','YYYY-MM-DD'),124,100,50002,1,0,0,0,100,60,57,109,50009,0,50004,57,54,5.00,0,'N','N',57,1,0,0,0,'f1643bd3-fc09-4d8a-a195-c40d5ac02914','N','N')
;

-- Sep 8, 2022, 4:32:17 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:17 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:18 PM CEST
DELETE FROM AD_Attachment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:18 PM CEST
DELETE FROM AD_Archive WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:18 PM CEST
DELETE FROM AD_Note WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:18 PM CEST
DELETE FROM AD_PostIt WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:18 PM CEST
DELETE FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:18 PM CEST
DELETE FROM C_OrderLine WHERE C_OrderLine_ID=200011
;

-- Sep 8, 2022, 4:32:18 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:18 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:18 PM CEST
DELETE FROM C_OrderLine WHERE C_OrderLine_ID=200012
;

-- Sep 8, 2022, 4:32:18 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:18 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:18 PM CEST
DELETE FROM C_OrderLine WHERE C_OrderLine_ID=200013
;

-- Sep 8, 2022, 4:32:18 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:18 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:18 PM CEST
DELETE FROM C_Order WHERE C_Order_ID=200005
;

-- Sep 8, 2022, 4:32:19 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200006,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:18','YYYY-MM-DD HH24:MI:SS'),100,'50075','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-11-21','YYYY-MM-DD'),TO_TIMESTAMP('2022-11-21','YYYY-MM-DD'),TO_TIMESTAMP('2022-11-21','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',50008,0,'N',50003,'Y','A','I','P','N','N','N','N','N',50008,'N',50003,'N',114,'N',0,0,0,0,200003,0,'N','348b9dbb-9317-4c4e-a6e5-30179d38c582','N','N')
;

-- Sep 8, 2022, 4:32:19 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200014,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:19','YYYY-MM-DD HH24:MI:SS'),100,200006,10,TO_TIMESTAMP('2022-11-21','YYYY-MM-DD'),TO_TIMESTAMP('2022-11-21','YYYY-MM-DD'),137,100,50002,9,0,0,0,100,3,3,109,50008,0,50003,27,2.7,0.00,0,'N','N',3,9,0,0,0,'a1e687cd-35c7-4c0e-b2db-062ef18bc427','N','N')
;

-- Sep 8, 2022, 4:32:19 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200006
;

-- Sep 8, 2022, 4:32:19 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200006
;

-- Sep 8, 2022, 4:32:20 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,Description,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,POReference,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200007,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:20','YYYY-MM-DD HH24:MI:SS'),100,'50071','DR','CO',0,132,'Order Description from Business Partner Definition','N','N','N','N','N','N',TO_TIMESTAMP('2022-01-12','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-12','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-12','YYYY-MM-DD'),102,106,100,'I',0,'P','5',0,0,50002,101,'N',117,104,'Order Reference 1234',0,'N',112,'Y','A','I','P','Y','N','N','N','N',104,117,'N',112,'N',114,'N',0,0,0,0,200003,0,'N','f43c65da-d7b1-4a03-9938-5bbd834edcd5','N','N')
;

-- Sep 8, 2022, 4:32:20 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200015,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:20','YYYY-MM-DD HH24:MI:SS'),100,200007,20,TO_TIMESTAMP('2022-01-12','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-12','YYYY-MM-DD'),137,100,50002,1,0,0,0,100,3,3,109,117,0,112,3,2.7,0.00,0,'N','N',3,1,0,0,0,'b557f3f1-0a62-46ba-aa10-80a24c1fa4a8','N','N')
;

-- Sep 8, 2022, 4:32:20 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:32:20 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:32:21 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200016,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:21','YYYY-MM-DD HH24:MI:SS'),100,200007,30,TO_TIMESTAMP('2022-01-12','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-12','YYYY-MM-DD'),50007,100,50002,2,0,0,0,100,35.00,33.00,109,117,0,112,66.00,30.00,5.71,0,'N','N',33.00,2,0,0,0,'890aa26c-2a6f-4c27-90b5-51b42f77d03f','N','N')
;

-- Sep 8, 2022, 4:32:21 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:32:21 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:32:22 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200017,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:22','YYYY-MM-DD HH24:MI:SS'),100,200007,40,TO_TIMESTAMP('2022-01-12','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-12','YYYY-MM-DD'),142,100,50002,4,0,0,0,100,3.5,3.15,109,117,0,112,12.60,2.8,10.00,0,'N','N',3.15,4,0,0,0,'4e9423c6-da04-445a-a37d-453f094a08d9','N','N')
;

-- Sep 8, 2022, 4:32:22 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:32:22 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:32:22 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200008,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:22','YYYY-MM-DD HH24:MI:SS'),100,'50067','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-12-09','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-09','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-09','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',113,101,0,'N',117,'Y','A','I','P','Y','N','N','N','N',101,113,'N',117,'N',114,'N',0,0,0,0,200003,0,'N','b5f51da1-5086-4c26-b915-18abefe53f17','N','N')
;

-- Sep 8, 2022, 4:32:23 PM CEST
DELETE FROM AD_Attachment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:23 PM CEST
DELETE FROM AD_Archive WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:23 PM CEST
DELETE FROM AD_Note WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:23 PM CEST
DELETE FROM AD_PostIt WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:23 PM CEST
DELETE FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:23 PM CEST
DELETE FROM C_Order WHERE C_Order_ID=200008
;

-- Sep 8, 2022, 4:32:23 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200009,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:23','YYYY-MM-DD HH24:MI:SS'),100,'50062','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-09-24','YYYY-MM-DD'),TO_TIMESTAMP('2022-09-24','YYYY-MM-DD'),TO_TIMESTAMP('2022-09-24','YYYY-MM-DD'),102,106,100,'I',0,'P','5',0,0,50002,101,'N',118,0,'N',113,'Y','A','I','P','Y','N','N','N','N',118,'N',113,'N',114,'N',0,0,0,0,200003,0,'N','14371958-74f3-4af1-ac92-89707820e827','N','N')
;

-- Sep 8, 2022, 4:32:24 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200018,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:24','YYYY-MM-DD HH24:MI:SS'),100,200009,10,TO_TIMESTAMP('2022-09-24','YYYY-MM-DD'),TO_TIMESTAMP('2022-09-24','YYYY-MM-DD'),123,100,50002,6,0,0,0,100,65,61.75,109,118,0,113,370.50,58.5,5.00,0,'N','N',61.75,6,0,0,0,'98af13e9-560e-4dd9-a183-ecf6dd0937e7','N','N')
;

-- Sep 8, 2022, 4:32:24 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200009
;

-- Sep 8, 2022, 4:32:24 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200009
;

-- Sep 8, 2022, 4:32:25 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200010,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:24','YYYY-MM-DD HH24:MI:SS'),100,'50061','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-12-25','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-25','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-25','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',121,0,'N',115,'Y','A','I','P','Y','N','N','N','N',121,'N',115,'N',114,'N',0,0,0,0,200003,0,'N','8e2b7273-8f96-42dc-ae0c-887666d0cc44','N','N')
;

-- Sep 8, 2022, 4:32:25 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200019,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:25','YYYY-MM-DD HH24:MI:SS'),100,200010,10,TO_TIMESTAMP('2022-12-25','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-25','YYYY-MM-DD'),130,100,50002,1,0,0,0,100,50,47.5,109,121,0,115,47.5,45,5.00,0,'N','N',47.5,1,0,0,0,'057b8d17-e883-4cfd-b2fd-e7adcd668f7c','N','N')
;

-- Sep 8, 2022, 4:32:25 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:32:25 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:32:26 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200020,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:26','YYYY-MM-DD HH24:MI:SS'),100,200010,20,TO_TIMESTAMP('2022-12-25','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-25','YYYY-MM-DD'),135,100,50002,10,0,0,0,100,22,22.5,109,121,0,115,225.0,18,-2.27,0,'N','N',22.5,10,0,0,0,'19238521-d6b2-432e-8a8e-ebb37211dff5','N','N')
;

-- Sep 8, 2022, 4:32:26 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:32:26 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:32:27 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200011,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:26','YYYY-MM-DD HH24:MI:SS'),100,'50060','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-10-11','YYYY-MM-DD'),TO_TIMESTAMP('2022-10-11','YYYY-MM-DD'),TO_TIMESTAMP('2022-10-11','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',112,0,'N',108,'Y','A','I','P','Y','N','N','N','N',112,'N',108,'N',114,'N',0,0,0,0,200003,0,'N','2f3bbb56-df54-444e-a8af-794e9b7e97d2','N','N')
;

-- Sep 8, 2022, 4:32:27 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200021,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:27','YYYY-MM-DD HH24:MI:SS'),100,200011,10,TO_TIMESTAMP('2022-10-11','YYYY-MM-DD'),TO_TIMESTAMP('2022-10-11','YYYY-MM-DD'),137,100,50002,7,0,0,0,100,3,3,109,112,0,108,21,2.7,0.00,0,'N','N',3,7,0,0,0,'e275b2a3-50e3-4cd7-beb8-99d742ae094f','N','N')
;

-- Sep 8, 2022, 4:32:27 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200011
;

-- Sep 8, 2022, 4:32:27 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200011
;

-- Sep 8, 2022, 4:32:28 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200022,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:28','YYYY-MM-DD HH24:MI:SS'),100,200011,20,TO_TIMESTAMP('2022-10-11','YYYY-MM-DD'),TO_TIMESTAMP('2022-10-11','YYYY-MM-DD'),139,100,50002,12,0,0,0,100,9,8.1,109,112,0,108,97.2,7.2,10.00,0,'N','N',8.1,12,0,0,0,'8707d0cc-bcd0-4a21-89f7-9573405c3c0c','N','N')
;

-- Sep 8, 2022, 4:32:28 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200011
;

-- Sep 8, 2022, 4:32:28 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200011
;

-- Sep 8, 2022, 4:32:28 PM CEST
DELETE FROM AD_Attachment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:28 PM CEST
DELETE FROM AD_Archive WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:28 PM CEST
DELETE FROM AD_Note WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:28 PM CEST
DELETE FROM AD_PostIt WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:28 PM CEST
DELETE FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:28 PM CEST
DELETE FROM C_OrderLine WHERE C_OrderLine_ID=200021
;

-- Sep 8, 2022, 4:32:28 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200011
;

-- Sep 8, 2022, 4:32:28 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200011
;

-- Sep 8, 2022, 4:32:28 PM CEST
DELETE FROM C_OrderLine WHERE C_OrderLine_ID=200022
;

-- Sep 8, 2022, 4:32:29 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200011
;

-- Sep 8, 2022, 4:32:29 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200011
;

-- Sep 8, 2022, 4:32:29 PM CEST
DELETE FROM C_Order WHERE C_Order_ID=200011
;

-- Sep 8, 2022, 4:32:29 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200012,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:29','YYYY-MM-DD HH24:MI:SS'),100,'50059','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-12-21','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-21','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-21','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',50009,0,'N',50004,'Y','A','I','P','N','N','N','N','N',50009,'N',50004,'N',114,'N',0,0,0,0,200003,0,'N','d720865f-1c49-46f6-a88f-aeab15d123cd','N','N')
;

-- Sep 8, 2022, 4:32:30 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200023,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:30','YYYY-MM-DD HH24:MI:SS'),100,200012,10,TO_TIMESTAMP('2022-12-21','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-21','YYYY-MM-DD'),135,100,50002,6,0,0,0,100,22,22.5,109,50009,0,50004,135.0,18,-2.27,0,'N','N',22.5,6,0,0,0,'57372a9f-6ece-4229-8041-710145fd39db','N','N')
;

-- Sep 8, 2022, 4:32:30 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:32:30 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:32:31 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200024,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:30','YYYY-MM-DD HH24:MI:SS'),100,200012,20,TO_TIMESTAMP('2022-12-21','YYYY-MM-DD'),TO_TIMESTAMP('2022-12-21','YYYY-MM-DD'),143,100,50002,6,0,0,0,100,30,27,109,50009,0,50004,162,24,10.00,0,'N','N',27,6,0,0,0,'4048b8c5-b9cc-4f10-8f77-5b0135df9fdf','N','N')
;

-- Sep 8, 2022, 4:32:31 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:32:31 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:32:31 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200013,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:31','YYYY-MM-DD HH24:MI:SS'),100,'50058','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-01-01','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-01','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-01','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',50008,0,'N',50003,'Y','A','I','P','N','N','N','N','N',50008,'N',50003,'N',114,'N',0,0,0,0,200003,0,'N','e1172ec2-346b-44e1-be7b-9f81ee9ec740','N','N')
;

-- Sep 8, 2022, 4:32:32 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200025,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:32','YYYY-MM-DD HH24:MI:SS'),100,200013,10,TO_TIMESTAMP('2022-01-01','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-01','YYYY-MM-DD'),147,100,50002,3,0,0,0,100,15,15,109,50008,0,50003,45,15,0.00,0,'N','N',15,3,0,0,0,'60a6d259-19c4-4bc8-a193-19b26fac2015','N','N')
;

-- Sep 8, 2022, 4:32:32 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:32:32 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:32:33 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200026,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:32','YYYY-MM-DD HH24:MI:SS'),100,200013,20,TO_TIMESTAMP('2022-01-01','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-01','YYYY-MM-DD'),127,100,50002,2,0,0,0,100,30,28.5,109,50008,0,50003,57.0,27,5.00,0,'N','N',28.5,2,0,0,0,'6f2f5717-2abf-45f4-9699-17abfc9ff3b2','N','N')
;

-- Sep 8, 2022, 4:32:33 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:32:33 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:32:33 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200014,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:33','YYYY-MM-DD HH24:MI:SS'),100,'50057','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-02-24','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-24','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-24','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',113,101,0,'N',117,'Y','A','I','P','Y','N','N','N','N',101,113,'N',117,'N',114,'N',0,0,0,0,200003,0,'N','cccfbce0-1cbd-4e41-80b0-ebf85199466d','N','N')
;

-- Sep 8, 2022, 4:32:34 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200027,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:33','YYYY-MM-DD HH24:MI:SS'),100,200014,10,TO_TIMESTAMP('2022-02-24','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-24','YYYY-MM-DD'),126,101,50002,3.00,0,0,0,100,45,42.75,109,113,0,117,128.25,40.5,5.00,0,'N','N',42.75,3.00,0,0,0,'da8f8832-b6a8-4ed5-a759-519312ce2ed6','N','N')
;

-- Sep 8, 2022, 4:32:34 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:32:34 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:32:35 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200028,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:34','YYYY-MM-DD HH24:MI:SS'),100,200014,20,TO_TIMESTAMP('2022-02-24','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-24','YYYY-MM-DD'),127,100,50002,2,0,0,0,100,30,28.5,109,113,0,117,57.0,27,5.00,0,'N','N',28.5,2,0,0,0,'baacd2f0-d0e3-4f48-ba35-89d095c49142','N','N')
;

-- Sep 8, 2022, 4:32:35 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:32:35 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:32:35 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200015,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:35','YYYY-MM-DD HH24:MI:SS'),100,'50056','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-02-03','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-03','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-03','YYYY-MM-DD'),101,106,100,'D',0,'P','5',0,0,50002,101,'N',120,105,0,'N',114,'Y','A','I','P','Y','N','N','N','N',105,120,'N',114,'N',114,'N',0,0,0,0,200003,0,'N','e6a7ee5b-1c90-4b31-a0c4-1e713aacce1f','N','N')
;

-- Sep 8, 2022, 4:32:35 PM CEST
DELETE FROM AD_Attachment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:35 PM CEST
DELETE FROM AD_Archive WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:35 PM CEST
DELETE FROM AD_Note WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:35 PM CEST
DELETE FROM AD_PostIt WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:35 PM CEST
DELETE FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:32:35 PM CEST
DELETE FROM C_Order WHERE C_Order_ID=200015
;

-- Sep 8, 2022, 4:32:36 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200016,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:36','YYYY-MM-DD HH24:MI:SS'),100,'50054','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',121,0,'N',115,'Y','A','I','P','Y','N','N','N','N',121,'N',115,'N',114,'N',0,0,0,0,200003,0,'N','ffaefdd9-e908-44fb-8274-72c01d1b0540','N','N')
;

-- Sep 8, 2022, 4:32:37 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200029,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:36','YYYY-MM-DD HH24:MI:SS'),100,200016,10,TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),124,100,50002,1,0,0,0,100,60,57,109,121,0,115,57,54,5.00,0,'N','N',57,1,0,0,0,'d84ddba8-734d-454f-82d2-f5cdd275c9c3','N','N')
;

-- Sep 8, 2022, 4:32:37 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:32:37 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:32:37 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200030,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:37','YYYY-MM-DD HH24:MI:SS'),100,200016,20,TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),140,100,50002,7,0,0,0,100,12,10.8,109,121,0,115,75.6,9.6,10.00,0,'N','N',10.8,7,0,0,0,'6796e289-8e55-40fd-8949-6e10dbd3d455','N','N')
;

-- Sep 8, 2022, 4:32:37 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:32:37 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:32:38 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200031,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:38','YYYY-MM-DD HH24:MI:SS'),100,200016,30,TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),135,100,50002,1,0,0,0,100,22,22.5,109,121,0,115,22.5,18,-2.27,0,'N','N',22.5,1,0,0,0,'2ce849ec-1f21-41d8-bb91-eb22e8d999f6','N','N')
;

-- Sep 8, 2022, 4:32:38 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:32:38 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:32:39 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200032,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:38','YYYY-MM-DD HH24:MI:SS'),100,200016,40,TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),TO_TIMESTAMP('2022-03-14','YYYY-MM-DD'),133,100,50002,2,0,0,0,100,33,33.75,109,121,0,115,67.50,27,-2.27,0,'N','N',33.75,2,0,0,0,'149f23c3-b4a1-4d11-b4a3-b51710defc4b','N','N')
;

-- Sep 8, 2022, 4:32:39 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:32:39 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:32:39 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200017,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:39','YYYY-MM-DD HH24:MI:SS'),100,'50053','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',50008,0,'N',50003,'Y','A','I','P','N','N','N','N','N',50008,'N',50003,'N',114,'N',0,0,0,0,200003,0,'N','c79a6d9d-bc12-438a-9f45-1efedf32b1c9','N','N')
;

-- Sep 8, 2022, 4:32:40 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200033,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:40','YYYY-MM-DD HH24:MI:SS'),100,200017,20,TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),147,100,50002,3,0,0,0,100,15,15,109,50008,0,50003,45,15,0.00,0,'N','N',15,3,0,0,0,'ec0d88c1-6c2f-48a6-b33e-e2104165c5dc','N','N')
;

-- Sep 8, 2022, 4:32:40 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:40 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:40 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200034,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:40','YYYY-MM-DD HH24:MI:SS'),100,200017,30,TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),50007,100,50002,1,0,0,0,100,35.00,33.00,109,50008,0,50003,33.00,30.00,5.71,0,'N','N',33.00,1,0,0,0,'0feef9b1-6239-4e8c-958e-aa1f728399e4','N','N')
;

-- Sep 8, 2022, 4:32:40 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:40 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:41 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200035,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:41','YYYY-MM-DD HH24:MI:SS'),100,200017,40,TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),123,100,50002,1,0,0,0,100,65,61.75,109,50008,0,50003,61.75,58.5,5.00,0,'N','N',61.75,1,0,0,0,'27c95eb1-4237-4372-84d3-3a51c369f038','N','N')
;

-- Sep 8, 2022, 4:32:41 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:41 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:42 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200036,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:41','YYYY-MM-DD HH24:MI:SS'),100,200017,50,TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),137,100,50002,13,0,0,0,100,3,3,109,50008,0,50003,39,2.7,0.00,0,'N','N',3,13,0,0,0,'86a380b4-103b-4134-8e38-bd2327f99f21','N','N')
;

-- Sep 8, 2022, 4:32:42 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:42 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:42 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200037,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:42','YYYY-MM-DD HH24:MI:SS'),100,200017,60,TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),143,100,50002,1,0,0,0,100,30,27,109,50008,0,50003,27,24,10.00,0,'N','N',27,1,0,0,0,'f0c54ccd-9c1c-4844-ab1a-14e8742ecfb5','N','N')
;

-- Sep 8, 2022, 4:32:42 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:42 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:43 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200038,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:43','YYYY-MM-DD HH24:MI:SS'),100,200017,70,TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),TO_TIMESTAMP('2022-02-27','YYYY-MM-DD'),133,100,50002,1,0,0,0,100,33,33.75,109,50008,0,50003,33.75,27,-2.27,0,'N','N',33.75,1,0,0,0,'b2b726f3-ea8f-4a51-81c0-79f1caeab9f0','N','N')
;

-- Sep 8, 2022, 4:32:43 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:43 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:32:44 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200018,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:43','YYYY-MM-DD HH24:MI:SS'),100,'50050','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',50009,0,'N',50004,'Y','A','I','P','N','N','N','N','N',50009,'N',50004,'N',114,'N',0,0,0,0,200003,0,'N','7ea68d2e-3340-48bb-814f-2f176e86dec3','N','N')
;

-- Sep 8, 2022, 4:32:44 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200039,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:44','YYYY-MM-DD HH24:MI:SS'),100,200018,10,TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),148,100,50002,2,0,0,0,100,15,15,109,50009,0,50004,30,15,0.00,0,'N','N',15,2,0,0,0,'9bc73657-5a8f-482c-8ad9-c1e83b7157cb','N','N')
;

-- Sep 8, 2022, 4:32:44 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:44 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:45 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200040,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:45','YYYY-MM-DD HH24:MI:SS'),100,200018,20,TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),125,100,50002,1,0,0,0,100,80,76,109,50009,0,50004,76,72,5.00,0,'N','N',76,1,0,0,0,'237a3bcc-014d-4b39-b87d-429d469cf3cb','N','N')
;

-- Sep 8, 2022, 4:32:45 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:45 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:46 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200041,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:45','YYYY-MM-DD HH24:MI:SS'),100,200018,30,TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),142,100,50002,17,0,0,0,100,3.5,3.15,109,50009,0,50004,53.55,2.8,10.00,0,'N','N',3.15,17,0,0,0,'11846b01-e9d5-4df6-ab06-64870c0f2699','N','N')
;

-- Sep 8, 2022, 4:32:46 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:46 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:46 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200042,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:46','YYYY-MM-DD HH24:MI:SS'),100,200018,40,TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),141,100,50002,14,0,0,0,100,3,2.7,109,50009,0,50004,37.8,2.4,10.00,0,'N','N',2.7,14,0,0,0,'2c31db0e-501c-4a7d-8a58-7373a92ca417','N','N')
;

-- Sep 8, 2022, 4:32:46 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:46 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:47 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200043,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:47','YYYY-MM-DD HH24:MI:SS'),100,200018,50,TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),127,100,50002,1,0,0,0,100,30,28.5,109,50009,0,50004,28.5,27,5.00,0,'N','N',28.5,1,0,0,0,'9581d510-49b8-41d9-9e3a-ec68c6c61671','N','N')
;

-- Sep 8, 2022, 4:32:47 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:47 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:48 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200044,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:48','YYYY-MM-DD HH24:MI:SS'),100,200018,60,TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),TO_TIMESTAMP('2022-01-28','YYYY-MM-DD'),135,100,50002,1,0,0,0,100,22,22.5,109,50009,0,50004,22.5,18,-2.27,0,'N','N',22.5,1,0,0,0,'7ebea6b9-e5d8-4633-900f-d1da319fdb76','N','N')
;

-- Sep 8, 2022, 4:32:48 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:48 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:32:48 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200019,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:48','YYYY-MM-DD HH24:MI:SS'),100,'50047','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),101,106,100,'D',0,'P','5',0,0,50002,101,'N',120,105,0,'N',114,'Y','A','I','P','Y','N','N','N','N',105,120,'N',114,'N',114,'N',0,0,0,0,200003,0,'N','2f143655-7061-4690-930f-998ac593ba1c','N','N')
;

-- Sep 8, 2022, 4:32:49 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200045,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:49','YYYY-MM-DD HH24:MI:SS'),100,200019,10,TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),130,100,50002,1,0,0,0,100,50,47.5,109,120,0,114,47.5,45,5.00,0,'N','N',47.5,1,0,0,0,'cf079528-a73f-40a2-837c-37b18a49cc58','N','N')
;

-- Sep 8, 2022, 4:32:49 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:49 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:50 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200046,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:49','YYYY-MM-DD HH24:MI:SS'),100,200019,20,TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),141,100,50002,9,0,0,0,100,3,2.7,109,120,0,114,24.3,2.4,10.00,0,'N','N',2.7,9,0,0,0,'8632c330-ea2a-4e8b-8077-e360eefbe55b','N','N')
;

-- Sep 8, 2022, 4:32:50 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:50 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:50 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200047,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:50','YYYY-MM-DD HH24:MI:SS'),100,200019,30,TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),144,100,50002,1,0,0,0,100,35,31.5,109,120,0,114,31.5,28,10.00,0,'N','N',31.5,1,0,0,0,'d491e530-73c8-444a-b14b-24280ddb99a8','N','N')
;

-- Sep 8, 2022, 4:32:50 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:50 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:51 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200048,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:51','YYYY-MM-DD HH24:MI:SS'),100,200019,40,TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),123,100,50002,4,0,0,0,100,65,61.75,109,120,0,114,247.00,58.5,5.00,0,'N','N',61.75,4,0,0,0,'3a3fa7b1-c571-4295-8d1c-9a3b62c98603','N','N')
;

-- Sep 8, 2022, 4:32:51 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:51 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:52 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200049,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:51','YYYY-MM-DD HH24:MI:SS'),100,200019,50,TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),50007,100,50002,1,0,0,0,100,35.00,33.00,109,120,0,114,33.00,30.00,5.71,0,'N','N',33.00,1,0,0,0,'92f00a67-9082-4ae4-bcc3-011926d3757e','N','N')
;

-- Sep 8, 2022, 4:32:52 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:52 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:52 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200050,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:52','YYYY-MM-DD HH24:MI:SS'),100,200019,60,TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),125,100,50002,1,0,0,0,100,80,76,109,120,0,114,76,72,5.00,0,'N','N',76,1,0,0,0,'01ae6aac-9662-490d-908f-27e1b5b439f5','N','N')
;

-- Sep 8, 2022, 4:32:52 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:52 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:53 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200051,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:53','YYYY-MM-DD HH24:MI:SS'),100,200019,70,TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),143,100,50002,1,0,0,0,100,30,27,109,120,0,114,27,24,10.00,0,'N','N',27,1,0,0,0,'db8b35d5-884a-4b5c-842c-ad06883c2652','N','N')
;

-- Sep 8, 2022, 4:32:53 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:53 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:54 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200052,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:53','YYYY-MM-DD HH24:MI:SS'),100,200019,80,TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-04','YYYY-MM-DD'),137,100,50002,1,0,0,0,100,3,3,109,120,0,114,3,2.7,0.00,0,'N','N',3,1,0,0,0,'643dde39-b641-4c75-904e-c067e01be87e','N','N')
;

-- Sep 8, 2022, 4:32:54 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:54 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:32:54 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200020,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:54','YYYY-MM-DD HH24:MI:SS'),100,'50045','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',121,0,'N',115,'Y','A','I','P','Y','N','N','N','N',121,'N',115,'N',114,'N',0,0,0,0,200003,0,'N','46bb8f9e-d81b-42f5-a1d5-47b566fc4692','N','N')
;

-- Sep 8, 2022, 4:32:55 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200053,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:54','YYYY-MM-DD HH24:MI:SS'),100,200020,10,TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),144,100,50002,1,0,0,0,100,35,31.5,109,121,0,115,31.5,28,10.00,0,'N','N',31.5,1,0,0,0,'c56f53ff-6a24-4425-b307-66906253d2c2','N','N')
;

-- Sep 8, 2022, 4:32:55 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:55 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:55 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200054,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:55','YYYY-MM-DD HH24:MI:SS'),100,200020,20,TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),137,100,50002,9,0,0,0,100,3,3,109,121,0,115,27,2.7,0.00,0,'N','N',3,9,0,0,0,'3e1b9322-f8c1-4490-9127-32ba51b8505f','N','N')
;

-- Sep 8, 2022, 4:32:55 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:56 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:56 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200055,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:56','YYYY-MM-DD HH24:MI:SS'),100,200020,30,TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),136,100,50002,3,0,0,0,100,20,20,109,121,0,115,60,18,0.00,0,'N','N',20,3,0,0,0,'9014d444-efc4-46ce-aff0-5e9d19b6afd8','N','N')
;

-- Sep 8, 2022, 4:32:56 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:56 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:57 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200056,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:57','YYYY-MM-DD HH24:MI:SS'),100,200020,40,TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),128,100,50002,1,0,0,0,100,25,23.75,109,121,0,115,23.75,22.5,5.00,0,'N','N',23.75,1,0,0,0,'8cdcb3f6-3337-4c24-bc71-b176086d2e3d','N','N')
;

-- Sep 8, 2022, 4:32:57 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:57 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:58 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200057,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:57','YYYY-MM-DD HH24:MI:SS'),100,200020,50,TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),129,100,50002,2,0,0,0,100,40,38,109,121,0,115,76,36,5.00,0,'N','N',38,2,0,0,0,'63457785-c9c5-483b-a1e7-6d3352663b8b','N','N')
;

-- Sep 8, 2022, 4:32:58 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:58 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:58 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200058,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:58','YYYY-MM-DD HH24:MI:SS'),100,200020,60,TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-11','YYYY-MM-DD'),138,100,50002,2,0,0,0,100,15,13.5,109,121,0,115,27.0,12,10.00,0,'N','N',13.5,2,0,0,0,'db7fc641-316d-43fd-87cd-ede2428b4eac','N','N')
;

-- Sep 8, 2022, 4:32:58 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:58 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:32:59 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200021,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:59','YYYY-MM-DD HH24:MI:SS'),100,'50044','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-08-01','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-01','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-01','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',121,0,'N',115,'Y','A','I','P','Y','N','N','N','N',121,'N',115,'N',114,'N',0,0,0,0,200003,0,'N','3968322a-cb13-4d25-8b47-c90d9c8067e6','N','N')
;

-- Sep 8, 2022, 4:32:59 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200059,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:32:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:32:59','YYYY-MM-DD HH24:MI:SS'),100,200021,10,TO_TIMESTAMP('2021-08-01','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-01','YYYY-MM-DD'),125,100,50002,1,0,0,0,100,80,76,109,121,0,115,76,72,5.00,0,'N','N',76,1,0,0,0,'6b4012d9-d0ce-4611-9fd6-a58bc819178a','N','N')
;

-- Sep 8, 2022, 4:32:59 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:32:59 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:33:00 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200060,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:00','YYYY-MM-DD HH24:MI:SS'),100,200021,20,TO_TIMESTAMP('2021-08-01','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-01','YYYY-MM-DD'),139,100,50002,3,0,0,0,100,9,8.1,109,121,0,115,24.3,7.2,10.00,0,'N','N',8.1,3,0,0,0,'849876ac-215c-4d32-9226-4b1eec99fd4b','N','N')
;

-- Sep 8, 2022, 4:33:00 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:33:00 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:33:01 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200061,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:01','YYYY-MM-DD HH24:MI:SS'),100,200021,30,TO_TIMESTAMP('2021-08-01','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-01','YYYY-MM-DD'),134,100,50002,1,0,0,0,100,66,67.5,109,121,0,115,67.5,54,-2.27,0,'N','N',67.5,1,0,0,0,'0d488ed6-dfec-4ceb-8c7e-38880b378047','N','N')
;

-- Sep 8, 2022, 4:33:01 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:33:01 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:33:01 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200022,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:01','YYYY-MM-DD HH24:MI:SS'),100,'50041','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',121,0,'N',115,'Y','A','I','P','Y','N','N','N','N',121,'N',115,'N',114,'N',0,0,0,0,200003,0,'N','3051f90d-7cea-4ece-ad2e-24cf87ce9768','N','N')
;

-- Sep 8, 2022, 4:33:02 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200062,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:02','YYYY-MM-DD HH24:MI:SS'),100,200022,10,TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),148,100,50002,1,0,0,0,100,15,15,109,121,0,115,15,15,0.00,0,'N','N',15,1,0,0,0,'b0664fca-85a1-4d21-8f8e-89863176d051','N','N')
;

-- Sep 8, 2022, 4:33:02 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:02 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:03 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200063,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:02','YYYY-MM-DD HH24:MI:SS'),100,200022,20,TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),125,100,50002,1,0,0,0,100,80,76,109,121,0,115,76,72,5.00,0,'N','N',76,1,0,0,0,'7c3a88db-2439-4ec4-be63-f5b767548bdb','N','N')
;

-- Sep 8, 2022, 4:33:03 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:03 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:03 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200064,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:03','YYYY-MM-DD HH24:MI:SS'),100,200022,30,TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),123,100,50002,1,0,0,0,100,65,61.75,109,121,0,115,61.75,58.5,5.00,0,'N','N',61.75,1,0,0,0,'05d3a642-1efb-4e42-a96e-c325959f8669','N','N')
;

-- Sep 8, 2022, 4:33:03 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:03 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:04 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200065,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:04','YYYY-MM-DD HH24:MI:SS'),100,200022,40,TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),136,100,50002,3,0,0,0,100,20,20,109,121,0,115,60,18,0.00,0,'N','N',20,3,0,0,0,'69f53f05-5b8e-4158-9baf-69997ff0dcd3','N','N')
;

-- Sep 8, 2022, 4:33:04 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:04 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:05 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200066,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:04','YYYY-MM-DD HH24:MI:SS'),100,200022,50,TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),133,100,50002,1,0,0,0,100,33,33.75,109,121,0,115,33.75,27,-2.27,0,'N','N',33.75,1,0,0,0,'c136d3c6-ff47-41c9-ac7b-a12c9eace8cf','N','N')
;

-- Sep 8, 2022, 4:33:05 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:05 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:05 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200067,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:05','YYYY-MM-DD HH24:MI:SS'),100,200022,60,TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),TO_TIMESTAMP('2021-04-02','YYYY-MM-DD'),129,100,50002,1,0,0,0,100,40,38,109,121,0,115,38,36,5.00,0,'N','N',38,1,0,0,0,'a742332e-aec7-45ca-ae03-60b4fc244389','N','N')
;

-- Sep 8, 2022, 4:33:05 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:05 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:33:06 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200023,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:05','YYYY-MM-DD HH24:MI:SS'),100,'50040','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-08-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-11','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',50004,0,'N',50001,'Y','A','I','P','N','N','N','N','N',50004,'N',50001,'N',114,'N',0,0,0,0,200003,0,'N','ccfd6c03-f0eb-465c-a722-0adf934699d8','N','N')
;

-- Sep 8, 2022, 4:33:06 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200068,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:06','YYYY-MM-DD HH24:MI:SS'),100,200023,10,TO_TIMESTAMP('2021-08-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-11','YYYY-MM-DD'),127,100,50002,1,0,0,0,100,30,28.5,109,50004,0,50001,28.5,27,5.00,0,'N','N',28.5,1,0,0,0,'2ccf07bc-4d06-4a33-b25d-0717f8251073','N','N')
;

-- Sep 8, 2022, 4:33:06 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200023
;

-- Sep 8, 2022, 4:33:06 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200023
;

-- Sep 8, 2022, 4:33:07 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200069,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:07','YYYY-MM-DD HH24:MI:SS'),100,200023,20,TO_TIMESTAMP('2021-08-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-11','YYYY-MM-DD'),141,100,50002,40,0,0,0,100,3,2.7,109,50004,0,50001,108.0,2.4,10.00,0,'N','N',2.7,40,0,0,0,'b4586c87-d9dd-45bb-b19d-82000961348b','N','N')
;

-- Sep 8, 2022, 4:33:07 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200023
;

-- Sep 8, 2022, 4:33:07 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200023
;

-- Sep 8, 2022, 4:33:07 PM CEST
DELETE FROM AD_Attachment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:07 PM CEST
DELETE FROM AD_Archive WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:07 PM CEST
DELETE FROM AD_Note WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:07 PM CEST
DELETE FROM AD_PostIt WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:07 PM CEST
DELETE FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:07 PM CEST
DELETE FROM C_OrderLine WHERE C_OrderLine_ID=200068
;

-- Sep 8, 2022, 4:33:07 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200023
;

-- Sep 8, 2022, 4:33:07 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200023
;

-- Sep 8, 2022, 4:33:07 PM CEST
DELETE FROM C_OrderLine WHERE C_OrderLine_ID=200069
;

-- Sep 8, 2022, 4:33:07 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200023
;

-- Sep 8, 2022, 4:33:07 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200023
;

-- Sep 8, 2022, 4:33:07 PM CEST
DELETE FROM C_Order WHERE C_Order_ID=200023
;

-- Sep 8, 2022, 4:33:08 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200024,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:08','YYYY-MM-DD HH24:MI:SS'),100,'50039','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),101,106,100,'I',0,'P','5',0,0,50002,101,'N',118,0,'N',113,'Y','A','I','P','Y','N','N','N','N',118,'N',113,'N',114,'N',0,0,0,0,200003,0,'N','c0f8bbdd-1b06-48c1-b948-285fe597ccff','N','N')
;

-- Sep 8, 2022, 4:33:09 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200070,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:08','YYYY-MM-DD HH24:MI:SS'),100,200024,10,TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),133,100,50002,1,0,0,0,100,33,33.75,109,118,0,113,33.75,27,-2.27,0,'N','N',33.75,1,0,0,0,'0d35f485-d764-42af-98a9-87708821e424','N','N')
;

-- Sep 8, 2022, 4:33:09 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:09 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:09 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200071,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:09','YYYY-MM-DD HH24:MI:SS'),100,200024,20,TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),124,100,50002,1,0,0,0,100,60,57,109,118,0,113,57,54,5.00,0,'N','N',57,1,0,0,0,'e681860a-ae11-47cd-83d7-2590002206b0','N','N')
;

-- Sep 8, 2022, 4:33:09 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:09 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:10 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200072,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:10','YYYY-MM-DD HH24:MI:SS'),100,200024,30,TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),148,100,50002,4,0,0,0,100,15,15,109,118,0,113,60,15,0.00,0,'N','N',15,4,0,0,0,'9db47a03-f65d-479f-a322-318dc05183a0','N','N')
;

-- Sep 8, 2022, 4:33:10 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:10 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:11 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200073,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:10','YYYY-MM-DD HH24:MI:SS'),100,200024,40,TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),123,100,50002,1,0,0,0,100,65,61.75,109,118,0,113,61.75,58.5,5.00,0,'N','N',61.75,1,0,0,0,'df3e6e07-be57-42a7-9507-10f1aeb63f14','N','N')
;

-- Sep 8, 2022, 4:33:11 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:11 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:11 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200074,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:11','YYYY-MM-DD HH24:MI:SS'),100,200024,50,TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),144,100,50002,1,0,0,0,100,35,31.5,109,118,0,113,31.5,28,10.00,0,'N','N',31.5,1,0,0,0,'52662e4e-c911-4f10-bbd5-c3995333cefd','N','N')
;

-- Sep 8, 2022, 4:33:11 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:11 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:12 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200075,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:12','YYYY-MM-DD HH24:MI:SS'),100,200024,60,TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-10','YYYY-MM-DD'),125,100,50002,1,0,0,0,100,80,76,109,118,0,113,76,72,5.00,0,'N','N',76,1,0,0,0,'bee67457-cf5d-4c2f-9a3b-53ba5d4afc51','N','N')
;

-- Sep 8, 2022, 4:33:12 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:12 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:33:13 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200025,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:12','YYYY-MM-DD HH24:MI:SS'),100,'50036','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),101,106,100,'D',0,'P','5',0,0,50002,101,'N',120,105,0,'N',114,'Y','A','I','P','Y','N','N','N','N',105,120,'N',114,'N',114,'N',0,0,0,0,200003,0,'N','8036a064-4e2e-4e21-8316-56d2504a6f18','N','N')
;

-- Sep 8, 2022, 4:33:13 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200076,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:13','YYYY-MM-DD HH24:MI:SS'),100,200025,10,TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),141,100,50002,21,0,0,0,100,3,2.7,109,120,0,114,56.7,2.4,10.00,0,'N','N',2.7,21,0,0,0,'15e5e390-bceb-48a3-9f03-a6eaa26c4b96','N','N')
;

-- Sep 8, 2022, 4:33:13 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:33:13 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:33:14 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200077,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:14','YYYY-MM-DD HH24:MI:SS'),100,200025,20,TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),130,100,50002,1,0,0,0,100,50,47.5,109,120,0,114,47.5,45,5.00,0,'N','N',47.5,1,0,0,0,'65c6f337-d4ca-455c-828e-aecefe4eed81','N','N')
;

-- Sep 8, 2022, 4:33:14 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:33:14 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:33:15 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200078,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:14','YYYY-MM-DD HH24:MI:SS'),100,200025,30,TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),129,100,50002,9,0,0,0,100,40,38,109,120,0,114,342,36,5.00,0,'N','N',38,9,0,0,0,'b27ddd64-54dd-425c-96c9-a40aa1b36afd','N','N')
;

-- Sep 8, 2022, 4:33:15 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:33:15 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:33:15 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200079,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:15','YYYY-MM-DD HH24:MI:SS'),100,200025,40,TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),140,100,50002,7,0,0,0,100,12,10.8,109,120,0,114,75.6,9.6,10.00,0,'N','N',10.8,7,0,0,0,'b3f8a236-2a8d-43e3-b0ae-d65c6ee8d379','N','N')
;

-- Sep 8, 2022, 4:33:15 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:33:15 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:33:16 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200080,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:16','YYYY-MM-DD HH24:MI:SS'),100,200025,50,TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-17','YYYY-MM-DD'),132,101,50002,1.00,0,0,0,100,100,90,109,120,0,114,90.00,80,10.00,0,'N','N',90,1.00,0,0,0,'be5fc0e4-bb61-4b7d-a806-b040f9a4ffa7','N','N')
;

-- Sep 8, 2022, 4:33:16 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:33:16 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:33:17 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200026,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:16','YYYY-MM-DD HH24:MI:SS'),100,'50035','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',50005,0,'N',50000,'Y','A','I','P','N','N','N','N','N',50005,'N',50000,'N',114,'N',0,0,0,0,200003,0,'N','98ec1c5d-7503-4eb2-9567-4b00ac909479','N','N')
;

-- Sep 8, 2022, 4:33:17 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200081,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:17','YYYY-MM-DD HH24:MI:SS'),100,200026,10,TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),139,100,50002,2,0,0,0,100,9,8.1,109,50005,0,50000,16.2,7.2,10.00,0,'N','N',8.1,2,0,0,0,'147b74b6-e061-4ccd-9c9c-471b81d20fc1','N','N')
;

-- Sep 8, 2022, 4:33:17 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:33:17 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:33:18 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200082,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:18','YYYY-MM-DD HH24:MI:SS'),100,200026,20,TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),125,100,50002,1,0,0,0,100,80,76,109,50005,0,50000,76,72,5.00,0,'N','N',76,1,0,0,0,'e2b6a994-c4bb-4634-b75f-6c98ac626539','N','N')
;

-- Sep 8, 2022, 4:33:18 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:33:18 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:33:19 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200083,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:18','YYYY-MM-DD HH24:MI:SS'),100,200026,30,TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),147,100,50002,1,0,0,0,100,15,15,109,50005,0,50000,15,15,0.00,0,'N','N',15,1,0,0,0,'7811bbce-6212-4f9c-bdef-2ff558ccedaf','N','N')
;

-- Sep 8, 2022, 4:33:19 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:33:19 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:33:19 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200084,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:19','YYYY-MM-DD HH24:MI:SS'),100,200026,40,TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-28','YYYY-MM-DD'),123,100,50002,1,0,0,0,100,65,61.75,109,50005,0,50000,61.75,58.5,5.00,0,'N','N',61.75,1,0,0,0,'679daafc-9926-48f5-ad08-c44c75ca4f3d','N','N')
;

-- Sep 8, 2022, 4:33:19 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:33:19 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:33:20 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200027,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:19','YYYY-MM-DD HH24:MI:SS'),100,'50033','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-12-19','YYYY-MM-DD'),TO_TIMESTAMP('2021-12-19','YYYY-MM-DD'),TO_TIMESTAMP('2021-12-19','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',50007,0,'N',50002,'Y','A','I','P','N','N','N','N','N',50007,'N',50002,'N',114,'N',0,0,0,0,200003,0,'N','7f9ae6ad-bfa4-4c9b-881a-337a492eb56a','N','N')
;

-- Sep 8, 2022, 4:33:20 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200085,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:20','YYYY-MM-DD HH24:MI:SS'),100,200027,10,TO_TIMESTAMP('2021-12-19','YYYY-MM-DD'),TO_TIMESTAMP('2021-12-19','YYYY-MM-DD'),133,100,50002,3,0,0,0,100,33,33.75,109,50007,0,50002,101.25,27,-2.27,0,'N','N',33.75,3,0,0,0,'a19437f3-e0b5-43eb-9630-dcae1564d9d0','N','N')
;

-- Sep 8, 2022, 4:33:20 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200027
;

-- Sep 8, 2022, 4:33:20 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200027
;

-- Sep 8, 2022, 4:33:21 PM CEST
DELETE FROM AD_Attachment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:21 PM CEST
DELETE FROM AD_Archive WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:21 PM CEST
DELETE FROM AD_Note WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:21 PM CEST
DELETE FROM AD_PostIt WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:21 PM CEST
DELETE FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:21 PM CEST
DELETE FROM C_OrderLine WHERE C_OrderLine_ID=200085
;

-- Sep 8, 2022, 4:33:21 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200027
;

-- Sep 8, 2022, 4:33:21 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200027
;

-- Sep 8, 2022, 4:33:21 PM CEST
DELETE FROM C_Order WHERE C_Order_ID=200027
;

-- Sep 8, 2022, 4:33:22 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,Description,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,POReference,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200028,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:21','YYYY-MM-DD HH24:MI:SS'),100,'50032','DR','CO',0,132,'Order Description from Business Partner Definition','N','N','N','N','N','N',TO_TIMESTAMP('2021-05-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-11','YYYY-MM-DD'),101,106,100,'I',0,'P','5',0,0,50002,101,'N',117,104,'Order Reference 1234',0,'N',112,'Y','A','I','P','Y','N','N','N','N',104,117,'N',112,'N',114,'N',0,0,0,0,200003,0,'N','636d68b1-b83d-4872-89b7-30a078678b3f','N','N')
;

-- Sep 8, 2022, 4:33:22 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200086,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:22','YYYY-MM-DD HH24:MI:SS'),100,200028,10,TO_TIMESTAMP('2021-05-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-11','YYYY-MM-DD'),123,100,50002,1,0,0,0,100,65,61.75,109,117,0,112,61.75,58.5,5.00,0,'N','N',61.75,1,0,0,0,'5f8b6b36-b00f-4d04-8644-75fa1e500b43','N','N')
;

-- Sep 8, 2022, 4:33:22 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200028
;

-- Sep 8, 2022, 4:33:22 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200028
;

-- Sep 8, 2022, 4:33:23 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200087,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:23','YYYY-MM-DD HH24:MI:SS'),100,200028,20,TO_TIMESTAMP('2021-05-11','YYYY-MM-DD'),TO_TIMESTAMP('2021-05-11','YYYY-MM-DD'),137,100,50002,1,0,0,0,100,3,3,109,117,0,112,3,2.7,0.00,0,'N','N',3,1,0,0,0,'b96a2a76-fdef-412f-91d1-ac71a043c744','N','N')
;

-- Sep 8, 2022, 4:33:23 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200028
;

-- Sep 8, 2022, 4:33:23 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200028
;

-- Sep 8, 2022, 4:33:23 PM CEST
DELETE FROM AD_Attachment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:23 PM CEST
DELETE FROM AD_Archive WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:23 PM CEST
DELETE FROM AD_Note WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:23 PM CEST
DELETE FROM AD_PostIt WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:23 PM CEST
DELETE FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:23 PM CEST
DELETE FROM C_OrderLine WHERE C_OrderLine_ID=200086
;

-- Sep 8, 2022, 4:33:23 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200028
;

-- Sep 8, 2022, 4:33:23 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200028
;

-- Sep 8, 2022, 4:33:23 PM CEST
DELETE FROM C_OrderLine WHERE C_OrderLine_ID=200087
;

-- Sep 8, 2022, 4:33:23 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200028
;

-- Sep 8, 2022, 4:33:23 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200028
;

-- Sep 8, 2022, 4:33:23 PM CEST
DELETE FROM C_Order WHERE C_Order_ID=200028
;

-- Sep 8, 2022, 4:33:24 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200029,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:24','YYYY-MM-DD HH24:MI:SS'),100,'50029','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-08-31','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-31','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-31','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',114,103,0,'N',109,'Y','A','I','P','Y','N','N','N','N',103,114,'N',109,'N',114,'N',0,0,0,0,200003,0,'N','df13d1ec-8840-45e8-b42e-e9258588de0a','N','N')
;

-- Sep 8, 2022, 4:33:25 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200088,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:24','YYYY-MM-DD HH24:MI:SS'),100,200029,10,TO_TIMESTAMP('2021-08-31','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-31','YYYY-MM-DD'),125,100,50002,2,0,0,0,100,80,76,109,114,0,109,152,72,5.00,0,'N','N',76,2,0,0,0,'6ca02d47-cbe1-4fb0-9246-9c70dfe83137','N','N')
;

-- Sep 8, 2022, 4:33:25 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:33:25 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:33:25 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200089,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:25','YYYY-MM-DD HH24:MI:SS'),100,200029,20,TO_TIMESTAMP('2021-08-31','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-31','YYYY-MM-DD'),123,100,50002,1,0,0,0,100,65,61.75,109,114,0,109,61.75,58.5,5.00,0,'N','N',61.75,1,0,0,0,'7fb995d0-1fa7-476a-90b7-4137ddfc1bb2','N','N')
;

-- Sep 8, 2022, 4:33:25 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:33:25 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:33:26 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200030,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:25','YYYY-MM-DD HH24:MI:SS'),100,'50028','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',50009,0,'N',50004,'Y','A','I','P','N','N','N','N','N',50009,'N',50004,'N',114,'N',0,0,0,0,200003,0,'N','7515b9f8-3799-4629-9086-11fc806e8b40','N','N')
;

-- Sep 8, 2022, 4:33:26 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200090,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:26','YYYY-MM-DD HH24:MI:SS'),100,200030,10,TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),125,100,50002,1,0,0,0,100,80,76,109,50009,0,50004,76,72,5.00,0,'N','N',76,1,0,0,0,'0a7bdb65-07a4-404c-a646-6626298bec74','N','N')
;

-- Sep 8, 2022, 4:33:26 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:33:26 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:33:27 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200091,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:27','YYYY-MM-DD HH24:MI:SS'),100,200030,20,TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),124,100,50002,1,0,0,0,100,60,57,109,50009,0,50004,57,54,5.00,0,'N','N',57,1,0,0,0,'9d34c261-5f42-4e20-9d27-4162427b4dcc','N','N')
;

-- Sep 8, 2022, 4:33:27 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:33:27 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:33:28 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200092,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:27','YYYY-MM-DD HH24:MI:SS'),100,200030,30,TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),128,100,50002,2,0,0,0,100,25,23.75,109,50009,0,50004,47.50,22.5,5.00,0,'N','N',23.75,2,0,0,0,'366a3484-fe76-460e-ba5e-b20f5e0ecc66','N','N')
;

-- Sep 8, 2022, 4:33:28 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:33:28 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:33:28 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200093,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:28','YYYY-MM-DD HH24:MI:SS'),100,200030,40,TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-18','YYYY-MM-DD'),129,100,50002,2,0,0,0,100,40,38,109,50009,0,50004,76,36,5.00,0,'N','N',38,2,0,0,0,'301f66e5-de66-40b7-85a0-f426b6c8632c','N','N')
;

-- Sep 8, 2022, 4:33:28 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:33:28 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:33:29 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200031,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:29','YYYY-MM-DD HH24:MI:SS'),100,'50026','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-07-30','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-30','YYYY-MM-DD'),TO_TIMESTAMP('2021-07-30','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',50008,0,'N',50003,'Y','A','I','P','N','N','N','N','N',50008,'N',50003,'N',114,'N',0,0,0,0,200003,0,'N','1bedc702-f23d-4fe8-8ade-e3a217738a31','N','N')
;

-- Sep 8, 2022, 4:33:29 PM CEST
DELETE FROM AD_Attachment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:29 PM CEST
DELETE FROM AD_Archive WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:29 PM CEST
DELETE FROM AD_Note WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:29 PM CEST
DELETE FROM AD_PostIt WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:29 PM CEST
DELETE FROM AD_LabelAssignment WHERE AD_Table_ID=? AND Record_ID IN (SELECT C_OrderLine_ID FROM C_OrderLine WHERE C_Order_ID=?)
;

-- Sep 8, 2022, 4:33:29 PM CEST
DELETE FROM C_Order WHERE C_Order_ID=200031
;

-- Sep 8, 2022, 4:33:30 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,Description,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,POReference,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200032,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:30','YYYY-MM-DD HH24:MI:SS'),100,'50024','DR','CO',0,132,'Order Description from Business Partner Definition','N','N','N','N','N','N',TO_TIMESTAMP('2021-02-12','YYYY-MM-DD'),TO_TIMESTAMP('2021-02-12','YYYY-MM-DD'),TO_TIMESTAMP('2021-02-12','YYYY-MM-DD'),102,106,100,'I',0,'P','5',0,0,50002,101,'N',117,104,'Order Reference 1234',0,'N',112,'Y','A','I','P','Y','N','N','N','N',104,117,'N',112,'N',114,'N',0,0,0,0,200003,0,'N','62870617-2b06-4e08-a89a-f024c2fd8a9d','N','N')
;

-- Sep 8, 2022, 4:33:30 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200094,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:30','YYYY-MM-DD HH24:MI:SS'),100,200032,10,TO_TIMESTAMP('2021-02-12','YYYY-MM-DD'),TO_TIMESTAMP('2021-02-12','YYYY-MM-DD'),125,100,50002,1,0,0,0,100,80,76,109,117,0,112,76,72,5.00,0,'N','N',76,1,0,0,0,'622ba817-9997-443e-bd64-88795ac2abf0','N','N')
;

-- Sep 8, 2022, 4:33:30 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:33:30 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:33:31 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200095,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:31','YYYY-MM-DD HH24:MI:SS'),100,200032,20,TO_TIMESTAMP('2021-02-12','YYYY-MM-DD'),TO_TIMESTAMP('2021-02-12','YYYY-MM-DD'),141,100,50002,81,0,0,0,100,3,2.7,109,117,0,112,218.7,2.4,10.00,0,'N','N',2.7,81,0,0,0,'5f577c3d-7cb7-415f-bcab-b9f9889d0983','N','N')
;

-- Sep 8, 2022, 4:33:31 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:33:31 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:33:32 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200033,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:31','YYYY-MM-DD HH24:MI:SS'),100,'50021','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-03-14','YYYY-MM-DD'),TO_TIMESTAMP('2021-03-14','YYYY-MM-DD'),TO_TIMESTAMP('2021-03-14','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',112,0,'N',108,'Y','A','I','P','Y','N','N','N','N',112,'N',108,'N',114,'N',0,0,0,0,200003,0,'N','208533d0-c6df-496d-84d9-df9b40ac367d','N','N')
;

-- Sep 8, 2022, 4:33:32 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200096,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:32','YYYY-MM-DD HH24:MI:SS'),100,200033,10,TO_TIMESTAMP('2021-03-14','YYYY-MM-DD'),TO_TIMESTAMP('2021-03-14','YYYY-MM-DD'),139,100,50002,11,0,0,0,100,9,8.1,109,112,0,108,89.1,7.2,10.00,0,'N','N',8.1,11,0,0,0,'b2c54d49-b1da-47e9-841c-3ecda1624884','N','N')
;

-- Sep 8, 2022, 4:33:32 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:33:32 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:33:33 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200097,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:33','YYYY-MM-DD HH24:MI:SS'),100,200033,20,TO_TIMESTAMP('2021-03-14','YYYY-MM-DD'),TO_TIMESTAMP('2021-03-14','YYYY-MM-DD'),126,101,50002,3.00,0,0,0,100,45,42.75,109,112,0,108,128.25,40.5,5.00,0,'N','N',42.75,3.00,0,0,0,'39e64bcb-d9d1-4830-8bf8-527403b5c5df','N','N')
;

-- Sep 8, 2022, 4:33:33 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:33:33 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:33:33 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200034,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:33','YYYY-MM-DD HH24:MI:SS'),100,'50020','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),102,105,100,'D',0,'P','5',0,0,50002,101,'N',121,0,'N',115,'Y','A','I','P','Y','N','N','N','N',121,'N',115,'N',114,'N',0,0,0,0,200003,0,'N','07b79712-c860-4dff-99e7-a8337fd75b1f','N','N')
;

-- Sep 8, 2022, 4:33:34 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200098,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:34','YYYY-MM-DD HH24:MI:SS'),100,200034,10,TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),141,100,50002,3,0,0,0,100,3,2.7,109,121,0,115,8.1,2.4,10.00,0,'N','N',2.7,3,0,0,0,'e16d9724-d68f-4ade-95ec-243c92c97af8','N','N')
;

-- Sep 8, 2022, 4:33:34 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:34 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:35 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200099,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:34','YYYY-MM-DD HH24:MI:SS'),100,200034,20,TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),50007,100,50002,1,0,0,0,100,35.00,33.00,109,121,0,115,33.00,30.00,5.71,0,'N','N',33.00,1,0,0,0,'ed2f03ce-6e05-4d8d-a1db-ff83808e7f41','N','N')
;

-- Sep 8, 2022, 4:33:35 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:35 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:35 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200100,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:35','YYYY-MM-DD HH24:MI:SS'),100,200034,30,TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),143,100,50002,1,0,0,0,100,30,27,109,121,0,115,27,24,10.00,0,'N','N',27,1,0,0,0,'65efe8c4-9dfe-4892-b851-3a5918961ab4','N','N')
;

-- Sep 8, 2022, 4:33:35 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:35 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:36 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200101,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:36','YYYY-MM-DD HH24:MI:SS'),100,200034,40,TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),139,100,50002,2,0,0,0,100,9,8.1,109,121,0,115,16.2,7.2,10.00,0,'N','N',8.1,2,0,0,0,'43be31e8-947e-4995-a34b-d4e494f09f2a','N','N')
;

-- Sep 8, 2022, 4:33:36 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:36 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:37 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200102,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:36','YYYY-MM-DD HH24:MI:SS'),100,200034,50,TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),134,100,50002,1,0,0,0,100,66,67.5,109,121,0,115,67.5,54,-2.27,0,'N','N',67.5,1,0,0,0,'8f6d1723-5270-4460-a9ed-1adf1cbc8dbd','N','N')
;

-- Sep 8, 2022, 4:33:37 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:37 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:37 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200103,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:37','YYYY-MM-DD HH24:MI:SS'),100,200034,60,TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),129,100,50002,5,0,0,0,100,40,38,109,121,0,115,190,36,5.00,0,'N','N',38,5,0,0,0,'d028ace4-e4ff-4652-90f4-6e6a7f0d0928','N','N')
;

-- Sep 8, 2022, 4:33:37 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:37 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:38 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200104,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:38','YYYY-MM-DD HH24:MI:SS'),100,200034,70,TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),TO_TIMESTAMP('2021-11-07','YYYY-MM-DD'),137,100,50002,1,0,0,0,100,3,3,109,121,0,115,3,2.7,0.00,0,'N','N',3,1,0,0,0,'59cd39a8-3b8c-4848-aee3-dbe61b5735e6','N','N')
;

-- Sep 8, 2022, 4:33:38 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:38 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:33:38 PM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200035,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:38','YYYY-MM-DD HH24:MI:SS'),100,'50019','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2021-08-15','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-15','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-15','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,50002,101,'N',50007,0,'N',50002,'Y','A','I','P','N','N','N','N','N',50007,'N',50002,'N',114,'N',0,0,0,0,200003,0,'N','2cfb25a9-5a1c-44c7-b9fc-ee219970bdfc','N','N')
;

-- Sep 8, 2022, 4:33:39 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200105,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:39','YYYY-MM-DD HH24:MI:SS'),100,200035,10,TO_TIMESTAMP('2021-08-15','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-15','YYYY-MM-DD'),127,100,50002,5,0,0,0,100,30,28.5,109,50007,0,50002,142.5,27,5.00,0,'N','N',28.5,5,0,0,0,'4c61fc88-1ef5-407a-9154-68f31eecdc8b','N','N')
;

-- Sep 8, 2022, 4:33:39 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:33:39 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:33:40 PM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200106,11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:33:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:33:40','YYYY-MM-DD HH24:MI:SS'),100,200035,20,TO_TIMESTAMP('2021-08-15','YYYY-MM-DD'),TO_TIMESTAMP('2021-08-15','YYYY-MM-DD'),130,100,50002,2,0,0,0,100,50,47.5,109,50007,0,50002,95.0,45,5.00,0,'N','N',47.5,2,0,0,0,'111d5bcf-2a0e-4a78-aa7f-a9b930f31ae4','N','N')
;

-- Sep 8, 2022, 4:33:40 PM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:33:40 PM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:34:26 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:34:26','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:34:26','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200007,'50077: Grand Total=418.0',259,0,200004,'75aa2963-d5bd-41d6-8b36-3ab1327b0187')
;

-- Sep 8, 2022, 4:34:26 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:34:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200007
;

-- Sep 8, 2022, 4:34:27 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200019,200007,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:34:26','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:34:26','YYYY-MM-DD HH24:MI:SS'),116,0,200004,259,'ff1dae74-fea3-42bd-abf5-44c9a7c106f2')
;

-- Sep 8, 2022, 4:34:27 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),200019,'PC',200007,259,183,200004,0.0,'e80ebeb8-1aad-4416-a3a9-bb7cd2084864')
;

-- Sep 8, 2022, 4:34:27 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200019
;

-- Sep 8, 2022, 4:34:27 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200019
;

-- Sep 8, 2022, 4:34:27 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200019
;

-- Sep 8, 2022, 4:34:27 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=293,Updated=TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200019
;

-- Sep 8, 2022, 4:34:27 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200019
;

-- Sep 8, 2022, 4:34:27 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200020,200007,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),116,0,200004,259,'d31e1d46-9a6e-48de-8776-9d1f4805906e')
;

-- Sep 8, 2022, 4:34:27 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),200020,'PC',200007,259,185,200004,0.0,'7479951f-d6d3-466c-bb11-7d27178ae14b')
;

-- Sep 8, 2022, 4:34:27 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200020
;

-- Sep 8, 2022, 4:34:27 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200020
;

-- Sep 8, 2022, 4:34:27 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,124,0.0,TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),100,'Y','68a42210-a893-4b6e-87d8-44e3a5ee1b69')
;

-- Sep 8, 2022, 4:34:27 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:34:28 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:34:27','YYYY-MM-DD HH24:MI:SS'),100,'Y',200000,'a050a5da-44cb-4dd0-9b1d-227a9e612723',132,'50077',60,260,200010,50002,124,0,'Y',0.0,1,1.0)
;

-- Sep 8, 2022, 4:34:28 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=57, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200010
;

-- Sep 8, 2022, 4:34:28 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,129,0.0,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y','fab7e818-5398-4d05-85f9-aeb043e977f6')
;

-- Sep 8, 2022, 4:34:28 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:34:28 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',200001,'4bcc294a-b149-4de4-8fa3-1ba1612a3d5c',132,'50077',40,260,200008,50002,129,0,'Y',0.0,1,1.0)
;

-- Sep 8, 2022, 4:34:28 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=38, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200008
;

-- Sep 8, 2022, 4:34:28 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,130,0.0,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y','ecb0198f-d373-4754-972f-ef0aa0b33dd4')
;

-- Sep 8, 2022, 4:34:28 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:34:28 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',200002,'3ede40ca-794e-4a47-b60f-3e3f271a47b8',132,'50077',50,260,200009,50002,130,0,'Y',0.0,6,6.0)
;

-- Sep 8, 2022, 4:34:28 PM CEST
UPDATE C_OrderLine SET QtyReserved=6, LineNetAmt=285.0, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200009
;

-- Sep 8, 2022, 4:34:28 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,136,0.0,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y','a3bf0848-60f2-4c86-9804-2a6fb3e6d746')
;

-- Sep 8, 2022, 4:34:28 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:34:28 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',200003,'d405a41c-1a86-4ca3-b46a-247a72950801',132,'50077',30,260,200007,50002,136,0,'Y',0.0,1,1.0)
;

-- Sep 8, 2022, 4:34:28 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=20, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200007
;

-- Sep 8, 2022, 4:34:28 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,137,0.0,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y','a81dd632-a1e5-4b52-a747-e7dc7a65d433')
;

-- Sep 8, 2022, 4:34:28 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:34:29 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:34:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',200004,'782fc74e-e6a9-46a2-9b50-7ddf99291465',132,'50077',10,260,200005,50002,137,0,'Y',0.0,1,1.0)
;

-- Sep 8, 2022, 4:34:29 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=3, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200005
;

-- Sep 8, 2022, 4:34:29 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,147,0.0,TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),100,'Y','1126958a-6403-4b27-9f63-512e342dc488')
;

-- Sep 8, 2022, 4:34:29 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:34:29 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',200005,'16480bb1-8e41-49f9-831a-55f5b76f1ad5',132,'50077',20,260,200006,50002,147,0,'Y',0.0,1,1.0)
;

-- Sep 8, 2022, 4:34:29 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=15, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200006
;

-- Sep 8, 2022, 4:34:29 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:34:29 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),100,200004,109,418.0,0.0,'N','N','9a5744c3-596a-4986-b8aa-d006653a7230')
;

-- Sep 8, 2022, 4:34:29 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=418.0, GrandTotal=418.0, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:34:29 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50077: Grand Total=418.0 (#6)',Updated=TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200020
;

-- Sep 8, 2022, 4:34:29 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50077: Grand Total=418.0 (#6)', ElapsedTimeMS=2646,Updated=TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200020
;

-- Sep 8, 2022, 4:34:29 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200020
;

-- Sep 8, 2022, 4:34:29 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200021,200007,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),116,0,200004,259,'debfb84e-9444-42b6-bc65-1e98b63551a8')
;

-- Sep 8, 2022, 4:34:30 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:34:29','YYYY-MM-DD HH24:MI:SS'),200021,'PC',200007,259,186,200004,0.0,'16d1b451-0ac4-48ff-84a8-984f25a4ef49')
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200021
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200021
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647670206.2068,Updated=TO_TIMESTAMP('2022-09-08 16:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200004 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:34:30 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200004 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200004 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:34:30 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200004 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200004
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50077: Grand Total=418.0',Updated=TO_TIMESTAMP('2022-09-08 16:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200021
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50077: Grand Total=418.0', ElapsedTimeMS=1258,Updated=TO_TIMESTAMP('2022-09-08 16:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200021
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200021
;

-- Sep 8, 2022, 4:34:30 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200007
;

-- Sep 8, 2022, 4:35:35 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:35:34','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:35:34','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200008,'50075: Grand Total=27',259,0,200006,'d454de20-d60e-4770-a15c-b856274ed8b6')
;

-- Sep 8, 2022, 4:35:35 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200008
;

-- Sep 8, 2022, 4:35:35 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200022,200008,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),116,0,200006,259,'045642b8-3c7a-4069-89ad-5a09ca7a9396')
;

-- Sep 8, 2022, 4:35:35 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),200022,'PC',200008,259,183,200006,0.0,'a491a6a6-5a27-4b21-9b26-71a0905918fc')
;

-- Sep 8, 2022, 4:35:35 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200022
;

-- Sep 8, 2022, 4:35:35 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200022
;

-- Sep 8, 2022, 4:35:35 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200022
;

-- Sep 8, 2022, 4:35:35 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=716,Updated=TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200022
;

-- Sep 8, 2022, 4:35:35 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200022
;

-- Sep 8, 2022, 4:35:35 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200023,200008,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),116,0,200006,259,'e704a8c6-2bfa-4095-b213-1e05dde846f1')
;

-- Sep 8, 2022, 4:35:36 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:35','YYYY-MM-DD HH24:MI:SS'),200023,'PC',200008,259,185,200006,0.0,'7f2625f6-b932-4d10-abca-dbcbd54c94d5')
;

-- Sep 8, 2022, 4:35:36 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200023
;

-- Sep 8, 2022, 4:35:36 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200023
;

-- Sep 8, 2022, 4:35:36 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:35:36 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),100,'Y',200006,'581576b8-df24-48fe-997b-6b45da0b1b12',132,'50075',10,260,200014,50002,137,0,'Y',1.0,9,10.0)
;

-- Sep 8, 2022, 4:35:36 PM CEST
UPDATE C_OrderLine SET QtyReserved=9, LineNetAmt=27, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200014
;

-- Sep 8, 2022, 4:35:36 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200006
;

-- Sep 8, 2022, 4:35:36 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),100,200006,109,27.0,0.0,'N','N','e05f2a5e-c75b-4aaa-9dc8-ebc8f774b085')
;

-- Sep 8, 2022, 4:35:36 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=27.0, GrandTotal=27.0, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200006
;

-- Sep 8, 2022, 4:35:36 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50075: Grand Total=27.0 (#1)',Updated=TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200023
;

-- Sep 8, 2022, 4:35:36 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50075: Grand Total=27.0 (#1)', ElapsedTimeMS=1536,Updated=TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200023
;

-- Sep 8, 2022, 4:35:36 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200023
;

-- Sep 8, 2022, 4:35:36 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200024,200008,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),116,0,200006,259,'47da3b86-955d-4c7f-a483-ca716bf71f44')
;

-- Sep 8, 2022, 4:35:37 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:36','YYYY-MM-DD HH24:MI:SS'),200024,'PC',200008,259,186,200006,0.0,'b09b8188-6060-431f-9871-cc1da419c358')
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200024
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200024
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200006
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200006
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647737109.1091,Updated=TO_TIMESTAMP('2022-09-08 16:35:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200006
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200006 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:35:37 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200006 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200006
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200006 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:35:37 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200006 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200006
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200006
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50075: Grand Total=27.0',Updated=TO_TIMESTAMP('2022-09-08 16:35:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200024
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50075: Grand Total=27.0', ElapsedTimeMS=1136,Updated=TO_TIMESTAMP('2022-09-08 16:35:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200024
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200024
;

-- Sep 8, 2022, 4:35:37 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:35:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200008
;

-- Sep 8, 2022, 4:35:41 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200009,'50071: Grand Total=81.60 - Order Description from Business Partner Definition',259,0,200007,'7a5545f4-015f-492f-9938-b214cf94a90e')
;

-- Sep 8, 2022, 4:35:41 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200009
;

-- Sep 8, 2022, 4:35:41 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200025,200009,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),116,0,200007,259,'7342e4a8-39a3-4eee-87df-1a624c54407a')
;

-- Sep 8, 2022, 4:35:41 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),200025,'PC',200009,259,183,200007,0.0,'3647b019-a84e-4c9b-9d56-3e35aa494568')
;

-- Sep 8, 2022, 4:35:41 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200025
;

-- Sep 8, 2022, 4:35:41 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200025
;

-- Sep 8, 2022, 4:35:41 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200025
;

-- Sep 8, 2022, 4:35:41 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=986,Updated=TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200025
;

-- Sep 8, 2022, 4:35:41 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200025
;

-- Sep 8, 2022, 4:35:42 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200026,200009,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:41','YYYY-MM-DD HH24:MI:SS'),116,0,200007,259,'c39995db-13e8-4efc-89c5-225349987191')
;

-- Sep 8, 2022, 4:35:42 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),200026,'PC',200009,259,185,200007,0.0,'b6285875-a70e-442d-b7eb-aceaafef0d3a')
;

-- Sep 8, 2022, 4:35:42 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200026
;

-- Sep 8, 2022, 4:35:42 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200026
;

-- Sep 8, 2022, 4:35:42 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:35:42 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),100,'Y',200007,'74740c49-7e6e-4e53-bd52-945b4210fb52',132,'50071',20,260,200015,50002,137,0,'Y',10.0,1,11.0)
;

-- Sep 8, 2022, 4:35:42 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=3, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200015
;

-- Sep 8, 2022, 4:35:42 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,142,0.0,TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),100,'Y','c9353642-b356-4972-9f49-dddcbd4509d6')
;

-- Sep 8, 2022, 4:35:42 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:35:43 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),100,'Y',200008,'41915475-a168-47de-87e1-7aa93664abb7',132,'50071',40,260,200017,50002,142,0,'Y',0.0,4,4.0)
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_OrderLine SET QtyReserved=4, LineNetAmt=12.60, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200017
;

-- Sep 8, 2022, 4:35:43 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,50007,0.0,TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),100,'Y','e85976c0-e50a-4af5-99e1-d715dde5a1e3')
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:35:43 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),100,'Y',200009,'95276265-b877-4f48-be14-670409f11c58',132,'50071',30,260,200016,50002,50007,0,'Y',0.0,2,2.0)
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=66.00, Discount=5.71,Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200016
;

-- Sep 8, 2022, 4:35:43 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:35:43 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),100,200007,109,81.60,0.0,'N','N','ad9f8288-038c-4be8-8e28-bcce251aaf9a')
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=81.60, GrandTotal=81.60, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50071: Grand Total=81.60 (#3) - Order Description from Business Partner Definition',Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200026
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50071: Grand Total=81.60 (#3) - Order Description from Business Partner Definition', ElapsedTimeMS=1349,Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200026
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200026
;

-- Sep 8, 2022, 4:35:43 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200027,200009,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),116,0,200007,259,'eace1ac1-94a1-4fc7-9370-f4878ce63306')
;

-- Sep 8, 2022, 4:35:43 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),200027,'PC',200009,259,186,200007,0.0,'e2143887-0cf5-47ad-96af-afe2c452a9aa')
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200027
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200027
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647743884.885,Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200007 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:35:43 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200007 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200007 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:35:43 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200007 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200007
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50071: Grand Total=81.60 - Order Description from Business Partner Definition',Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200027
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50071: Grand Total=81.60 - Order Description from Business Partner Definition', ElapsedTimeMS=910,Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200027
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200027
;

-- Sep 8, 2022, 4:35:43 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:35:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200009
;

-- Sep 8, 2022, 4:35:47 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:35:47','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:35:47','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200010,'50062: Grand Total=370.50',259,0,200009,'b956c6ac-c58f-4173-83ee-b4af314c6a98')
;

-- Sep 8, 2022, 4:35:47 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200010
;

-- Sep 8, 2022, 4:35:48 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200028,200010,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:47','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:47','YYYY-MM-DD HH24:MI:SS'),116,0,200009,259,'753bc666-fe69-42ca-802d-ba2ce329ed05')
;

-- Sep 8, 2022, 4:35:48 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),200028,'PC',200010,259,183,200009,0.0,'5f7d9b82-dccb-482d-acfe-94c500d913c8')
;

-- Sep 8, 2022, 4:35:48 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200028
;

-- Sep 8, 2022, 4:35:48 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200028
;

-- Sep 8, 2022, 4:35:48 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200028
;

-- Sep 8, 2022, 4:35:48 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=458,Updated=TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200028
;

-- Sep 8, 2022, 4:35:48 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200028
;

-- Sep 8, 2022, 4:35:48 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200029,200010,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),116,0,200009,259,'001df372-887c-4c99-974d-c07b4e95064c')
;

-- Sep 8, 2022, 4:35:48 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),200029,'PC',200010,259,185,200009,0.0,'3fd2afa3-b7a8-456b-b826-ebbada5d135a')
;

-- Sep 8, 2022, 4:35:48 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200029
;

-- Sep 8, 2022, 4:35:48 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200029
;

-- Sep 8, 2022, 4:35:48 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,123,0.0,TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),100,'Y','bae91676-5c4c-482d-8668-d7173ce7ff55')
;

-- Sep 8, 2022, 4:35:48 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:35:49 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',200010,'1d974593-4fec-4b09-b6fe-ee3eaccdceca',132,'50062',10,260,200018,50002,123,0,'Y',0.0,6,6.0)
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE C_OrderLine SET QtyReserved=6, LineNetAmt=370.50, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200018
;

-- Sep 8, 2022, 4:35:49 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200009
;

-- Sep 8, 2022, 4:35:49 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),100,200009,109,370.50,0.0,'N','N','d8c46001-22d3-4374-90d3-f043d1a64dc1')
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=370.50, GrandTotal=370.50, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200009
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50062: Grand Total=370.50 (#1)',Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200029
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50062: Grand Total=370.50 (#1)', ElapsedTimeMS=1273,Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200029
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200029
;

-- Sep 8, 2022, 4:35:49 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200030,200010,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),116,0,200009,259,'ca29bb74-9327-4f38-b9fe-7b00eb1dfc4f')
;

-- Sep 8, 2022, 4:35:49 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),200030,'PC',200010,259,186,200009,0.0,'a4060f6d-a8bc-469d-8e87-e7915d7db1ba')
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200030
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200030
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200009
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200009
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647749824.8247,Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200009
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200009 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:35:49 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200009 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200009
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200009 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:35:49 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200009 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200009
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200009
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50062: Grand Total=370.50',Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200030
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50062: Grand Total=370.50', ElapsedTimeMS=852,Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200030
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200030
;

-- Sep 8, 2022, 4:35:49 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:35:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200010
;

-- Sep 8, 2022, 4:35:54 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:35:53','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:35:53','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200011,'50061: Grand Total=272.5',259,0,200010,'43295645-8afb-4367-b5ad-a200a4d29a57')
;

-- Sep 8, 2022, 4:35:54 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200011
;

-- Sep 8, 2022, 4:35:54 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200031,200011,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),116,0,200010,259,'d6835a38-0a09-408c-b26a-2e013c169b6d')
;

-- Sep 8, 2022, 4:35:54 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),200031,'PC',200011,259,183,200010,0.0,'f901e561-773e-44d9-a6d2-bdb464491427')
;

-- Sep 8, 2022, 4:35:54 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200031
;

-- Sep 8, 2022, 4:35:54 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200031
;

-- Sep 8, 2022, 4:35:54 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200031
;

-- Sep 8, 2022, 4:35:54 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=706,Updated=TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200031
;

-- Sep 8, 2022, 4:35:54 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200031
;

-- Sep 8, 2022, 4:35:54 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200032,200011,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),116,0,200010,259,'ee11cb53-3399-4196-af9b-90f2c399a655')
;

-- Sep 8, 2022, 4:35:55 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:54','YYYY-MM-DD HH24:MI:SS'),200032,'PC',200011,259,185,200010,0.0,'ed87c08d-fd35-415f-bd88-9d09c08f3819')
;

-- Sep 8, 2022, 4:35:55 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200032
;

-- Sep 8, 2022, 4:35:55 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200032
;

-- Sep 8, 2022, 4:35:55 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:35:55 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',200011,'10b55a5b-2763-4150-b8d5-e4ab37086cbf',132,'50061',10,260,200019,50002,130,0,'Y',6.0,1,7.0)
;

-- Sep 8, 2022, 4:35:55 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=47.5, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200019
;

-- Sep 8, 2022, 4:35:55 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,135,0.0,TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),100,'Y','9e51d351-398a-4684-b4ff-eb3b935f8dda')
;

-- Sep 8, 2022, 4:35:55 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:35:55 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',200012,'026ac243-5dac-4e90-a51f-08d15c9846e9',132,'50061',20,260,200020,50002,135,0,'Y',0.0,10,10.0)
;

-- Sep 8, 2022, 4:35:55 PM CEST
UPDATE C_OrderLine SET QtyReserved=10, LineNetAmt=225.0, Discount=-2.27,Updated=TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200020
;

-- Sep 8, 2022, 4:35:55 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:35:55 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),100,200010,109,272.5,0.0,'N','N','417910e1-e15e-4d93-ae4e-e83ecc003555')
;

-- Sep 8, 2022, 4:35:55 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=272.5, GrandTotal=272.5, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:35:55 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50061: Grand Total=272.5 (#2)',Updated=TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200032
;

-- Sep 8, 2022, 4:35:55 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50061: Grand Total=272.5 (#2)', ElapsedTimeMS=1806,Updated=TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200032
;

-- Sep 8, 2022, 4:35:55 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200032
;

-- Sep 8, 2022, 4:35:56 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200033,200011,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:35:55','YYYY-MM-DD HH24:MI:SS'),116,0,200010,259,'57837923-166c-4cb4-b05e-f4827d29fa9d')
;

-- Sep 8, 2022, 4:35:56 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:35:56','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:35:56','YYYY-MM-DD HH24:MI:SS'),200033,'PC',200011,259,186,200010,0.0,'c65fa35c-073f-4df9-8544-356245678703')
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200033
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200033
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647756347.3474,Updated=TO_TIMESTAMP('2022-09-08 16:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200010 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:35:56 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200010 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200010 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:35:56 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200010 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200010
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50061: Grand Total=272.5',Updated=TO_TIMESTAMP('2022-09-08 16:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200033
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50061: Grand Total=272.5', ElapsedTimeMS=370,Updated=TO_TIMESTAMP('2022-09-08 16:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200033
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200033
;

-- Sep 8, 2022, 4:35:56 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200011
;

-- Sep 8, 2022, 4:36:00 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:36:00','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:36:00','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200012,'50059: Grand Total=297.0',259,0,200012,'3a7ba2d0-4d15-4a4f-8425-68ecf8b792a4')
;

-- Sep 8, 2022, 4:36:00 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200012
;

-- Sep 8, 2022, 4:36:00 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200034,200012,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:00','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:00','YYYY-MM-DD HH24:MI:SS'),116,0,200012,259,'6d09bd3f-0292-45b2-956b-62d0fb6c3bbb')
;

-- Sep 8, 2022, 4:36:01 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:00','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:00','YYYY-MM-DD HH24:MI:SS'),200034,'PC',200012,259,183,200012,0.0,'6b55478f-c964-4a6f-a309-11c547e12cdc')
;

-- Sep 8, 2022, 4:36:01 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200034
;

-- Sep 8, 2022, 4:36:01 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200034
;

-- Sep 8, 2022, 4:36:01 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200034
;

-- Sep 8, 2022, 4:36:01 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=1253,Updated=TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200034
;

-- Sep 8, 2022, 4:36:01 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200034
;

-- Sep 8, 2022, 4:36:01 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200035,200012,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),116,0,200012,259,'cd37fb0e-e314-43ef-b411-c7b4f1840e13')
;

-- Sep 8, 2022, 4:36:01 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),200035,'PC',200012,259,185,200012,0.0,'b778e2e1-4abb-4119-9878-96b42ccc5642')
;

-- Sep 8, 2022, 4:36:01 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200035
;

-- Sep 8, 2022, 4:36:01 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200035
;

-- Sep 8, 2022, 4:36:01 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:02 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',200013,'6ae08029-5801-44f8-baf0-1846af761171',132,'50059',10,260,200023,50002,135,0,'Y',10.0,6,16.0)
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE C_OrderLine SET QtyReserved=6, LineNetAmt=135.0, Discount=-2.27,Updated=TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200023
;

-- Sep 8, 2022, 4:36:02 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,143,0.0,TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),100,'Y','53321c15-ef54-48ab-ba5f-fb9adf2d4359')
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:02 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',200014,'3cb095bc-e49a-46b8-bd72-5f2a8ffe1a4e',132,'50059',20,260,200024,50002,143,0,'Y',0.0,6,6.0)
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE C_OrderLine SET QtyReserved=6, LineNetAmt=162, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200024
;

-- Sep 8, 2022, 4:36:02 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:36:02 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),100,200012,109,297.0,0.0,'N','N','601dddfb-51db-4617-9a16-0d54a83cf7f8')
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=297.0, GrandTotal=297.0, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50059: Grand Total=297.0 (#2)',Updated=TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200035
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50059: Grand Total=297.0 (#2)', ElapsedTimeMS=1392,Updated=TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200035
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200035
;

-- Sep 8, 2022, 4:36:02 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200036,200012,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),116,0,200012,259,'bd4b2d15-c575-467b-9d8e-3945ef0dd128')
;

-- Sep 8, 2022, 4:36:02 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),200036,'PC',200012,259,186,200012,0.0,'3ca1fd7d-3526-4b57-a3be-dd6f88626632')
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200036
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200036
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:36:02 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:36:03 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647762998.9985,Updated=TO_TIMESTAMP('2022-09-08 16:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:36:03 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200012 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:03 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200012 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:36:03 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:36:03 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200012 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:03 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200012 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:36:03 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:36:03 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200012
;

-- Sep 8, 2022, 4:36:03 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50059: Grand Total=297.0',Updated=TO_TIMESTAMP('2022-09-08 16:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200036
;

-- Sep 8, 2022, 4:36:03 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50059: Grand Total=297.0', ElapsedTimeMS=1021,Updated=TO_TIMESTAMP('2022-09-08 16:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200036
;

-- Sep 8, 2022, 4:36:03 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200036
;

-- Sep 8, 2022, 4:36:03 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200012
;

-- Sep 8, 2022, 4:36:07 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:36:06','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:36:06','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200013,'50058: Grand Total=102.0',259,0,200013,'8d31857d-e758-49da-8966-b32cd9f78e81')
;

-- Sep 8, 2022, 4:36:07 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200013
;

-- Sep 8, 2022, 4:36:07 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200037,200013,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),116,0,200013,259,'1ecf5c0f-36c9-4df4-9f5e-822c329910c4')
;

-- Sep 8, 2022, 4:36:07 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),200037,'PC',200013,259,183,200013,0.0,'42409183-b07c-4902-8c94-417472f378ce')
;

-- Sep 8, 2022, 4:36:07 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200037
;

-- Sep 8, 2022, 4:36:07 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200037
;

-- Sep 8, 2022, 4:36:07 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200037
;

-- Sep 8, 2022, 4:36:07 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=725,Updated=TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200037
;

-- Sep 8, 2022, 4:36:07 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200037
;

-- Sep 8, 2022, 4:36:07 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200038,200013,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),116,0,200013,259,'f49b34fa-192a-4f5f-a418-68a768f52987')
;

-- Sep 8, 2022, 4:36:08 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:07','YYYY-MM-DD HH24:MI:SS'),200038,'PC',200013,259,185,200013,0.0,'3a9ab101-303e-433a-b7b8-a14bed55bcb4')
;

-- Sep 8, 2022, 4:36:08 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200038
;

-- Sep 8, 2022, 4:36:08 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200038
;

-- Sep 8, 2022, 4:36:08 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,127,0.0,TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),100,'Y','5b8d7ab4-8e81-439f-bfb4-588103922368')
;

-- Sep 8, 2022, 4:36:08 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:08 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',200015,'ba7fdac7-5758-4b70-8e96-cb8e8305abf9',132,'50058',20,260,200026,50002,127,0,'Y',0.0,2,2.0)
;

-- Sep 8, 2022, 4:36:08 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=57.0, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200026
;

-- Sep 8, 2022, 4:36:08 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:08 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',200016,'c12dc9a1-5f0b-400c-983a-47d0fa67bfb9',132,'50058',10,260,200025,50002,147,0,'Y',1.0,3,4.0)
;

-- Sep 8, 2022, 4:36:08 PM CEST
UPDATE C_OrderLine SET QtyReserved=3, LineNetAmt=45, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200025
;

-- Sep 8, 2022, 4:36:08 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:36:08 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),100,200013,109,102.0,0.0,'N','N','4f6f230b-8941-4833-8497-b1ebbf4e7784')
;

-- Sep 8, 2022, 4:36:08 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=102.0, GrandTotal=102.0, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:36:08 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50058: Grand Total=102.0 (#2)',Updated=TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200038
;

-- Sep 8, 2022, 4:36:08 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50058: Grand Total=102.0 (#2)', ElapsedTimeMS=1818,Updated=TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200038
;

-- Sep 8, 2022, 4:36:08 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200038
;

-- Sep 8, 2022, 4:36:09 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200039,200013,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:08','YYYY-MM-DD HH24:MI:SS'),116,0,200013,259,'896b31c5-0010-4b25-a7d6-af284c41ac96')
;

-- Sep 8, 2022, 4:36:09 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),200039,'PC',200013,259,186,200013,0.0,'0fca9a1e-f955-4383-a164-f767ea3f9bce')
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200039
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200039
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647769365.3657,Updated=TO_TIMESTAMP('2022-09-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200013 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:09 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200013 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200013 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:09 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200013 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200013
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50058: Grand Total=102.0',Updated=TO_TIMESTAMP('2022-09-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200039
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50058: Grand Total=102.0', ElapsedTimeMS=391,Updated=TO_TIMESTAMP('2022-09-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200039
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200039
;

-- Sep 8, 2022, 4:36:09 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200013
;

-- Sep 8, 2022, 4:36:14 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:36:14','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:36:14','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200014,'50057: Grand Total=185.25',259,0,200014,'761ce717-39cb-41ec-b7b1-97358a8243c1')
;

-- Sep 8, 2022, 4:36:14 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200014
;

-- Sep 8, 2022, 4:36:14 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200040,200014,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:14','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:14','YYYY-MM-DD HH24:MI:SS'),116,0,200014,259,'d7d9e5a2-9ffb-44b8-8af5-e93cbce8a135')
;

-- Sep 8, 2022, 4:36:15 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:14','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:14','YYYY-MM-DD HH24:MI:SS'),200040,'PC',200014,259,183,200014,0.0,'d50fdc68-0541-4894-b7f5-64bb605c323e')
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200040
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200040
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200040
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=1054,Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200040
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200040
;

-- Sep 8, 2022, 4:36:15 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200041,200014,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),116,0,200014,259,'a0d6cb20-29a2-43f8-81fb-12a5a10eb068')
;

-- Sep 8, 2022, 4:36:15 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),200041,'PC',200014,259,185,200014,0.0,'3d06c650-7877-4f9c-813f-b95f97783d6b')
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200041
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200041
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE C_OrderLine SET QtyReserved=3.00, LineNetAmt=128.25, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200027
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:15 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',200017,'f13835ef-62f4-4d8e-b7c1-0e806a8aa4b7',132,'50057',20,260,200028,50002,127,0,'Y',2.0,2,4.0)
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=57.0, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200028
;

-- Sep 8, 2022, 4:36:15 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:36:15 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),100,200014,109,185.25,0.0,'N','N','26667651-4541-4637-8a3b-506e15a9870f')
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=185.25, GrandTotal=185.25, Volume=0.00, Weight=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50057: Grand Total=185.25 (#2)',Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200041
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50057: Grand Total=185.25 (#2)', ElapsedTimeMS=895,Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200041
;

-- Sep 8, 2022, 4:36:15 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200041
;

-- Sep 8, 2022, 4:36:16 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200042,200014,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:15','YYYY-MM-DD HH24:MI:SS'),116,0,200014,259,'1d7a2236-3842-4a8f-b329-382f2a58b120')
;

-- Sep 8, 2022, 4:36:16 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:16','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:16','YYYY-MM-DD HH24:MI:SS'),200042,'PC',200014,259,186,200014,0.0,'a5774cd9-fcac-42cf-b43a-97074e4b2220')
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200042
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200042
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647776534.5344,Updated=TO_TIMESTAMP('2022-09-08 16:36:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200014 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:16 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200014 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200014 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:16 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200014 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200014
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50057: Grand Total=185.25',Updated=TO_TIMESTAMP('2022-09-08 16:36:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200042
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50057: Grand Total=185.25', ElapsedTimeMS=558,Updated=TO_TIMESTAMP('2022-09-08 16:36:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200042
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200042
;

-- Sep 8, 2022, 4:36:16 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200014
;

-- Sep 8, 2022, 4:36:20 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200015,'50054: Grand Total=222.60',259,0,200016,'754e8d63-5d81-44f8-80a1-26d80abeeab8')
;

-- Sep 8, 2022, 4:36:20 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200015
;

-- Sep 8, 2022, 4:36:20 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200043,200015,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),116,0,200016,259,'e72c85ed-3dc3-4f66-b446-a7774fe3287a')
;

-- Sep 8, 2022, 4:36:20 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),200043,'PC',200015,259,183,200016,0.0,'c7db6eb8-491c-4f6c-a5d2-8ba904f47327')
;

-- Sep 8, 2022, 4:36:20 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200043
;

-- Sep 8, 2022, 4:36:20 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200043
;

-- Sep 8, 2022, 4:36:20 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200043
;

-- Sep 8, 2022, 4:36:20 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=966,Updated=TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200043
;

-- Sep 8, 2022, 4:36:20 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200043
;

-- Sep 8, 2022, 4:36:21 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200044,200015,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:20','YYYY-MM-DD HH24:MI:SS'),116,0,200016,259,'5928e8ab-4c8f-444c-8064-d209073e098b')
;

-- Sep 8, 2022, 4:36:21 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),200044,'PC',200015,259,185,200016,0.0,'3b287b36-3c29-49ae-8051-e20253032809')
;

-- Sep 8, 2022, 4:36:21 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200044
;

-- Sep 8, 2022, 4:36:21 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200044
;

-- Sep 8, 2022, 4:36:21 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:21 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',200018,'748cc48e-d9f3-4f32-99e0-fa9d82c37c13',132,'50054',10,260,200029,50002,124,0,'Y',1.0,1,2.0)
;

-- Sep 8, 2022, 4:36:21 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=57, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200029
;

-- Sep 8, 2022, 4:36:21 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,133,0.0,TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),100,'Y','4dd6e06f-2ba6-43ed-99d2-527d71329f98')
;

-- Sep 8, 2022, 4:36:21 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:22 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',200019,'0d055263-6ade-4f65-aa0b-a6b362878b17',132,'50054',40,260,200032,50002,133,0,'Y',0.0,2,2.0)
;

-- Sep 8, 2022, 4:36:22 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=67.50, Discount=-2.27,Updated=TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200032
;

-- Sep 8, 2022, 4:36:22 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:22 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),100,'Y',200020,'988c7eb1-4b8b-4ddd-9c20-316cdda1385b',132,'50054',30,260,200031,50002,135,0,'Y',16.0,1,17.0)
;

-- Sep 8, 2022, 4:36:22 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=22.5, Discount=-2.27,Updated=TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200031
;

-- Sep 8, 2022, 4:36:22 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,140,0.0,TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),100,'Y','52dc016a-23a0-4b89-9f9a-5491d8fd56b9')
;

-- Sep 8, 2022, 4:36:22 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:22 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),100,'Y',200021,'07d9c838-ca9a-415b-8b7c-9fc25c7a0b59',132,'50054',20,260,200030,50002,140,0,'Y',0.0,7,7.0)
;

-- Sep 8, 2022, 4:36:22 PM CEST
UPDATE C_OrderLine SET QtyReserved=7, LineNetAmt=75.6, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200030
;

-- Sep 8, 2022, 4:36:22 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:36:22 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),100,200016,109,222.60,0.0,'N','N','2994c98a-98a9-465d-a4a7-0fba1353db0d')
;

-- Sep 8, 2022, 4:36:22 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=222.60, GrandTotal=222.60, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:36:22 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50054: Grand Total=222.60 (#4)',Updated=TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200044
;

-- Sep 8, 2022, 4:36:22 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50054: Grand Total=222.60 (#4)', ElapsedTimeMS=1612,Updated=TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200044
;

-- Sep 8, 2022, 4:36:22 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200044
;

-- Sep 8, 2022, 4:36:22 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200045,200015,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),116,0,200016,259,'787852ba-362d-4049-8f59-502d3c6e5dd2')
;

-- Sep 8, 2022, 4:36:23 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:22','YYYY-MM-DD HH24:MI:SS'),200045,'PC',200015,259,186,200016,0.0,'d1c88d6e-19e4-4c47-8157-dc889d8682f4')
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200045
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200045
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647783159.16,Updated=TO_TIMESTAMP('2022-09-08 16:36:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200016 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:23 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200016 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200016 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:23 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200016 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200016
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50054: Grand Total=222.60',Updated=TO_TIMESTAMP('2022-09-08 16:36:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200045
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50054: Grand Total=222.60', ElapsedTimeMS=1186,Updated=TO_TIMESTAMP('2022-09-08 16:36:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200045
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200045
;

-- Sep 8, 2022, 4:36:23 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200015
;

-- Sep 8, 2022, 4:36:27 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200016,'50053: Grand Total=239.50',259,0,200017,'9b25f8a1-dd41-4f8f-8145-18f33bd32c67')
;

-- Sep 8, 2022, 4:36:27 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200016
;

-- Sep 8, 2022, 4:36:27 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200046,200016,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),116,0,200017,259,'905a9271-75c3-4d2a-b976-7a1cd4969201')
;

-- Sep 8, 2022, 4:36:27 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),200046,'PC',200016,259,183,200017,0.0,'1b2a8107-35f3-4159-a851-7a4cdcc474e0')
;

-- Sep 8, 2022, 4:36:27 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200046
;

-- Sep 8, 2022, 4:36:27 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200046
;

-- Sep 8, 2022, 4:36:27 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200046
;

-- Sep 8, 2022, 4:36:27 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=979,Updated=TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200046
;

-- Sep 8, 2022, 4:36:27 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200046
;

-- Sep 8, 2022, 4:36:28 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200047,200016,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:27','YYYY-MM-DD HH24:MI:SS'),116,0,200017,259,'d4b652bc-95fa-433e-8cf7-2709fca4687f')
;

-- Sep 8, 2022, 4:36:28 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:28','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:28','YYYY-MM-DD HH24:MI:SS'),200047,'PC',200016,259,185,200017,0.0,'f13320de-ed79-4e19-a938-fef027455dc6')
;

-- Sep 8, 2022, 4:36:28 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200047
;

-- Sep 8, 2022, 4:36:28 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200047
;

-- Sep 8, 2022, 4:36:28 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:28 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',200022,'dba74953-461f-4b06-8da4-9bac3af7d514',132,'50053',40,260,200035,50002,123,0,'Y',6.0,1,7.0)
;

-- Sep 8, 2022, 4:36:28 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=61.75, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200035
;

-- Sep 8, 2022, 4:36:28 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:29 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',200023,'27168faf-f6cf-46b6-96ad-9d47049d6a80',132,'50053',70,260,200038,50002,133,0,'Y',2.0,1,3.0)
;

-- Sep 8, 2022, 4:36:29 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=33.75, Discount=-2.27,Updated=TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200038
;

-- Sep 8, 2022, 4:36:29 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:29 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',200024,'62bcfb5f-e1e7-42a7-b530-913f294f148f',132,'50053',50,260,200036,50002,137,0,'Y',11.0,13,24.0)
;

-- Sep 8, 2022, 4:36:29 PM CEST
UPDATE C_OrderLine SET QtyReserved=13, LineNetAmt=39, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200036
;

-- Sep 8, 2022, 4:36:29 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:29 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',200025,'f03ed0fc-d012-44e0-a9a8-63c1c2e5d9af',132,'50053',60,260,200037,50002,143,0,'Y',6.0,1,7.0)
;

-- Sep 8, 2022, 4:36:29 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=27, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200037
;

-- Sep 8, 2022, 4:36:29 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:29 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',200026,'4641bf2e-490a-405d-aef2-bca4c0e7b244',132,'50053',20,260,200033,50002,147,0,'Y',4.0,3,7.0)
;

-- Sep 8, 2022, 4:36:29 PM CEST
UPDATE C_OrderLine SET QtyReserved=3, LineNetAmt=45, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200033
;

-- Sep 8, 2022, 4:36:29 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:30 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',200027,'741c9d9c-7c29-46bf-81bf-6a183cb26c4f',132,'50053',30,260,200034,50002,50007,0,'Y',2.0,1,3.0)
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=33.00, Discount=5.71,Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200034
;

-- Sep 8, 2022, 4:36:30 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:36:30 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),100,200017,109,239.50,0.0,'N','N','2288810f-5c45-4f2c-a831-ae3d6594eced')
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=239.50, GrandTotal=239.50, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50053: Grand Total=239.50 (#6)',Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200047
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50053: Grand Total=239.50 (#6)', ElapsedTimeMS=2278,Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200047
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200047
;

-- Sep 8, 2022, 4:36:30 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200048,200016,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),116,0,200017,259,'51e1ce4e-f549-4667-971d-a2c02bafec18')
;

-- Sep 8, 2022, 4:36:30 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),200048,'PC',200016,259,186,200017,0.0,'3608e875-40ee-4f21-93f6-70fb891a29b9')
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200048
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200048
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647790826.8267,Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200017 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:30 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200017 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200017 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:30 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200017 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200017
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50053: Grand Total=239.50',Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200048
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50053: Grand Total=239.50', ElapsedTimeMS=850,Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200048
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200048
;

-- Sep 8, 2022, 4:36:30 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200016
;

-- Sep 8, 2022, 4:36:34 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:36:34','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:36:34','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200017,'50050: Grand Total=248.35',259,0,200018,'6da6ecb9-c951-493f-98bd-c83dab0f2fdc')
;

-- Sep 8, 2022, 4:36:34 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200017
;

-- Sep 8, 2022, 4:36:35 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200049,200017,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:34','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:34','YYYY-MM-DD HH24:MI:SS'),116,0,200018,259,'88f7658b-5dd6-4f1f-9d3c-7ff80b8eaf03')
;

-- Sep 8, 2022, 4:36:35 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),200049,'PC',200017,259,183,200018,0.0,'03254991-d364-4de6-9152-40cea0e9aba5')
;

-- Sep 8, 2022, 4:36:35 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200049
;

-- Sep 8, 2022, 4:36:35 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200049
;

-- Sep 8, 2022, 4:36:35 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200049
;

-- Sep 8, 2022, 4:36:35 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=359,Updated=TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200049
;

-- Sep 8, 2022, 4:36:35 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200049
;

-- Sep 8, 2022, 4:36:35 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200050,200017,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),116,0,200018,259,'78243463-e894-46bd-86f6-994f6258e069')
;

-- Sep 8, 2022, 4:36:35 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),200050,'PC',200017,259,185,200018,0.0,'a194a1ec-3899-4677-8bce-0851fa7a9016')
;

-- Sep 8, 2022, 4:36:35 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200050
;

-- Sep 8, 2022, 4:36:35 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200050
;

-- Sep 8, 2022, 4:36:35 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,125,0.0,TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),100,'Y','82bbb385-0827-415d-8d0d-a280126869e5')
;

-- Sep 8, 2022, 4:36:35 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:36 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:35','YYYY-MM-DD HH24:MI:SS'),100,'Y',200028,'26659a8b-9804-4578-897c-8ddcf2dfc089',132,'50050',20,260,200040,50002,125,0,'Y',0.0,1,1.0)
;

-- Sep 8, 2022, 4:36:36 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=76, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200040
;

-- Sep 8, 2022, 4:36:36 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:36 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,'Y',200029,'f206003d-aef4-4249-b575-05c2a77a4552',132,'50050',50,260,200043,50002,127,0,'Y',4.0,1,5.0)
;

-- Sep 8, 2022, 4:36:36 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=28.5, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200043
;

-- Sep 8, 2022, 4:36:36 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:36 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,'Y',200030,'5c6aa8a8-fe3c-482b-a346-c4d0561a75a9',132,'50050',60,260,200044,50002,135,0,'Y',17.0,1,18.0)
;

-- Sep 8, 2022, 4:36:36 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=22.5, Discount=-2.27,Updated=TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200044
;

-- Sep 8, 2022, 4:36:36 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,141,0.0,TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,'Y','b14555e0-4d2d-4052-9ca2-d8a4fdcef705')
;

-- Sep 8, 2022, 4:36:36 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:37 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,'Y',200031,'086935c7-c279-4db3-90e2-5eb66cf59cb1',132,'50050',40,260,200042,50002,141,0,'Y',0.0,14,14.0)
;

-- Sep 8, 2022, 4:36:37 PM CEST
UPDATE C_OrderLine SET QtyReserved=14, LineNetAmt=37.8, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200042
;

-- Sep 8, 2022, 4:36:37 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:37 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,'Y',200032,'fac73152-1f6c-44ad-b88e-bc1431a96893',132,'50050',30,260,200041,50002,142,0,'Y',4.0,17,21.0)
;

-- Sep 8, 2022, 4:36:37 PM CEST
UPDATE C_OrderLine SET QtyReserved=17, LineNetAmt=53.55, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200041
;

-- Sep 8, 2022, 4:36:37 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,148,0.0,TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,'Y','a85ce29f-2136-4887-b3eb-262df063e3d7')
;

-- Sep 8, 2022, 4:36:37 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:37 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,'Y',200033,'263406d7-a9ba-4ce4-a268-771d372e24da',132,'50050',10,260,200039,50002,148,0,'Y',0.0,2,2.0)
;

-- Sep 8, 2022, 4:36:37 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=30, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200039
;

-- Sep 8, 2022, 4:36:37 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:36:37 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,200018,109,248.35,0.0,'N','N','bc16d041-b9e5-40f5-95d1-1a6d1feb440f')
;

-- Sep 8, 2022, 4:36:37 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=248.35, GrandTotal=248.35, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:36:37 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50050: Grand Total=248.35 (#6)',Updated=TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200050
;

-- Sep 8, 2022, 4:36:37 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50050: Grand Total=248.35 (#6)', ElapsedTimeMS=2585,Updated=TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200050
;

-- Sep 8, 2022, 4:36:37 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200050
;

-- Sep 8, 2022, 4:36:37 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200051,200017,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),116,0,200018,259,'5e0accf8-6c41-4b6c-adf2-b4acc017f792')
;

-- Sep 8, 2022, 4:36:38 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:37','YYYY-MM-DD HH24:MI:SS'),200051,'PC',200017,259,186,200018,0.0,'f91cdda3-3488-4dad-9602-347bacdfa110')
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200051
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200051
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647798124.124,Updated=TO_TIMESTAMP('2022-09-08 16:36:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200018 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:38 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200018 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200018 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:38 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200018 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200018
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50050: Grand Total=248.35',Updated=TO_TIMESTAMP('2022-09-08 16:36:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200051
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50050: Grand Total=248.35', ElapsedTimeMS=1147,Updated=TO_TIMESTAMP('2022-09-08 16:36:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200051
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200051
;

-- Sep 8, 2022, 4:36:38 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200017
;

-- Sep 8, 2022, 4:36:42 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200018,'50047: Grand Total=489.30',259,0,200019,'ed95d3c3-c58f-4d1a-8b78-c3125a3706da')
;

-- Sep 8, 2022, 4:36:42 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200018
;

-- Sep 8, 2022, 4:36:42 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200052,200018,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),116,0,200019,259,'2daa100a-2554-4ca1-9be1-b632db1ba52f')
;

-- Sep 8, 2022, 4:36:42 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),200052,'PC',200018,259,183,200019,0.0,'3db92898-a2d3-4e0d-9cc0-dd8a898375f5')
;

-- Sep 8, 2022, 4:36:42 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200052
;

-- Sep 8, 2022, 4:36:42 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200052
;

-- Sep 8, 2022, 4:36:42 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200052
;

-- Sep 8, 2022, 4:36:42 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=950,Updated=TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200052
;

-- Sep 8, 2022, 4:36:42 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200052
;

-- Sep 8, 2022, 4:36:43 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200053,200018,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:42','YYYY-MM-DD HH24:MI:SS'),116,0,200019,259,'19e92198-c907-4dcc-bf24-781e45d99675')
;

-- Sep 8, 2022, 4:36:43 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:43','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:43','YYYY-MM-DD HH24:MI:SS'),200053,'PC',200018,259,185,200019,0.0,'d8cf1615-17df-4a9b-b0a8-7c0a25ca0166')
;

-- Sep 8, 2022, 4:36:43 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200053
;

-- Sep 8, 2022, 4:36:43 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200053
;

-- Sep 8, 2022, 4:36:43 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:43 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:43','YYYY-MM-DD HH24:MI:SS'),100,'Y',200034,'2f78045b-54a8-46b7-9bdf-37477248d20e',132,'50047',40,260,200048,50002,123,0,'Y',7.0,4,11.0)
;

-- Sep 8, 2022, 4:36:43 PM CEST
UPDATE C_OrderLine SET QtyReserved=4, LineNetAmt=247.00, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200048
;

-- Sep 8, 2022, 4:36:43 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:44 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:43','YYYY-MM-DD HH24:MI:SS'),100,'Y',200035,'0484e7eb-cebd-477e-be4e-5c11611486cf',132,'50047',60,260,200050,50002,125,0,'Y',1.0,1,2.0)
;

-- Sep 8, 2022, 4:36:44 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=76, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200050
;

-- Sep 8, 2022, 4:36:44 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:44 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',200036,'dee2d2a1-8cdb-4a6e-b731-aa5d4e9be004',132,'50047',10,260,200045,50002,130,0,'Y',7.0,1,8.0)
;

-- Sep 8, 2022, 4:36:44 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=47.5, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200045
;

-- Sep 8, 2022, 4:36:44 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:44 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',200037,'6754e53c-77fd-487b-8bac-2e19800bda38',132,'50047',80,260,200052,50002,137,0,'Y',24.0,1,25.0)
;

-- Sep 8, 2022, 4:36:44 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=3, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200052
;

-- Sep 8, 2022, 4:36:44 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:44 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',200038,'f7f4ab1a-df4d-426a-b7e8-d404469203d2',132,'50047',20,260,200046,50002,141,0,'Y',14.0,9,23.0)
;

-- Sep 8, 2022, 4:36:44 PM CEST
UPDATE C_OrderLine SET QtyReserved=9, LineNetAmt=24.3, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200046
;

-- Sep 8, 2022, 4:36:44 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:45 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',200039,'853fe69f-d77c-412e-b112-8b6b39d2bab5',132,'50047',70,260,200051,50002,143,0,'Y',7.0,1,8.0)
;

-- Sep 8, 2022, 4:36:45 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=27, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200051
;

-- Sep 8, 2022, 4:36:45 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,144,0.0,TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),100,'Y','2f7815d4-b0a4-4845-a5b7-71b17c450d4b')
;

-- Sep 8, 2022, 4:36:45 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:45 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',200040,'f557103f-ce34-4803-8167-8edd0a170b1f',132,'50047',30,260,200047,50002,144,0,'Y',0.0,1,1.0)
;

-- Sep 8, 2022, 4:36:45 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=31.5, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200047
;

-- Sep 8, 2022, 4:36:45 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:45 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',200041,'587ceaa5-1442-4190-b55d-b3a067cd84b4',132,'50047',50,260,200049,50002,50007,0,'Y',3.0,1,4.0)
;

-- Sep 8, 2022, 4:36:45 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=33.00, Discount=5.71,Updated=TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200049
;

-- Sep 8, 2022, 4:36:45 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:36:45 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),100,200019,109,489.30,0.0,'N','N','c63657dc-e5c8-42f9-ac83-afba956cba17')
;

-- Sep 8, 2022, 4:36:45 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=489.30, GrandTotal=489.30, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:36:45 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50047: Grand Total=489.30 (#8)',Updated=TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200053
;

-- Sep 8, 2022, 4:36:45 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50047: Grand Total=489.30 (#8)', ElapsedTimeMS=2624,Updated=TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200053
;

-- Sep 8, 2022, 4:36:45 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200053
;

-- Sep 8, 2022, 4:36:45 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200054,200018,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),116,0,200019,259,'204011d4-46a5-4486-b45d-45d7c1ecc65e')
;

-- Sep 8, 2022, 4:36:46 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:45','YYYY-MM-DD HH24:MI:SS'),200054,'PC',200018,259,186,200019,0.0,'4f768833-4fde-4009-b712-a3cb17061261')
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200054
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200054
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647806174.174,Updated=TO_TIMESTAMP('2022-09-08 16:36:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200019 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:46 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200019 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200019 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:46 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200019 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200019
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50047: Grand Total=489.30',Updated=TO_TIMESTAMP('2022-09-08 16:36:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200054
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50047: Grand Total=489.30', ElapsedTimeMS=1200,Updated=TO_TIMESTAMP('2022-09-08 16:36:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200054
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200054
;

-- Sep 8, 2022, 4:36:46 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200018
;

-- Sep 8, 2022, 4:36:49 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:36:49','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:36:49','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200019,'50045: Grand Total=245.25',259,0,200020,'f9e9f07e-0c89-438a-8124-b279440858bf')
;

-- Sep 8, 2022, 4:36:49 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200019
;

-- Sep 8, 2022, 4:36:50 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200055,200019,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:49','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:49','YYYY-MM-DD HH24:MI:SS'),116,0,200020,259,'31124492-0a96-4ad2-97b4-74542bfde7b6')
;

-- Sep 8, 2022, 4:36:50 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:50','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:50','YYYY-MM-DD HH24:MI:SS'),200055,'PC',200019,259,183,200020,0.0,'ceb75437-bbe6-4c5f-af92-65608b8e2fe7')
;

-- Sep 8, 2022, 4:36:50 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200055
;

-- Sep 8, 2022, 4:36:50 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200055
;

-- Sep 8, 2022, 4:36:50 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200055
;

-- Sep 8, 2022, 4:36:50 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=496,Updated=TO_TIMESTAMP('2022-09-08 16:36:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200055
;

-- Sep 8, 2022, 4:36:50 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200055
;

-- Sep 8, 2022, 4:36:51 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200056,200019,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:50','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:50','YYYY-MM-DD HH24:MI:SS'),116,0,200020,259,'1cbe1a04-6319-4ed5-a846-68cf5bebcb9e')
;

-- Sep 8, 2022, 4:36:51 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),200056,'PC',200019,259,185,200020,0.0,'ec712c1e-6dee-43c6-b689-bfcadc83d439')
;

-- Sep 8, 2022, 4:36:51 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200056
;

-- Sep 8, 2022, 4:36:51 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200056
;

-- Sep 8, 2022, 4:36:51 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,128,0.0,TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),100,'Y','aac2b8b7-bd44-4602-88ea-7c49d058a56a')
;

-- Sep 8, 2022, 4:36:51 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:51 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',200042,'55266c3e-4e74-4037-98c5-23911c3ae738',132,'50045',40,260,200056,50002,128,0,'Y',0.0,1,1.0)
;

-- Sep 8, 2022, 4:36:51 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=23.75, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200056
;

-- Sep 8, 2022, 4:36:51 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:51 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',200043,'01a5b5f7-ffca-4e4e-af09-7eefa97462f7',132,'50045',50,260,200057,50002,129,0,'Y',1.0,2,3.0)
;

-- Sep 8, 2022, 4:36:51 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=76, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200057
;

-- Sep 8, 2022, 4:36:51 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:52 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',200044,'dd162115-d842-43c2-8985-f564e6eafe9c',132,'50045',30,260,200055,50002,136,0,'Y',1.0,3,4.0)
;

-- Sep 8, 2022, 4:36:52 PM CEST
UPDATE C_OrderLine SET QtyReserved=3, LineNetAmt=60, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200055
;

-- Sep 8, 2022, 4:36:52 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:52 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',200045,'7125a1b5-203b-4085-bbd4-7f9fc373bf9c',132,'50045',20,260,200054,50002,137,0,'Y',25.0,9,34.0)
;

-- Sep 8, 2022, 4:36:52 PM CEST
UPDATE C_OrderLine SET QtyReserved=9, LineNetAmt=27, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200054
;

-- Sep 8, 2022, 4:36:52 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,138,0.0,TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),100,'Y','c59d6d7c-2dc2-43fc-a701-663c2efa51ea')
;

-- Sep 8, 2022, 4:36:52 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:52 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',200046,'377b5722-2ad8-4490-9940-9b8ca2f39dcd',132,'50045',60,260,200058,50002,138,0,'Y',0.0,2,2.0)
;

-- Sep 8, 2022, 4:36:52 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=27.0, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200058
;

-- Sep 8, 2022, 4:36:52 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:36:53 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',200047,'b7109e1b-a4bd-49c4-8ddb-232921f17d61',132,'50045',10,260,200053,50002,144,0,'Y',1.0,1,2.0)
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=31.5, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200053
;

-- Sep 8, 2022, 4:36:53 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:36:53 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),100,200020,109,245.25,0.0,'N','N','de56e732-d20f-45bf-8311-389cd7d9c2bd')
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=245.25, GrandTotal=245.25, Volume=0.0, Weight=12.00,Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50045: Grand Total=245.25 (#6)',Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200056
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50045: Grand Total=245.25 (#6)', ElapsedTimeMS=2169,Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200056
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200056
;

-- Sep 8, 2022, 4:36:53 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200057,200019,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),116,0,200020,259,'66bb9526-48ac-4eae-9d12-fd538b5cda75')
;

-- Sep 8, 2022, 4:36:53 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),200057,'PC',200019,259,186,200020,0.0,'bedd21e4-2913-40cc-8b97-0777d29aad58')
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200057
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200057
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647813743.7437,Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200020 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:53 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200020 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200020 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:36:53 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200020 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200020
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50045: Grand Total=245.25',Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200057
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50045: Grand Total=245.25', ElapsedTimeMS=847,Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200057
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200057
;

-- Sep 8, 2022, 4:36:53 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200019
;

-- Sep 8, 2022, 4:36:59 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:36:58','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:36:58','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200020,'50044: Grand Total=167.8',259,0,200021,'68093f15-f07d-4747-b927-17c3a101993f')
;

-- Sep 8, 2022, 4:36:59 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200020
;

-- Sep 8, 2022, 4:36:59 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200058,200020,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),116,0,200021,259,'659cfe87-9d17-4c1d-8f37-1e56bf211921')
;

-- Sep 8, 2022, 4:36:59 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),200058,'PC',200020,259,183,200021,0.0,'c70aa895-d9ac-4381-832e-0dcb0b1738b9')
;

-- Sep 8, 2022, 4:36:59 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200058
;

-- Sep 8, 2022, 4:36:59 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200058
;

-- Sep 8, 2022, 4:36:59 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200058
;

-- Sep 8, 2022, 4:36:59 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=632,Updated=TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200058
;

-- Sep 8, 2022, 4:36:59 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200058
;

-- Sep 8, 2022, 4:36:59 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200059,200020,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),116,0,200021,259,'0be6fad3-0c2f-4cef-add5-9b91890a1e20')
;

-- Sep 8, 2022, 4:37:00 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:36:59','YYYY-MM-DD HH24:MI:SS'),200059,'PC',200020,259,185,200021,0.0,'e42e9e5c-5d72-48c6-955b-a7b6804da8e8')
;

-- Sep 8, 2022, 4:37:00 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200059
;

-- Sep 8, 2022, 4:37:00 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200059
;

-- Sep 8, 2022, 4:37:00 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:00 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',200048,'ebc4dd53-6c3f-4634-af68-8dc3b0baca01',132,'50044',10,260,200059,50002,125,0,'Y',2.0,1,3.0)
;

-- Sep 8, 2022, 4:37:00 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=76, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200059
;

-- Sep 8, 2022, 4:37:00 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,134,0.0,TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','f000ff02-d13c-4b6a-a325-ac9b3a7b0c7f')
;

-- Sep 8, 2022, 4:37:00 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:00 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',200049,'cc3a0a0f-3e8e-4615-913a-e8c656bdcd0c',132,'50044',30,260,200061,50002,134,0,'Y',0.0,1,1.0)
;

-- Sep 8, 2022, 4:37:00 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=67.5, Discount=-2.27,Updated=TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200061
;

-- Sep 8, 2022, 4:37:00 PM CEST
INSERT INTO M_StorageReservation (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,M_AttributeSetInstance_ID,M_Warehouse_ID,M_Product_ID,Qty,Updated,UpdatedBy,IsSOTrx,M_StorageReservation_UU) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,50002,139,0.0,TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','82d80288-24b6-49bb-aaf1-34115b643d9c')
;

-- Sep 8, 2022, 4:37:00 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:01 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',200050,'595e8ac6-c0eb-4340-b2e5-9cb73d9c58f7',132,'50044',20,260,200060,50002,139,0,'Y',0.0,3,3.0)
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE C_OrderLine SET QtyReserved=3, LineNetAmt=24.3, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200060
;

-- Sep 8, 2022, 4:37:01 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:37:01 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),100,200021,109,167.8,0.0,'N','N','af4f8241-8202-4f0a-9f98-bb41c04e2643')
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=167.8, GrandTotal=167.8, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50044: Grand Total=167.8 (#3)',Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200059
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50044: Grand Total=167.8 (#3)', ElapsedTimeMS=2043,Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200059
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200059
;

-- Sep 8, 2022, 4:37:01 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200060,200020,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),116,0,200021,259,'fd94af07-f544-4470-808e-02c017f429c2')
;

-- Sep 8, 2022, 4:37:01 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),200060,'PC',200020,259,186,200021,0.0,'d2eab7bb-a003-40f9-91bc-13b89022f73c')
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200060
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200060
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647821581.5818,Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200021 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:01 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200021 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200021 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:01 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200021 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200021
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50044: Grand Total=167.8',Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200060
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50044: Grand Total=167.8', ElapsedTimeMS=607,Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200060
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200060
;

-- Sep 8, 2022, 4:37:01 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200020
;

-- Sep 8, 2022, 4:37:05 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:37:05','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:37:05','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200021,'50041: Grand Total=284.50',259,0,200022,'7d89fecc-96ed-41f4-858a-dbce1dbf71f6')
;

-- Sep 8, 2022, 4:37:05 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200021
;

-- Sep 8, 2022, 4:37:06 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200061,200021,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:05','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:05','YYYY-MM-DD HH24:MI:SS'),116,0,200022,259,'32cd27a5-c6b5-4f16-9f12-b3bc254c021d')
;

-- Sep 8, 2022, 4:37:06 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),200061,'PC',200021,259,183,200022,0.0,'a6d3fef1-30ac-43a8-b1f0-2080f5173e53')
;

-- Sep 8, 2022, 4:37:06 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200061
;

-- Sep 8, 2022, 4:37:06 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200061
;

-- Sep 8, 2022, 4:37:06 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200061
;

-- Sep 8, 2022, 4:37:06 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=285,Updated=TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200061
;

-- Sep 8, 2022, 4:37:06 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200061
;

-- Sep 8, 2022, 4:37:06 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200062,200021,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),116,0,200022,259,'53c1b769-4a07-46f2-8105-981562804630')
;

-- Sep 8, 2022, 4:37:06 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),200062,'PC',200021,259,185,200022,0.0,'51bc55e8-3065-4ff1-abe9-a12f852aa00c')
;

-- Sep 8, 2022, 4:37:06 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200062
;

-- Sep 8, 2022, 4:37:06 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200062
;

-- Sep 8, 2022, 4:37:06 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:07 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',200051,'3ce51e81-982b-4e26-bf12-00443d50ed94',132,'50041',30,260,200064,50002,123,0,'Y',11.0,1,12.0)
;

-- Sep 8, 2022, 4:37:07 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=61.75, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200064
;

-- Sep 8, 2022, 4:37:07 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:07 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',200052,'519fc38c-fc54-4856-8fe3-b6a709cad589',132,'50041',20,260,200063,50002,125,0,'Y',3.0,1,4.0)
;

-- Sep 8, 2022, 4:37:07 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=76, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200063
;

-- Sep 8, 2022, 4:37:07 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:07 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',200053,'531ea324-1d43-40f5-95a5-c1474b777b1b',132,'50041',60,260,200067,50002,129,0,'Y',3.0,1,4.0)
;

-- Sep 8, 2022, 4:37:07 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=38, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200067
;

-- Sep 8, 2022, 4:37:07 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:07 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',200054,'4b8eae61-60bd-4292-b560-38a43ffffbbb',132,'50041',50,260,200066,50002,133,0,'Y',3.0,1,4.0)
;

-- Sep 8, 2022, 4:37:07 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=33.75, Discount=-2.27,Updated=TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200066
;

-- Sep 8, 2022, 4:37:07 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:08 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',200055,'62729f56-4e30-4a04-a6ba-09911331cd9e',132,'50041',40,260,200065,50002,136,0,'Y',4.0,3,7.0)
;

-- Sep 8, 2022, 4:37:08 PM CEST
UPDATE C_OrderLine SET QtyReserved=3, LineNetAmt=60, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200065
;

-- Sep 8, 2022, 4:37:08 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:08 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',200056,'ff925ead-edb9-4f94-bfdb-22619369f62f',132,'50041',10,260,200062,50002,148,0,'Y',2.0,1,3.0)
;

-- Sep 8, 2022, 4:37:08 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=15, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200062
;

-- Sep 8, 2022, 4:37:08 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:37:08 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),100,200022,109,284.50,0.0,'N','N','a4cad087-05aa-4a15-9164-7430961ad6a5')
;

-- Sep 8, 2022, 4:37:08 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=284.50, GrandTotal=284.50, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:37:08 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50041: Grand Total=284.50 (#6)',Updated=TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200062
;

-- Sep 8, 2022, 4:37:08 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50041: Grand Total=284.50 (#6)', ElapsedTimeMS=2475,Updated=TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200062
;

-- Sep 8, 2022, 4:37:08 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200062
;

-- Sep 8, 2022, 4:37:08 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200063,200021,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),116,0,200022,259,'4bef3d99-e90b-45ee-9d5b-4b26ef2c99f8')
;

-- Sep 8, 2022, 4:37:09 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:08','YYYY-MM-DD HH24:MI:SS'),200063,'PC',200021,259,186,200022,0.0,'dc04518d-5f6e-4de0-aac8-9e440a33128f')
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200063
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200063
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647829009.924,Updated=TO_TIMESTAMP('2022-09-08 16:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200022 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:09 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200022 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200022 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:09 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200022 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200022
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50041: Grand Total=284.50',Updated=TO_TIMESTAMP('2022-09-08 16:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200063
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50041: Grand Total=284.50', ElapsedTimeMS=1032,Updated=TO_TIMESTAMP('2022-09-08 16:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200063
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200063
;

-- Sep 8, 2022, 4:37:09 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200021
;

-- Sep 8, 2022, 4:37:12 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:37:12','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:37:12','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200022,'50039: Grand Total=320.00',259,0,200024,'0fc5133a-8035-499b-b335-4bdee5da8c2f')
;

-- Sep 8, 2022, 4:37:12 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200022
;

-- Sep 8, 2022, 4:37:13 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200064,200022,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:12','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:12','YYYY-MM-DD HH24:MI:SS'),116,0,200024,259,'c341fbbd-b84f-4dfa-a985-f75b18931952')
;

-- Sep 8, 2022, 4:37:13 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),200064,'PC',200022,259,183,200024,0.0,'596a3e45-7438-42c8-84a0-79d19aeb6589')
;

-- Sep 8, 2022, 4:37:13 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200064
;

-- Sep 8, 2022, 4:37:13 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200064
;

-- Sep 8, 2022, 4:37:13 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200064
;

-- Sep 8, 2022, 4:37:13 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=366,Updated=TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200064
;

-- Sep 8, 2022, 4:37:13 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200064
;

-- Sep 8, 2022, 4:37:13 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200065,200022,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),116,0,200024,259,'332ac4e7-1182-4876-8982-16bdc4b0413a')
;

-- Sep 8, 2022, 4:37:13 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),200065,'PC',200022,259,185,200024,0.0,'b53e5138-ef9e-47e6-b71d-ba32317a4860')
;

-- Sep 8, 2022, 4:37:13 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200065
;

-- Sep 8, 2022, 4:37:13 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200065
;

-- Sep 8, 2022, 4:37:13 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:14 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',200057,'04a5f2d4-bffd-4969-b767-4d85ad64330d',132,'50039',40,260,200073,50002,123,0,'Y',12.0,1,13.0)
;

-- Sep 8, 2022, 4:37:14 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=61.75, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200073
;

-- Sep 8, 2022, 4:37:14 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:14 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',200058,'47500741-febb-40e3-94ec-6e46bb5bd2d4',132,'50039',20,260,200071,50002,124,0,'Y',2.0,1,3.0)
;

-- Sep 8, 2022, 4:37:14 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=57, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200071
;

-- Sep 8, 2022, 4:37:14 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:14 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',200059,'ebae550e-4db8-4dc2-bce0-6fec84dc5364',132,'50039',60,260,200075,50002,125,0,'Y',4.0,1,5.0)
;

-- Sep 8, 2022, 4:37:14 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=76, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200075
;

-- Sep 8, 2022, 4:37:14 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:14 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',200060,'33715a86-0fcf-4faf-8b90-c79d84da03b8',132,'50039',10,260,200070,50002,133,0,'Y',4.0,1,5.0)
;

-- Sep 8, 2022, 4:37:14 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=33.75, Discount=-2.27,Updated=TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200070
;

-- Sep 8, 2022, 4:37:14 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:15 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',200061,'9b859615-c948-4779-a814-ff66f3e60d45',132,'50039',50,260,200074,50002,144,0,'Y',2.0,1,3.0)
;

-- Sep 8, 2022, 4:37:15 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=31.5, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200074
;

-- Sep 8, 2022, 4:37:15 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:15 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',200062,'e1c5ee7d-6062-4455-b105-cd3f3fc14a89',132,'50039',30,260,200072,50002,148,0,'Y',3.0,4,7.0)
;

-- Sep 8, 2022, 4:37:15 PM CEST
UPDATE C_OrderLine SET QtyReserved=4, LineNetAmt=60, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200072
;

-- Sep 8, 2022, 4:37:15 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:37:15 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),100,200024,109,320.00,0.0,'N','N','93fdab8a-b4f2-464a-b4fc-efbe17b5a8b2')
;

-- Sep 8, 2022, 4:37:15 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=320.00, GrandTotal=320.00, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:37:15 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50039: Grand Total=320.00 (#6)',Updated=TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200065
;

-- Sep 8, 2022, 4:37:15 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50039: Grand Total=320.00 (#6)', ElapsedTimeMS=2529,Updated=TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200065
;

-- Sep 8, 2022, 4:37:15 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200065
;

-- Sep 8, 2022, 4:37:15 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200066,200022,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),116,0,200024,259,'a9a13e1a-50fb-45a3-ba46-64367ff624e1')
;

-- Sep 8, 2022, 4:37:16 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:15','YYYY-MM-DD HH24:MI:SS'),200066,'PC',200022,259,186,200024,0.0,'ba6687bd-9428-4122-b6fb-a16580831dba')
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200066
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200066
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647836083.8364,Updated=TO_TIMESTAMP('2022-09-08 16:37:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200024 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:16 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200024 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200024 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:16 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200024 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200024
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50039: Grand Total=320.00',Updated=TO_TIMESTAMP('2022-09-08 16:37:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200066
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50039: Grand Total=320.00', ElapsedTimeMS=1107,Updated=TO_TIMESTAMP('2022-09-08 16:37:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200066
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200066
;

-- Sep 8, 2022, 4:37:16 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200022
;

-- Sep 8, 2022, 4:37:21 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200023,'50036: Grand Total=611.80',259,0,200025,'6858cbb3-dfc0-4732-8e98-48392bdd7ead')
;

-- Sep 8, 2022, 4:37:21 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200023
;

-- Sep 8, 2022, 4:37:21 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200067,200023,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),116,0,200025,259,'ee746282-9905-4af4-9b5e-ff19f77465eb')
;

-- Sep 8, 2022, 4:37:21 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),200067,'PC',200023,259,183,200025,0.0,'6bc9307e-9162-4cc9-8702-debf0f8dfffd')
;

-- Sep 8, 2022, 4:37:21 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200067
;

-- Sep 8, 2022, 4:37:21 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200067
;

-- Sep 8, 2022, 4:37:21 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200067
;

-- Sep 8, 2022, 4:37:21 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=966,Updated=TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200067
;

-- Sep 8, 2022, 4:37:21 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200067
;

-- Sep 8, 2022, 4:37:22 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200068,200023,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:21','YYYY-MM-DD HH24:MI:SS'),116,0,200025,259,'becd0ab6-ae8d-471a-a0f0-7a873345709c')
;

-- Sep 8, 2022, 4:37:22 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:22','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:22','YYYY-MM-DD HH24:MI:SS'),200068,'PC',200023,259,185,200025,0.0,'7260fff0-547e-444b-bef3-982a37870ad1')
;

-- Sep 8, 2022, 4:37:22 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200068
;

-- Sep 8, 2022, 4:37:22 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200068
;

-- Sep 8, 2022, 4:37:22 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:22 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:22','YYYY-MM-DD HH24:MI:SS'),100,'Y',200063,'2bb8c738-5519-441e-8114-d3145155580d',132,'50036',30,260,200078,50002,129,0,'Y',4.0,9,13.0)
;

-- Sep 8, 2022, 4:37:22 PM CEST
UPDATE C_OrderLine SET QtyReserved=9, LineNetAmt=342, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200078
;

-- Sep 8, 2022, 4:37:22 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:23 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:22','YYYY-MM-DD HH24:MI:SS'),100,'Y',200064,'743bc087-7c29-4009-8ee1-8b9f66895817',132,'50036',20,260,200077,50002,130,0,'Y',8.0,1,9.0)
;

-- Sep 8, 2022, 4:37:23 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=47.5, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200077
;

-- Sep 8, 2022, 4:37:23 PM CEST
UPDATE C_OrderLine SET QtyReserved=1.00, LineNetAmt=90.00, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200080
;

-- Sep 8, 2022, 4:37:23 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:23 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',200065,'c96c47a2-43f4-4fc1-9c94-af2a7759e2a7',132,'50036',40,260,200079,50002,140,0,'Y',7.0,7,14.0)
;

-- Sep 8, 2022, 4:37:23 PM CEST
UPDATE C_OrderLine SET QtyReserved=7, LineNetAmt=75.6, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200079
;

-- Sep 8, 2022, 4:37:23 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:23 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',200066,'0c4f1f23-4aeb-4381-8181-0902bdfcd68e',132,'50036',10,260,200076,50002,141,0,'Y',23.0,21,44.0)
;

-- Sep 8, 2022, 4:37:23 PM CEST
UPDATE C_OrderLine SET QtyReserved=21, LineNetAmt=56.7, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200076
;

-- Sep 8, 2022, 4:37:23 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:37:23 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),100,200025,109,611.80,0.0,'N','N','ecaafac4-1bd6-493b-a37b-c523805f9328')
;

-- Sep 8, 2022, 4:37:23 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=611.80, GrandTotal=611.80, Volume=0.00, Weight=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:37:23 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50036: Grand Total=611.80 (#5)',Updated=TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200068
;

-- Sep 8, 2022, 4:37:23 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50036: Grand Total=611.80 (#5)', ElapsedTimeMS=1632,Updated=TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200068
;

-- Sep 8, 2022, 4:37:23 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200068
;

-- Sep 8, 2022, 4:37:23 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200069,200023,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),116,0,200025,259,'66a2e476-7fe8-456e-8ba8-229aaaaf48ee')
;

-- Sep 8, 2022, 4:37:24 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:23','YYYY-MM-DD HH24:MI:SS'),200069,'PC',200023,259,186,200025,0.0,'bb197e17-f06f-430c-92fa-8404305e762c')
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200069
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200069
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647844234.2341,Updated=TO_TIMESTAMP('2022-09-08 16:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200025 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:24 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200025 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200025 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:24 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200025 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200025
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50036: Grand Total=611.80',Updated=TO_TIMESTAMP('2022-09-08 16:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200069
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50036: Grand Total=611.80', ElapsedTimeMS=1258,Updated=TO_TIMESTAMP('2022-09-08 16:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200069
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200069
;

-- Sep 8, 2022, 4:37:24 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200023
;

-- Sep 8, 2022, 4:37:27 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:37:27','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:37:27','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200024,'50035: Grand Total=168.95',259,0,200026,'52b4d41c-f324-4f4f-a812-60695fa53ddc')
;

-- Sep 8, 2022, 4:37:27 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200024
;

-- Sep 8, 2022, 4:37:28 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200070,200024,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:27','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:27','YYYY-MM-DD HH24:MI:SS'),116,0,200026,259,'be1a618b-5119-4129-a0c1-9fd5c1fe4305')
;

-- Sep 8, 2022, 4:37:28 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),200070,'PC',200024,259,183,200026,0.0,'a856695c-b1d2-4192-8b0f-50578e51dcb5')
;

-- Sep 8, 2022, 4:37:28 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200070
;

-- Sep 8, 2022, 4:37:28 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200070
;

-- Sep 8, 2022, 4:37:28 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200070
;

-- Sep 8, 2022, 4:37:28 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=300,Updated=TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200070
;

-- Sep 8, 2022, 4:37:28 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200070
;

-- Sep 8, 2022, 4:37:28 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200071,200024,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),116,0,200026,259,'67ee8026-9655-4bcb-8cb9-5365891ec463')
;

-- Sep 8, 2022, 4:37:28 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),200071,'PC',200024,259,185,200026,0.0,'d034edf1-4fb8-4fe9-aeaf-b8a1ae13ba80')
;

-- Sep 8, 2022, 4:37:28 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200071
;

-- Sep 8, 2022, 4:37:28 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200071
;

-- Sep 8, 2022, 4:37:28 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:29 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:28','YYYY-MM-DD HH24:MI:SS'),100,'Y',200067,'9c8ee6bf-ad59-49ff-b4f4-b2a94da9d049',132,'50035',40,260,200084,50002,123,0,'Y',13.0,1,14.0)
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=61.75, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200084
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:29 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',200068,'6835b5ee-5521-4484-be19-11ff30000109',132,'50035',20,260,200082,50002,125,0,'Y',5.0,1,6.0)
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=76, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200082
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:29 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',200069,'b2360822-fbe0-4e64-bc34-bdfd3720c425',132,'50035',10,260,200081,50002,139,0,'Y',3.0,2,5.0)
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=16.2, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200081
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:29 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',200070,'58177951-e90c-4b49-be16-e6427f712252',132,'50035',30,260,200083,50002,147,0,'Y',7.0,1,8.0)
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=15, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200083
;

-- Sep 8, 2022, 4:37:29 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:37:29 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,200026,109,168.95,0.0,'N','N','50fd2ec2-2b3f-442f-a81f-97a4c9a411de')
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=168.95, GrandTotal=168.95, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50035: Grand Total=168.95 (#4)',Updated=TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200071
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50035: Grand Total=168.95 (#4)', ElapsedTimeMS=1987,Updated=TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200071
;

-- Sep 8, 2022, 4:37:29 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200071
;

-- Sep 8, 2022, 4:37:30 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200072,200024,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:29','YYYY-MM-DD HH24:MI:SS'),116,0,200026,259,'2e0036ab-d686-4cbb-92a0-721d5aacde29')
;

-- Sep 8, 2022, 4:37:30 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:30','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:30','YYYY-MM-DD HH24:MI:SS'),200072,'PC',200024,259,186,200026,0.0,'f1eff2fe-11a0-450f-a2c3-2c465cdb2506')
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200072
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200072
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647850556.557,Updated=TO_TIMESTAMP('2022-09-08 16:37:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200026 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:30 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200026 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200026 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:30 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200026 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200026
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50035: Grand Total=168.95',Updated=TO_TIMESTAMP('2022-09-08 16:37:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200072
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50035: Grand Total=168.95', ElapsedTimeMS=579,Updated=TO_TIMESTAMP('2022-09-08 16:37:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200072
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200072
;

-- Sep 8, 2022, 4:37:30 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200024
;

-- Sep 8, 2022, 4:37:34 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:37:34','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:37:34','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200025,'50029: Grand Total=213.75',259,0,200029,'af54eb64-36cf-4900-8066-754cf708eb05')
;

-- Sep 8, 2022, 4:37:34 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200025
;

-- Sep 8, 2022, 4:37:34 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200073,200025,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:34','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:34','YYYY-MM-DD HH24:MI:SS'),116,0,200029,259,'be6cbe3e-53a2-401a-a35c-faad18a92d20')
;

-- Sep 8, 2022, 4:37:35 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:34','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:34','YYYY-MM-DD HH24:MI:SS'),200073,'PC',200025,259,183,200029,0.0,'5511fc84-a4e1-4452-9a70-17ece1b18f17')
;

-- Sep 8, 2022, 4:37:35 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200073
;

-- Sep 8, 2022, 4:37:35 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200073
;

-- Sep 8, 2022, 4:37:35 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200073
;

-- Sep 8, 2022, 4:37:35 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=1079,Updated=TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200073
;

-- Sep 8, 2022, 4:37:35 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200073
;

-- Sep 8, 2022, 4:37:35 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200074,200025,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),116,0,200029,259,'e0ffb852-5c45-49ab-95c6-048d4ea90e1e')
;

-- Sep 8, 2022, 4:37:35 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),200074,'PC',200025,259,185,200029,0.0,'b0c7ae5e-8996-4001-aba3-4a91ef57d368')
;

-- Sep 8, 2022, 4:37:35 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200074
;

-- Sep 8, 2022, 4:37:35 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200074
;

-- Sep 8, 2022, 4:37:35 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:35 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),100,'Y',200071,'ba79516c-c1e9-4dd1-849b-0246e2092a35',132,'50029',20,260,200089,50002,123,0,'Y',14.0,1,15.0)
;

-- Sep 8, 2022, 4:37:35 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=61.75, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200089
;

-- Sep 8, 2022, 4:37:35 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:36 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:35','YYYY-MM-DD HH24:MI:SS'),100,'Y',200072,'3d0e51e2-ced5-48b5-83f2-5a0dc202acc0',132,'50029',10,260,200088,50002,125,0,'Y',6.0,2,8.0)
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=152, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200088
;

-- Sep 8, 2022, 4:37:36 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:37:36 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),100,200029,109,213.75,0.0,'N','N','4bed6c65-6605-4482-8746-2f2ad5ad654c')
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=213.75, GrandTotal=213.75, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50029: Grand Total=213.75 (#2)',Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200074
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50029: Grand Total=213.75 (#2)', ElapsedTimeMS=1213,Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200074
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200074
;

-- Sep 8, 2022, 4:37:36 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200075,200025,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),116,0,200029,259,'1ca2efd3-331b-4cb3-a68f-6a5c5265cf21')
;

-- Sep 8, 2022, 4:37:36 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),200075,'PC',200025,259,186,200029,0.0,'72b015b3-4c09-4818-aa46-752381e469ba')
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200075
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200075
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647856735.7358,Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200029 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:36 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200029 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200029 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:36 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200029 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200029
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50029: Grand Total=213.75',Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200075
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50029: Grand Total=213.75', ElapsedTimeMS=758,Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200075
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200075
;

-- Sep 8, 2022, 4:37:36 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200025
;

-- Sep 8, 2022, 4:37:40 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:37:40','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:37:40','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200026,'50028: Grand Total=256.50',259,0,200030,'825a7e44-6e3e-48da-94f2-971b213778d0')
;

-- Sep 8, 2022, 4:37:40 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200026
;

-- Sep 8, 2022, 4:37:40 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200076,200026,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:40','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:40','YYYY-MM-DD HH24:MI:SS'),116,0,200030,259,'c6c40205-6e4f-4bfd-8565-8b166146c3e7')
;

-- Sep 8, 2022, 4:37:41 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:40','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:40','YYYY-MM-DD HH24:MI:SS'),200076,'PC',200026,259,183,200030,0.0,'ebfa8bd2-2151-4914-b873-15d34db56412')
;

-- Sep 8, 2022, 4:37:41 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200076
;

-- Sep 8, 2022, 4:37:41 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200076
;

-- Sep 8, 2022, 4:37:41 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200076
;

-- Sep 8, 2022, 4:37:41 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=1260,Updated=TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200076
;

-- Sep 8, 2022, 4:37:41 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200076
;

-- Sep 8, 2022, 4:37:41 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200077,200026,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),116,0,200030,259,'d5af2f92-3975-4371-a369-1954d1031197')
;

-- Sep 8, 2022, 4:37:41 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),200077,'PC',200026,259,185,200030,0.0,'24416b8f-d9a7-422f-ba1a-27cd8448d069')
;

-- Sep 8, 2022, 4:37:41 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200077
;

-- Sep 8, 2022, 4:37:41 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200077
;

-- Sep 8, 2022, 4:37:41 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:42 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:41','YYYY-MM-DD HH24:MI:SS'),100,'Y',200073,'72ffa784-4fe3-440f-8aa8-c8e2df9bc74b',132,'50028',20,260,200091,50002,124,0,'Y',3.0,1,4.0)
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=57, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200091
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:42 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),100,'Y',200074,'79aa59e7-4728-458c-a94c-4338b74bb9e3',132,'50028',10,260,200090,50002,125,0,'Y',8.0,1,9.0)
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=76, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200090
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:42 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),100,'Y',200075,'92cb0b6f-5b0c-4316-b6f9-9bda41687684',132,'50028',30,260,200092,50002,128,0,'Y',1.0,2,3.0)
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=47.50, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200092
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:42 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),100,'Y',200076,'88c00703-920b-4787-8b2a-719c39bfd2d3',132,'50028',40,260,200093,50002,129,0,'Y',13.0,2,15.0)
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=76, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200093
;

-- Sep 8, 2022, 4:37:42 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:37:42 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),100,200030,109,256.50,0.0,'N','N','272fc005-ae44-4f20-97c9-a8e50219154d')
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=256.50, GrandTotal=256.50, Volume=0.0, Weight=20.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50028: Grand Total=256.50 (#4)',Updated=TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200077
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50028: Grand Total=256.50 (#4)', ElapsedTimeMS=1856,Updated=TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200077
;

-- Sep 8, 2022, 4:37:42 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200077
;

-- Sep 8, 2022, 4:37:43 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200078,200026,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:42','YYYY-MM-DD HH24:MI:SS'),116,0,200030,259,'9b8a64b1-bc8c-40e2-97f7-a1095a019a4d')
;

-- Sep 8, 2022, 4:37:43 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:43','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:43','YYYY-MM-DD HH24:MI:SS'),200078,'PC',200026,259,186,200030,0.0,'1db0c083-f71c-447a-874d-5503b257d2d2')
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200078
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200078
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647863389.3892,Updated=TO_TIMESTAMP('2022-09-08 16:37:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200030 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:43 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200030 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200030 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:43 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200030 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200030
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50028: Grand Total=256.50',Updated=TO_TIMESTAMP('2022-09-08 16:37:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200078
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50028: Grand Total=256.50', ElapsedTimeMS=411,Updated=TO_TIMESTAMP('2022-09-08 16:37:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200078
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200078
;

-- Sep 8, 2022, 4:37:43 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200026
;

-- Sep 8, 2022, 4:37:47 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:37:47','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:37:47','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200027,'50024: Grand Total=294.7 - Order Description from Business Partner Definition',259,0,200032,'c0b34f42-e517-49d7-aeb7-51a96ce0c820')
;

-- Sep 8, 2022, 4:37:47 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200027
;

-- Sep 8, 2022, 4:37:47 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200079,200027,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:47','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:47','YYYY-MM-DD HH24:MI:SS'),116,0,200032,259,'f186cc74-fe4b-406a-aa14-ce8a251c50a9')
;

-- Sep 8, 2022, 4:37:48 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:47','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:47','YYYY-MM-DD HH24:MI:SS'),200079,'PC',200027,259,183,200032,0.0,'604423a6-0752-49a0-a848-1ab8d6a1213b')
;

-- Sep 8, 2022, 4:37:48 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200079
;

-- Sep 8, 2022, 4:37:48 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200079
;

-- Sep 8, 2022, 4:37:48 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200079
;

-- Sep 8, 2022, 4:37:48 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=1252,Updated=TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200079
;

-- Sep 8, 2022, 4:37:48 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200079
;

-- Sep 8, 2022, 4:37:48 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200080,200027,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),116,0,200032,259,'0acfe0c2-a104-4358-9af9-c6b7b0234327')
;

-- Sep 8, 2022, 4:37:48 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),200080,'PC',200027,259,185,200032,0.0,'4d7bd01f-2dc9-496b-a378-7aefb0c19652')
;

-- Sep 8, 2022, 4:37:48 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200080
;

-- Sep 8, 2022, 4:37:48 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200080
;

-- Sep 8, 2022, 4:37:48 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:49 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',200077,'5c2c5c5b-117d-4487-b0f6-1043797d6259',132,'50024',10,260,200094,50002,125,0,'Y',9.0,1,10.0)
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=76, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200094
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:49 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),100,'Y',200078,'fd3709f7-f40a-4223-959d-084e4bab8022',132,'50024',20,260,200095,50002,141,0,'Y',44.0,81,125.0)
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_OrderLine SET QtyReserved=81, LineNetAmt=218.7, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200095
;

-- Sep 8, 2022, 4:37:49 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:37:49 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),100,200032,109,294.7,0.0,'N','N','b92ac04a-f55a-4c21-8314-de6a0bb97c31')
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=294.7, GrandTotal=294.7, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50024: Grand Total=294.7 (#2) - Order Description from Business Partner Definition',Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200080
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50024: Grand Total=294.7 (#2) - Order Description from Business Partner Definition', ElapsedTimeMS=1326,Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200080
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200080
;

-- Sep 8, 2022, 4:37:49 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200081,200027,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),116,0,200032,259,'07de9513-7905-4ce2-9c04-31650130e6d2')
;

-- Sep 8, 2022, 4:37:49 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),200081,'PC',200027,259,186,200032,0.0,'04dc36a7-5a91-4a67-8e1a-55871fbb0899')
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200081
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200081
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647869843.8438,Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200032 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:49 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200032 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200032 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:49 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200032 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200032
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50024: Grand Total=294.7 - Order Description from Business Partner Definition',Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200081
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50024: Grand Total=294.7 - Order Description from Business Partner Definition', ElapsedTimeMS=866,Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200081
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200081
;

-- Sep 8, 2022, 4:37:49 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200027
;

-- Sep 8, 2022, 4:37:53 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200028,'50021: Grand Total=217.35',259,0,200033,'9b2d03f2-bb8e-45df-9662-a067ab837789')
;

-- Sep 8, 2022, 4:37:53 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200028
;

-- Sep 8, 2022, 4:37:53 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200082,200028,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),116,0,200033,259,'0221c00e-6f31-45cb-9d76-a7602acc5330')
;

-- Sep 8, 2022, 4:37:53 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),200082,'PC',200028,259,183,200033,0.0,'26943409-4d70-4f06-89d4-80cba4b903e0')
;

-- Sep 8, 2022, 4:37:53 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200082
;

-- Sep 8, 2022, 4:37:53 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200082
;

-- Sep 8, 2022, 4:37:53 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200082
;

-- Sep 8, 2022, 4:37:53 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=894,Updated=TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200082
;

-- Sep 8, 2022, 4:37:53 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200082
;

-- Sep 8, 2022, 4:37:54 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200083,200028,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:53','YYYY-MM-DD HH24:MI:SS'),116,0,200033,259,'f3fef342-e4b9-4355-94cc-6884a9ff02c2')
;

-- Sep 8, 2022, 4:37:54 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),200083,'PC',200028,259,185,200033,0.0,'2ffeff9e-92b7-4359-9025-87feeb32918e')
;

-- Sep 8, 2022, 4:37:54 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200083
;

-- Sep 8, 2022, 4:37:54 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200083
;

-- Sep 8, 2022, 4:37:54 PM CEST
UPDATE C_OrderLine SET QtyReserved=3.00, LineNetAmt=128.25, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200097
;

-- Sep 8, 2022, 4:37:54 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:37:54 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),100,'Y',200079,'ec3b4025-e172-48f2-845a-65af63c7e0e7',132,'50021',10,260,200096,50002,139,0,'Y',5.0,11,16.0)
;

-- Sep 8, 2022, 4:37:54 PM CEST
UPDATE C_OrderLine SET QtyReserved=11, LineNetAmt=89.1, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200096
;

-- Sep 8, 2022, 4:37:54 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:37:54 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),100,200033,109,217.35,0.0,'N','N','bd685553-97e1-4f20-aec1-9942f25b7a50')
;

-- Sep 8, 2022, 4:37:54 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=217.35, GrandTotal=217.35, Volume=0.00, Weight=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:37:54 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50021: Grand Total=217.35 (#2)',Updated=TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200083
;

-- Sep 8, 2022, 4:37:54 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50021: Grand Total=217.35 (#2)', ElapsedTimeMS=719,Updated=TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200083
;

-- Sep 8, 2022, 4:37:54 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200083
;

-- Sep 8, 2022, 4:37:54 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200084,200028,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),116,0,200033,259,'4d512dc2-5c8f-4822-93fa-6fc02c1a0f9a')
;

-- Sep 8, 2022, 4:37:55 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:54','YYYY-MM-DD HH24:MI:SS'),200084,'PC',200028,259,186,200033,0.0,'fb7ad43b-e657-4f6e-aa70-1624957d110e')
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200084
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200084
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647875246.2466,Updated=TO_TIMESTAMP('2022-09-08 16:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200033 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:55 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200033 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200033 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:37:55 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200033 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200033
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50021: Grand Total=217.35',Updated=TO_TIMESTAMP('2022-09-08 16:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200084
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50021: Grand Total=217.35', ElapsedTimeMS=1269,Updated=TO_TIMESTAMP('2022-09-08 16:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200084
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200084
;

-- Sep 8, 2022, 4:37:55 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200028
;

-- Sep 8, 2022, 4:37:58 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:37:58','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:37:58','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',102,100,101,200029,'50020: Grand Total=344.80',259,0,200034,'452e5c90-b1fe-4599-b9fe-4e4f7638c58e')
;

-- Sep 8, 2022, 4:37:58 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200029
;

-- Sep 8, 2022, 4:37:59 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,102,200085,200029,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:58','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:58','YYYY-MM-DD HH24:MI:SS'),116,0,200034,259,'5a374198-8315-478c-a3a8-a0d437dbdf71')
;

-- Sep 8, 2022, 4:37:59 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),200085,'PC',200029,259,183,200034,0.0,'dadff03a-7817-4b86-bd7c-8e9e75206453')
;

-- Sep 8, 2022, 4:37:59 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200085
;

-- Sep 8, 2022, 4:37:59 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200085
;

-- Sep 8, 2022, 4:37:59 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200085
;

-- Sep 8, 2022, 4:37:59 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=447,Updated=TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200085
;

-- Sep 8, 2022, 4:37:59 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200085
;

-- Sep 8, 2022, 4:37:59 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,102,200086,200029,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),116,0,200034,259,'0bc7cd6a-b27f-4fbe-8514-20e4cdb004ed')
;

-- Sep 8, 2022, 4:37:59 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),200086,'PC',200029,259,185,200034,0.0,'8f10587c-c720-405d-a0ca-bb43b24d0e4b')
;

-- Sep 8, 2022, 4:37:59 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200086
;

-- Sep 8, 2022, 4:37:59 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200086
;

-- Sep 8, 2022, 4:37:59 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:38:00 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:37:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',200080,'b3a26786-aff2-444a-a76c-ce6c74da5a0d',132,'50020',60,260,200103,50002,129,0,'Y',15.0,5,20.0)
;

-- Sep 8, 2022, 4:38:00 PM CEST
UPDATE C_OrderLine SET QtyReserved=5, LineNetAmt=190, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:38:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200103
;

-- Sep 8, 2022, 4:38:00 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:38:00 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:38:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:38:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',200081,'3ccbb1e6-b1f0-41f8-896b-ca4cfbbd90ab',132,'50020',50,260,200102,50002,134,0,'Y',1.0,1,2.0)
;

-- Sep 8, 2022, 4:38:00 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=67.5, Discount=-2.27,Updated=TO_TIMESTAMP('2022-09-08 16:38:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200102
;

-- Sep 8, 2022, 4:38:00 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:38:00 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:38:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:38:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',200082,'a1abe3c3-672a-42db-b475-b8d19f81c20d',132,'50020',70,260,200104,50002,137,0,'Y',34.0,1,35.0)
;

-- Sep 8, 2022, 4:38:00 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=3, Discount=0.00,Updated=TO_TIMESTAMP('2022-09-08 16:38:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200104
;

-- Sep 8, 2022, 4:38:00 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:38:01 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:38:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:38:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',200083,'3edaea89-6c37-48b8-872a-f3237760c086',132,'50020',40,260,200101,50002,139,0,'Y',16.0,2,18.0)
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=16.2, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200101
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:38:01 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',200084,'59ed61d2-82d8-48e9-90a7-5006f726aa94',132,'50020',10,260,200098,50002,141,0,'Y',125.0,3,128.0)
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE C_OrderLine SET QtyReserved=3, LineNetAmt=8.1, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200098
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:38:01 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',200085,'2c6f311e-9c6e-4459-b62e-ff0fe151716e',132,'50020',30,260,200100,50002,143,0,'Y',8.0,1,9.0)
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=27, Discount=10.00,Updated=TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200100
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:38:01 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',200086,'13b0dc9e-753d-4d15-b5ed-e08d1a7077a3',132,'50020',20,260,200099,50002,50007,0,'Y',4.0,1,5.0)
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=33.00, Discount=5.71,Updated=TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200099
;

-- Sep 8, 2022, 4:38:01 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:38:01 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),100,200034,109,344.80,0.0,'N','N','1135b5af-a87b-4bbc-8da0-273c9064c24f')
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=344.80, GrandTotal=344.80, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50020: Grand Total=344.80 (#7)',Updated=TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200086
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50020: Grand Total=344.80 (#7)', ElapsedTimeMS=2961,Updated=TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200086
;

-- Sep 8, 2022, 4:38:01 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200086
;

-- Sep 8, 2022, 4:38:02 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,102,200087,200029,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:38:01','YYYY-MM-DD HH24:MI:SS'),116,0,200034,259,'3763e7e3-c40f-40ac-8a0b-67b58e98dbe6')
;

-- Sep 8, 2022, 4:38:02 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (102,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:38:02','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:38:02','YYYY-MM-DD HH24:MI:SS'),200087,'PC',200029,259,186,200034,0.0,'abf15385-8564-4f31-b374-8a9eb47eeb8e')
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:38:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200087
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:38:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200087
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647882513.5132,Updated=TO_TIMESTAMP('2022-09-08 16:38:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200034 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:38:02 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200034 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200034 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:38:02 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200034 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200034
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50020: Grand Total=344.80',Updated=TO_TIMESTAMP('2022-09-08 16:38:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200087
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50020: Grand Total=344.80', ElapsedTimeMS=536,Updated=TO_TIMESTAMP('2022-09-08 16:38:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200087
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:38:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200087
;

-- Sep 8, 2022, 4:38:02 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:38:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200029
;

-- Sep 8, 2022, 4:38:06 PM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,50001,'ON',101,100,101,200030,'50019: Grand Total=237.5',259,0,200035,'acecec23-c1d2-4207-b536-7618d4b97960')
;

-- Sep 8, 2022, 4:38:06 PM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200030
;

-- Sep 8, 2022, 4:38:06 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,50001,100,101,200088,200030,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),116,0,200035,259,'e4b7d2b4-5bf8-4b09-817d-f4667d02d67f')
;

-- Sep 8, 2022, 4:38:06 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),200088,'PC',200030,259,183,200035,0.0,'504a121f-c85c-407a-a675-b7a7b9961117')
;

-- Sep 8, 2022, 4:38:06 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200088
;

-- Sep 8, 2022, 4:38:06 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200088
;

-- Sep 8, 2022, 4:38:06 PM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200088
;

-- Sep 8, 2022, 4:38:06 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=794,Updated=TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200088
;

-- Sep 8, 2022, 4:38:06 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200088
;

-- Sep 8, 2022, 4:38:07 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,50001,100,101,200089,200030,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:38:06','YYYY-MM-DD HH24:MI:SS'),116,0,200035,259,'26f41928-9478-4618-ae23-d3a3849de77c')
;

-- Sep 8, 2022, 4:38:07 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),200089,'PC',200030,259,185,200035,0.0,'526e3889-23e8-4acb-bdc9-3fa8dd68a82c')
;

-- Sep 8, 2022, 4:38:07 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200089
;

-- Sep 8, 2022, 4:38:07 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200089
;

-- Sep 8, 2022, 4:38:07 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:38:07 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',200087,'e46206c1-a035-4677-98ff-63f4c553ee8c',132,'50019',10,260,200105,50002,127,0,'Y',5.0,5,10.0)
;

-- Sep 8, 2022, 4:38:07 PM CEST
UPDATE C_OrderLine SET QtyReserved=5, LineNetAmt=142.5, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200105
;

-- Sep 8, 2022, 4:38:07 PM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 8, 2022, 4:38:07 PM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,50001,TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',200088,'28fa9415-dccf-4209-9e37-3508201e8d47',132,'50019',20,260,200106,50002,130,0,'Y',9.0,2,11.0)
;

-- Sep 8, 2022, 4:38:07 PM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=95.0, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200106
;

-- Sep 8, 2022, 4:38:07 PM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:38:07 PM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,50001,'Y',TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),100,200035,109,237.5,0.0,'N','N','2943a976-aaf9-4971-98e5-05925ab23e40')
;

-- Sep 8, 2022, 4:38:07 PM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=237.5, GrandTotal=237.5, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:38:07 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50019: Grand Total=237.5 (#2)',Updated=TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200089
;

-- Sep 8, 2022, 4:38:07 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50019: Grand Total=237.5 (#2)', ElapsedTimeMS=901,Updated=TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200089
;

-- Sep 8, 2022, 4:38:07 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200089
;

-- Sep 8, 2022, 4:38:08 PM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,50001,100,101,200090,200030,'Y','N','N','ON',TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-08 16:38:07','YYYY-MM-DD HH24:MI:SS'),116,0,200035,259,'a2bd032c-976f-4b9b-a234-9537aa32f61a')
;

-- Sep 8, 2022, 4:38:08 PM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,50001,TO_TIMESTAMP('2022-09-08 16:38:08','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-08 16:38:08','YYYY-MM-DD HH24:MI:SS'),200090,'PC',200030,259,186,200035,0.0,'8959e5c3-2879-4d6c-8926-67a3cbc4c450')
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-08 16:38:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200090
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-08 16:38:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200090
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662647888432.4324,Updated=TO_TIMESTAMP('2022-09-08 16:38:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200035 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:38:08 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200035 AND C_AcctSchema_ID=101
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200035 AND Processed='Y' AND IsActive='Y'
;

-- Sep 8, 2022, 4:38:08 PM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200035 AND C_AcctSchema_ID=200000
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200035
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='50019: Grand Total=237.5',Updated=TO_TIMESTAMP('2022-09-08 16:38:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200090
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='50019: Grand Total=237.5', ElapsedTimeMS=455,Updated=TO_TIMESTAMP('2022-09-08 16:38:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200090
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-08 16:38:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200090
;

-- Sep 8, 2022, 4:38:08 PM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-08 16:38:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200030
;

-- Sep 8, 2022, 4:38:53 PM CEST
UPDATE PA_DashboardPreference SET FlexGrow=2,Updated=TO_TIMESTAMP('2022-09-08 16:38:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200000
;

-- Sep 9, 2022, 11:14:54 AM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200038,11,11,'Y',TO_TIMESTAMP('2022-09-09 11:14:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 11:14:54','YYYY-MM-DD HH24:MI:SS'),100,'502','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-08-31','YYYY-MM-DD'),TO_TIMESTAMP('2022-08-31','YYYY-MM-DD'),TO_TIMESTAMP('2022-08-31','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,103,101,'N',114,103,0,'N',109,'Y','A','I','P','Y','N','N','N','N',103,114,'N',109,'N',114,'N',0.0,0.0,0.00,0.00,200003,0,'N','32f67365-18a3-4b72-9350-5ad757dec191','N','N')
;

-- Sep 9, 2022, 11:15:03 AM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200110,11,11,'Y',TO_TIMESTAMP('2022-09-09 11:15:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 11:15:03','YYYY-MM-DD HH24:MI:SS'),100,200038,10,TO_TIMESTAMP('2022-08-31','YYYY-MM-DD'),TO_TIMESTAMP('2022-08-31','YYYY-MM-DD'),130,100,103,2,0,0,0,100,50,47.5,104,114,0,109,95.0,45,5.00,0,'N','N',47.5,2,0,0,0,'dfb60856-56ce-44f1-95db-10d0e1ff9bee','N','N')
;

-- Sep 9, 2022, 11:15:04 AM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200038
;

-- Sep 9, 2022, 11:15:04 AM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200038
;

-- Sep 9, 2022, 11:15:14 AM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-09 11:15:14','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-09 11:15:14','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,11,'ON',101,100,101,200033,'502: Grand Total=95.0',259,0,200038,'6ad86417-6261-4402-999c-063c6c197d57')
;

-- Sep 9, 2022, 11:15:14 AM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-09 11:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200033
;

-- Sep 9, 2022, 11:15:15 AM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,11,100,101,200097,200033,'Y','N','N','ON',TO_TIMESTAMP('2022-09-09 11:15:14','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-09 11:15:14','YYYY-MM-DD HH24:MI:SS'),116,0,200038,259,'75ca1177-e8e0-4052-9823-5fc053c2433e')
;

-- Sep 9, 2022, 11:15:15 AM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,11,TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),200097,'PC',200033,259,183,200038,0.0,'f4390ded-8ab9-4ca3-8970-afb500de9612')
;

-- Sep 9, 2022, 11:15:15 AM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200097
;

-- Sep 9, 2022, 11:15:15 AM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200097
;

-- Sep 9, 2022, 11:15:15 AM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200097
;

-- Sep 9, 2022, 11:15:15 AM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=469,Updated=TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200097
;

-- Sep 9, 2022, 11:15:15 AM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200097
;

-- Sep 9, 2022, 11:15:15 AM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,11,100,101,200098,200033,'Y','N','N','ON',TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),116,0,200038,259,'7e246960-e0de-44d0-8fcb-74cc7a5921dd')
;

-- Sep 9, 2022, 11:15:16 AM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,11,TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-09 11:15:15','YYYY-MM-DD HH24:MI:SS'),200098,'PC',200033,259,185,200038,0.0,'27cd50c2-58e7-49d1-bf84-a29187eaa7a9')
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200098
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200098
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 9, 2022, 11:15:16 AM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,0,TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',200092,'11b873fe-4304-478c-bef6-9827496f6172',132,'502',10,260,200110,103,130,0,'Y',3.0,2,5.0)
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE C_OrderLine SET QtyReserved=2, LineNetAmt=95.0, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200110
;

-- Sep 9, 2022, 11:15:16 AM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200038
;

-- Sep 9, 2022, 11:15:16 AM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,11,'Y',TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),100,200038,104,95.0,0.0,'N','N','23cae01f-0f46-4c34-8ee8-15bb7afa312d')
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=95.0, GrandTotal=95.0, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200038
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='502: Grand Total=95.0 (#1)',Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200098
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='502: Grand Total=95.0 (#1)', ElapsedTimeMS=1340,Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200098
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200098
;

-- Sep 9, 2022, 11:15:16 AM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,11,100,101,200099,200033,'Y','N','N','ON',TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),116,0,200038,259,'7720ffea-4f13-4dca-b608-0ddee11e7e36')
;

-- Sep 9, 2022, 11:15:16 AM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,11,TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),200099,'PC',200033,259,186,200038,0.0,'96abaec1-c691-4197-a97b-716bbdb86133')
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200099
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200099
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200038
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200038
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662714916887.888,Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200038
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200038 AND Processed='Y' AND IsActive='Y'
;

-- Sep 9, 2022, 11:15:16 AM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200038 AND C_AcctSchema_ID=101
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200038
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200038 AND Processed='Y' AND IsActive='Y'
;

-- Sep 9, 2022, 11:15:16 AM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200038 AND C_AcctSchema_ID=200000
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200038
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200038
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='502: Grand Total=95.0',Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200099
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='502: Grand Total=95.0', ElapsedTimeMS=952,Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200099
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200099
;

-- Sep 9, 2022, 11:15:16 AM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-09 11:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200033
;

-- Sep 9, 2022, 11:15:30 AM CEST
INSERT INTO C_Order (C_Order_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,DocStatus,DocAction,C_DocType_ID,C_DocTypeTarget_ID,IsApproved,IsCreditApproved,IsDelivered,IsInvoiced,IsPrinted,IsTransferred,DateOrdered,DatePromised,DateAcct,SalesRep_ID,C_PaymentTerm_ID,C_Currency_ID,InvoiceRule,FreightAmt,DeliveryViaRule,PriorityRule,TotalLines,GrandTotal,M_Warehouse_ID,M_PriceList_ID,Processing,C_BPartner_ID,AD_User_ID,ChargeAmt,Processed,C_BPartner_Location_ID,IsSOTrx,DeliveryRule,FreightCostRule,PaymentRule,IsDiscountPrinted,Posted,IsTaxIncluded,IsSelected,SendEMail,Bill_User_ID,Bill_BPartner_ID,CopyFrom,Bill_Location_ID,IsSelfService,C_ConversionType_ID,IsDropShip,Volume,Weight,AmountTendered,AmountRefunded,C_OrderSource_ID,ProcessedOn,IsPayScheduleValid,C_Order_UU,ShippingRateInquiry,IsPriviledgedRate) VALUES (200039,11,11,'Y',TO_TIMESTAMP('2022-09-09 11:15:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 11:15:30','YYYY-MM-DD HH24:MI:SS'),100,'503','DR','CO',0,132,'N','N','N','N','N','N',TO_TIMESTAMP('2022-08-20','YYYY-MM-DD'),TO_TIMESTAMP('2022-08-20','YYYY-MM-DD'),TO_TIMESTAMP('2022-08-20','YYYY-MM-DD'),101,105,100,'D',0,'P','5',0,0,103,101,'N',114,103,0,'N',109,'Y','A','I','P','Y','N','N','N','N',103,114,'N',109,'N',114,'N',0.0,0.0,0.00,0.00,200003,0,'N','7694b489-1ffa-4a40-a3a2-424079217af4','N','N')
;

-- Sep 9, 2022, 11:15:38 AM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200111,11,11,'Y',TO_TIMESTAMP('2022-09-09 11:15:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 11:15:38','YYYY-MM-DD HH24:MI:SS'),100,200039,10,TO_TIMESTAMP('2022-08-20','YYYY-MM-DD'),TO_TIMESTAMP('2022-08-20','YYYY-MM-DD'),130,100,103,1,0,0,0,100,50,47.5,104,114,0,109,47.5,45,5.00,0,'N','N',47.5,1,0,0,0,'34fe3e25-3a12-4b0d-9827-2cc91da9ac51','N','N')
;

-- Sep 9, 2022, 11:15:38 AM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:38 AM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:45 AM CEST
INSERT INTO C_OrderLine (C_OrderLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,Line,DateOrdered,DatePromised,M_Product_ID,C_UOM_ID,M_Warehouse_ID,QtyOrdered,QtyReserved,QtyDelivered,QtyInvoiced,C_Currency_ID,PriceList,PriceActual,C_Tax_ID,C_BPartner_ID,FreightAmt,C_BPartner_Location_ID,LineNetAmt,PriceLimit,Discount,M_AttributeSetInstance_ID,IsDescription,Processed,PriceEntered,QtyEntered,PriceCost,QtyLostSales,RRAmt,C_OrderLine_UU,CreateProduction,CreateShipment) VALUES (200112,11,11,'Y',TO_TIMESTAMP('2022-09-09 11:15:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 11:15:45','YYYY-MM-DD HH24:MI:SS'),100,200039,20,TO_TIMESTAMP('2022-08-20','YYYY-MM-DD'),TO_TIMESTAMP('2022-08-20','YYYY-MM-DD'),123,100,103,3,0,0,0,100,65,61.75,104,114,0,109,185.25,58.5,5.00,0,'N','N',61.75,3,0,0,0,'09c1346d-50c0-486c-91da-8f3f124fa949','N','N')
;

-- Sep 9, 2022, 11:15:45 AM CEST
UPDATE C_Order SET TotalLines=(SELECT COALESCE(SUM(LineNetAmt),0) FROM C_OrderLine il WHERE C_Order.C_Order_ID=il.C_Order_ID) WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:45 AM CEST
UPDATE C_Order SET GrandTotal=TotalLines+(SELECT COALESCE(SUM(TaxAmt),0) FROM C_OrderTax it WHERE C_Order.C_Order_ID=it.C_Order_ID) WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:55 AM CEST
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,TextMsg,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-09-09 11:15:55','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-09-09 11:15:55','YYYY-MM-DD HH24:MI:SS'),'N','Y',116,11,100,11,'ON',101,100,101,200034,'503: Grand Total=232.75',259,0,200039,'bc49c4d0-ba94-4a9d-a467-5d493f002d18')
;

-- Sep 9, 2022, 11:15:55 AM CEST
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-09 11:15:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200034
;

-- Sep 9, 2022, 11:15:55 AM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (183,101,11,100,101,200100,200034,'Y','N','N','ON',TO_TIMESTAMP('2022-09-09 11:15:55','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-09 11:15:55','YYYY-MM-DD HH24:MI:SS'),116,0,200039,259,'04aa4e48-1143-4ce5-b4d7-acca221ed3b9')
;

-- Sep 9, 2022, 11:15:56 AM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,11,TO_TIMESTAMP('2022-09-09 11:15:55','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-09 11:15:55','YYYY-MM-DD HH24:MI:SS'),200100,'PC',200034,259,183,200039,0.0,'5d32863d-2656-4ce4-bdc5-f0074d9e3cc1')
;

-- Sep 9, 2022, 11:15:56 AM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200100
;

-- Sep 9, 2022, 11:15:56 AM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200100
;

-- Sep 9, 2022, 11:15:56 AM CEST
UPDATE AD_WF_Activity SET WFState='CC',Updated=TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200100
;

-- Sep 9, 2022, 11:15:56 AM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg=NULL, ElapsedTimeMS=1029,Updated=TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200100
;

-- Sep 9, 2022, 11:15:56 AM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200100
;

-- Sep 9, 2022, 11:15:56 AM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (185,101,11,100,101,200101,200034,'Y','N','N','ON',TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),116,0,200039,259,'7c040851-5570-4ea4-9bf7-0b54d12d1394')
;

-- Sep 9, 2022, 11:15:56 AM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,11,TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),200101,'PC',200034,259,185,200039,0.0,'d65c0068-c307-4a19-9d80-7bac11f8a514')
;

-- Sep 9, 2022, 11:15:56 AM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200101
;

-- Sep 9, 2022, 11:15:56 AM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200101
;

-- Sep 9, 2022, 11:15:56 AM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 9, 2022, 11:15:56 AM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,0,TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',200093,'53b5b3e2-fdf9-40f0-ba94-eb44548347fb',132,'503',20,260,200112,103,123,0,'Y',3.0,3,6.0)
;

-- Sep 9, 2022, 11:15:56 AM CEST
UPDATE C_OrderLine SET QtyReserved=3, LineNetAmt=185.25, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200112
;

-- Sep 9, 2022, 11:15:56 AM CEST
UPDATE M_StorageReservation SET Qty=Qty+?, Updated=statement_timestamp(), UpdatedBy=? WHERE M_Product_ID=? AND M_Warehouse_ID=? AND M_AttributeSetInstance_ID=? AND IsSOTrx=?
;

-- Sep 9, 2022, 11:15:57 AM CEST
INSERT INTO M_StorageReservationLog (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,M_StorageReservationLog_ID,M_StorageReservationLog_UU,C_DocType_ID,DocumentNo,LineNo,AD_Table_ID,Record_ID,M_Warehouse_ID,M_Product_ID,M_AttributeSetInstance_ID,IsSOTrx,OldQty,DeltaQty,NewQty) VALUES (11,0,TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 11:15:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',200094,'7761f59d-a04a-4dff-8940-b1e7cacc2a89',132,'503',10,260,200111,103,130,0,'Y',5.0,1,6.0)
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE C_OrderLine SET QtyReserved=1, LineNetAmt=47.5, Discount=5.00,Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_OrderLine_ID=200111
;

-- Sep 9, 2022, 11:15:57 AM CEST
DELETE FROM C_OrderTax WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:57 AM CEST
INSERT INTO C_OrderTax (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Order_ID,C_Tax_ID,TaxBaseAmt,TaxAmt,Processed,IsTaxIncluded,C_OrderTax_UU) VALUES (11,11,'Y',TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),100,200039,104,232.75,0.0,'N','N','26965d8a-f4f9-42a6-8458-00b6103f9c22')
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE C_Order SET DocStatus='IP', C_DocType_ID=132, TotalLines=232.75, GrandTotal=232.75, Volume=0.0, Weight=0.0,Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='503: Grand Total=232.75 (#2)',Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200101
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='503: Grand Total=232.75 (#2)', ElapsedTimeMS=1157,Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200101
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200101
;

-- Sep 9, 2022, 11:15:57 AM CEST
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (186,101,11,100,101,200102,200034,'Y','N','N','ON',TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),116,0,200039,259,'4385082f-2098-4c3c-b272-ea98a41cedaf')
;

-- Sep 9, 2022, 11:15:57 AM CEST
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (101,101,11,'Y',100,11,TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),200102,'PC',200034,259,186,200039,0.0,'12ffc32b-72f5-4e56-86d2-459457ca749e')
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200102
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200102
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE C_OrderTax SET Processed='Y' WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE C_Order SET DocStatus='CO', DocAction='CL', IsApproved='Y', Processed='Y', ProcessedOn=1662714957691.6914,Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200039 AND Processed='Y' AND IsActive='Y'
;

-- Sep 9, 2022, 11:15:57 AM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200039 AND C_AcctSchema_ID=101
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE C_Order SET Processing='Y' WHERE C_Order_ID=200039 AND Processed='Y' AND IsActive='Y'
;

-- Sep 9, 2022, 11:15:57 AM CEST
DELETE FROM Fact_Acct WHERE AD_Table_ID=259 AND Record_ID=200039 AND C_AcctSchema_ID=200000
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE C_Order SET Processing='N' WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE C_Order SET Posted='Y',Processing='N' WHERE C_Order_ID=200039
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE AD_WF_Activity SET WFState='CC', TextMsg='503: Grand Total=232.75',Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200102
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE AD_WF_EventAudit SET WFState='CC', EventType='PX', TextMsg='503: Grand Total=232.75', ElapsedTimeMS=720,Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200102
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE AD_WF_Activity SET Processed='Y',Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200102
;

-- Sep 9, 2022, 11:15:57 AM CEST
UPDATE AD_WF_Process SET Processed='Y', WFState='CC',Updated=TO_TIMESTAMP('2022-09-09 11:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200034
;

