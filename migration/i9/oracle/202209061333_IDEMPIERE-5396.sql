-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202209061333_IDEMPIERE-5396.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 6, 2022, 1:33:59 PM SGT
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200359,'C_Invoice_CreateFrom_v','C_Invoice_CreateFrom_v',0,'3',0,0,'Y',TO_TIMESTAMP('2022-09-06 13:33:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:33:57','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','D','N','N','L','N','Y','2d40aae1-731e-4a48-b601-49756f7efa67','N','N','N','N')
;

-- Sep 6, 2022, 1:34:26 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,OtherClause,SeqNo,FromClause,IsUnionAll) VALUES (0,0,200227,'efd20c84-5692-40ac-bc02-309cbb017f3e',TO_TIMESTAMP('2022-09-06 13:34:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Order Lines',TO_TIMESTAMP('2022-09-06 13:34:25','YYYY-MM-DD HH24:MI:SS'),100,200359,'GROUP BY l.QtyOrdered,CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END,
l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, l.Line, l.C_OrderLine_ID, o.IsSOTrx',10,'FROM C_OrderLine l
     JOIN C_Order o ON o.C_Order_ID = l.C_Order_ID 
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND l.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN M_MatchPO m ON l.c_orderline_id = m.C_OrderLine_ID AND m.C_InvoiceLine_ID IS NOT NULL AND COALESCE(m.Reversal_ID,0)=0
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID','N')
;

-- Sep 6, 2022, 1:34:27 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217538,'0628186a-62ba-4dcc-8df0-337606a14cd9',TO_TIMESTAMP('2022-09-06 13:34:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:26','YYYY-MM-DD HH24:MI:SS'),100,200227,'CreditMemoQty','SUM(COALESCE(m.Qty,0))')
;

-- Sep 6, 2022, 1:34:28 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217539,'f0212dfa-9580-4f8f-ae42-1eb5934d831b',TO_TIMESTAMP('2022-09-06 13:34:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:27','YYYY-MM-DD HH24:MI:SS'),100,200227,'Qty','l.QtyOrdered-SUM(COALESCE(m.Qty,0))')
;

-- Sep 6, 2022, 1:34:29 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217540,'3b68ee34-f15a-435b-8f81-5e9d4e771de5',TO_TIMESTAMP('2022-09-06 13:34:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:28','YYYY-MM-DD HH24:MI:SS'),100,200227,'Multiplier','CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END')
;

-- Sep 6, 2022, 1:34:30 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217541,'e7cb9b61-bc84-40c0-9f0a-7ebd0a590172',TO_TIMESTAMP('2022-09-06 13:34:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:29','YYYY-MM-DD HH24:MI:SS'),100,200227,'C_UOM_ID','l.C_UOM_ID')
;

-- Sep 6, 2022, 1:34:31 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217542,'3a63e960-c528-4c96-b857-8f51b7a0f7cc',TO_TIMESTAMP('2022-09-06 13:34:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:30','YYYY-MM-DD HH24:MI:SS'),100,200227,'M_Product_ID','COALESCE(l.M_Product_ID, 0)')
;

-- Sep 6, 2022, 1:34:32 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217543,'fda7735a-0cd0-4e02-9c39-55c6d7cebc87',TO_TIMESTAMP('2022-09-06 13:34:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:31','YYYY-MM-DD HH24:MI:SS'),100,200227,'C_Charge_ID','COALESCE(l.C_Charge_ID, 0)')
;

-- Sep 6, 2022, 1:34:32 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217544,'0b26484a-d3fb-4265-9ddf-f96642bd4ddc',TO_TIMESTAMP('2022-09-06 13:34:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:32','YYYY-MM-DD HH24:MI:SS'),100,200227,'VendorProductNo','po.VendorProductNo')
;

-- Sep 6, 2022, 1:34:33 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217545,'e5c88c83-19cb-4052-8110-8895a8fbdb07',TO_TIMESTAMP('2022-09-06 13:34:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:32','YYYY-MM-DD HH24:MI:SS'),100,200227,'Line','l.Line')
;

-- Sep 6, 2022, 1:34:34 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217546,'6a29a1ed-3740-4054-898d-bb1d87dafc46',TO_TIMESTAMP('2022-09-06 13:34:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:33','YYYY-MM-DD HH24:MI:SS'),100,200227,'C_OrderLine_ID','l.C_OrderLine_ID')
;

-- Sep 6, 2022, 1:34:35 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217547,'82379e52-c090-4614-8f03-53aca0cfdd57',TO_TIMESTAMP('2022-09-06 13:34:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:34','YYYY-MM-DD HH24:MI:SS'),100,200227,'M_InOutLine_ID','0')
;

-- Sep 6, 2022, 1:34:36 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217548,'1c95d3cd-caab-4bba-b218-0d80ad680ff6',TO_TIMESTAMP('2022-09-06 13:34:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:35','YYYY-MM-DD HH24:MI:SS'),100,200227,'M_RMALine_ID','0')
;

-- Sep 6, 2022, 1:34:37 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217549,'97a48298-8a18-4872-bd28-2d98c68df5ca',TO_TIMESTAMP('2022-09-06 13:34:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:36','YYYY-MM-DD HH24:MI:SS'),100,200227,'C_BPartner_ID','l.C_BPartner_ID')
;

-- Sep 6, 2022, 1:34:37 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217550,'84362811-b390-49b8-9714-e31996b7f657',TO_TIMESTAMP('2022-09-06 13:34:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:37','YYYY-MM-DD HH24:MI:SS'),100,200227,'C_Order_ID','l.C_Order_ID')
;

-- Sep 6, 2022, 1:34:38 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217551,'e47af095-e630-4474-bdfa-4b6050f5a337',TO_TIMESTAMP('2022-09-06 13:34:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:37','YYYY-MM-DD HH24:MI:SS'),100,200227,'M_InOut_ID','0')
;

-- Sep 6, 2022, 1:34:39 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217552,'3f4e1712-f722-4b24-bf59-9840574a5243',TO_TIMESTAMP('2022-09-06 13:34:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:38','YYYY-MM-DD HH24:MI:SS'),100,200227,'M_RMA_ID','0')
;

-- Sep 6, 2022, 1:34:40 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217553,'d762f642-2513-481d-9f60-515c4ddd76b6',TO_TIMESTAMP('2022-09-06 13:34:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:39','YYYY-MM-DD HH24:MI:SS'),100,200227,'C_Invoice_CreateFrom_v2_ID','l.C_OrderLine_ID')
;

-- Sep 6, 2022, 1:34:41 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217554,'5d1f9b2d-bc15-473a-98ea-9af397153473',TO_TIMESTAMP('2022-09-06 13:34:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:40','YYYY-MM-DD HH24:MI:SS'),100,200227,'AD_Client_ID','l.AD_Client_ID')
;

-- Sep 6, 2022, 1:34:42 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217555,'4c43aa4d-088e-4665-b322-144099e334f2',TO_TIMESTAMP('2022-09-06 13:34:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:41','YYYY-MM-DD HH24:MI:SS'),100,200227,'AD_Org_ID','l.AD_Org_ID')
;

-- Sep 6, 2022, 1:34:42 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217556,'60123f38-c0dc-4200-ac2a-8c22784dea8d',TO_TIMESTAMP('2022-09-06 13:34:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:42','YYYY-MM-DD HH24:MI:SS'),100,200227,'IsActive','l.IsActive')
;

-- Sep 6, 2022, 1:34:43 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217557,'9f9b6f43-c91a-4cf0-9464-4f78b11d6121',TO_TIMESTAMP('2022-09-06 13:34:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:42','YYYY-MM-DD HH24:MI:SS'),100,200227,'IsSOTrx','o.IsSOTrx')
;

-- Sep 6, 2022, 1:34:44 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217558,'fb80732e-7f30-44e8-8e78-8da515b6c09d',TO_TIMESTAMP('2022-09-06 13:34:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:43','YYYY-MM-DD HH24:MI:SS'),100,200227,'AD_Table_ID','260')
;

