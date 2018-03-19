-- IDEMPIERE-1953 Performance problem of postgresql functions - adding STABLE/IMMUTABLE attribute.

CREATE OR REPLACE FUNCTION acctBalance(p_Account_ID numeric, p_AmtDr numeric, p_AmtCr numeric) RETURNS numeric AS $body$
DECLARE
	v_balance	NUMERIC;
	v_AccountType   C_ElementValue.AccountType%TYPE;
    	v_AccountSign   C_ElementValue.AccountSign%TYPE;

BEGIN
	    v_balance := p_AmtDr - p_AmtCr;
	    --  
	    IF (p_Account_ID > 0) THEN
	        SELECT AccountType, AccountSign
	          INTO v_AccountType, v_AccountSign
	        FROM C_ElementValue
	        WHERE C_ElementValue_ID=p_Account_ID;
	   --   DBMS_OUTPUT.PUT_LINE('Type=' || v_AccountType || ' - Sign=' || v_AccountSign);
	        --  Natural Account Sign
	        IF (v_AccountSign='N') THEN
	            IF (v_AccountType IN ('A','E')) THEN
	                v_AccountSign := 'D';
	            ELSE
	                v_AccountSign := 'C';
	            END IF;
	        --  DBMS_OUTPUT.PUT_LINE('Type=' || v_AccountType || ' - Sign=' || v_AccountSign);
	        END IF;
	        --  Debit Balance
	        IF (v_AccountSign = 'C') THEN
	            v_balance := p_AmtCr - p_AmtDr;
	        END IF;
	    END IF;
	    --
	    RETURN v_balance;
	EXCEPTION WHEN OTHERS THEN
	    -- In case Acct not found
    	RETURN  p_AmtDr - p_AmtCr;
	
END;

$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION add_months (in datetime timestamptz, in months numeric) RETURNS date AS
$BODY$
declare duration varchar;
BEGIN
	if datetime is null or months is null then
		return null;
	end if;
	duration = months || ' month';	 
	return cast(datetime + cast(duration as interval) as date);
END;
$BODY$
LANGUAGE 'plpgsql' IMMUTABLE
;

CREATE OR REPLACE FUNCTION bpartnerRemitLocation(p_C_BPartner_ID C_BPartner.C_BPartner_ID%TYPE) 
RETURNS numeric AS $body$

DECLARE
	v_C_Location_ID	NUMERIC := NULL;
	l RECORD;

BEGIN
	FOR l IN 
		SELECT	IsRemitTo, C_Location_ID
		FROM	C_BPartner_Location
		WHERE	C_BPartner_ID=p_C_BPartner_ID AND IsActive='Y'
		ORDER BY IsRemitTo DESC
	LOOP
		IF (v_C_Location_ID IS NULL) THEN
			v_C_Location_ID := l.C_Location_ID;
		END IF;
	END LOOP;
	RETURN v_C_Location_ID;
	
END;

$body$ LANGUAGE plpgsql STABLE;

create or replace FUNCTION currencyBase
(
	p_Amount	NUMERIC,
	p_CurFrom_ID	NUMERIC,
	p_ConvDate	timestamp with time zone,
	p_Client_ID	NUMERIC,
	p_Org_ID	NUMERIC
)
RETURNS numeric AS $body$
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
 * 
 ***
 * Title:	Convert Amount to Base Currency of Client
 * Description:
 *		Get CurrencyTo from Client
 *		Returns NULL, if conversion not found
 *		Standard Rounding
 * Test:
 *		SELECT currencyBase(100,116,null,11,null) FROM AD_System; => 64.72
 ************************************************************************/
DECLARE
	v_CurTo_ID	NUMERIC;
BEGIN
	--	Get Currency
	SELECT	MAX(ac.C_Currency_ID)
	  INTO	v_CurTo_ID
	FROM	AD_ClientInfo ci, C_AcctSchema ac
	WHERE	ci.C_AcctSchema1_ID=ac.C_AcctSchema_ID
	  AND	ci.AD_Client_ID=p_Client_ID;
	--	Same as Currency_Conversion - if currency/rate not found - return 0
	IF (v_CurTo_ID IS NULL) THEN
		RETURN NULL;
	END IF;
	--	Same currency
	IF (p_CurFrom_ID = v_CurTo_ID) THEN
		RETURN p_Amount;
	END IF;

	RETURN currencyConvert (p_Amount, p_CurFrom_ID, v_CurTo_ID, p_ConvDate, null, p_Client_ID, p_Org_ID);
END;

$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION currencyConvert(
	p_Amount		NUMERIC,
	p_CurFrom_ID		NUMERIC,
	p_CurTo_ID		NUMERIC,
	p_ConvDate		timestamp with time zone,
	p_ConversionType_ID IN	NUMERIC,
	p_Client_ID		NUMERIC,
	p_Org_ID		NUMERIC
	) 

RETURNS numeric AS $body$
	
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
 ***
 * Title:	Convert Amount (using IDs)
 * Description:
 *		from CurrencyFrom_ID to CurrencyTo_ID
 *		Returns NULL, if conversion not found
 *		Standard Rounding
 * Test:
 *	SELECT currencyConvert(100,116,100,null,null,null,null) FROM AD_System;  => 64.72
 ************************************************************************/	
	
	
DECLARE
	v_Rate				NUMERIC;

BEGIN
	--	Return Amount
		IF (p_Amount = 0 OR p_CurFrom_ID = p_CurTo_ID) THEN
			RETURN p_Amount;
		END IF;
		--	Return NULL
		IF (p_Amount IS NULL OR p_CurFrom_ID IS NULL OR p_CurTo_ID IS NULL) THEN
			RETURN NULL;
		END IF;
	
		--	Get Rate
		v_Rate := currencyRate (p_CurFrom_ID, p_CurTo_ID, p_ConvDate, p_ConversionType_ID, p_Client_ID, p_Org_ID);
		IF (v_Rate IS NULL) THEN
			RETURN NULL;
		END IF;
	
		--	Standard Precision
	RETURN currencyRound(p_Amount * v_Rate, p_CurTo_ID, null);
	
END;

$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION currencyRate(
	p_CurFrom_ID		NUMERIC,
	p_CurTo_ID		NUMERIC,
	p_ConvDate		timestamp with time zone,
	p_ConversionType_ID	NUMERIC,
	p_Client_ID		NUMERIC,
	p_Org_ID		NUMERIC
	) 

RETURNS numeric AS $body$
	
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
 ***
 * Title:	Return Conversion Rate
 * Description:
 *		from CurrencyFrom_ID to CurrencyTo_ID
 *		Returns NULL, if rate not found
 * Test
 *		SELECT currencyrate(116, 100, null, null, null, null) FROM AD_System;  => .647169
 ************************************************************************/
	
	
DECLARE
	--	Currency From variables
	cf_IsEuro		CHAR(1);
	cf_IsEMUMember		CHAR(1);
	cf_EMUEntryDate		timestamp with time zone;
	cf_EMURate		NUMERIC;
	--	Currency To variables
	ct_IsEuro		CHAR(1);
	ct_IsEMUMember		CHAR(1);
	ct_EMUEntryDate	DATE;
	ct_EMURate		NUMERIC;
	--	Triangle
	v_CurrencyFrom		NUMERIC;
	v_CurrencyTo		NUMERIC;
	v_CurrencyEuro		NUMERIC;
	--
	v_ConvDate		timestamp with time zone := now();
	v_ConversionType_ID	NUMERIC := 0;
	v_Rate			NUMERIC;
	c			RECORD;			

