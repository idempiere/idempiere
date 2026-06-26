SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-6590 Adding Charge on Payment->Allocate tab to support allocating to multiple charge
SELECT register_migration_script('202409021942_IDEMPIERE-6590.sql') FROM dual
;

-- Sep 2, 2024, 6:47:26 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216628,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',812,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2024-09-02 18:47:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-09-02 18:47:25','YYYY-MM-DD HH24:MI:SS'),100,968,'N','N','@C_Invoice_ID@!0','D','N','N','@C_Invoice_ID@=0','N','Y','91cdea30-61e6-47d3-aff8-17b1abc1a436','Y',0,'N','N','N')
;

-- Sep 2, 2024, 6:47:40 PM IST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2024-09-02 18:47:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216628
;

-- Sep 2, 2024, 6:47:43 PM IST
UPDATE AD_Column SET FKConstraintName='CCharge_CPaymentAllocate', FKConstraintType='N',Updated=TO_DATE('2024-09-02 18:47:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216628
;

-- Sep 2, 2024, 6:47:43 PM IST
ALTER TABLE C_PaymentAllocate ADD C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 2, 2024, 6:47:43 PM IST
ALTER TABLE C_PaymentAllocate ADD CONSTRAINT CCharge_CPaymentAllocate FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 2, 2024, 6:51:13 PM IST
UPDATE AD_Column SET ReadOnlyLogic='@C_Charge_ID@!0', MandatoryLogic='@C_Charge_ID@=0',Updated=TO_DATE('2024-09-02 18:51:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14328
;

-- Sep 2, 2024, 6:51:47 PM IST
UPDATE AD_Column SET ReadOnlyLogic='@C_Charge_ID@!0',Updated=TO_DATE('2024-09-02 18:51:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14330
;

-- Sep 2, 2024, 6:51:53 PM IST
UPDATE AD_Column SET ReadOnlyLogic='@C_Charge_ID@!0',Updated=TO_DATE('2024-09-02 18:51:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14334
;

-- Sep 2, 2024, 6:52:04 PM IST
UPDATE AD_Column SET ReadOnlyLogic='@C_Charge_ID@!0',Updated=TO_DATE('2024-09-02 18:52:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14332
;

-- Sep 2, 2024, 6:52:19 PM IST
UPDATE AD_Column SET ReadOnlyLogic='@C_Charge_ID@!0',Updated=TO_DATE('2024-09-02 18:52:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14331
;

-- Sep 2, 2024, 6:53:43 PM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutPaymentAllocate.charge',Updated=TO_DATE('2024-09-02 18:53:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216628
;

-- Sep 2, 2024, 6:54:54 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208504,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',755,216628,'Y',10,130,'N','N','N','N',0,0,'Y',TO_DATE('2024-09-02 18:54:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-09-02 18:54:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ddc0b905-d1ea-4b42-b55e-de66091e94a5','Y',130,2)
;

-- Sep 2, 2024, 6:56:34 PM IST
UPDATE AD_Field SET SeqNo=65, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=65, IsToolbarButton=NULL,Updated=TO_DATE('2024-09-02 18:56:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208504
;

-- 02-Sep-2024, 7:28:34 PM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2024-09-02 19:28:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14328
;

-- 02-Sep-2024, 7:35:30 PM IST
ALTER TABLE C_PaymentAllocate MODIFY C_Invoice_ID NUMBER(10) DEFAULT NULL 
;

-- 02-Sep-2024, 7:35:30 PM IST
ALTER TABLE C_PaymentAllocate MODIFY C_Invoice_ID NULL
;
