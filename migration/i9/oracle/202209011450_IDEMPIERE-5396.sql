-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202209011450_IDEMPIERE-5396.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 1, 2022, 2:50:58 PM SGT
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200355,'M_InOut_CreateFrom_v','M_InOut_CreateFrom_v',0,'3',0,0,'Y',TO_TIMESTAMP('2022-09-01 14:50:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 14:50:57','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','D','N','N','L','N','Y','7209268d-f892-4377-b297-d6500bb4cab9','N','N','N','N')
;

-- Sep 1, 2022, 2:52:26 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,OtherClause,SeqNo,FromClause,IsUnionAll) VALUES (0,0,200221,'f7624f67-c02f-4842-910e-6a0d3c68b7ff',TO_TIMESTAMP('2022-09-01 14:52:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Order Lines',TO_TIMESTAMP('2022-09-01 14:52:25','YYYY-MM-DD HH24:MI:SS'),100,200355,'GROUP BY l.qtyordered, (
        CASE
            WHEN l.qtyordered = 0 THEN 0
            ELSE l.qtyentered / l.qtyordered
        END), 
l.c_uom_id, p.m_locator_id, po.vendorproductno, l.m_product_id, l.c_charge_id, l.line, l.c_orderline_id, p.upc,o.m_warehouse_id,o.issotrx',10,'FROM c_orderline l
     JOIN c_order o ON o.c_order_id = l.c_order_id
     LEFT JOIN m_product_po po ON l.m_product_id = po.m_product_id AND l.c_bpartner_id = po.c_bpartner_id
     LEFT JOIN m_matchpo m ON l.c_orderline_id = m.c_orderline_id AND m.m_inoutline_id IS NOT NULL
     LEFT JOIN m_product p ON l.m_product_id = p.m_product_id','N')
;

-- Sep 1, 2022, 2:52:28 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217406,'33132bfe-bb61-4475-b646-7ad03d0fd8a4',TO_TIMESTAMP('2022-09-01 14:52:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:26','YYYY-MM-DD HH24:MI:SS'),100,200221,'Qty','l.qtyordered - sum(COALESCE(m.qty, 0)) - COALESCE(( SELECT sum(iol.movementqty) AS sum FROM m_inoutline iol JOIN m_inout io ON iol.m_inout_id = io.m_inout_id           WHERE l.c_orderline_id = iol.c_orderline_id AND io.processed = ''N''), 0)')
;

-- Sep 1, 2022, 2:52:29 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217407,'22886337-0b46-42c8-929a-1219758d9d4e',TO_TIMESTAMP('2022-09-01 14:52:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:28','YYYY-MM-DD HH24:MI:SS'),100,200221,'Multiplier','CASE WHEN l.qtyordered = 0 THEN 0 ELSE l.qtyentered / l.qtyordered END')
;

-- Sep 1, 2022, 2:52:30 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217408,'325cd4b8-d1f8-40d2-81a9-d379f8fa7d27',TO_TIMESTAMP('2022-09-01 14:52:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:29','YYYY-MM-DD HH24:MI:SS'),100,200221,'C_UOM_ID','l.c_uom_id')
;

-- Sep 1, 2022, 2:52:30 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217409,'dcdc1587-f00b-4553-b9d2-716f9ae70666',TO_TIMESTAMP('2022-09-01 14:52:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:30','YYYY-MM-DD HH24:MI:SS'),100,200221,'M_Locator_ID','p.m_locator_id')
;

-- Sep 1, 2022, 2:52:31 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217410,'a5ed27ee-7837-4064-9705-206b9d5cd670',TO_TIMESTAMP('2022-09-01 14:52:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:31','YYYY-MM-DD HH24:MI:SS'),100,200221,'M_Product_ID','COALESCE(l.m_product_id, 0)')
;

-- Sep 1, 2022, 2:52:32 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217411,'844120cf-0c2a-47dc-b75b-62ddd05f8d2e',TO_TIMESTAMP('2022-09-01 14:52:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:31','YYYY-MM-DD HH24:MI:SS'),100,200221,'C_Charge_ID','COALESCE(l.c_charge_id, 0)')
;

-- Sep 1, 2022, 2:52:33 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217412,'55f0accc-1dbb-48a3-ad0c-f1da0f0e7c62',TO_TIMESTAMP('2022-09-01 14:52:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:32','YYYY-MM-DD HH24:MI:SS'),100,200221,'VendorProductNo','po.vendorproductno')
;

-- Sep 1, 2022, 2:52:34 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217413,'171326bc-fe0e-4cca-9755-f89faf009c02',TO_TIMESTAMP('2022-09-01 14:52:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:33','YYYY-MM-DD HH24:MI:SS'),100,200221,'Line','l.line')
;

-- Sep 1, 2022, 2:52:35 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217414,'39ddcd58-2a13-4714-9cea-0a349763881b',TO_TIMESTAMP('2022-09-01 14:52:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:34','YYYY-MM-DD HH24:MI:SS'),100,200221,'C_OrderLine_ID','l.c_orderline_id')
;

-- Sep 1, 2022, 2:52:35 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217415,'23028584-5fc6-4d51-a46a-0847e0a2d427',TO_TIMESTAMP('2022-09-01 14:52:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:35','YYYY-MM-DD HH24:MI:SS'),100,200221,'C_InvoiceLine_ID','0')
;

-- Sep 1, 2022, 2:52:36 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217416,'9543150e-a6d9-4ea7-b3e2-73c5dd896aad',TO_TIMESTAMP('2022-09-01 14:52:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:36','YYYY-MM-DD HH24:MI:SS'),100,200221,'M_RMALine_ID','0')
;

-- Sep 1, 2022, 2:52:37 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217417,'a95333bb-e7ef-4ff6-80f6-586246cd5d11',TO_TIMESTAMP('2022-09-01 14:52:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:36','YYYY-MM-DD HH24:MI:SS'),100,200221,'C_BPartner_ID','l.c_bpartner_id')
;

-- Sep 1, 2022, 2:52:38 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217418,'ce59302b-6954-4fab-a868-fb6731d4dbbd',TO_TIMESTAMP('2022-09-01 14:52:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:37','YYYY-MM-DD HH24:MI:SS'),100,200221,'C_Order_ID','l.c_order_id')
;

-- Sep 1, 2022, 2:52:39 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217419,'ed8c34ce-f109-4289-ac95-3bb66cac57b6',TO_TIMESTAMP('2022-09-01 14:52:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:38','YYYY-MM-DD HH24:MI:SS'),100,200221,'C_Invoice_ID','0')
;

-- Sep 1, 2022, 2:52:40 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217420,'030cebe5-561f-4043-aa07-87c8b516ec91',TO_TIMESTAMP('2022-09-01 14:52:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:39','YYYY-MM-DD HH24:MI:SS'),100,200221,'M_RMA_ID','0')
;

-- Sep 1, 2022, 2:52:41 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217421,'41d011d9-fa8d-4f34-af96-d9fe8c1ba34a',TO_TIMESTAMP('2022-09-01 14:52:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:40','YYYY-MM-DD HH24:MI:SS'),100,200221,'M_InOut_CreateFrom_v2_ID','l.c_orderline_id')
;

-- Sep 1, 2022, 2:52:41 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217422,'a8e8532c-7dcb-4230-b6e2-621a0cc30cca',TO_TIMESTAMP('2022-09-01 14:52:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:41','YYYY-MM-DD HH24:MI:SS'),100,200221,'AD_Client_ID','l.ad_client_id')
;

-- Sep 1, 2022, 2:52:42 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217423,'d3924d77-e318-45b0-95f2-acc66229724f',TO_TIMESTAMP('2022-09-01 14:52:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:41','YYYY-MM-DD HH24:MI:SS'),100,200221,'AD_Org_ID','l.ad_org_id')
;

-- Sep 1, 2022, 2:52:43 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217424,'a383be8c-dd94-4055-91fc-aabf84078a7d',TO_TIMESTAMP('2022-09-01 14:52:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:42','YYYY-MM-DD HH24:MI:SS'),100,200221,'IsActive','l.isactive')
;

-- Sep 1, 2022, 2:52:44 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217425,'c1754edb-499d-4992-822a-6a2926ce410d',TO_TIMESTAMP('2022-09-01 14:52:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:43','YYYY-MM-DD HH24:MI:SS'),100,200221,'UPC','p.upc')
;

-- Sep 1, 2022, 2:52:45 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217426,'75f2e470-4bb6-4317-841d-f8fe93cbc424',TO_TIMESTAMP('2022-09-01 14:52:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:44','YYYY-MM-DD HH24:MI:SS'),100,200221,'M_Warehouse_ID','o.m_warehouse_id')
;

-- Sep 1, 2022, 2:52:45 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217427,'370d6fcd-adf2-499a-9fc3-ef9fa78d0803',TO_TIMESTAMP('2022-09-01 14:52:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:45','YYYY-MM-DD HH24:MI:SS'),100,200221,'IsSOTrx','o.issotrx')
;

-- Sep 1, 2022, 2:52:46 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217428,'78cb96fb-a2d6-4f0e-95a3-3f14cdf1e847',TO_TIMESTAMP('2022-09-01 14:52:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:46','YYYY-MM-DD HH24:MI:SS'),100,200221,'AD_Table_ID','260')
;