BEGIN
--	No Conversion
	IF (p_CurFrom_ID = p_CurTo_ID) THEN
		RETURN 1;
	END IF;
	--	Default Date Parameter
	IF (p_ConvDate IS NOT NULL) THEN
		v_ConvDate := p_ConvDate;   --  SysDate
	END IF;
    --  Default Conversion Type
	IF (p_ConversionType_ID IS NULL OR p_ConversionType_ID = 0) THEN
		BEGIN
		    SELECT C_ConversionType_ID 
		      INTO v_ConversionType_ID
		    FROM C_ConversionType 
		    WHERE IsDefault='Y'
		      AND AD_Client_ID IN (0,p_Client_ID)
		    ORDER BY AD_Client_ID DESC
		    LIMIT 1;
		EXCEPTION WHEN OTHERS THEN
		    RAISE NOTICE 'Conversion Type Not Found';
		END;
    	ELSE
        	v_ConversionType_ID := p_ConversionType_ID;
	END IF;

	--	Get Currency Info
	SELECT	MAX(IsEuro), MAX(IsEMUMember), MAX(EMUEntryDate), MAX(EMURate)
	  INTO	cf_IsEuro, cf_IsEMUMember, cf_EMUEntryDate, cf_EMURate
	FROM		C_Currency
	  WHERE	C_Currency_ID = p_CurFrom_ID;
	-- Not Found
	IF (cf_IsEuro IS NULL) THEN
		RAISE NOTICE 'From Currency Not Found';
		RETURN NULL;
	END IF;
	SELECT	MAX(IsEuro), MAX(IsEMUMember), MAX(EMUEntryDate), MAX(EMURate)
	  INTO	ct_IsEuro, ct_IsEMUMember, ct_EMUEntryDate, ct_EMURate
	FROM		C_Currency
	  WHERE	C_Currency_ID = p_CurTo_ID;
	-- Not Found
	IF (ct_IsEuro IS NULL) THEN
		RAISE NOTICE 'To Currency Not Found';
		RETURN NULL;
	END IF;

	--	Fixed - From Euro to EMU
	IF (cf_IsEuro = 'Y' AND ct_IsEMUMember ='Y' AND v_ConvDate >= ct_EMUEntryDate) THEN
		RETURN ct_EMURate;
	END IF;

	--	Fixed - From EMU to Euro
	IF (ct_IsEuro = 'Y' AND cf_IsEMUMember ='Y' AND v_ConvDate >= cf_EMUEntryDate) THEN
		RETURN 1 / cf_EMURate;
	END IF;

	--	Fixed - From EMU to EMU
	IF (cf_IsEMUMember = 'Y' AND cf_IsEMUMember ='Y'
			AND v_ConvDate >= cf_EMUEntryDate AND v_ConvDate >= ct_EMUEntryDate) THEN
		RETURN ct_EMURate / cf_EMURate;
	END IF;

	--	Flexible Rates
	v_CurrencyFrom := p_CurFrom_ID;
	v_CurrencyTo := p_CurTo_ID;

	-- if EMU Member involved, replace From/To Currency
	IF ((cf_isEMUMember = 'Y' AND v_ConvDate >= cf_EMUEntryDate)
	  OR (ct_isEMUMember = 'Y' AND v_ConvDate >= ct_EMUEntryDate)) THEN
		SELECT	MAX(C_Currency_ID)
		  INTO	v_CurrencyEuro
		FROM		C_Currency
		WHERE	IsEuro = 'Y';
		-- Conversion Rate not Found
		IF (v_CurrencyEuro IS NULL) THEN
			RAISE NOTICE 'Euro Not Found';
			RETURN NULL;
		END IF;
		IF (cf_isEMUMember = 'Y' AND v_ConvDate >= cf_EMUEntryDate) THEN
			v_CurrencyFrom := v_CurrencyEuro;
		ELSE
			v_CurrencyTo := v_CurrencyEuro;
		END IF;
	END IF;

	--	Get Rate

	BEGIN
		FOR c IN SELECT	MultiplyRate
			FROM	C_Conversion_Rate
			WHERE	C_Currency_ID=v_CurrencyFrom AND C_Currency_ID_To=v_CurrencyTo
			  AND	C_ConversionType_ID=v_ConversionType_ID
			  AND	v_ConvDate BETWEEN ValidFrom AND ValidTo
			  AND	AD_Client_ID IN (0,p_Client_ID) AND AD_Org_ID IN (0,p_Org_ID)
			ORDER BY AD_Client_ID DESC, AD_Org_ID DESC, ValidFrom DESC
		LOOP
			v_Rate := c.MultiplyRate;
			EXIT;	--	only first
		END LOOP;
	END;
	--	Not found
	IF (v_Rate IS NULL) THEN
		RAISE NOTICE 'Conversion Rate Not Found';
		RETURN NULL;
	END IF;

	--	Currency From was EMU
	IF (cf_isEMUMember = 'Y' AND v_ConvDate >= cf_EMUEntryDate) THEN
		RETURN v_Rate / cf_EMURate;
	END IF;

	--	Currency To was EMU
	IF (ct_isEMUMember = 'Y' AND v_ConvDate >= ct_EMUEntryDate) THEN
		RETURN v_Rate * ct_EMURate;
	END IF;

	RETURN v_Rate;

EXCEPTION WHEN OTHERS THEN
	RAISE NOTICE '%', SQLERRM;
	RETURN NULL;

	
END;

$body$ LANGUAGE plpgsql STABLE;

-- DROP FUNCTION currencyround(p_amount numeric, p_curto_id numeric, p_costing character varying);

CREATE OR REPLACE FUNCTION currencyRound(
	p_Amount	NUMERIC,
	p_CurTo_ID	NUMERIC,
	p_Costing	character varying		--	Default 'N'
) 

RETURNS numeric AS $BODY$

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
 ***
 * Title:	Round amount for Traget Currency
 * Description:
 *		Round Amount using Costing or Standard Precision
 *		Returns unmodified amount if currency not found
 * Test:
 *		SELECT currencyRound(currencyConvert(100,116,100,null,null),100,null) FROM AD_System => 64.72 
 ************************************************************************/
	
	
DECLARE
	v_StdPrecision		int;
	v_CostPrecision		int;

BEGIN
	--	Nothing to convert
	IF (p_Amount IS NULL OR p_CurTo_ID IS NULL) THEN
		RETURN p_Amount;
	END IF;

	--	Ger Precision
	SELECT	MAX(StdPrecision), MAX(CostingPrecision)
	  INTO	v_StdPrecision, v_CostPrecision
	FROM	C_Currency
	  WHERE	C_Currency_ID = p_CurTo_ID;
	--	Currency Not Found
	IF (v_StdPrecision IS NULL) THEN
		RETURN p_Amount;
	END IF;

	IF (p_Costing = 'Y') THEN
		RETURN ROUND (p_Amount, v_CostPrecision);
	END IF;

	RETURN ROUND (p_Amount, v_StdPrecision);
	
END;

$BODY$
  LANGUAGE 'plpgsql' STABLE;

CREATE OR REPLACE FUNCTION invoiceDiscount
(
	p_C_Invoice_ID		       	NUMERIC,
	p_paydate 			timestamp with time zone,
	p_C_InvoicePaySchedule_ID	NUMERIC
)
RETURNS numeric AS $body$
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
 ***
 * Title:	Calculate Payment Discount Amount
 * Description:
 *			- Calculate discountable amount (i.e. with or without tax)
 *			- Calculate and return payment discount
 * Test:
 * 		select invoiceDiscount(109, now(), 103) from ad_system; => 0
 ************************************************************************/
DECLARE
	v_Amount		NUMERIC;
	v_IsDiscountLineAmt	CHAR(1);
	v_GrandTotal		NUMERIC;
	v_TotalLines		NUMERIC;
	v_C_PaymentTerm_ID	NUMERIC(10);
	v_C_Currency_ID		NUMERIC(10);
	v_DocDate		timestamp with time zone;
	v_PayDate		timestamp with time zone := now();
    	v_IsPayScheduleValid    CHAR(1);

BEGIN
	SELECT 	ci.IsDiscountLineAmt, i.GrandTotal, i.TotalLines,
		i.C_PaymentTerm_ID, i.DateInvoiced, i.IsPayScheduleValid, C_Currency_ID
	INTO 	v_IsDiscountLineAmt, v_GrandTotal, v_TotalLines,
		v_C_PaymentTerm_ID, v_DocDate, v_IsPayScheduleValid, v_C_Currency_ID
	FROM 	AD_ClientInfo ci, C_Invoice i
	WHERE 	ci.AD_Client_ID=i.AD_Client_ID
	  AND 	i.C_Invoice_ID=p_C_Invoice_ID;
	  
	--	What Amount is the Discount Base?
 	IF (v_IsDiscountLineAmt = 'Y') THEN
		v_Amount := v_TotalLines;
	ELSE
		v_Amount := v_GrandTotal;
	END IF;

	--	Anything to discount?
	IF (v_Amount = 0) THEN
		RETURN 0;
   	END IF;
	IF (p_PayDate IS NOT NULL) THEN
		v_PayDate := p_PayDate;
  	END IF;

    --  Valid Payment Schedule
    IF (v_IsPayScheduleValid='Y' AND p_C_InvoicePaySchedule_ID > 0) THEN
        SELECT COALESCE(MAX(DiscountAmt),0)
          INTO v_Amount
        FROM C_InvoicePaySchedule
        WHERE C_InvoicePaySchedule_ID=p_C_InvoicePaySchedule_ID
          AND DiscountDate <= v_PayDate;
        --
        RETURN v_Amount;
    END IF;

	--	return discount amount	
	RETURN paymentTermDiscount (v_Amount, v_C_Currency_ID, v_C_PaymentTerm_ID, v_DocDate, p_PayDate);

--	Most likely if invoice not found
EXCEPTION
	WHEN OTHERS THEN
		RETURN NULL;
END;

$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION invoiceopen (in p_c_invoice_id numeric, in p_c_invoicepayschedule_id numeric) RETURNS numeric AS
$BODY$
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
 ***
 * Title:	Calculate Open Item Amount in Invoice Currency
 * Description:
 *	Add up total amount open for C_Invoice_ID if no split payment.
 *  Grand Total minus Sum of Allocations in Invoice Currency
 *
 *  For Split Payments:
 *  Allocate Payments starting from first schedule.
 *  Cannot be used for IsPaid as mutating
 *
 * Test:
 * 	SELECT C_InvoicePaySchedule_ID, DueAmt FROM C_InvoicePaySchedule WHERE C_Invoice_ID=109 ORDER BY DueDate;
 * 	SELECT invoiceOpen (109, null) FROM AD_System; - converted to default client currency
 * 	SELECT invoiceOpen (109, 11) FROM AD_System; - converted to default client currency
 * 	SELECT invoiceOpen (109, 102) FROM AD_System;
 * 	SELECT invoiceOpen (109, 103) FROM AD_System;
 ************************************************************************/