-- Sep 6, 2022, 1:34:45 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,OtherClause,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200228,'437603a6-4cff-4a01-ab33-4078341f12fe',TO_TIMESTAMP('2022-09-06 13:34:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Receipt Lines',TO_TIMESTAMP('2022-09-06 13:34:44','YYYY-MM-DD HH24:MI:SS'),100,200359,'GROUP BY io.MovementType, l.MovementQty, l.QtyEntered/l.MovementQty, l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, 
	 l.Line, l.C_OrderLine_ID, l.M_InOutLine_ID, io.C_BPartner_ID, l.M_InOut_ID, io.IsSOTrx
	 HAVING l.MovementQty-SUM(COALESCE(mi.Qty, 0)) <> 0',20,'WHERE l.MovementQty <> 0 AND io.IsSOTrx=''N''','FROM M_InOutLine l
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID
     JOIN M_InOut io ON l.m_inout_id= io.M_InOut_ID
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND io.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN M_MatchInv mi ON l.M_InOutLine_ID = mi.M_InOutLine_ID','N')
;

-- Sep 6, 2022, 1:34:46 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217559,'ed779d6c-e039-4335-81c0-e2a262c249e8',TO_TIMESTAMP('2022-09-06 13:34:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:45','YYYY-MM-DD HH24:MI:SS'),100,200228,'CreditMemoQty','CASE WHEN io.IsSOTrx=''N'' THEN (l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = ''V-'' THEN -1 ELSE 1 END) ELSE (l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = ''V-'' THEN -1 ELSE 1 END) END')
;

-- Sep 6, 2022, 1:34:47 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217560,'f6990d81-20c7-421d-882f-8b1951ea6723',TO_TIMESTAMP('2022-09-06 13:34:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:46','YYYY-MM-DD HH24:MI:SS'),100,200228,'Qty','l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = ''V-'' THEN -1 ELSE 1 END')
;

-- Sep 6, 2022, 1:34:47 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217561,'7124a362-d8f1-4a2f-9867-261dc91180a9',TO_TIMESTAMP('2022-09-06 13:34:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:47','YYYY-MM-DD HH24:MI:SS'),100,200228,'Multiplier','l.QtyEntered/l.MovementQty')
;

-- Sep 6, 2022, 1:34:48 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217562,'5c0745d0-35ac-496e-b989-57b085adae8e',TO_TIMESTAMP('2022-09-06 13:34:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:47','YYYY-MM-DD HH24:MI:SS'),100,200228,'C_UOM_ID','l.C_UOM_ID')
;

-- Sep 6, 2022, 1:34:49 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217563,'304f1308-c8e2-4ef8-bc66-f97f5c43b7d1',TO_TIMESTAMP('2022-09-06 13:34:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:48','YYYY-MM-DD HH24:MI:SS'),100,200228,'M_Product_ID','l.M_Product_ID')
;

-- Sep 6, 2022, 1:34:50 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217564,'61f403f3-584a-4c75-9260-8a4ae69032f3',TO_TIMESTAMP('2022-09-06 13:34:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:49','YYYY-MM-DD HH24:MI:SS'),100,200228,'C_Charge_ID','l.C_Charge_ID')
;

-- Sep 6, 2022, 1:34:51 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217565,'68177ad5-0bdc-4e10-a6b8-052cc9a30a52',TO_TIMESTAMP('2022-09-06 13:34:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:50','YYYY-MM-DD HH24:MI:SS'),100,200228,'VendorProductNo','po.VendorProductNo')
;

-- Sep 6, 2022, 1:34:52 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217566,'b768d7dc-96cc-4ada-8ccb-adff48d1a897',TO_TIMESTAMP('2022-09-06 13:34:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:51','YYYY-MM-DD HH24:MI:SS'),100,200228,'Line','l.Line')
;

-- Sep 6, 2022, 1:34:52 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217567,'bbfdcf59-1c16-426c-9391-0fd66422cf37',TO_TIMESTAMP('2022-09-06 13:34:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:52','YYYY-MM-DD HH24:MI:SS'),100,200228,'C_OrderLine_ID','l.C_OrderLine_ID')
;

-- Sep 6, 2022, 1:34:53 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217568,'3932e8c9-ce8e-4027-87ff-38ac0bcc0c2f',TO_TIMESTAMP('2022-09-06 13:34:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:53','YYYY-MM-DD HH24:MI:SS'),100,200228,'M_InOutLine_ID','l.M_InOutLine_ID')
;

-- Sep 6, 2022, 1:34:54 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217569,'9738f8e1-de2e-45cf-9372-ca199ec58d16',TO_TIMESTAMP('2022-09-06 13:34:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:53','YYYY-MM-DD HH24:MI:SS'),100,200228,'M_RMALine_ID','0')
;

-- Sep 6, 2022, 1:34:55 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217570,'cde2788b-6567-441d-97b6-7dc45638976a',TO_TIMESTAMP('2022-09-06 13:34:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:54','YYYY-MM-DD HH24:MI:SS'),100,200228,'C_BPartner_ID','io.C_BPartner_ID')
;

-- Sep 6, 2022, 1:34:56 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217571,'88cabd54-0657-4a9d-a824-5c889e592aa0',TO_TIMESTAMP('2022-09-06 13:34:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:55','YYYY-MM-DD HH24:MI:SS'),100,200228,'C_Order_ID','0')
;

-- Sep 6, 2022, 1:34:57 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217572,'59649281-a67a-44ad-8280-6ff3db06b629',TO_TIMESTAMP('2022-09-06 13:34:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:56','YYYY-MM-DD HH24:MI:SS'),100,200228,'M_InOut_ID','l.M_InOut_ID')
;

-- Sep 6, 2022, 1:34:57 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217573,'725766dc-904a-4b8b-b568-7c54b27cc7fc',TO_TIMESTAMP('2022-09-06 13:34:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:57','YYYY-MM-DD HH24:MI:SS'),100,200228,'M_RMA_ID','0')
;

-- Sep 6, 2022, 1:34:58 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217574,'a74ad06b-9175-4fe7-a581-99daa6af71be',TO_TIMESTAMP('2022-09-06 13:34:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:57','YYYY-MM-DD HH24:MI:SS'),100,200228,'C_Invoice_CreateFrom_v2_ID','l.M_InOutLine_ID')
;

-- Sep 6, 2022, 1:34:59 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217575,'0000ca69-9d2a-4ca4-b373-7713a770226e',TO_TIMESTAMP('2022-09-06 13:34:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:58','YYYY-MM-DD HH24:MI:SS'),100,200228,'AD_Client_ID','l.AD_Client_ID')
;

-- Sep 6, 2022, 1:35:00 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217576,'9465da4d-250b-4694-b76b-08b67bb1b3ff',TO_TIMESTAMP('2022-09-06 13:34:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:34:59','YYYY-MM-DD HH24:MI:SS'),100,200228,'AD_Org_ID','l.AD_Org_ID')
;

-- Sep 6, 2022, 1:35:01 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217577,'f19f33f4-9d9b-4226-b228-b3a6ff223f79',TO_TIMESTAMP('2022-09-06 13:35:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:00','YYYY-MM-DD HH24:MI:SS'),100,200228,'IsActive','l.IsActive')
;

-- Sep 6, 2022, 1:35:02 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217578,'d87d02d9-6699-429a-8f93-0c0dacd0e726',TO_TIMESTAMP('2022-09-06 13:35:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:01','YYYY-MM-DD HH24:MI:SS'),100,200228,'IsSOTrx','io.IsSOTrx')
;

-- Sep 6, 2022, 1:35:03 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217579,'fc4ed31e-53af-48fe-80ad-e09c43d22a85',TO_TIMESTAMP('2022-09-06 13:35:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:02','YYYY-MM-DD HH24:MI:SS'),100,200228,'AD_Table_ID','320')
;

-- Sep 6, 2022, 1:35:04 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,OtherClause,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200229,'9e7e1239-0ad3-4a1d-bb15-67ec1a29c801',TO_TIMESTAMP('2022-09-06 13:35:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Shipment Lines',TO_TIMESTAMP('2022-09-06 13:35:03','YYYY-MM-DD HH24:MI:SS'),100,200359,'GROUP BY io.MovementType, l.MovementQty, l.QtyEntered/l.MovementQty, l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, 
	 l.Line, l.C_OrderLine_ID, l.M_InOutLine_ID, io.C_BPartner_ID, l.M_InOut_ID, io.IsSOTrx
	 HAVING l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) <> 0',25,'WHERE l.MovementQty <> 0 AND io.IsSOTrx=''Y''','FROM M_InOutLine l
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID
     JOIN M_InOut io ON l.m_inout_id= io.M_InOut_ID
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND io.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN C_InvoiceLine il ON l.M_InOutLine_ID = il.M_InOutLine_ID ','N')
;

-- Sep 6, 2022, 1:35:04 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217580,'bfcdbf9a-e53c-4eed-858b-25f5edd976a5',TO_TIMESTAMP('2022-09-06 13:35:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:04','YYYY-MM-DD HH24:MI:SS'),100,200229,'Qty','l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0))')
;

-- Sep 6, 2022, 1:35:05 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217581,'2c826d75-17f8-49ac-883a-0b5a37cfb80c',TO_TIMESTAMP('2022-09-06 13:35:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:04','YYYY-MM-DD HH24:MI:SS'),100,200229,'Multiplier','l.QtyEntered/l.MovementQty')
;

-- Sep 6, 2022, 1:35:06 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217582,'68841bbb-82bb-4c26-bb74-c61a838f5a30',TO_TIMESTAMP('2022-09-06 13:35:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:05','YYYY-MM-DD HH24:MI:SS'),100,200229,'C_UOM_ID','l.C_UOM_ID')
;

-- Sep 6, 2022, 1:35:07 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217583,'1b3d2c10-5338-44bd-8dd9-1eba31933968',TO_TIMESTAMP('2022-09-06 13:35:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:06','YYYY-MM-DD HH24:MI:SS'),100,200229,'M_Product_ID','l.M_Product_ID')
;

-- Sep 6, 2022, 1:35:08 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217584,'7c832834-c313-4c4c-9571-9685ab67d57f',TO_TIMESTAMP('2022-09-06 13:35:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:07','YYYY-MM-DD HH24:MI:SS'),100,200229,'C_Charge_ID','l.C_Charge_ID')
;

