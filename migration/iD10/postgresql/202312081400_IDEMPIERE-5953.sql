-- IDEMPIERE-5953 Can not select Order or Material receipt on Create lines from on Vendor Invoice as it do not show any value
SELECT register_migration_script('202312081400_IDEMPIERE-5953.sql') FROM dual;

-- Dec 8, 2023, 2:00:16 PM CET
UPDATE AD_Val_Rule SET Code='C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus IN (''CL'',''CO'')
AND C_Order_ID IN (SELECT C_Order_ID FROM C_OrderLine WHERE QtyOrdered-QtyDelivered!=0)
AND M_Warehouse_ID = (CASE WHEN @M_Warehouse_ID@>0 THEN @M_Warehouse_ID@ ELSE M_Warehouse_ID END)',Updated=TO_TIMESTAMP('2023-12-08 14:00:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200164
;

-- Dec 8, 2023, 2:52:48 PM CET
UPDATE AD_InfoWindow SET WhereClause='(CASE WHEN (SELECT COUNT(*) from C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC'',''ARC''))=1 THEN v.CreditQty*v.Multiplier <> 0 ELSE v.Qty*v.Multiplier <> 0 END) 
AND (v.C_OrderLine_ID IS NULL OR v.C_OrderLine_ID NOT IN (SELECT il.C_OrderLine_ID FROM C_InvoiceLine il, C_Invoice i WHERE il.C_Invoice_ID = i.C_Invoice_ID AND i.DocStatus=''IP'' AND il.C_OrderLine_ID > 0)) 
AND (v.M_InOutLine_ID IS NULL OR v.M_InOutLine_ID NOT IN (SELECT il.M_InOutLine_ID FROM C_InvoiceLine il, C_Invoice i WHERE il.C_Invoice_ID = i.C_Invoice_ID AND i.DocStatus=''IP'' AND il.M_InOutLine_ID > 0))
AND (v.M_RMALine_ID IS NULL OR v.M_RMALine_ID NOT IN (SELECT il.M_RMALine_ID FROM C_InvoiceLine il, C_Invoice i WHERE il.C_Invoice_ID = i.C_Invoice_ID AND i.DocStatus=''IP'' AND il.M_RMALine_ID > 0))', IsValid='Y',Updated=TO_TIMESTAMP('2023-12-08 14:52:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200024
;

-- Dec 8, 2023, 2:53:43 PM CET
UPDATE AD_InfoColumn SET SelectClause='(CASE WHEN (SELECT COUNT(*) from C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC'',''ARC''))=1 THEN v.CreditQty*v.Multiplier ELSE v.Qty*v.Multiplier END)',Updated=TO_TIMESTAMP('2023-12-08 14:53:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200269
;

-- Dec 8, 2023, 3:17:46 PM CET
UPDATE AD_Val_Rule SET Code='Bill_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus IN (''CL'',''CO'')
AND 
(
 (
  (SELECT COUNT(*) FROM C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC'',''ARC''))=1 AND C_Order_ID IN (SELECT ol.C_Order_ID FROM C_OrderLine ol WHERE ol.QtyInvoiced>0 AND ((ol.QtyDelivered>=ol.QtyOrdered AND ol.QtyDelivered-ol.QtyInvoiced!=0) OR (ol.QtyDelivered<ol.QtyOrdered)))
 )
 OR
 (
  (SELECT COUNT(*) FROM C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC'',''ARC''))!=1 AND C_Order_ID IN (SELECT ol.C_Order_ID FROM C_OrderLine ol WHERE (ol.QtyOrdered-ol.QtyInvoiced!=0))
 )
)',Updated=TO_TIMESTAMP('2023-12-08 15:17:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200168
;

-- Dec 8, 2023, 4:13:09 PM CET
UPDATE AD_Val_Rule SET Code='C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND DocStatus IN (''CL'',''CO'') AND
(
 (
  IsSOTrx=''N'' AND
  M_InOut_ID IN (
SELECT sl.M_InOut_ID FROM M_InOutLine sl
LEFT OUTER JOIN M_MatchInv mi ON (sl.M_InOutLine_ID=mi.M_InOutLine_ID)
JOIN M_InOut s2 ON (sl.M_InOut_ID=s2.M_InOut_ID)
WHERE s2.C_BPartner_ID=@C_BPartner_ID@ AND s2.IsSOTrx=''@IsSOTrx@'' AND s2.DocStatus IN (''CL'',''CO'')
GROUP BY sl.M_InOut_ID,sl.MovementQty,s2.MovementType,mi.M_InOutLine_ID
HAVING (sl.MovementQty <> SUM(mi.Qty) * CASE WHEN s2.MovementType = ''V-'' THEN -1 ELSE 1 END
AND mi.M_InOutLine_ID IS NOT NULL) OR mi.M_InOutLine_ID IS NULL
)
 )
OR
 (
 IsSOTrx!=''N'' AND
 M_InOut_ID IN (
SELECT sl.M_InOut_ID FROM M_InOutLine sl
INNER JOIN M_InOut s2 ON (sl.M_InOut_ID=s2.M_InOut_ID)
LEFT JOIN C_InvoiceLine il ON sl.M_InOutLine_ID = il.M_InOutLine_ID
WHERE s2.C_BPartner_ID=@C_BPartner_ID@ AND s2.IsSOTrx=''@IsSOTrx@'' AND s2.DocStatus IN (''CL'',''CO'')
GROUP BY sl.M_InOut_ID,sl.MovementQty
HAVING sl.MovementQty - sum(COALESCE(il.QtyInvoiced,0)) > 0
)
 )
)',Updated=TO_TIMESTAMP('2023-12-08 16:13:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200167
;

-- Dec 8, 2023, 4:26:45 PM CET
UPDATE AD_InfoWindow SET WhereClause='(
((SELECT COUNT(*) FROM C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC'',''ARC''))=1 AND v.CreditQty * v.Multiplier <> 0)
OR
((SELECT COUNT(*) FROM C_DocType WHERE C_DocType_ID=@C_DocTypeTarget_ID@ AND DocBaseType IN (''APC'',''ARC''))!=1 AND v.Qty * v.Multiplier <> 0)
)
AND (v.C_OrderLine_ID IS NULL OR v.C_OrderLine_ID NOT IN (SELECT il.C_OrderLine_ID FROM C_InvoiceLine il, C_Invoice i WHERE il.C_Invoice_ID = i.C_Invoice_ID AND i.DocStatus=''IP'' AND il.C_OrderLine_ID > 0))
AND (v.M_InOutLine_ID IS NULL OR v.M_InOutLine_ID NOT IN (SELECT il.M_InOutLine_ID FROM C_InvoiceLine il, C_Invoice i WHERE il.C_Invoice_ID = i.C_Invoice_ID AND i.DocStatus=''IP'' AND il.M_InOutLine_ID > 0))
AND (v.M_RMALine_ID IS NULL OR v.M_RMALine_ID NOT IN (SELECT il.M_RMALine_ID FROM C_InvoiceLine il, C_Invoice i WHERE il.C_Invoice_ID = i.C_Invoice_ID AND i.DocStatus=''IP'' AND il.M_RMALine_ID > 0))
', IsValid='Y',Updated=TO_TIMESTAMP('2023-12-08 16:26:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200024
;