DECLARE
	v_Currency_ID		NUMERIC(10);
	v_TotalOpenAmt  	NUMERIC := 0;
	v_PaidAmt  	        NUMERIC := 0;
	v_Remaining	        NUMERIC := 0;
    	v_MultiplierAP      	NUMERIC := 0;
    	v_MultiplierCM      	NUMERIC := 0;
    	v_Temp              	NUMERIC := 0;
    	v_Precision            	NUMERIC := 0;
    	v_Min            	NUMERIC := 0;
    	ar			RECORD;
    	s			RECORD;

BEGIN
	--	Get Currency
	BEGIN
		SELECT	MAX(C_Currency_ID), SUM(GrandTotal), MAX(MultiplierAP), MAX(Multiplier)
		INTO	v_Currency_ID, v_TotalOpenAmt, v_MultiplierAP, v_MultiplierCM
		FROM	C_Invoice_v		--	corrected for CM / Split Payment
		WHERE	C_Invoice_ID = p_C_Invoice_ID;
	EXCEPTION	--	Invoice in draft form
		WHEN OTHERS THEN
            	RAISE NOTICE 'InvoiceOpen - %', SQLERRM;
			RETURN NULL;
	END;

	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = v_Currency_ID;

	SELECT 1/10^v_Precision INTO v_Min;

	--	Calculate Allocated Amount
	FOR ar IN 
		SELECT	a.AD_Client_ID, a.AD_Org_ID,
		al.Amount, al.DiscountAmt, al.WriteOffAmt,
		a.C_Currency_ID, a.DateTrx
		FROM	C_AllocationLine al
		INNER JOIN C_AllocationHdr a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
		WHERE	al.C_Invoice_ID = p_C_Invoice_ID
          	AND   a.IsActive='Y'
	LOOP
        v_Temp := ar.Amount + ar.DisCountAmt + ar.WriteOffAmt;
		v_PaidAmt := v_PaidAmt
        -- Allocation
			+ currencyConvert(v_Temp * v_MultiplierAP,
				ar.C_Currency_ID, v_Currency_ID, ar.DateTrx, null, ar.AD_Client_ID, ar.AD_Org_ID);
      	RAISE NOTICE '   PaidAmt=% , Allocation= % * %', v_PaidAmt, v_Temp, v_MultiplierAP;
	END LOOP;

    --  Do we have a Payment Schedule ?
    IF (p_C_InvoicePaySchedule_ID > 0) THEN --   if not valid = lists invoice amount
        v_Remaining := v_PaidAmt;
        FOR s IN 
        	SELECT  C_InvoicePaySchedule_ID, DueAmt
	        FROM    C_InvoicePaySchedule
		WHERE	C_Invoice_ID = p_C_Invoice_ID
	        AND   IsValid='Y'
        	ORDER BY DueDate
        LOOP
            IF (s.C_InvoicePaySchedule_ID = p_C_InvoicePaySchedule_ID) THEN
                v_TotalOpenAmt := (s.DueAmt*v_MultiplierCM) - v_Remaining;
                IF (s.DueAmt - v_Remaining < 0) THEN
                    v_TotalOpenAmt := 0;
                END IF;
            ELSE -- calculate amount, which can be allocated to next schedule
                v_Remaining := v_Remaining - s.DueAmt;
                IF (v_Remaining < 0) THEN
                    v_Remaining := 0;
                END IF;
            END IF;
        END LOOP;
    ELSE
        v_TotalOpenAmt := v_TotalOpenAmt - v_PaidAmt;
    END IF;
--  RAISE NOTICE ''== Total='' || v_TotalOpenAmt;

	--	Ignore Rounding
	IF (v_TotalOpenAmt > -v_Min AND v_TotalOpenAmt < v_Min) THEN
		v_TotalOpenAmt := 0;
	END IF;

	--	Round to currency precision
	v_TotalOpenAmt := ROUND(COALESCE(v_TotalOpenAmt,0), v_Precision);
	RETURN	v_TotalOpenAmt;
END;

$BODY$
LANGUAGE 'plpgsql' STABLE
;

/*
 *This file is part of Adempiere ERP Bazaar
 *http://www.adempiere.org
 *Copyright (C) 2006-2008 victor.perez@e-evolution.com, e-Evolution
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either version 2
 *of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.of 
 * Title: Calculate Open Item Amount in Invoice Currency
 * Description:
 * Add up total amount open for C_Invoice_ID if no split payment.
 *  Grand Total minus Sum of Allocations in Invoice Currency
 *
 *  For Split Payments:
 *  Allocate Payments starting from first schedule.
 
SELECT C_Invoice_Open (109) FROM DUAL;
SELECT C_Invoice_Open (109, null) FROM DUAL;
SELECT C_Invoice_Open (109, 11) FROM DUAL;
SELECT C_Invoice_Open (109, 102) FROM DUAL;
SELECT C_Invoice_Open (109, 103) FROM DUAL;
SELECT * FROM RV_OpenItem WHERE C_Invoice_ID=109;
SELECT C_InvoicePaySchedule_ID, DueAmt FROM C_InvoicePaySchedule WHERE C_Invoice_ID=109 ORDER BY DueDate;

*  Cannot be used for IsPaid as mutating
************************************************************************/
CREATE OR REPLACE FUNCTION InvoiceopenToDate
(
 p_C_Invoice_ID             IN numeric,
    p_C_InvoicePaySchedule_ID   IN  numeric,
	p_DateAcct IN timestamp with time zone
)
RETURNS numeric
AS
$BODY$
DECLARE
	v_Currency_ID  numeric(10);
	v_Precision         NUMERIC := 0;
    v_Min            	NUMERIC := 0;
	v_TotalOpenAmt   numeric := 0;
	v_PaidAmt           numeric := 0;
	v_Remaining         numeric := 0;
	v_MultiplierAP      numeric := 0;
	v_MultiplierCM      numeric := 0;
	v_Temp              numeric := 0;
	allocationline	    record;
	invoiceschedule	    record;
BEGIN
 -- Get Currency
 BEGIN
  SELECT MAX(C_Currency_ID), SUM(GrandTotal), MAX(MultiplierAP), MAX(Multiplier)
    INTO v_Currency_ID, v_TotalOpenAmt, v_MultiplierAP, v_MultiplierCM
  FROM C_Invoice_v  -- corrected for CM / Split Payment
  WHERE C_Invoice_ID = p_C_Invoice_ID
    AND DateAcct <= p_DateAcct;
 EXCEPTION -- Invoice in draft form
  WHEN OTHERS THEN
            --DBMS_OUTPUT.PUT_LINE('InvoiceOpen - ' || SQLERRM);
   RETURN NULL;
 END;
--  DBMS_OUTPUT.PUT_LINE('== C_Invoice_ID=' || p_C_Invoice_ID || ', Total=' || v_TotalOpenAmt || ', AP=' || v_MultiplierAP || ', CM=' || v_MultiplierCM);

	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = v_Currency_ID;

	SELECT 1/10^v_Precision INTO v_Min;

 -- Calculate Allocated Amount
 FOR allocationline IN  
  SELECT a.AD_Client_ID, a.AD_Org_ID,
            al.Amount, al.DiscountAmt, al.WriteOffAmt,
            a.C_Currency_ID, a.DateTrx
  FROM C_ALLOCATIONLINE al
          INNER JOIN C_ALLOCATIONHDR a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
  WHERE al.C_Invoice_ID = p_C_Invoice_ID
    AND a.DateAcct <= p_DateAcct
    AND   a.IsActive='Y'
 LOOP
        v_Temp := allocationline.Amount + allocationline.DisCountAmt + allocationline.WriteOffAmt;
  v_PaidAmt := v_PaidAmt
        -- Allocation
   + Currencyconvert(v_Temp * v_MultiplierAP,
    allocationline.C_Currency_ID, v_Currency_ID, allocationline.DateTrx, NULL, allocationline.AD_Client_ID, allocationline.AD_Org_ID);
      --DBMS_OUTPUT.PUT_LINE('   PaidAmt=' || v_PaidAmt || ', Allocation=' || v_Temp || ' * ' || v_MultiplierAP);
 END LOOP;

    --  Do we have a Payment Schedule ?
    IF (p_C_InvoicePaySchedule_ID > 0) THEN --   if not valid = lists invoice amount
        v_Remaining := v_PaidAmt;
        FOR invoiceschedule IN 
        SELECT  C_InvoicePaySchedule_ID, DueAmt FROM    C_INVOICEPAYSCHEDULE WHERE C_Invoice_ID = p_C_Invoice_ID AND IsValid='Y'
        ORDER BY DueDate
        LOOP
            IF (invoiceschedule.C_InvoicePaySchedule_ID = p_C_InvoicePaySchedule_ID) THEN
                v_TotalOpenAmt := (invoiceschedule.DueAmt*v_MultiplierCM) - v_Remaining;
                IF (invoiceschedule.DueAmt - v_Remaining < 0) THEN
                    v_TotalOpenAmt := 0;
                END IF;
            --  DBMS_OUTPUT.PUT_LINE('Sched Total=' || v_TotalOpenAmt || ', Due=' || s.DueAmt || ',Remaining=' || v_Remaining || ',CM=' || v_MultiplierCM);
            ELSE -- calculate amount, which can be allocated to next schedule
                v_Remaining := v_Remaining - invoiceschedule.DueAmt;
                IF (v_Remaining < 0) THEN
                    v_Remaining := 0;
                END IF;
            --  DBMS_OUTPUT.PUT_LINE('Remaining=' || v_Remaining);
            END IF;
        END LOOP;
    ELSE
        v_TotalOpenAmt := v_TotalOpenAmt - v_PaidAmt;
    END IF;
