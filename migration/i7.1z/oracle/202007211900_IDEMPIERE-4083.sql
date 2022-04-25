SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 6, 2018 12:04:56 PM MYT
-- AP2-473 Improve handling of Spot Rate
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,CreatedBy,UpdatedBy,AD_Client_ID,EntityType,AD_Org_ID) VALUES (203258,'IsOverrideCurrencyRate',TO_DATE('2018-08-06 12:04:54','YYYY-MM-DD HH24:MI:SS'),'Override Currency Conversion Rate','Override Currency Conversion Rate','Override Currency Conversion Rate','fa5158e6-cd76-4b51-a423-0e61f1174402','Y',TO_DATE('2018-08-06 12:04:54','YYYY-MM-DD HH24:MI:SS'),100,100,0,'D',0)
;

-- Aug 6, 2018 12:06:46 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,IsSecure,EntityType,IsEncrypted,FKConstraintType,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID,IsHtml) VALUES (213664,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','694d7baf-3218-4940-a32e-439a8a8c0fdf',TO_DATE('2018-08-06 12:06:45','YYYY-MM-DD HH24:MI:SS'),'Y','IsOverrideCurrencyRate','Override Currency Conversion Rate','N','Override Currency Conversion Rate','Y','Y',100,100,'N',0,TO_DATE('2018-08-06 12:06:45','YYYY-MM-DD HH24:MI:SS'),'N','D','N','N',203258,335,20,'N',0,'N')
;

-- Aug 6, 2018 12:07:00 PM MYT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2018-08-06 12:07:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213664
;

-- Aug 6, 2018 12:07:06 PM MYT
ALTER TABLE C_Payment ADD IsOverrideCurrencyRate CHAR(1) DEFAULT 'N' CHECK (IsOverrideCurrencyRate IN ('Y','N')) NOT NULL
;

-- Aug 6, 2018 12:11:52 PM MYT
UPDATE AD_Field SET SeqNo=233, DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@ & @IsOverrideCurrencyRateO@=Y', AD_Val_Rule_ID=NULL, SeqNoGrid=223, XPosition=4, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-08-06 12:11:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205670
;

-- Aug 6, 2018 12:12:40 PM MYT
UPDATE AD_Field SET SeqNo=232, DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@ & @IsOverrideCurrencyRate@=Y', AD_Val_Rule_ID=NULL, SeqNoGrid=222, XPosition=1, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-08-06 12:12:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205669
;

-- Aug 6, 2018 12:13:30 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,DisplayLogic,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,205706,'N',0,'N','N',231,'Y','N','@C_Currency_ID@!@$C_Currency_ID@',TO_DATE('2018-08-06 12:13:30','YYYY-MM-DD HH24:MI:SS'),'Override Currency Conversion Rate','Override Currency Conversion Rate','29fffeb3-e9dc-4a9d-813f-e54782b9dc19','Y','N',100,100,'Y','Y',221,1,'N',0,TO_DATE('2018-08-06 12:13:30','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213664,'D',330,0)
;

-- Aug 6, 2018 12:14:06 PM MYT
UPDATE AD_Field SET DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@ & @IsOverrideCurrencyRate@=N', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-08-06 12:14:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8651
;

-- Aug 6, 2018 12:14:39 PM MYT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, XPosition=2, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-08-06 12:14:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205706
;

-- Aug 6, 2018 3:36:31 PM MYT
-- AP2-473 Improve handling of Spot Rate
UPDATE AD_Field SET DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-08-06 15:36:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8651
;

-- Aug 6, 2018 4:34:56 PM MYT
-- AP2-473 Improve handling of Spot Rate
UPDATE AD_Column SET Callout=NULL,Updated=TO_DATE('2018-08-06 16:34:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12128
;

-- Aug 6, 2018 4:35:17 PM MYT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutPayment.amounts',Updated=TO_DATE('2018-08-06 16:35:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213664
;

-- Aug 6, 2018 6:16:52 PM MYT
-- AP2-473 Improve handling of Spot Rate
UPDATE AD_Field SET DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@ & @IsOverrideCurrencyRate@=Y', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-08-06 18:16:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205670
;

CREATE OR REPLACE FUNCTION currencyConvertPayment
(
	p_C_Payment_ID		IN NUMBER,
	p_CurTo_ID		IN NUMBER,
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
	FROM C_Payment
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

SELECT register_migration_script('202007211900_IDEMPIERE-4083.sql') FROM dual
;

