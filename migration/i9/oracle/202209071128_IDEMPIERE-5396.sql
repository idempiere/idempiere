-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202209071128_IDEMPIERE-5396.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 6, 2022, 6:19:25 PM SGT
UPDATE AD_InfoColumn SET SelectClause='(CASE WHEN (SELECT COUNT(*)=1 from C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC'',''ARC'')) THEN v.CreditQty*v.Multiplier ELSE v.Qty*v.Multiplier END)',Updated=TO_TIMESTAMP('2022-09-06 18:19:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200269
;

-- Sep 7, 2022, 11:28:34 AM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,ColumnSQL,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,AD_InfoWindow_ID) VALUES (215285,0,'Document Base Type','Logical type of document','The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.',318,'DocBaseType',3,'N','N','N','N','N',0,'N',17,183,0,0,'Y',TO_TIMESTAMP('2022-09-07 11:28:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-07 11:28:32','YYYY-MM-DD HH24:MI:SS'),100,865,'N','N','D','N','N','(SELECT dt.DocBaseType FROM C_DocType dt WHERE dt.C_DocType_ID=C_Invoice.C_DocTypeTarget_ID)','N','Y','a8851e5d-e3e2-4d9e-b9c4-a2dba510fffb','N',0,'N','N','N',200000)
;

-- Sep 7, 2022, 11:29:10 AM SGT
UPDATE AD_Val_Rule SET Code='C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus in (''CO'', ''CL'') 
AND M_RMA_ID in (SELECT rl.M_RMA_ID FROM M_RMALine rl 
WHERE rl.M_RMA_ID=M_RMA.M_RMA_ID AND COALESCE(rl.QtyInvoiced,0)< rl.Qty) ',Updated=TO_TIMESTAMP('2022-09-07 11:29:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200169
;

-- Sep 7, 2022, 11:29:46 AM SGT
UPDATE AD_InfoColumn SET DisplayLogic='@C_Order_ID@=0 & @M_InOut_ID@=0 & @DocBaseType@=''APC''',Updated=TO_TIMESTAMP('2022-09-07 11:29:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200278
;

-- Sep 7, 2022, 11:37:20 AM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207189,'Document Base Type','Logical type of document','The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.',290,215285,'Y',3,450,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-07 11:37:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-07 11:37:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ee2b621b-882f-467f-a1fa-7ea0b1f43605','Y',440,2)
;

-- Sep 7, 2022, 11:37:38 AM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207190,'Document Base Type','Logical type of document','The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.',263,215285,'Y',3,470,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-07 11:37:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-07 11:37:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','79d49f41-c7aa-4fff-888f-5afdf4607de0','Y',460,2)
;

-- Sep 7, 2022, 11:46:33 AM SGT
UPDATE AD_Field SET IsDisplayed='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-07 11:46:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207189
;

-- Sep 7, 2022, 11:50:32 AM SGT
UPDATE AD_Field SET IsDisplayed='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-07 11:50:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207190
;

-- Sep 7, 2022, 12:20:05 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200227
;

-- Sep 7, 2022, 12:20:10 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200228
;

-- Sep 7, 2022, 12:20:14 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:20:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200229
;

-- Sep 7, 2022, 12:20:19 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:20:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200230
;

-- Sep 7, 2022, 12:20:24 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200231
;

-- Sep 7, 2022, 12:20:28 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:20:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200232
;

-- Sep 7, 2022, 12:20:41 PM SGT
CREATE OR REPLACE VIEW C_Invoice_CreateFrom_v(CreditQty, Qty, Multiplier, C_UOM_ID, M_Product_ID, C_Charge_ID, VendorProductNo, Line, C_OrderLine_ID, M_InOutLine_ID, M_RMALine_ID, C_BPartner_ID, C_Order_ID, M_InOut_ID, M_RMA_ID, C_Invoice_CreateFrom_v_ID, AD_Client_ID, AD_Org_ID, IsActive, IsSOTrx, AD_Table_ID) 
AS SELECT SUM(COALESCE(m.Qty,0)) AS CreditQty, l.QtyOrdered-SUM(COALESCE(m.Qty,0)) AS Qty, CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END AS Multiplier, l.C_UOM_ID AS C_UOM_ID, COALESCE(l.M_Product_ID, 0) AS M_Product_ID, 
COALESCE(l.C_Charge_ID, 0) AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, 0 AS M_InOutLine_ID, 0 AS M_RMALine_ID, l.C_BPartner_ID AS C_BPartner_ID, l.C_Order_ID AS C_Order_ID, 0 AS M_InOut_ID, 
0 AS M_RMA_ID, l.C_OrderLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, o.IsSOTrx AS IsSOTrx, 260 AS AD_Table_ID 
FROM C_OrderLine l
     JOIN C_Order o ON o.C_Order_ID = l.C_Order_ID 
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND l.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN M_MatchPO m ON l.c_orderline_id = m.C_OrderLine_ID AND m.C_InvoiceLine_ID IS NOT NULL AND COALESCE(m.Reversal_ID,0)=0
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID 
GROUP BY l.QtyOrdered,CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END,
l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, l.Line, l.C_OrderLine_ID, o.IsSOTrx,
l.AD_Client_ID, l.AD_Org_ID, l.IsActive,l.c_bpartner_id,l.C_Order_ID
UNION  ALL SELECT CASE WHEN io.IsSOTrx='N' THEN (l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END) ELSE (l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END) END AS CreditQty, 
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
UNION  ALL SELECT l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) AS CreditQty, l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) AS Qty, l.QtyEntered/l.MovementQty AS Multiplier, l.C_UOM_ID AS C_UOM_ID, l.M_Product_ID AS M_Product_ID, 
l.C_Charge_ID AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, l.M_InOutLine_ID AS M_InOutLine_ID, 0 AS M_RMALine_ID, io.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, l.M_InOut_ID AS M_InOut_ID, 
0 AS M_RMA_ID, l.M_InOutLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, io.IsSOTrx AS IsSOTrx, 320 AS AD_Table_ID
FROM M_InOutLine l
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID
     JOIN M_InOut io ON l.m_inout_id= io.M_InOut_ID
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND io.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN C_InvoiceLine il ON l.M_InOutLine_ID = il.M_InOutLine_ID  WHERE l.MovementQty <> 0 AND io.IsSOTrx='Y' 
GROUP BY io.MovementType, l.MovementQty, l.QtyEntered/l.MovementQty, l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, 
	 l.Line, l.C_OrderLine_ID, l.M_InOutLine_ID, io.C_BPartner_ID, l.M_InOut_ID, io.IsSOTrx,
     l.AD_Client_ID, l.AD_Org_ID,l.IsActive
	 HAVING l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) <> 0 
