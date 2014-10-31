SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 26, 2014 12:15:00 PM SGT
-- IDEMPIERE-1856 Amount in database functions and views are hardcoded to round to 2 decimal points

CREATE OR REPLACE FUNCTION invoiceOpen
(
	p_C_Invoice_ID	            IN	NUMBER,
    p_C_InvoicePaySchedule_ID   IN  NUMBER
)
RETURN NUMBER
/*************************************************************************
 * The contents of this file are subject to the Compiere License.  You may
 * obtain a copy of the License at    http://www.compiere.org/license.html
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either
 * express or implied. See the License for details. Code: Compiere ERP+CRM
 * Copyright (C) 1999-2001 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *************************************************************************
 * $Id: C_Invoice_Open.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
 ***
 * Title:	Calculate Open Item Amount in Invoice Currency
 * Description:
 *	Add up total amount open for C_Invoice_ID if no split payment.
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
AS
	v_Currency_ID		NUMBER(10);
	v_Precision			NUMBER := 0;
	v_Min				NUMBER := 0;
	v_TotalOpenAmt  	NUMBER := 0;
	v_PaidAmt  	        NUMBER := 0;
	v_Remaining	        NUMBER := 0;
    v_MultiplierAP      NUMBER := 0;
    v_MultiplierCM      NUMBER := 0;
    v_Temp              NUMBER := 0;
    --
	CURSOR	Cur_Alloc	IS
		SELECT	a.AD_Client_ID, a.AD_Org_ID,
            al.Amount, al.DiscountAmt, al.WriteOffAmt,
            a.C_Currency_ID, a.DateTrx
		FROM	C_AllocationLine al
          INNER JOIN C_AllocationHdr a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
		WHERE	al.C_Invoice_ID = p_C_Invoice_ID
          AND   a.IsActive='Y';
    --
	CURSOR	Cur_PaySchedule	IS
        SELECT  C_InvoicePaySchedule_ID, DueAmt
        FROM    C_InvoicePaySchedule
		WHERE	C_Invoice_ID = p_C_Invoice_ID
          AND   IsValid='Y'
        ORDER BY DueDate;

BEGIN
	--	Get Currency
	BEGIN
		SELECT	MAX(C_Currency_ID), SUM(GrandTotal), MAX(MultiplierAP), MAX(Multiplier)
		  INTO	v_Currency_ID, v_TotalOpenAmt, v_MultiplierAP, v_MultiplierCM
		FROM	C_Invoice_v		--	corrected for CM / Split Payment
		WHERE	C_Invoice_ID = p_C_Invoice_ID;
	EXCEPTION	--	Invoice in draft form
		WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('InvoiceOpen - ' || SQLERRM);
			RETURN NULL;
	END;
--  DBMS_OUTPUT.PUT_LINE('== C_Invoice_ID=' || p_C_Invoice_ID || ', Total=' || v_TotalOpenAmt || ', AP=' || v_MultiplierAP || ', CM=' || v_MultiplierCM);

	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = v_Currency_ID;

	SELECT POWER(1/10,v_Precision) INTO v_Min FROM DUAL;

	--	Calculate Allocated Amount
	FOR a IN Cur_Alloc LOOP
        v_Temp := a.Amount + a.DisCountAmt + a.WriteOffAmt;
		v_PaidAmt := v_PaidAmt
        -- Allocation
			+ currencyConvert(v_Temp * v_MultiplierAP,
				a.C_Currency_ID, v_Currency_ID, a.DateTrx, null, a.AD_Client_ID, a.AD_Org_ID);
      DBMS_OUTPUT.PUT_LINE('   PaidAmt=' || v_PaidAmt || ', Allocation=' || v_Temp || ' * ' || v_MultiplierAP);
	END LOOP;

    --  Do we have a Payment Schedule ?
    IF (p_C_InvoicePaySchedule_ID > 0) THEN --   if not valid = lists invoice amount
        v_Remaining := v_PaidAmt;
        FOR s IN Cur_PaySchedule LOOP
            IF (s.C_InvoicePaySchedule_ID = p_C_InvoicePaySchedule_ID) THEN
                v_TotalOpenAmt := (s.DueAmt*v_MultiplierCM) - v_Remaining;
                IF (s.DueAmt - v_Remaining < 0) THEN
                    v_TotalOpenAmt := 0;
                END IF;
            --  DBMS_OUTPUT.PUT_LINE('Sched Total=' || v_TotalOpenAmt || ', Due=' || s.DueAmt || ',Remaining=' || v_Remaining || ',CM=' || v_MultiplierCM);
            ELSE -- calculate amount, which can be allocated to next schedule
                v_Remaining := v_Remaining - s.DueAmt;
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
END invoiceOpen;
/

CREATE OR REPLACE FUNCTION InvoiceopenToDate
(
 p_C_Invoice_ID             IN NUMBER,
    p_C_InvoicePaySchedule_ID   IN  NUMBER,
	p_DateAcct IN DATE
)
RETURN NUMBER
/*************************************************************************
 * The contents of this file are subject to the Compiere License.  You may
 * obtain a copy of the License at    http://www.compiere.org/license.html
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either
 * express or implied. See the License for details. Code: Compiere ERP+CRM
 * Copyright (C) 1999-2001 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *************************************************************************
 * $Id: C_Invoice_Open.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
 ***
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
AS
 v_Currency_ID  NUMBER(10);
 v_Precision	NUMBER := 0;
 v_Min			NUMBER := 0;
 v_TotalOpenAmt   NUMBER := 0;
 v_PaidAmt           NUMBER := 0;
 v_Remaining         NUMBER := 0;
    v_MultiplierAP      NUMBER := 0;
    v_MultiplierCM      NUMBER := 0;
    v_Temp              NUMBER := 0;
    --
 CURSOR Cur_Alloc IS
  SELECT a.AD_Client_ID, a.AD_Org_ID,
            al.Amount, al.DiscountAmt, al.WriteOffAmt,
            a.C_Currency_ID, a.DateTrx
  FROM C_ALLOCATIONLINE al
          INNER JOIN C_ALLOCATIONHDR a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
  WHERE al.C_Invoice_ID = p_C_Invoice_ID
    AND a.DateAcct <= p_DateAcct
    AND   a.IsActive='Y';
    --
 CURSOR Cur_PaySchedule IS
        SELECT  C_InvoicePaySchedule_ID, DueAmt
        FROM    C_INVOICEPAYSCHEDULE
  WHERE C_Invoice_ID = p_C_Invoice_ID
          AND   IsValid='Y'
        ORDER BY DueDate;

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
            DBMS_OUTPUT.PUT_LINE('InvoiceOpen - ' || SQLERRM);
   RETURN NULL;
 END;
--  DBMS_OUTPUT.PUT_LINE('== C_Invoice_ID=' || p_C_Invoice_ID || ', Total=' || v_TotalOpenAmt || ', AP=' || v_MultiplierAP || ', CM=' || v_MultiplierCM);

	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = v_Currency_ID;

	SELECT POWER(1/10,v_Precision) INTO v_Min FROM DUAL;

 -- Calculate Allocated Amount
 FOR a IN Cur_Alloc LOOP
        v_Temp := a.Amount + a.DisCountAmt + a.WriteOffAmt;
  v_PaidAmt := v_PaidAmt
        -- Allocation
   + Currencyconvert(v_Temp * v_MultiplierAP,
    a.C_Currency_ID, v_Currency_ID, a.DateTrx, NULL, a.AD_Client_ID, a.AD_Org_ID);
      DBMS_OUTPUT.PUT_LINE('   PaidAmt=' || v_PaidAmt || ', Allocation=' || v_Temp || ' * ' || v_MultiplierAP);
 END LOOP;

    --  Do we have a Payment Schedule ?
    IF (p_C_InvoicePaySchedule_ID > 0) THEN --   if not valid = lists invoice amount
        v_Remaining := v_PaidAmt;
        FOR s IN Cur_PaySchedule LOOP
            IF (s.C_InvoicePaySchedule_ID = p_C_InvoicePaySchedule_ID) THEN
                v_TotalOpenAmt := (s.DueAmt*v_MultiplierCM) - v_Remaining;
                IF (s.DueAmt - v_Remaining < 0) THEN
                    v_TotalOpenAmt := 0;
                END IF;
            --  DBMS_OUTPUT.PUT_LINE('Sched Total=' || v_TotalOpenAmt || ', Due=' || s.DueAmt || ',Remaining=' || v_Remaining || ',CM=' || v_MultiplierCM);
            ELSE -- calculate amount, which can be allocated to next schedule
                v_Remaining := v_Remaining - s.DueAmt;
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
END InvoiceopenToDate;
/

CREATE OR REPLACE FUNCTION invoicePaid
(
	p_C_Invoice_ID		IN	NUMBER,
	p_C_Currency_ID	    IN	NUMBER,
	p_MultiplierAP		IN	NUMBER	-- DEFAULT 1
)
RETURN NUMBER
/*************************************************************************
 * The contents of this file are subject to the Compiere License.  You may
 * obtain a copy of the License at    http://www.compiere.org/license.html 
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either 
 * express or implied. See the License for details. Code: Compiere ERP+CRM
 * Copyright (C) 1999-2001 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *************************************************************************
 * $Id: C_Invoice_Paid.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
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
    SELECT C_Invoice_ID, IsPaid, IsSOTrx, GrandTotal, 
    C_Invoice_Paid (C_Invoice_ID, C_Currency_ID, MultiplierAP)
    FROM C_Invoice_v;
    --
    UPDATE C_Invoice_v1	
 	SET IsPaid = CASE WHEN C_Invoice_Paid(C_Invoice_ID,C_Currency_ID,MultiplierAP)=GrandTotal THEN 'Y' ELSE 'N' END 
    WHERE C_Invoice_ID>1000000
 *	
 ************************************************************************/
