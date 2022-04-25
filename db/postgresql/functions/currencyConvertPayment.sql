CREATE OR REPLACE FUNCTION currencyConvertPayment(
	p_C_Payment_ID numeric,
	p_Currency_To_id numeric,
	p_Amt numeric default null,
	p_conversionDate timestamp with time zone default null)
    RETURNS numeric
    LANGUAGE 'plpgsql'
AS $BODY$		
DECLARE
	v_PayAmt NUMERIC;
	v_ConversionType_ID NUMERIC;
	v_Client_ID NUMERIC;
	v_Org_ID NUMERIC;
	v_Currency_ID NUMERIC;
	v_CurrencyRate NUMERIC;
	v_ConvertedAmt NUMERIC;
	v_DateAcct timestamp with time zone;
	v_BaseCurrency_ID NUMERIC;
	v_IsOverrideCurrencyRate character(1);
BEGIN
	SELECT AD_Client_ID, AD_Org_ID, DateAcct, C_Currency_ID, C_ConversionType_ID, CurrencyRate, ConvertedAmt, PayAmt, IsOverrideCurrencyRate
	INTO v_Client_ID, v_Org_ID, v_DateAcct, v_Currency_ID, v_ConversionType_ID, v_CurrencyRate, v_ConvertedAmt, v_PayAmt, v_IsOverrideCurrencyRate
	FROM C_Payment_V
	WHERE C_Payment_ID=p_C_Payment_ID;
	
	SELECT sc.C_Currency_ID
	INTO v_BaseCurrency_ID
	FROM AD_ClientInfo ci
	JOIN C_AcctSchema sc ON ci.C_AcctSchema1_ID=sc.C_AcctSchema_ID
	WHERE ci.AD_Client_ID=v_Client_ID;
	
	IF v_BaseCurrency_ID=p_Currency_To_id AND Coalesce(v_CurrencyRate,0) > 0 AND Coalesce(v_ConvertedAmt,0) != 0 AND v_Currency_ID != p_Currency_To_id AND v_IsOverrideCurrencyRate='Y' THEN
		IF p_Amt IS NULL THEN
			RETURN v_ConvertedAmt;
		ELSE
			RETURN currencyRound(p_Amt*v_CurrencyRate, p_Currency_To_id, null);
		END IF;
	END IF;
	
	RETURN currencyConvert(Coalesce(p_Amt,v_PayAmt), v_Currency_ID, p_Currency_To_id, Coalesce(p_conversionDate,v_DateAcct), v_ConversionType_ID, v_Client_ID, v_Org_ID);
END;
$BODY$;

