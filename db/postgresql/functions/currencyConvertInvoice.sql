CREATE OR REPLACE FUNCTION currencyConvertInvoice(
	p_c_invoice_id numeric,
	p_currency_to_id numeric,
	p_amt numeric DEFAULT NULL::numeric,
	p_conversiondate timestamp with time zone DEFAULT NULL::timestamp with time zone)
    RETURNS numeric
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
		
DECLARE
	v_GrandTotal NUMERIC;
	v_ConversionType_ID NUMERIC;
	v_Client_ID NUMERIC;
	v_Org_ID NUMERIC;
	v_Currency_ID NUMERIC;
	v_CurrencyRate NUMERIC;
	v_DateAcct timestamp with time zone;
	v_BaseCurrency_ID NUMERIC;
	v_IsOverrideCurrencyRate character(1);
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
END;

$BODY$;