-- Sep 1, 2022, 2:52:47 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,OtherClause,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200222,'23caeb65-0cd7-490d-8e7a-fdb8c62cd258',TO_TIMESTAMP('2022-09-01 14:52:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Invoice Lines',TO_TIMESTAMP('2022-09-01 14:52:46','YYYY-MM-DD HH24:MI:SS'),100,200355,'GROUP BY l.qtyinvoiced, (l.qtyentered / l.qtyinvoiced), l.c_uom_id, p.m_locator_id, l.m_product_id, l.c_charge_id, po.vendorproductno, l.c_invoiceline_id, l.line, l.c_orderline_id, inv.c_bpartner_id, l.c_invoice_id, p.upc, inv.issotrx',20,'WHERE l.qtyinvoiced <> 0','FROM c_invoiceline l
     LEFT JOIN m_product p ON l.m_product_id = p.m_product_id
     JOIN c_invoice inv ON l.c_invoice_id = inv.c_invoice_id
     LEFT JOIN m_product_po po ON l.m_product_id = po.m_product_id AND inv.c_bpartner_id = po.c_bpartner_id
     LEFT JOIN m_matchinv mi ON l.c_invoiceline_id = mi.c_invoiceline_id','N')
;

-- Sep 1, 2022, 2:52:48 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217429,'db6745c3-2fd0-46d4-89f2-e4ca99f69b75',TO_TIMESTAMP('2022-09-01 14:52:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:47','YYYY-MM-DD HH24:MI:SS'),100,200222,'Qty','l.qtyinvoiced - sum(nvl(mi.qty, 0))')
;

-- Sep 1, 2022, 2:52:49 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217430,'d8d6e637-da3a-4eb9-bdc3-be3cf42a9680',TO_TIMESTAMP('2022-09-01 14:52:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:48','YYYY-MM-DD HH24:MI:SS'),100,200222,'Multiplier','l.qtyentered / l.qtyinvoiced')
;

-- Sep 1, 2022, 2:52:50 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217431,'9d2caf09-4b33-4ec8-af41-2d22bc2575dc',TO_TIMESTAMP('2022-09-01 14:52:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:49','YYYY-MM-DD HH24:MI:SS'),100,200222,'C_UOM_ID','l.c_uom_id')
;

-- Sep 1, 2022, 2:52:50 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217432,'9461c3c0-b7cb-45a9-bf19-6dfafbc4b404',TO_TIMESTAMP('2022-09-01 14:52:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:50','YYYY-MM-DD HH24:MI:SS'),100,200222,'M_Locator_ID','p.m_locator_id')
;

-- Sep 1, 2022, 2:52:51 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217433,'5ebf5d7f-9503-452f-bfb6-3c998a5fc44d',TO_TIMESTAMP('2022-09-01 14:52:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:51','YYYY-MM-DD HH24:MI:SS'),100,200222,'M_Product_ID','l.m_product_id')
;

-- Sep 1, 2022, 2:52:52 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217434,'9c3b74a2-b072-48de-a93b-1967425e5e73',TO_TIMESTAMP('2022-09-01 14:52:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:51','YYYY-MM-DD HH24:MI:SS'),100,200222,'C_Charge_ID','l.c_charge_id')
;

-- Sep 1, 2022, 2:52:53 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217435,'5db429e6-3c77-4100-bb52-4d3419106111',TO_TIMESTAMP('2022-09-01 14:52:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:52','YYYY-MM-DD HH24:MI:SS'),100,200222,'VendorProductNo','po.vendorproductno')
;

-- Sep 1, 2022, 2:52:54 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217436,'e9878dd5-c20a-4d74-8ebc-8086b074d496',TO_TIMESTAMP('2022-09-01 14:52:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:53','YYYY-MM-DD HH24:MI:SS'),100,200222,'Line','l.line')
;

-- Sep 1, 2022, 2:52:55 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217437,'c0fb4e53-ef37-4522-bca3-6cc5618f11ab',TO_TIMESTAMP('2022-09-01 14:52:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:54','YYYY-MM-DD HH24:MI:SS'),100,200222,'C_OrderLine_ID','l.c_orderline_id')
;

-- Sep 1, 2022, 2:52:55 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217438,'37d63d82-4e39-4080-bc15-30445e31356e',TO_TIMESTAMP('2022-09-01 14:52:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:55','YYYY-MM-DD HH24:MI:SS'),100,200222,'C_InvoiceLine_ID','l.c_invoiceline_id')
;

-- Sep 1, 2022, 2:52:56 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217439,'0cee6e16-e0ac-42e7-aaf7-1337bcc23d03',TO_TIMESTAMP('2022-09-01 14:52:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:55','YYYY-MM-DD HH24:MI:SS'),100,200222,'M_RMALine_ID','0')
;

-- Sep 1, 2022, 2:52:57 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217440,'b52acb4a-aa0e-4686-b57a-abb353b6a747',TO_TIMESTAMP('2022-09-01 14:52:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:56','YYYY-MM-DD HH24:MI:SS'),100,200222,'C_BPartner_ID','inv.c_bpartner_id')
;

-- Sep 1, 2022, 2:52:58 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217441,'83521cbd-b082-4344-bf5a-fee00e84590d',TO_TIMESTAMP('2022-09-01 14:52:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:57','YYYY-MM-DD HH24:MI:SS'),100,200222,'C_Order_ID','0')
;

-- Sep 1, 2022, 2:52:59 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217442,'d941bce4-ee6d-4850-b00d-31b153e76f32',TO_TIMESTAMP('2022-09-01 14:52:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:58','YYYY-MM-DD HH24:MI:SS'),100,200222,'C_Invoice_ID','l.c_invoice_id')
;

-- Sep 1, 2022, 2:52:59 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217443,'fd6cd397-a8e9-44df-af99-7558b0368d6b',TO_TIMESTAMP('2022-09-01 14:52:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:59','YYYY-MM-DD HH24:MI:SS'),100,200222,'M_RMA_ID','0')
;

-- Sep 1, 2022, 2:53:00 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217444,'14456812-2400-4408-b794-ffc165177a1a',TO_TIMESTAMP('2022-09-01 14:52:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:52:59','YYYY-MM-DD HH24:MI:SS'),100,200222,'M_InOut_CreateFrom_v2_ID','l.c_invoiceline_id')
;

-- Sep 1, 2022, 2:53:01 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217445,'946a8936-3499-45ef-9644-2d0b317ac99c',TO_TIMESTAMP('2022-09-01 14:53:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:00','YYYY-MM-DD HH24:MI:SS'),100,200222,'AD_Client_ID','l.ad_client_id')
;

-- Sep 1, 2022, 2:53:02 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217446,'df825a0f-cefd-4695-b154-4ada43a7b3bd',TO_TIMESTAMP('2022-09-01 14:53:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:01','YYYY-MM-DD HH24:MI:SS'),100,200222,'AD_Org_ID','l.ad_org_id')
;

-- Sep 1, 2022, 2:53:03 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217447,'b90d43ba-d1a5-4d5d-86f8-7faa80224712',TO_TIMESTAMP('2022-09-01 14:53:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:02','YYYY-MM-DD HH24:MI:SS'),100,200222,'IsActive','l.isactive')
;

-- Sep 1, 2022, 2:53:03 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217448,'0b8d7f86-70e3-4269-b6e1-c16d90ac61b3',TO_TIMESTAMP('2022-09-01 14:53:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:03','YYYY-MM-DD HH24:MI:SS'),100,200222,'UPC','p.upc')
;

-- Sep 1, 2022, 2:53:04 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217449,'a582384b-4a8a-4ca6-9ed7-1b24c777fdce',TO_TIMESTAMP('2022-09-01 14:53:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:03','YYYY-MM-DD HH24:MI:SS'),100,200222,'M_Warehouse_ID','0')
;

-- Sep 1, 2022, 2:53:05 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217450,'63e4805d-e4c5-4ed9-aedc-a8a88f9e5793',TO_TIMESTAMP('2022-09-01 14:53:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:04','YYYY-MM-DD HH24:MI:SS'),100,200222,'IsSOTrx','inv.issotrx')
;

-- Sep 1, 2022, 2:53:06 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217451,'5835309b-e3b3-4366-b944-cc6698269fcb',TO_TIMESTAMP('2022-09-01 14:53:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:05','YYYY-MM-DD HH24:MI:SS'),100,200222,'AD_Table_ID','333')
;

-- Sep 1, 2022, 2:53:07 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200223,'a162e603-9a64-4296-9d1b-ddcba2cdbd84',TO_TIMESTAMP('2022-09-01 14:53:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','RMA Lines with Shipment/Receipt Line',TO_TIMESTAMP('2022-09-01 14:53:06','YYYY-MM-DD HH24:MI:SS'),100,200355,30,'WHERE rl.m_inoutline_id IS NOT NULL','FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_inoutline iol ON rl.m_inoutline_id = iol.m_inoutline_id
     LEFT JOIN m_product p ON p.m_product_id = iol.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = COALESCE(p.c_uom_id, iol.c_uom_id)
     LEFT JOIN c_charge c ON c.c_charge_id = iol.c_charge_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id','N')
;

-- Sep 1, 2022, 2:53:07 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217452,'d7c3022e-070d-4c04-89b6-ef8c313a2ccf',TO_TIMESTAMP('2022-09-01 14:53:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:07','YYYY-MM-DD HH24:MI:SS'),100,200223,'Qty','rl.qty - rl.qtydelivered')
;

