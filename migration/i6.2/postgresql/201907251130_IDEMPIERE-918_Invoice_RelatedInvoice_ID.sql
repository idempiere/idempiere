-- IDEMPIERE-918 - add C_Invoice.RelatedInvoice_ID
-- 07/25/2019 11:08:54
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203348,0,0,'Y',TO_TIMESTAMP('2019-07-25 11:08:54','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2019-07-25 11:08:54','YYYY-MM-DD HH24:MI:SS'),0,'RelatedInvoice_ID','Related Invoice','Related Invoice','D','30673d40-aeaa-4d46-b9aa-fd2d41ab90f8')
;

-- 07/25/2019 11:10:03
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213967,0,'Related Invoice',318,'RelatedInvoice_ID',10,'N','N','N','N','N',0,'N',30,336,0,0,'Y',TO_TIMESTAMP('2019-07-25 11:10:03','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2019-07-25 11:10:03','YYYY-MM-DD HH24:MI:SS'),0,203348,'Y','N','D','N','N','N','Y','75158448-52e0-426b-a393-86141d86157e','N',0,'N','N','N','N')
;

-- 07/25/2019 11:10:08
UPDATE AD_Column SET FKConstraintName='RelatedInvoice_CInvoice', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-07-25 11:10:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=213967
;

-- 07/25/2019 11:10:08
ALTER TABLE C_Invoice ADD COLUMN RelatedInvoice_ID NUMERIC(10) DEFAULT NULL 
;

-- 07/25/2019 11:10:08
ALTER TABLE C_Invoice ADD CONSTRAINT RelatedInvoice_CInvoice FOREIGN KEY (RelatedInvoice_ID) REFERENCES c_invoice(c_invoice_id) DEFERRABLE INITIALLY DEFERRED
;

-- 07/25/2019 11:10:35
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206135,'Related Invoice',263,213967,'Y',10,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-07-25 11:10:35','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2019-07-25 11:10:35','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','ecbcf980-4cfe-4937-b31a-9e18e7e5767e','Y',450,2)
;

-- 07/25/2019 11:10:44
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-07-25 11:10:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=204733
;

-- 07/25/2019 11:11:21
UPDATE AD_Field SET DisplayLogic='@RelatedInvoice_ID@ > 0', IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-07-25 11:11:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206135
;

-- 07/25/2019 11:11:38
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206136,'Related Invoice',290,213967,'Y',10,440,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-07-25 11:11:37','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2019-07-25 11:11:37','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','e0bb818f-dfc1-494c-a9c2-1d5f1a9c7945','Y',430,2)
;

-- 07/25/2019 11:12:06
UPDATE AD_Field SET DisplayLogic='@RelatedInvoice_ID@ > 0', IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-07-25 11:12:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206136
;

SELECT register_migration_script('201907251130_IDEMPIERE-918_Invoice_RelatedInvoice_ID.sql') FROM dual
;