-- Sep 6, 2022, 1:35:09 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217585,'d1f8053d-995d-4c1f-9f0d-280bffe87430',TO_TIMESTAMP('2022-09-06 13:35:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:08','YYYY-MM-DD HH24:MI:SS'),100,200229,'VendorProductNo','po.VendorProductNo')
;

-- Sep 6, 2022, 1:35:09 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217586,'8a74bae2-b2e2-4c6d-a297-12a64510b8fe',TO_TIMESTAMP('2022-09-06 13:35:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:09','YYYY-MM-DD HH24:MI:SS'),100,200229,'Line','l.Line')
;

-- Sep 6, 2022, 1:35:10 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217587,'0a13ebe3-8b90-4589-a0fa-48a8f18db455',TO_TIMESTAMP('2022-09-06 13:35:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:09','YYYY-MM-DD HH24:MI:SS'),100,200229,'C_OrderLine_ID','l.C_OrderLine_ID')
;

-- Sep 6, 2022, 1:35:11 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217588,'95ea116c-b77d-44e9-879e-2a3ffa9d81be',TO_TIMESTAMP('2022-09-06 13:35:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:10','YYYY-MM-DD HH24:MI:SS'),100,200229,'M_InOutLine_ID','l.M_InOutLine_ID')
;

-- Sep 6, 2022, 1:35:12 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217589,'0dd07503-6afb-400d-b4eb-23106d55beb2',TO_TIMESTAMP('2022-09-06 13:35:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:11','YYYY-MM-DD HH24:MI:SS'),100,200229,'M_RMALine_ID','0')
;

-- Sep 6, 2022, 1:35:13 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217590,'909820bb-3b23-4316-b9e0-6e9f249309e9',TO_TIMESTAMP('2022-09-06 13:35:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:12','YYYY-MM-DD HH24:MI:SS'),100,200229,'C_BPartner_ID','io.C_BPartner_ID')
;

-- Sep 6, 2022, 1:35:14 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217591,'d5da4572-15aa-49c0-90d6-77dbabc5caa5',TO_TIMESTAMP('2022-09-06 13:35:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:13','YYYY-MM-DD HH24:MI:SS'),100,200229,'C_Order_ID','0')
;

-- Sep 6, 2022, 1:35:14 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217592,'802e3a45-bd84-48e3-bc9e-fbc88a642b90',TO_TIMESTAMP('2022-09-06 13:35:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:14','YYYY-MM-DD HH24:MI:SS'),100,200229,'M_InOut_ID','l.M_InOut_ID')
;

-- Sep 6, 2022, 1:35:15 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217593,'c3409767-3b58-42a1-adc9-d0afe9ba1d0e',TO_TIMESTAMP('2022-09-06 13:35:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:14','YYYY-MM-DD HH24:MI:SS'),100,200229,'M_RMA_ID','0')
;

-- Sep 6, 2022, 1:35:16 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217594,'34446940-7229-4d50-943f-40bae779eaa9',TO_TIMESTAMP('2022-09-06 13:35:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:15','YYYY-MM-DD HH24:MI:SS'),100,200229,'C_Invoice_CreateFrom_v2_ID','l.M_InOutLine_ID')
;

-- Sep 6, 2022, 1:35:17 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217595,'307892ec-d117-455b-a8f2-bda81b5be159',TO_TIMESTAMP('2022-09-06 13:35:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:16','YYYY-MM-DD HH24:MI:SS'),100,200229,'AD_Client_ID','l.AD_Client_ID')
;

-- Sep 6, 2022, 1:35:18 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217596,'b2066b98-f0e0-435f-bd75-1c28a6762035',TO_TIMESTAMP('2022-09-06 13:35:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:17','YYYY-MM-DD HH24:MI:SS'),100,200229,'AD_Org_ID','l.AD_Org_ID')
;

-- Sep 6, 2022, 1:35:19 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217597,'dbba6931-0974-4c75-977c-63c968f2fbe2',TO_TIMESTAMP('2022-09-06 13:35:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:18','YYYY-MM-DD HH24:MI:SS'),100,200229,'IsActive','l.IsActive')
;

-- Sep 6, 2022, 1:35:19 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217598,'3aa53973-3787-4a82-a3ed-c0fce94174a5',TO_TIMESTAMP('2022-09-06 13:35:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:19','YYYY-MM-DD HH24:MI:SS'),100,200229,'IsSOTrx','io.IsSOTrx')
;

-- Sep 6, 2022, 1:35:20 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217599,'ed0dbd51-df46-403f-a474-9f1d2c20bd40',TO_TIMESTAMP('2022-09-06 13:35:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:19','YYYY-MM-DD HH24:MI:SS'),100,200229,'AD_Table_ID','320')
;

-- Sep 6, 2022, 1:35:21 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217600,'baa32cee-2568-4c35-adf9-80ef60990332',TO_TIMESTAMP('2022-09-06 13:35:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:20','YYYY-MM-DD HH24:MI:SS'),100,200229,'CreditMemoQty','l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0))')
;

-- Sep 6, 2022, 1:35:22 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200230,'74417df3-e0f0-4850-adb9-0a88987f1ed8',TO_TIMESTAMP('2022-09-06 13:35:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','RMA Lines with Shipment/Receipt Line',TO_TIMESTAMP('2022-09-06 13:35:21','YYYY-MM-DD HH24:MI:SS'),100,200359,30,'WHERE rl.m_inoutline_id IS NOT NULL','FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_inoutline iol ON rl.m_inoutline_id = iol.m_inoutline_id
     LEFT JOIN m_product p ON p.m_product_id = iol.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = COALESCE(p.c_uom_id, iol.c_uom_id)
     LEFT JOIN c_charge c ON c.c_charge_id = iol.c_charge_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id','N')
;

-- Sep 6, 2022, 1:35:23 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217601,'9d0dcf06-ba44-448a-86c0-2e77efe5e569',TO_TIMESTAMP('2022-09-06 13:35:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:22','YYYY-MM-DD HH24:MI:SS'),100,200230,'CreditMemoQty','rl.Qty - COALESCE(rl.QtyInvoiced, 0)')
;

-- Sep 6, 2022, 1:35:24 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217602,'b86253fb-ec53-41fb-beb5-c29906e29105',TO_TIMESTAMP('2022-09-06 13:35:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:23','YYYY-MM-DD HH24:MI:SS'),100,200230,'Qty','rl.Qty - COALESCE(rl.QtyInvoiced, 0)')
;

-- Sep 6, 2022, 1:35:25 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217603,'b4efaab2-7256-4519-94eb-3aa96ce95297',TO_TIMESTAMP('2022-09-06 13:35:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:24','YYYY-MM-DD HH24:MI:SS'),100,200230,'Multiplier','1')
;

-- Sep 6, 2022, 1:35:25 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217604,'81fd0017-5cdf-4466-a641-afdcf8664676',TO_TIMESTAMP('2022-09-06 13:35:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:25','YYYY-MM-DD HH24:MI:SS'),100,200230,'C_UOM_ID','uom.C_UOM_ID')
;

-- Sep 6, 2022, 1:35:26 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217605,'cbacfc32-f834-4d68-ad6a-f5551b482013',TO_TIMESTAMP('2022-09-06 13:35:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:25','YYYY-MM-DD HH24:MI:SS'),100,200230,'M_Product_ID','p.M_Product_ID')
;

-- Sep 6, 2022, 1:35:27 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217606,'61853738-5860-4025-9d13-7f4fd496e5a7',TO_TIMESTAMP('2022-09-06 13:35:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:26','YYYY-MM-DD HH24:MI:SS'),100,200230,'C_Charge_ID','c.C_Charge_ID')
;

-- Sep 6, 2022, 1:35:28 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217607,'65de3657-d2b2-4595-9506-11f5158d21c8',TO_TIMESTAMP('2022-09-06 13:35:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:27','YYYY-MM-DD HH24:MI:SS'),100,200230,'VendorProductNo','po.VendorProductNo')
;

-- Sep 6, 2022, 1:35:29 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217608,'eadfb620-b721-4fd9-b548-e3269450e272',TO_TIMESTAMP('2022-09-06 13:35:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:28','YYYY-MM-DD HH24:MI:SS'),100,200230,'Line','rl.Line')
;

-- Sep 6, 2022, 1:35:30 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217609,'41caef9b-91ba-4566-8555-fce443e8e4da',TO_TIMESTAMP('2022-09-06 13:35:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:29','YYYY-MM-DD HH24:MI:SS'),100,200230,'C_OrderLine_ID','0')
;

-- Sep 6, 2022, 1:35:30 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217610,'0eb72532-af27-4127-a272-b9c6ffc44890',TO_TIMESTAMP('2022-09-06 13:35:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:30','YYYY-MM-DD HH24:MI:SS'),100,200230,'M_InOutLine_ID','0')
;

-- Sep 6, 2022, 1:35:31 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217611,'be57abc6-3a74-4016-8267-82daeda93c60',TO_TIMESTAMP('2022-09-06 13:35:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:30','YYYY-MM-DD HH24:MI:SS'),100,200230,'M_RMALine_ID','rl.M_RMALine_ID')
;

-- Sep 6, 2022, 1:35:33 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217612,'9a19cb85-275b-4e4b-99dd-ebdba45c5e33',TO_TIMESTAMP('2022-09-06 13:35:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:31','YYYY-MM-DD HH24:MI:SS'),100,200230,'C_BPartner_ID','r.C_BPartner_ID')
;

