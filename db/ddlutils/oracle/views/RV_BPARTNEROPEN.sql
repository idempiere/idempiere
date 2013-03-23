DROP VIEW rv_bpartneropen;

CREATE OR REPLACE VIEW rv_bpartneropen
AS
  SELECT i.ad_client_id,
         i.ad_org_id,
         i.isactive,
         i.created,
         i.createdby,
         i.updated,
         i.updatedby,
         i.c_bpartner_id,
         i.c_currency_id,
         i.grandtotal * i.multiplierap                                                                                    AS amt,
         invoiceopen(i.c_invoice_id, i.c_invoicepayschedule_id) * i.multiplierap                                          AS openamt,
         i.dateinvoiced                                                                                                   AS datedoc,
         COALESCE(daysbetween(getdate(), ips.duedate), paymenttermduedays(i.c_paymentterm_id, i.dateinvoiced, getdate())) AS daysdue,
         i.c_campaign_id,
         i.c_project_id,
         i.c_activity_id,
         i.ad_orgtrx_id,
         i.c_charge_id,
         i.c_conversiontype_id,
         i.c_doctype_id,
         i.chargeamt,
         i.c_invoice_id,
         i.c_order_id,
         i.c_payment_id,
         i.dateacct,
         i.description,
         i.docstatus,
         i.documentno,
         i.isapproved,
         i.isselfservice,
         i.posted,
         i.processedon,
         i.reversal_id
  FROM   c_invoice_v i
         LEFT JOIN c_invoicepayschedule ips
                ON i.c_invoicepayschedule_id = ips.c_invoicepayschedule_id
  WHERE  i.ispaid = 'N'
         AND i.docstatus IN ( 'CO', 'CL' )
  UNION
  SELECT p.ad_client_id,
         p.ad_org_id,
         p.isactive,
         p.created,
         p.createdby,
         p.updated,
         p.updatedby,
         p.c_bpartner_id,
         p.c_currency_id,
         p.payamt * p.multiplierap * ( -1 )                         AS amt,
         paymentavailable(p.c_payment_id) * p.multiplierap * ( -1 ) AS openamt,
         p.datetrx                                                  AS datedoc,
         NULL                                                       AS daysdue,
         p.c_campaign_id,
         p.c_project_id,
         p.c_activity_id,
         p.ad_orgtrx_id,
         p.c_charge_id,
         p.c_conversiontype_id,
         p.c_doctype_id,
         p.chargeamt,
         p.c_invoice_id,
         p.c_order_id,
         p.c_payment_id,
         p.dateacct,
         p.description,
         p.docstatus,
         p.documentno,
         p.isapproved,
         p.isselfservice,
         p.posted,
         p.processedon,
         p.reversal_id
  FROM   c_payment_v p
  WHERE  p.isallocated = 'N'
         AND p.c_bpartner_id IS NOT NULL
         AND p.docstatus IN ( 'CO', 'CL' )
;

