-- IDEMPIERE-6375 -Add missing quantities to RV_Storage_per_product view
SELECT register_migration_script('202501091312_IDEMPIERE-6375.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 9, 2025, 1:12:52 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM m_product p
JOIN ( SELECT rv_storage.m_product_id, rv_storage.m_locator_id, sum(rv_storage.qtyonhand) AS sumqtyonhand, sum(rv_storage.qtyavailable) AS sumqtyavailable, sum(rv_storage.qtyordered) AS sumqtyordered, sum(rv_storage.qtyreserved) AS sumqtyreserved, rv_storage.ad_client_id, rv_storage.ad_org_id FROM rv_storage GROUP BY rv_storage.m_product_id, rv_storage.m_locator_id, rv_storage.ad_client_id, rv_storage.ad_org_id) strg ON p.m_product_id = strg.m_product_id
JOIN m_locator l ON strg.m_locator_id = l.m_locator_id',Updated=TO_TIMESTAMP('2025-01-09 13:12:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200181
;

-- Jan 9, 2025, 1:13:29 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217718,'285629d4-c7dd-4f8d-a5e6-2cf79d334ae6',TO_TIMESTAMP('2025-01-09 13:13:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-01-09 13:13:29','YYYY-MM-DD HH24:MI:SS'),100,200181,'SumQtyAvailable','strg.sumqtyavailable',180)
;

-- Jan 9, 2025, 1:13:40 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217719,'450904a6-a66e-46c0-b816-b9f2c97257a3',TO_TIMESTAMP('2025-01-09 13:13:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-01-09 13:13:39','YYYY-MM-DD HH24:MI:SS'),100,200181,'SumQtyOrdered','strg.sumqtyordered',190)
;

-- Jan 9, 2025, 1:13:50 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217720,'662d97dd-68f8-4a0d-9b8c-3060a54dcdcf',TO_TIMESTAMP('2025-01-09 13:13:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-01-09 13:13:50','YYYY-MM-DD HH24:MI:SS'),100,200181,'SumQtyReserved','strg.sumqtyreserved',200)
;

-- Jan 9, 2025, 1:14:43 PM CET
CREATE OR REPLACE VIEW RV_Storage_Per_Product(AD_Client_ID, AD_Org_ID, M_Product_ID, Value, Name, Description, UPC, SKU, C_UOM_ID, M_Product_Category_ID, Classification, Weight, Volume, VersionNo, GuaranteeDays, GuaranteeDaysMin, SumQtyOnHand, SumQtyAvailable, SumQtyOrdered, SumQtyReserved) AS SELECT strg.ad_client_id AS AD_Client_ID, strg.ad_org_id AS AD_Org_ID, p.m_product_id AS M_Product_ID, p.value AS Value, p.name AS Name, p.description AS Description, p.upc AS UPC, p.sku AS SKU, p.c_uom_id AS C_UOM_ID, p.m_product_category_id AS M_Product_Category_ID, p.classification AS Classification, p.weight AS Weight, p.volume AS Volume, p.versionno AS VersionNo, p.guaranteedays AS GuaranteeDays, p.guaranteedaysmin AS GuaranteeDaysMin, strg.sumqtyonhand AS SumQtyOnHand, strg.sumqtyavailable AS SumQtyAvailable, strg.sumqtyordered AS SumQtyOrdered, strg.sumqtyreserved AS SumQtyReserved FROM m_product p
JOIN ( SELECT rv_storage.m_product_id, rv_storage.m_locator_id, sum(rv_storage.qtyonhand) AS sumqtyonhand, sum(rv_storage.qtyavailable) AS sumqtyavailable, sum(rv_storage.qtyordered) AS sumqtyordered, sum(rv_storage.qtyreserved) AS sumqtyreserved, rv_storage.ad_client_id, rv_storage.ad_org_id FROM rv_storage GROUP BY rv_storage.m_product_id, rv_storage.m_locator_id, rv_storage.ad_client_id, rv_storage.ad_org_id) strg ON p.m_product_id = strg.m_product_id
JOIN m_locator l ON strg.m_locator_id = l.m_locator_id
;