-- Sep 6, 2022, 1:35:34 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217613,'1f90326c-b38f-4b5c-881a-bb87e3222d66',TO_TIMESTAMP('2022-09-06 13:35:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:33','YYYY-MM-DD HH24:MI:SS'),100,200230,'C_Order_ID','0')
;

-- Sep 6, 2022, 1:35:34 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217614,'259978d4-c87e-4e92-9c18-8568c2f9860a',TO_TIMESTAMP('2022-09-06 13:35:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:34','YYYY-MM-DD HH24:MI:SS'),100,200230,'M_InOut_ID','0')
;

-- Sep 6, 2022, 1:35:35 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217615,'0fe7bc3e-b4ab-4400-8789-38ea30b93cfa',TO_TIMESTAMP('2022-09-06 13:35:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:34','YYYY-MM-DD HH24:MI:SS'),100,200230,'M_RMA_ID','r.m_rma_id')
;

-- Sep 6, 2022, 1:35:36 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217616,'7346b069-fc6e-499c-8367-87d62f68e2b5',TO_TIMESTAMP('2022-09-06 13:35:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:35','YYYY-MM-DD HH24:MI:SS'),100,200230,'C_Invoice_CreateFrom_v2_ID','rl.M_RMALine_ID')
;

-- Sep 6, 2022, 1:35:37 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217617,'9693bc1a-4e91-4a56-a835-27d4725553e3',TO_TIMESTAMP('2022-09-06 13:35:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:36','YYYY-MM-DD HH24:MI:SS'),100,200230,'AD_Client_ID','rl.AD_Client_ID')
;

-- Sep 6, 2022, 1:35:38 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217618,'2fd6f708-ab23-40a6-aa95-8bf167d21023',TO_TIMESTAMP('2022-09-06 13:35:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:37','YYYY-MM-DD HH24:MI:SS'),100,200230,'AD_Org_ID','rl.AD_Org_ID')
;

-- Sep 6, 2022, 1:35:39 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217619,'f211bc6f-1e5b-47e4-aae8-2783c9a9f606',TO_TIMESTAMP('2022-09-06 13:35:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:38','YYYY-MM-DD HH24:MI:SS'),100,200230,'IsActive','rl.IsActive')
;

-- Sep 6, 2022, 1:35:39 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217620,'4d687267-df4b-45f7-b427-319f03c7994b',TO_TIMESTAMP('2022-09-06 13:35:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:39','YYYY-MM-DD HH24:MI:SS'),100,200230,'IsSOTrx','r.IsSOTrx')
;

-- Sep 6, 2022, 1:35:40 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217621,'6408c338-f4c3-4b00-9eb1-a92a46a1b372',TO_TIMESTAMP('2022-09-06 13:35:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:39','YYYY-MM-DD HH24:MI:SS'),100,200230,'AD_Table_ID','660')
;

-- Sep 6, 2022, 1:35:41 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200231,'94f4c615-4bcc-40ac-9925-f910254ac3a0',TO_TIMESTAMP('2022-09-06 13:35:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','RMA Lines without Shipment/Receipt Line - Product',TO_TIMESTAMP('2022-09-06 13:35:40','YYYY-MM-DD HH24:MI:SS'),100,200359,40,'WHERE rl.m_product_id IS NOT NULL AND rl.m_inoutline_id IS NULL','FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_product p ON p.m_product_id = rl.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = p.c_uom_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id','N')
;

-- Sep 6, 2022, 1:35:42 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217622,'b97cd1e3-47db-40f9-a7f9-9832123333dd',TO_TIMESTAMP('2022-09-06 13:35:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:41','YYYY-MM-DD HH24:MI:SS'),100,200231,'CreditMemoQty','rl.Qty - COALESCE(rl.QtyInvoiced, 0)')
;

-- Sep 6, 2022, 1:35:43 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217623,'8419d3ae-278b-4784-9bd3-3e5f9f84fc7c',TO_TIMESTAMP('2022-09-06 13:35:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:42','YYYY-MM-DD HH24:MI:SS'),100,200231,'Qty','rl.Qty - COALESCE(rl.QtyInvoiced, 0)')
;

-- Sep 6, 2022, 1:35:44 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217624,'cc264638-3361-40f0-b8a1-35c54f822927',TO_TIMESTAMP('2022-09-06 13:35:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:43','YYYY-MM-DD HH24:MI:SS'),100,200231,'Multiplier','1')
;

-- Sep 6, 2022, 1:35:44 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217625,'65c1a612-fe4d-4eee-ad31-6ab8d057c392',TO_TIMESTAMP('2022-09-06 13:35:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:44','YYYY-MM-DD HH24:MI:SS'),100,200231,'C_UOM_ID','uom.C_UOM_ID')
;

-- Sep 6, 2022, 1:35:45 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217626,'2699e4a0-742c-4dd0-9d51-a66757274563',TO_TIMESTAMP('2022-09-06 13:35:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:44','YYYY-MM-DD HH24:MI:SS'),100,200231,'M_Product_ID','p.M_Product_ID')
;

-- Sep 6, 2022, 1:35:46 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217627,'afa6b207-3594-4f6b-91ca-a6f2590535e4',TO_TIMESTAMP('2022-09-06 13:35:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:45','YYYY-MM-DD HH24:MI:SS'),100,200231,'C_Charge_ID','0')
;

-- Sep 6, 2022, 1:35:47 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217628,'d50a79c8-5058-4175-9a6f-0eb59afc2975',TO_TIMESTAMP('2022-09-06 13:35:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:46','YYYY-MM-DD HH24:MI:SS'),100,200231,'VendorProductNo','po.VendorProductNo')
;

-- Sep 6, 2022, 1:35:48 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217629,'0f9c5e7d-d1b5-4a51-b910-e349278781ca',TO_TIMESTAMP('2022-09-06 13:35:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:47','YYYY-MM-DD HH24:MI:SS'),100,200231,'Line','rl.Line')
;

-- Sep 6, 2022, 1:35:49 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217630,'caaf5204-9f7d-4886-ba17-3e5c2ccaf2c4',TO_TIMESTAMP('2022-09-06 13:35:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:48','YYYY-MM-DD HH24:MI:SS'),100,200231,'C_OrderLine_ID','0')
;

-- Sep 6, 2022, 1:35:50 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217631,'a00d3267-101f-4ed0-98fa-5bf4a841a151',TO_TIMESTAMP('2022-09-06 13:35:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:49','YYYY-MM-DD HH24:MI:SS'),100,200231,'M_InOutLine_ID','0')
;

-- Sep 6, 2022, 1:35:50 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217632,'cf94572c-7ae2-4390-a132-37acb22928d3',TO_TIMESTAMP('2022-09-06 13:35:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:50','YYYY-MM-DD HH24:MI:SS'),100,200231,'M_RMALine_ID','rl.M_RMALine_ID')
;

-- Sep 6, 2022, 1:35:51 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217633,'e069cc1f-1010-41f9-b3f3-97708e349229',TO_TIMESTAMP('2022-09-06 13:35:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:50','YYYY-MM-DD HH24:MI:SS'),100,200231,'C_BPartner_ID','r.C_BPartner_ID')
;

-- Sep 6, 2022, 1:35:52 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217634,'3172c42f-780a-4a40-a8fd-cc57255bb56c',TO_TIMESTAMP('2022-09-06 13:35:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:51','YYYY-MM-DD HH24:MI:SS'),100,200231,'C_Order_ID','0')
;

-- Sep 6, 2022, 1:35:53 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217635,'f6d9280e-6a70-4918-a405-4f54318901d7',TO_TIMESTAMP('2022-09-06 13:35:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:52','YYYY-MM-DD HH24:MI:SS'),100,200231,'M_InOut_ID','0')
;

-- Sep 6, 2022, 1:35:54 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217636,'7337e69a-11dc-4bd5-a3de-752b7be860f4',TO_TIMESTAMP('2022-09-06 13:35:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:53','YYYY-MM-DD HH24:MI:SS'),100,200231,'M_RMA_ID','r.M_RMA_ID')
;

-- Sep 6, 2022, 1:35:55 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217637,'82d3a97f-2f94-4dc9-9631-68610fc1c202',TO_TIMESTAMP('2022-09-06 13:35:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:54','YYYY-MM-DD HH24:MI:SS'),100,200231,'C_Invoice_CreateFrom_v2_ID','rl.M_RMALine_ID')
;

-- Sep 6, 2022, 1:35:55 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217638,'f220c417-da99-44b4-9ff7-2f9dfc819e78',TO_TIMESTAMP('2022-09-06 13:35:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:55','YYYY-MM-DD HH24:MI:SS'),100,200231,'AD_Client_ID','rl.AD_Client_ID')
;

-- Sep 6, 2022, 1:35:56 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217639,'767ecc00-7b56-4e65-b6aa-c13cf285c892',TO_TIMESTAMP('2022-09-06 13:35:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:56','YYYY-MM-DD HH24:MI:SS'),100,200231,'AD_Org_ID','rl.AD_Org_ID')
;

-- Sep 6, 2022, 1:35:57 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217640,'b8eea22b-a073-492f-b924-568771994332',TO_TIMESTAMP('2022-09-06 13:35:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:56','YYYY-MM-DD HH24:MI:SS'),100,200231,'IsActive','rl.IsActive')
;