--  DBMS_OUTPUT.PUT_LINE('== Total=' || v_TotalOpenAmt);

	--	Ignore Rounding
	IF (v_TotalOpenAmt > -v_Min AND v_TotalOpenAmt < v_Min) THEN
		v_TotalOpenAmt := 0;
	END IF;

	--	Round to currency precision
	v_TotalOpenAmt := ROUND(COALESCE(v_TotalOpenAmt,0), v_Precision);
	
	RETURN v_TotalOpenAmt;
END;
$BODY$
  LANGUAGE 'plpgsql' STABLE;


CREATE OR REPLACE FUNCTION InvoiceopenToDate
(
 p_C_Invoice_ID             IN numeric,
    p_C_InvoicePaySchedule_ID   IN  numeric,
	p_DateAcct IN date
)
RETURNS numeric
AS
$BODY$
DECLARE
	v_Currency_ID  numeric(10);
	v_Precision         NUMERIC := 0;
    v_Min            	NUMERIC := 0;
	v_TotalOpenAmt   numeric := 0;
	v_PaidAmt           numeric := 0;
	v_Remaining         numeric := 0;
	v_MultiplierAP      numeric := 0;
	v_MultiplierCM      numeric := 0;
	v_Temp              numeric := 0;
	allocationline	    record;
	invoiceschedule	    record;
BEGIN
 -- Get Currency
 BEGIN
  SELECT MAX(C_Currency_ID), SUM(GrandTotal), MAX(MultiplierAP), MAX(Multiplier)
    INTO v_Currency_ID, v_TotalOpenAmt, v_MultiplierAP, v_MultiplierCM
  FROM C_Invoice_v  -- corrected for CM / Split Payment
  WHERE C_Invoice_ID = p_C_Invoice_ID
    AND DateAcct <= p_DateAcct;
 EXCEPTION -- Invoice in draft form
  WHEN OTHERS THEN
            --DBMS_OUTPUT.PUT_LINE('InvoiceOpen - ' || SQLERRM);
   RETURN NULL;
 END;
--  DBMS_OUTPUT.PUT_LINE('== C_Invoice_ID=' || p_C_Invoice_ID || ', Total=' || v_TotalOpenAmt || ', AP=' || v_MultiplierAP || ', CM=' || v_MultiplierCM);

	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = v_Currency_ID;

	SELECT 1/10^v_Precision INTO v_Min;

 -- Calculate Allocated Amount
 FOR allocationline IN  
  SELECT a.AD_Client_ID, a.AD_Org_ID,
            al.Amount, al.DiscountAmt, al.WriteOffAmt,
            a.C_Currency_ID, a.DateTrx
  FROM C_ALLOCATIONLINE al
          INNER JOIN C_ALLOCATIONHDR a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
  WHERE al.C_Invoice_ID = p_C_Invoice_ID
    AND a.DateAcct <= p_DateAcct
    AND   a.IsActive='Y'
 LOOP
        v_Temp := allocationline.Amount + allocationline.DisCountAmt + allocationline.WriteOffAmt;
  v_PaidAmt := v_PaidAmt
        -- Allocation
   + Currencyconvert(v_Temp * v_MultiplierAP,
    allocationline.C_Currency_ID, v_Currency_ID, allocationline.DateTrx, NULL, allocationline.AD_Client_ID, allocationline.AD_Org_ID);
      --DBMS_OUTPUT.PUT_LINE('   PaidAmt=' || v_PaidAmt || ', Allocation=' || v_Temp || ' * ' || v_MultiplierAP);
 END LOOP;

    --  Do we have a Payment Schedule ?
    IF (p_C_InvoicePaySchedule_ID > 0) THEN --   if not valid = lists invoice amount
        v_Remaining := v_PaidAmt;
        FOR invoiceschedule IN 
        SELECT  C_InvoicePaySchedule_ID, DueAmt FROM    C_INVOICEPAYSCHEDULE WHERE C_Invoice_ID = p_C_Invoice_ID AND IsValid='Y'
        ORDER BY DueDate
        LOOP
            IF (invoiceschedule.C_InvoicePaySchedule_ID = p_C_InvoicePaySchedule_ID) THEN
                v_TotalOpenAmt := (invoiceschedule.DueAmt*v_MultiplierCM) - v_Remaining;
                IF (invoiceschedule.DueAmt - v_Remaining < 0) THEN
                    v_TotalOpenAmt := 0;
                END IF;
            --  DBMS_OUTPUT.PUT_LINE('Sched Total=' || v_TotalOpenAmt || ', Due=' || s.DueAmt || ',Remaining=' || v_Remaining || ',CM=' || v_MultiplierCM);
            ELSE -- calculate amount, which can be allocated to next schedule
                v_Remaining := v_Remaining - invoiceschedule.DueAmt;
                IF (v_Remaining < 0) THEN
                    v_Remaining := 0;
                END IF;
            --  DBMS_OUTPUT.PUT_LINE('Remaining=' || v_Remaining);
            END IF;
        END LOOP;
    ELSE
        v_TotalOpenAmt := v_TotalOpenAmt - v_PaidAmt;
    END IF;
--  DBMS_OUTPUT.PUT_LINE('== Total=' || v_TotalOpenAmt);

	--	Ignore Rounding
	IF (v_TotalOpenAmt > -v_Min AND v_TotalOpenAmt < v_Min) THEN
		v_TotalOpenAmt := 0;
	END IF;

	--	Round to currency precision
	v_TotalOpenAmt := ROUND(COALESCE(v_TotalOpenAmt,0), v_Precision);
	
	RETURN v_TotalOpenAmt;
END;
$BODY$
  LANGUAGE 'plpgsql' STABLE;

CREATE OR REPLACE FUNCTION invoicePaid
(
	p_C_Invoice_ID		NUMERIC,
	p_C_Currency_ID	    	NUMERIC,
	p_MultiplierAP		NUMERIC	-- DEFAULT 1
)
RETURNS numeric AS $body$
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
 ***
 * Title:	Calculate Paid/Allocated amount in Currency
 * Description:
 *	Add up total amount paid for for C_Invoice_ID.
 *  Split Payments are ignored.
 *  all allocation amounts  converted to invoice C_Currency_ID
 *	round it to the nearest cent
 *	and adjust for CreditMemos by using C_Invoice_v
 *  and for Payments with the multiplierAP (-1, 1)
 *
 *
 * Test:
    SELECT C_Invoice_ID, IsPaid, IsSOTrx, GrandTotal, 
    invoicePaid (C_Invoice_ID, C_Currency_ID, MultiplierAP)
    FROM C_Invoice_v;
 *	
 ************************************************************************/
DECLARE
	v_Precision         NUMERIC := 0;
    v_Min            	NUMERIC := 0;
	v_MultiplierAP		NUMERIC := 1;
	v_PaymentAmt		NUMERIC := 0;
	ar			RECORD;

BEGIN
	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = p_C_Currency_ID;

	SELECT 1/10^v_Precision INTO v_Min;
	
	--	Default
	IF (p_MultiplierAP IS NOT NULL) THEN
		v_MultiplierAP := p_MultiplierAP;
	END IF;
	--	Calculate Allocated Amount
	FOR ar IN 
		SELECT	a.AD_Client_ID, a.AD_Org_ID, 
		al.Amount, al.DiscountAmt, al.WriteOffAmt, 
		a.C_Currency_ID, a.DateTrx
		FROM	C_AllocationLine al
		INNER JOIN C_AllocationHdr a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
		WHERE	al.C_Invoice_ID = p_C_Invoice_ID
		AND   a.IsActive='Y'
	LOOP
		v_PaymentAmt := v_PaymentAmt
			+ currencyConvert(ar.Amount + ar.DisCountAmt + ar.WriteOffAmt,
				ar.C_Currency_ID, p_C_Currency_ID, ar.DateTrx, null, ar.AD_Client_ID, ar.AD_Org_ID);
	END LOOP;

	--	Ignore Rounding
	IF (v_PaymentAmt > -v_Min AND v_PaymentAmt < v_Min) THEN
		v_PaymentAmt := 0;
	END IF;

	--	Round to currency precision
	v_PaymentAmt := ROUND(COALESCE(v_PaymentAmt,0), v_Precision);
	
	RETURN	v_PaymentAmt * v_MultiplierAP;
END;

$body$ LANGUAGE plpgsql STABLE;

/*
 *This file is part of Adempiere ERP Bazaar
 *http://www.adempiere.org
 *Copyright (C) 2006-2008 victor.perez@e-evolution.com, e-Evolution
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either version 2
 *of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.of 
 * Title:	Calculate Paid/Allocated amount in Currency
 * Description:
 *	Add up total amount paid for for C_Invoice_ID.
 *  Split Payments are ignored.
 *  all allocation amounts  converted to invoice C_Currency_ID
 *	round it to the nearest cent
 *	and adjust for CreditMemos by using C_Invoice_v
 *  and for Payments with the multiplierAP (-1, 1)
 *
    SELECT C_Invoice_ID, IsPaid, IsSOTrx, GrandTotal,
    C_Invoice_Paid (C_Invoice_ID, C_Currency_ID, MultiplierAP, DateAcct)
    FROM C_Invoice_v;
    --
    UPDATE C_Invoice_v1
 	SET IsPaid = CASE WHEN C_Invoice_Paid(C_Invoice_ID,C_Currency_ID,MultiplierAP,DateAcct)=GrandTotal THEN 'Y' ELSE 'N' END
    WHERE C_Invoice_ID>1000000
 *
 ************************************************************************/
 