-- Jan 9, 2025, 1:15:06 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203983,0,0,'Y',TO_TIMESTAMP('2025-01-09 13:15:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-09 13:15:06','YYYY-MM-DD HH24:MI:SS'),100,'sumqtyavailable','sumqtyavailable','sumqtyavailable','D','ffd77962-19f6-474c-afd3-96e1debe1df5')
;

-- Jan 9, 2025, 1:15:06 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217026,0.0,'sumqtyavailable',53247,'sumqtyavailable',14,'N','N','N','N','N','N',29,0,0,'Y',TO_TIMESTAMP('2025-01-09 13:15:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-09 13:15:06','YYYY-MM-DD HH24:MI:SS'),100,203983,'N','N','D','N','75d564b7-673f-4c40-9c66-06f6edbde2b7','N')
;

-- Jan 9, 2025, 1:15:07 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203984,0,0,'Y',TO_TIMESTAMP('2025-01-09 13:15:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-09 13:15:06','YYYY-MM-DD HH24:MI:SS'),100,'sumqtyordered','sumqtyordered','sumqtyordered','D','699e13b2-d9dc-4de5-bdce-13003606db49')
;

-- Jan 9, 2025, 1:15:07 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217027,0.0,'sumqtyordered',53247,'sumqtyordered',14,'N','N','N','N','N','N',29,0,0,'Y',TO_TIMESTAMP('2025-01-09 13:15:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-09 13:15:06','YYYY-MM-DD HH24:MI:SS'),100,203984,'N','N','D','N','cdaed881-1e7a-43f9-868a-d13b094d0380','N')
;

-- Jan 9, 2025, 1:15:07 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203985,0,0,'Y',TO_TIMESTAMP('2025-01-09 13:15:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-09 13:15:07','YYYY-MM-DD HH24:MI:SS'),100,'sumqtyreserved','sumqtyreserved','sumqtyreserved','D','f705bc1b-cd16-4559-9306-d4bbc2f5ee50')
;

-- Jan 9, 2025, 1:15:08 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217028,0.0,'sumqtyreserved',53247,'sumqtyreserved',14,'N','N','N','N','N','N',29,0,0,'Y',TO_TIMESTAMP('2025-01-09 13:15:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-09 13:15:07','YYYY-MM-DD HH24:MI:SS'),100,203985,'N','N','D','N','7c195147-abaf-414b-97a2-3de5828c665b','N')
;

-- Jan 9, 2025, 1:16:40 PM CET
UPDATE AD_Element SET ColumnName='SumQtyAvailable', Name='Sum Qty Available', Description='Summary of products available in all locators', PrintName='Sum Qty Available',Updated=TO_TIMESTAMP('2025-01-09 13:16:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203983
;

-- Jan 9, 2025, 1:16:40 PM CET
UPDATE AD_Column SET ColumnName='SumQtyAvailable', Name='Sum Qty Available', Description='Summary of products available in all locators', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203983
;

-- Jan 9, 2025, 1:16:40 PM CET
UPDATE AD_Process_Para SET ColumnName='SumQtyAvailable', Name='Sum Qty Available', Description='Summary of products available in all locators', Help=NULL, AD_Element_ID=203983 WHERE UPPER(ColumnName)='SUMQTYAVAILABLE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 9, 2025, 1:16:40 PM CET
UPDATE AD_Process_Para SET ColumnName='SumQtyAvailable', Name='Sum Qty Available', Description='Summary of products available in all locators', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203983 AND IsCentrallyMaintained='Y'
;

-- Jan 9, 2025, 1:16:40 PM CET
UPDATE AD_InfoColumn SET ColumnName='SumQtyAvailable', Name='Sum Qty Available', Description='Summary of products available in all locators', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203983 AND IsCentrallyMaintained='Y'
;

-- Jan 9, 2025, 1:16:40 PM CET
UPDATE AD_Field SET Name='Sum Qty Available', Description='Summary of products available in all locators', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203983) AND IsCentrallyMaintained='Y'
;

