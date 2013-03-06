CREATE OR REPLACE FUNCTION asu_get1099bucket (
   p_cbpartner_id   IN   numeric,
   p_cut_date       IN   timestamp with time zone,
   p_bucket         IN   numeric
)
   RETURNS numeric
AS
$BODY$
DECLARE
   tmpvar   numeric;
/******************************************************************************
   NAME:       asu_get1099bucket
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        04/01/2008  Carlos Ruiz      1. Created this function.

******************************************************************************/
BEGIN
   SELECT SUM (  (COALESCE (linenetamt, 0) + COALESCE (taxamt, 0))
               * (CASE WHEN docbasetype = 'API' THEN 1
		       WHEN docbasetype = 'APC' THEN -1
		       ELSE 0
		  END)
              )            -- +API->AP Invoice / -APC->AP Credit Memo
     INTO tmpvar
     FROM C_INVOICE i, C_INVOICELINE il, ASU_1099BOX b, C_DOCTYPE dt
    WHERE i.c_invoice_id = il.c_invoice_id
      AND i.issotrx = 'N'
      AND il.asu_1099box_id = b.asu_1099box_id
      AND i.dateacct BETWEEN TRUNC (p_cut_date, 'YEAR') AND p_cut_date
      AND c_bpartner_id = p_cbpartner_id
      AND b.bucket = p_bucket
      AND i.c_doctype_id = dt.c_doctype_id
      AND i.docstatus IN ('CO', 'CL');

   RETURN tmpvar;
END;
$BODY$
   LANGUAGE plpgsql VOLATILE
   COST 100
;

