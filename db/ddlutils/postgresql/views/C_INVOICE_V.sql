CREATE OR REPLACE VIEW c_invoice_v AS 
         SELECT i.c_invoice_id, i.ad_client_id, i.ad_org_id, i.isactive, i.created, i.createdby, i.updated, i.updatedby, i.issotrx, i.documentno, i.docstatus, i.docaction, i.processing, i.processed, i.c_doctype_id, i.c_doctypetarget_id, i.c_order_id, i.description, i.isapproved, i.istransferred, i.salesrep_id, i.dateinvoiced, i.dateprinted, i.dateacct, i.c_bpartner_id, i.c_bpartner_location_id, i.ad_user_id, i.poreference, i.dateordered, i.c_currency_id, i.c_conversiontype_id, i.paymentrule, i.c_paymentterm_id, i.c_charge_id, i.m_pricelist_id, i.c_campaign_id, i.c_project_id, i.c_activity_id, i.isprinted, i.isdiscountprinted, i.ispaid, i.isindispute, i.ispayschedulevalid, NULL AS c_invoicepayschedule_id, i.invoicecollectiontype, i.dunninggrace, 
                CASE
                    WHEN charat(d.docbasetype, 3) = 'C' THEN i.chargeamt * (-1)
                    ELSE i.chargeamt
                END AS chargeamt, 
                CASE
                    WHEN charat(d.docbasetype, 3) = 'C' THEN i.totallines * (-1)
                    ELSE i.totallines
                END AS totallines, 
                CASE
                    WHEN charat(d.docbasetype, 3) = 'C' THEN i.grandtotal * (-1)
                    ELSE i.grandtotal
                END AS grandtotal, 
                CASE
                    WHEN charat(d.docbasetype, 3) = 'C' THEN (-1.0)
                    ELSE 1.0
                END AS multiplier, 
                CASE
                    WHEN charat(d.docbasetype, 2) = 'P' THEN (-1.0)
                    ELSE 1.0
                END AS multiplierap, d.docbasetype, paymenttermduedate(i.c_paymentterm_id, i.dateinvoiced) AS duedate, i.ad_orgtrx_id, i.c_payment_id, i.isselfservice, i.posted, i.processedon, i.reversal_id
           FROM c_invoice i
      JOIN c_doctype d ON i.c_doctype_id = d.c_doctype_id
     WHERE i.ispayschedulevalid <> 'Y'
UNION 
         SELECT i.c_invoice_id, i.ad_client_id, i.ad_org_id, i.isactive, i.created, i.createdby, i.updated, i.updatedby, i.issotrx, i.documentno, i.docstatus, i.docaction, i.processing, i.processed, i.c_doctype_id, i.c_doctypetarget_id, i.c_order_id, i.description, i.isapproved, i.istransferred, i.salesrep_id, i.dateinvoiced, i.dateprinted, i.dateacct, i.c_bpartner_id, i.c_bpartner_location_id, i.ad_user_id, i.poreference, i.dateordered, i.c_currency_id, i.c_conversiontype_id, i.paymentrule, i.c_paymentterm_id, i.c_charge_id, i.m_pricelist_id, i.c_campaign_id, i.c_project_id, i.c_activity_id, i.isprinted, i.isdiscountprinted, i.ispaid, i.isindispute, i.ispayschedulevalid, ips.c_invoicepayschedule_id, i.invoicecollectiontype, i.dunninggrace, NULL AS chargeamt, NULL AS totallines, 
                CASE
                    WHEN charat(d.docbasetype, 3) = 'C' THEN ips.dueamt * (-1)
                    ELSE ips.dueamt
                END AS grandtotal, 
                CASE
                    WHEN charat(d.docbasetype, 3) = 'C' THEN (-1)
                    ELSE 1
                END AS multiplier, 
                CASE
                    WHEN charat(d.docbasetype, 2) = 'P' THEN (-1)
                    ELSE 1
                END AS multiplierap, d.docbasetype, ips.duedate, i.ad_orgtrx_id, i.c_payment_id, i.isselfservice, i.posted, i.processedon, i.reversal_id
           FROM c_invoice i
      JOIN c_doctype d ON i.c_doctype_id = d.c_doctype_id
   JOIN c_invoicepayschedule ips ON i.c_invoice_id = ips.c_invoice_id
  WHERE i.ispayschedulevalid = 'Y' AND ips.isvalid = 'Y';