UNION  ALL SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, p.M_Product_ID AS M_Product_ID, c.C_Charge_ID AS C_Charge_ID, 
po.VendorProductNo AS VendorProductNo, rl.Line AS Line, 0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.m_rma_id AS M_RMA_ID, 
rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, rl.AD_Client_ID AS AD_Client_ID, rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID 
FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_inoutline iol ON rl.m_inoutline_id = iol.m_inoutline_id
     LEFT JOIN m_product p ON p.m_product_id = iol.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = COALESCE(p.c_uom_id, iol.c_uom_id)
     LEFT JOIN c_charge c ON c.c_charge_id = iol.c_charge_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_inoutline_id IS NOT NULL 
UNION  ALL SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, p.M_Product_ID AS M_Product_ID, 0 AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, 
rl.Line AS Line, 0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.M_RMA_ID AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, 
rl.AD_Client_ID AS AD_Client_ID, rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID 
FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_product p ON p.m_product_id = rl.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = p.c_uom_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_product_id IS NOT NULL AND rl.m_inoutline_id IS NULL 
UNION  ALL SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, 0 AS M_Product_ID, c.C_Charge_ID AS C_Charge_ID, NULL AS VendorProductNo, rl.Line AS Line, 
0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.m_rma_id AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, rl.AD_Client_ID AS AD_Client_ID, 
rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID 
FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN c_charge c ON c.c_charge_id = rl.c_charge_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = 100 WHERE rl.c_charge_id IS NOT NULL AND rl.m_inoutline_id IS NULL
;

-- Sep 7, 2022, 12:23:00 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200221
;

-- Sep 7, 2022, 12:23:05 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:23:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200222
;

-- Sep 7, 2022, 12:23:10 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:23:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200223
;

-- Sep 7, 2022, 12:23:14 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:23:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200224
;

-- Sep 7, 2022, 12:23:18 PM SGT
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-09-07 12:23:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200225
;

-- Sep 7, 2022, 12:23:50 PM SGT
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
l.c_uom_id, p.m_locator_id, po.vendorproductno, l.m_product_id, l.c_charge_id, l.line, l.c_orderline_id, p.upc,o.m_warehouse_id,o.issotrx,
l.c_bpartner_id,l.c_order_id,l.ad_client_id,l.ad_org_id,l.IsActive
UNION  ALL SELECT l.qtyinvoiced - sum(nvl(mi.qty, 0)) AS Qty, l.qtyentered / l.qtyinvoiced AS Multiplier, l.c_uom_id AS C_UOM_ID, p.m_locator_id AS M_Locator_ID, l.m_product_id AS M_Product_ID, l.c_charge_id AS C_Charge_ID, 
po.vendorproductno AS VendorProductNo, l.line AS Line, l.c_orderline_id AS C_OrderLine_ID, l.c_invoiceline_id AS C_InvoiceLine_ID, 0 AS M_RMALine_ID, inv.c_bpartner_id AS C_BPartner_ID, 0 AS C_Order_ID, l.c_invoice_id AS C_Invoice_ID, 0 AS M_RMA_ID, 
l.c_invoiceline_id AS M_InOut_CreateFrom_v_ID, l.ad_client_id AS AD_Client_ID, l.ad_org_id AS AD_Org_ID, l.isactive AS IsActive, p.upc AS UPC, 0 AS M_Warehouse_ID, inv.issotrx AS IsSOTrx, 333 AS AD_Table_ID 
FROM c_invoiceline l
     LEFT JOIN m_product p ON l.m_product_id = p.m_product_id
     JOIN c_invoice inv ON l.c_invoice_id = inv.c_invoice_id
     LEFT JOIN m_product_po po ON l.m_product_id = po.m_product_id AND inv.c_bpartner_id = po.c_bpartner_id
     LEFT JOIN m_matchinv mi ON l.c_invoiceline_id = mi.c_invoiceline_id WHERE l.qtyinvoiced <> 0 