AS
	v_Precision         NUMBER := 0;
    v_Min            	NUMBER := 0;
	v_MultiplierAP		NUMBER := 1;
	v_PaymentAmt		NUMBER := 0;
	CURSOR	Cur_Alloc	IS
		SELECT	a.AD_Client_ID, a.AD_Org_ID, 
            al.Amount, al.DiscountAmt, al.WriteOffAmt, 
            a.C_Currency_ID, a.DateTrx
		FROM	C_AllocationLine al
          INNER JOIN C_AllocationHdr a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
		WHERE	al.C_Invoice_ID = p_C_Invoice_ID
          AND   a.IsActive='Y';
BEGIN
	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = p_C_Currency_ID;

	SELECT POWER(1/10,v_Precision) INTO v_Min FROM DUAL;
	
	--	Default
	IF (p_MultiplierAP IS NOT NULL) THEN
		v_MultiplierAP := p_MultiplierAP;
	END IF;
	--	Calculate Allocated Amount
	FOR a IN Cur_Alloc LOOP
		v_PaymentAmt := v_PaymentAmt
			+ currencyConvert(a.Amount + a.DisCountAmt + a.WriteOffAmt,
				a.C_Currency_ID, p_C_Currency_ID, a.DateTrx, null, a.AD_Client_ID, a.AD_Org_ID);
	END LOOP;
	
	--	Ignore Rounding
	IF (v_PaymentAmt > -v_Min AND v_PaymentAmt < v_Min) THEN
		v_PaymentAmt := 0;
	END IF;

	--	Round to currency precision
	v_PaymentAmt := ROUND(COALESCE(v_PaymentAmt,0), v_Precision);
	
	RETURN	v_PaymentAmt * v_MultiplierAP;
END invoicePaid;
/

CREATE OR REPLACE FUNCTION InvoicepaidToDate
(
	p_C_Invoice_ID		IN	NUMBER,
	p_C_Currency_ID	    IN	NUMBER,
	p_MultiplierAP		IN	NUMBER,	-- DEFAULT 1
	p_DateAcct IN DATE
)
RETURN NUMBER
/*************************************************************************
 * The contents of this file are subject to the Compiere License.  You may
 * obtain a copy of the License at    http://www.compiere.org/license.html
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either
 * express or implied. See the License for details. Code: Compiere ERP+CRM
 * Copyright (C) 1999-2001 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *************************************************************************
 * $Id: C_Invoice_Paid.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
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
    SELECT C_Invoice_ID, IsPaid, IsSOTrx, GrandTotal,
    C_Invoice_Paid (C_Invoice_ID, C_Currency_ID, MultiplierAP)
    FROM C_Invoice_v;
    --
    UPDATE C_Invoice_v1
 	SET IsPaid = CASE WHEN C_Invoice_Paid(C_Invoice_ID,C_Currency_ID,MultiplierAP)=GrandTotal THEN 'Y' ELSE 'N' END
    WHERE C_Invoice_ID>1000000
 *
 ************************************************************************/
AS
	v_Precision         NUMBER := 0;
    v_Min            	NUMBER := 0;
	v_MultiplierAP		NUMBER := 1;
	v_PaymentAmt		NUMBER := 0;
	CURSOR	Cur_Alloc	IS
		SELECT	a.AD_Client_ID, a.AD_Org_ID,
            al.Amount, al.DiscountAmt, al.WriteOffAmt,
            a.C_Currency_ID, a.DateTrx
		FROM	C_ALLOCATIONLINE al
          INNER JOIN C_ALLOCATIONHDR a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
		WHERE	al.C_Invoice_ID = p_C_Invoice_ID
          AND   a.IsActive='Y'
		  AND a.DateAcct <= p_DateAcct;
BEGIN
	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = p_C_Currency_ID;

	SELECT POWER(1/10,v_Precision) INTO v_Min FROM DUAL;
	
	--	Default
	IF (p_MultiplierAP IS NOT NULL) THEN
		v_MultiplierAP := p_MultiplierAP;
	END IF;
	--	Calculate Allocated Amount
	FOR a IN Cur_Alloc LOOP
		v_PaymentAmt := v_PaymentAmt
			+ Currencyconvert(a.Amount + a.DisCountAmt + a.WriteOffAmt,
				a.C_Currency_ID, p_C_Currency_ID, a.DateTrx, NULL, a.AD_Client_ID, a.AD_Org_ID);
	END LOOP;
	
	--	Ignore Rounding
	IF (v_PaymentAmt > -v_Min AND v_PaymentAmt < v_Min) THEN
		v_PaymentAmt := 0;
	END IF;

	--	Round to currency precision
	v_PaymentAmt := ROUND(COALESCE(v_PaymentAmt,0), v_Precision);
	
	RETURN	v_PaymentAmt * v_MultiplierAP;
END InvoicepaidToDate;
/

CREATE OR REPLACE FUNCTION paymentAllocated
(
	p_C_Payment_ID	IN	NUMBER,
	p_C_Currency_ID	IN	NUMBER
)
RETURN NUMBER
/*************************************************************************
 * The contents of this file are subject to the Compiere License.  You may
 * obtain a copy of the License at    http://www.compiere.org/license.html
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either
 * express or implied. See the License for details. Code: Compiere ERP+CRM
 * Copyright (C) 1999-2001 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *************************************************************************
 * $Id: C_Payment_Allocated.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
 ***
 * Title:	Calculate Allocated Payment Amount in Payment Currency
 * Description:
    --
    SELECT C_Payment_Allocated(C_Payment_ID,C_Currency_ID), PayAmt, IsAllocated
    FROM C_Payment_v 
    WHERE C_Payment_ID>=1000000;
    --
    UPDATE C_Payment_v 
    SET IsAllocated=CASE WHEN C_Payment_Allocated(C_Payment_ID, C_Currency_ID)=PayAmt THEN 'Y' ELSE 'N' END
    WHERE C_Payment_ID>=1000000;
 
 ************************************************************************/
AS
	v_Precision         NUMBER := 0;
    v_Min            	NUMBER := 0;
	v_AllocatedAmt		NUMBER := 0;
    v_PayAmt            NUMBER;
	CURSOR	Cur_Alloc	IS
		SELECT	a.AD_Client_ID, a.AD_Org_ID, al.Amount, a.C_Currency_ID, a.DateTrx
		FROM	C_AllocationLine al
          INNER JOIN C_AllocationHdr a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
		WHERE	al.C_Payment_ID = p_C_Payment_ID
          AND   a.IsActive='Y';
		--  AND	al.C_Invoice_ID IS NOT NULL;
BEGIN
	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = p_C_Currency_ID;

	SELECT POWER(1/10,v_Precision) INTO v_Min FROM DUAL;
	
    --  Charge - nothing available
    SELECT MAX(PayAmt) 
      INTO v_PayAmt
    FROM C_Payment 
    WHERE C_Payment_ID=p_C_Payment_ID AND C_Charge_ID > 0;
    IF (v_PayAmt IS NOT NULL) THEN
        RETURN v_PayAmt;
    END IF;
    
	--	Calculate Allocated Amount
	FOR a IN Cur_Alloc LOOP
		v_AllocatedAmt := v_AllocatedAmt
			+ currencyConvert(a.Amount, a.C_Currency_ID, p_C_Currency_ID, a.DateTrx, null, a.AD_Client_ID, a.AD_Org_ID);
	END LOOP;
	
	--	Ignore Rounding
	IF (v_AllocatedAmt > -v_Min AND v_AllocatedAmt < v_Min) THEN
		v_AllocatedAmt := 0;
	END IF;

	--	Round to currency precision
	v_AllocatedAmt := ROUND(COALESCE(v_AllocatedAmt,0), v_Precision);
	
	RETURN	v_AllocatedAmt;
