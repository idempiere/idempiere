-- IDEMPIERE-4426 Fix add_months and adddays functions

DROP VIEW c_invoice_candidate_v;
DROP VIEW rv_fact_adaxa;
DROP VIEW rv_openitemtodate;
DROP VIEW rv_openitem;

DROP OPERATOR + (timestamp with time ZONE, NUMERIC);
DROP OPERATOR - (timestamp with time ZONE, NUMERIC);
DROP FUNCTION addDays(TIMESTAMP WITH TIME ZONE, Numeric);
DROP FUNCTION subtractdays (TIMESTAMP WITH TIME ZONE, NUMERIC);
DROP FUNCTION add_months (TIMESTAMP WITH TIME ZONE, numeric);


CREATE OR REPLACE FUNCTION add_months (datetime TIMESTAMP WITH TIME ZONE, months NUMERIC)
RETURNS TIMESTAMP WITH TIME ZONE AS $$
BEGIN
	if datetime is null or months is null then
		return null;
	end if;
	return datetime + (interval '1' month * TRUNC(months));
END;
$$ LANGUAGE plpgsql IMMUTABLE
;



CREATE OR REPLACE FUNCTION addDays(datetime TIMESTAMP WITH TIME ZONE, days Numeric)
RETURNS TIMESTAMP WITH TIME ZONE AS $$
BEGIN
	if datetime is null or days is null then
		return null;
	end if;
	return datetime + (interval '1' second * (86400 * days));
END;
$$ LANGUAGE plpgsql IMMUTABLE;


CREATE OR REPLACE FUNCTION adddays (in inter interval, in days numeric)
RETURNS integer AS $$
BEGIN   
RETURN ( EXTRACT( EPOCH FROM ( inter ) ) / 86400 ) + days;
END;    
$$ LANGUAGE plpgsql IMMUTABLE;


CREATE OR REPLACE FUNCTION subtractdays (day TIMESTAMP WITH TIME ZONE, days NUMERIC)
RETURNS TIMESTAMP WITH TIME ZONE AS $$
BEGIN
    RETURN addDays(day,(days * -1));
END;
$$ LANGUAGE plpgsql IMMUTABLE;


CREATE OR REPLACE FUNCTION subtractdays (in inter interval, in days numeric)
RETURNS integer AS $$
BEGIN
RETURN ( EXTRACT( EPOCH FROM ( inter ) ) / 86400 ) - days;
END;
$$ LANGUAGE plpgsql IMMUTABLE;


CREATE OPERATOR + (
    PROCEDURE = adddays,
    LEFTARG = timestamp with time zone,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(+)
);



CREATE OPERATOR - (
    PROCEDURE = subtractdays,
    LEFTARG = timestamp with time zone,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(-)
);



CREATE OR REPLACE VIEW C_INVOICE_CANDIDATE_V
(AD_CLIENT_ID, AD_ORG_ID, C_BPARTNER_ID, C_ORDER_ID, DOCUMENTNO, 
 DATEORDERED, C_DOCTYPE_ID, TOTALLINES)
AS 
SELECT	
	o.AD_Client_ID, o.AD_Org_ID, o.C_BPartner_ID, o.C_Order_ID,
	o.DocumentNo, o.DateOrdered, o.C_DocType_ID,
	SUM((l.QtyOrdered-l.QtyInvoiced)*l.PriceActual) AS TotalLines
FROM C_Order o
  INNER JOIN C_OrderLine l ON (o.C_Order_ID=l.C_Order_ID)
  INNER JOIN C_BPartner bp ON (o.C_BPartner_ID=bp.C_BPartner_ID)
  LEFT OUTER JOIN C_InvoiceSchedule si ON (bp.C_InvoiceSchedule_ID=si.C_InvoiceSchedule_ID)
