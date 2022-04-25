CREATE OR REPLACE FUNCTION currencyConvertPayment
(
	p_C_Payment_ID		IN NUMBER,
	p_Currency_To_id	IN NUMBER,
	p_Amt			IN NUMBER DEFAULT NULL,
	p_conversionDate	IN DATE DEFAULT NULL
)
RETURN NUMBER
AS
	v_Rate	NUMBER;
	v_PayAmt NUMBER;
	v_ConversionType_ID NUMBER;
	v_Client_ID NUMBER;
	v_Org_ID NUMBER;
	v_Currency_ID NUMBER;
	v_CurrencyRate NUMBER;
	v_ConvertedAmt NUMBER;
	v_DateAcct DATE;
	v_BaseCurrency_ID NUMBER;
	v_IsOverrideCurrencyRate Char(1);
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
END currencyConvertPayment;
/