-- Sep 1, 2022, 2:53:08 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217453,'904b576e-0d43-470f-b961-81e264e43b54',TO_TIMESTAMP('2022-09-01 14:53:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:08','YYYY-MM-DD HH24:MI:SS'),100,200223,'Multiplier','1')
;

-- Sep 1, 2022, 2:53:09 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217454,'b257636d-a5d9-4fca-b05f-5386827811c5',TO_TIMESTAMP('2022-09-01 14:53:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:08','YYYY-MM-DD HH24:MI:SS'),100,200223,'C_UOM_ID','uom.c_uom_id')
;

-- Sep 1, 2022, 2:53:10 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217455,'eaa9d299-eab4-4fe5-a4aa-680af4d3a1ce',TO_TIMESTAMP('2022-09-01 14:53:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:09','YYYY-MM-DD HH24:MI:SS'),100,200223,'M_Locator_ID','p.m_locator_id')
;

-- Sep 1, 2022, 2:53:11 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217456,'b877a841-4ddd-4896-b7cf-3e59ef74f988',TO_TIMESTAMP('2022-09-01 14:53:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:10','YYYY-MM-DD HH24:MI:SS'),100,200223,'M_Product_ID','p.m_product_id')
;

-- Sep 1, 2022, 2:53:12 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217457,'bdb912e3-ec6b-4f16-8882-7009cb2385b7',TO_TIMESTAMP('2022-09-01 14:53:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:11','YYYY-MM-DD HH24:MI:SS'),100,200223,'C_Charge_ID','c.c_charge_id')
;

-- Sep 1, 2022, 2:53:12 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217458,'50599ba8-22d5-4bdb-bd1d-203ce7c2ae08',TO_TIMESTAMP('2022-09-01 14:53:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:12','YYYY-MM-DD HH24:MI:SS'),100,200223,'VendorProductNo','po.vendorproductno')
;

-- Sep 1, 2022, 2:53:13 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217459,'9e013910-cde0-4048-aa61-a58a9f2b6b5c',TO_TIMESTAMP('2022-09-01 14:53:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:12','YYYY-MM-DD HH24:MI:SS'),100,200223,'Line','rl.line')
;

-- Sep 1, 2022, 2:53:14 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217460,'81d629ea-d06c-44a2-bfdc-dd60eae942ec',TO_TIMESTAMP('2022-09-01 14:53:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:13','YYYY-MM-DD HH24:MI:SS'),100,200223,'C_OrderLine_ID','0')
;

-- Sep 1, 2022, 2:53:15 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217461,'c59d3ce1-4399-4443-a41e-92d31fc0030e',TO_TIMESTAMP('2022-09-01 14:53:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:14','YYYY-MM-DD HH24:MI:SS'),100,200223,'C_InvoiceLine_ID','0')
;

-- Sep 1, 2022, 2:53:16 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217462,'deff49a3-a068-409e-9368-48320b4d84f4',TO_TIMESTAMP('2022-09-01 14:53:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:15','YYYY-MM-DD HH24:MI:SS'),100,200223,'M_RMALine_ID','rl.m_rmaline_id')
;

-- Sep 1, 2022, 2:53:16 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217463,'6bcb04df-6893-44da-9ea0-412a8bd041e1',TO_TIMESTAMP('2022-09-01 14:53:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:16','YYYY-MM-DD HH24:MI:SS'),100,200223,'C_BPartner_ID','r.c_bpartner_id')
;

-- Sep 1, 2022, 2:53:17 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217464,'cb14f346-21aa-4eed-b948-10f23d53bc51',TO_TIMESTAMP('2022-09-01 14:53:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:16','YYYY-MM-DD HH24:MI:SS'),100,200223,'C_Order_ID','0')
;

-- Sep 1, 2022, 2:53:18 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217465,'d91f317e-25d1-4f8e-8788-27f5b9acade5',TO_TIMESTAMP('2022-09-01 14:53:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:17','YYYY-MM-DD HH24:MI:SS'),100,200223,'C_Invoice_ID','0')
;

-- Sep 1, 2022, 2:53:19 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217466,'b2d58de1-cb2d-4513-825d-561d9faf18e0',TO_TIMESTAMP('2022-09-01 14:53:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:18','YYYY-MM-DD HH24:MI:SS'),100,200223,'M_RMA_ID','r.m_rma_id')
;

-- Sep 1, 2022, 2:53:20 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217467,'158a2950-bef9-4987-98a7-0a439a38326f',TO_TIMESTAMP('2022-09-01 14:53:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:19','YYYY-MM-DD HH24:MI:SS'),100,200223,'M_InOut_CreateFrom_v2_ID','rl.m_rmaline_id')
;

-- Sep 1, 2022, 2:53:21 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217468,'7a3eeb71-27f2-4c1a-9f82-1cf854b180ac',TO_TIMESTAMP('2022-09-01 14:53:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:20','YYYY-MM-DD HH24:MI:SS'),100,200223,'AD_Client_ID','rl.ad_client_id')
;

-- Sep 1, 2022, 2:53:21 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217469,'e4b09848-dc6b-47ac-bd52-72d12e0ddece',TO_TIMESTAMP('2022-09-01 14:53:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:21','YYYY-MM-DD HH24:MI:SS'),100,200223,'AD_Org_ID','rl.ad_org_id')
;

-- Sep 1, 2022, 2:53:22 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217470,'8e5e60f6-a02e-49b6-a420-7f6d01b012bd',TO_TIMESTAMP('2022-09-01 14:53:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:21','YYYY-MM-DD HH24:MI:SS'),100,200223,'IsActive','rl.isactive')
;

-- Sep 1, 2022, 2:53:23 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217471,'0fadfb65-cff9-4f00-a43f-242768330a4d',TO_TIMESTAMP('2022-09-01 14:53:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:22','YYYY-MM-DD HH24:MI:SS'),100,200223,'UPC','p.upc')
;

-- Sep 1, 2022, 2:53:24 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217472,'a5c283cd-7f9b-4a76-9560-5893662d206f',TO_TIMESTAMP('2022-09-01 14:53:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:23','YYYY-MM-DD HH24:MI:SS'),100,200223,'M_Warehouse_ID','0')
;

-- Sep 1, 2022, 2:53:25 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217473,'46c94b21-6aa7-4c63-a497-731c45f3474a',TO_TIMESTAMP('2022-09-01 14:53:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:24','YYYY-MM-DD HH24:MI:SS'),100,200223,'IsSOTrx','r.issotrx')
;

-- Sep 1, 2022, 2:53:25 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217474,'a8891baa-bd27-4fa0-8d05-0da69e8d4cc8',TO_TIMESTAMP('2022-09-01 14:53:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:25','YYYY-MM-DD HH24:MI:SS'),100,200223,'AD_Table_ID','660')
;

-- Sep 1, 2022, 2:53:26 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200224,'da315b7b-a0b0-4f42-a8b6-76d449b94008',TO_TIMESTAMP('2022-09-01 14:53:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','RMA Lines without Shipment/Receipt Line - Product',TO_TIMESTAMP('2022-09-01 14:53:25','YYYY-MM-DD HH24:MI:SS'),100,200355,40,'WHERE rl.m_product_id IS NOT NULL AND rl.m_inoutline_id IS NULL','FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_product p ON p.m_product_id = rl.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = p.c_uom_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id','N')
;

-- Sep 1, 2022, 2:53:27 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217475,'87b9d6cc-afca-4a9a-a1d3-eb5e016f102c',TO_TIMESTAMP('2022-09-01 14:53:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:26','YYYY-MM-DD HH24:MI:SS'),100,200224,'Qty','rl.qty - rl.qtydelivered')
;

-- Sep 1, 2022, 2:53:28 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217476,'f3f1e637-abb3-4620-8ad6-8275202f2336',TO_TIMESTAMP('2022-09-01 14:53:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:27','YYYY-MM-DD HH24:MI:SS'),100,200224,'Multiplier','1')
;

-- Sep 1, 2022, 2:53:29 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217477,'91d4898b-4c7d-447a-b42c-e565a5deeb3b',TO_TIMESTAMP('2022-09-01 14:53:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:28','YYYY-MM-DD HH24:MI:SS'),100,200224,'C_UOM_ID','uom.c_uom_id')
;

-- Sep 1, 2022, 2:53:29 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217478,'df007b52-fce4-495f-afc5-7b018f14f5aa',TO_TIMESTAMP('2022-09-01 14:53:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:29','YYYY-MM-DD HH24:MI:SS'),100,200224,'M_Locator_ID','p.m_locator_id')
;

-- Sep 1, 2022, 2:53:30 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217479,'7d328653-731d-4d21-a18d-98012a675514',TO_TIMESTAMP('2022-09-01 14:53:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:30','YYYY-MM-DD HH24:MI:SS'),100,200224,'M_Product_ID','p.m_product_id')
;

-- Sep 1, 2022, 2:53:31 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217480,'79df7d2a-6998-403d-af1b-e44c12786bd4',TO_TIMESTAMP('2022-09-01 14:53:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:30','YYYY-MM-DD HH24:MI:SS'),100,200224,'C_Charge_ID','0')
;

