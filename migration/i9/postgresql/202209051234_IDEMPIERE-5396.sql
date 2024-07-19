-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202209051234_IDEMPIERE-5396.sql') FROM dual;

-- Sep 5, 2022, 12:34:59 PM SGT
UPDATE AD_InfoColumn SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-09-05 12:34:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200256
;

-- Sep 5, 2022, 1:26:20 PM SGT
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200356,'M_RMA_CreateFrom_v','M_RMA_CreateFrom_v',0,'3',0,0,'Y',TO_TIMESTAMP('2022-09-05 13:26:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:26:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','D','N','N','L','N','Y','8bb4fa35-7dd3-4788-9ce3-274fb607fde8','N','N','N','N')
;

-- Sep 5, 2022, 1:27:15 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,FromClause,IsUnionAll) VALUES (0,0,200226,'69765c28-326e-4aed-8f91-c36e5ab64dff',TO_TIMESTAMP('2022-09-05 13:27:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Shipment/Receipt Lines',TO_TIMESTAMP('2022-09-05 13:27:14','YYYY-MM-DD HH24:MI:SS'),100,200356,10,'FROM M_InOutLine iol
JOIN M_InOut io ON (io.M_InOut_ID = iol.M_InOut_ID)','N')
;

-- Sep 5, 2022, 1:27:17 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217523,'44b7a5be-6043-4db3-a160-6a8cd40111f2',TO_TIMESTAMP('2022-09-05 13:27:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:15','YYYY-MM-DD HH24:MI:SS'),100,200226,'M_InOutLine_ID','iol.M_InOutLine_ID')
;

-- Sep 5, 2022, 1:27:18 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217524,'7ee028e9-abac-4338-bb9c-27850db80993',TO_TIMESTAMP('2022-09-05 13:27:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:17','YYYY-MM-DD HH24:MI:SS'),100,200226,'Line','iol.Line')
;

-- Sep 5, 2022, 1:27:19 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217525,'768c769d-b751-42c2-9be7-ee5c4c402eae',TO_TIMESTAMP('2022-09-05 13:27:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:18','YYYY-MM-DD HH24:MI:SS'),100,200226,'M_Product_ID','iol.M_Product_ID')
;

-- Sep 5, 2022, 1:27:19 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217526,'2ca5f953-74af-4450-b4b0-ec9ec7d3e7f3',TO_TIMESTAMP('2022-09-05 13:27:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:19','YYYY-MM-DD HH24:MI:SS'),100,200226,'C_Charge_ID','iol.C_Charge_ID')
;

-- Sep 5, 2022, 1:27:20 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217527,'ff04c117-efa1-46bf-8ca8-f91cd23651db',TO_TIMESTAMP('2022-09-05 13:27:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:19','YYYY-MM-DD HH24:MI:SS'),100,200226,'M_AttributeSetInstance_ID','iol.M_AttributeSetInstance_ID')
;

-- Sep 5, 2022, 1:27:21 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217528,'5dec3ac4-720e-408f-8b2f-2a6e2db25b95',TO_TIMESTAMP('2022-09-05 13:27:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:20','YYYY-MM-DD HH24:MI:SS'),100,200226,'SerNo','CASE WHEN iol.M_AttributeSetInstance_ID IS NOT NULL THEN (SELECT SerNo FROM M_AttributeSetInstance asi WHERE asi.M_AttributeSetInstance_ID=iol.M_AttributeSetInstance_ID) END')
;

-- Sep 5, 2022, 1:27:22 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217529,'30f4501c-2fd5-44b4-af65-3d15b0e180e1',TO_TIMESTAMP('2022-09-05 13:27:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:21','YYYY-MM-DD HH24:MI:SS'),100,200226,'QtyEntered','iol.QtyEntered')
;

-- Sep 5, 2022, 1:27:23 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217530,'5a5dc80e-b8b4-4a35-b165-678841c6ccf7',TO_TIMESTAMP('2022-09-05 13:27:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:22','YYYY-MM-DD HH24:MI:SS'),100,200226,'MovementQty','iol.MovementQty-(COALESCE((SELECT SUM(rmal.qty) FROM M_RMALine rmal JOIN M_RMA rma ON rma.M_RMA_ID=rmal.M_RMA_ID WHERE rmal.M_InOutLine_ID=iol.M_InOutLine_ID AND rma.DocStatus IN (''CO'',''CL'')),0))')
;