WHERE	o.DocStatus IN ('CO','CL','IP')	-- Standard Orders are IP
	--	not Offers and open Walkin-Receipts
	AND o.C_DocType_ID IN (SELECT C_DocType_ID FROM C_DocType
		WHERE DocBaseType='SOO' AND DocSubTypeSO NOT IN ('ON','OB','WR'))
	--	we need to invoice
	AND	l.QtyOrdered <> l.QtyInvoiced
	--
	AND (
		--	Immediate
		o.InvoiceRule='I'
		--	Order complete
		OR	(o.InvoiceRule='O' AND NOT EXISTS (SELECT 1 FROM C_OrderLine zz1
												WHERE zz1.C_Order_ID=o.C_Order_ID AND zz1.QtyOrdered<>zz1.QtyDelivered))
		--	Delivery
		OR	(o.InvoiceRule='D' AND l.QtyInvoiced<>l.QtyDelivered)
		--	Order Schedule, but none defined on Business Partner level
		OR	(o.InvoiceRule='S' AND bp.C_InvoiceSchedule_ID IS NULL)
		--	Schedule defined at BP
		OR	(o.InvoiceRule='S' AND bp.C_InvoiceSchedule_ID IS NOT NULL AND
				(
				--	Daily or none
					(si.InvoiceFrequency IS NULL OR si.InvoiceFrequency='D')
				--	Weekly
				OR	(si.InvoiceFrequency='W')
				--	Bi-Monthly
				OR	(si.InvoiceFrequency='T'
					AND ((TRUNC(o.DateOrdered) <= firstOf(getdate(),'MM')+si.InvoiceDayCutoff-1
						AND TRUNC(getdate()) >= firstOf(o.DateOrdered,'MM')+si.InvoiceDay-1)
					OR	(TRUNC(o.DateOrdered) <= firstOf(getdate(),'MM')+si.InvoiceDayCutoff+14
						AND TRUNC(getdate()) >= firstOf(o.DateOrdered,'MM')+si.InvoiceDay+14))
					)
				--	Monthly
				OR	(si.InvoiceFrequency='M'
					AND TRUNC(o.DateOrdered) <= firstOf(getdate(),'MM')+si.InvoiceDayCutoff-1	-- after cutoff
					AND TRUNC(getdate()) >= firstOf(o.DateOrdered,'MM')+si.InvoiceDay-1)		-- after invoice day
				)
			)
		)
GROUP BY o.AD_Client_ID, o.AD_Org_ID, o.C_BPartner_ID, o.C_Order_ID,
	o.DocumentNo, o.DateOrdered, o.C_DocType_ID;



