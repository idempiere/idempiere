SET SQLBLANKLINES ON
SET DEFINE OFF

-- Added Price field in Expense Report Line
-- 07-Mar-2023, 12:49:49 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Callout,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215777,0,'Price','Price Entered - the price based on the selected price list on header','Price Entered - the price based on the selected price list on header',488,'PriceEntered','0',22,'N','N','N','N','N',0,'N',37,0,0,'Y',TO_DATE('2023-03-07 12:49:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-03-07 12:49:48','YYYY-MM-DD HH24:MI:SS'),100,'org.compiere.model.CalloutTimeExpense.priceOrQty',2588,'Y','N','D','N','N','N','Y','0d4f6687-ec2e-46a7-977a-fbb44ac8f4d3','N',0,'N','N','N')
;

-- 07-Mar-2023, 12:50:01 PM IST
ALTER TABLE S_TimeExpenseLine ADD PriceEntered NUMBER DEFAULT 0
;

-- 07-Mar-2023, 12:50:35 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207572,'Price','Price Entered - the price based on the selected price list on header','Price Entered - the price based on the selected price list on header',413,215777,'Y',22,95,'N','N','N','N',0,0,'Y',TO_DATE('2023-03-07 12:50:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-03-07 12:50:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e39cabde-90c0-4bac-a32a-0ac84f2cb15a','Y',95,2)
;

-- 07-Mar-2023, 9:23:37 PM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutTimeExpense.priceOrQty',Updated=TO_DATE('2023-03-07 21:23:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6875
;

-- 07-Mar-2023, 10:13:18 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2023-03-07 22:13:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5463
;

-- 07-Mar-2023, 9:34:04 PM IST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2023-03-07 21:34:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5462
;

SELECT register_migration_script('202303071543_IDEMPIERE-5602.sql') FROM dual;