-- Sep 6, 2022, 1:35:58 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217641,'b22ff56a-d543-461a-80a6-bf04b5220b55',TO_TIMESTAMP('2022-09-06 13:35:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:57','YYYY-MM-DD HH24:MI:SS'),100,200231,'IsSOTrx','r.IsSOTrx')
;

-- Sep 6, 2022, 1:35:59 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217642,'93291ce0-7b9f-44e8-beb3-5b508a2be4ad',TO_TIMESTAMP('2022-09-06 13:35:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:35:58','YYYY-MM-DD HH24:MI:SS'),100,200231,'AD_Table_ID','660')
;

-- Sep 6, 2022, 1:36:00 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200232,'bed6a97a-a11b-48af-b4b5-1bb8a9996f25',TO_TIMESTAMP('2022-09-06 13:35:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','RMA Lines without Shipment/Receipt Line - Charge',TO_TIMESTAMP('2022-09-06 13:35:59','YYYY-MM-DD HH24:MI:SS'),100,200359,50,'WHERE rl.c_charge_id IS NOT NULL AND rl.m_inoutline_id IS NULL','FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN c_charge c ON c.c_charge_id = rl.c_charge_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = 100','N')
;

-- Sep 6, 2022, 1:36:00 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217643,'d1dad0da-2df0-4e89-ab7f-6d4744fd236f',TO_TIMESTAMP('2022-09-06 13:36:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:00','YYYY-MM-DD HH24:MI:SS'),100,200232,'CreditMemoQty','rl.Qty - COALESCE(rl.QtyInvoiced, 0)')
;

-- Sep 6, 2022, 1:36:01 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217644,'a75f786d-3a54-453b-a923-e97baef957d3',TO_TIMESTAMP('2022-09-06 13:36:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:01','YYYY-MM-DD HH24:MI:SS'),100,200232,'Qty','rl.Qty - COALESCE(rl.QtyInvoiced, 0)')
;

-- Sep 6, 2022, 1:36:02 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217645,'b494a7f7-20cd-4c14-ad42-e508d525d09e',TO_TIMESTAMP('2022-09-06 13:36:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:01','YYYY-MM-DD HH24:MI:SS'),100,200232,'Multiplier','1')
;

-- Sep 6, 2022, 1:36:03 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217646,'97b5636a-9452-4625-9628-713d85f0cd32',TO_TIMESTAMP('2022-09-06 13:36:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:02','YYYY-MM-DD HH24:MI:SS'),100,200232,'C_UOM_ID','uom.C_UOM_ID')
;

-- Sep 6, 2022, 1:36:04 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217647,'18668278-8233-4e0f-92a2-01916c2f465a',TO_TIMESTAMP('2022-09-06 13:36:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:03','YYYY-MM-DD HH24:MI:SS'),100,200232,'M_Product_ID','0')
;

-- Sep 6, 2022, 1:36:05 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217648,'05868e3d-56b2-4de4-8dd0-2d89675d2a26',TO_TIMESTAMP('2022-09-06 13:36:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:04','YYYY-MM-DD HH24:MI:SS'),100,200232,'C_Charge_ID','c.C_Charge_ID')
;

-- Sep 6, 2022, 1:36:06 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217649,'9bfa4c7e-5f1a-4b09-8245-203f6171d393',TO_TIMESTAMP('2022-09-06 13:36:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:05','YYYY-MM-DD HH24:MI:SS'),100,200232,'VendorProductNo','NULL')
;

-- Sep 6, 2022, 1:36:06 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217650,'2537d273-b9d1-4d16-8bbc-a6abea9edf21',TO_TIMESTAMP('2022-09-06 13:36:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:06','YYYY-MM-DD HH24:MI:SS'),100,200232,'Line','rl.Line')
;

-- Sep 6, 2022, 1:36:07 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217651,'0fa604f5-dec6-484f-a405-f7c2eea62dd0',TO_TIMESTAMP('2022-09-06 13:36:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:07','YYYY-MM-DD HH24:MI:SS'),100,200232,'C_OrderLine_ID','0')
;

-- Sep 6, 2022, 1:36:08 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217652,'fa0e6c67-7a02-42ea-9a8c-62e26310107f',TO_TIMESTAMP('2022-09-06 13:36:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:07','YYYY-MM-DD HH24:MI:SS'),100,200232,'M_InOutLine_ID','0')
;

-- Sep 6, 2022, 1:36:09 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217653,'1aaf0c29-a832-4878-87f9-76a17c1c59b0',TO_TIMESTAMP('2022-09-06 13:36:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:08','YYYY-MM-DD HH24:MI:SS'),100,200232,'M_RMALine_ID','rl.M_RMALine_ID')
;

-- Sep 6, 2022, 1:36:10 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217654,'7c83a8ce-df63-4285-8a34-fa119046cef8',TO_TIMESTAMP('2022-09-06 13:36:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:09','YYYY-MM-DD HH24:MI:SS'),100,200232,'C_BPartner_ID','r.C_BPartner_ID')
;

-- Sep 6, 2022, 1:36:11 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217655,'b278ec20-9192-4a5b-b92f-2904bf67f898',TO_TIMESTAMP('2022-09-06 13:36:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:10','YYYY-MM-DD HH24:MI:SS'),100,200232,'C_Order_ID','0')
;

-- Sep 6, 2022, 1:36:12 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217656,'8f1edf12-a1d7-4b93-b3b1-370d1d99f443',TO_TIMESTAMP('2022-09-06 13:36:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:11','YYYY-MM-DD HH24:MI:SS'),100,200232,'M_InOut_ID','0')
;

-- Sep 6, 2022, 1:36:12 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217657,'bc399561-5713-4673-9a04-f90679866c81',TO_TIMESTAMP('2022-09-06 13:36:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:12','YYYY-MM-DD HH24:MI:SS'),100,200232,'M_RMA_ID','r.m_rma_id')
;

-- Sep 6, 2022, 1:36:13 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217658,'b7f44e01-6b92-49bd-b555-81b9587adec9',TO_TIMESTAMP('2022-09-06 13:36:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:12','YYYY-MM-DD HH24:MI:SS'),100,200232,'C_Invoice_CreateFrom_v2_ID','rl.M_RMALine_ID')
;

-- Sep 6, 2022, 1:36:14 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217659,'e7c2b297-a059-4a14-837b-e64a6fdfdba6',TO_TIMESTAMP('2022-09-06 13:36:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:13','YYYY-MM-DD HH24:MI:SS'),100,200232,'AD_Client_ID','rl.AD_Client_ID')
;

-- Sep 6, 2022, 1:36:15 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217660,'00eaf3cc-12ed-4ac2-9d6c-d0d122327f92',TO_TIMESTAMP('2022-09-06 13:36:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:14','YYYY-MM-DD HH24:MI:SS'),100,200232,'AD_Org_ID','rl.AD_Org_ID')
;

-- Sep 6, 2022, 1:36:16 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217661,'549f8533-bbaa-49ac-af55-208fcd2914ab',TO_TIMESTAMP('2022-09-06 13:36:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:15','YYYY-MM-DD HH24:MI:SS'),100,200232,'IsActive','rl.IsActive')
;

-- Sep 6, 2022, 1:36:17 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217662,'7ac580cd-8e8c-438e-868d-c5aa317a985e',TO_TIMESTAMP('2022-09-06 13:36:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:16','YYYY-MM-DD HH24:MI:SS'),100,200232,'IsSOTrx','r.IsSOTrx')
;

-- Sep 6, 2022, 1:36:18 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217663,'fdec03e5-4ac6-459d-9f49-15c424cc3973',TO_TIMESTAMP('2022-09-06 13:36:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-06 13:36:17','YYYY-MM-DD HH24:MI:SS'),100,200232,'AD_Table_ID','660')
;