END paymentAllocated;
/

CREATE OR REPLACE FUNCTION paymentAvailable
(
	p_C_Payment_ID	IN	NUMBER
)
RETURN NUMBER
/*************************************************************************
 * The contents of this file are subject to the Compiere License.  You may
 * obtain a copy of the License at    http://www.compiere.org/license.html
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either
 * express or implied. See the License for details. Code: Compiere ERP+CRM
 * Copyright (C) 1999-2001 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *************************************************************************
 * $Id: C_Payment_Available.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
 ***
 * Title:	Calculate Available Payment Amount in Payment Currency
 * Description:
 *		similar to C_Invoice_Open
 ************************************************************************/
AS
	v_Currency_ID		NUMBER(10);
	v_Precision         NUMBER := 0;
    v_Min            	NUMBER := 0;
	v_AvailableAmt		NUMBER := 0;
    v_IsReceipt         C_Payment.IsReceipt%TYPE;
    v_Amt               NUMBER := 0;
	CURSOR	Cur_Alloc	IS
		SELECT	a.AD_Client_ID, a.AD_Org_ID, al.Amount, a.C_Currency_ID, a.DateTrx
		FROM	C_AllocationLine al
          INNER JOIN C_AllocationHdr a ON (al.C_AllocationHdr_ID=a.C_AllocationHdr_ID)
		WHERE	al.C_Payment_ID = p_C_Payment_ID
          AND   a.IsActive='Y';
		--  AND	al.C_Invoice_ID IS NOT NULL;
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

	SELECT POWER(1/10,v_Precision) INTO v_Min FROM DUAL;
	
	--	Calculate Allocated Amount
	FOR a IN Cur_Alloc LOOP
        v_Amt := currencyConvert(a.Amount, a.C_Currency_ID, v_Currency_ID, a.DateTrx, null, a.AD_Client_ID, a.AD_Org_ID);
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
END paymentAvailable;
/

CREATE OR REPLACE FUNCTION paymentTermDiscount
(
	Amount			IN	NUMBER,
    Currency_ID     IN  NUMBER,
	PaymentTerm_ID	IN	NUMBER,
	DocDate			IN	DATE,
	PayDate			IN	DATE
)
RETURN NUMBER
/*************************************************************************
 * The contents of this file are subject to the Compiere License.  You may
 * obtain a copy of the License at    http://www.compiere.org/license.html
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either
 * express or implied. See the License for details. Code: Compiere ERP+CRM
 * Copyright (C) 1999-2001 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *************************************************************************
 * $Id: C_PaymentTerm_Discount.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
 ***
 * Title:	Calculate Discount
 * Description:
 *	Calculate the allowable Discount Amount of the Payment Term
 *
 *	Test:	SELECT C_PaymentTerm_Discount(17777, 103, '10-DEC-1999') FROM DUAL
 ************************************************************************/

AS
	v_Precision			NUMBER := 0;
    v_Min				NUMBER := 0;
	Discount			NUMBER := 0;
	CURSOR Cur_PT	IS
		SELECT	*
		FROM	C_PaymentTerm
		WHERE	C_PaymentTerm_ID = PaymentTerm_ID;
	Discount1Date		DATE;
	Discount2Date		DATE;
	Add1Date			NUMBER := 0;
	Add2Date			NUMBER := 0;
BEGIN
	SELECT StdPrecision
	    INTO v_Precision
	    FROM C_Currency
	    WHERE C_Currency_ID = Currency_ID;

	SELECT POWER(1/10,v_Precision) INTO v_Min FROM DUAL;
	
	--	No Data - No Discount
	IF (Amount IS NULL OR PaymentTerm_ID IS NULL OR DocDate IS NULL) THEN
		RETURN 0;
	END IF;

	FOR p IN Cur_PT LOOP	--	for convineance only
--		DBMS_OUTPUT.PUT_LINE(p.Name || ' - Doc = ' || TO_CHAR(DocDate));
		Discount1Date := TRUNC(DocDate + p.DiscountDays + p.GraceDays);
		Discount2Date := TRUNC(DocDate + p.DiscountDays2 + p.GraceDays);

		--	Next Business Day
		IF (p.IsNextBusinessDay='Y') THEN
			Discount1Date := nextBusinessDay(Discount1Date, p.AD_Client_ID);
			Discount2Date := nextBusinessDay(Discount2Date, p.AD_Client_ID);
		END IF;

		--	Discount 1
		IF (Discount1Date >= TRUNC(PayDate)) THEN
--			DBMS_OUTPUT.PUT_LINE('Discount 1 ' || TO_CHAR(Discount1Date) || ' ' || p.Discount);
			Discount := Amount * p.Discount / 100;
		--	Discount 2
		ELSIF (Discount2Date >= TRUNC(PayDate)) THEN
--			DBMS_OUTPUT.PUT_LINE('Discount 2 ' || TO_CHAR(Discount2Date) || ' ' || p.Discount2);
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
END paymentTermDiscount;
/

CREATE OR REPLACE VIEW C_INVOICELINE_V
(AD_CLIENT_ID, AD_ORG_ID, C_INVOICELINE_ID, C_INVOICE_ID, SALESREP_ID, 
 C_BPARTNER_ID, M_PRODUCT_ID, DOCUMENTNO, DATEINVOICED, DATEACCT, 
 ISSOTRX, DOCSTATUS, LINENETAMT, LINELISTAMT, LINELIMITAMT, 
 LINEDISCOUNTAMT, LINEOVERLIMITAMT, QTYINVOICED, QTYENTERED, LINE, 
 C_ORDERLINE_ID, C_UOM_ID, C_CAMPAIGN_ID, C_PROJECT_ID, C_ACTIVITY_ID, 
 C_PROJECTPHASE_ID, C_PROJECTTASK_ID)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID, 
	il.C_InvoiceLine_ID, i.C_Invoice_ID, i.SalesRep_ID, 
	i.C_BPartner_ID, il.M_Product_ID,  
	i.DocumentNo, i.DateInvoiced, i.DateAcct,
	i.IsSOTrx, i.DocStatus,
	currencyRound(i.Multiplier*LineNetAmt,i.C_Currency_ID,'N') AS LineNetAmt,
	currencyRound(i.Multiplier*PriceList*QtyInvoiced,i.C_Currency_ID,'N') AS LineListAmt,
	CASE WHEN COALESCE(il.PriceLimit, 0)=0 THEN currencyRound(i.Multiplier*LineNetAmt,i.C_Currency_ID,'N') ELSE currencyRound(i.Multiplier*il.PriceLimit*il.QtyInvoiced,i.C_Currency_ID,'N') END AS LineLimitAmt,
	currencyRound(i.Multiplier*il.PriceList*il.QtyInvoiced-il.LineNetAmt,i.C_Currency_ID,'N') AS LineDiscountAmt,
	CASE WHEN COALESCE(il.PriceLimit,0)=0 THEN 0 ELSE currencyRound(i.Multiplier*il.LineNetAmt-il.PriceLimit*il.QtyInvoiced,i.C_Currency_ID,'N') END AS LineOverLimitAmt,
	il.QtyInvoiced, il.QtyEntered,
	il.Line, il.C_OrderLine_ID, il.C_UOM_ID,
    il.C_Campaign_ID, il.C_Project_ID, il.C_Activity_ID, il.C_ProjectPhase_ID, il.C_ProjectTask_ID
FROM C_Invoice_v i, C_InvoiceLine il
WHERE i.C_Invoice_ID=il.C_Invoice_ID;

--COMMENT ON TABLE C_INVOICELINE_V IS 'Invoice Line Summary for Reporting Views - Corrected for Credit Memos';