-- Sep 1, 2022, 2:53:32 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217481,'6f49c3fd-57ed-499c-848f-5b9ba145d4b1',TO_TIMESTAMP('2022-09-01 14:53:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:31','YYYY-MM-DD HH24:MI:SS'),100,200224,'VendorProductNo','po.vendorproductno')
;

-- Sep 1, 2022, 2:53:33 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217482,'291b3b58-2a68-4ac4-b44b-d314bd4f98e3',TO_TIMESTAMP('2022-09-01 14:53:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:32','YYYY-MM-DD HH24:MI:SS'),100,200224,'Line','rl.line')
;

-- Sep 1, 2022, 2:53:34 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217483,'f67974a3-57a2-4e4c-b1c7-cdd0388497b2',TO_TIMESTAMP('2022-09-01 14:53:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:33','YYYY-MM-DD HH24:MI:SS'),100,200224,'C_OrderLine_ID','0')
;

-- Sep 1, 2022, 2:53:34 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217484,'99936144-9e9f-4e0c-90c9-8b5724e33616',TO_TIMESTAMP('2022-09-01 14:53:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:34','YYYY-MM-DD HH24:MI:SS'),100,200224,'C_InvoiceLine_ID','0')
;

-- Sep 1, 2022, 2:53:35 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217485,'afa8daa1-8305-4de4-b5e5-1dd54a9e06b9',TO_TIMESTAMP('2022-09-01 14:53:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:35','YYYY-MM-DD HH24:MI:SS'),100,200224,'M_RMALine_ID','rl.m_rmaline_id')
;

-- Sep 1, 2022, 2:53:36 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217486,'f4bdf2d7-03c4-4866-bae9-37d0e9cae8e2',TO_TIMESTAMP('2022-09-01 14:53:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:35','YYYY-MM-DD HH24:MI:SS'),100,200224,'C_BPartner_ID','r.c_bpartner_id')
;

-- Sep 1, 2022, 2:53:37 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217487,'c1bf9e0a-e1d2-43be-b702-ab98a5d2f3ef',TO_TIMESTAMP('2022-09-01 14:53:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:36','YYYY-MM-DD HH24:MI:SS'),100,200224,'C_Order_ID','0')
;

-- Sep 1, 2022, 2:53:38 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217488,'522b5f3c-d433-43ea-b53a-d831383d6ca2',TO_TIMESTAMP('2022-09-01 14:53:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:37','YYYY-MM-DD HH24:MI:SS'),100,200224,'C_Invoice_ID','0')
;

-- Sep 1, 2022, 2:53:39 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217489,'f31200cf-0c3e-4121-b4a6-0174161fb374',TO_TIMESTAMP('2022-09-01 14:53:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:38','YYYY-MM-DD HH24:MI:SS'),100,200224,'M_RMA_ID','r.m_rma_id')
;

-- Sep 1, 2022, 2:53:39 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217490,'2e94b6ef-ba4b-4095-837e-a7a285997d69',TO_TIMESTAMP('2022-09-01 14:53:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:39','YYYY-MM-DD HH24:MI:SS'),100,200224,'M_InOut_CreateFrom_v2_ID','rl.m_rmaline_id')
;

-- Sep 1, 2022, 2:53:40 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217491,'acd7c86a-c549-4fc0-a5f7-b2019dadca78',TO_TIMESTAMP('2022-09-01 14:53:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:39','YYYY-MM-DD HH24:MI:SS'),100,200224,'AD_Client_ID','rl.ad_client_id')
;

-- Sep 1, 2022, 2:53:41 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217492,'110bf6ef-5d3a-496e-8445-0bf46d78ea74',TO_TIMESTAMP('2022-09-01 14:53:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:40','YYYY-MM-DD HH24:MI:SS'),100,200224,'AD_Org_ID','rl.ad_org_id')
;

-- Sep 1, 2022, 2:53:42 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217493,'313f5799-c8c1-4097-952c-e21cb917af2f',TO_TIMESTAMP('2022-09-01 14:53:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:41','YYYY-MM-DD HH24:MI:SS'),100,200224,'IsActive','rl.isactive')
;

-- Sep 1, 2022, 2:53:43 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217494,'f5448bd9-6ab6-4cc9-a99f-a7ffe31c8971',TO_TIMESTAMP('2022-09-01 14:53:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:42','YYYY-MM-DD HH24:MI:SS'),100,200224,'UPC','p.upc')
;

-- Sep 1, 2022, 2:53:43 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217495,'277915d1-6d75-4450-9d8a-66c2afb97506',TO_TIMESTAMP('2022-09-01 14:53:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:43','YYYY-MM-DD HH24:MI:SS'),100,200224,'M_Warehouse_ID','0')
;

-- Sep 1, 2022, 2:53:44 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217496,'60f5768c-bdc9-4ff3-bfb3-6be7967d4639',TO_TIMESTAMP('2022-09-01 14:53:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:43','YYYY-MM-DD HH24:MI:SS'),100,200224,'IsSOTrx','r.issotrx')
;

-- Sep 1, 2022, 2:53:45 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217497,'f5bb3c43-2964-4c93-bb7b-4d91b83d4a60',TO_TIMESTAMP('2022-09-01 14:53:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:44','YYYY-MM-DD HH24:MI:SS'),100,200224,'AD_Table_ID','660')
;

-- Sep 1, 2022, 2:53:46 PM SGT
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200225,'461a153d-b1fd-4eae-bf6d-513cf636e55c',TO_TIMESTAMP('2022-09-01 14:53:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','RMA Lines without Shipment/Receipt Line - Charge',TO_TIMESTAMP('2022-09-01 14:53:45','YYYY-MM-DD HH24:MI:SS'),100,200355,50,'WHERE rl.c_charge_id IS NOT NULL AND rl.m_inoutline_id IS NULL','FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN c_charge c ON c.c_charge_id = rl.c_charge_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = 100','N')
;

-- Sep 1, 2022, 2:53:47 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217498,'6bad5050-4857-48de-a532-0cddc5b885da',TO_TIMESTAMP('2022-09-01 14:53:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:46','YYYY-MM-DD HH24:MI:SS'),100,200225,'Qty','rl.qty - rl.qtydelivered')
;

-- Sep 1, 2022, 2:53:48 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217499,'db66ed01-033b-46de-9b52-154bb0b43c00',TO_TIMESTAMP('2022-09-01 14:53:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:47','YYYY-MM-DD HH24:MI:SS'),100,200225,'Multiplier','1')
;

-- Sep 1, 2022, 2:53:48 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217500,'62129115-5593-4d25-882a-711b06d80264',TO_TIMESTAMP('2022-09-01 14:53:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:48','YYYY-MM-DD HH24:MI:SS'),100,200225,'C_UOM_ID','uom.c_uom_id')
;

-- Sep 1, 2022, 2:53:49 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217501,'559fb16a-fb2a-4c31-addf-8f04e1d2621c',TO_TIMESTAMP('2022-09-01 14:53:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:48','YYYY-MM-DD HH24:MI:SS'),100,200225,'M_Locator_ID','0')
;

-- Sep 1, 2022, 2:53:50 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217502,'19eb0d6d-ab7d-4455-9396-5115328ca636',TO_TIMESTAMP('2022-09-01 14:53:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:49','YYYY-MM-DD HH24:MI:SS'),100,200225,'M_Product_ID','0')
;

-- Sep 1, 2022, 2:53:51 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217503,'df41c828-0fcb-402b-8389-a694ac24b862',TO_TIMESTAMP('2022-09-01 14:53:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:50','YYYY-MM-DD HH24:MI:SS'),100,200225,'C_Charge_ID','c.c_charge_id')
;

-- Sep 1, 2022, 2:53:52 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217504,'530e2c6a-108c-42bd-b606-cdefce6552b3',TO_TIMESTAMP('2022-09-01 14:53:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:51','YYYY-MM-DD HH24:MI:SS'),100,200225,'VendorProductNo','NULL')
;

-- Sep 1, 2022, 2:53:52 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217505,'82d91937-23fc-4920-aa40-4e07866adefe',TO_TIMESTAMP('2022-09-01 14:53:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:52','YYYY-MM-DD HH24:MI:SS'),100,200225,'Line','rl.line')
;

-- Sep 1, 2022, 2:53:53 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217506,'055b330c-f947-4fe5-91af-9f071f4c0c1f',TO_TIMESTAMP('2022-09-01 14:53:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:52','YYYY-MM-DD HH24:MI:SS'),100,200225,'C_OrderLine_ID','0')
;

-- Sep 1, 2022, 2:53:54 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217507,'dba5028d-5479-4307-a57b-04278e0e2b4b',TO_TIMESTAMP('2022-09-01 14:53:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:53','YYYY-MM-DD HH24:MI:SS'),100,200225,'C_InvoiceLine_ID','0')
;

-- Sep 1, 2022, 2:53:55 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217508,'18f3988e-b7dd-4acf-a620-1eba625d18e2',TO_TIMESTAMP('2022-09-01 14:53:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:54','YYYY-MM-DD HH24:MI:SS'),100,200225,'M_RMALine_ID','rl.m_rmaline_id')
;

-- Sep 1, 2022, 2:53:56 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217509,'af6489d0-9885-4977-8275-102657477d22',TO_TIMESTAMP('2022-09-01 14:53:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:55','YYYY-MM-DD HH24:MI:SS'),100,200225,'C_BPartner_ID','r.c_bpartner_id')
;

