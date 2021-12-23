-- BOM Indexes

-- Dec 22, 2021, 9:24:14 AM ART
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201097,'08a853c4-3437-419c-95a9-7ca4ea452e09',TO_TIMESTAMP('2021-12-22 09:24:13','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','pp_product_bom_product_id_idx',TO_TIMESTAMP('2021-12-22 09:24:13','YYYY-MM-DD HH24:MI:SS'),0,53018,'N','N','N','N','N')
;

-- Dec 22, 2021, 9:24:42 AM ART
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201445,'5351abd4-97a8-433e-9e6b-94f4e51d2732',TO_TIMESTAMP('2021-12-22 09:24:42','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_TIMESTAMP('2021-12-22 09:24:42','YYYY-MM-DD HH24:MI:SS'),0,53333,201097,10)
;

-- Dec 22, 2021, 9:25:23 AM ART
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201098,'899686b0-bf6a-45f5-9df1-f43d216f053f',TO_TIMESTAMP('2021-12-22 09:25:22','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','pp_product_bomline_pp_product_bom_id_idx',TO_TIMESTAMP('2021-12-22 09:25:22','YYYY-MM-DD HH24:MI:SS'),0,53018,'N','N','N','N','N')
;

-- Dec 22, 2021, 9:25:59 AM ART
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201446,'e7f86caf-a5cb-4f78-8168-938640ff59d2',TO_TIMESTAMP('2021-12-22 09:25:58','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_TIMESTAMP('2021-12-22 09:25:58','YYYY-MM-DD HH24:MI:SS'),0,53334,201098,10)
;

-- Rewrite Virtual Columns

-- Dec 22, 2021, 9:32:44 AM ART
UPDATE AD_Column SET ColumnSQL='@SQLFIND=(SELECT ProductType FROM M_Product WHERE M_Product.M_Product_ID = M_ProductionLine.M_Product_ID)',Updated=TO_TIMESTAMP('2021-12-22 09:32:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=61947
;

-- Dec 22, 2021, 9:33:28 AM ART
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, ColumnSQL='(SELECT ProductType FROM M_Product WHERE M_Product.M_Product_ID = M_ProductionLine.M_Product_ID)',Updated=TO_TIMESTAMP('2021-12-22 09:33:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=61972
;

-- Dec 22, 2021, 9:33:52 AM ART
UPDATE AD_Column SET ColumnSQL='@SQLFIND=(SELECT bomQtyOnHand(M_ProductionLine.M_Product_ID,l.M_Warehouse_ID,0) - bomQtyReserved(M_ProductionLine.M_Product_ID,l.M_Warehouse_ID,0) - prodQtyReserved(M_ProductionLine.M_Product_ID,l.M_Warehouse_ID) FROM M_Locator l WHERE l.M_Locator_ID=M_ProductionLine.M_Locator_ID) ',Updated=TO_TIMESTAMP('2021-12-22 09:33:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=61946
;

-- Dec 22, 2021, 9:34:19 AM ART
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, ColumnSQL='(SELECT bomQtyOnHand(M_ProductionLine.M_Product_ID,l.M_Warehouse_ID,0) - bomQtyReserved(M_ProductionLine.M_Product_ID,l.M_Warehouse_ID,0) - prodQtyReserved(M_ProductionLine.M_Product_ID,l.M_Warehouse_ID) FROM M_Locator l WHERE l.M_Locator_ID=M_ProductionLine.M_Locator_ID) ',Updated=TO_TIMESTAMP('2021-12-22 09:34:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=61971
;

SELECT register_migration_script('202112210930_IDEMPIERE-5110.sql') FROM dual
;