CREATE OR REPLACE VIEW M_PRODUCT_SUBSTITUTERELATED_V AS
SELECT s.ad_client_id, 
		s.ad_org_id, 
		s.isactive, 
		s.created, 
		s.createdby, 
		s.updated, 
		s.updatedby,
		s.m_product_id, 
		s.substitute_id, 
		'S' AS rowtype,
		mp.name, 
		sum(ms.qtyonhand - ms.qtyreserved) AS qtyavailable, 
		sum(ms.qtyonhand) AS qtyonhand, 
		sum(ms.qtyreserved) AS qtyreserved,
		currencyRound(MAX(mpr.pricestd),mpl.C_Currency_ID,'N') AS pricestd, 
		mpr.m_pricelist_version_id, 
		mw.m_warehouse_id, 
		org.name AS orgname
           FROM m_substitute s
      JOIN m_storage ms ON ms.m_product_id = s.substitute_id
   JOIN m_product mp ON ms.m_product_id = mp.m_product_id
   JOIN m_locator ml ON ms.m_locator_id = ml.m_locator_id
   JOIN m_warehouse mw ON ml.m_warehouse_id = mw.m_warehouse_id
   JOIN m_productprice mpr ON ms.m_product_id = mpr.m_product_id 
   JOIN m_pricelist_version mplv ON mplv.m_pricelist_version_id = mpr.m_pricelist_version_id 
   JOIN m_pricelist mpl ON mplv.m_pricelist_id = mpl.m_pricelist_id 
   JOIN ad_org org ON org.ad_org_id = mw.ad_org_id
   GROUP BY s.ad_client_id, 
   			s.ad_org_id, 
   			s.isactive, 
   			s.created, 
   			s.createdby, 
   			s.updated, 
   			s.updatedby, 
   			s.m_product_id, 
   			s.substitute_id, 
   			mw.m_warehouse_id, 
   			mpr.m_pricelist_version_id, 
   			org.name,  
   			mp.name,
			mpl.C_Currency_ID 
	UNION 
         SELECT r.ad_client_id, 
         	r.ad_org_id, 
         	r.isactive, 
         	r.created, 
         	r.createdby, 
         	r.updated, 
         	r.updatedby,
			r.m_product_id, 
			r.relatedproduct_id AS substitute_id, 
			'R' AS rowtype,  
			mp.name, 
			sum(ms.qtyonhand - ms.qtyreserved) AS qtyavailable, 
			sum(ms.qtyonhand) AS qtyonhand, 
			sum(ms.qtyreserved) AS qtyreserved, 
			currencyRound(MAX(mpr.pricestd),mpl.C_Currency_ID,'N') AS pricestd, 
			mpr.m_pricelist_version_id, 
			mw.m_warehouse_id, 
			org.name AS orgname
           FROM m_relatedproduct r
      JOIN m_storage ms ON ms.m_product_id = r.relatedproduct_id
   JOIN m_product mp ON ms.m_product_id = mp.m_product_id
   JOIN m_locator ml ON ms.m_locator_id = ml.m_locator_id
   JOIN m_warehouse mw ON ml.m_warehouse_id = mw.m_warehouse_id
   JOIN m_productprice mpr ON ms.m_product_id = mpr.m_product_id 
   JOIN m_pricelist_version mplv ON mplv.m_pricelist_version_id = mpr.m_pricelist_version_id 
   JOIN m_pricelist mpl ON mplv.m_pricelist_id = mpl.m_pricelist_id 
   JOIN ad_org org ON org.ad_org_id = mw.ad_org_id 
   GROUP BY r.ad_client_id, 
   			r.ad_org_id, 
   			r.isactive, 
   			r.created, 
   			r.createdby, 
   			r.updated, 
   			r.updatedby, 
   			r.m_product_id, 
   			r.relatedproduct_id, 
   			mw.m_warehouse_id, 
   			mpr.m_pricelist_version_id, 
   			org.name,  
   			mp.name,
			mpl.C_Currency_ID;
			
CREATE OR REPLACE VIEW RV_C_INVOICE_CUSTOMERPRODQTR
(AD_CLIENT_ID, AD_ORG_ID, C_BPARTNER_ID, M_PRODUCT_CATEGORY_ID, DATEINVOICED, 
 LINENETAMT, LINELISTAMT, LINELIMITAMT, LINEDISCOUNTAMT, LINEDISCOUNT, 
 LINEOVERLIMITAMT, LINEOVERLIMIT, QTYINVOICED, ISSOTRX)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID,
	il.C_BPartner_ID, il.M_Product_Category_ID,
	firstOf(il.DateInvoiced, 'Q') AS DateInvoiced,	--	DD Day, DY Week, MM Month
	SUM(LineNetAmt) AS LineNetAmt,
	SUM(LineListAmt) AS LineListAmt,
	SUM(LineLimitAmt) AS LineLimitAmt,
	SUM(LineDiscountAmt) AS LineDiscountAmt,
	CASE WHEN SUM(LineListAmt)=0 THEN 0 ELSE
	  currencyRound((SUM(LineListAmt)-SUM(LineNetAmt))/SUM(LineListAmt)*100,i.C_Currency_ID,'N') END AS LineDiscount,
	SUM(LineOverLimitAmt) AS LineOverLimitAmt,
	CASE WHEN SUM(LineNetAmt)=0 THEN 0 ELSE
	  100-currencyRound((SUM(LineNetAmt)-SUM(LineOverLimitAmt))/SUM(LineNetAmt)*100,i.C_Currency_ID,'N') END AS LineOverLimit,
	SUM(QtyInvoiced) AS QtyInvoiced, il.IsSOTrx
FROM RV_C_InvoiceLine il
	INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID)
GROUP BY il.AD_Client_ID, il.AD_Org_ID, il.C_BPartner_ID, il.M_Product_Category_ID,
	firstOf(il.DateInvoiced, 'Q'), il.IsSOTrx, i.C_Currency_ID;

CREATE OR REPLACE VIEW RV_C_INVOICE_CUSTOMERVENDQTR
(AD_CLIENT_ID, AD_ORG_ID, C_BPARTNER_ID, VENDOR_ID, DATEINVOICED, 
 LINENETAMT, LINELISTAMT, LINELIMITAMT, LINEDISCOUNTAMT, LINEDISCOUNT, 
 LINEOVERLIMITAMT, LINEOVERLIMIT, QTYINVOICED)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID,
	il.C_BPartner_ID, po.C_BPartner_ID AS Vendor_ID,
	firstOf(il.DateInvoiced, 'Q') AS DateInvoiced,	--	DD Day, DY Week, MM Month
	SUM(LineNetAmt) AS LineNetAmt,
	SUM(LineListAmt) AS LineListAmt,
	SUM(LineLimitAmt) AS LineLimitAmt,
	SUM(LineDiscountAmt) AS LineDiscountAmt,
	CASE WHEN SUM(LineListAmt)=0 THEN 0 ELSE
	  currencyRound((SUM(LineListAmt)-SUM(LineNetAmt))/SUM(LineListAmt)*100,i.C_Currency_ID,'N') END AS LineDiscount,
	SUM(LineOverLimitAmt) AS LineOverLimitAmt,
	CASE WHEN SUM(LineNetAmt)=0 THEN 0 ELSE
	  100-currencyRound((SUM(LineNetAmt)-SUM(LineOverLimitAmt))/SUM(LineNetAmt)*100,i.C_Currency_ID,'N') END AS LineOverLimit,
	SUM(QtyInvoiced) AS QtyInvoiced
FROM RV_C_InvoiceLine il
	INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID)
	INNER JOIN M_Product_PO po ON (il.M_Product_ID=po.M_Product_ID)
WHERE il.IsSOTrx='Y'
GROUP BY il.AD_Client_ID, il.AD_Org_ID, il.C_BPartner_ID, po.C_BPartner_ID,
	firstOf(il.DateInvoiced, 'Q'), i.C_Currency_ID;

CREATE OR REPLACE VIEW RV_C_INVOICE_DAY
(AD_CLIENT_ID, AD_ORG_ID, SALESREP_ID, DATEINVOICED, LINENETAMT, 
 LINELISTAMT, LINELIMITAMT, LINEDISCOUNTAMT, LINEDISCOUNT, LINEOVERLIMITAMT, 
 LINEOVERLIMIT, ISSOTRX)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID, il.SalesRep_ID,
	firstOf(il.DateInvoiced, 'DD') AS DateInvoiced,	--	DD Day, DY Week, MM Month
	SUM(LineNetAmt) AS LineNetAmt,
	SUM(LineListAmt) AS LineListAmt,
	SUM(LineLimitAmt) AS LineLimitAmt,
	SUM(LineDiscountAmt) AS LineDiscountAmt,
	CASE WHEN SUM(LineListAmt)=0 THEN 0 ELSE
	  currencyRound((SUM(LineListAmt)-SUM(LineNetAmt))/SUM(LineListAmt)*100,i.C_Currency_ID,'N') END AS LineDiscount,
	SUM(LineOverLimitAmt) AS LineOverLimitAmt,
	CASE WHEN SUM(LineNetAmt)=0 THEN 0 ELSE
	  100-currencyRound((SUM(LineNetAmt)-SUM(LineOverLimitAmt))/SUM(LineNetAmt)*100,i.C_Currency_ID,'N') END AS LineOverLimit,
    il.IsSOTrx
FROM RV_C_InvoiceLine il
	INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID)
GROUP BY il.AD_Client_ID, il.AD_Org_ID, il.SalesRep_ID,
	firstOf(il.DateInvoiced, 'DD'), il.IsSOTrx, i.C_Currency_ID;