-- Sep 1, 2022, 2:53:56 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217510,'dca0d215-274b-4596-b932-fc13a55a255d',TO_TIMESTAMP('2022-09-01 14:53:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:56','YYYY-MM-DD HH24:MI:SS'),100,200225,'C_Order_ID','0')
;

-- Sep 1, 2022, 2:53:57 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217511,'d34d3eff-52f2-4065-b31b-255507d18925',TO_TIMESTAMP('2022-09-01 14:53:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:56','YYYY-MM-DD HH24:MI:SS'),100,200225,'C_Invoice_ID','0')
;

-- Sep 1, 2022, 2:53:58 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217512,'df358d14-c13f-4154-8a0f-9ad879c2d534',TO_TIMESTAMP('2022-09-01 14:53:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:57','YYYY-MM-DD HH24:MI:SS'),100,200225,'M_RMA_ID','r.m_rma_id')
;

-- Sep 1, 2022, 2:53:59 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217513,'d0d1a667-98ff-42c8-90e7-2d1aee16abb8',TO_TIMESTAMP('2022-09-01 14:53:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:58','YYYY-MM-DD HH24:MI:SS'),100,200225,'M_InOut_CreateFrom_v2_ID','rl.m_rmaline_id')
;

-- Sep 1, 2022, 2:54:00 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217514,'6566e660-33c3-40b1-866e-b7a06d13302d',TO_TIMESTAMP('2022-09-01 14:53:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:53:59','YYYY-MM-DD HH24:MI:SS'),100,200225,'AD_Client_ID','rl.ad_client_id')
;

-- Sep 1, 2022, 2:54:00 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217515,'e59ef87b-549b-476e-8d09-995f8785c62f',TO_TIMESTAMP('2022-09-01 14:54:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:54:00','YYYY-MM-DD HH24:MI:SS'),100,200225,'AD_Org_ID','rl.ad_org_id')
;

-- Sep 1, 2022, 2:54:01 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217516,'30e3dd15-2229-43a2-917e-2b99e3730db6',TO_TIMESTAMP('2022-09-01 14:54:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:54:01','YYYY-MM-DD HH24:MI:SS'),100,200225,'IsActive','rl.isactive')
;

-- Sep 1, 2022, 2:54:02 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217517,'291bd77a-2724-461c-bf3c-4b5453993afb',TO_TIMESTAMP('2022-09-01 14:54:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:54:01','YYYY-MM-DD HH24:MI:SS'),100,200225,'UPC','NULL')
;

-- Sep 1, 2022, 2:54:03 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217518,'d557f631-462d-4589-8d49-b36752b7b7ff',TO_TIMESTAMP('2022-09-01 14:54:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:54:02','YYYY-MM-DD HH24:MI:SS'),100,200225,'M_Warehouse_ID','0')
;

-- Sep 1, 2022, 2:54:04 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217519,'e2932715-861b-4bc8-a854-b2483f2efebb',TO_TIMESTAMP('2022-09-01 14:54:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:54:03','YYYY-MM-DD HH24:MI:SS'),100,200225,'IsSOTrx','r.issotrx')
;

-- Sep 1, 2022, 2:54:05 PM SGT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL) VALUES (0,0,217520,'deb2deb9-0cde-478f-91bc-5744f0059d30',TO_TIMESTAMP('2022-09-01 14:54:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-01 14:54:04','YYYY-MM-DD HH24:MI:SS'),100,200225,'AD_Table_ID','660')
;

-- Sep 1, 2022, 2:55:42 PM SGT
UPDATE AD_ViewColumn SET ColumnName='M_InOut_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-01 14:55:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217421
;

-- Sep 1, 2022, 2:56:07 PM SGT
UPDATE AD_ViewColumn SET ColumnName='M_InOut_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-01 14:56:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217444
;

-- Sep 1, 2022, 2:56:23 PM SGT
UPDATE AD_ViewColumn SET ColumnName='M_InOut_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-01 14:56:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217467
;

-- Sep 1, 2022, 2:56:45 PM SGT
UPDATE AD_ViewColumn SET ColumnName='M_InOut_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-01 14:56:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217490
;

-- Sep 1, 2022, 2:57:08 PM SGT
UPDATE AD_ViewColumn SET ColumnName='M_InOut_CreateFrom_v_ID',Updated=TO_TIMESTAMP('2022-09-01 14:57:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217513
;

-- Sep 1, 2022, 2:58:28 PM SGT
CREATE OR REPLACE VIEW M_InOut_CreateFrom_v(Qty, Multiplier, C_UOM_ID, M_Locator_ID, M_Product_ID, C_Charge_ID, VendorProductNo, Line, C_OrderLine_ID, C_InvoiceLine_ID, M_RMALine_ID, C_BPartner_ID, C_Order_ID, C_Invoice_ID, M_RMA_ID, M_InOut_CreateFrom_v_ID, AD_Client_ID, AD_Org_ID, IsActive, UPC, M_Warehouse_ID, IsSOTrx, AD_Table_ID) 
AS SELECT l.qtyordered - sum(COALESCE(m.qty, 0)) - COALESCE(( SELECT sum(iol.movementqty) AS sum FROM m_inoutline iol JOIN m_inout io ON iol.m_inout_id = io.m_inout_id           WHERE l.c_orderline_id = iol.c_orderline_id AND io.processed = 'N'), 0) AS Qty, 
CASE WHEN l.qtyordered = 0 THEN 0 ELSE l.qtyentered / l.qtyordered END AS Multiplier, l.c_uom_id AS C_UOM_ID, p.m_locator_id AS M_Locator_ID, COALESCE(l.m_product_id, 0) AS M_Product_ID, COALESCE(l.c_charge_id, 0) AS C_Charge_ID, 
po.vendorproductno AS VendorProductNo, l.line AS Line, l.c_orderline_id AS C_OrderLine_ID, 0 AS C_InvoiceLine_ID, 0 AS M_RMALine_ID, l.c_bpartner_id AS C_BPartner_ID, l.c_order_id AS C_Order_ID, 0 AS C_Invoice_ID, 0 AS M_RMA_ID,
 l.c_orderline_id AS M_InOut_CreateFrom_v_ID, l.ad_client_id AS AD_Client_ID, l.ad_org_id AS AD_Org_ID, l.isactive AS IsActive, p.upc AS UPC, o.m_warehouse_id AS M_Warehouse_ID, o.issotrx AS IsSOTrx, 260 AS AD_Table_ID 
 FROM c_orderline l
     JOIN c_order o ON o.c_order_id = l.c_order_id
     LEFT JOIN m_product_po po ON l.m_product_id = po.m_product_id AND l.c_bpartner_id = po.c_bpartner_id
     LEFT JOIN m_matchpo m ON l.c_orderline_id = m.c_orderline_id AND m.m_inoutline_id IS NOT NULL
     LEFT JOIN m_product p ON l.m_product_id = p.m_product_id 
  GROUP BY l.qtyordered, (
        CASE
            WHEN l.qtyordered = 0 THEN 0
            ELSE l.qtyentered / l.qtyordered
        END), 
l.c_uom_id, p.m_locator_id, po.vendorproductno, l.m_product_id, l.c_charge_id, l.line, l.c_orderline_id, p.upc,o.m_warehouse_id,o.issotrx ,
l.c_bpartner_id,l.c_order_id,l.ad_client_id,l.ad_org_id,l.IsActive
UNION SELECT l.qtyinvoiced - sum(nvl(mi.qty, 0)) AS Qty, l.qtyentered / l.qtyinvoiced AS Multiplier, l.c_uom_id AS C_UOM_ID, p.m_locator_id AS M_Locator_ID, l.m_product_id AS M_Product_ID, l.c_charge_id AS C_Charge_ID, 
po.vendorproductno AS VendorProductNo, l.line AS Line, l.c_orderline_id AS C_OrderLine_ID, l.c_invoiceline_id AS C_InvoiceLine_ID, 0 AS M_RMALine_ID, inv.c_bpartner_id AS C_BPartner_ID, 0 AS C_Order_ID, l.c_invoice_id AS C_Invoice_ID, 
0 AS M_RMA_ID, l.c_invoiceline_id AS M_InOut_CreateFrom_v_ID, l.ad_client_id AS AD_Client_ID, l.ad_org_id AS AD_Org_ID, l.isactive AS IsActive, p.upc AS UPC, 0 AS M_Warehouse_ID, inv.issotrx AS IsSOTrx, 333 AS AD_Table_ID 
FROM c_invoiceline l
     LEFT JOIN m_product p ON l.m_product_id = p.m_product_id
     JOIN c_invoice inv ON l.c_invoice_id = inv.c_invoice_id
     LEFT JOIN m_product_po po ON l.m_product_id = po.m_product_id AND inv.c_bpartner_id = po.c_bpartner_id
     LEFT JOIN m_matchinv mi ON l.c_invoiceline_id = mi.c_invoiceline_id WHERE l.qtyinvoiced <> 0 
   GROUP BY l.qtyinvoiced, (l.qtyentered / l.qtyinvoiced), l.c_uom_id, p.m_locator_id, l.m_product_id, l.c_charge_id, po.vendorproductno, l.c_invoiceline_id, l.line, l.c_orderline_id, inv.c_bpartner_id, l.c_invoice_id, p.upc, inv.issotrx ,
   l.ad_client_id,l.ad_org_id,l.IsActive
   UNION SELECT rl.qty - rl.qtydelivered AS Qty, 1 AS Multiplier, uom.c_uom_id AS C_UOM_ID, p.m_locator_id AS M_Locator_ID, p.m_product_id AS M_Product_ID, c.c_charge_id AS C_Charge_ID, po.vendorproductno AS VendorProductNo, rl.line AS Line, 
   0 AS C_OrderLine_ID, 0 AS C_InvoiceLine_ID, rl.m_rmaline_id AS M_RMALine_ID, r.c_bpartner_id AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS C_Invoice_ID, r.m_rma_id AS M_RMA_ID, rl.m_rmaline_id AS M_InOut_CreateFrom_v_ID, rl.ad_client_id AS AD_Client_ID, 
   rl.ad_org_id AS AD_Org_ID, rl.isactive AS IsActive, p.upc AS UPC, 0 AS M_Warehouse_ID, r.issotrx AS IsSOTrx, 660 AS AD_Table_ID 
   FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_inoutline iol ON rl.m_inoutline_id = iol.m_inoutline_id
     LEFT JOIN m_product p ON p.m_product_id = iol.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = COALESCE(p.c_uom_id, iol.c_uom_id)
     LEFT JOIN c_charge c ON c.c_charge_id = iol.c_charge_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_inoutline_id IS NOT NULL 
   UNION SELECT rl.qty - rl.qtydelivered AS Qty, 1 AS Multiplier, uom.c_uom_id AS C_UOM_ID, p.m_locator_id AS M_Locator_ID, p.m_product_id AS M_Product_ID, 0 AS C_Charge_ID, po.vendorproductno AS VendorProductNo, rl.line AS Line, 
   0 AS C_OrderLine_ID, 0 AS C_InvoiceLine_ID, rl.m_rmaline_id AS M_RMALine_ID, r.c_bpartner_id AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS C_Invoice_ID, r.m_rma_id AS M_RMA_ID, rl.m_rmaline_id AS M_InOut_CreateFrom_v_ID, rl.ad_client_id AS AD_Client_ID, 
   rl.ad_org_id AS AD_Org_ID, rl.isactive AS IsActive, p.upc AS UPC, 0 AS M_Warehouse_ID, r.issotrx AS IsSOTrx, 660 AS AD_Table_ID 
   FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_product p ON p.m_product_id = rl.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = p.c_uom_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_product_id IS NOT NULL AND rl.m_inoutline_id IS NULL 
    UNION SELECT rl.qty - rl.qtydelivered AS Qty, 1 AS Multiplier, uom.c_uom_id AS C_UOM_ID, 0 AS M_Locator_ID, 0 AS M_Product_ID, c.c_charge_id AS C_Charge_ID, NULL AS VendorProductNo, rl.line AS Line, 0 AS C_OrderLine_ID, 0 AS C_InvoiceLine_ID, 
    rl.m_rmaline_id AS M_RMALine_ID, r.c_bpartner_id AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS C_Invoice_ID, r.m_rma_id AS M_RMA_ID, rl.m_rmaline_id AS M_InOut_CreateFrom_v_ID, rl.ad_client_id AS AD_Client_ID, rl.ad_org_id AS AD_Org_ID, rl.isactive AS IsActive, 
    NULL AS UPC, 0 AS M_Warehouse_ID, r.issotrx AS IsSOTrx, 660 AS AD_Table_ID 
    FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN c_charge c ON c.c_charge_id = rl.c_charge_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = 100 WHERE rl.c_charge_id IS NOT NULL AND rl.m_inoutline_id IS NULL
;

-- Sep 1, 2022, 3:00:50 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215102,0.0,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',200355,'Qty',14,'N','N','N','N','N','N',29,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:00:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:00:49','YYYY-MM-DD HH24:MI:SS'),100,526,'N','N','D','N','b595b973-4d7a-409c-bc9a-f285c357acf7','N')
;