CREATE OR REPLACE VIEW rv_fact_adaxa AS 
 SELECT f.ad_client_id, f.ad_org_id, ( SELECT cli.name
           FROM ad_client cli
          WHERE cli.ad_client_id = f.ad_client_id) AS clientname, f.dateacct, 
        CASE
            WHEN f.dateacct < (( SELECT clinfo.fy_startdate
               FROM ad_clientinfo clinfo
              WHERE clinfo.ad_client_id = f.ad_client_id)) THEN (( SELECT clinfo.fy_startdate - 1
               FROM ad_clientinfo clinfo
              WHERE clinfo.ad_client_id = f.ad_client_id))
            ELSE f.dateacct
        END AS bsdate, 
        CASE
            WHEN f.dateacct < (( SELECT clinfo.fy_startdate
               FROM ad_clientinfo clinfo
              WHERE clinfo.ad_client_id = f.ad_client_id)) THEN ( SELECT to_char((clinfo.fy_startdate - 1), 'YYYY-MM') AS to_char
               FROM ad_clientinfo clinfo
              WHERE clinfo.ad_client_id = f.ad_client_id)
            ELSE to_char(f.dateacct, 'YYYY-MM')
        END AS bsmth, to_char((f.dateacct + 184), '"FY"YYYY') AS fyear, to_char(f.dateacct, 'YYYY-MM') AS fymth, ( SELECT t.name
           FROM ad_table t
          WHERE t.ad_table_id = f.ad_table_id) AS table_name, f.record_id, ( SELECT gl.name
           FROM gl_budget gl
          WHERE gl.gl_budget_id = f.gl_budget_id) AS budname, ( SELECT tax.name
           FROM c_tax tax
          WHERE tax.c_tax_id = f.c_tax_id) AS taxname, 
        CASE f.postingtype
            WHEN 'A' THEN 'Actual'
            WHEN 'B' THEN 'Budget'
            WHEN 'E' THEN 'Encumbrance'
            WHEN 'S' THEN 'Statistic'
            ELSE 'Other'
        END AS act_bud, ( SELECT c.iso_code
           FROM c_currency c
          WHERE c.c_currency_id = f.c_currency_id) AS currency, f.amtsourcedr - f.amtsourcecr AS amtsce, f.amtacctdr - f.amtacctcr AS amtacct, 
        CASE
            WHEN f.postingtype = 'B' THEN 0
            ELSE f.amtacctcr - f.amtacctdr
        END AS "pl$act", 
        CASE
            WHEN f.postingtype = 'B' THEN 0
            WHEN ev.accounttype = 'A' THEN f.amtacctdr - f.amtacctcr
            WHEN ev.accounttype = 'L' THEN f.amtacctdr - f.amtacctcr
            WHEN ev.accounttype = 'O' THEN f.amtacctcr - f.amtacctdr
            WHEN ev.accounttype = 'E' THEN f.amtacctcr - f.amtacctdr
            WHEN ev.accounttype = 'R' THEN f.amtacctcr - f.amtacctdr
            ELSE 0
        END AS "bs$act", 
        CASE
            WHEN f.postingtype = 'A' THEN 0
            WHEN ev.accounttype = 'E' THEN f.amtacctcr - f.amtacctdr
            WHEN ev.accounttype = 'R' THEN f.amtacctcr - f.amtacctdr
            ELSE 0
        END AS "pl$bud", ( SELECT um.uomsymbol
           FROM c_uom um
          WHERE um.c_uom_id = f.c_uom_id) AS uomname, f.qty, ( SELECT prj.name
           FROM c_project prj
          WHERE prj.c_project_id = f.c_project_id) AS projectname, f.description, o.name AS orgname, ev.value AS ac_code, ev.name AS ac_name, (ev.value || '-' || ev.name) AS account_name, 
        CASE ev.accounttype
            WHEN 'A' THEN '1 Asset'
            WHEN 'E' THEN '3 Equity'
            WHEN 'L' THEN '2 Liability'
            WHEN 'M' THEN '9 Memo'
            WHEN 'O' THEN '3 Equity'
            WHEN 'R' THEN '3 Equity'
            ELSE '9. Unknown'
        END AS bstypename, 
        CASE ev.accounttype
            WHEN 'A' THEN '9 BSheet'
            WHEN 'E' THEN '6 Expense'
            WHEN 'L' THEN '9 BSheet'
            WHEN 'M' THEN '9 Memo'
            WHEN 'O' THEN '9 BSheet'
            WHEN 'R' THEN '4 Revenue'
            ELSE '9. Unknown'
        END AS pltypename, ( SELECT (ss.value || '-') || ss.name
           FROM c_elementvalue ss
          WHERE ss.value = substr(ev.value, 1, 1) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id) AS ac_group, 
        CASE ev.accounttype
            WHEN 'A' THEN (( SELECT (ss.value || '-') || ss.name
               FROM c_elementvalue ss
              WHERE ss.value = substr(ev.value, 1, 3) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id))
            WHEN 'E' THEN '330-Current P and L Accounts Balance'
            WHEN 'L' THEN (( SELECT (ss.value || '-') || ss.name
               FROM c_elementvalue ss
              WHERE ss.value = substr(ev.value, 1, 3) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id))
            WHEN 'O' THEN (( SELECT (ss.value || '-') || ss.name
               FROM c_elementvalue ss
              WHERE ss.value = substr(ev.value, 1, 3) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id))
            WHEN 'R' THEN '330-Current P and L Accounts Balance'
            ELSE 'Unknown Account Type'
        END AS bsgroup, 
        CASE ev.accounttype
            WHEN 'A' THEN '999-Balance Sheet Item'
            WHEN 'E' THEN (( SELECT (ss.value || '-') || ss.name
               FROM c_elementvalue ss
              WHERE ss.value = substr(ev.value, 1, 3) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id))
            WHEN 'L' THEN '999-Balance Sheet Item'
            WHEN 'O' THEN '999-Balance Sheet Item'
            WHEN 'R' THEN (( SELECT (ss.value || '-') || ss.name
               FROM c_elementvalue ss
              WHERE ss.value = substr(ev.value, 1, 3) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id))
            ELSE 'Unknown Account Type'
        END AS plgroup, 
        CASE ev.accounttype
            WHEN 'A' THEN 'BS'
            WHEN 'E' THEN 'PL'
            WHEN 'L' THEN 'BS'
            WHEN 'M' THEN 'Unknown Account Type'
            WHEN 'O' THEN 'BS'
            WHEN 'R' THEN 'PL'
            ELSE 'Unknown Account Type'
        END AS plbs, 
        CASE ev.accounttype
            WHEN 'A' THEN '1 NetAssets'
            WHEN 'E' THEN '2 Equity'
            WHEN 'L' THEN '1 NetAssets'
            WHEN 'M' THEN '9 Memo'
            WHEN 'O' THEN '2 Equity'
            WHEN 'R' THEN '2 Equity'
            ELSE 'Unknown Account Type'
        END AS na_eq, bp.value AS bpcode, bp.name AS bpname, 
        CASE
            WHEN bp.name IS NULL THEN NULL
            ELSE (bp.value || '-') || bp.name
        END AS bpartnercodeandname, ( SELECT bpg.name
           FROM c_bp_group bpg
          WHERE bpg.c_bp_group_id = bp.c_bp_group_id) AS bpgroupname, ( SELECT ad_user.name
           FROM ad_user
          WHERE ad_user.ad_user_id = bp.salesrep_id) AS repname, p.value AS prodcode, p.name AS prodname, 
        CASE
            WHEN p.name IS NULL THEN NULL
            ELSE (p.value || '-') || p.name
        END AS product, ( SELECT pc.name
           FROM m_product_category pc
          WHERE pc.m_product_category_id = p.m_product_category_id) AS prodcategory
   FROM fact_acct f
   JOIN ad_org o ON f.ad_org_id = o.ad_org_id
   JOIN c_elementvalue ev ON f.account_id = ev.c_elementvalue_id
   LEFT JOIN c_bpartner bp ON f.c_bpartner_id = bp.c_bpartner_id
   LEFT JOIN m_product p ON f.m_product_id = p.m_product_id
