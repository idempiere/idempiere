-- IDEMPIERE-6025 Purchase Credit Memo > Create Lines From not displaying open/deferred matched PO invoice quantities
SELECT register_migration_script('202403051827_IDEMPIERE-6025.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 5, 2024, 6:27:42 PM MYT
UPDATE AD_ViewComponent SET OtherClause='GROUP BY l.QtyOrdered,CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END,
l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, l.Line, l.C_OrderLine_ID, o.IsSOTrx, 
l.AD_Client_ID, l.AD_Org_ID, l.IsActive,l.c_bpartner_id,l.C_Order_ID, m2.Qty, l.QtyInvoiced
HAVING (l.QtyOrdered-(CASE WHEN SUM(m.Qty) IS NULL THEN l.QtyInvoiced ELSE SUM(COALESCE(m.Qty,0))+COALESCE(m2.Qty,0) END) <> 0) 
OR (COALESCE(m2.Qty,0) <> 0)',Updated=TO_TIMESTAMP('2024-03-05 18:27:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200227
;

-- Mar 5, 2024, 6:27:54 PM MYT
CREATE OR REPLACE VIEW C_Invoice_CreateFrom_v(CreditQty, Qty, Multiplier, C_UOM_ID, M_Product_ID, C_Charge_ID, VendorProductNo, Line, C_OrderLine_ID, M_InOutLine_ID, M_RMALine_ID, C_BPartner_ID, C_Order_ID, M_InOut_ID, M_RMA_ID, C_Invoice_CreateFrom_v_ID, AD_Client_ID, AD_Org_ID, IsActive, IsSOTrx, AD_Table_ID) AS SELECT COALESCE(m2.Qty,SUM(COALESCE(m.Qty,0))) AS CreditQty, l.QtyOrdered-(CASE WHEN SUM(m.Qty) IS NULL THEN l.QtyInvoiced ELSE SUM(COALESCE(m.Qty,0))+COALESCE(m2.Qty,0) END) AS Qty, CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END AS Multiplier, l.C_UOM_ID AS C_UOM_ID, COALESCE(l.M_Product_ID, 0) AS M_Product_ID, COALESCE(l.C_Charge_ID, 0) AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, 0 AS M_InOutLine_ID, 0 AS M_RMALine_ID, l.C_BPartner_ID AS C_BPartner_ID, l.C_Order_ID AS C_Order_ID, 0 AS M_InOut_ID, 0 AS M_RMA_ID, l.C_OrderLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, o.IsSOTrx AS IsSOTrx, 260 AS AD_Table_ID FROM C_OrderLine l
     JOIN C_Order o ON o.C_Order_ID = l.C_Order_ID 
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND l.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN M_MatchPO m ON l.c_orderline_id = m.C_OrderLine_ID AND m.C_InvoiceLine_ID IS NOT NULL AND COALESCE(m.Reversal_ID,0)=0 AND m.Posted<>'d' 
	 LEFT JOIN (
		 SELECT m2.C_OrderLine_ID, SUM(COALESCE(m2.Qty,0)) AS Qty 
		 FROM M_MatchPO m2 
		 WHERE m2.C_InvoiceLine_ID IS NOT NULL
		 AND COALESCE(m2.Reversal_ID,0)=0 
		 AND m2.Posted='d'
		 GROUP BY m2.C_OrderLine_ID
	 ) m2 ON l.c_orderline_id = m2.C_OrderLine_ID 
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID GROUP BY l.QtyOrdered,CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END,
l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, l.Line, l.C_OrderLine_ID, o.IsSOTrx, 
l.AD_Client_ID, l.AD_Org_ID, l.IsActive,l.c_bpartner_id,l.C_Order_ID, m2.Qty, l.QtyInvoiced
HAVING (l.QtyOrdered-(CASE WHEN SUM(m.Qty) IS NULL THEN l.QtyInvoiced ELSE SUM(COALESCE(m.Qty,0))+COALESCE(m2.Qty,0) END) <> 0) 
OR (COALESCE(m2.Qty,0) <> 0) UNION  ALL SELECT CASE WHEN io.IsSOTrx='N' THEN (l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END) ELSE (l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END) END AS CreditQty, l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END AS Qty, l.QtyEntered/l.MovementQty AS Multiplier, l.C_UOM_ID AS C_UOM_ID, l.M_Product_ID AS M_Product_ID, l.C_Charge_ID AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, l.M_InOutLine_ID AS M_InOutLine_ID, 0 AS M_RMALine_ID, io.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, l.M_InOut_ID AS M_InOut_ID, 0 AS M_RMA_ID, l.M_InOutLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, io.IsSOTrx AS IsSOTrx, 320 AS AD_Table_ID FROM M_InOutLine l
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID
     JOIN M_InOut io ON l.m_inout_id= io.M_InOut_ID
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND io.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN M_MatchInv mi ON l.M_InOutLine_ID = mi.M_InOutLine_ID WHERE l.MovementQty <> 0 AND io.IsSOTrx='N' GROUP BY io.MovementType, l.MovementQty, l.QtyEntered/l.MovementQty, l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, 
	 l.Line, l.C_OrderLine_ID, l.M_InOutLine_ID, io.C_BPartner_ID, l.M_InOut_ID, io.IsSOTrx, l.AD_Client_ID, l.AD_Org_ID, l.IsActive 
	 HAVING l.MovementQty-SUM(COALESCE(mi.Qty, 0)) <> 0 UNION  ALL SELECT l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) AS CreditQty, l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) AS Qty, l.QtyEntered/l.MovementQty AS Multiplier, l.C_UOM_ID AS C_UOM_ID, l.M_Product_ID AS M_Product_ID, l.C_Charge_ID AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, l.M_InOutLine_ID AS M_InOutLine_ID, 0 AS M_RMALine_ID, io.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, l.M_InOut_ID AS M_InOut_ID, 0 AS M_RMA_ID, l.M_InOutLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, io.IsSOTrx AS IsSOTrx, 320 AS AD_Table_ID FROM M_InOutLine l
     LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID
     JOIN M_InOut io ON l.m_inout_id= io.M_InOut_ID
     LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND io.C_BPartner_ID = po.C_BPartner_ID
     LEFT JOIN C_InvoiceLine il ON l.M_InOutLine_ID = il.M_InOutLine_ID  WHERE l.MovementQty <> 0 AND io.IsSOTrx='Y' GROUP BY io.MovementType, l.MovementQty, l.QtyEntered/l.MovementQty, l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, 
	 l.Line, l.C_OrderLine_ID, l.M_InOutLine_ID, io.C_BPartner_ID, l.M_InOut_ID, io.IsSOTrx, l.AD_Client_ID, l.AD_Org_ID, l.IsActive 
	 HAVING l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) <> 0 UNION  ALL SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, p.M_Product_ID AS M_Product_ID, c.C_Charge_ID AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, rl.Line AS Line, 0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.m_rma_id AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, rl.AD_Client_ID AS AD_Client_ID, rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_inoutline iol ON rl.m_inoutline_id = iol.m_inoutline_id
     LEFT JOIN m_product p ON p.m_product_id = iol.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = COALESCE(p.c_uom_id, iol.c_uom_id)
     LEFT JOIN c_charge c ON c.c_charge_id = iol.c_charge_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_inoutline_id IS NOT NULL UNION  ALL SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, p.M_Product_ID AS M_Product_ID, 0 AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, rl.Line AS Line, 0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.M_RMA_ID AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, rl.AD_Client_ID AS AD_Client_ID, rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN m_product p ON p.m_product_id = rl.m_product_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = p.c_uom_id
     LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_product_id IS NOT NULL AND rl.m_inoutline_id IS NULL UNION  ALL SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, 0 AS M_Product_ID, c.C_Charge_ID AS C_Charge_ID, NULL AS VendorProductNo, rl.Line AS Line, 0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.m_rma_id AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, rl.AD_Client_ID AS AD_Client_ID, rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID FROM m_rmaline rl
     JOIN m_rma r ON r.m_rma_id = rl.m_rma_id
     JOIN c_charge c ON c.c_charge_id = rl.c_charge_id
     LEFT JOIN c_uom uom ON uom.c_uom_id = 100 WHERE rl.c_charge_id IS NOT NULL AND rl.m_inoutline_id IS NULL
;