CREATE OR REPLACE FUNCTION InvoicepaidToDate
(
	p_C_Invoice_ID		IN	numeric,
	p_C_Currency_ID	    	IN	numeric,
	p_MultiplierAP		IN	numeric,	-- DEFAULT 1
	p_DateAcct 		IN	timestamp with time zone
)
RETURNS numeric
AS
$BODY$
DECLARE
	v_Precision         NUMERIC := 0;
    v_Min            	NUMERIC := 0;
	v_MultiplierAP		numeric := 1;
	v_PaymentAmt		numeric := 0;
	allocation 		record;
BEGIN
	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = p_C_Currency_ID;

	SELECT 1/10^v_Precision INTO v_Min;
	
	--	Default
	IF (p_MultiplierAP IS NOT NULL) THEN
		v_MultiplierAP := p_MultiplierAP;
	END IF;
	--	Calculate Allocated Amount
	FOR allocation IN 
	SELECT	al.AD_Client_ID, al.AD_Org_ID,al.Amount, al.DiscountAmt, al.WriteOffAmt,a.C_Currency_ID, a.DateTrx
	FROM	C_ALLOCATIONLINE al
	INNER JOIN C_ALLOCATIONHDR a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
    WHERE	al.C_Invoice_ID = p_C_Invoice_ID AND   a.IsActive='Y' AND a.DateAcct <= p_DateAcct
	LOOP
		v_PaymentAmt := v_PaymentAmt
			+ Currencyconvert(allocation.Amount + allocation.DisCountAmt + allocation.WriteOffAmt,
				allocation.C_Currency_ID, p_C_Currency_ID, allocation.DateTrx, NULL, allocation.AD_Client_ID, allocation.AD_Org_ID);
	END LOOP;
	
	--	Ignore Rounding
	IF (v_PaymentAmt > -v_Min AND v_PaymentAmt < v_Min) THEN
		v_PaymentAmt := 0;
	END IF;

	--	Round to currency precision
	v_PaymentAmt := ROUND(COALESCE(v_PaymentAmt,0), v_Precision);
	
	RETURN	v_PaymentAmt * v_MultiplierAP;
END;	
$BODY$
LANGUAGE 'plpgsql' STABLE;

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
    v_Min			NUMERIC := 0;
	Discount		NUMERIC := 0;
	Discount1Date		timestamp with time zone;
	Discount2Date		timestamp with time zone;
	Add1Date		NUMERIC := 0;
	Add2Date		NUMERIC := 0;
	p   			RECORD;
BEGIN
	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = Currency_ID;

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

$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION paymenttermduedate (in paymentterm_id numeric, in docdate timestamptz) RETURNS timestamptz AS
$BODY$
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
 * Title:	Get Due timestamp with time zone
 * Description:
 *	Returns the due timestamp with time zone
 * Test:
 *	select paymenttermDueDate(106, now()) from Test; => now()+30 days
 ************************************************************************/
DECLARE
 	Days				NUMERIC := 0;
	DueDate				timestamp with time zone := TRUNC(DocDate);
	--
	FirstDay			timestamp with time zone;
	NoDays				NUMERIC;
	p   			RECORD;
BEGIN
	FOR p IN 
		SELECT	*
		FROM	C_PaymentTerm
		WHERE	C_PaymentTerm_ID = PaymentTerm_ID
	LOOP	--	for convineance only
		--	Due 15th of following month
		IF (p.IsDueFixed = 'Y') THEN		
			FirstDay := TRUNC(DocDate, 'MM');
			NoDays := EXTRACT(day FROM TRUNC(DocDate) - FirstDay);
			DueDate := FirstDay + (p.FixMonthDay-1);	--	starting on 1st
			DueDate := ADD_MONTHS(DueDate, p.FixMonthOffset);
			IF (NoDays > p.FixMonthCutoff) THEN
				DueDate := ADD_MONTHS(DueDate, 1);
			END IF;
		ELSE
			DueDate := TRUNC(DocDate) + p.NetDays;
		END IF;
	END LOOP;
	RETURN DueDate;
END;
$BODY$
LANGUAGE 'plpgsql' STABLE
;

create or replace FUNCTION   paymenttermDueDays 
(
	PaymentTerm_ID	IN	NUMERIC,
	DocDate			IN	timestamp with time zone,
	PayDate			IN	timestamp with time zone
)
RETURNS INTEGER AS $body$
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
 * Title:	Get Due Days
 * Description:
 *	Returns the days due (positive) or the days till due (negative)
 *	Grace days are not considered!
 *	If record is not found it assumes due immediately
 *
 *	Test:	SELECT paymenttermDueDays(103, now(), now());
 *
 * Contributor(s): Carlos Ruiz - globalqss - match with SQLJ version
 ************************************************************************/
DECLARE
 	Days			NUMERIC := 0;
	DueDate			timestamp with time zone := NULL;
	calDueDate		timestamp with time zone;
	FixMonthOffset		C_PaymentTerm.FixMonthOffset%TYPE;
	MaxDayCut		NUMERIC;
	MaxDay			NUMERIC;
	v_PayDate		timestamp with time zone;
	p   			RECORD;
	--
	FirstDay			timestamp with time zone;
	NoDays				NUMERIC;
BEGIN

    	IF PaymentTerm_ID = 0 OR DocDate IS NULL THEN
	    RETURN 0;
	END IF;

    	v_PayDate := PayDate;
	IF v_PayDate IS NULL THEN
	    v_PayDate := TRUNC(now());
	END IF;

	FOR p IN 
		SELECT	*
		FROM	C_PaymentTerm
		WHERE	C_PaymentTerm_ID = PaymentTerm_ID
	LOOP	--	for convineance only

		--	Due 15th of following month
		IF (p.IsDueFixed = 'Y') THEN
			FirstDay := TRUNC(DocDate, 'MM');
			NoDays := extract (day from (TRUNC(DocDate) - FirstDay));
			DueDate := FirstDay + (p.FixMonthDay-1);	--	starting on 1st
			DueDate := DueDate + (p.FixMonthOffset || ' month')::interval;
			
			IF (NoDays > p.FixMonthCutoff) THEN
				DueDate := DueDate + '1 month'::interval;
			END IF;
			-- raise notice 'FirstDay: %, NoDays: %, DueDate: %', FirstDay, NoDays, DueDate;
			
			calDueDate := TRUNC(DocDate);
			MaxDayCut := extract (day from (cast(date_trunc('month', calDueDate) + '1 month'::interval as date) - 1));
			-- raise notice 'last day(MaxDayCut): %' , MaxDayCut;

			IF p.FixMonthCutoff > MaxDayCut THEN
				-- raise notice 'p.FixMonthCutoff > MaxDayCut';
			    calDueDate := cast(date_trunc('month', TRUNC(calDueDate)) + '1 month'::interval as date) - 1;
				-- raise notice 'last day(calDueDate): %' , calDueDate;
			ELSE
			    -- set day fixmonthcutoff on duedate
			    calDueDate := TRUNC(calDueDate, 'MM') + (((p.FixMonthCutoff-1)|| ' days')::interval);
			    -- raise notice 'calDueDate: %' , calDueDate;
			    
			END IF;
			FixMonthOffset := p.FixMonthOffset;
			IF DocDate > calDueDate THEN
			    FixMonthOffset := FixMonthOffset + 1;
				raise notice 'FixMonthOffset: %' , FixMonthOffset;
			END IF;

			calDueDate := calDueDate + (FixMonthOffset || ' month')::interval;
			-- raise notice 'calDueDate: %' , calDueDate;

			MaxDay := extract (day from (cast(date_trunc('month', calDueDate) + '1 month'::interval as date) - 1));


			IF    (p.FixMonthDay > MaxDay)    --	32 -> 28
			   OR (p.FixMonthDay >= 30 AND MaxDay > p.FixMonthDay) THEN  	--	30 -> 31
				calDueDate := TRUNC(calDueDate, 'MM') + (((MaxDay-1)|| ' days')::interval);
				-- raise notice 'calDueDate: %' , calDueDate;			
			ELSE
				calDueDate := TRUNC(calDueDate, 'MM') + (((p.FixMonthDay-1)|| ' days')::interval);
				-- raise notice 'calDueDate: %' , calDueDate;			
			END IF;
			DueDate := calDueDate; 

		ELSE
			DueDate := TRUNC(DocDate) + p.NetDays;
		END IF;
	END LOOP;

    IF DueDate IS NULL THEN
	    RETURN 0;
	END IF;


	Days := EXTRACT(day from (TRUNC(v_PayDate) - DueDate));
	RETURN Days;
END;

$body$ LANGUAGE plpgsql STABLE;


