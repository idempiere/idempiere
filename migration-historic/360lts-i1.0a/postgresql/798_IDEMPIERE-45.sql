-- Aug 4, 2011 11:42:53 PM COT
UPDATE AD_Ref_Table SET WhereClause='(C_Invoice_ID=@C_Invoice_ID@ AND IsSOTrx=''Y'') OR
M_InOut_ID IN (
  SELECT m.M_InOut_ID from /* intentionally lowercase */ M_InOut m
    LEFT JOIN M_InOutline ml ON ml.M_InOut_ID = m.M_InOut_ID
    LEFT JOIN c_invoiceline il ON il.M_InOutline_ID = ml.M_InOutline_ID
  where il.C_Invoice_ID=@C_Invoice_ID@ AND m.MovementType IN (''C-'')
)',Updated=TO_TIMESTAMP('2011-08-04 23:42:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=53345
;

-- Aug 4, 2011 11:44:25 PM COT
UPDATE AD_Ref_Table SET WhereClause='(C_Order_ID=@C_Order_ID@ AND IsSOTrx=''Y'') OR
C_Invoice_ID IN (
  SELECT i.C_Invoice_ID from /* intentionally lowercase */ C_Invoice i
    LEFT JOIN C_InvoiceLine il ON il.C_Invoice_ID = i.C_Invoice_ID
    LEFT JOIN C_OrderLine ol ON ol.C_OrderLine_ID = il.C_OrderLine_ID
  where ol.C_Order_ID=@C_Order_ID@ AND i.isSOTrx=''Y''
)',Updated=TO_TIMESTAMP('2011-08-04 23:44:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=53334
;

-- Aug 4, 2011 11:44:54 PM COT
UPDATE AD_Ref_Table SET WhereClause='(C_Order_ID=@C_Order_ID@ AND IsSOTrx=''Y'') OR
M_InOut_ID IN (
  SELECT i.M_InOut_ID from /* intentionally lowercase */ M_InOut i
    LEFT JOIN M_InOutline il ON il.M_InOut_ID = i.M_InOut_ID
    LEFT JOIN C_OrderLine ol ON ol.C_OrderLine_ID = il.C_OrderLine_ID
  where ol.C_Order_ID=@C_Order_ID@ AND i.MovementType IN (''C-'')
)',Updated=TO_TIMESTAMP('2011-08-04 23:44:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=53347
;