;


CREATE OR REPLACE VIEW RV_OPENITEMTODATE
(AD_ORG_ID, AD_CLIENT_ID, DOCUMENTNO, C_INVOICE_ID, C_ORDER_ID, 
 C_BPARTNER_ID, ISSOTRX, DATEINVOICED, DATEACCT, NETDAYS, 
 DUEDATE, DAYSDUE, DISCOUNTDATE, DISCOUNTAMT, GRANDTOTAL, 
 --PAIDAMT, OPENAMT, 
 C_CURRENCY_ID, C_CONVERSIONTYPE_ID, C_PAYMENTTERM_ID, 
 ISPAYSCHEDULEVALID, C_INVOICEPAYSCHEDULE_ID, INVOICECOLLECTIONTYPE, C_CAMPAIGN_ID, C_PROJECT_ID, 
 C_ACTIVITY_ID)
AS 
SELECT i.AD_Org_ID, i.AD_Client_ID,
	i.DocumentNo, i.C_Invoice_ID, i.C_Order_ID, i.C_BPartner_ID, i.IsSOTrx,
	i.DateInvoiced, i.DateAcct,
    p.NetDays,
	paymentTermDueDate(i.C_PaymentTerm_ID, i.DateInvoiced) AS DueDate,
	paymentTermDueDays(i.C_PaymentTerm_ID, i.DateInvoiced, getdate()) AS DaysDue,
    addDays(i.DateInvoiced,p.DiscountDays) AS DiscountDate,
    currencyRound(i.GrandTotal*p.Discount/100,i.C_Currency_ID,'N') AS DiscountAmt,
	i.GrandTotal,
	--invoicePaid(i.C_Invoice_ID, i.C_Currency_ID, 1) AS PaidAmt,
	--invoiceOpen(i.C_Invoice_ID,0) AS OpenAmt,
    i.C_Currency_ID, i.C_ConversionType_ID,
    i.C_PaymentTerm_ID,
    i.IsPayScheduleValid, cast(null as numeric) AS C_InvoicePaySchedule_ID, i.InvoiceCollectionType,
    i.C_Campaign_ID, i.C_Project_ID, i.C_Activity_ID