create or replace FUNCTION paymentAllocated
(
	p_C_Payment_ID	IN	NUMERIC,
	p_C_Currency_ID	IN	NUMERIC
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
 * Title:	Calculate Allocated Payment Amount in Payment Currency
 * Description:
    --
    SELECT paymentAllocated(C_Payment_ID,C_Currency_ID), PayAmt, IsAllocated
    FROM C_Payment_v 
    WHERE C_Payment_ID<1000000;
    --
    UPDATE C_Payment_v 
    SET IsAllocated=CASE WHEN paymentAllocated(C_Payment_ID, C_Currency_ID)=PayAmt THEN 'Y' ELSE 'N' END
    WHERE C_Payment_ID>=1000000;
 
 ************************************************************************/
DECLARE
	v_Precision         NUMERIC := 0;
    v_Min            	NUMERIC := 0;
	v_AllocatedAmt		NUMERIC := 0;
    	v_PayAmt        	NUMERIC;
    	r   			RECORD;
BEGIN
	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = p_C_Currency_ID;

	SELECT 1/10^v_Precision INTO v_Min;
	
    --  Charge - nothing available
    SELECT 
      INTO v_PayAmt MAX(PayAmt) 
    FROM C_Payment 
    WHERE C_Payment_ID=p_C_Payment_ID AND C_Charge_ID > 0;
    
    IF (v_PayAmt IS NOT NULL) THEN
        RETURN v_PayAmt;
    END IF;
    
	--	Calculate Allocated Amount
	FOR r IN
		SELECT	a.AD_Client_ID, a.AD_Org_ID, al.Amount, a.C_Currency_ID, a.DateTrx
			FROM	C_AllocationLine al
	          INNER JOIN C_AllocationHdr a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
			WHERE	al.C_Payment_ID = p_C_Payment_ID
          	AND   a.IsActive='Y'
	LOOP
		v_AllocatedAmt := v_AllocatedAmt
			+ currencyConvert(r.Amount, r.C_Currency_ID, p_C_Currency_ID, r.DateTrx, null, r.AD_Client_ID, r.AD_Org_ID);
	END LOOP;
	
	--	Ignore Rounding
	IF (v_AllocatedAmt > -v_Min AND v_AllocatedAmt < v_Min) THEN
		v_AllocatedAmt := 0;
	END IF;

	--	Round to currency precision
	v_AllocatedAmt := ROUND(COALESCE(v_AllocatedAmt,0), v_Precision);
	
	RETURN	v_AllocatedAmt;
END;

$body$ LANGUAGE plpgsql STABLE;

create or replace FUNCTION  paymentAvailable
(
	p_C_Payment_ID	IN	NUMERIC
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
 * Title:	Calculate Available Payment Amount in Payment Currency
 * Description:
 *		similar to C_Invoice_Open
 ************************************************************************/
DECLARE
	v_Currency_ID		NUMERIC(10);
	v_Precision         NUMERIC := 0;
    v_Min            	NUMERIC := 0;
	v_AvailableAmt		NUMERIC := 0;
    	v_IsReceipt         	C_Payment.IsReceipt%TYPE;
    	v_Amt               	NUMERIC := 0;
    	r   			RECORD;

BEGIN
    --  Charge - fully allocated
    SELECT MAX(PayAmt) 
      INTO v_Amt
    FROM C_Payment 
    WHERE C_Payment_ID=p_C_Payment_ID AND C_Charge_ID > 0;
    IF (v_Amt IS NOT NULL) THEN
        RETURN 0;
    END IF;

	--	Get Currency
	SELECT	C_Currency_ID, PayAmt, IsReceipt
	  INTO	v_Currency_ID, v_AvailableAmt, v_IsReceipt
	FROM	C_Payment_v     -- corrected for AP/AR
	WHERE	C_Payment_ID = p_C_Payment_ID;
--  DBMS_OUTPUT.PUT_LINE('== C_Payment_ID=' || p_C_Payment_ID || ', PayAmt=' || v_AvailableAmt || ', Receipt=' || v_IsReceipt);

	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = v_Currency_ID;

	SELECT 1/10^v_Precision INTO v_Min;

	--	Calculate Allocated Amount
	FOR r IN
		SELECT	a.AD_Client_ID, a.AD_Org_ID, al.Amount, a.C_Currency_ID, a.DateTrx
		FROM	C_AllocationLine al
	        INNER JOIN C_AllocationHdr a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
		WHERE	al.C_Payment_ID = p_C_Payment_ID
          	AND   a.IsActive='Y'
	LOOP
        v_Amt := currencyConvert(r.Amount, r.C_Currency_ID, v_Currency_ID, r.DateTrx, null, r.AD_Client_ID, r.AD_Org_ID);
	    v_AvailableAmt := v_AvailableAmt - v_Amt;
--      DBMS_OUTPUT.PUT_LINE('  Allocation=' || a.Amount || ' - Available=' || v_AvailableAmt);
	END LOOP;
	
	--	Ignore Rounding
	IF (v_AvailableAmt > -v_Min AND v_AvailableAmt < v_Min) THEN
		v_AvailableAmt := 0;
	END IF;

	--	Round to currency precision
	v_AvailableAmt := ROUND(COALESCE(v_AvailableAmt,0), v_Precision);
	
	RETURN	v_AvailableAmt;
END;

$body$ LANGUAGE plpgsql STABLE;

set client_encoding='LATIN1';

CREATE OR REPLACE FUNCTION      ProductAttribute 
(
    p_M_AttributeSetInstance_ID     NUMERIC
)
RETURNS VARCHAR AS $body$

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
 * Title: Return Instance Attribute Info
 * Description:
 *  
 * Test:
    SELECT ProductAttribute (M_AttributeSetInstance_ID) 
    FROM M_InOutLine WHERE M_AttributeSetInstance_ID > 0
    --
    SELECT p.Name
    FROM C_InvoiceLine il LEFT OUTER JOIN M_Product p ON (il.M_Product_ID=p.M_Product_ID);
    SELECT p.Name || ProductAttribute (il.M_AttributeSetInstance_ID) 
    FROM C_InvoiceLine il LEFT OUTER JOIN M_Product p ON (il.M_Product_ID=p.M_Product_ID);
    
 ************************************************************************/

	
DECLARE

    v_Name          VARCHAR(2000) := '';
    v_NameAdd       VARCHAR(2000) := '';
    --
    v_Lot           M_AttributeSetInstance.Lot%TYPE;
    v_LotStart      M_AttributeSet.LotCharSOverwrite%TYPE;
    v_LotEnd        M_AttributeSet.LotCharEOverwrite%TYPE;
    v_SerNo         M_AttributeSetInstance.SerNo%TYPE;
    v_SerNoStart    M_AttributeSet.SerNoCharSOverwrite%TYPE;
    v_SerNoEnd      M_AttributeSet.SerNoCharEOverwrite%TYPE;
    v_GuaranteeDate M_AttributeSetInstance.GuaranteeDate%TYPE;
    
    r   RECORD;
    --

BEGIN
    --  Get Product Attribute Set Instance
    IF (p_M_AttributeSetInstance_ID > 0) THEN
        SELECT asi.Lot, asi.SerNo, asi.GuaranteeDate,
            COALESCE(a.SerNoCharSOverwrite, '#'::CHAR(1)), COALESCE(a.SerNoCharEOverwrite, ''::CHAR(1)),
            COALESCE(a.LotCharSOverwrite, '«'::CHAR(1)), COALESCE(a.LotCharEOverwrite, '»'::CHAR(1))
          INTO v_Lot, v_SerNo, v_GuaranteeDate,
            v_SerNoStart, v_SerNoEnd, v_LotStart, v_LotEnd
        FROM M_AttributeSetInstance asi
          INNER JOIN M_AttributeSet a ON (asi.M_AttributeSet_ID=a.M_AttributeSet_ID)
        WHERE asi.M_AttributeSetInstance_ID=p_M_AttributeSetInstance_ID;
        --
        IF (v_SerNo IS NOT NULL) THEN
            v_NameAdd := v_NameAdd || v_SerNoStart || v_SerNo || v_SerNoEnd || ' ';
        END IF;
        IF (v_Lot IS NOT NULL) THEN
            v_NameAdd := v_NameAdd || v_LotStart || v_Lot || v_LotEnd || ' ';
        END IF;
        IF (v_GuaranteeDate IS NOT NULL) THEN
            v_NameAdd := v_NameAdd || v_GuaranteeDate || ' ';
        END IF;
        --
        
        FOR r IN
	     SELECT ai.Value, a.Name
	        FROM M_AttributeInstance ai
	        INNER JOIN M_Attribute a ON (ai.M_Attribute_ID=a.M_Attribute_ID AND a.IsInstanceAttribute='Y')
        	WHERE ai.M_AttributeSetInstance_ID=p_M_AttributeSetInstance_ID
    	LOOP
            v_NameAdd := v_NameAdd || r.Name || ':' || r.Value || ' ';
        END LOOP;
        --
        IF (LENGTH(v_NameAdd) > 0) THEN
            v_Name := v_Name || ' (' || TRIM(v_NameAdd) || ')';
	ELSE 
	    v_Name := NULL;
        END IF;
    END IF;
    RETURN v_Name;
END;

$body$ LANGUAGE plpgsql STABLE;

/*
*This file is part of Adempiere ERP Bazaar
*http://www.adempiere.org
*
*Copyright (C) 2007 Low Heng Sin
*Copyright (C) 1999-2006 ComPiere, inc
*
*This program is free software; you can redistribute it and/or
*modify it under the terms of the GNU General Public License
*as published by the Free Software Foundation; either version 2
*of the License, or (at your option) any later version.
*
*This program is distributed in the hope that it will be useful,
*but WITHOUT ANY WARRANTY; without even the implied warranty of
*MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*GNU General Public License for more details.
*
*You should have received a copy of the GNU General Public License
*along with this program; if not, write to the Free Software
*Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.of
*/

CREATE OR REPLACE FUNCTION addDays(datetime TIMESTAMP WITH TIME ZONE, days Numeric)
RETURNS DATE AS $$
declare duration varchar;
BEGIN
	if datetime is null or days is null then
		return null;
	end if;
	duration = days || ' day';	 
	return cast(date_trunc('day',datetime) + cast(duration as interval) as date);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION subtractdays (day TIMESTAMP WITH TIME ZONE, days NUMERIC)
RETURNS DATE AS $$
BEGIN
    RETURN addDays(day,(days * -1));
END;
$$ LANGUAGE plpgsql IMMUTABLE;

/*
 *This file is part of Adempiere ERP Bazaar
 *http://www.adempiere.org
 *
 *Copyright (C) 2006 Gavin Dunse
 *Copyright (C) 1999-2006 ComPiere, inc
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either version 2
 *of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.of
 */

/** Get Character at Position */
CREATE OR REPLACE FUNCTION charAt (
 IN VARCHAR, -- $1 the string
 IN INTEGER -- $2 the position
) RETURNS VARCHAR AS
$$
 BEGIN
 RETURN SUBSTR($1, $2, 1);
 END;
$$ LANGUAGE plpgsql IMMUTABLE;

/*
*This file is part of Adempiere ERP Bazaar
*http://www.adempiere.org
*
*Copyright (C) 2007 Low Heng Sin
*Copyright (C) 1999-2006 ComPiere, inc
*
*This program is free software; you can redistribute it and/or
*modify it under the terms of the GNU General Public License
*as published by the Free Software Foundation; either version 2
*of the License, or (at your option) any later version.
*
*This program is distributed in the hope that it will be useful,
*but WITHOUT ANY WARRANTY; without even the implied warranty of
*MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*GNU General Public License for more details.
*
*You should have received a copy of the GNU General Public License
*along with this program; if not, write to the Free Software
*Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.of
*/

CREATE OR REPLACE FUNCTION daysBetween(p_date1 TIMESTAMP WITH TIME ZONE, p_date2 TIMESTAMP WITH TIME ZONE)
RETURNS INTEGER AS $$
BEGIN
	RETURN CAST(p_date1 AS DATE) - CAST(p_date2 as DATE);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

/*
 *This file is part of Adempiere ERP Bazaar
 *http://www.adempiere.org
 *Copyright (C) 2006-2008 Antonio CaÃ±averal, e-Evolution
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either version 2
 *of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.of 
 * Return the Document for Dcocument Type
 */
create or replace FUNCTION documentNo
(
      p_PP_MRP_ID IN PP_MRP.PP_MRP_ID%TYPE
)
RETURNS PP_MRP.Value%TYPE
AS
$BODY$
DECLARE
	v_DocumentNo PP_MRP.Value%TYPE := '';
BEGIN
	-- If NO id return empty string
	IF p_PP_MRP_ID <= 0 THEN
		RETURN '';
	END IF;
	SELECT --ordertype, m_forecast_id, c_order_id, dd_order_id, pp_order_id, m_requisition_id,
	CASE
			WHEN trim(mrp.ordertype) = 'FTC' THEN (SELECT f.Name FROM M_Forecast f WHERE f.M_Forecast_ID=mrp.M_Forecast_ID)
			WHEN trim(mrp.ordertype) = 'POO' THEN (SELECT co.DocumentNo  FROM C_Order co WHERE co.C_Order_ID=mrp.C_Order_ID)
			WHEN trim(mrp.ordertype) = 'DOO' THEN (SELECT dd.DocumentNo  FROM DD_Order dd WHERE dd.DD_Order_ID=mrp.DD_Order_ID)
			WHEN trim(mrp.ordertype) = 'SOO' THEN (SELECT co.DocumentNo  FROM C_Order co WHERE co.C_Order_ID=mrp.C_Order_ID)
			WHEN trim(mrp.ordertype) = 'MOP' THEN (SELECT po.DocumentNo FROM PP_Order po WHERE po.PP_Order_ID=mrp.PP_Order_ID)
			WHEN trim(mrp.ordertype) = 'POR' THEN (SELECT r.DocumentNo  FROM M_Requisition r WHERE r.M_Requisition_ID=mrp.M_Requisition_ID)
			
	END INTO v_DocumentNo
	FROM pp_mrp mrp
	WHERE mrp.pp_mrp_id = p_PP_MRP_ID;
	RETURN v_DocumentNo;
END;	
$BODY$
  LANGUAGE 'plpgsql' STABLE;

/*
*This file is part of Adempiere ERP Bazaar
*http://www.adempiere.org
*
*Copyright (C) 2006 Gavin Dunse
*Copyright (C) 1999-2006 ComPiere, inc
*
*This program is free software; you can redistribute it and/or
*modify it under the terms of the GNU General Public License
*as published by the Free Software Foundation; either version 2
*of the License, or (at your option) any later version.
*
*This program is distributed in the hope that it will be useful,
*but WITHOUT ANY WARRANTY; without even the implied warranty of
*MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*GNU General Public License for more details.
*
*You should have received a copy of the GNU General Public License
*along with this program; if not, write to the Free Software
*Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.of
*/

/** Get Character at Position */
SET search_path = adempiere, pg_catalog;

CREATE OR REPLACE FUNCTION firstOf (
IN TIMESTAMP WITH TIME ZONE, -- $1 date
IN VARCHAR -- $2 part of date
) RETURNS DATE AS
$$
DECLARE
datepart VARCHAR;
datetime TIMESTAMP WITH TIME ZONE;
offsetdays INTEGER;
BEGIN
	datepart = $2;
	offsetdays = 0;
	IF $2 IN ('') THEN
		datepart = 'millennium';
	ELSEIF $2 IN ('') THEN
		datepart = 'century';
	ELSEIF $2 IN ('') THEN
		datepart = 'decade';
	ELSEIF $2 IN ('IYYY','IY','I') THEN
		datepart = 'year';
	ELSEIF $2 IN ('SYYYY','YYYY','YEAR','SYEAR','YYY','YY','Y') THEN
		datepart = 'year';
	ELSEIF $2 IN ('Q') THEN
		datepart = 'quarter';
	ELSEIF $2 IN ('MONTH','MON','MM','RM') THEN
		datepart = 'month';
	ELSEIF $2 IN ('IW') THEN
		datepart = 'week';
	ELSEIF $2 IN ('W') THEN
		datepart = 'week';
	ELSEIF $2 IN ('DDD','DD','J') THEN
		datepart = 'day';
	ELSEIF $2 IN ('DAY','DY','D') THEN
		datepart = 'week';
		-- move to sunday to make it compatible with oracle and SQLJ
		offsetdays = -1;
	ELSEIF $2 IN ('HH','HH12','HH24') THEN
		datepart = 'hour';
	ELSEIF $2 IN ('MI') THEN
		datepart = 'minute';
	ELSEIF $2 IN ('') THEN
		datepart = 'second';
	ELSEIF $2 IN ('') THEN
		datepart = 'milliseconds';
	ELSEIF $2 IN ('') THEN
		datepart = 'microseconds';
	END IF;
	datetime = date_trunc(datepart, $1); 
RETURN cast(datetime as date) + offsetdays;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

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
   LANGUAGE plpgsql STABLE
;

/*
 *This file is part of Adempiere ERP Bazaar
 *http://www.adempiere.org
 *Copyright (C) 2006-2008 victor.perez@e-evolution.com, e-Evolution
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either version 2
 *of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.of 
 *
 * Author: Carlos Ruiz (globalqss)
 */
CREATE OR REPLACE FUNCTION get_Sysconfig
(
    sysconfig_name ad_sysconfig.name%TYPE,
    defaultvalue ad_sysconfig.value%TYPE,
    client_id ad_sysconfig.ad_client_id%TYPE,
    org_id ad_sysconfig.ad_org_id%TYPE
)
RETURNS ad_sysconfig.value%TYPE 
AS
$BODY$
DECLARE
 	v_value ad_sysconfig.value%TYPE;
BEGIN
    BEGIN
	    SELECT Value
	      INTO STRICT v_value
	      FROM AD_SysConfig WHERE Name=sysconfig_name AND AD_Client_ID IN (0, client_id) AND AD_Org_ID IN (0, org_id) AND IsActive='Y' 
	     ORDER BY AD_Client_ID DESC, AD_Org_ID DESC
	     LIMIT 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_value := defaultvalue;
    END;
	RETURN v_value;
END;
$BODY$
  LANGUAGE 'plpgsql' STABLE;

CREATE OR REPLACE FUNCTION nextbusinessday(p_date timestamp with time zone, p_ad_client_id numeric) RETURNS timestamp with time zone
    AS $$
/**
*This file is part of Adempiere ERP Bazaar
*http://www.adempiere.org
*
*Copyright (C) 2007 Teo Sarca
*
*This program is free software; you can redistribute it and/or
*modify it under the terms of the GNU General Public License
*as published by the Free Software Foundation; either version 2
*of the License, or (at your option) any later version.
*
*This program is distributed in the hope that it will be useful,
*but WITHOUT ANY WARRANTY; without even the implied warranty of
*MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*GNU General Public License for more details.
*
*You should have received a copy of the GNU General Public License
*along with this program; if not, write to the Free Software
*Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.of
*
* Converted to PostgreSQL by Tony Snook, 
* tspc@dodo.com.au 
*/
DECLARE
	v_nextDate	date := trunc(p_Date);
	v_offset	numeric	:= 0;
	v_Saturday	numeric	:= TO_CHAR(TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'D');
	v_Sunday	numeric	:= (case when v_Saturday = 7 then 1 else v_Saturday + 1 end);
	v_isHoliday	boolean	:= true;
	v_country       c_country.c_country_id%type;
	nbd C_NonBusinessDay%ROWTYPE;
begin
	v_isHoliday := true;
	loop
		SELECT	CASE TO_CHAR(v_nextDate,'D')::numeric 
					WHEN v_Saturday THEN 2
					WHEN v_Sunday THEN 1
					ELSE 0
				END INTO v_offset;
		v_nextDate := v_nextDate + v_offset::integer;
		v_isHoliday := false;
		SELECT COALESCE(MAX(co.c_country_id), 100) 
		INTO   v_country
		FROM   ad_client cl 
		       JOIN ad_language l ON cl.ad_language = l.ad_language 
		       JOIN c_country co ON l.countrycode = co.countrycode 
		WHERE  cl.ad_client_id = p_ad_client_id;
		FOR nbd IN	SELECT * 
					FROM C_NonBusinessDay 
					WHERE AD_Client_ID=p_AD_Client_ID and IsActive ='Y' and Date1 >= v_nextDate
					    AND COALESCE(C_Country_ID,0) IN (0, v_country)
					ORDER BY Date1
		LOOP
			exit when v_nextDate <> trunc(nbd.Date1);
			v_nextDate := v_nextDate + 1;
			v_isHoliday := true;
		end loop;
		exit when v_isHoliday=false;
	end loop;
	--
	return v_nextDate::timestamp with time zone;
end;
$$
    LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION prodqtyordered(p_product_id numeric, p_warehouse_id numeric)
  RETURNS numeric AS
$BODY$
DECLARE
	v_Warehouse_ID			numeric;
 	v_Quantity			numeric := 99999;	--	unlimited
	v_IsBOM				CHAR(1);
	v_IsStocked			CHAR(1);
	v_ProductType			CHAR(1);
 	v_ProductQty			numeric;
	v_StdPrecision			int;
BEGIN
	--	Check Parameters
	v_Warehouse_ID := p_Warehouse_ID;
	IF (v_Warehouse_ID IS NULL) THEN
		RETURN 0;
	END IF;
--	DBMS_OUTPUT.PUT_LINE('Warehouse=' || v_Warehouse_ID);

	--	Check, if product exists and if it is stocked
	BEGIN
		SELECT	IsBOM, ProductType, IsStocked
		  INTO	v_IsBOM, v_ProductType, v_IsStocked
		FROM M_PRODUCT
		WHERE M_Product_ID=p_Product_ID;
		--
	EXCEPTION	--	not found
		WHEN OTHERS THEN
			RETURN 0;
	END;

	--	No reservation for non-stocked
	IF (v_IsStocked='Y') THEN
		--	Get ProductQty
		SELECT 	COALESCE(SUM(MovementQty), 0)
		  INTO	v_ProductQty
		FROM 	M_ProductionLine p
		WHERE M_Product_ID=p_Product_ID AND MovementQty > 0 AND p.Processed = 'N'
		  AND EXISTS (SELECT * FROM M_LOCATOR l WHERE p.M_Locator_ID=l.M_Locator_ID
		  	AND l.M_Warehouse_ID=v_Warehouse_ID);
		--
		RETURN v_ProductQty;
	END IF;

	--	Unlimited (e.g. only services)
	IF (v_Quantity = 99999) THEN
		RETURN 0;
	END IF;

	IF (v_Quantity > 0) THEN
		--	Get Rounding Precision for Product
		SELECT 	COALESCE(MAX(u.StdPrecision), 0)
		  INTO	v_StdPrecision
		FROM 	C_UOM u, M_PRODUCT p
		WHERE 	u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=p_Product_ID;
		--
		RETURN ROUND (v_Quantity, v_StdPrecision);
	END IF;
	RETURN 0;
END;
$BODY$
  LANGUAGE plpgsql STABLE
;

CREATE OR REPLACE FUNCTION prodqtyreserved(p_product_id numeric, p_warehouse_id numeric)
  RETURNS numeric AS
$BODY$
DECLARE
	v_Warehouse_ID			numeric;
 	v_Quantity			numeric := 99999;	--	unlimited
	v_IsBOM				CHAR(1);
	v_IsStocked			CHAR(1);
	v_ProductType			CHAR(1);
 	v_ProductQty			numeric;
	v_StdPrecision			int;
BEGIN
	--	Check Parameters
	v_Warehouse_ID := p_Warehouse_ID;
	IF (v_Warehouse_ID IS NULL) THEN
		RETURN 0;
	END IF;
--	DBMS_OUTPUT.PUT_LINE('Warehouse=' || v_Warehouse_ID);

	--	Check, if product exists and if it is stocked
BEGIN
		SELECT	IsBOM, ProductType, IsStocked
		  INTO	v_IsBOM, v_ProductType, v_IsStocked
		FROM M_PRODUCT
		WHERE M_Product_ID=p_Product_ID;
		--
	EXCEPTION	--	not found
		WHEN OTHERS THEN
			RETURN 0;
	END;

	--	No reservation for non-stocked
	IF (v_IsStocked='Y') THEN
		--	Get ProductQty
		SELECT 	-1*COALESCE(SUM(MovementQty), 0)
		  INTO	v_ProductQty
		FROM 	M_ProductionLine p
		WHERE M_Product_ID=p_Product_ID AND MovementQty < 0 AND p.Processed = 'N'
		  AND EXISTS (SELECT * FROM M_LOCATOR l WHERE p.M_Locator_ID=l.M_Locator_ID
		  	AND l.M_Warehouse_ID=v_Warehouse_ID);
		--
		RETURN v_ProductQty;
	END IF;

	--	Unlimited (e.g. only services)
	IF (v_Quantity = 99999) THEN
	RETURN 0;
	END IF;

	IF (v_Quantity > 0) THEN
		--	Get Rounding Precision for Product
		SELECT 	COALESCE(MAX(u.StdPrecision), 0)
		  INTO	v_StdPrecision
		FROM 	C_UOM u, M_PRODUCT p
		WHERE 	u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=p_Product_ID;
		--
	RETURN ROUND (v_Quantity, v_StdPrecision);
	END IF;
	RETURN 0;
END;
$BODY$
  LANGUAGE plpgsql STABLE
;

CREATE OR REPLACE FUNCTION round (
 IN NUMERIC, -- $1 numeric
 IN NUMERIC -- $2 numeric
) RETURNS NUMERIC AS
$$
 BEGIN
	RETURN ROUND($1, cast($2 as integer));
 END;
$$ LANGUAGE plpgsql IMMUTABLE;

/*
*This file is part of Adempiere ERP Bazaar
*http://www.adempiere.org
*
*Copyright (C) 2007 Low Heng Sin
*Copyright (C) 1999-2006 ComPiere, inc
*
*This program is free software; you can redistribute it and/or
*modify it under the terms of the GNU General Public License
*as published by the Free Software Foundation; either version 2
*of the License, or (at your option) any later version.
*
*This program is distributed in the hope that it will be useful,
*but WITHOUT ANY WARRANTY; without even the implied warranty of
*MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*GNU General Public License for more details.
*
*You should have received a copy of the GNU General Public License
*along with this program; if not, write to the Free Software
*Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.of
*/
CREATE OR REPLACE FUNCTION trunc(datetime TIMESTAMP WITH TIME ZONE)
RETURNS TIMESTAMP WITH TIME ZONE AS $$
BEGIN
	RETURN CAST(datetime AS DATE);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION trunc(datetime TIMESTAMP WITH TIME ZONE, format varchar)
RETURNS DATE AS $$
BEGIN
	IF format = 'Q' THEN
		RETURN CAST(DATE_Trunc('quarter',datetime) as DATE);
	ELSIF format = 'Y' or format = 'YEAR' THEN
		RETURN CAST(DATE_Trunc('year',datetime) as DATE);
	ELSIF format = 'MM' or format = 'MONTH' THEN
		RETURN CAST(DATE_Trunc('month',datetime) as DATE);
	ELSIF format = 'DD' THEN
		RETURN CAST(DATE_Trunc('day',datetime) as DATE);
	ELSIF format = 'DY' THEN
		RETURN CAST(DATE_Trunc('day',datetime) as DATE);
	ELSE
		RETURN CAST(datetime AS DATE);
	END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION trunc(i INTERVAL)
RETURNS INTEGER AS $$
BEGIN
	RETURN EXTRACT(DAY FROM i);
END;
$$ LANGUAGE plpgsql IMMUTABLE;


SELECT register_migration_script('201405301149_IDEMPIERE-1953.sql') FROM dual
;
