CREATE OR REPLACE FUNCTION currencyConvertInvoice(
	p_c_invoice_id 	in number,
	p_currency_to_id in number,
	p_amt in number DEFAULT NULL,
	p_conversiondate in date DEFAULT NULL)
    RETURN number
AS
	v_GrandTotal NUMBER;
	v_ConversionType_ID NUMBER;
	v_Client_ID NUMBER;
	v_Org_ID NUMBER;
	v_Currency_ID NUMBER;
	v_CurrencyRate NUMBER;
	v_DateAcct DATE;
	v_BaseCurrency_ID NUMBER;
	v_IsOverrideCurrencyRate CHAR(1);
BEGIN
	SELECT AD_Client_ID, AD_Org_ID, DateAcct, C_Currency_ID, C_ConversionType_ID, CurrencyRate, GrandTotal, IsOverrideCurrencyRate
	INTO v_Client_ID, v_Org_ID, v_DateAcct, v_Currency_ID, v_ConversionType_ID, v_CurrencyRate, v_GrandTotal, v_IsOverrideCurrencyRate
	FROM C_Invoice
	WHERE C_Invoice_ID=p_C_Invoice_ID;
	
	SELECT sc.C_Currency_ID
	INTO v_BaseCurrency_ID
	FROM AD_ClientInfo ci
	JOIN C_AcctSchema sc ON ci.C_AcctSchema1_ID=sc.C_AcctSchema_ID
	WHERE ci.AD_Client_ID=v_Client_ID;
	
	IF v_BaseCurrency_ID=p_Currency_To_id AND Coalesce(v_CurrencyRate,0) > 0 AND v_Currency_ID != p_Currency_To_id AND v_IsOverrideCurrencyRate='Y' THEN
		RETURN currencyRound(Coalesce(p_Amt,v_GrandTotal)*v_CurrencyRate, p_Currency_To_id, null);
	END IF;
	
	RETURN currencyConvert(Coalesce(p_Amt,v_GrandTotal), v_Currency_ID, p_Currency_To_id, Coalesce(p_conversionDate,v_DateAcct), v_ConversionType_ID, v_Client_ID, v_Org_ID);
END currencyConvertInvoice;
/