-- Sep 1, 2022, 3:00:51 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215103,0.0,'Multiplier','Type Multiplier (Credit = -1)',200355,'Multiplier',14,'N','N','N','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:00:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:00:50','YYYY-MM-DD HH24:MI:SS'),100,1525,'N','N','D','N','7ec0d959-a90e-4365-a9b4-73430faf62f2','N','N')
;

-- Sep 1, 2022, 3:00:52 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215104,0.0,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',200355,'C_UOM_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:00:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:00:51','YYYY-MM-DD HH24:MI:SS'),100,215,'N','N','D','N','aeb74338-59e2-4ee8-a9a7-1c26915f79ca','N','N')
;

-- Sep 1, 2022, 3:00:53 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215105,0.0,'Locator','Warehouse Locator','The Locator indicates where in a Warehouse a product is located.',200355,'M_Locator_ID',10,'N','N','N','N','N','N',31,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:00:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:00:52','YYYY-MM-DD HH24:MI:SS'),100,448,'N','N','D','N','aaff01fe-5a0c-41b3-849d-0eaffb139972','N')
;

-- Sep 1, 2022, 3:00:54 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215106,0.0,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200355,231,'M_Product_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:00:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:00:53','YYYY-MM-DD HH24:MI:SS'),100,454,'N','N','D','N','b3a5daef-e654-4869-ae3d-aed395ae837b','N','N')
;

-- Sep 1, 2022, 3:00:56 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215107,0.0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',200355,'C_Charge_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:00:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:00:54','YYYY-MM-DD HH24:MI:SS'),100,968,'N','N','D','N','493827f9-009e-4aa5-8d80-cbdbc1dded5f','N')
;

-- Sep 1, 2022, 3:00:57 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215108,0.0,'Partner Product Key','Product Key of the Business Partner','The Business Partner Product Key identifies the number used by the Business Partner for this product. It can be printed on orders and invoices when you include the Product Key in the print format.',200355,'VendorProductNo',2147483647,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:00:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:00:56','YYYY-MM-DD HH24:MI:SS'),100,623,'N','N','D','N','e2728f9c-cf89-4806-89ce-73b4cf90690f','N')
;

-- Sep 1, 2022, 3:00:58 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215109,0.0,'Line No','Unique line for this document','Indicates the unique line for a document.  It will also control the display order of the lines within a document.',200355,'Line',10,'N','N','N','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:00:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:00:57','YYYY-MM-DD HH24:MI:SS'),100,439,'N','N','D','N','1d8cc788-efe4-4a05-8829-9473aebeea7e','N')
;

-- Sep 1, 2022, 3:00:59 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215110,0.0,'Sales Order Line','Sales Order Line','The Sales Order Line is a unique identifier for a line in an order.',200355,'C_OrderLine_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:00:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:00:58','YYYY-MM-DD HH24:MI:SS'),100,561,'N','N','D','N','14d68fb7-718d-42c6-9454-435a0acb970e','N')
;

-- Sep 1, 2022, 3:01:00 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215111,0.0,'Invoice Line','Invoice Detail Line','The Invoice Line uniquely identifies a single line of an Invoice.',200355,'C_InvoiceLine_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:00:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:00:59','YYYY-MM-DD HH24:MI:SS'),100,1076,'N','N','D','N','6afc501c-20d5-4df9-b442-1a50e603e7be','N','N')
;

-- Sep 1, 2022, 3:01:01 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215112,0.0,'RMA Line','Return Material Authorization Line','Detail information about the returned goods',200355,'M_RMALine_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:00','YYYY-MM-DD HH24:MI:SS'),100,2413,'N','N','D','N','13972f87-f6a9-42ee-822a-8e9161bf08f4','N')
;

-- Sep 1, 2022, 3:01:02 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215113,0.0,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200355,'C_BPartner_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:01','YYYY-MM-DD HH24:MI:SS'),100,187,'N','N','D','N','2df5c871-8154-475d-b9a6-213d6ee8da5e','N')
;

-- Sep 1, 2022, 3:01:03 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215114,0.0,'Order','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.',200355,'C_Order_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:02','YYYY-MM-DD HH24:MI:SS'),100,558,'N','N','D','N','5db5c785-c622-4abe-9733-3a0e460441cb','N')
;

-- Sep 1, 2022, 3:01:04 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215115,0.0,'Invoice','Invoice Identifier','The Invoice Document.',200355,'C_Invoice_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:03','YYYY-MM-DD HH24:MI:SS'),100,1008,'N','N','D','N','91bb742b-ae6e-4b24-84fc-e807fac631dc','N')
;

-- Sep 1, 2022, 3:01:05 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215116,0.0,'RMA','Return Material Authorization','A Return Material Authorization may be required to accept returns and to create Credit Memos',200355,'M_RMA_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:04','YYYY-MM-DD HH24:MI:SS'),100,2412,'N','N','D','N','1cfd103d-7f66-4b74-af40-7e847f520abd','N')
;

-- Sep 1, 2022, 3:01:06 PM SGT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203637,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:05','YYYY-MM-DD HH24:MI:SS'),100,'M_InOut_CreateFrom_v_ID','M_InOut_CreateFrom_v','M_InOut_CreateFrom_v','D','d8a8287a-baef-4087-a77c-82884d46c7a0')
;

-- Sep 1, 2022, 3:01:07 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215117,0.0,'M_InOut_CreateFrom_v',200355,'M_InOut_CreateFrom_v_ID',10,'Y','N','N','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:05','YYYY-MM-DD HH24:MI:SS'),100,203637,'N','N','D','N','5140a32e-01cb-43c7-ac6c-26759ca2ecbd','N')
;