CREATE OR REPLACE VIEW RV_C_INVOICE_MONTH
(AD_CLIENT_ID, AD_ORG_ID, SALESREP_ID, DATEINVOICED, LINENETAMT, 
 LINELISTAMT, LINELIMITAMT, LINEDISCOUNTAMT, LINEDISCOUNT, LINEOVERLIMITAMT, 
 LINEOVERLIMIT, ISSOTRX)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID, il.SalesRep_ID,
	firstOf(il.DateInvoiced, 'MM') AS DateInvoiced,	--	DD Day, DY Week, MM Month
	SUM(LineNetAmt) AS LineNetAmt,
	SUM(LineListAmt) AS LineListAmt,
	SUM(LineLimitAmt) AS LineLimitAmt,
	SUM(LineDiscountAmt) AS LineDiscountAmt,
	CASE WHEN SUM(LineListAmt)=0 THEN 0 ELSE
	  currencyRound((SUM(LineListAmt)-SUM(LineNetAmt))/SUM(LineListAmt)*100,i.C_Currency_ID,'N') END AS LineDiscount,
	SUM(LineOverLimitAmt) AS LineOverLimitAmt,
	CASE WHEN SUM(LineNetAmt)=0 THEN 0 ELSE
	  100-currencyRound((SUM(LineNetAmt)-SUM(LineOverLimitAmt))/SUM(LineNetAmt)*100,i.C_Currency_ID,'N') END AS LineOverLimit,
    il.IsSOTrx
FROM RV_C_InvoiceLine il 
	INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID)
GROUP BY il.AD_Client_ID, il.AD_Org_ID, il.SalesRep_ID,
	firstOf(il.DateInvoiced, 'MM'), il.IsSOTrx, i.C_Currency_ID;

CREATE OR REPLACE VIEW RV_C_INVOICE_PRODMONTH
(AD_CLIENT_ID, AD_ORG_ID, M_PRODUCT_CATEGORY_ID, DATEINVOICED, LINENETAMT, 
 LINELISTAMT, LINELIMITAMT, LINEDISCOUNTAMT, LINEDISCOUNT, LINEOVERLIMITAMT, 
 LINEOVERLIMIT, QTYINVOICED, ISSOTRX)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID, il.M_Product_Category_ID,
	firstOf(il.DateInvoiced, 'MM') AS DateInvoiced,
	SUM(il.LineNetAmt) AS LineNetAmt,
	SUM(il.LineListAmt) AS LineListAmt,
	SUM(il.LineLimitAmt) AS LineLimitAmt,
	SUM(il.LineDiscountAmt) AS LineDiscountAmt,
	CASE WHEN SUM(LineListAmt)=0 THEN 0 ELSE
	  currencyRound((SUM(LineListAmt)-SUM(LineNetAmt))/SUM(LineListAmt)*100,i.C_Currency_ID,'N') END AS LineDiscount,
	SUM(LineOverLimitAmt) AS LineOverLimitAmt,
	CASE WHEN SUM(LineNetAmt)=0 THEN 0 ELSE
	  100-currencyRound((SUM(LineNetAmt)-SUM(LineOverLimitAmt))/SUM(LineNetAmt)*100,i.C_Currency_ID,'N') END AS LineOverLimit,
	SUM(QtyInvoiced) AS QtyInvoiced, il.IsSOTrx
FROM RV_C_InvoiceLine il
	INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID)
GROUP BY il.AD_Client_ID, il.AD_Org_ID, il.M_Product_Category_ID,
	firstOf(il.DateInvoiced, 'MM'), il.IsSOTrx, i.C_Currency_ID;

CREATE OR REPLACE VIEW RV_C_INVOICE_PRODUCTMONTH
(AD_CLIENT_ID, AD_ORG_ID, M_PRODUCT_ID, DATEINVOICED, LINENETAMT, 
 LINELISTAMT, LINELIMITAMT, LINEDISCOUNTAMT, LINEDISCOUNT, LINEOVERLIMITAMT, 
 LINEOVERLIMIT, QTYINVOICED, ISSOTRX)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID, il.M_Product_ID,
	firstOf(il.DateInvoiced, 'MM') AS DateInvoiced,
	SUM(il.LineNetAmt) AS LineNetAmt,
	SUM(il.LineListAmt) AS LineListAmt,
	SUM(il.LineLimitAmt) AS LineLimitAmt,
	SUM(il.LineDiscountAmt) AS LineDiscountAmt,
	CASE WHEN SUM(LineListAmt)=0 THEN 0 ELSE
	  currencyRound((SUM(LineListAmt)-SUM(LineNetAmt))/SUM(LineListAmt)*100,i.C_Currency_ID,'N') END AS LineDiscount,
	SUM(LineOverLimitAmt) AS LineOverLimitAmt,
	CASE WHEN SUM(LineNetAmt)=0 THEN 0 ELSE
	  100-currencyRound((SUM(LineNetAmt)-SUM(LineOverLimitAmt))/SUM(LineNetAmt)*100,i.C_Currency_ID,'N') END AS LineOverLimit,
	SUM(QtyInvoiced) AS QtyInvoiced, il.IsSOTrx
FROM RV_C_InvoiceLine il
	INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID)
GROUP BY il.AD_Client_ID, il.AD_Org_ID, il.M_Product_ID,
	firstOf(il.DateInvoiced, 'MM'), il.IsSOTrx, i.C_Currency_ID;

CREATE OR REPLACE VIEW RV_C_INVOICE_PRODUCTQTR
(AD_CLIENT_ID, AD_ORG_ID, M_PRODUCT_ID, DATEINVOICED, LINENETAMT, 
 LINELISTAMT, LINELIMITAMT, LINEDISCOUNTAMT, LINEDISCOUNT, LINEOVERLIMITAMT, 
 LINEOVERLIMIT, QTYINVOICED, ISSOTRX)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID, il.M_Product_ID,
	firstOf(il.DateInvoiced, 'Q') AS DateInvoiced,
	SUM(il.LineNetAmt) AS LineNetAmt,
	SUM(il.LineListAmt) AS LineListAmt,
	SUM(il.LineLimitAmt) AS LineLimitAmt,
	SUM(il.LineDiscountAmt) AS LineDiscountAmt,
	CASE WHEN SUM(LineListAmt)=0 THEN 0 ELSE
	  currencyRound((SUM(LineListAmt)-SUM(LineNetAmt))/SUM(LineListAmt)*100,i.C_Currency_ID,'N') END AS LineDiscount,
	SUM(LineOverLimitAmt) AS LineOverLimitAmt,
	CASE WHEN SUM(LineNetAmt)=0 THEN 0 ELSE
	  100-currencyRound((SUM(LineNetAmt)-SUM(LineOverLimitAmt))/SUM(LineNetAmt)*100,i.C_Currency_ID,'N') END AS LineOverLimit,
	SUM(QtyInvoiced) AS QtyInvoiced, il.IsSOTrx
FROM RV_C_InvoiceLine il
	INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID)
GROUP BY il.AD_Client_ID, il.AD_Org_ID, il.M_Product_ID,
	firstOf(il.DateInvoiced, 'Q'), il.IsSOTrx, i.C_Currency_ID;

CREATE OR REPLACE VIEW RV_C_INVOICE_PRODWEEK
(AD_CLIENT_ID, AD_ORG_ID, M_PRODUCT_CATEGORY_ID, DATEINVOICED, LINENETAMT, 
 LINELISTAMT, LINELIMITAMT, LINEDISCOUNTAMT, LINEDISCOUNT, LINEOVERLIMITAMT, 
 LINEOVERLIMIT, QTYINVOICED, ISSOTRX)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID, il.M_Product_Category_ID,
	firstOf(il.DateInvoiced, 'DY') AS DateInvoiced,
	SUM(il.LineNetAmt) AS LineNetAmt,
	SUM(il.LineListAmt) AS LineListAmt,
	SUM(il.LineLimitAmt) AS LineLimitAmt,
	SUM(il.LineDiscountAmt) AS LineDiscountAmt,
	CASE WHEN SUM(LineListAmt)=0 THEN 0 ELSE
	  currencyRound((SUM(LineListAmt)-SUM(LineNetAmt))/SUM(LineListAmt)*100,i.C_Currency_ID,'N') END AS LineDiscount,
	SUM(LineOverLimitAmt) AS LineOverLimitAmt,
	CASE WHEN SUM(LineNetAmt)=0 THEN 0 ELSE
	  100-currencyRound((SUM(LineNetAmt)-SUM(LineOverLimitAmt))/SUM(LineNetAmt)*100,i.C_Currency_ID,'N') END AS LineOverLimit,
	SUM(QtyInvoiced) AS QtyInvoiced, il.IsSOTrx
FROM RV_C_InvoiceLine il
	INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID)
GROUP BY il.AD_Client_ID, il.AD_Org_ID, il.M_Product_Category_ID,
	firstOf(il.DateInvoiced, 'DY'), il.IsSOTrx, i.C_Currency_ID;

