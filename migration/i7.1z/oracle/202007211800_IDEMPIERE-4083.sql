SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 25, 2018 6:27:49 PM MYT
-- AP2-473 Improve handling of Spot Rate
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID,IsHtml) VALUES (213623,0,'N',0,'N','N','N',0,'N',22,'N','N','N','Y','2c7aa027-bb65-45f3-b584-7471b4db2589',TO_DATE('2018-07-25 18:27:43','YYYY-MM-DD HH24:MI:SS'),'Y','CurrencyRate','Currency Conversion Rate',NULL,'The Currency Conversion Rate indicates the rate to use when converting the source currency to the accounting currency','Rate','Y','Y',100,100,'N',0,TO_DATE('2018-07-25 18:27:43','YYYY-MM-DD HH24:MI:SS'),'N','D','N',253,335,22,'N',0,'N')
;

-- Jul 25, 2018 6:27:58 PM MYT
ALTER TABLE C_Payment ADD CurrencyRate NUMBER DEFAULT NULL 
;

-- Jul 25, 2018 6:28:37 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID,IsHtml) VALUES (213624,0,'N',0,'N','N','N',0,'N',22,'N','N','N','Y','d1ef932b-5a7d-4d3a-b6c9-d92b02c440f9',TO_DATE('2018-07-25 18:28:37','YYYY-MM-DD HH24:MI:SS'),'Y','ConvertedAmt','Converted Amount','The Converted Amount is the result of multiplying the Source Amount by the Conversion Rate for this target currency.','Converted Amount','Y','Y',100,100,'N',0,TO_DATE('2018-07-25 18:28:37','YYYY-MM-DD HH24:MI:SS'),'N','D','N',1555,335,12,'N',0,'N')
;

-- Jul 25, 2018 6:28:44 PM MYT
ALTER TABLE C_Payment ADD ConvertedAmt NUMBER DEFAULT NULL 
;

-- Jul 25, 2018 6:35:47 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,DisplayLogic,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,205669,'N',0,'N','N',231,'Y','N','The Currency Conversion Rate indicates the rate to use when converting the source currency to the accounting currency','@C_Currency_ID@!@$C_Currency_ID@ & @C_ConversionType_ID@=114',TO_DATE('2018-07-25 18:35:41','YYYY-MM-DD HH24:MI:SS'),'Currency Conversion Rate','Rate','085538d5-fa30-454f-9efa-46d7f03ec2bf','Y','N',100,100,'Y','Y',221,4,'N',0,TO_DATE('2018-07-25 18:35:41','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213623,'D',330,0)
;

-- Jul 25, 2018 6:36:28 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,DisplayLogic,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,205670,'N',0,'N','N',232,'Y','N','The Converted Amount is the result of multiplying the Source Amount by the Conversion Rate for this target currency.','@C_Currency_ID@!@$C_Currency_ID@ & @C_ConversionType_ID@=114',TO_DATE('2018-07-25 18:36:22','YYYY-MM-DD HH24:MI:SS'),'Converted Amount','Converted Amount','a7312ba2-8cd8-4c8c-ac60-24559140372a','Y','N',100,100,'Y','Y',222,1,'N',0,TO_DATE('2018-07-25 18:36:22','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213624,'D',330,0)
;

-- Jul 26, 2018 5:47:16 PM MYT
-- AP2-473 Improve handling of Spot Rate
UPDATE AD_Column SET Callout='org.compiere.model.CalloutPayment.amounts',Updated=TO_DATE('2018-07-26 17:47:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213623
;

-- Jul 26, 2018 5:47:50 PM MYT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutPayment.amounts',Updated=TO_DATE('2018-07-26 17:47:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213624
;

-- Jul 26, 2018 8:42:12 PM MYT
-- AP2-473 Improve handling of Spot Rate
UPDATE AD_Column SET Callout='org.compiere.model.CalloutPayment.amounts',Updated=TO_DATE('2018-07-26 20:42:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12128
;

SELECT register_migration_script('202007211800_IDEMPIERE-4083.sql') FROM dual
;