-- Sep 1, 2022, 3:01:08 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215118,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200355,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:07','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','ed638416-fa4c-4438-89c5-8d1a02df4e4e','N','D')
;

-- Sep 1, 2022, 3:01:09 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215119,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200355,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:08','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','ba416009-bffd-44d3-8f07-f8e4513df38b','N','D')
;

-- Sep 1, 2022, 3:01:10 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215120,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200355,'IsActive','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:09','YYYY-MM-DD HH24:MI:SS'),100,348,'N','N','D','N','5d9ce703-8af6-491f-8df1-344837540a03','N')
;

-- Sep 1, 2022, 3:01:11 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215121,0.0,'UPC/EAN','Bar Code (Universal Product Code or its superset European Article Number)','Use this field to enter the bar code for the product in any of the bar code symbologies (Codabar, Code 25, Code 39, Code 93, Code 128, UPC (A), UPC (E), EAN-13, EAN-8, ITF, ITF-14, ISBN, ISSN, JAN-13, JAN-8, POSTNET and FIM, MSI/Plessey, and Pharmacode) ',200355,'UPC',2147483647,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:10','YYYY-MM-DD HH24:MI:SS'),100,603,'N','N','D','N','45469c81-323d-4343-b71e-de875bc8171e','N')
;

-- Sep 1, 2022, 3:01:12 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215122,0.0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200355,'M_Warehouse_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:11','YYYY-MM-DD HH24:MI:SS'),100,459,'N','N','D','N','d47677ef-434e-422d-a71a-2a1410c4380a','N')
;

-- Sep 1, 2022, 3:01:13 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215123,0.0,'Sales Transaction','This is a Sales Transaction','The Sales Transaction checkbox indicates if this item is a Sales Transaction.',200355,'IsSOTrx',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:12','YYYY-MM-DD HH24:MI:SS'),100,1106,'N','N','D','N','3865eab7-8d4a-4cb1-afc9-45f8ae778b2f','N')
;

-- Sep 1, 2022, 3:01:14 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215124,0.0,'Table','Database Table information','The Database Table provides the information of the table definition',200355,'AD_Table_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:01:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:01:13','YYYY-MM-DD HH24:MI:SS'),100,126,'N','N','D','N','2179c393-a55c-40fd-bce6-eab13351edf8','N','N')
;

-- Sep 1, 2022, 3:02:38 PM SGT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200164,'C_Order in M_InOut_CreateFrom_v','S','C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus IN (''CL'',''CO'') 
AND C_Order_ID IN (SELECT C_Order_ID FROM C_OrderLine WHERE QtyOrdered-QtyDelivered!=0) 
AND (CASE WHEN @M_Warehouse_ID@>0 THEN M_Warehouse_ID=@M_Warehouse_ID@ ELSE 1=1 END) ',0,0,'Y',TO_TIMESTAMP('2022-09-01 15:02:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:02:37','YYYY-MM-DD HH24:MI:SS'),100,'D','12919b7f-d9bd-45f4-8b23-4fad6863385c')
;

-- Sep 1, 2022, 3:03:21 PM SGT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200165,'C_Invoice in M_InOut_CreateFrom_v','S','C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus IN (''CL'',''CO'') AND C_Invoice_ID IN (
SELECT il.C_Invoice_ID FROM C_InvoiceLine il 
LEFT OUTER JOIN M_MatchInv mi ON (il.C_InvoiceLine_ID=mi.C_InvoiceLine_ID) 
JOIN C_Invoice i2 ON (il.C_Invoice_ID = i2.C_Invoice_ID) 
WHERE i2.C_BPartner_ID=@C_BPartner_ID@ AND i2.IsSOTrx=''@IsSOTrx@'' AND i2.DocStatus IN (''CL'',''CO'') 
AND il.M_Product_ID IS NOT NULL 
GROUP BY il.C_Invoice_ID,mi.C_InvoiceLine_ID,il.QtyInvoiced 
HAVING (il.QtyInvoiced<>SUM(mi.Qty) AND mi.C_InvoiceLine_ID IS NOT NULL) OR mi.C_InvoiceLine_ID IS NULL) ',0,0,'Y',TO_TIMESTAMP('2022-09-01 15:03:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:03:21','YYYY-MM-DD HH24:MI:SS'),100,'D','b135f397-5fae-424b-9dc6-100de89b7bd7')
;

-- Sep 1, 2022, 3:03:40 PM SGT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200166,'M_RMA in M_InOut_CreateFrom_v','S','C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus in (''CO'', ''CL'') 
AND M_RMA_ID in (SELECT rl.M_RMA_ID FROM M_RMALine rl 
WHERE rl.M_RMA_ID=M_RMA.M_RMA_ID AND rl.QtyDelivered < rl.Qty 
AND rl.M_InOutLine_ID IS NOT NULL)',0,0,'Y',TO_TIMESTAMP('2022-09-01 15:03:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:03:39','YYYY-MM-DD HH24:MI:SS'),100,'D','9140d25d-1676-4f87-8215-7be9379f3274')
;

-- Sep 1, 2022, 3:05:40 PM SGT
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,OrderByClause,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) VALUES (200022,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:05:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:05:40','YYYY-MM-DD HH24:MI:SS'),100,'Create lines from Shipment/Receipt',200355,'D','M_InOut_CreateFrom_v v','N','59c1afd6-d5c4-4afd-9e20-88bb78048923','N','N','v.Line','N',20,'N',0,'Y',0)
;

-- Sep 1, 2022, 3:06:08 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200246,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:07','YYYY-MM-DD HH24:MI:SS'),100,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',200022,'D','v.Qty*v.Multiplier',10,'Y','N',526,29,'14c5f276-2df8-4bf9-9090-72ebb4514710','Y','Qty','=','N',0,'N','N')
;

-- Sep 1, 2022, 3:06:09 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200247,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:09','YYYY-MM-DD HH24:MI:SS'),100,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',200022,'D','v.C_UOM_ID',20,'Y','N',215,19,'596da29d-2009-427b-8d84-fa67e86571f9','Y','C_UOM_ID','=','N',0,'N','Y')
;

-- Sep 1, 2022, 3:06:10 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200248,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:09','YYYY-MM-DD HH24:MI:SS'),100,'Locator','Warehouse Locator','The Locator indicates where in a Warehouse a product is located.',200022,'D','v.M_Locator_ID',30,'Y','N',448,18,'9f223d61-c4e9-4a07-abd2-5c7191fca284',191,'Y','M_Locator_ID','=','N',0,'N','Y')
;

-- Sep 1, 2022, 3:06:11 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200249,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:10','YYYY-MM-DD HH24:MI:SS'),100,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200022,'D','v.M_Product_ID',40,'Y','N',454,19,'1809c465-483c-4707-9cfb-c00424671c44','Y','M_Product_ID','=','N',0,'N','Y')
;

-- Sep 1, 2022, 3:06:12 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200250,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:11','YYYY-MM-DD HH24:MI:SS'),100,'Partner Product Key','Product Key of the Business Partner','The Business Partner Product Key identifies the number used by the Business Partner for this product. It can be printed on orders and invoices when you include the Product Key in the print format.',200022,'D','v.VendorProductNo',50,'Y','N',623,10,'f0c79856-d27b-450d-b148-9844d92f01dd','Y','VendorProductNo','Like','Upper','N',0,'N','Y')
;

-- Sep 1, 2022, 3:06:13 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200251,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:12','YYYY-MM-DD HH24:MI:SS'),100,'Sales Order Line','Sales Order Line','The Sales Order Line is a unique identifier for a line in an order.',200022,'D','v.C_OrderLine_ID',60,'N','N',561,13,'8c30a03e-a484-464b-89b3-712170701868','Y','C_OrderLine_ID','N',0,'N','Y')
;

-- Sep 1, 2022, 3:06:14 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200252,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:13','YYYY-MM-DD HH24:MI:SS'),100,'Line No','Unique line for this document','Indicates the unique line for a document.  It will also control the display order of the lines within a document.',200022,'D','v.Line',70,'N','N',439,11,'9c68247f-3815-4824-a452-0285f5def4d1','Y','Line','=','Y',0,'N','Y')
;