CREATE OR REPLACE VIEW RV_C_INVOICE_VENDORMONTH
(AD_CLIENT_ID, AD_ORG_ID, C_BPARTNER_ID, M_PRODUCT_CATEGORY_ID, DATEINVOICED, 
 LINENETAMT, LINELISTAMT, LINELIMITAMT, LINEDISCOUNTAMT, LINEDISCOUNT, 
 LINEOVERLIMITAMT, LINEOVERLIMIT, QTYINVOICED)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID,
	po.C_BPartner_ID, il.M_Product_Category_ID,
	firstOf(il.DateInvoiced, 'MM') AS DateInvoiced,	--	DD Day, DY Week, MM Month
	SUM(il.LineNetAmt) AS LineNetAmt,
	SUM(LineListAmt) AS LineListAmt,
	SUM(LineLimitAmt) AS LineLimitAmt,
	SUM(LineDiscountAmt) AS LineDiscountAmt,
	CASE WHEN SUM(LineListAmt)=0 THEN 0 ELSE
	  currencyRound((SUM(LineListAmt)-SUM(LineNetAmt))/SUM(LineListAmt)*100,i.C_Currency_ID,'N') END AS LineDiscount,
	SUM(LineOverLimitAmt) AS LineOverLimitAmt,
	CASE WHEN SUM(LineNetAmt)=0 THEN 0 ELSE
	  100-currencyRound((SUM(LineNetAmt)-SUM(LineOverLimitAmt))/SUM(LineNetAmt)*100,i.C_Currency_ID,'N') END AS LineOverLimit,
	SUM(QtyInvoiced) AS QtyInvoiced
FROM RV_C_InvoiceLine il
	INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID)
    INNER JOIN M_Product_PO po ON (il.M_Product_ID=po.M_Product_ID)
WHERE il.IsSOTrx='Y'
GROUP BY il.AD_Client_ID, il.AD_Org_ID, po.C_BPartner_ID, il.M_Product_Category_ID,
	firstOf(il.DateInvoiced, 'MM'), i.C_Currency_ID;

CREATE OR REPLACE VIEW RV_C_INVOICE_WEEK
(AD_CLIENT_ID, AD_ORG_ID, SALESREP_ID, DATEINVOICED, LINENETAMT, 
 LINELISTAMT, LINELIMITAMT, LINEDISCOUNTAMT, LINEDISCOUNT, LINEOVERLIMITAMT, 
 LINEOVERLIMIT, ISSOTRX)
AS 
SELECT il.AD_Client_ID, il.AD_Org_ID, il.SalesRep_ID,
	firstOf(il.DateInvoiced, 'DY') AS DateInvoiced,	--	DD Day, DY Week, MM Month
	SUM(LineNetAmt) AS LineNetAmt,
	SUM(LineListAmt) AS LineListAmt,
	SUM(LineLimitAmt) AS LineLimitAmt,
	SUM(LineDiscountAmt) AS LineDiscountAmt,
	CASE WHEN SUM(LineListAmt)=0 THEN 0 ELSE
	  currencyRound((SUM(LineListAmt)-SUM(LineNetAmt))/SUM(LineListAmt)*100,i.C_Currency_ID,'N') END AS LineDiscount,
	SUM(LineOverLimitAmt) AS LineOverLimitAmt,
	CASE WHEN SUM(LineNetAmt)=0 THEN 0 ELSE
	  100-currencyRound((SUM(LineNetAmt)-SUM(LineOverLimitAmt))/SUM(LineNetAmt)*100,i.C_Currency_ID,'N') END AS LineOverLimit,
    il.IsSOTrx
FROM RV_C_InvoiceLine il
	INNER JOIN C_Invoice i ON (i.C_Invoice_ID=il.C_Invoice_ID)
GROUP BY il.AD_Client_ID, il.AD_Org_ID, il.SalesRep_ID,
	firstOf(il.DateInvoiced, 'DY'), il.IsSOTrx, i.C_Currency_ID;

CREATE OR REPLACE VIEW rv_c_invoiceline AS 
SELECT il.ad_client_id,
    il.ad_org_id,
    il.isactive,
    il.created,
    il.createdby,
    il.updated,
    il.updatedby,
    il.c_invoiceline_id,
    i.c_invoice_id,
    i.salesrep_id,
    i.c_bpartner_id,
    i.c_bp_group_id,
    il.m_product_id,
    p.m_product_category_id,
    i.dateinvoiced,
    i.dateacct,
    i.issotrx,
    i.c_doctype_id,
    i.docstatus,
    i.ispaid,
    il.c_campaign_id,
    il.c_project_id,
    il.c_activity_id,
    il.c_projectphase_id,
    il.c_projecttask_id,
    il.qtyinvoiced * i.multiplier                                          AS qtyinvoiced,
    il.qtyentered * i.multiplier                                           AS qtyentered,
    il.m_attributesetinstance_id,
    productattribute(il.m_attributesetinstance_id)                         AS productattribute,
    pasi.m_attributeset_id,
    pasi.m_lot_id,
    pasi.guaranteedate,
    pasi.lot,
    pasi.serno,
    il.pricelist,
    il.priceactual,
    il.pricelimit,
    il.priceentered,
    CASE WHEN il.pricelist = 0 THEN 0 ELSE currencyRound((il.pricelist - il.priceactual) / il.pricelist * 100,i.C_Currency_ID,'N') END                                                                AS discount,
    CASE WHEN il.pricelimit = 0 THEN 0 ELSE currencyRound((il.priceactual - il.pricelimit) / il.pricelimit * 100,i.C_Currency_ID,'N') END                                                                AS margin,
    CASE WHEN il.pricelimit = 0 THEN 0 ELSE (il.priceactual - il.pricelimit) * il.qtyinvoiced END                                                                AS marginamt,
    currencyRound(i.multiplier * il.linenetamt,i.C_Currency_ID,'N')                                 AS linenetamt,
    currencyRound(i.multiplier * il.pricelist * il.qtyinvoiced,i.C_Currency_ID,'N')                 AS linelistamt,
    CASE WHEN COALESCE(il.pricelimit, 0) = 0 THEN currencyRound(i.multiplier * il.linenetamt,i.C_Currency_ID,'N') ELSE currencyRound(i.multiplier * il.pricelimit * il.qtyinvoiced,i.C_Currency_ID,'N') END                                                                
    AS linelimitamt,
    currencyRound(i.multiplier * il.pricelist * il.qtyinvoiced - il.linenetamt,i.C_Currency_ID,'N') AS linediscountamt,
    CASE WHEN COALESCE(il.pricelimit, 0) = 0 THEN 0 ELSE currencyRound(i.multiplier * il.linenetamt - il.pricelimit * il.qtyinvoiced,i.C_Currency_ID,'N') END                                                                AS 
    lineoverlimitamt,
    il.ad_orgtrx_id,
    il.a_processed,
    il.c_charge_id,
    il.c_orderline_id,
    il.c_tax_id,
    il.c_uom_id                                                            AS c_invoiceline_c_uom_id,
    il.description                                                         AS c_invoiceline_description,
    il.isdescription,
    il.isprinted,
    il.line,
    il.linenetamt                                                          AS c_invoiceline_linenetamt,
    il.linetotalamt,
    il.m_inoutline_id,
    il.m_rmaline_id,
    il.processed,
    il.ref_invoiceline_id,
    il.rramt,
    il.rrstartdate,
    il.s_resourceassignment_id,
    il.taxamt,
    il.user1_id,
    il.user2_id,
    p.ad_org_id                                                            AS m_product_ad_org_id,
    p.classification,
    p.copyfrom                                                             AS m_product_copyfrom,
    p.created                                                              AS m_product_created,
    p.createdby                                                            AS m_product_createdby,
    p.c_revenuerecognition_id,
    p.c_subscriptiontype_id,
    p.c_taxcategory_id,
    p.c_uom_id                                                             AS m_productline_c_uom_id,
    p.description                                                          AS m_product_description,
    p.descriptionurl,
    p.discontinued,
    p.discontinuedat,
    p.documentnote,
    p.group1,
    p.group2,
    p.guaranteedays,
    p.guaranteedaysmin,
    p.help,
    p.imageurl,
    p.isactive                                                             AS m_product_isactive,
    p.isdropship,
    p.isexcludeautodelivery,
    p.isinvoiceprintdetails,
    p.ispicklistprintdetails,
    p.ispurchased,
    p.isselfservice,
    p.issold,
    p.isstocked,
    p.issummary                                                            AS m_product_issummary,
    p.isverified,
    p.iswebstorefeatured,
    p.lowlevel,
    p.m_attributeset_id                                                    AS m_product_m_attributeset_id,
    p.m_freightcategory_id,
    p.m_locator_id,
    p.m_product_id                                                         AS m_product_m_product_id,
    p.processing                                                           AS m_product_processing,
    p.producttype,
    p.r_mailtext_id,
    p.salesrep_id                                                          AS m_product_salesrep_id,
    p.s_expensetype_id,
    p.shelfdepth,
    p.shelfheight,
    p.shelfwidth,
    p.sku,
    p.s_resource_id,
    p.unitsperpack,
    p.unitsperpallet,
    p.updated                                                              AS m_product_updated,
    p.updatedby                                                            AS m_product_updatedby,
    p.versionno,
    p.volume,
    p.weight,
    pasi.ad_org_id                                                         AS m_asi_ad_org_id,
    pasi.created                                                           AS m_attributesetinstance_created,
    pasi.createdby                                                         AS m_asi_createdby,
    pasi.description                                                       AS m_asi_description,
    pasi.isactive                                                          AS m_attributesetinstance_isacti,
    pasi.serno                                                             AS m_attributesetinstance_serno,
    pasi.updated                                                           AS m_attributesetinstance_updated,
    pasi.updatedby                                                         AS m_asi_updatedby 