-- Sep 5, 2022, 1:27:24 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217531,'345fba8c-719d-4905-a6a5-ef4b85e6883d',TO_TIMESTAMP('2022-09-05 13:27:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:23','YYYY-MM-DD HH24:MI:SS'),100,200226,'Description','iol.Description')
;

-- Sep 5, 2022, 1:27:25 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217532,'e2464fb5-8ccd-49c1-8848-5e69e827dabd',TO_TIMESTAMP('2022-09-05 13:27:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:24','YYYY-MM-DD HH24:MI:SS'),100,200226,'C_BPartner_ID','io.C_BPartner_ID')
;

-- Sep 5, 2022, 1:27:25 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217533,'a0500958-9ae1-4ec9-8488-a5f71466a47d',TO_TIMESTAMP('2022-09-05 13:27:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:25','YYYY-MM-DD HH24:MI:SS'),100,200226,'M_RMA_CreateFrom_v2_ID','iol.M_InOutLine_ID')
;

-- Sep 5, 2022, 1:27:26 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217534,'a70b8a11-8977-4c3c-ba6e-702180a9f500',TO_TIMESTAMP('2022-09-05 13:27:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:25','YYYY-MM-DD HH24:MI:SS'),100,200226,'IsActive','iol.IsActive')
;

-- Sep 5, 2022, 1:27:27 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217535,'4fac1004-90d4-4a03-93e1-6c621b41ad6c',TO_TIMESTAMP('2022-09-05 13:27:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:26','YYYY-MM-DD HH24:MI:SS'),100,200226,'AD_Client_ID','iol.AD_Client_ID')
;

-- Sep 5, 2022, 1:27:28 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217536,'de4e4537-c9a9-4177-9274-e0ecd1982711',TO_TIMESTAMP('2022-09-05 13:27:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:27','YYYY-MM-DD HH24:MI:SS'),100,200226,'AD_Org_ID','iol.AD_Org_ID')
;

-- Sep 5, 2022, 1:27:29 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217537,'cfa06b28-26ef-4b0d-93ed-e1910e213c45',TO_TIMESTAMP('2022-09-05 13:27:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-05 13:27:28','YYYY-MM-DD HH24:MI:SS'),100,200226,'M_InOut_ID','io.M_InOut_ID')
;

-- Sep 5, 2022, 1:32:43 PM SGT
UPDATE AD_ViewColumn SET ColumnName='M_RMA_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-05 13:32:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217533
;

-- Sep 5, 2022, 1:32:58 PM SGT
CREATE OR REPLACE VIEW M_RMA_CreateFrom_v(M_InOutLine_ID, Line, M_Product_ID, C_Charge_ID, M_AttributeSetInstance_ID, SerNo, QtyEntered, MovementQty, Description, C_BPartner_ID, M_RMA_CreateFrom_v_ID, IsActive, AD_Client_ID, AD_Org_ID, M_InOut_ID) AS SELECT iol.M_InOutLine_ID AS M_InOutLine_ID, iol.Line AS Line, iol.M_Product_ID AS M_Product_ID, iol.C_Charge_ID AS C_Charge_ID, iol.M_AttributeSetInstance_ID AS M_AttributeSetInstance_ID, CASE WHEN iol.M_AttributeSetInstance_ID IS NOT NULL THEN (SELECT SerNo FROM M_AttributeSetInstance asi WHERE asi.M_AttributeSetInstance_ID=iol.M_AttributeSetInstance_ID) END AS SerNo, iol.QtyEntered AS QtyEntered, iol.MovementQty-(COALESCE((SELECT SUM(rmal.qty) FROM M_RMALine rmal JOIN M_RMA rma ON rma.M_RMA_ID=rmal.M_RMA_ID WHERE rmal.M_InOutLine_ID=iol.M_InOutLine_ID AND rma.DocStatus IN ('CO','CL')),0)) AS MovementQty, iol.Description AS Description, io.C_BPartner_ID AS C_BPartner_ID, iol.M_InOutLine_ID AS M_RMA_CreateFrom_v_ID, iol.IsActive AS IsActive, iol.AD_Client_ID AS AD_Client_ID, iol.AD_Org_ID AS AD_Org_ID, io.M_InOut_ID AS M_InOut_ID FROM M_InOutLine iol JOIN M_InOut io ON (io.M_InOut_ID = iol.M_InOut_ID)
;

