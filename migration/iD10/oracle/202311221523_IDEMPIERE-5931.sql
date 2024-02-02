-- IDEMPIERE-5931 Generate Invoices (manual) displays RMA for selection despite AR Credit memo already completed.
SELECT register_migration_script('202311221523_IDEMPIERE-5931.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 22, 2023, 3:23:50 PM MYT
UPDATE AD_ViewComponent SET WhereClause='WHERE rma.docstatus = ''CO''
AND dt.docbasetype = ''SOO''
AND NOT EXISTS (SELECT 1
	FROM c_invoice i
	WHERE i.m_rma_id = rma.m_rma_id
    AND i.docstatus IN (''IP'', ''CO'', ''CL''))
AND NOT EXISTS (SELECT 1
	FROM c_invoice i
	JOIN c_invoiceline il ON il.c_invoice_id = i.c_invoice_id
	JOIN m_rmaline rl ON rl.m_rmaline_id = il.m_rmaline_id
	WHERE rl.m_rma_id = rma.m_rma_id
    AND i.docstatus IN (''IP'', ''CO'', ''CL''))
AND EXISTS (SELECT 1
	FROM c_invoiceline il
	JOIN m_inoutline iol ON il.m_inoutline_id = iol.m_inoutline_id
	JOIN c_invoice i ON i.c_invoice_id = il.c_invoice_id
	WHERE i.docstatus IN (''CO'', ''CL'') AND EXISTS (SELECT 1
		FROM m_rmaline rl
		WHERE rl.m_rma_id = rma.m_rma_id
		AND iol.m_inoutline_id = rl.m_inoutline_id
		AND rl.m_inoutline_id IS NOT NULL
		AND COALESCE(rl.QtyInvoiced,0) < rl.Qty)
	UNION 
	SELECT 1
	FROM c_invoiceline il
	JOIN c_orderline ol ON il.c_orderline_id = ol.c_orderline_id
	JOIN c_invoice i ON i.c_invoice_id = il.c_invoice_id
	WHERE i.docstatus IN (''CO'', ''CL'') AND EXISTS (SELECT 1
		FROM m_rmaline rl 
		JOIN m_inoutline iol ON iol.m_inoutline_id = rl.m_inoutline_id
		WHERE rl.m_rma_id = rma.m_rma_id
		AND iol.c_orderline_id = ol.c_orderline_id
		AND iol.c_orderline_id IS NOT NULL
		AND COALESCE(rl.QtyInvoiced,0) < rl.Qty))',Updated=TO_TIMESTAMP('2023-11-22 15:23:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200220
;

-- Nov 22, 2023, 3:24:03 PM MYT
CREATE OR REPLACE VIEW C_Invoice_Candidate_v(AD_Client_ID, AD_Org_ID, Created, Updated, IsActive, C_BPartner_ID, C_Order_ID, M_InOut_ID, DocumentNo, DateOrdered, C_DocType_ID, InvoiceRule, TotalLines, DocSource, C_Invoice_Candidate_v_ID) AS SELECT o.ad_client_id AS AD_Client_ID, o.ad_org_id AS AD_Org_ID, o.created AS Created, o.updated AS Updated, o.isactive AS IsActive, o.c_bpartner_id AS C_BPartner_ID, o.c_order_id AS C_Order_ID, NULL AS M_InOut_ID, o.documentno AS DocumentNo, o.dateordered AS DateOrdered, o.c_doctype_id AS C_DocType_ID, o.invoicerule AS InvoiceRule, sum((l.qtyordered - l.qtyinvoiced) * l.priceactual) AS TotalLines, 'O' AS DocSource, o.c_order_id AS C_Invoice_Candidate_v_ID FROM c_order o
JOIN c_orderline l ON o.c_order_id = l.c_order_id
JOIN c_bpartner bp ON o.c_bpartner_id = bp.c_bpartner_id
LEFT JOIN c_invoiceschedule si ON bp.c_invoiceschedule_id = si.c_invoiceschedule_id WHERE (o.docstatus IN ('CO', 'CL', 'IP')) AND (o.c_doctype_id IN ( SELECT c_doctype.c_doctype_id
           FROM c_doctype
          WHERE c_doctype.docbasetype = 'SOO' AND (c_doctype.docsubtypeso NOT IN ('ON', 'OB', 'WR')))) AND l.qtyordered <> l.qtyinvoiced AND (o.invoicerule = 'I' OR o.invoicerule = 'O' AND NOT (EXISTS ( SELECT 1
           FROM c_orderline zz1
          WHERE zz1.c_order_id = o.c_order_id AND zz1.qtyordered <> zz1.qtydelivered)) OR o.invoicerule = 'D' AND l.qtyinvoiced <> l.qtydelivered OR o.invoicerule = 'S' AND bp.c_invoiceschedule_id IS NULL OR o.invoicerule = 'S' AND bp.c_invoiceschedule_id IS NOT NULL AND (si.invoicefrequency IS NULL OR si.invoicefrequency = 'D' OR si.invoicefrequency = 'W' OR si.invoicefrequency = 'T' AND (trunc(o.dateordered) <= (firstof(getdate(), 'MM') + si.invoicedaycutoff - 1) AND trunc(getdate()) >= (firstof(o.dateordered, 'MM') + si.invoiceday - 1) OR trunc(o.dateordered) <= (firstof(getdate(), 'MM') + si.invoicedaycutoff + 14) AND trunc(getdate()) >= (firstof(o.dateordered, 'MM') + si.invoiceday + 14)) OR si.invoicefrequency = 'M' AND trunc(o.dateordered) <= (firstof(getdate(), 'MM') + si.invoicedaycutoff - 1) AND trunc(getdate()) >= (firstof(o.dateordered, 'MM') + si.invoiceday - 1))) GROUP BY o.ad_client_id, o.ad_org_id, o.created, o.updated, o.isactive, o.c_bpartner_id, o.c_order_id, o.documentno, o.dateordered, o.c_doctype_id,o.invoicerule UNION  ALL SELECT rma.ad_client_id AS AD_Client_ID, rma.ad_org_id AS AD_Org_ID, rma.created AS Created, rma.updated AS Updated, rma.isactive AS IsActive, rma.c_bpartner_id AS C_BPartner_ID, rma.c_order_id AS C_Order_ID, rma.inout_id AS M_InOut_ID, rma.documentno AS DocumentNo, rma.created AS DateOrdered, rma.c_doctype_id AS C_DocType_ID, NULL AS InvoiceRule, rma.amt AS TotalLines, 'R' AS DocSource, rma.m_rma_id AS C_Invoice_Candidate_v_ID FROM   m_rma rma
JOIN c_doctype dt ON rma.c_doctype_id = dt.c_doctype_id
 WHERE rma.docstatus = 'CO'
AND dt.docbasetype = 'SOO'
AND NOT EXISTS (SELECT 1
	FROM c_invoice i
	WHERE i.m_rma_id = rma.m_rma_id
    AND i.docstatus IN ('IP', 'CO', 'CL'))
AND NOT EXISTS (SELECT 1
	FROM c_invoice i
	JOIN c_invoiceline il ON il.c_invoice_id = i.c_invoice_id
	JOIN m_rmaline rl ON rl.m_rmaline_id = il.m_rmaline_id
	WHERE rl.m_rma_id = rma.m_rma_id
    AND i.docstatus IN ('IP', 'CO', 'CL'))
AND EXISTS (SELECT 1
	FROM c_invoiceline il
	JOIN m_inoutline iol ON il.m_inoutline_id = iol.m_inoutline_id
	JOIN c_invoice i ON i.c_invoice_id = il.c_invoice_id
	WHERE i.docstatus IN ('CO', 'CL') AND EXISTS (SELECT 1
		FROM m_rmaline rl
		WHERE rl.m_rma_id = rma.m_rma_id
		AND iol.m_inoutline_id = rl.m_inoutline_id
		AND rl.m_inoutline_id IS NOT NULL
		AND COALESCE(rl.QtyInvoiced,0) < rl.Qty)
	UNION 
	SELECT 1
	FROM c_invoiceline il
	JOIN c_orderline ol ON il.c_orderline_id = ol.c_orderline_id
	JOIN c_invoice i ON i.c_invoice_id = il.c_invoice_id
	WHERE i.docstatus IN ('CO', 'CL') AND EXISTS (SELECT 1
		FROM m_rmaline rl 
		JOIN m_inoutline iol ON iol.m_inoutline_id = rl.m_inoutline_id
		WHERE rl.m_rma_id = rma.m_rma_id
		AND iol.c_orderline_id = ol.c_orderline_id
		AND iol.c_orderline_id IS NOT NULL
		AND COALESCE(rl.QtyInvoiced,0) < rl.Qty))
;

-- Nov 22, 2023, 4:57:03 PM MYT
UPDATE AD_ViewComponent SET WhereClause='WHERE RMA.docstatus = ''CO''
AND DT.docbasetype = ''POO''
AND EXISTS (SELECT 1
	FROM m_rma R
	INNER JOIN m_rmaline RL ON R.m_rma_id = RL.m_rma_id
	WHERE R.m_rma_id = RMA.m_rma_id
	AND RL.isactive = ''Y''
	AND RL.m_inoutline_id > 0
	AND RL.qtydelivered < RL.qty)
AND NOT EXISTS (SELECT 1
	FROM m_inout OIO
	WHERE OIO.m_rma_id = RMA.m_rma_id
	AND OIO.docstatus IN (''IP'', ''CO'', ''CL''))
AND NOT EXISTS (SELECT 1
	FROM m_inout OIO
	JOIN m_inoutline IL ON IL.m_inout_id = OIO.m_inout_id
	JOIN m_rmaline RL ON RL.m_rmaline_id = IL.m_rmaline_id
	WHERE RL.m_rma_id = rma.m_rma_id
    AND OIO.docstatus IN (''IP'', ''CO'', ''CL''))',Updated=TO_TIMESTAMP('2023-11-22 16:57:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200219
;

-- Nov 22, 2023, 4:57:16 PM MYT
CREATE OR REPLACE VIEW M_InOut_Candidate_v(AD_Client_ID, AD_Org_ID, Created, Updated, IsActive, C_BPartner_ID, C_Order_ID, DocumentNo, DateOrdered, C_DocType_ID, POReference, Description, SalesRep_ID, M_Warehouse_ID, M_InOut_ID, TotalLines, DocSource, M_InOut_Candidate_v_ID, DeliveryRule) AS SELECT o.ad_client_id AS AD_Client_ID, o.ad_org_id AS AD_Org_ID, o.created AS Created, o.updated AS Updated, o.isactive AS IsActive, o.c_bpartner_id AS C_BPartner_ID, o.c_order_id AS C_Order_ID, o.documentno AS DocumentNo, o.dateordered AS DateOrdered, o.c_doctype_id AS C_DocType_ID, o.poreference AS POReference, o.description AS Description, o.salesrep_id AS SalesRep_ID, l.m_warehouse_id AS M_Warehouse_ID, NULL AS M_InOut_ID, sum((l.qtyordered - l.qtydelivered) * l.priceactual) AS TotalLines, 'O' AS DocSource, o.c_order_id AS M_InOut_Candidate_v_ID, o.deliveryrule AS DeliveryRule FROM c_order o
JOIN c_orderline l ON o.c_order_id = l.c_order_id WHERE o.docstatus = 'CO' AND o.isdelivered = 'N' AND (o.c_doctype_id IN ( SELECT c_doctype.c_doctype_id
           FROM c_doctype
          WHERE c_doctype.docbasetype = 'SOO' AND (c_doctype.docsubtypeso NOT IN ('ON', 'OB', 'WR')))) AND o.deliveryrule <> 'M' AND (l.m_product_id IS NULL OR (EXISTS ( SELECT 1
           FROM m_product p
          WHERE l.m_product_id = p.m_product_id AND p.isexcludeautodelivery = 'N'))) AND l.qtyordered <> l.qtydelivered AND (l.m_product_id IS NOT NULL OR l.c_charge_id IS NOT NULL) AND NOT (EXISTS ( SELECT 1
           FROM m_inoutline iol
             JOIN m_inout io ON iol.m_inout_id = io.m_inout_id
          WHERE iol.c_orderline_id = l.c_orderline_id AND (io.docstatus IN ('DR', 'IN', 'IP', 'WC')))) GROUP BY o.ad_client_id, o.ad_org_id, o.c_bpartner_id, o.c_order_id, o.documentno, o.dateordered, o.c_doctype_id, o.poreference, o.description, o.salesrep_id, l.m_warehouse_id, o.created, o.updated, o.isactive, o.deliveryrule
 UNION  ALL SELECT rma.ad_client_id AS AD_Client_ID, rma.ad_org_id AS AD_Org_ID, rma.created AS Created, rma.updated AS Updated, rma.isactive AS IsActive, rma.c_bpartner_id AS C_BPartner_ID, rma.c_order_id AS C_Order_ID, rma.documentno AS DocumentNo, rma.created AS DateOrdered, rma.c_doctype_id AS C_DocType_ID, NULL AS POReference, NULL AS Description, NULL AS SalesRep_ID, io.m_warehouse_id AS M_Warehouse_ID, rma.inout_id AS M_InOut_ID, rma.amt AS TotalLines, 'R' AS DocSource, rma.m_rma_id AS M_InOut_Candidate_v_ID, NULL AS DeliveryRule FROM m_rma RMA
       INNER JOIN ad_org ORG ON RMA.ad_org_id = ORG.ad_org_id
       INNER JOIN c_doctype DT ON RMA.c_doctype_id = DT.c_doctype_id
       INNER JOIN c_bpartner BP ON RMA.c_bpartner_id = BP.c_bpartner_id
       INNER JOIN m_inout IO ON RMA.inout_id = IO.m_inout_id WHERE RMA.docstatus = 'CO'
AND DT.docbasetype = 'POO'
AND EXISTS (SELECT 1
	FROM m_rma R
	INNER JOIN m_rmaline RL ON R.m_rma_id = RL.m_rma_id
	WHERE R.m_rma_id = RMA.m_rma_id
	AND RL.isactive = 'Y'
	AND RL.m_inoutline_id > 0
	AND RL.qtydelivered < RL.qty)
AND NOT EXISTS (SELECT 1
	FROM m_inout OIO
	WHERE OIO.m_rma_id = RMA.m_rma_id
	AND OIO.docstatus IN ('IP', 'CO', 'CL'))
AND NOT EXISTS (SELECT 1
	FROM m_inout OIO
	JOIN m_inoutline IL ON IL.m_inout_id = OIO.m_inout_id
	JOIN m_rmaline RL ON RL.m_rmaline_id = IL.m_rmaline_id
	WHERE RL.m_rma_id = rma.m_rma_id
    AND OIO.docstatus IN ('IP', 'CO', 'CL'))
;

