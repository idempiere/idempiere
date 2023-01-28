-- IDEMPIERE-5504 Very slow performance retrieving Product Costs > Cost Movement records
SELECT register_migration_script('202211301216_IDEMPIERE-5504.sql') FROM dual;

-- Nov 30, 2022, 12:16:02 PM SGT
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2022-11-30 12:16:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200063
;

-- Nov 30, 2022, 12:16:08 PM SGT
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2022-11-30 12:16:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200061
;

-- Nov 30, 2022, 12:16:15 PM SGT
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2022-11-30 12:16:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200067
;

-- Nov 30, 2022, 12:16:21 PM SGT
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2022-11-30 12:16:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200068
;

-- Nov 30, 2022, 12:16:27 PM SGT
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2022-11-30 12:16:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200044
;

-- Nov 30, 2022, 12:16:35 PM SGT
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2022-11-30 12:16:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200062
;

-- Nov 30, 2022, 12:16:41 PM SGT
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2022-11-30 12:16:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200065
;

-- Nov 30, 2022, 12:16:47 PM SGT
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2022-11-30 12:16:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200064
;

-- Nov 30, 2022, 12:16:53 PM SGT
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2022-11-30 12:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200066
;

-- Nov 30, 2022, 12:20:05 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215688,0,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200001,231,'M_Product_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-11-30 12:20:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-30 12:20:03','YYYY-MM-DD HH24:MI:SS'),100,454,'Y','N','D','N','N','N','Y','b3f85769-4963-469e-8ed7-2859338cf2f0','Y',0,'N','N','N','N')
;

-- Nov 30, 2022, 12:20:26 PM SGT
UPDATE AD_Column SET FKConstraintName='MProduct_MCostHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-11-30 12:20:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215688
;

-- Nov 30, 2022, 12:20:26 PM SGT
ALTER TABLE M_CostHistory ADD COLUMN M_Product_ID NUMERIC(10) DEFAULT NULL 
;

-- Nov 30, 2022, 12:20:27 PM SGT
ALTER TABLE M_CostHistory ADD CONSTRAINT MProduct_MCostHistory FOREIGN KEY (M_Product_ID) REFERENCES m_product(m_product_id) DEFERRABLE INITIALLY DEFERRED
;

UPDATE M_CostHistory SET M_Product_ID = (SELECT M_Product_ID FROM M_CostDetail WHERE M_CostDetail.M_CostDetail_ID=M_CostHistory.M_CostDetail_ID) WHERE M_Product_ID IS NULL
;

-- Nov 30, 2022, 12:24:12 PM SGT
UPDATE AD_ViewColumn SET ColumnSQL='a.m_product_id',Updated=TO_TIMESTAMP('2022-11-30 12:24:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210436
;

-- Nov 30, 2022, 12:24:31 PM SGT
CREATE OR REPLACE VIEW M_CostMovement_v(AD_Client_ID, AD_Org_ID, C_AcctSchema_ID, M_CostHistory_ID, M_CostType_ID, M_CostElement_ID, M_AttributeSetInstance_ID, M_Product_ID, OldQty, NewQty, OldCostPrice, NewCostPrice, OldCQty, NewCQty, OldCAmt, NewCAmt, Qty, Amt, DeltaQty, DeltaAmt, C_OrderLine_ID, M_InOutLine_ID, C_InvoiceLine_ID, M_MovementLine_ID, M_InventoryLine_ID, M_ProductionLine_ID, C_ProjectIssue_ID, M_MatchInv_ID, M_CostDetail_ID, Description, Created, CreatedBy, Updated, UpdatedBy, IsActive) AS SELECT a.ad_client_id AS AD_Client_ID, a.ad_org_id AS AD_Org_ID, b.c_acctschema_id AS C_AcctSchema_ID, a.m_costhistory_id AS M_CostHistory_ID, a.m_costtype_id AS M_CostType_ID, a.m_costelement_id AS M_CostElement_ID, a.m_attributesetinstance_id AS M_AttributeSetInstance_ID, a.m_product_id AS M_Product_ID, a.oldqty AS OldQty, a.newqty AS NewQty, a.oldcostprice AS OldCostPrice, a.newcostprice AS NewCostPrice, a.oldcqty AS OldCQty, a.newcqty AS NewCQty, a.oldcamt AS OldCAmt, a.newcamt AS NewCAmt, b.qty AS Qty, b.amt AS Amt, b.deltaqty AS DeltaQty, b.deltaamt AS DeltaAmt, b.c_orderline_id AS C_OrderLine_ID, b.m_inoutline_id AS M_InOutLine_ID, b.c_invoiceline_id AS C_InvoiceLine_ID, b.m_movementline_id AS M_MovementLine_ID, b.m_inventoryline_id AS M_InventoryLine_ID, b.m_productionline_id AS M_ProductionLine_ID, b.c_projectissue_id AS C_ProjectIssue_ID, b.m_matchinv_id AS M_MatchInv_ID, a.m_costdetail_id AS M_CostDetail_ID, b.description AS Description, a.created AS Created, a.createdby AS CreatedBy, a.updated AS Updated, a.updatedby AS UpdatedBy, a.isactive AS IsActive FROM m_costhistory a JOIN m_costdetail b ON a.m_costdetail_id = b.m_costdetail_id ORDER BY a.m_costhistory_id
;

-- Nov 30, 2022, 12:29:39 PM SGT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201137,'badb9971-cc84-4bca-859b-36df31aff5b1',TO_TIMESTAMP('2022-11-30 12:29:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','m_costhistory_costmovement_idx',TO_TIMESTAMP('2022-11-30 12:29:38','YYYY-MM-DD HH24:MI:SS'),100,200001,'N','N','N','N','N')
;

-- Nov 30, 2022, 12:29:52 PM SGT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201523,'c03b207b-4719-40d7-971c-15bb12a14d95',TO_TIMESTAMP('2022-11-30 12:29:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-11-30 12:29:51','YYYY-MM-DD HH24:MI:SS'),100,200020,201137,10)
;

-- Nov 30, 2022, 12:30:05 PM SGT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201524,'2e102999-e2dc-40db-be53-38a6c9cc613a',TO_TIMESTAMP('2022-11-30 12:30:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-11-30 12:30:04','YYYY-MM-DD HH24:MI:SS'),100,215688,201137,20)
;

-- Nov 30, 2022, 12:30:14 PM SGT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201525,'cb578fdb-3972-49f7-9ca7-f9acbc16beec',TO_TIMESTAMP('2022-11-30 12:30:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-11-30 12:30:13','YYYY-MM-DD HH24:MI:SS'),100,200031,201137,30)
;

-- Nov 30, 2022, 12:30:22 PM SGT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201526,'0485925a-b8f6-43fa-be4c-dd531c3209d8',TO_TIMESTAMP('2022-11-30 12:30:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-11-30 12:30:22','YYYY-MM-DD HH24:MI:SS'),100,200027,201137,40)
;

-- Nov 30, 2022, 12:30:33 PM SGT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201527,'a1ee59bd-fbb8-4bfa-9e03-6f6312597011',TO_TIMESTAMP('2022-11-30 12:30:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-11-30 12:30:32','YYYY-MM-DD HH24:MI:SS'),100,200025,201137,50)
;

-- Nov 30, 2022, 12:30:40 PM SGT
CREATE INDEX m_costhistory_costmovement_idx ON M_CostHistory (AD_Client_ID,M_Product_ID,M_CostType_ID,M_CostElement_ID,M_AttributeSetInstance_ID)
;