-- Sep 6, 2022, 1:36:53 PM SGT
UPDATE AD_ViewColumn SET ColumnName='CreditQty',Updated=TO_TIMESTAMP('2022-09-06 13:36:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217538
;

-- Sep 6, 2022, 1:37:05 PM SGT
UPDATE AD_ViewColumn SET ColumnName='C_Invoice_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-06 13:37:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217553
;

-- Sep 6, 2022, 1:37:30 PM SGT
UPDATE AD_ViewColumn SET ColumnName='C_Invoice_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-06 13:37:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217574
;

-- Sep 6, 2022, 1:37:39 PM SGT
UPDATE AD_ViewColumn SET ColumnName='CreditQty',Updated=TO_TIMESTAMP('2022-09-06 13:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217559
;

-- Sep 6, 2022, 1:38:28 PM SGT
UPDATE AD_ViewColumn SET ColumnName='C_Invoice_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-06 13:38:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217594
;

-- Sep 6, 2022, 1:38:36 PM SGT
UPDATE AD_ViewColumn SET ColumnName='CreditQty',Updated=TO_TIMESTAMP('2022-09-06 13:38:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217600
;

-- Sep 6, 2022, 1:38:59 PM SGT
UPDATE AD_ViewColumn SET ColumnName='C_Invoice_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-06 13:38:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217616
;

-- Sep 6, 2022, 1:39:09 PM SGT
UPDATE AD_ViewColumn SET ColumnName='CreditQty',Updated=TO_TIMESTAMP('2022-09-06 13:39:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217601
;

-- Sep 6, 2022, 1:39:33 PM SGT
UPDATE AD_ViewColumn SET ColumnName='CreditQty',Updated=TO_TIMESTAMP('2022-09-06 13:39:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217622
;

-- Sep 6, 2022, 1:39:40 PM SGT
UPDATE AD_ViewColumn SET ColumnName='C_Invoice_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-06 13:39:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217637
;

-- Sep 6, 2022, 1:40:08 PM SGT
UPDATE AD_ViewColumn SET ColumnName='CreditQty',Updated=TO_TIMESTAMP('2022-09-06 13:40:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217643
;

-- Sep 6, 2022, 1:40:13 PM SGT
UPDATE AD_ViewColumn SET ColumnName='C_Invoice_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-06 13:40:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217658
;

-- Sep 6, 2022, 1:40:29 PM SGT
CREATE OR REPLACE VIEW C_Invoice_CreateFrom_v(CreditQty, Qty, Multiplier, C_UOM_ID, M_Product_ID, C_Charge_ID, VendorProductNo, Line, C_OrderLine_ID, M_InOutLine_ID, M_RMALine_ID, C_BPartner_ID, C_Order_ID, M_InOut_ID, M_RMA_ID, C_Invoice_CreateFrom_v_ID, AD_Client_ID, AD_Org_ID, IsActive, IsSOTrx, AD_Table_ID) 
AS SELECT SUM(COALESCE(m.Qty,0)) AS CreditQty, l.QtyOrdered-SUM(COALESCE(m.Qty,0)) AS Qty, CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END AS Multiplier, l.C_UOM_ID AS C_UOM_ID, COALESCE(l.M_Product_ID, 0) AS M_Product_ID, 
COALESCE(l.C_Charge_ID, 0) AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, 0 AS M_InOutLine_ID, 0 AS M_RMALine_ID, l.C_BPartner_ID AS C_BPartner_ID, l.C_Order_ID AS C_Order_ID, 
0 AS M_InOut_ID, 0 AS M_RMA_ID, l.C_OrderLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, o.IsSOTrx AS IsSOTrx, 260 AS AD_Table_ID 
FROM C_OrderLine l
     JOIN C_Order o ON o.C_Order_ID = l.C_Order_ID 
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND l.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN M_MatchPO m ON l.c_orderline_id = m.C_OrderLine_ID AND m.C_InvoiceLine_ID IS NOT NULL AND COALESCE(m.Reversal_ID,0)=0
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID 
GROUP BY l.QtyOrdered,CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END,
l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, l.Line, l.C_OrderLine_ID, o.IsSOTrx ,
l.AD_Client_ID, l.AD_Org_ID, l.IsActive,l.c_bpartner_id,l.C_Order_ID
UNION SELECT CASE WHEN io.IsSOTrx='N' THEN (l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END) ELSE (l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END) END AS CreditQty,
 l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END AS Qty, l.QtyEntered/l.MovementQty AS Multiplier, l.C_UOM_ID AS C_UOM_ID, l.M_Product_ID AS M_Product_ID, l.C_Charge_ID AS C_Charge_ID,
  po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, l.M_InOutLine_ID AS M_InOutLine_ID, 0 AS M_RMALine_ID, io.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, l.M_InOut_ID AS M_InOut_ID, 0 AS M_RMA_ID, 
  l.M_InOutLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, io.IsSOTrx AS IsSOTrx, 320 AS AD_Table_ID 
  FROM M_InOutLine l
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID
     JOIN M_InOut io ON l.m_inout_id= io.M_InOut_ID
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND io.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN M_MatchInv mi ON l.M_InOutLine_ID = mi.M_InOutLine_ID WHERE l.MovementQty <> 0 AND io.IsSOTrx='N' 
GROUP BY io.MovementType, l.MovementQty, l.QtyEntered/l.MovementQty, l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, 
	 l.Line, l.C_OrderLine_ID, l.M_InOutLine_ID, io.C_BPartner_ID, l.M_InOut_ID, io.IsSOTrx,
      l.AD_Client_ID, l.AD_Org_ID, l.IsActive
	 HAVING l.MovementQty-SUM(COALESCE(mi.Qty, 0)) <> 0 
UNION SELECT l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) AS CreditQty, l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) AS Qty, l.QtyEntered/l.MovementQty AS Multiplier, l.C_UOM_ID AS C_UOM_ID, l.M_Product_ID AS M_Product_ID, 
l.C_Charge_ID AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, l.M_InOutLine_ID AS M_InOutLine_ID, 0 AS M_RMALine_ID, io.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID,
 l.M_InOut_ID AS M_InOut_ID, 0 AS M_RMA_ID, l.M_InOutLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, io.IsSOTrx AS IsSOTrx, 320 AS AD_Table_ID 
 FROM M_InOutLine l
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID
     JOIN M_InOut io ON l.m_inout_id= io.M_InOut_ID
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND io.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN C_InvoiceLine il ON l.M_InOutLine_ID = il.M_InOutLine_ID  WHERE l.MovementQty <> 0 AND io.IsSOTrx='Y' 
GROUP BY io.MovementType, l.MovementQty, l.QtyEntered/l.MovementQty, l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, 
	 l.Line, l.C_OrderLine_ID, l.M_InOutLine_ID, io.C_BPartner_ID, l.M_InOut_ID, io.IsSOTrx,
      l.AD_Client_ID, l.AD_Org_ID,l.IsActive
	 HAVING l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) <> 0 
UNION SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, p.M_Product_ID AS M_Product_ID, c.C_Charge_ID AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, 
rl.Line AS Line, 0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.m_rma_id AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, 
rl.AD_Client_ID AS AD_Client_ID, rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID 
FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_inoutline iol ON rl.m_inoutline_id = iol.m_inoutline_id
     LEFT JOIN m_product p ON p.m_product_id = iol.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = COALESCE(p.c_uom_id, iol.c_uom_id)
     LEFT JOIN c_charge c ON c.c_charge_id = iol.c_charge_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_inoutline_id IS NOT NULL 
UNION SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, p.M_Product_ID AS M_Product_ID, 0 AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, 
rl.Line AS Line, 0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.M_RMA_ID AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, 
rl.AD_Client_ID AS AD_Client_ID, rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID 
FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_product p ON p.m_product_id = rl.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = p.c_uom_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_product_id IS NOT NULL AND rl.m_inoutline_id IS NULL 
UNION SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, 0 AS M_Product_ID, c.C_Charge_ID AS C_Charge_ID, NULL AS VendorProductNo, rl.Line AS Line, 
0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.m_rma_id AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, rl.AD_Client_ID AS AD_Client_ID, 
rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID 
FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN c_charge c ON c.c_charge_id = rl.c_charge_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = 100 WHERE rl.c_charge_id IS NOT NULL AND rl.m_inoutline_id IS NULL
;

-- Sep 6, 2022, 1:41:29 PM SGT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203649,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:27','YYYY-MM-DD HH24:MI:SS'),100,'CreditQty','Credit Quantity','Credit Quantity','The Credit Quantity indicates the number of a specific product or item for this document.','Credit Qty','D','3ce54872-ce31-4635-8307-f6854a80b87c')
;

-- Sep 6, 2022, 1:41:51 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215261,0.0,'Credit Quantity','Credit Quantity','The Credit Quantity indicates the number of a specific product or item for this document.',200359,'CreditQty',14,'N','N','N','N','N','N',29,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:50','YYYY-MM-DD HH24:MI:SS'),100,203649,'N','N','D','N','b87dc6f8-7a08-42fc-baf3-1a24f1772682','N')
;

-- Sep 6, 2022, 1:41:52 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215262,0.0,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',200359,'Qty',14,'N','N','N','N','N','N',29,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:51','YYYY-MM-DD HH24:MI:SS'),100,526,'N','N','D','N','2661f389-b002-444d-bcb4-5cc3d41300cd','N')
;

-- Sep 6, 2022, 1:41:53 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215263,0.0,'Multiplier','Type Multiplier (Credit = -1)',200359,'Multiplier',14,'N','N','N','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:52','YYYY-MM-DD HH24:MI:SS'),100,1525,'N','N','D','N','adcab58b-6528-42c6-a01e-dcfffee44cc1','N','N')
;

-- Sep 6, 2022, 1:41:54 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215264,0.0,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',200359,'C_UOM_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:53','YYYY-MM-DD HH24:MI:SS'),100,215,'N','N','D','N','d09af64d-eccd-4198-94e6-41cac983ca0a','N','N')
;

-- Sep 6, 2022, 1:41:55 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215265,0.0,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200359,231,'M_Product_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:54','YYYY-MM-DD HH24:MI:SS'),100,454,'N','N','D','N','3c8f51d7-606b-41ca-bc37-89782c3927f2','N','N')
;

-- Sep 6, 2022, 1:41:56 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215266,0.0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',200359,'C_Charge_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:55','YYYY-MM-DD HH24:MI:SS'),100,968,'N','N','D','N','c9fa4dc2-8df1-4fa8-9cba-66c3546f200f','N')
;

