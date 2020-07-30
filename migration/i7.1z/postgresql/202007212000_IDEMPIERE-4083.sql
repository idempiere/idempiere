-- Aug 7, 2018 12:11:37 PM MYT
-- AP2-473 Improve handling of Spot Rate
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,IsSecure,EntityType,IsEncrypted,FKConstraintType,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID,IsHtml) VALUES (213667,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','49dfde99-b3e4-48df-b2dc-d178a7ba8391',TO_TIMESTAMP('2018-08-07 12:11:31','YYYY-MM-DD HH24:MI:SS'),'Y','IsOverrideCurrencyRate','Override Currency Conversion Rate','N','Override Currency Conversion Rate','Y','Y',100,100,'N',0,TO_TIMESTAMP('2018-08-07 12:11:31','YYYY-MM-DD HH24:MI:SS'),'N','D','N','N',203258,318,20,'N',0,'N')
;

-- Aug 7, 2018 12:11:44 PM MYT
ALTER TABLE C_Invoice ADD COLUMN IsOverrideCurrencyRate CHAR(1) DEFAULT 'N' CHECK (IsOverrideCurrencyRate IN ('Y','N')) NOT NULL
;

-- Aug 7, 2018 12:12:34 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID,IsHtml) VALUES (213668,0,'N',0,'N','N','N',0,'N',22,'N','N','N','Y','a73b45e7-f38f-4447-8657-1eb475e6e153',TO_TIMESTAMP('2018-08-07 12:12:28','YYYY-MM-DD HH24:MI:SS'),'Y','CurrencyRate','Currency Conversion Rate','The Currency Conversion Rate indicates the rate to use when converting the source currency to the accounting currency','Rate','Y','Y',100,100,'N',0,TO_TIMESTAMP('2018-08-07 12:12:28','YYYY-MM-DD HH24:MI:SS'),'N','D','N',253,318,22,'N',0,'N')
;

-- Aug 7, 2018 12:12:40 PM MYT
ALTER TABLE C_Invoice ADD COLUMN CurrencyRate NUMERIC DEFAULT NULL 
;

-- Aug 7, 2018 12:50:01 PM MYT
-- AP2-473 Improve handling of Spot Rate
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,DisplayLogic,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,205806,'N',0,'N','N',171,'Y','N','@C_Currency_ID@!@$C_Currency_ID@',TO_TIMESTAMP('2018-08-07 12:49:55','YYYY-MM-DD HH24:MI:SS'),'Override Currency Conversion Rate','Override Currency Conversion Rate','a28728cb-1b43-493f-bf29-481604eb1dcb','Y','N',100,100,'Y','Y',171,2,'N',0,TO_TIMESTAMP('2018-08-07 12:49:55','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213667,'D',263,0)
;

-- Aug 7, 2018 12:51:28 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,DisplayLogic,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,205807,'N',0,'N','N',172,'Y','N','The Currency Conversion Rate indicates the rate to use when converting the source currency to the accounting currency','@C_Currency_ID@!@$C_Currency_ID@ & @IsOverrideCurrencyRate@=Y',TO_TIMESTAMP('2018-08-07 12:51:22','YYYY-MM-DD HH24:MI:SS'),'Currency Conversion Rate','Rate','c8f3055c-77ff-4fa8-bf79-fa1e60f8693f','Y','N',100,100,'Y','Y',172,4,'N',0,TO_TIMESTAMP('2018-08-07 12:51:22','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213668,'D',263,0)
;

-- Aug 7, 2018 12:53:55 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,DisplayLogic,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,205808,'N',0,'N','N',171,'Y','N','@C_Currency_ID@!@$C_Currency_ID@',TO_TIMESTAMP('2018-08-07 12:53:50','YYYY-MM-DD HH24:MI:SS'),'Override Currency Conversion Rate','Override Currency Conversion Rate','8adaa192-2b66-477c-a442-4902fcc8a377','Y','N',100,100,'Y','Y',171,2,'N',0,TO_TIMESTAMP('2018-08-07 12:53:50','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213667,'D',290,0)
;

-- Aug 7, 2018 12:55:15 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,DisplayLogic,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,205809,'N',0,'N','N',172,'Y','N','The Currency Conversion Rate indicates the rate to use when converting the source currency to the accounting currency','@C_Currency_ID@!@$C_Currency_ID@ & @IsOverrideCurrencyRate@=Y',TO_TIMESTAMP('2018-08-07 12:55:09','YYYY-MM-DD HH24:MI:SS'),'Currency Conversion Rate','Rate','654aef87-77d6-4640-9366-4e2d16de610c','Y','N',100,100,'Y','Y',1,4,'N',0,TO_TIMESTAMP('2018-08-07 12:55:09','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213668,'D',290,0)
;

-- Aug 7, 2018 5:24:49 PM MYT
-- AP2-473 Improve handling of Spot Rate
UPDATE AD_StatusLine SET SQLStatement='SELECT COUNT(DISTINCT C_InvoiceLine_ID) AS Lines,o.TotalLines,o.GrandTotal,c.ISO_Code, currencyConvertInvoice(o.C_Invoice_ID,@$C_Currency_ID@,o.GrandTotal,o.DateAcct) AS ConvAmt, o.GrandTotal-o.TotalLines AS TaxAmt
FROM C_Invoice o
INNER JOIN C_Currency c ON (o.C_Currency_ID=c.C_Currency_ID)
LEFT JOIN C_InvoiceLine l ON (o.C_Invoice_ID=l.C_Invoice_ID)
WHERE o.C_Invoice_ID=@C_Invoice_ID@
GROUP BY o.C_Currency_ID, c.ISO_Code, o.TotalLines, o.GrandTotal, o.DateAcct, o.AD_Client_ID, o.AD_Org_ID',Updated=TO_TIMESTAMP('2018-08-07 17:24:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_StatusLine_ID=200002
;

-- Aug 7, 2018 5:26:55 PM MYT
UPDATE AD_StatusLine SET SQLStatement='SELECT COUNT(DISTINCT C_InvoiceLine_ID) AS Lines,o.TotalLines,o.GrandTotal,c.ISO_Code, currencyConvertInvoice(o.C_Invoice_ID,@$C_Currency_ID@,o.GrandTotal,o.DateAcct) AS ConvAmt, o.GrandTotal-o.TotalLines AS TaxAmt
FROM C_Invoice o
INNER JOIN C_Currency c ON (o.C_Currency_ID=c.C_Currency_ID)
LEFT JOIN C_InvoiceLine l ON (o.C_Invoice_ID=l.C_Invoice_ID)
WHERE o.C_Invoice_ID=@C_Invoice_ID@
GROUP BY o.C_Invoice_ID, c.ISO_Code, o.TotalLines, o.GrandTotal, o.DateAcct, o.AD_Client_ID, o.AD_Org_ID',Updated=TO_TIMESTAMP('2018-08-07 17:26:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_StatusLine_ID=200002
;

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

SELECT register_migration_script('202007212000_IDEMPIERE-4083.sql') FROM dual
;