FROM rv_c_invoice i 
        JOIN c_invoiceline il 
        ON i.c_invoice_id = il.c_invoice_id 
        LEFT JOIN m_product p 
        ON il.m_product_id = p.m_product_id 
        LEFT JOIN m_attributesetinstance pasi 
        ON il.m_attributesetinstance_id = pasi.m_attributesetinstance_id
;

CREATE OR REPLACE VIEW rv_openitem AS 
SELECT i.ad_org_id,
    i.ad_client_id,
    i.documentno,
    i.c_invoice_id,
    i.c_order_id,
    i.c_bpartner_id,
    i.issotrx,
    i.dateinvoiced,
    i.dateacct,
    p.netdays,
    paymenttermduedate(i.c_paymentterm_id, i.dateinvoiced)            AS duedate,
    paymenttermduedays(i.c_paymentterm_id, i.dateinvoiced, getdate()) AS daysdue,
    adddays(i.dateinvoiced, p.discountdays)                           AS discountdate,
    currencyRound(i.grandtotal * p.discount / 100,i.C_Currency_ID,'N')                         AS discountamt,
    i.grandtotal,
    invoicepaid(i.c_invoice_id, i.c_currency_id, 1)                   AS paidamt,
    invoiceopen(i.c_invoice_id, 0)                                    AS openamt,
    i.c_currency_id,
    i.c_conversiontype_id,
    i.c_paymentterm_id,
    i.ispayschedulevalid,
    NULL                                                              AS c_invoicepayschedule_id,
    i.invoicecollectiontype,
    i.c_campaign_id,
    i.c_project_id,
    i.c_activity_id,
    i.c_invoice_ad_orgtrx_id                                          AS ad_orgtrx_id,
    i.ad_user_id,
    i.c_bpartner_location_id,
    i.c_charge_id,
    i.c_doctype_id,
    i.c_doctypetarget_id,
    i.c_dunninglevel_id,
    i.chargeamt,
    i.c_payment_id,
    i.created,
    i.createdby,
    i.dateordered,
    i.dateprinted,
    i.description,
    i.docaction,
    i.docstatus,
    i.dunninggrace,
    i.generateto,
    i.isactive,
    i.isapproved,
    i.isdiscountprinted,
    i.isindispute,
    i.ispaid,
    i.isprinted,
    i.c_invoice_isselfservice                                         AS isselfservice,
    i.istaxincluded,
    i.istransferred,
    i.m_pricelist_id,
    i.m_rma_id,
    i.paymentrule,
    i.poreference,
    i.posted,
    i.processedon,
    i.processing,
    i.ref_invoice_id,
    i.reversal_id,
    i.salesrep_id,
    i.sendemail,
    i.totallines,
    i.updated,
    i.updatedby,
    i.user1_id,
    i.user2_id 
FROM rv_c_invoice i 
        JOIN c_paymentterm p 
        ON i.c_paymentterm_id = p.c_paymentterm_id 
WHERE invoiceopen(i.c_invoice_id, 0) <> 0 AND i.ispayschedulevalid <> 'Y' AND i.docstatus IN ('CO',
    'CL') 
UNION 
SELECT i.ad_org_id,
    i.ad_client_id,
    i.documentno,
    i.c_invoice_id,
    i.c_order_id,
    i.c_bpartner_id,
    i.issotrx,
    i.dateinvoiced,
    i.dateacct,
    daysbetween(ips.duedate, i.dateinvoiced)                 AS netdays,
    ips.duedate,
    daysbetween(getdate(), ips.duedate)                      AS daysdue,
    ips.discountdate,
    ips.discountamt,
    ips.dueamt                                               AS grandtotal,
    invoicepaid(i.c_invoice_id, i.c_currency_id, 1)          AS paidamt,
    invoiceopen(i.c_invoice_id, ips.c_invoicepayschedule_id) AS openamt,
    i.c_currency_id,
    i.c_conversiontype_id,
    i.c_paymentterm_id,
    i.ispayschedulevalid,
    ips.c_invoicepayschedule_id,
    i.invoicecollectiontype,
    i.c_campaign_id,
    i.c_project_id,
    i.c_activity_id,
    i.c_invoice_ad_orgtrx_id                                 AS ad_orgtrx_id,
    i.ad_user_id,
    i.c_bpartner_location_id,
    i.c_charge_id,
    i.c_doctype_id,
    i.c_doctypetarget_id,
    i.c_dunninglevel_id,
    i.chargeamt,
    i.c_payment_id,
    i.created,
    i.createdby,
    i.dateordered,
    i.dateprinted,
    i.description,
    i.docaction,
    i.docstatus,
    i.dunninggrace,
    i.generateto,
    i.isactive,
    i.isapproved,
    i.isdiscountprinted,
    i.isindispute,
    i.ispaid,
    i.isprinted,
    i.c_invoice_isselfservice                                AS isselfservice,
    i.istaxincluded,
    i.istransferred,
    i.m_pricelist_id,
    i.m_rma_id,
    i.paymentrule,
    i.poreference,
    i.posted,
    i.processedon,
    i.processing,
    i.ref_invoice_id,
    i.reversal_id,
    i.salesrep_id,
    i.sendemail,
    i.totallines,
    i.updated,
    i.updatedby,
    i.user1_id,
    i.user2_id 
FROM rv_c_invoice i 
        JOIN c_invoicepayschedule ips 
        ON i.c_invoice_id = ips.c_invoice_id 
WHERE invoiceopen(i.c_invoice_id, ips.c_invoicepayschedule_id) <> 0 AND i.ispayschedulevalid = 'Y' AND i.docstatus IN ('CO',
    'CL') AND ips.isvalid = 'Y'
;

CREATE OR REPLACE VIEW RV_OPENITEMTODATE
(AD_ORG_ID, AD_CLIENT_ID, DOCUMENTNO, C_INVOICE_ID, C_ORDER_ID, 
 C_BPARTNER_ID, ISSOTRX, DATEINVOICED, DATEACCT, NETDAYS, 
 DUEDATE, DAYSDUE, DISCOUNTDATE, DISCOUNTAMT, GRANDTOTAL, 
 --PAIDAMT, OPENAMT, 
 C_CURRENCY_ID, C_CONVERSIONTYPE_ID, C_PAYMENTTERM_ID, 
 ISPAYSCHEDULEVALID, C_INVOICEPAYSCHEDULE_ID, INVOICECOLLECTIONTYPE, C_CAMPAIGN_ID, C_PROJECT_ID, 
 C_ACTIVITY_ID)
AS 
SELECT i.AD_Org_ID, i.AD_Client_ID,
	i.DocumentNo, i.C_Invoice_ID, i.C_Order_ID, i.C_BPartner_ID, i.IsSOTrx,
	i.DateInvoiced, i.DateAcct,
    p.NetDays,
	paymentTermDueDate(i.C_PaymentTerm_ID, i.DateInvoiced) AS DueDate,
	paymentTermDueDays(i.C_PaymentTerm_ID, i.DateInvoiced, getdate()) AS DaysDue,
    addDays(i.DateInvoiced,p.DiscountDays) AS DiscountDate,
    currencyRound(i.GrandTotal*p.Discount/100,i.C_Currency_ID,'N') AS DiscountAmt,
	i.GrandTotal,
	--invoicePaid(i.C_Invoice_ID, i.C_Currency_ID, 1) AS PaidAmt,
	--invoiceOpen(i.C_Invoice_ID,0) AS OpenAmt,
    i.C_Currency_ID, i.C_ConversionType_ID,
    i.C_PaymentTerm_ID,
    i.IsPayScheduleValid, cast(null as numeric) AS C_InvoicePaySchedule_ID, i.InvoiceCollectionType,
    i.C_Campaign_ID, i.C_Project_ID, i.C_Activity_ID