-- Jan 9, 2025, 1:16:40 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Sum Qty Available', Name='Sum Qty Available' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203983)
;

-- Jan 9, 2025, 1:17:37 PM CET
UPDATE AD_Element SET ColumnName='SumQtyOrdered', Name='Sum Qty Ordered', Description='Summary of product ordered in all locators', PrintName='Sum Qty Ordered',Updated=TO_TIMESTAMP('2025-01-09 13:17:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203984
;

-- Jan 9, 2025, 1:17:37 PM CET
UPDATE AD_Column SET ColumnName='SumQtyOrdered', Name='Sum Qty Ordered', Description='Summary of product ordered in all locators', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203984
;

-- Jan 9, 2025, 1:17:37 PM CET
UPDATE AD_Process_Para SET ColumnName='SumQtyOrdered', Name='Sum Qty Ordered', Description='Summary of product ordered in all locators', Help=NULL, AD_Element_ID=203984 WHERE UPPER(ColumnName)='SUMQTYORDERED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 9, 2025, 1:17:37 PM CET
UPDATE AD_Process_Para SET ColumnName='SumQtyOrdered', Name='Sum Qty Ordered', Description='Summary of product ordered in all locators', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203984 AND IsCentrallyMaintained='Y'
;

-- Jan 9, 2025, 1:17:37 PM CET
UPDATE AD_InfoColumn SET ColumnName='SumQtyOrdered', Name='Sum Qty Ordered', Description='Summary of product ordered in all locators', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203984 AND IsCentrallyMaintained='Y'
;

-- Jan 9, 2025, 1:17:37 PM CET
UPDATE AD_Field SET Name='Sum Qty Ordered', Description='Summary of product ordered in all locators', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203984) AND IsCentrallyMaintained='Y'
;

-- Jan 9, 2025, 1:17:37 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Sum Qty Ordered', Name='Sum Qty Ordered' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203984)
;

-- Jan 9, 2025, 1:18:15 PM CET
UPDATE AD_Element SET ColumnName='SumQtyReserved', Name='Sum Qty Reserved', Description='Summary of product reserved in all locators', PrintName='Sum Qty Reserved',Updated=TO_TIMESTAMP('2025-01-09 13:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203985
;

-- Jan 9, 2025, 1:18:15 PM CET
UPDATE AD_Column SET ColumnName='SumQtyReserved', Name='Sum Qty Reserved', Description='Summary of product reserved in all locators', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203985
;

-- Jan 9, 2025, 1:18:15 PM CET
UPDATE AD_Process_Para SET ColumnName='SumQtyReserved', Name='Sum Qty Reserved', Description='Summary of product reserved in all locators', Help=NULL, AD_Element_ID=203985 WHERE UPPER(ColumnName)='SUMQTYRESERVED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 9, 2025, 1:18:15 PM CET
UPDATE AD_Process_Para SET ColumnName='SumQtyReserved', Name='Sum Qty Reserved', Description='Summary of product reserved in all locators', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203985 AND IsCentrallyMaintained='Y'
;

-- Jan 9, 2025, 1:18:15 PM CET
UPDATE AD_InfoColumn SET ColumnName='SumQtyReserved', Name='Sum Qty Reserved', Description='Summary of product reserved in all locators', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203985 AND IsCentrallyMaintained='Y'
;

-- Jan 9, 2025, 1:18:15 PM CET
UPDATE AD_Field SET Name='Sum Qty Reserved', Description='Summary of product reserved in all locators', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203985) AND IsCentrallyMaintained='Y'
;

-- Jan 9, 2025, 1:18:15 PM CET
UPDATE AD_PrintFormatItem SET PrintName='Sum Qty Reserved', Name='Sum Qty Reserved' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203985)
;