-- Sep 6, 2022, 1:41:57 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215267,0.0,'Partner Product Key','Product Key of the Business Partner','The Business Partner Product Key identifies the number used by the Business Partner for this product. It can be printed on orders and invoices when you include the Product Key in the print format.',200359,'VendorProductNo',2147483647,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:56','YYYY-MM-DD HH24:MI:SS'),100,623,'N','N','D','N','c5e50d97-7ef1-4e75-919b-c7048864d994','N')
;

-- Sep 6, 2022, 1:41:58 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215268,0.0,'Line No','Unique line for this document','Indicates the unique line for a document.  It will also control the display order of the lines within a document.',200359,'Line',10,'N','N','N','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:57','YYYY-MM-DD HH24:MI:SS'),100,439,'N','N','D','N','a64ee4a1-628c-405d-aa30-95506a3e99ad','N')
;

-- Sep 6, 2022, 1:41:59 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215269,0.0,'Sales Order Line','Sales Order Line','The Sales Order Line is a unique identifier for a line in an order.',200359,'C_OrderLine_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:58','YYYY-MM-DD HH24:MI:SS'),100,561,'N','N','D','N','359ed3b8-6c11-4541-94bb-a004370c6967','N')
;

-- Sep 6, 2022, 1:42:00 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215270,0.0,'Shipment/Receipt Line','Line on Shipment or Receipt document','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document',200359,'M_InOutLine_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:41:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:41:59','YYYY-MM-DD HH24:MI:SS'),100,1026,'N','N','D','N','a168e937-45b2-4f49-ba58-fab500740987','N','N')
;

-- Sep 6, 2022, 1:42:01 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215271,0.0,'RMA Line','Return Material Authorization Line','Detail information about the returned goods',200359,'M_RMALine_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:00','YYYY-MM-DD HH24:MI:SS'),100,2413,'N','N','D','N','f120f3c7-1bac-49c8-8158-5eeea98eba6b','N')
;

-- Sep 6, 2022, 1:42:02 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215272,0.0,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200359,'C_BPartner_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:01','YYYY-MM-DD HH24:MI:SS'),100,187,'N','N','D','N','ad606e8f-8377-4d53-93b5-406bcf588633','N')
;

-- Sep 6, 2022, 1:42:03 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215273,0.0,'Order','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.',200359,'C_Order_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:02','YYYY-MM-DD HH24:MI:SS'),100,558,'N','N','D','N','4eca6238-bfcd-48ca-a64a-ad621bda7ba0','N')
;

-- Sep 6, 2022, 1:42:04 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215274,0.0,'Shipment/Receipt','Material Shipment Document','The Material Shipment / Receipt ',200359,'M_InOut_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:03','YYYY-MM-DD HH24:MI:SS'),100,1025,'N','N','D','N','114a34af-8335-4350-aaab-5210a63f6b63','N')
;

-- Sep 6, 2022, 1:42:05 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215275,0.0,'RMA','Return Material Authorization','A Return Material Authorization may be required to accept returns and to create Credit Memos',200359,'M_RMA_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:04','YYYY-MM-DD HH24:MI:SS'),100,2412,'N','N','D','N','0af4a59c-0835-41eb-bcd7-97a5ec1e8ebe','N')
;

-- Sep 6, 2022, 1:42:06 PM SGT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203650,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:05','YYYY-MM-DD HH24:MI:SS'),100,'C_Invoice_CreateFrom_v_ID','C_Invoice_CreateFrom_v','C_Invoice_CreateFrom_v','D','6381e89c-10b2-4c37-8d94-82f7f4647718')
;

-- Sep 6, 2022, 1:42:07 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215276,0.0,'C_Invoice_CreateFrom_v',200359,'C_Invoice_CreateFrom_v_ID',10,'Y','N','N','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:05','YYYY-MM-DD HH24:MI:SS'),100,203650,'N','N','D','N','451bf28b-31bb-4704-9d86-e3ca597444de','N')
;

-- Sep 6, 2022, 1:42:08 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215277,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200359,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:07','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','14776bd0-a0a4-4b8f-8aee-4ed0b4872044','N','D')
;

-- Sep 6, 2022, 1:42:09 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215278,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200359,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:08','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','8e5e25b5-cf1d-4606-9e70-c31c9cacdaea','N','D')
;

-- Sep 6, 2022, 1:42:10 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215279,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200359,'IsActive','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:09','YYYY-MM-DD HH24:MI:SS'),100,348,'N','N','D','N','9b26e0ae-e481-4418-a6d8-b284ec46ec88','N')
;

-- Sep 6, 2022, 1:42:11 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215280,0.0,'Sales Transaction','This is a Sales Transaction','The Sales Transaction checkbox indicates if this item is a Sales Transaction.',200359,'IsSOTrx',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:10','YYYY-MM-DD HH24:MI:SS'),100,1106,'N','N','D','N','520d3185-9b76-486d-86ff-4d569a0df5fe','N')
;

-- Sep 6, 2022, 1:42:12 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215281,0.0,'Table','Database Table information','The Database Table provides the information of the table definition',200359,'AD_Table_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:42:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:42:11','YYYY-MM-DD HH24:MI:SS'),100,126,'N','N','D','N','07721646-0ac2-4f0a-843d-d36d7c509ff2','N','N')
;

-- Sep 6, 2022, 1:43:56 PM SGT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,AD_Process_UU,AllowMultipleExecution) VALUES (200143,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:43:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:43:55','YYYY-MM-DD HH24:MI:SS'),100,'Create lines from Invoice','Create lines from Invoice','N','C_Invoice_CreateFromProcess','N','org.compiere.process.CreateFromInvoice','1','D',0,0,'N','Y','93b52473-ea26-4bb2-b74e-bb0951dc8e06','P')
;

-- Sep 6, 2022, 1:44:31 PM SGT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,ReadOnlyLogic,AD_Process_Para_UU) VALUES (200408,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:44:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:44:30','YYYY-MM-DD HH24:MI:SS'),100,'Invoice','Invoice Identifier','The Invoice Document.',200143,10,30,'N',0,'Y','@C_Invoice_ID@','C_Invoice_ID','Y','D',1008,'@C_Invoice_ID@!0','9b959710-46da-446c-bad4-005c4deb097f')
;

-- Sep 6, 2022, 1:45:15 PM SGT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200167,'M_InOut in C_Invoice_CreateFrom_v','S','C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus IN (''CL'',''CO'') AND 
(CASE WHEN IsSOTrx=''N'' THEN 
M_InOut_ID IN (
SELECT sl.M_InOut_ID FROM M_InOutLine sl 
LEFT OUTER JOIN M_MatchInv mi ON (sl.M_InOutLine_ID=mi.M_InOutLine_ID) 
JOIN M_InOut s2 ON (sl.M_InOut_ID=s2.M_InOut_ID) 
WHERE s2.C_BPartner_ID=@C_BPartner_ID@ AND s2.IsSOTrx=''@IsSOTrx@'' AND s2.DocStatus IN (''CL'',''CO'') 
GROUP BY sl.M_InOut_ID,sl.MovementQty,s2.MovementType,mi.M_InOutLine_ID 
HAVING (sl.MovementQty <> SUM(mi.Qty) * CASE WHEN s2.MovementType = ''V-'' THEN -1 ELSE 1 END 
AND mi.M_InOutLine_ID IS NOT NULL) OR mi.M_InOutLine_ID IS NULL
) 
ELSE
M_InOut_ID IN (
SELECT sl.M_InOut_ID FROM M_InOutLine sl 
INNER JOIN M_InOut s2 ON (sl.M_InOut_ID=s2.M_InOut_ID) 
LEFT JOIN C_InvoiceLine il ON sl.M_InOutLine_ID = il.M_InOutLine_ID 
WHERE s2.C_BPartner_ID=@C_BPartner_ID@ AND s2.IsSOTrx=''@IsSOTrx@'' AND s2.DocStatus IN (''CL'',''CO'') 
GROUP BY sl.M_InOutLine_ID 
HAVING sl.MovementQty - sum(COALESCE(il.QtyInvoiced,0)) > 0 
) 
END)

',0,0,'Y',TO_TIMESTAMP('2022-09-06 13:45:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:45:14','YYYY-MM-DD HH24:MI:SS'),100,'D','431cbfc9-4c6a-445f-ac5f-a7cee37d923d')
;

-- Sep 6, 2022, 1:45:28 PM SGT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200168,'C_Order in C_Invoice_CreateFrom_v','S','Bill_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus IN (''CL'',''CO'') 
AND CASE WHEN (SELECT COUNT(*) FROM C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC'',''ARC''))=1
THEN (C_Order_ID IN (SELECT ol.C_Order_ID FROM C_OrderLine ol WHERE ol.QtyInvoiced>0 AND (CASE WHEN ol.QtyDelivered>=ol.QtyOrdered THEN ol.QtyDelivered-ol.QtyInvoiced!=0 ELSE 1=1 END)) )
ELSE (C_Order_ID IN (SELECT ol.C_Order_ID FROM C_OrderLine ol WHERE ol.QtyOrdered-ol.QtyInvoiced!=0))
END 

',0,0,'Y',TO_TIMESTAMP('2022-09-06 13:45:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:45:27','YYYY-MM-DD HH24:MI:SS'),100,'D','fc5901ff-8ced-47ef-9199-8945e6569117')
;

