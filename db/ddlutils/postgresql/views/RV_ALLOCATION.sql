DROP VIEW rv_allocation;

CREATE OR REPLACE VIEW rv_allocation AS 
 SELECT h.c_allocationhdr_id, h.ad_client_id, h.ad_org_id, h.isactive, h.created, h.createdby, h.updated, h.updatedby, h.documentno, h.description, h.datetrx, h.dateacct, h.c_currency_id, h.approvalamt, h.ismanual, h.docstatus, h.docaction, h.processed, l.c_allocationline_id, l.c_invoice_id, l.c_bpartner_id, l.c_order_id, l.c_payment_id, l.c_cashline_id, l.amount, l.discountamt, l.writeoffamt, l.overunderamt, h.isapproved, h.posted, l.ad_org_id AS c_allocationline_ad_org_id, l.created AS c_allocationline_created, l.createdby AS c_allocationline_createdby, l.datetrx AS c_allocationline_datetrx, l.isactive AS c_allocationline_isactive, l.ismanual AS c_allocationline_ismanual, l.updated AS c_allocationline_updated, l.updatedby AS c_allocationline_updatedby
   FROM c_allocationhdr h
   JOIN c_allocationline l ON h.c_allocationhdr_id = l.c_allocationhdr_id;

