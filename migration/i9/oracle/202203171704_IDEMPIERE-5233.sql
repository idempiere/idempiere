-- IDEMPIERE-5233 - Invoice created from the Commission Run window cannot be easly found after created
SELECT register_migration_script('202203171704_IDEMPIERE-5233.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 17, 2022, 5:04:47 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214715,0,'Invoice','Invoice Identifier','The Invoice Document.',436,'C_Invoice_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-03-17 17:04:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-17 17:04:46','YYYY-MM-DD HH24:MI:SS'),100,1008,'N','N','D','N','N','N','Y','2e785622-37fb-49d3-b0a2-0794efd14079','N',0,'N','N','N')
;

-- Mar 17, 2022, 5:05:01 PM CET
UPDATE AD_Column SET FKConstraintName='CInvoice_CCommissionRun', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-03-17 17:05:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214715
;

-- Mar 17, 2022, 5:05:01 PM CET
ALTER TABLE C_CommissionRun ADD C_Invoice_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 17, 2022, 5:05:01 PM CET
ALTER TABLE C_CommissionRun ADD CONSTRAINT CInvoice_CCommissionRun FOREIGN KEY (C_Invoice_ID) REFERENCES c_invoice(c_invoice_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 17, 2022, 5:05:39 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206917,'Invoice','Invoice Identifier','The Invoice Document.',362,214715,'Y',22,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-03-17 17:05:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-17 17:05:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d8469e95-9b96-41d4-986f-775856d7b44a','Y',120,2)
;

-- Mar 17, 2022, 5:06:11 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-17 17:06:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206917
;

-- Mar 17, 2022, 5:06:32 PM CET
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-17 17:06:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206917
;

-- Mar 17, 2022, 5:07:40 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-17 17:07:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4569
;

-- Mar 17, 2022, 5:10:22 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@Processed@=''Y''', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-17 17:10:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4568
;