-- Sep 6, 2022, 1:47:00 PM SGT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200169,'M_RMA in C_Invoice_CreateFrom_v','S','C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus in (''CO'', ''CL'') 
AND M_RMA_ID in (SELECT rl.M_RMA_ID FROM M_RMALine rl 
WHERE rl.M_RMA_ID=M_RMA.M_RMA_ID AND COALESCE(rl.QtyInvoiced,0)< rl.Qty) 
AND (SELECT COUNT(*) FROM C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC''))=1',0,0,'Y',TO_TIMESTAMP('2022-09-06 13:46:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:46:59','YYYY-MM-DD HH24:MI:SS'),100,'D','5f7b6e31-c5d4-45a0-841b-1a6777a591fc')
;

-- Sep 6, 2022, 1:47:51 PM SGT
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,OrderByClause,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) VALUES (200024,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:47:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:47:51','YYYY-MM-DD HH24:MI:SS'),100,'Create lines from Invoice',200359,'D','C_Invoice_CreateFrom_v v','N','f63ba82b-c657-4038-bf4c-94c47e9a1bed','N','N','v.Line','N',20,'N',0,'Y',0)
;

-- Sep 6, 2022, 1:48:11 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200269,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:10','YYYY-MM-DD HH24:MI:SS'),100,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',200024,'D','(CASE WHEN (SELECT COUNT(*)=1 FROM C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC'',''ARC'')) THEN v.CreditMemoQty*v.Multiplier ELSE v.Qty*v.Multiplier END)',10,'Y','N',526,29,'f87ed4cb-aadb-4536-b34c-c48ec938cdcb','Y','Qty','=','N',0,'N','N')
;

-- Sep 6, 2022, 1:48:12 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200270,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:11','YYYY-MM-DD HH24:MI:SS'),100,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',200024,'D','v.C_UOM_ID',20,'Y','N',215,19,'2706de66-2c45-4d3f-8a33-f4f3c9be9c6e','Y','C_UOM_ID','=','N',0,'N','Y')
;

-- Sep 6, 2022, 1:48:13 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200271,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:12','YYYY-MM-DD HH24:MI:SS'),100,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200024,'D','v.M_Product_ID',40,'Y','N',454,19,'f2a528db-0b40-4191-a124-1a78d419e523','Y','M_Product_ID','=','N',0,'N','Y')
;

-- Sep 6, 2022, 1:48:14 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200272,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:13','YYYY-MM-DD HH24:MI:SS'),100,'Partner Product Key','Product Key of the Business Partner','The Business Partner Product Key identifies the number used by the Business Partner for this product. It can be printed on orders and invoices when you include the Product Key in the print format.',200024,'D','v.VendorProductNo',50,'Y','N',623,10,'649ad81a-efe0-4363-b9c7-e734c46a901b','Y','VendorProductNo','Like','Upper','N',0,'N','Y')
;

-- Sep 6, 2022, 1:48:15 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200273,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:14','YYYY-MM-DD HH24:MI:SS'),100,'Sales Order Line','Sales Order Line','The Sales Order Line is a unique identifier for a line in an order.',200024,'D','v.C_OrderLine_ID',60,'N','N',561,13,'b0d5a8a4-171f-4f42-887b-324cd93d3bf8','Y','C_OrderLine_ID','N',0,'N','Y')
;

-- Sep 6, 2022, 1:48:16 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200274,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:15','YYYY-MM-DD HH24:MI:SS'),100,'Line No','Unique line for this document','Indicates the unique line for a document.  It will also control the display order of the lines within a document.',200024,'D','v.Line',70,'N','N',439,11,'e1ce5d19-9c1f-4966-aad3-72cea116ef9a','Y','Line','=','Y',0,'N','Y')
;

-- Sep 6, 2022, 1:48:17 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsReadOnly) VALUES (200275,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:16','YYYY-MM-DD HH24:MI:SS'),100,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200024,'D','v.C_BPartner_ID',80,'N','Y',187,30,'c2b9de44-a366-47d3-ac93-3fca80f3cb4f','Y','C_BPartner_ID','=','N',10,'@C_BPartner_ID@','Y','Y')
;

-- Sep 6, 2022, 1:48:18 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsReadOnly) VALUES (200276,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:17','YYYY-MM-DD HH24:MI:SS'),100,'Order','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.',200024,'D','v.C_Order_ID',90,'Y','Y',558,19,'ec2fa27f-0fbf-4f4e-9fad-ce7c0db55f9b','Y','@M_InOut_ID@=0 & @M_RMA_ID@=0','C_Order_ID','=','N',20,'@C_Order_ID@','Y','Y')
;

-- Sep 6, 2022, 1:48:18 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsReadOnly) VALUES (200277,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:18','YYYY-MM-DD HH24:MI:SS'),100,'Shipment/Receipt','Material Shipment Document','The Material Shipment / Receipt ',200024,'D','v.M_InOut_ID',100,'Y','Y',1025,19,'7ec96214-33ad-4309-958b-cba87fec9c62','Y','@C_Order_ID@=0 & @M_RMA_ID@=0','M_InOut_ID','=','N',30,'0','Y','Y')
;

-- Sep 6, 2022, 1:48:19 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsReadOnly) VALUES (200278,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:19','YYYY-MM-DD HH24:MI:SS'),100,'RMA','Return Material Authorization','A Return Material Authorization may be required to accept returns and to create Credit Memos',200024,'D','v.M_RMA_ID',110,'Y','Y',2412,19,'947022e1-8885-433a-9527-63ee4aeebf80','Y','@C_Order_ID@=0 & @M_InOut_ID@=0 & @IsSOTrx@=''N''','M_RMA_ID','=','N',40,'@M_RMA_ID@','Y','Y')
;

-- Sep 6, 2022, 1:48:20 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200279,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:48:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:48:19','YYYY-MM-DD HH24:MI:SS'),100,'Table','Database Table information','The Database Table provides the information of the table definition',200024,'D','v.AD_Table_ID',140,'N','N',126,19,'abf4565e-b553-49d0-8e1e-51a74bdf174c','Y','AD_Table_ID','N',0,'N','Y')
;

-- Sep 6, 2022, 1:48:41 PM SGT
UPDATE AD_InfoColumn SET SelectClause='(CASE WHEN (SELECT COUNT(*)=1 FROM C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC'',''ARC'')) THEN v.CreditQty*v.Multiplier ELSE v.Qty*v.Multiplier END)',Updated=TO_TIMESTAMP('2022-09-06 13:48:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200269
;

-- Sep 6, 2022, 1:48:41 PM SGT
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2022-09-06 13:48:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200024
;

-- Sep 6, 2022, 1:50:18 PM SGT
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,AD_InfoColumn_ID,EntityType) VALUES (200015,'e50f493e-ba32-4e0b-beae-292e3978224a',0,0,'Y',TO_TIMESTAMP('2022-09-06 13:50:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:50:17','YYYY-MM-DD HH24:MI:SS'),100,10,200143,200024,'B',200279,'D')
;

-- Sep 6, 2022, 1:56:53 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,AD_InfoWindow_ID) VALUES (215282,1,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',318,'CreateLinesFrom',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2022-09-06 13:56:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:56:52','YYYY-MM-DD HH24:MI:SS'),100,203638,'Y','N','D','N','N','N','Y','f12b18ff-dc48-499e-a5b4-24fe4de0029b','Y','N','N','N','N',200024)
;

-- Sep 6, 2022, 1:57:18 PM SGT
ALTER TABLE C_Invoice ADD CreateLinesFrom CHAR(1) DEFAULT NULL 
;

-- Sep 6, 2022, 1:58:55 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207185,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',263,215282,'Y',1,470,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-06 13:58:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:58:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6d037b35-89fc-4f6b-aef8-3f3a49360762','Y',460,2,2)
;

-- Sep 6, 2022, 1:59:11 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207186,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',290,215282,'Y',1,450,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-06 13:59:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 13:59:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1962159e-e934-4d64-9dbb-adcd06b2e2ed','Y',440,2,2)
;

-- Sep 6, 2022, 2:00:53 PM SGT
UPDATE AD_Field SET DisplayLogic='@Processed@=N', SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', SeqNoGrid=0, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 14:00:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207185
;

-- Sep 6, 2022, 2:01:14 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 14:01:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4244
;

-- Sep 6, 2022, 2:01:51 PM SGT
UPDATE AD_Field SET DisplayLogic='@Processed@=N', SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=240, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 14:01:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207186
;

-- Sep 6, 2022, 2:03:19 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 14:03:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4246
;

-- Sep 6, 2022, 3:08:38 PM SGT
UPDATE AD_InfoColumn SET AD_Val_Rule_ID=200168,Updated=TO_TIMESTAMP('2022-09-06 15:08:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200276
;

-- Sep 6, 2022, 3:08:55 PM SGT
UPDATE AD_InfoColumn SET AD_Val_Rule_ID=200167,Updated=TO_TIMESTAMP('2022-09-06 15:08:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200277
;

-- Sep 6, 2022, 3:09:07 PM SGT
UPDATE AD_InfoColumn SET AD_Val_Rule_ID=200169,Updated=TO_TIMESTAMP('2022-09-06 15:09:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200278
;