FROM RV_C_Invoice i
    INNER JOIN C_PaymentTerm p ON (i.C_PaymentTerm_ID=p.C_PaymentTerm_ID)
WHERE --    i.IsPaid='N'
    --invoiceOpen(i.C_Invoice_ID,0) <> 0 AND 
    i.IsPayScheduleValid<>'Y'
    AND i.DocStatus IN ('CO','CL')
UNION
SELECT i.AD_Org_ID, i.AD_Client_ID,
    i.DocumentNo, i.C_Invoice_ID, i.C_Order_ID, i.C_BPartner_ID, i.IsSOTrx,
	i.DateInvoiced, i.DateAcct,
    daysBetween(ips.DueDate,i.DateInvoiced) AS NetDays,
    ips.DueDate,
    daysBetween(getdate(),ips.DueDate) AS DaysDue,
    ips.DiscountDate,
    ips.DiscountAmt,
	ips.DueAmt AS GrandTotal,
	--invoicePaid(i.C_Invoice_ID, i.C_Currency_ID, 1) AS PaidAmt,
	--invoiceOpen(i.C_Invoice_ID, ips.C_InvoicePaySchedule_ID) AS OpenAmt,
    i.C_Currency_ID, i.C_ConversionType_ID,
    i.C_PaymentTerm_ID,
    i.IsPayScheduleValid, ips.C_InvoicePaySchedule_ID, i.InvoiceCollectionType,
    i.C_Campaign_ID, i.C_Project_ID, i.C_Activity_ID
FROM RV_C_Invoice i
    INNER JOIN C_InvoicePaySchedule ips ON (i.C_Invoice_ID=ips.C_Invoice_ID)
WHERE  --   i.IsPaid='N'
    --invoiceOpen(i.C_Invoice_ID,ips.C_InvoicePaySchedule_ID) <> 0 AND 
    i.IsPayScheduleValid='Y'
    AND i.DocStatus IN ('CO','CL')
    AND ips.IsValid='Y';


CREATE OR REPLACE VIEW rv_openitem AS 
SELECT i.ad_org_id,
    i.ad_client_id,
    i.documentno,
    i.c_invoice_id,
    i.c_order_id,
    i.c_bpartner_id,
    i.issotrx,
    i.dateinvoiced,
    i.dateacct,
    p.netdays,
    paymenttermduedate(i.c_paymentterm_id, i.dateinvoiced)            AS duedate,
    paymenttermduedays(i.c_paymentterm_id, i.dateinvoiced, getdate()) AS daysdue,
    adddays(i.dateinvoiced, p.discountdays)                           AS discountdate,
    currencyRound(i.grandtotal * p.discount / 100,i.C_Currency_ID,'N')                         AS discountamt,
    i.grandtotal,
    invoicepaid(i.c_invoice_id, i.c_currency_id, 1)                   AS paidamt,
    invoiceopen(i.c_invoice_id, 0)                                    AS openamt,
    i.c_currency_id,
    i.c_conversiontype_id,
    i.c_paymentterm_id,
    i.ispayschedulevalid,
    NULL                                                              AS c_invoicepayschedule_id,
    i.invoicecollectiontype,
    i.c_campaign_id,
    i.c_project_id,
    i.c_activity_id,
    i.c_invoice_ad_orgtrx_id                                          AS ad_orgtrx_id,
    i.ad_user_id,
    i.c_bpartner_location_id,
    i.c_charge_id,
    i.c_doctype_id,
    i.c_doctypetarget_id,
    i.c_dunninglevel_id,
    i.chargeamt,
    i.c_payment_id,
    i.created,
    i.createdby,
    i.dateordered,
    i.dateprinted,
    i.description,
    i.docaction,
    i.docstatus,
    i.dunninggrace,
    i.generateto,
    i.isactive,
    i.isapproved,
    i.isdiscountprinted,
    i.isindispute,
    i.ispaid,
    i.isprinted,
    i.c_invoice_isselfservice                                         AS isselfservice,
    i.istaxincluded,
    i.istransferred,
    i.m_pricelist_id,
    i.m_rma_id,
    i.paymentrule,
    i.poreference,
    i.posted,
    i.processedon,
    i.processing,
    i.ref_invoice_id,
    i.reversal_id,
    i.salesrep_id,
    i.sendemail,
    i.totallines,
    i.updated,
    i.updatedby,
    i.user1_id,
    i.user2_id 