-- Sep 5, 2022, 1:33:33 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215198,0.0,'Shipment/Receipt Line','Line on Shipment or Receipt document','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document',200356,'M_InOutLine_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:32','YYYY-MM-DD HH24:MI:SS'),100,1026,'N','N','D','N','60bf1a3e-1624-43ac-bd50-9f2e53ae64af','N','N')
;

-- Sep 5, 2022, 1:33:34 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215199,0.0,'Line No','Unique line for this document','Indicates the unique line for a document.  It will also control the display order of the lines within a document.',200356,'Line',10,'N','N','N','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:33','YYYY-MM-DD HH24:MI:SS'),100,439,'N','N','D','N','6cb98d33-8133-462a-b496-bf345621df61','N')
;

-- Sep 5, 2022, 1:33:36 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215200,0.0,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200356,231,'M_Product_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:35','YYYY-MM-DD HH24:MI:SS'),100,454,'N','N','D','N','538cb16c-21eb-4e60-a07b-b56ea471bc17','N','N')
;

-- Sep 5, 2022, 1:33:37 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215201,0.0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',200356,'C_Charge_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:36','YYYY-MM-DD HH24:MI:SS'),100,968,'N','N','D','N','e2f1fc01-d65e-4047-ba47-7da8a22e71ef','N')
;

-- Sep 5, 2022, 1:33:38 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215202,0.0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',200356,'M_AttributeSetInstance_ID',10,'N','N','N','N','N','N',35,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:37','YYYY-MM-DD HH24:MI:SS'),100,2019,'N','N','D','N','1d0fdee9-c2af-4cb3-95da-9a81b559dd3c','N','N')
;

-- Sep 5, 2022, 1:33:39 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215203,0.0,'Serial No','Product Serial Number ','The Serial Number identifies a tracked, warranted product.  It can only be used when the quantity is 1.',200356,'SerNo',2147483647,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:38','YYYY-MM-DD HH24:MI:SS'),100,568,'N','N','D','N','186333ba-ec71-4201-8068-2e24a319fe2f','N')
;

-- Sep 5, 2022, 1:33:40 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215204,0.0,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',200356,'QtyEntered',14,'N','N','N','N','N','N',29,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:39','YYYY-MM-DD HH24:MI:SS'),100,2589,'N','N','D','N','13dbe844-e30e-457d-948f-077ea611e00d','N')
;

-- Sep 5, 2022, 1:33:41 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215205,0.0,'Movement Quantity','Quantity of a product moved.','The Movement Quantity indicates the quantity of a product that has been moved.',200356,'MovementQty',14,'N','N','N','N','N','N',29,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:40','YYYY-MM-DD HH24:MI:SS'),100,1038,'N','N','D','N','c4c1966f-577d-4ec0-8825-6674dfb81122','N')
;

-- Sep 5, 2022, 1:33:42 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (215206,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200356,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:41','YYYY-MM-DD HH24:MI:SS'),100,275,'N','Y','D','N','f947f346-7a97-4a59-8c0a-afeb442870cb',10,'N')
;

-- Sep 5, 2022, 1:33:43 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215207,0.0,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200356,'C_BPartner_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:42','YYYY-MM-DD HH24:MI:SS'),100,187,'N','N','D','N','550e829a-1edf-4d18-bdce-980a23aef274','N')
;

-- Sep 5, 2022, 1:33:44 PM SGT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203644,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:43','YYYY-MM-DD HH24:MI:SS'),100,'M_RMA_CreateFrom_v_ID','M_RMA_CreateFrom_v','M_RMA_CreateFrom_v','D','453bd57f-f83a-4d5b-bb13-def9bfafff02')
;

-- Sep 5, 2022, 1:33:46 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215208,0.0,'M_RMA_CreateFrom_v',200356,'M_RMA_CreateFrom_v_ID',10,'Y','N','N','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:43','YYYY-MM-DD HH24:MI:SS'),100,203644,'N','N','D','N','68f0ff10-f2fc-462b-b275-ced85aae213d','N')
;

