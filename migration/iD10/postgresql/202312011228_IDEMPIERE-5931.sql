-- IDEMPIERE-5931 Generate Invoices (manual) displays RMA for selection despite AR Credit memo already completed.
SELECT register_migration_script('202312011228_IDEMPIERE-5931.sql') FROM dual;

-- Dec 1, 2023, 1:05:12 PM MYT
UPDATE AD_ViewColumn SET ColumnSQL='l.QtyOrdered-SUM(COALESCE(m.Qty,l.QtyInvoiced))',Updated=TO_TIMESTAMP('2023-12-01 13:05:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217539
;

-- Dec 1, 2023, 1:05:34 PM MYT
UPDATE AD_ViewComponent SET OtherClause='GROUP BY l.QtyOrdered,CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END,
l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, l.Line, l.C_OrderLine_ID, o.IsSOTrx, 
l.AD_Client_ID, l.AD_Org_ID, l.IsActive,l.c_bpartner_id,l.C_Order_ID 
HAVING l.QtyOrdered-SUM(COALESCE(m.Qty,l.QtyInvoiced)) <> 0',Updated=TO_TIMESTAMP('2023-12-01 13:05:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200227
;

-- Dec 1, 2023, 1:06:05 PM MYT
CREATE OR REPLACE VIEW C_Invoice_CreateFrom_v(CreditQty, Qty, Multiplier, C_UOM_ID, M_Product_ID, C_Charge_ID, VendorProductNo, Line, C_OrderLine_ID, M_InOutLine_ID, M_RMALine_ID, C_BPartner_ID, C_Order_ID, M_InOut_ID, M_RMA_ID, C_Invoice_CreateFrom_v_ID, AD_Client_ID, AD_Org_ID, IsActive, IsSOTrx, AD_Table_ID) AS SELECT SUM(COALESCE(m.Qty,0)) AS CreditQty, l.QtyOrdered-SUM(COALESCE(m.Qty,l.QtyInvoiced)) AS Qty, CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END AS Multiplier, l.C_UOM_ID AS C_UOM_ID, COALESCE(l.M_Product_ID, 0) AS M_Product_ID, COALESCE(l.C_Charge_ID, 0) AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, 0 AS M_InOutLine_ID, 0 AS M_RMALine_ID, l.C_BPartner_ID AS C_BPartner_ID, l.C_Order_ID AS C_Order_ID, 0 AS M_InOut_ID, 0 AS M_RMA_ID, l.C_OrderLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, o.IsSOTrx AS IsSOTrx, 260 AS AD_Table_ID FROM C_OrderLine l JOIN C_Order o ON o.C_Order_ID = l.C_Order_ID LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND l.C_BPartner_ID = po.C_BPartner_ID LEFT JOIN M_MatchPO m ON l.c_orderline_id = m.C_OrderLine_ID AND m.C_InvoiceLine_ID IS NOT NULL AND COALESCE(m.Reversal_ID,0)=0 LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID GROUP BY l.QtyOrdered,CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END, l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, l.Line, l.C_OrderLine_ID, o.IsSOTrx, l.AD_Client_ID, l.AD_Org_ID, l.IsActive,l.c_bpartner_id,l.C_Order_ID HAVING l.QtyOrdered-SUM(COALESCE(m.Qty,l.QtyInvoiced)) <> 0 UNION ALL SELECT CASE WHEN io.IsSOTrx='N' THEN (l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END) ELSE (l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END) END AS CreditQty, l.Movementqty-SUM(COALESCE(mi.Qty, 0))*CASE WHEN io.MovementType = 'V-' THEN -1 ELSE 1 END AS Qty, l.QtyEntered/l.MovementQty AS Multiplier, l.C_UOM_ID AS C_UOM_ID, l.M_Product_ID AS M_Product_ID, l.C_Charge_ID AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, l.M_InOutLine_ID AS M_InOutLine_ID, 0 AS M_RMALine_ID, io.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, l.M_InOut_ID AS M_InOut_ID, 0 AS M_RMA_ID, l.M_InOutLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, io.IsSOTrx AS IsSOTrx, 320 AS AD_Table_ID FROM M_InOutLine l LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID JOIN M_InOut io ON l.m_inout_id= io.M_InOut_ID LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND io.C_BPartner_ID = po.C_BPartner_ID LEFT JOIN M_MatchInv mi ON l.M_InOutLine_ID = mi.M_InOutLine_ID WHERE l.MovementQty <> 0 AND io.IsSOTrx='N' GROUP BY io.MovementType, l.MovementQty, l.QtyEntered/l.MovementQty, l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, l.Line, l.C_OrderLine_ID, l.M_InOutLine_ID, io.C_BPartner_ID, l.M_InOut_ID, io.IsSOTrx, l.AD_Client_ID, l.AD_Org_ID, l.IsActive HAVING l.MovementQty-SUM(COALESCE(mi.Qty, 0)) <> 0 UNION ALL SELECT l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) AS CreditQty, l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) AS Qty, l.QtyEntered/l.MovementQty AS Multiplier, l.C_UOM_ID AS C_UOM_ID, l.M_Product_ID AS M_Product_ID, l.C_Charge_ID AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, l.Line AS Line, l.C_OrderLine_ID AS C_OrderLine_ID, l.M_InOutLine_ID AS M_InOutLine_ID, 0 AS M_RMALine_ID, io.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, l.M_InOut_ID AS M_InOut_ID, 0 AS M_RMA_ID, l.M_InOutLine_ID AS C_Invoice_CreateFrom_v_ID, l.AD_Client_ID AS AD_Client_ID, l.AD_Org_ID AS AD_Org_ID, l.IsActive AS IsActive, io.IsSOTrx AS IsSOTrx, 320 AS AD_Table_ID FROM M_InOutLine l LEFT JOIN M_Product p ON l.M_Product_ID = p.M_Product_ID JOIN M_InOut io ON l.m_inout_id= io.M_InOut_ID LEFT JOIN M_Product_PO po ON l.M_Product_ID = po.M_Product_ID AND io.C_BPartner_ID = po.C_BPartner_ID LEFT JOIN C_InvoiceLine il ON l.M_InOutLine_ID = il.M_InOutLine_ID WHERE l.MovementQty <> 0 AND io.IsSOTrx='Y' GROUP BY io.MovementType, l.MovementQty, l.QtyEntered/l.MovementQty, l.C_UOM_ID, po.VendorProductNo, l.M_Product_ID, l.C_Charge_ID, l.Line, l.C_OrderLine_ID, l.M_InOutLine_ID, io.C_BPartner_ID, l.M_InOut_ID, io.IsSOTrx, l.AD_Client_ID, l.AD_Org_ID, l.IsActive HAVING l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) <> 0 UNION ALL SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, p.M_Product_ID AS M_Product_ID, c.C_Charge_ID AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, rl.Line AS Line, 0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.m_rma_id AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, rl.AD_Client_ID AS AD_Client_ID, rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID FROM m_rmaline rl JOIN m_rma r ON r.m_rma_id = rl.m_rma_id JOIN m_inoutline iol ON rl.m_inoutline_id = iol.m_inoutline_id LEFT JOIN m_product p ON p.m_product_id = iol.m_product_id LEFT JOIN c_uom uom ON uom.c_uom_id = COALESCE(p.c_uom_id, iol.c_uom_id) LEFT JOIN c_charge c ON c.c_charge_id = iol.c_charge_id LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_inoutline_id IS NOT NULL UNION ALL SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, p.M_Product_ID AS M_Product_ID, 0 AS C_Charge_ID, po.VendorProductNo AS VendorProductNo, rl.Line AS Line, 0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.M_RMA_ID AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, rl.AD_Client_ID AS AD_Client_ID, rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID FROM m_rmaline rl JOIN m_rma r ON r.m_rma_id = rl.m_rma_id JOIN m_product p ON p.m_product_id = rl.m_product_id LEFT JOIN c_uom uom ON uom.c_uom_id = p.c_uom_id LEFT JOIN m_product_po po ON rl.m_product_id = po.m_product_id AND r.c_bpartner_id = po.c_bpartner_id WHERE rl.m_product_id IS NOT NULL AND rl.m_inoutline_id IS NULL UNION ALL SELECT rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS CreditQty, rl.Qty - COALESCE(rl.QtyInvoiced, 0) AS Qty, 1 AS Multiplier, uom.C_UOM_ID AS C_UOM_ID, 0 AS M_Product_ID, c.C_Charge_ID AS C_Charge_ID, NULL AS VendorProductNo, rl.Line AS Line, 0 AS C_OrderLine_ID, 0 AS M_InOutLine_ID, rl.M_RMALine_ID AS M_RMALine_ID, r.C_BPartner_ID AS C_BPartner_ID, 0 AS C_Order_ID, 0 AS M_InOut_ID, r.m_rma_id AS M_RMA_ID, rl.M_RMALine_ID AS C_Invoice_CreateFrom_v_ID, rl.AD_Client_ID AS AD_Client_ID, rl.AD_Org_ID AS AD_Org_ID, rl.IsActive AS IsActive, r.IsSOTrx AS IsSOTrx, 660 AS AD_Table_ID FROM m_rmaline rl JOIN m_rma r ON r.m_rma_id = rl.m_rma_id JOIN c_charge c ON c.c_charge_id = rl.c_charge_id LEFT JOIN c_uom uom ON uom.c_uom_id = 100 WHERE rl.c_charge_id IS NOT NULL AND rl.m_inoutline_id IS NULL
;

