-- Jan 22, 2013 4:06:28 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow (Processing,FromClause,AD_InfoWindow_UU,AD_InfoWindow_ID,AD_Table_ID,EntityType,Name,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,IsActive,IsDefault,IsDistinct,IsValid) VALUES ('N','M_Product p
LEFT OUTER JOIN M_ProductPrice pr ON (p.M_Product_ID=pr.M_Product_ID AND pr.IsActive=''Y'')
LEFT OUTER JOIN M_AttributeSet pa ON (p.M_AttributeSet_ID=pa.M_AttributeSet_ID)
LEFT OUTER JOIN M_Product_PO ppo ON (p.M_Product_ID=ppo.M_Product_ID)
LEFT OUTER JOIN C_BPartner bp ON (ppo.C_BPartner_ID=bp.C_BPartner_ID)','30a3f498-24bf-48fb-b441-27a121494091',200000,208,'D','Product Info',0,0,TO_TIMESTAMP('2013-01-22 16:06:24','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-22 16:06:24','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','Y','Y','N')
;

-- Jan 22, 2013 4:06:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('1c98f7f3-8e60-4fdb-a428-6f220816f8dc',TO_TIMESTAMP('2013-01-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),100,50002,200000,0,0,TO_TIMESTAMP('2013-01-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 22, 2013 4:06:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('fb450505-9865-49d6-b8cf-1b898b525b36',TO_TIMESTAMP('2013-01-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),100,0,200000,0,0,TO_TIMESTAMP('2013-01-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 22, 2013 4:06:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('93c68a87-4496-466b-b271-a5dd1c4e5655',TO_TIMESTAMP('2013-01-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),100,102,200000,11,0,TO_TIMESTAMP('2013-01-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 22, 2013 4:06:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('151716a5-0124-43d6-bbe9-549c7cb20555',TO_TIMESTAMP('2013-01-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),100,103,200000,11,0,TO_TIMESTAMP('2013-01-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 22, 2013 4:06:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('cf82c670-bf45-45ad-a013-6a860441164e',TO_TIMESTAMP('2013-01-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),100,50001,200000,0,0,TO_TIMESTAMP('2013-01-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 22, 2013 4:07:48 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction) VALUES (200000,'A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','aedb4ebf-e98d-448d-bfc2-8aaa4fec5647',10,200000,'Y','p.Value','D','Search key for the record in the format required - must be unique',TO_TIMESTAMP('2013-01-22 16:07:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 16:07:47','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Search Key','Y','Value','Y','Y',620,10,'Like','Upper')
;

-- Jan 22, 2013 4:31:22 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction) VALUES (200000,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','a245f812-ffb4-41e1-9627-c76109f8839a',10,200001,'Y','p.Name','D','Alphanumeric identifier of the entity',TO_TIMESTAMP('2013-01-22 16:31:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 16:31:21','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Name','Y','Name','Y','Y',469,20,'Like','Upper')
;

-- Jan 22, 2013 4:32:18 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator) VALUES (200000,'The Warehouse identifies a unique Warehouse where products are stored or Services are provided.','ab46f7de-4198-492a-b44f-770fa98e8e85',19,200002,'N','0','D','Storage Warehouse and Service Point',TO_TIMESTAMP('2013-01-22 16:32:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 16:32:16','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Warehouse','Y','M_Warehouse_ID','N','Y',459,30,'=')
;

-- Jan 22, 2013 4:34:39 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction) VALUES (200000,'Use this field to enter the bar code for the product in any of the bar code symbologies (Codabar, Code 25, Code 39, Code 93, Code 128, UPC (A), UPC (E), EAN-13, EAN-8, ITF, ITF-14, ISBN, ISSN, JAN-13, JAN-8, POSTNET and FIM, MSI/Plessey, and Pharmacode) ','7b58d47c-98a4-4edb-839b-d48ad8978aee',10,200003,'Y','p.UPC','D','Bar Code (Universal Product Code or its superset European Article Number)',TO_TIMESTAMP('2013-01-22 16:34:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 16:34:38','YYYY-MM-DD HH24:MI:SS'),0,0,100,'UPC/EAN','Y','UPC','Y','Y',603,40,'Like','Upper')
;

-- Jan 22, 2013 4:34:59 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction) VALUES (200000,'The SKU indicates a user defined stock keeping unit.  It may be used for an additional bar code symbols or your own schema.','e860ddb6-8883-4b57-b16e-e818dade7d31',10,200004,'Y','p.SKU','D','Stock Keeping Unit',TO_TIMESTAMP('2013-01-22 16:34:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 16:34:59','YYYY-MM-DD HH24:MI:SS'),0,0,100,'SKU','Y','SKU','Y','Y',549,50,'Like','Upper')
;

-- Jan 22, 2013 4:35:06 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=40,Updated=TO_TIMESTAMP('2013-01-22 16:35:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200004
;

-- Jan 22, 2013 4:35:11 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=30,Updated=TO_TIMESTAMP('2013-01-22 16:35:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200003
;

-- Jan 22, 2013 4:35:17 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=50,Updated=TO_TIMESTAMP('2013-01-22 16:35:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200002
;

-- Jan 22, 2013 4:38:13 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,AD_Reference_Value_ID,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator) VALUES (200000,NULL,'f458b6d9-4710-44da-bfe9-ac5626173bde',30,200005,'Y','ppo.C_BPartner_ID','D','Current Vendor',TO_TIMESTAMP('2013-01-22 16:38:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 16:38:12','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Vendor',192,230,'N','C_BPartner_ID','Y','Y',187,60,'=')
;

-- Jan 22, 2013 4:46:06 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo) VALUES (200000,'The Discontinued check box indicates a product that has been discontinued.','806a9a68-8aa8-4ac0-8e96-ecd19b7b5d32',20,200006,'N','p.Discontinued','U','This product is no longer available',TO_TIMESTAMP('2013-01-22 16:46:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 16:46:05','YYYY-MM-DD HH24:MI:SS'),0,0,100,'D','N','Discontinued','Y','Y',278,15)
;

-- Jan 22, 2013 4:47:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsDisplayed='N',Updated=TO_TIMESTAMP('2013-01-22 16:47:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200003
;

-- Jan 22, 2013 4:47:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsDisplayed='N',Updated=TO_TIMESTAMP('2013-01-22 16:47:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200004
;

-- Jan 22, 2013 4:49:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator) VALUES (200000,'Define Product Attribute Sets to add additional attributes and values to the product. You need to define a Attribute Set if you want to enable Serial and Lot Number tracking.','3d855c5d-347a-40b6-b5e5-24c307c9798c',19,200007,'Y','p.M_AttributeSet_ID','U','Product Attribute Set',TO_TIMESTAMP('2013-01-22 16:49:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 16:49:32','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Attribute Set','Y','M_AttributeSet_ID','N','Y',2017,70,'=')
;

-- Jan 22, 2013 4:49:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET EntityType='D',Updated=TO_TIMESTAMP('2013-01-22 16:49:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200007
;

-- Jan 22, 2013 4:58:03 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator) VALUES (200000,'The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.','f533b593-e606-4665-bb04-ea8afc54a0b8',35,200008,'Y','p.M_AttributeSetInstance_ID','U','Product Attribute Set Instance',TO_TIMESTAMP('2013-01-22 16:58:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 16:58:02','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Attribute Set Instance','Y','M_AttributeSetInstance_ID','Y','Y',2019,80,'=')
;

-- Jan 22, 2013 4:58:52 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET EntityType='D', DisplayLogic='@1113|M_AttributeSet_ID@>0',Updated=TO_TIMESTAMP('2013-01-22 16:58:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200008
;

-- Jan 22, 2013 4:59:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsDisplayed='N',Updated=TO_TIMESTAMP('2013-01-22 16:59:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200008
;

-- Jan 22, 2013 5:04:14 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SelectClause='0',Updated=TO_TIMESTAMP('2013-01-22 17:04:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200008
;

-- Jan 22, 2013 5:11:34 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator) VALUES (200000,'Each Price List can have multiple versions.  The most common use is to indicate the dates that a Price List is valid for.','9acadbff-2051-44f2-b87e-7c2eeb070fbb',18,200009,'Y','pr.M_PriceList_Version_ID','D','Identifies a unique instance of a Price List',TO_TIMESTAMP('2013-01-22 17:11:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 17:11:33','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Price List Version','Y','M_PriceList_Version_ID','N','Y',450,90,'=')
;

-- Jan 22, 2013 5:11:39 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET AD_Reference_ID=19,Updated=TO_TIMESTAMP('2013-01-22 17:11:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200009
;

-- Jan 22, 2013 5:12:16 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator) VALUES (200000,'Identifies the category which this product belongs to.  Product categories are used for pricing and selection.','773eedcf-4e7c-4311-88a9-83bcbdd91e6a',19,200010,'Y','p.M_Product_Category_ID','U','Category of a Product',TO_TIMESTAMP('2013-01-22 17:12:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 17:12:15','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Product Category',163,'Y','M_Product_Category_ID','N','Y',453,100,'=')
;

-- Jan 22, 2013 5:12:19 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET EntityType='D',Updated=TO_TIMESTAMP('2013-01-22 17:12:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200010
;

-- Jan 22, 2013 5:15:53 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator) VALUES (200000,'Quantity available to promise = On Hand minus Reserved Quantity','ebec5036-25fd-4d2c-b546-9f03ca02849c',29,200011,'N','bomQtyAvailable(p.M_Product_ID,@1113|M_Warehouse_ID@,0)','D','Available Quantity (On Hand - Reserved)',TO_TIMESTAMP('2013-01-22 17:15:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 17:15:52','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Available Quantity','Y','@1113|M_Warehouse_ID@ > 0','QtyAvailable','Y','Y',2238,110,'=')
;

-- Jan 22, 2013 5:16:47 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo) VALUES (200000,'The List Price is the official List Price in the document currency.','52117f01-8bd2-439a-be61-6f520fc975da',37,200012,'N','bomPriceList(p.M_Product_ID, pr.M_PriceList_Version_ID)','U','List Price',TO_TIMESTAMP('2013-01-22 17:16:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 17:16:46','YYYY-MM-DD HH24:MI:SS'),0,0,100,'List Price','Y','PriceList','Y','Y',520,120)
;

-- Jan 22, 2013 5:17:21 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo) VALUES (200000,'The Standard Price indicates the standard or normal price for a product on this price list','81ad0338-b080-4013-b8b7-626c4eeeee99',37,200013,'N','bomPriceStd(p.M_Product_ID, pr.M_PriceList_Version_ID)','D','Standard Price',TO_TIMESTAMP('2013-01-22 17:17:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 17:17:19','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Standard Price','Y','PriceStd','Y','Y',957,130)
;

-- Jan 22, 2013 5:18:41 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator) VALUES (200000,'The On Hand Quantity indicates the quantity of a product that is on hand in a warehouse.','8243b921-60f5-4339-b497-d59789ba4eee',29,200014,'N','bomQtyOnHand(p.M_Product_ID,@1113|M_Warehouse_ID@,0)','D','On Hand Quantity',TO_TIMESTAMP('2013-01-22 17:18:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 17:18:40','YYYY-MM-DD HH24:MI:SS'),0,0,100,'On Hand Quantity','Y','@1113|M_Warehouse_ID@ > 0','QtyOnHand','Y','Y',530,140,'=')
;

-- Jan 22, 2013 5:21:47 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator) VALUES (200000,'The Reserved Quantity indicates the quantity of a product that is currently reserved.','d21eee28-6353-46f3-902d-1bc937ab8a64',29,200015,'N','bomQtyReserved(p.M_Product_ID,@1113|M_Warehouse_ID@,0)','D','Reserved Quantity',TO_TIMESTAMP('2013-01-22 17:21:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 17:21:44','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Reserved Quantity','Y','@1113|M_Warehouse_ID@ > 0','QtyReserved','Y','Y',532,150,'=')
;

-- Jan 22, 2013 5:25:41 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,SelectClause,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator) VALUES (200000,'The Ordered Quantity indicates the quantity of a product that was ordered.','ac556f97-cc01-4c77-a9f1-6e357175ddcd',29,200016,'N','bomQtyOrdered(p.M_Product_ID,@1113|M_Warehouse_ID@,0)','D','Ordered Quantity',TO_TIMESTAMP('2013-01-22 17:25:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-22 17:25:39','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Ordered Quantity','Y','@1113|M_Warehouse_ID@>0','QtyOrdered','Y','Y',531,160,'=')
;

-- Jan 22, 2013 5:32:49 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SelectClause='bomQtyOrdered(p.M_Product_ID,@1113|M_Warehouse_ID@,0) AS QtyOrdered',Updated=TO_TIMESTAMP('2013-01-22 17:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200016
;

-- Jan 22, 2013 5:33:02 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SelectClause='bomQtyReserved(p.M_Product_ID,@1113|M_Warehouse_ID@,0) AS QtyReserved',Updated=TO_TIMESTAMP('2013-01-22 17:33:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200015
;

-- Jan 22, 2013 5:33:10 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SelectClause='bomQtyOnHand(p.M_Product_ID,@1113|M_Warehouse_ID@,0) AS QtyOnHand',Updated=TO_TIMESTAMP('2013-01-22 17:33:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200014
;

-- Jan 22, 2013 5:33:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SelectClause='bomPriceStd(p.M_Product_ID, pr.M_PriceList_Version_ID) AS PriceStd',Updated=TO_TIMESTAMP('2013-01-22 17:33:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200013
;

-- Jan 22, 2013 5:33:28 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SelectClause='bomPriceList(p.M_Product_ID, pr.M_PriceList_Version_ID) AS PriceList',Updated=TO_TIMESTAMP('2013-01-22 17:33:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200012
;

-- Jan 22, 2013 5:33:36 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SelectClause='bomQtyAvailable(p.M_Product_ID,@1113|M_Warehouse_ID@,0) AS QtyAvailable',Updated=TO_TIMESTAMP('2013-01-22 17:33:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200011
;

-- Jan 22, 2013 5:34:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET FromClause='M_Product p
LEFT OUTER JOIN M_ProductPrice pr ON (p.M_Product_ID=pr.M_Product_ID AND pr.IsActive=''Y'')
LEFT OUTER JOIN M_AttributeSet pa ON (p.M_AttributeSet_ID=pa.M_AttributeSet_ID)
LEFT OUTER JOIN M_Product_PO ppo ON (p.M_Product_ID=ppo.M_Product_ID AND ppo.IsCurrentVendor=''Y'' AND ppo.IsActive=''Y'')
LEFT OUTER JOIN C_BPartner bp ON (ppo.C_BPartner_ID=bp.C_BPartner_ID)',Updated=TO_TIMESTAMP('2013-01-22 17:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200000
;

-- Jan 22, 2013 5:35:38 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET FieldLength=2000,Updated=TO_TIMESTAMP('2013-01-22 17:35:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15786
;

-- Jan 22, 2013 5:35:47 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO t_alter_column values('ad_infocolumn','SelectClause','VARCHAR(2000)',null,null)
;

-- Jan 23, 2013 2:03:52 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,ColumnName,IsDisplayed,IsActive,SeqNo,QueryOperator,SelectClause) VALUES (200000,'1ef6e0d2-8e90-4b50-8dce-486661a560b3',29,200017,'N','D',TO_TIMESTAMP('2013-01-23 14:03:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-23 14:03:50','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Unconfirmed Qty','Y','@1113|M_Warehouse_ID@>0','QtyUnconfirmed','Y','Y',170,'=','(SELECT SUM(c.TargetQty) FROM M_InOutLineConfirm c INNER JOIN M_InOutLine il ON (c.M_InOutLine_ID=il.M_InOutLine_ID) INNER JOIN M_InOut i ON (il.M_InOut_ID=i.M_InOut_ID) WHERE c.Processed=''N'' AND i.M_Warehouse_ID=@1113|M_Warehouse_ID@ AND il.M_Product_ID=p.M_Product_ID) AS QtyUnconfirmed')
;

-- Jan 23, 2013 2:05:02 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,ColumnName,IsDisplayed,IsActive,SeqNo,QueryOperator,SelectClause) VALUES (200000,'62e6fcbd-699b-4ba8-ade1-b55cbf1989e6',29,200018,'N','D',TO_TIMESTAMP('2013-01-23 14:05:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-23 14:05:01','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Unconfirmed Move','Y','@1113|M_Warehouse_ID@>0','QtyUnconfirmedMove','Y','Y',180,'=','(SELECT SUM(c.TargetQty) FROM M_MovementLineConfirm c INNER JOIN M_MovementLine ml ON (c.M_MovementLine_ID=ml.M_MovementLine_ID) INNER JOIN M_Locator l ON (ml.M_LocatorTo_ID=l.M_Locator_ID) WHERE c.Processed=''N'' AND l.M_Warehouse_ID=@1113|M_Warehouse_ID@ AND ml.M_Product_ID=p.M_Product_ID) AS QtyUnconfirmedMove')
;

-- Jan 23, 2013 2:06:15 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,ColumnName,IsDisplayed,IsActive,SeqNo,QueryOperator,SelectClause) VALUES (200000,'4060fb00-411d-4f99-907a-449228286303',37,200019,'N','D',TO_TIMESTAMP('2013-01-23 14:06:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-23 14:06:14','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Margin','Y','@1113|M_PriceList_Version_ID@>0','Margin','Y','Y',190,'=','bomPriceStd(p.M_Product_ID, pr.M_PriceList_Version_ID)-bomPriceLimit(p.M_Product_ID, pr.M_PriceList_Version_ID) AS Margin')
;

-- Jan 23, 2013 2:06:47 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200000,'a3aaf1bf-1853-42da-9bd1-0c2d4f85a0d7',10,200020,'N','D',TO_TIMESTAMP('2013-01-23 14:06:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-23 14:06:46','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Vendor','Y','Vendor','Y','Y',200,'Like','Upper','bp.Name AS Vendor')
;

-- Jan 23, 2013 2:07:36 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200000,'The Price Limit indicates the lowest price for a product stated in the Price List Currency.','683b601b-1e20-46bb-88a0-0e82f2919168',37,200021,'N','D','Lowest price for a product',TO_TIMESTAMP('2013-01-23 14:07:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-23 14:07:35','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Limit Price','Y','@1113|M_PriceList_Version_ID@>0','PriceLimit','Y','Y',955,210,'pr.PriceLimit')
;

-- Jan 23, 2013 2:07:52 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200000,'If selected, the individual instance of the product has this attribute - like the individual Serial or Lot Numbers or  Guarantee Date of a product instance.  If not selected, all instances of the product share the attribute (e.g. color=green).','cd4ef8b2-53ed-4f3e-8b29-10c024fdef69',20,200022,'N','D','The product attribute is specific to the instance (like Serial No, Lot or Guarantee Date)',TO_TIMESTAMP('2013-01-23 14:07:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-23 14:07:51','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Instance Attribute','Y','IsInstanceAttribute','Y','Y',2012,220,'pa.IsInstanceAttribute')
;

-- Jan 23, 2013 2:08:13 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsDisplayed='N',Updated=TO_TIMESTAMP('2013-01-23 14:08:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200005
;

-- Jan 23, 2013 2:08:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsQueryCriteria='Y',Updated=TO_TIMESTAMP('2013-01-23 14:08:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200002
;

-- Jan 23, 2013 2:47:09 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=5,Updated=TO_TIMESTAMP('2013-01-23 14:47:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200006
;

-- Jan 23, 2013 5:34:13 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET DisplayLogic='@1113|M_PriceList_Version_ID@>0',Updated=TO_TIMESTAMP('2013-01-23 17:34:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200012
;

-- Jan 23, 2013 5:34:17 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET DisplayLogic='@1113|M_PriceList_Version_ID@>0',Updated=TO_TIMESTAMP('2013-01-23 17:34:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200013
;

-- Jan 23, 2013 5:58:52 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2013-01-23 17:58:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200000
;

SELECT register_migration_script('201301230948_IDEMPIERE-325.sql') FROM dual
;

