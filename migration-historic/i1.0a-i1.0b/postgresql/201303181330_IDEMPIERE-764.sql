-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
ALTER TABLE c_invoiceline RENAME asu_1099box_id TO c_1099box_id
;

ALTER TABLE i_invoice RENAME asu_1099box_id TO c_1099box_id
;

ALTER TABLE i_invoice RENAME asu_1099box_value TO c_1099box_value
;

ALTER TABLE asu_1099box RENAME TO c_1099box
;

ALTER TABLE c_1099box RENAME asu_1099box_id TO c_1099box_id
;

ALTER TABLE c_1099box RENAME asu_1099box_uu TO c_1099box_uu
;

-- Mar 18, 2013 1:26:33 PM COT
UPDATE AD_Sequence SET Description='Table C_1099Box', Name='C_1099Box',Updated=TO_TIMESTAMP('2013-03-18 13:26:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200064
;

-- Mar 18, 2013 1:28:05 PM COT
UPDATE AD_Table SET TableName='C_1099Box',Updated=TO_TIMESTAMP('2013-03-18 13:28:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200069
;

-- Mar 18, 2013 1:28:22 PM COT
UPDATE AD_Element SET ColumnName='C_1099Box_ID',Updated=TO_TIMESTAMP('2013-03-18 13:28:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202246
;

-- Mar 18, 2013 1:28:23 PM COT
UPDATE AD_Column SET ColumnName='C_1099Box_ID', Name='1099 Box', Description=NULL, Help=NULL WHERE AD_Element_ID=202246
;

-- Mar 18, 2013 1:28:23 PM COT
UPDATE AD_Process_Para SET ColumnName='C_1099Box_ID', Name='1099 Box', Description=NULL, Help=NULL, AD_Element_ID=202246 WHERE UPPER(ColumnName)='C_1099BOX_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 1:28:23 PM COT
UPDATE AD_Process_Para SET ColumnName='C_1099Box_ID', Name='1099 Box', Description=NULL, Help=NULL WHERE AD_Element_ID=202246 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 1:28:23 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_1099Box_ID', Name='1099 Box', Description=NULL, Help=NULL WHERE AD_Element_ID=202246 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 1:28:37 PM COT
UPDATE AD_Element SET ColumnName='C_1099Box_UU', Name='C_1099Box_UU', PrintName='C_1099Box_UU',Updated=TO_TIMESTAMP('2013-03-18 13:28:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202247
;

-- Mar 18, 2013 1:28:37 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202247
;

-- Mar 18, 2013 1:28:37 PM COT
UPDATE AD_Column SET ColumnName='C_1099Box_UU', Name='C_1099Box_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202247
;

-- Mar 18, 2013 1:28:37 PM COT
UPDATE AD_Process_Para SET ColumnName='C_1099Box_UU', Name='C_1099Box_UU', Description=NULL, Help=NULL, AD_Element_ID=202247 WHERE UPPER(ColumnName)='C_1099BOX_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 1:28:37 PM COT
UPDATE AD_Process_Para SET ColumnName='C_1099Box_UU', Name='C_1099Box_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202247 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 1:28:37 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_1099Box_UU', Name='C_1099Box_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202247 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 1:28:37 PM COT
UPDATE AD_Field SET Name='C_1099Box_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202247) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 1:28:37 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_1099Box_UU', Name='C_1099Box_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202247)
;

-- Mar 18, 2013 1:28:43 PM COT
UPDATE AD_Element SET ColumnName='C_1099Box_Value',Updated=TO_TIMESTAMP('2013-03-18 13:28:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202251
;

-- Mar 18, 2013 1:28:43 PM COT
UPDATE AD_Column SET ColumnName='C_1099Box_Value', Name='1099 Box Value', Description=NULL, Help=NULL WHERE AD_Element_ID=202251
;

-- Mar 18, 2013 1:28:43 PM COT
UPDATE AD_Process_Para SET ColumnName='C_1099Box_Value', Name='1099 Box Value', Description=NULL, Help=NULL, AD_Element_ID=202251 WHERE UPPER(ColumnName)='C_1099BOX_VALUE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 1:28:43 PM COT
UPDATE AD_Process_Para SET ColumnName='C_1099Box_Value', Name='1099 Box Value', Description=NULL, Help=NULL WHERE AD_Element_ID=202251 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 1:28:43 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_1099Box_Value', Name='1099 Box Value', Description=NULL, Help=NULL WHERE AD_Element_ID=202251 AND IsCentrallyMaintained='Y'
;

DROP FUNCTION asu_get1099bucket (in p_cbpartner_id numeric, in p_cut_date timestamptz, in p_bucket numeric)
;

CREATE OR REPLACE FUNCTION get1099bucket (
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
   NAME:       get1099bucket
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
END;
$BODY$
   LANGUAGE plpgsql VOLATILE
   COST 100
;

-- Mar 18, 2013 1:41:45 PM COT
-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
UPDATE AD_Column SET IsSelectionColumn='N',Updated=TO_TIMESTAMP('2013-03-18 13:41:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2813
;

-- Mar 18, 2013 1:42:12 PM COT
-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
UPDATE AD_Column SET IsSelectionColumn='Y',Updated=TO_TIMESTAMP('2013-03-18 13:42:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4656
;

-- Mar 18, 2013 1:42:36 PM COT
-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
UPDATE AD_Process SET Classname='org.adempiere.process.Fill1099Extract',Updated=TO_TIMESTAMP('2013-03-18 13:42:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200034
;

SELECT register_migration_script('201303181330_IDEMPIERE-764.sql') FROM dual
;

