CREATE OR REPLACE FUNCTION get1099bucket (
   p_cbpartner_id   IN   NUMBER,
   p_cut_date       IN   DATE,
   p_bucket         IN   NUMBER
)
   RETURN NUMBER
IS
   tmpvar   NUMBER;
/******************************************************************************
   NAME:       get1099bucket
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        04/01/2008  Carlos Ruiz      1. Created this function.

******************************************************************************/
BEGIN
   SELECT SUM (  (NVL (linenetamt, 0) + NVL (taxamt, 0))
               * DECODE
                       (docbasetype,
                        'API', 1,
                        'APC', -1,
                        0
                       )            -- +API->AP Invoice / -APC->AP Credit Memo
              )
     INTO tmpvar
     FROM C_INVOICE i, C_INVOICELINE il, C_1099BOX b, C_DOCTYPE dt
    WHERE i.c_invoice_id = il.c_invoice_id
      AND i.issotrx = 'N'
      AND il.c_1099box_id = b.c_1099box_id
      AND i.dateacct BETWEEN TRUNC (p_cut_date, 'YEAR') AND p_cut_date
      AND c_bpartner_id = p_cbpartner_id
      AND b.bucket = p_bucket
      AND i.c_doctype_id = dt.c_doctype_id
      AND i.docstatus IN ('CO', 'CL');

   RETURN tmpvar;
END get1099bucket;
/