GROUP BY l.qtyinvoiced, (l.qtyentered / l.qtyinvoiced), l.c_uom_id, p.m_locator_id, l.m_product_id, l.c_charge_id, po.vendorproductno, l.c_invoiceline_id, l.line, l.c_orderline_id, inv.c_bpartner_id, l.c_invoice_id, p.upc, inv.issotrx,
l.ad_client_id,l.ad_org_id,l.IsActive
UNION  ALL SELECT rl.qty - rl.qtydelivered AS Qty, 1 AS Multiplier, uom.c_uom_id AS C_UOM_ID, p.m_locator_id AS M_Locator_ID, p.m_product_id AS M_Product_ID, c.c_charge_id AS C_Charge_ID, po.vendorproductno AS VendorProductNo, rl.line AS Line, 
0 AS C_OrderLine_ID, 0 AS C_InvoiceLine_ID, rl.m_rmaline_id AS M_RMALine_ID, r.c_bpartner_id AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS C_Invoice_ID, r.m_rma_id AS M_RMA_ID, rl.m_rmaline_id AS M_InOut_CreateFrom_v_ID, rl.ad_client_id AS AD_Client_ID, 
rl.ad_org_id AS AD_Org_ID, rl.isactive AS IsActive, p.upc AS UPC, 0 AS M_Warehouse_ID, r.issotrx AS IsSOTrx, 660 AS AD_Table_ID 
FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_inoutline iol ON rl.m_inoutline_id = iol.m_inoutline_id
     LEFT JOIN m_product p ON p.m_product_id = iol.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = COALESCE(p.c_uom_id, iol.c_uom_id)
     LEFT JOIN c_charge c ON c.c_charge_id = iol.c_charge_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_inoutline_id IS NOT NULL 
UNION  ALL SELECT rl.qty - rl.qtydelivered AS Qty, 1 AS Multiplier, uom.c_uom_id AS C_UOM_ID, p.m_locator_id AS M_Locator_ID, p.m_product_id AS M_Product_ID, 0 AS C_Charge_ID, po.vendorproductno AS VendorProductNo, rl.line AS Line, 0 AS C_OrderLine_ID, 
0 AS C_InvoiceLine_ID, rl.m_rmaline_id AS M_RMALine_ID, r.c_bpartner_id AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS C_Invoice_ID, r.m_rma_id AS M_RMA_ID, rl.m_rmaline_id AS M_InOut_CreateFrom_v_ID, rl.ad_client_id AS AD_Client_ID, rl.ad_org_id AS AD_Org_ID, 
rl.isactive AS IsActive, p.upc AS UPC, 0 AS M_Warehouse_ID, r.issotrx AS IsSOTrx, 660 AS AD_Table_ID 
FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_product p ON p.m_product_id = rl.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = p.c_uom_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_product_id IS NOT NULL AND rl.m_inoutline_id IS NULL 
UNION  ALL SELECT rl.qty - rl.qtydelivered AS Qty, 1 AS Multiplier, uom.c_uom_id AS C_UOM_ID, 0 AS M_Locator_ID, 0 AS M_Product_ID, c.c_charge_id AS C_Charge_ID, NULL AS VendorProductNo, rl.line AS Line, 0 AS C_OrderLine_ID, 0 AS C_InvoiceLine_ID, 
rl.m_rmaline_id AS M_RMALine_ID, r.c_bpartner_id AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS C_Invoice_ID, r.m_rma_id AS M_RMA_ID, rl.m_rmaline_id AS M_InOut_CreateFrom_v_ID, rl.ad_client_id AS AD_Client_ID, rl.ad_org_id AS AD_Org_ID, rl.isactive AS IsActive, 
NULL AS UPC, 0 AS M_Warehouse_ID, r.issotrx AS IsSOTrx, 660 AS AD_Table_ID 
FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN c_charge c ON c.c_charge_id = rl.c_charge_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = 100 WHERE rl.c_charge_id IS NOT NULL AND rl.m_inoutline_id IS NULL
;

