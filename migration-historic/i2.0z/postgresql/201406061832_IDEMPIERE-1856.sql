-- June 6, 2014 18:32:00 PM SGT
-- IDEMPIERE-1856 Amount in database functions and views are hardcoded to round to 2 decimal points

create or replace FUNCTION  paymenttermDiscount
(
	Amount			NUMERIC,
    	Currency_ID     	NUMERIC,
	PaymentTerm_ID		NUMERIC,
	DocDate			timestamp with time zone,
	PayDate			timestamp with time zone
)
RETURNS NUMERIC AS $body$
/*************************************************************************
 * The contents of this file are subject to the Compiere License.  You may
 * obtain a copy of the License at    http://www.compiere.org/license.html
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either
 * express or implied. See the License for details. Code: Compiere ERP+CRM
 * Copyright (C) 1999-2001 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *
 * converted to postgreSQL by Karsten Thiemann (Schaeffer AG), 
 * kthiemann@adempiere.org
 *************************************************************************
 * Title:	Calculate Discount
 * Description:
 *	Calculate the allowable Discount Amount of the Payment Term
 *
 *	Test:	SELECT paymenttermDiscount(110, 103, 106, now(), now()) FROM TEST; => 2.20
 ************************************************************************/

DECLARE
	v_Precision		NUMERIC := 0;
	v_Currency		NUMERIC := 0;
    v_Min			NUMERIC := 0;
	Discount		NUMERIC := 0;
	Discount1Date		timestamp with time zone;
	Discount2Date		timestamp with time zone;
	Add1Date		NUMERIC := 0;
	Add2Date		NUMERIC := 0;
	p   			RECORD;
BEGIN
	v_Currency := Currency_ID;
	IF (v_Currency = 0) THEN 
		SELECT COALESCE(MAX(C_Currency_ID),0) 
		INTO v_Currency 
		FROM AD_ClientInfo ci, C_AcctSchema s, C_PaymentTerm pt 
		WHERE ci.AD_Client_ID = s.AD_Client_ID 
		AND ci.AD_Client_ID = pt.AD_Client_ID 
		AND pt.C_PaymentTerm_ID = PaymentTerm_ID; 
	END IF;
	
	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = v_Currency;

	SELECT 1/10^v_Precision INTO v_Min;
	
	--	No Data - No Discount
	IF (Amount IS NULL OR PaymentTerm_ID IS NULL OR DocDate IS NULL) THEN
		RETURN 0;
	END IF;

	FOR p IN 
		SELECT	*
		FROM	C_PaymentTerm
		WHERE	C_PaymentTerm_ID = PaymentTerm_ID
	LOOP	--	for convineance only
		Discount1Date := TRUNC(DocDate + p.DiscountDays + p.GraceDays);
		Discount2Date := TRUNC(DocDate + p.DiscountDays2 + p.GraceDays);

		--	Next Business Day
		IF (p.IsNextBusinessDay='Y') THEN
			Discount1Date := nextBusinessDay(Discount1Date, p.AD_Client_ID);
			Discount2Date := nextBusinessDay(Discount2Date, p.AD_Client_ID);
		END IF;

		--	Discount 1
		IF (Discount1Date >= TRUNC(PayDate)) THEN
			Discount := Amount * p.Discount / 100;
		--	Discount 2
		ELSIF (Discount2Date >= TRUNC(PayDate)) THEN
			Discount := Amount * p.Discount2 / 100;
		END IF;	
	END LOOP;
	
	--	Ignore Rounding
	IF (Discount > -v_Min AND Discount < v_Min) THEN
		Discount := 0;
	END IF;

	--	Round to currency precision
	Discount := ROUND(COALESCE(Discount,0), v_Precision);
	
	RETURN	Discount;
END;

$body$ LANGUAGE plpgsql;

SELECT register_migration_script('201406061832_IDEMPIERE-1856.sql') FROM dual
;