-- Sep 5, 2022, 1:33:47 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215209,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200356,'IsActive','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:46','YYYY-MM-DD HH24:MI:SS'),100,348,'N','N','D','N','75767984-0c05-4d00-ae1a-f1df1f430ae9','N')
;

-- Sep 5, 2022, 1:33:48 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215210,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200356,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:47','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','56657dad-5b87-4737-a2b7-63d78e62e413','N','D')
;

-- Sep 5, 2022, 1:33:49 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215211,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200356,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:48','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','49ed36cc-2f92-462f-9bf0-1b79e70d2ede','N','D')
;

-- Sep 5, 2022, 1:33:50 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215212,0.0,'Shipment/Receipt','Material Shipment Document','The Material Shipment / Receipt ',200356,'M_InOut_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:33:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:33:49','YYYY-MM-DD HH24:MI:SS'),100,1025,'N','N','D','N','05edad7b-b489-4b37-b209-ec6c1f4add6b','N')
;

-- Sep 5, 2022, 1:34:59 PM SGT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,AD_Process_UU,AllowMultipleExecution) VALUES (200142,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:34:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:34:58','YYYY-MM-DD HH24:MI:SS'),100,'Create lines from RMA','Create lines from RMA','N','M_RMA_CreateFromProcess','N','org.compiere.process.CreateFromRMA','1','D',0,0,'N','Y','9ee08695-597c-44c2-9763-3bfb9356c1d0','P')
;

-- Sep 5, 2022, 1:35:29 PM SGT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,ReadOnlyLogic,AD_Process_Para_UU) VALUES (200407,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:35:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:35:28','YYYY-MM-DD HH24:MI:SS'),100,'RMA','Return Material Authorization','A Return Material Authorization may be required to accept returns and to create Credit Memos',200142,10,30,'N',10,'Y','@M_RMA_ID@','M_RMA_ID','Y','D',2412,'@M_RMA_ID@!0','ac7f0e76-0e68-491f-b4c6-e9b369bdcc6d')
;

-- Sep 5, 2022, 1:37:39 PM SGT
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,WhereClause,IsDefault,IsDistinct,OrderByClause,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) VALUES (200023,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:37:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:37:38','YYYY-MM-DD HH24:MI:SS'),100,'Create lines from RMA',200356,'D','M_RMA_CreateFrom_v v','N','ddab41b3-89e7-4c64-80e7-12903e39730d','v.M_InOut_ID=@InOut_ID@ 
AND v.M_InOutLine_ID NOT IN (SELECT rmal.M_InOutLine_ID FROM M_RMALine rmal WHERE rmal.M_RMA_ID=@M_RMA_ID@)','N','N','v.Line','N',100,'N',0,'Y',0)
;

-- Sep 5, 2022, 1:38:08 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200260,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:38:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:38:07','YYYY-MM-DD HH24:MI:SS'),100,'Line No','Unique line for this document','Indicates the unique line for a document.  It will also control the display order of the lines within a document.',200023,'D','v.Line',10,'Y','N',439,11,'d46b34f1-eaaa-4024-8851-ee7009b9c971','Y','Line','=','Y',0,'N','Y')
;

-- Sep 5, 2022, 1:38:09 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200261,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:38:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:38:09','YYYY-MM-DD HH24:MI:SS'),100,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200023,'D','v.M_Product_ID',20,'Y','N',454,30,'2b007d9d-abe4-4498-860a-297150eaff31',231,'Y','M_Product_ID','=','Y',0,'N','Y')
;

-- Sep 5, 2022, 1:38:10 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200262,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:38:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:38:10','YYYY-MM-DD HH24:MI:SS'),100,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',200023,'D','v.C_Charge_ID',25,'Y','N',968,19,'d874c32a-8d8c-47d7-9f93-04a0d2a17d5a','Y','C_Charge_ID','N',0,'N','Y')
;