FROM rv_c_invoice i 
        JOIN c_paymentterm p 
        ON i.c_paymentterm_id = p.c_paymentterm_id 
WHERE invoiceopen(i.c_invoice_id, 0) <> 0 AND i.ispayschedulevalid <> 'Y' AND i.docstatus IN ('CO',
    'CL') 
UNION 
SELECT i.ad_org_id,
    i.ad_client_id,
    i.documentno,
    i.c_invoice_id,
    i.c_order_id,
    i.c_bpartner_id,
    i.issotrx,
    i.dateinvoiced,
    i.dateacct,
    daysbetween(ips.duedate, i.dateinvoiced)                 AS netdays,
    ips.duedate,
    daysbetween(getdate(), ips.duedate)                      AS daysdue,
    ips.discountdate,
    ips.discountamt,
    ips.dueamt                                               AS grandtotal,
    invoicepaid(i.c_invoice_id, i.c_currency_id, 1)          AS paidamt,
    invoiceopen(i.c_invoice_id, ips.c_invoicepayschedule_id) AS openamt,
    i.c_currency_id,
    i.c_conversiontype_id,
    i.c_paymentterm_id,
    i.ispayschedulevalid,
    ips.c_invoicepayschedule_id,
    i.invoicecollectiontype,
    i.c_campaign_id,
    i.c_project_id,
    i.c_activity_id,
    i.c_invoice_ad_orgtrx_id                                 AS ad_orgtrx_id,
    i.ad_user_id,
    i.c_bpartner_location_id,
    i.c_charge_id,
    i.c_doctype_id,
    i.c_doctypetarget_id,
    i.c_dunninglevel_id,
    i.chargeamt,
    i.c_payment_id,
    i.created,
    i.createdby,
    i.dateordered,
    i.dateprinted,
    i.description,
    i.docaction,
    i.docstatus,
    i.dunninggrace,
    i.generateto,
    i.isactive,
    i.isapproved,
    i.isdiscountprinted,
    i.isindispute,
    i.ispaid,
    i.isprinted,
    i.c_invoice_isselfservice                                AS isselfservice,
    i.istaxincluded,
    i.istransferred,
    i.m_pricelist_id,
    i.m_rma_id,
    i.paymentrule,
    i.poreference,
    i.posted,
    i.processedon,
    i.processing,
    i.ref_invoice_id,
    i.reversal_id,
    i.salesrep_id,
    i.sendemail,
    i.totallines,
    i.updated,
    i.updatedby,
    i.user1_id,
    i.user2_id 
FROM rv_c_invoice i 
        JOIN c_invoicepayschedule ips 
        ON i.c_invoice_id = ips.c_invoice_id 
WHERE invoiceopen(i.c_invoice_id, ips.c_invoicepayschedule_id) <> 0 AND i.ispayschedulevalid = 'Y' AND i.docstatus IN ('CO',
    'CL') AND ips.isvalid = 'Y'
;

SELECT register_migration_script('202008171626_IDEMPIERE-4426.sql') FROM dual
;

