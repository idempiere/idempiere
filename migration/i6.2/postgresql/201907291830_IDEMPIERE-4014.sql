-- IDEMPIERE-4014 - Aging - some lines are hidden if using C_Currency_ID as parameter
-- 07/29/2019 06:17:48
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203350,0,0,'Y',TO_TIMESTAMP('2019-07-29 18:17:35','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2019-07-29 18:17:35','YYYY-MM-DD HH24:MI:SS'),0,'ConvertAmountsInCurrency_ID','Convert Amounts in Currency',NULL,NULL,'Convert Amounts in Currency','D','3ff194dd-160e-4362-b4e5-d0e41221c1c5')
;

-- 07/29/2019 06:18:26
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200280,0,0,'Y',TO_TIMESTAMP('2019-07-29 18:18:26','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2019-07-29 18:18:26','YYYY-MM-DD HH24:MI:SS'),0,'Convert Amounts in Currency',238,45,18,112,'N',0,'N','ConvertAmountsInCurrency_ID','Y','D',203350,'a4cc6ea2-103f-4389-bf39-cda71c73028c','N')
;

-- 07/29/2019 06:18:51
UPDATE AD_Process SET Help='The aging report allows you to report on Open Items (Invoices). Select the aging buckets, you want to have in your report. If you select a currency, you get only invoices of that currency.
If you fill the "Convert Amounts in Currency", all amounts will be converted in that currency. If you do not select a Statement Date, the system date is used to calculate the buckets. If you do not list the individual invoices, the Due Date is the earliest due date for the business partner and the Due Days are the average due days of all invoices.<br>
<br>
If you select an Account Date the report will generate the Aging as of that date. The report will exclude documents after the selected date.<br>
<br>
For example: A customer has one invoice for $100 with the Account Date of 03/31/08 and one payment for $100 with the Account Date of 05/01/08. The report will show the following balances based on the Account Date selected: 03/15/08= 0; 04/15/08=100; 05/15/08 = 0.
',Updated=TO_TIMESTAMP('2019-07-29 18:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_ID=238
;

INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213969,0,'Convert Amounts in Currency',631,'ConvertAmountsInCurrency_ID',10,'N','N','N','N','N',0,'N',30,112,0,0,'Y',TO_TIMESTAMP('2019-07-29 18:34:22','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2019-07-29 18:34:22','YYYY-MM-DD HH24:MI:SS'),0,203350,'Y','N','D','N','N','N','Y','c34b0911-52ef-4a30-a04c-b2739de87f5d','N',0,'N','N','N','N')
;

-- 07/29/2019 06:34:24
UPDATE AD_Column SET FKConstraintName='ConvertAmountsInCurrency_TAgin', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-07-29 18:34:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=213969
;

-- 07/29/2019 06:34:24
ALTER TABLE T_Aging ADD COLUMN ConvertAmountsInCurrency_ID NUMERIC(10) DEFAULT NULL 
;

-- 07/29/2019 06:34:24
ALTER TABLE T_Aging ADD CONSTRAINT ConvertAmountsInCurrency_TAgin FOREIGN KEY (ConvertAmountsInCurrency_ID) REFERENCES c_currency(c_currency_id) DEFERRABLE INITIALLY DEFERRED
;

-- 07/29/2019 06:34:28
UPDATE AD_Column SET FKConstraintType='D',Updated=TO_TIMESTAMP('2019-07-29 18:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=213969
;

-- 07/29/2019 06:34:29
INSERT INTO t_alter_column values('t_aging','ConvertAmountsInCurrency_ID','NUMERIC(10)',null,'NULL')
;

-- 07/29/2019 06:34:29
ALTER TABLE T_Aging DROP CONSTRAINT convertamountsincurrency_tagin
;

SELECT register_migration_script('201907291830_IDEMPIERE-4014.sql') FROM dual
;