FROM RV_C_Invoice i
    INNER JOIN C_PaymentTerm p ON (i.C_PaymentTerm_ID=p.C_PaymentTerm_ID)
WHERE --    i.IsPaid='N'
    --invoiceOpen(i.C_Invoice_ID,0) <> 0 AND 
    i.IsPayScheduleValid<>'Y'
    AND i.DocStatus IN ('CO','CL')
UNION
SELECT i.AD_Org_ID, i.AD_Client_ID,
    i.DocumentNo, i.C_Invoice_ID, i.C_Order_ID, i.C_BPartner_ID, i.IsSOTrx,
	i.DateInvoiced, i.DateAcct,
    daysBetween(ips.DueDate,i.DateInvoiced) AS NetDays,
    ips.DueDate,
    daysBetween(getdate(),ips.DueDate) AS DaysDue,
    ips.DiscountDate,
    ips.DiscountAmt,
	ips.DueAmt AS GrandTotal,
	--invoicePaid(i.C_Invoice_ID, i.C_Currency_ID, 1) AS PaidAmt,
	--invoiceOpen(i.C_Invoice_ID, ips.C_InvoicePaySchedule_ID) AS OpenAmt,
    i.C_Currency_ID, i.C_ConversionType_ID,
    i.C_PaymentTerm_ID,
    i.IsPayScheduleValid, ips.C_InvoicePaySchedule_ID, i.InvoiceCollectionType,
    i.C_Campaign_ID, i.C_Project_ID, i.C_Activity_ID
FROM RV_C_Invoice i
    INNER JOIN C_InvoicePaySchedule ips ON (i.C_Invoice_ID=ips.C_Invoice_ID)
WHERE  --   i.IsPaid='N'
    --invoiceOpen(i.C_Invoice_ID,ips.C_InvoicePaySchedule_ID) <> 0 AND 
    i.IsPayScheduleValid='Y'
    AND i.DocStatus IN ('CO','CL')
    AND ips.IsValid='Y';

CREATE OR REPLACE VIEW rv_orderdetail AS 
SELECT l.ad_client_id,
    l.ad_org_id,
    l.isactive,
    l.created,
    l.createdby,
    l.updated,
    l.updatedby,
    o.c_order_id,
    o.docstatus,
    o.docaction,
    o.c_doctype_id,
    o.isapproved,
    o.iscreditapproved,
    o.salesrep_id,
    o.bill_bpartner_id,
    o.bill_location_id,
    o.bill_user_id,
    o.isdropship,
    l.c_bpartner_id,
    l.c_bpartner_location_id,
    o.ad_user_id,
    o.poreference,
    o.c_currency_id,
    o.issotrx,
    l.c_campaign_id,
    l.c_project_id,
    l.c_activity_id,
    l.c_projectphase_id,
    l.c_projecttask_id,
    l.c_orderline_id,
    l.dateordered,
    l.datepromised,
    l.m_product_id,
    l.m_warehouse_id,
    l.m_attributesetinstance_id,
    productattribute(l.m_attributesetinstance_id)  AS productattribute,
    pasi.m_attributeset_id,
    pasi.m_lot_id,
    pasi.guaranteedate,
    pasi.lot,
    pasi.serno,
    l.c_uom_id,
    l.qtyentered,
    l.qtyordered,
    l.qtyreserved,
    l.qtydelivered,
    l.qtyinvoiced,
    l.priceactual,
    l.priceentered,
    l.qtyordered - l.qtydelivered                  AS qtytodeliver,
    l.qtyordered - l.qtyinvoiced                   AS qtytoinvoice,
    (l.qtyordered - l.qtyinvoiced) * l.priceactual AS netamttoinvoice,
    l.qtylostsales,
    l.qtylostsales * l.priceactual                 AS amtlostsales,
    CASE WHEN l.pricelist = 0 THEN 0 ELSE currencyRound((l.pricelist - l.priceactual) / l.pricelist * 100,o.C_Currency_ID,'N') END                                        AS discount,
    CASE WHEN l.pricelimit = 0 THEN 0 ELSE currencyRound((l.priceactual - l.pricelimit) / l.pricelimit * 100,o.C_Currency_ID,'N') END                                        AS margin,
    CASE WHEN l.pricelimit = 0 THEN 0 ELSE (l.priceactual - l.pricelimit) * l.qtydelivered END                                        AS marginamt,
    o.ad_org_id                                    AS c_order_ad_org_id,
    o.ad_orgtrx_id                                 AS c_order_ad_orgtrx_id,
    o.amountrefunded,
    o.amounttendered,
    o.c_activity_id                                AS c_order_c_activity_id,
    o.c_bpartner_id                                AS c_order_c_bpartner_id,
    o.c_bpartner_location_id                       AS c_order_c_bpartner_loc_id,
    o.c_campaign_id                                AS c_order_c_compaign_id,
    o.c_cashline_id,
    o.c_cashplanline_id,
    o.c_charge_id                                  AS c_order_c_charge_id,
    o.c_conversiontype_id,
    o.c_doctypetarget_id,
    o.chargeamt,
    o.copyfrom,
    o.c_payment_id,
    o.c_paymentterm_id,
    o.c_pos_id,
    o.c_project_id                                 AS c_order_c_project_id,
    o.created                                      AS c_order_created,
    o.createdby                                    AS c_order_createdby,
    o.dateacct,
    o.dateordered                                  AS c_order_dateordered,
    o.dateprinted,
    o.datepromised                                 AS c_order_datepromised,
    o.deliveryrule,
    o.deliveryviarule,
    o.description                                  AS c_order_description,
    o.documentno,
    o.dropship_bpartner_id,
    o.dropship_location_id,
    o.dropship_user_id,
    o.freightamt                                   AS c_order_freightamt,
    o.freightcostrule,
    o.grandtotal,
    o.invoicerule,
    o.isactive                                     AS c_order_isactive,
    o.isdelivered,
    o.isdiscountprinted,
    o.isinvoiced,
    o.ispayschedulevalid,
    o.isprinted,
    o.isselected,
    o.isselfservice,
    o.istaxincluded,
    o.istransferred,
    o.link_order_id,
    o.m_freightcategory_id,
    o.m_pricelist_id,
    o.m_shipper_id                                 AS c_order_m_shipper_id,
    o.m_warehouse_id                               AS c_order_m_warehouse_id,
    o.ordertype,
    o.pay_bpartner_id,
    o.pay_location_id,
    o.paymentrule,
    o.posted,
    o.priorityrule,
    o.processed                                    AS c_order_processed,
    o.processedon,
    o.promotioncode,
    o.ref_order_id,
    o.sendemail,
    o.totallines,
    o.updated                                      AS c_order_updated,
    o.updatedby                                    AS c_order_updatedby,
    o.user1_id                                     AS c_order_user1_id,
    o.user2_id                                     AS c_order_user2_id,
    o.volume,
    o.weight,
    l.ad_orgtrx_id                                 AS c_orderline_ad_orgtrx_id,
    l.c_charge_id                                  AS c_orderline_c_charge_id,
    l.c_currency_id                                AS c_orderline_c_currency_id,
    l.c_tax_id,
    l.datedelivered,
    l.dateinvoiced,
    l.description                                  AS c_orderline_description,
    l.discount                                     AS c_orderline_discount,
    l.freightamt                                   AS c_orderline_freightamt,
    l.isdescription,
    l.line,
    l.linenetamt,
    l.link_orderline_id,
    l.m_promotion_id,
    l.m_shipper_id                                 AS c_orderline_m_shipper_id,
    l.pricecost,
    l.pricelimit,
    l.pricelist,
    l.processed                                    AS c_orderline_processed,
    l.ref_orderline_id,
    l.rramt,
    l.rrstartdate,
    l.s_resourceassignment_id,
    l.user1_id                                     AS c_orderline_user1_id,
    l.user2_id                                     AS c_orderline_user2_id,
    pasi.ad_org_id                                 AS m_asi_ad_org_id,
    pasi.created                                   AS m_asi_created,
    pasi.createdby                                 AS m_asi_createdby,
    pasi.description                               AS m_asi_description,
    pasi.isactive                                  AS m_asi_isactive,
    pasi.updated                                   AS m_asi_updated,
    pasi.updatedby                                 AS m_asi_updatedby 
FROM c_order o 
        JOIN c_orderline l 
        ON o.c_order_id = l.c_order_id 
        LEFT JOIN m_attributesetinstance pasi 
        ON l.m_attributesetinstance_id = pasi.m_attributesetinstance_id
;

SELECT register_migration_script('201403261215_IDEMPIERE-1856.sql') FROM dual
;