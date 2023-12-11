-- Added Line Amount field in Expense Report Line and removed Price field from Expense Report Line
SELECT register_migration_script('202312041613_IDEMPIERE-5602.sql') FROM dual;

--Update Expense Amt
UPDATE S_TimeExpenseLine SET ExpenseAmt = PriceEntered WHERE PriceEntered > 0 AND IsTimeReport = 'N';

--Update Converted Amt
UPDATE S_TimeExpenseLine SET ConvertedAmt = currencyconvert(ExpenseAmt,C_Currency_ID,(SELECT pl.C_Currency_ID FROM S_TimeExpense te INNER JOIN M_PriceList pl ON pl.M_PriceList_ID=te.M_PriceList_ID WHERE te.S_TimeExpense_ID=S_TimeExpenseLine.S_TimeExpense_ID),DateExpense,0,AD_Client_ID,AD_Org_ID) WHERE ExpenseAmt > 0 AND IsTimeReport = 'N';

-- Dec 4, 2023, 4:16:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216303,0,'Line Amount','Line Extended Amount (Quantity * Actual Price) without Freight and Charges','Indicates the extended line amount based on the quantity and the actual price.  Any additional charges or freight are not included.  The Amount may or may not include tax.  If the price list is inclusive tax, the line amount is the same as the line total.',488,'LineNetAmt',22,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2023-12-04 16:16:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:16:28','YYYY-MM-DD HH24:MI:SS'),100,441,'Y','N','D','N','N','N','Y','e3f82050-95c4-4c53-8e3b-8e9344000ea2','Y',0,'N','N','N')
;

-- Dec 4, 2023, 4:16:47 PM IST
ALTER TABLE S_TimeExpenseLine ADD COLUMN LineNetAmt NUMERIC DEFAULT NULL 
;

-- Dec 4, 2023, 4:20:04 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,DisplayLogic,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208092,'Line Amount','Line Extended Amount (Quantity * Actual Price) without Freight and Charges','Indicates the extended line amount based on the quantity and the actual price.  Any additional charges or freight are not included.  The Amount may or may not include tax.  If the price list is inclusive tax, the line amount is the same as the line total.',413,216303,'Y',22,155,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-04 16:20:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-04 16:20:04','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','@IsTimeReport@=N | @IsInvoiced@=Y','D','fd80a0f0-b3ab-49c4-8020-867a858d6b0f','Y',155,2)
;

-- Dec 4, 2023, 4:25:01 PM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutTimeExpense.amount',Updated=TO_TIMESTAMP('2023-12-04 16:25:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6875
;

-- Dec 4, 2023, 4:30:07 PM IST
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2023-12-04 16:30:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5463
;

-- Dec 4, 2023, 4:30:07 PM IST
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2023-12-04 16:30:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5462
;

-- 04-Dec-2023, 4:49:15 PM IST
DELETE FROM AD_Field WHERE AD_Field_ID=207572
;

-- 04-Dec-2023, 4:49:32 PM IST
DELETE FROM AD_Column WHERE AD_Column_ID=215777
;

-- 04-Dec-2023, 4:49:32 PM IST
ALTER TABLE S_TimeExpenseLine DROP COLUMN PriceEntered
;

--Set Line Amount
UPDATE S_TimeExpenseLine SET LineNetAmt = ExpenseAmt * Qty WHERE ExpenseAmt > 0 AND IsTimeReport = 'N';