-- Sep 5, 2022, 1:38:11 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200263,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:38:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:38:10','YYYY-MM-DD HH24:MI:SS'),100,'Serial No','Product Serial Number ','The Serial Number identifies a tracked, warranted product.  It can only be used when the quantity is 1.',200023,'D','v.SerNo',30,'Y','N',568,10,'ba19ce61-b376-43c5-8f08-8544a1e6d101','Y','SerNo','Like','Upper','N',0,'N','Y')
;

-- Sep 5, 2022, 1:38:12 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200264,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:38:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:38:11','YYYY-MM-DD HH24:MI:SS'),100,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',200023,'D','v.QtyEntered',40,'Y','N',2589,29,'9b9e5196-7ca0-43fc-a91f-875884a56b0f','Y','QtyEntered','N',0,'N','Y')
;

-- Sep 5, 2022, 1:38:13 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200265,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:38:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:38:12','YYYY-MM-DD HH24:MI:SS'),100,'Movement Quantity','Quantity of a product moved.','The Movement Quantity indicates the quantity of a product that has been moved.',200023,'D','v.MovementQty',50,'Y','N',1038,29,'d5e07757-af31-4565-9af5-bbec8ca1ba0d','Y','MovementQty','=','N',10,'N','N')
;

-- Sep 5, 2022, 1:38:14 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200266,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:38:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:38:13','YYYY-MM-DD HH24:MI:SS'),100,'Description','Optional short description of the record','A description is limited to 255 characters.',200023,'D','v.Description',60,'Y','N',275,14,'90dfa024-a3c3-4fc0-8088-1f6d99688bf4','Y','Description','Like','Upper','N',10,'N','Y')
;

-- Sep 5, 2022, 1:38:15 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsReadOnly) VALUES (200267,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:38:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:38:14','YYYY-MM-DD HH24:MI:SS'),100,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200023,'D','v.C_BPartner_ID',70,'N','Y',187,30,'8bc001ea-a52a-4009-b946-e7d29348ddc7','Y','C_BPartner_ID','=','N',10,'@C_BPartner_ID@','Y','Y')
;

-- Sep 5, 2022, 1:38:16 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200268,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:38:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:38:15','YYYY-MM-DD HH24:MI:SS'),100,'Shipment/Receipt Line','Line on Shipment or Receipt document','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document',200023,'D','v.M_InOutLine_ID',80,'N','N',1026,13,'d433aa05-47b0-4b10-a9fb-106be314e5ff','Y','M_InOutLine_ID','N',0,'N','Y')
;

-- Sep 5, 2022, 1:39:47 PM SGT
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,EntityType) VALUES (200014,'79be856c-632a-4c7c-8c37-6e7bc55a6bff',0,0,'Y',TO_TIMESTAMP('2022-09-05 13:39:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:39:46','YYYY-MM-DD HH24:MI:SS'),100,10,200142,200023,'B','D')
;

-- Sep 5, 2022, 1:40:39 PM SGT
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2022-09-05 13:40:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200023
;

-- Sep 5, 2022, 1:42:58 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,AD_InfoWindow_ID) VALUES (215213,0,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',661,'CreateLinesFrom',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2022-09-05 13:42:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:42:57','YYYY-MM-DD HH24:MI:SS'),100,203638,'Y','N','D','N','N','N','Y','e13d7366-b794-436e-aa5f-2fc4e82662ce','Y',0,'N','N','N','N',200023)
;

-- Sep 5, 2022, 1:43:12 PM SGT
ALTER TABLE M_RMA ADD COLUMN CreateLinesFrom CHAR(1) DEFAULT NULL 
;

-- Sep 5, 2022, 1:51:38 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207144,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',628,215213,'Y',1,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-05 13:51:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:51:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','346714c8-9ade-43c5-88a6-a03ac0d06715','Y',170,2,2)
;

-- Sep 5, 2022, 1:51:53 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207145,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',53280,215213,'Y',1,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-05 13:51:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-05 13:51:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','664a472f-456f-4a99-a5e1-bc6ce94f9ac9','Y',170,2,2)
;

-- Sep 5, 2022, 1:53:02 PM SGT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=150, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-05 13:53:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207144
;

-- Sep 5, 2022, 1:53:13 PM SGT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=150, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-05 13:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207145
;

-- Sep 5, 2022, 1:53:27 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-05 13:53:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201657
;

-- Sep 5, 2022, 1:53:37 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-05 13:53:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201654
;