-- Dec 1, 2023, 4:08:04 PM MYT
UPDATE AD_InfoColumn SET DisplayLogic='@C_Order_ID@=0 & @M_InOut_ID@=0 & (@DocBaseType@=''APC'' | @DocBaseType@=''ARC'')',Updated=TO_TIMESTAMP('2023-12-01 16:08:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200278
;

-- Dec 1, 2023, 4:37:05 PM MYT
UPDATE AD_Val_Rule SET Code='C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus IN (''CL'',''CO'') AND 
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
AND M_InOut_ID IN (
SELECT iol.M_InOut_ID FROM M_InOutLine iol
JOIN M_InOut io ON (io.M_InOut_ID = iol.M_InOut_ID) 
JOIN C_OrderLine ol ON (ol.C_OrderLine_ID = iol.C_OrderLine_ID) 
WHERE io.C_BPartner_ID=@C_BPartner_ID@ AND io.IsSOTrx=''@IsSOTrx@'' AND io.DocStatus IN (''CL'',''CO'') 
AND ol.QtyOrdered-ol.QtyInvoiced != 0
UNION
SELECT iol.M_InOut_ID FROM M_InOutLine iol
JOIN M_InOut io ON (io.M_InOut_ID = iol.M_InOut_ID) 
JOIN M_RMALine rl ON (rl.M_RMALine_ID = iol.M_RMALine_ID) 
WHERE io.C_BPartner_ID=@C_BPartner_ID@ AND io.IsSOTrx=''@IsSOTrx@'' AND io.DocStatus IN (''CL'',''CO'') 
AND rl.Qty-COALESCE(rl.QtyInvoiced,0) != 0
)',Updated=TO_TIMESTAMP('2023-12-01 16:37:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200167
;

-- Dec 1, 2023, 5:31:46 PM MYT
UPDATE AD_Val_Rule SET Code='C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus IN (''CL'',''CO'') AND C_Invoice_ID IN (
SELECT il.C_Invoice_ID FROM C_InvoiceLine il 
LEFT OUTER JOIN M_MatchInv mi ON (il.C_InvoiceLine_ID=mi.C_InvoiceLine_ID) 
JOIN C_Invoice i2 ON (il.C_Invoice_ID = i2.C_Invoice_ID) 
WHERE i2.C_BPartner_ID=@C_BPartner_ID@ AND i2.IsSOTrx=''@IsSOTrx@'' AND i2.DocStatus IN (''CL'',''CO'') 
AND il.M_Product_ID IS NOT NULL 
GROUP BY il.C_Invoice_ID,mi.C_InvoiceLine_ID,il.QtyInvoiced 
HAVING (il.QtyInvoiced<>SUM(mi.Qty) AND mi.C_InvoiceLine_ID IS NOT NULL) OR mi.C_InvoiceLine_ID IS NULL) 
AND C_Invoice_ID IN (
SELECT il.C_Invoice_ID FROM C_InvoiceLine il
JOIN C_Invoice i ON (i.C_Invoice_ID = il.C_Invoice_ID) 
JOIN C_OrderLine ol ON (ol.C_OrderLine_ID = il.C_OrderLine_ID) 
WHERE i.C_BPartner_ID=@C_BPartner_ID@ AND i.IsSOTrx=''@IsSOTrx@'' AND i.DocStatus IN (''CL'',''CO'') 
AND il.M_Product_ID IS NOT NULL 
AND il.M_InOutLine_ID IS NULL 
AND ol.QtyOrdered-ol.QtyDelivered != 0)',Updated=TO_TIMESTAMP('2023-12-01 17:31:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200165
;