-- Sep 1, 2022, 3:06:15 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsReadOnly) VALUES (200253,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:14','YYYY-MM-DD HH24:MI:SS'),100,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200022,'D','v.C_BPartner_ID',80,'N','Y',187,30,'e345e36b-faaa-4d70-8021-c49289796f2b','Y','C_BPartner_ID','=','N',10,'@C_BPartner_ID@','Y','Y')
;

-- Sep 1, 2022, 3:06:16 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsReadOnly) VALUES (200254,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:15','YYYY-MM-DD HH24:MI:SS'),100,'Order','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.',200022,'D','v.C_Order_ID',90,'Y','Y',558,19,'3de70169-09f4-4861-952d-88757d9daf8c','Y','@MovementType@!''C+'' & @MovementType@!''V-'' & @C_Invoice_ID@=0','C_Order_ID','=','N',20,'@C_Order_ID@','Y','Y')
;

-- Sep 1, 2022, 3:06:17 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsReadOnly) VALUES (200255,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:16','YYYY-MM-DD HH24:MI:SS'),100,'Invoice','Invoice Identifier','The Invoice Document.',200022,'D','v.C_Invoice_ID',100,'Y','Y',1008,19,'7eb42dd5-b1eb-49a0-9c4d-c9de2947c0ba','Y','@MovementType@!''C+'' & @MovementType@!''V-'' & @C_Order_ID@=0','C_Invoice_ID','=','N',30,'@C_Invoice_ID@','Y','Y')
;

-- Sep 1, 2022, 3:06:18 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsReadOnly) VALUES (200256,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:17','YYYY-MM-DD HH24:MI:SS'),100,'RMA','Return Material Authorization','A Return Material Authorization may be required to accept returns and to create Credit Memos',200022,'D','v.M_RMA_ID',110,'Y','Y',2412,19,'d5c2b03a-8b92-4787-a829-1b78aeec534b','Y','@MovementType@=''C+'' | @MovementType@=''V-''','M_RMA_ID','=','N',60,'@M_RMA_ID@','N','Y')
;

-- Sep 1, 2022, 3:06:18 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsReadOnly) VALUES (200257,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:18','YYYY-MM-DD HH24:MI:SS'),100,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200022,'D','v.M_Warehouse_ID',120,'N','Y',459,19,'7b7e6c80-5bd7-4370-81fc-39c6e1bd0a67','Y','@MovementType@!''C+'' & @MovementType@!''V-''','M_Warehouse_ID','=','N',50,'@M_Warehouse_ID@','N','Y')
;

-- Sep 1, 2022, 3:06:19 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200258,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:19','YYYY-MM-DD HH24:MI:SS'),100,'UPC/EAN','Bar Code (Universal Product Code or its superset European Article Number)','Use this field to enter the bar code for the product in any of the bar code symbologies (Codabar, Code 25, Code 39, Code 93, Code 128, UPC (A), UPC (E), EAN-13, EAN-8, ITF, ITF-14, ISBN, ISSN, JAN-13, JAN-8, POSTNET and FIM, MSI/Plessey, and Pharmacode) ',200022,'D','v.UPC',130,'N','Y',603,10,'e8f31c51-2bc1-4595-b7cf-582cda1a45e4','Y','UPC','Like','Upper','N',40,'N','Y')
;

-- Sep 1, 2022, 3:06:20 PM SGT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsReadOnly) VALUES (200259,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:06:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:06:19','YYYY-MM-DD HH24:MI:SS'),100,'Table','Database Table information','The Database Table provides the information of the table definition',200022,'D','v.AD_Table_ID',140,'N','N',126,19,'2c964ec6-16d9-4c25-a213-23ddb8df61c9','Y','AD_Table_ID','N',0,'N','Y')
;

-- Sep 1, 2022, 3:09:00 PM SGT
UPDATE AD_InfoColumn SET AD_Val_Rule_ID=200164,Updated=TO_TIMESTAMP('2022-09-01 15:09:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200254
;

-- Sep 1, 2022, 3:09:09 PM SGT
UPDATE AD_InfoColumn SET AD_Val_Rule_ID=200165,Updated=TO_TIMESTAMP('2022-09-01 15:09:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200255
;

-- Sep 1, 2022, 3:09:20 PM SGT
UPDATE AD_InfoColumn SET AD_Val_Rule_ID=200166,Updated=TO_TIMESTAMP('2022-09-01 15:09:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200256
;

-- Sep 1, 2022, 3:16:32 PM SGT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,AD_Process_UU) VALUES (200141,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:16:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:16:31','YYYY-MM-DD HH24:MI:SS'),100,'Create lines from Shipment/Receipt','Create lines from Shipment/Receipt','N','M_InOut_CreateFromProcess','N','org.compiere.process.CreateFromInOut','1','D',0,0,'N','Y','a937803f-8f37-4a08-90b8-f653f48dd421')
;

-- Sep 1, 2022, 3:17:04 PM SGT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,ReadOnlyLogic,AD_Process_Para_UU) VALUES (200405,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:17:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:17:03','YYYY-MM-DD HH24:MI:SS'),100,'Shipment/Receipt','Material Shipment Document','The Material Shipment / Receipt ',200141,10,30,'N',178,0,'Y','@M_InOut_ID@','M_InOut_ID','Y','D',1025,'@M_InOut_ID@!0','d1a8b414-18cd-4c08-ae30-525128965145')
;

-- Sep 1, 2022, 3:17:05 PM SGT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU) VALUES (200406,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:17:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:17:04','YYYY-MM-DD HH24:MI:SS'),100,'Locator','Warehouse Locator','The Locator indicates where in a Warehouse a product is located.',200141,20,31,'N',0,'Y','@SQL=SELECT MAX(M_Locator_ID) FROM M_Locator WHERE M_Warehouse_ID=@M_Warehouse_ID@','M_Locator_ID','Y','D',448,'9a6d8955-cc7f-4060-b821-0a11c893aba7')
;

-- Sep 1, 2022, 3:17:55 PM SGT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200405
;

-- Sep 1, 2022, 3:20:58 PM SGT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203638,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:20:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:20:57','YYYY-MM-DD HH24:MI:SS'),100,'CreateLinesFrom','Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.','Create lines from','D','18e06958-33d2-4f35-b725-eb0641c82185')
;

-- Sep 1, 2022, 3:28:52 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215125,1,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',319,'CreateLinesFrom',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2022-09-01 15:28:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:28:51','YYYY-MM-DD HH24:MI:SS'),100,203638,'Y','N','D','N','N','N','Y','ef9074e3-2b7e-464b-b934-04597f6b7ef9','Y','N','N','N','N')
;

-- Sep 1, 2022, 3:29:10 PM SGT
ALTER TABLE M_InOut ADD CreateLinesFrom CHAR(1) DEFAULT NULL 
;

-- Sep 1, 2022, 3:29:52 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207138,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',257,215125,'Y',1,580,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-01 15:29:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:29:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c28f99f6-a8b6-4e0c-831e-62dd55b0a6bd','Y',570,2,2)
;

-- Sep 1, 2022, 3:31:30 PM SGT
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=310, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:31:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207138
;

-- Sep 1, 2022, 3:32:13 PM SGT
UPDATE AD_Field SET DisplayLogic='@MovementType@=''C+''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:32:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207138
;

-- Sep 1, 2022, 3:32:28 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:32:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4242
;

-- Sep 1, 2022, 3:33:26 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207139,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',296,215125,'Y',1,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-01 15:33:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:33:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3ddba7a6-5dfd-4c32-952e-db272d9580f6','Y',410,2,2)
;

-- Sep 1, 2022, 3:35:09 PM SGT
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=250, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:35:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207139
;

-- Sep 1, 2022, 3:35:28 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:35:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4248
;

-- Sep 1, 2022, 3:36:49 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207140,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',53271,215125,'Y',1,410,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-01 15:36:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:36:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0795a379-43d6-4a65-afd0-84afa84d52c1','Y',410,2,2)
;

-- Sep 1, 2022, 3:37:50 PM SGT
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=250, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:37:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207140
;

-- Sep 1, 2022, 3:38:07 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:38:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57737
;

-- Sep 1, 2022, 3:40:28 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207141,'Create lines from','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.',53276,215125,'Y',1,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-01 15:40:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 15:40:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3319afe7-d7a8-473d-8556-838c1b08e24f','Y',460,2,2)
;

-- Sep 1, 2022, 3:41:43 PM SGT
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=280, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:41:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207141
;

-- Sep 1, 2022, 3:42:07 PM SGT
UPDATE AD_Field SET DisplayLogic='@MovementType@=''C+''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:42:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207141
;

-- Sep 1, 2022, 3:42:12 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-01 15:42:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57870
;

-- Sep 1, 2022, 4:02:10 PM SGT
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,AD_InfoColumn_ID,EntityType) VALUES (200013,'8f37b1a8-2d42-45dc-9fd7-bd357f9f6134',0,0,'Y',TO_TIMESTAMP('2022-09-01 16:02:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-01 16:02:08','YYYY-MM-DD HH24:MI:SS'),100,10,200141,200022,'B',200259,'D')
;

-- Sep 1, 2022, 4:22:39 PM SGT
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2022-09-01 16:22:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200022
;

-- Sep 1, 2022, 5:36:55 PM SGT
UPDATE AD_InfoColumn SET DisplayLogic='@MovementType@!''C+'' & @MovementType@!''V-'' & @C_Order_ID@!0',Updated=TO_TIMESTAMP('2022-09-01 17:36:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200257
;

-- Sep 1, 2022, 5:39:01 PM SGT
UPDATE AD_InfoColumn SET DisplayLogic='@MovementType@!''C+'' & @MovementType@!''V-'' & @C_Order_ID@=0',Updated=TO_TIMESTAMP('2022-09-01 17:39:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200255
;

-- Sep 1, 2022, 5:39:11 PM SGT
UPDATE AD_InfoColumn SET DefaultValue='0',Updated=TO_TIMESTAMP('2022-09-01 17:39:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200255
;

-- Sep 1, 2022, 5:42:15 PM SGT
UPDATE AD_InfoColumn SET DisplayLogic='@MovementType@!''C+'' & @MovementType@!''V-'' & (@C_Invoice_ID@=0 | (@C_Order_ID@!0 & @C_Invoice_ID@!0))',Updated=TO_TIMESTAMP('2022-09-01 17:42:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200254
;

