SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2442 Always using default conversion type in Order & Invoice window's amount summary information
-- Aug 7, 2018 12:22:32 PM CEST
UPDATE AD_StatusLine SET SQLStatement='SELECT COUNT(DISTINCT C_OrderLine_ID) AS Lines,o.TotalLines,o.GrandTotal,c.ISO_Code, 
currencyConvert(o.GrandTotal,o.C_Currency_ID,ac.C_Currency_ID,o.DateAcct,o.C_ConversionType_ID,o.AD_Client_ID,o.AD_Org_ID) AS ConvAmt
FROM C_Order o
INNER JOIN C_Currency c ON (o.C_Currency_ID=c.C_Currency_ID)
LEFT JOIN C_OrderLine l ON (o.C_Order_ID=l.C_Order_ID)
LEFT JOIN AD_ClientInfo ci ON (ci.AD_Client_ID=o.AD_Client_ID)
LEFT JOIN C_AcctSchema ac ON (ci.C_AcctSchema1_ID=ac.C_AcctSchema_ID)
WHERE o.C_Order_ID=@C_Order_ID@
GROUP BY o.C_Currency_ID, ac.C_Currency_ID, o.C_ConversionType_ID, c.ISO_Code, o.TotalLines, o.GrandTotal, o.DateAcct, o.AD_Client_ID, o.AD_Org_ID',Updated=TO_DATE('2018-08-07 12:22:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_StatusLine_ID=200000
;

-- Aug 7, 2018 12:25:27 PM CEST
UPDATE AD_StatusLine SET SQLStatement='SELECT COUNT(DISTINCT C_InvoiceLine_ID) AS Lines,o.TotalLines,o.GrandTotal,c.ISO_Code,
currencyConvert(o.GrandTotal,o.C_Currency_ID,ac.C_Currency_ID,o.DateAcct,o.C_ConversionType_ID,o.AD_Client_ID,o.AD_Org_ID) AS ConvAmt
FROM C_Invoice o
INNER JOIN C_Currency c ON (o.C_Currency_ID=c.C_Currency_ID)
LEFT JOIN C_InvoiceLine l ON (o.C_Invoice_ID=l.C_Invoice_ID)
LEFT JOIN AD_ClientInfo ci ON (ci.AD_Client_ID=o.AD_Client_ID)
LEFT JOIN C_AcctSchema ac ON (ci.C_AcctSchema1_ID=ac.C_AcctSchema_ID)
WHERE o.C_Invoice_ID=@C_Invoice_ID@
GROUP BY o.C_Currency_ID, ac.C_Currency_ID, o.C_ConversionType_ID, c.ISO_Code, o.TotalLines, o.GrandTotal, o.DateAcct, o.AD_Client_ID, o.AD_Org_ID',Updated=TO_DATE('2018-08-07 12:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_StatusLine_ID=200002
;

SELECT register_migration_script('201808071226_IDEMPIERE-2442.sql') FROM dual
;

