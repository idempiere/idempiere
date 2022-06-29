-- IDEMPIERE-5322 Document Rounding Rules
SELECT register_migration_script('202206291851_IDEMPIERE-5322.sql') FROM dual;

-- Jun 29, 2022, 6:51:21 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203611,0,0,'Y',TO_TIMESTAMP('2022-06-29 18:51:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-29 18:51:21','YYYY-MM-DD HH24:MI:SS'),100,'Rounding','Rounding rule for the document','Rounding rule for the document','D','758d6dd9-be8d-4d67-a100-1857ea9af6f1')
;

-- Jun 29, 2022, 6:51:22 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214968,0,'Rounding rule for the document',217,'Rounding',1,'N','N','N','N','N',0,'N',17,155,0,0,'Y',TO_TIMESTAMP('2022-06-29 18:51:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-29 18:51:21','YYYY-MM-DD HH24:MI:SS'),100,203611,'Y','N','D','Y','N','N','Y','20939b16-5559-4862-bd5d-14efbec507ec','Y',0,'N','N','N','N')
;

-- Jun 29, 2022, 6:51:22 PM CEST
ALTER TABLE C_DocType ADD COLUMN Rounding CHAR(1) DEFAULT NULL 
;

-- Jun 29, 2022, 6:51:22 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203612,0,0,'Y',TO_TIMESTAMP('2022-06-29 18:51:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-29 18:51:22','YYYY-MM-DD HH24:MI:SS'),100,'RoundingCharge_ID','Rounding Charge','Rounding Charge','D','5f119549-b506-4a88-a805-7eb7c2535b35')
;

-- Jun 29, 2022, 6:51:23 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214969,0,'Rounding Charge',217,'RoundingCharge_ID',10,'N','N','N','N','N',0,'N',18,200,0,0,'Y',TO_TIMESTAMP('2022-06-29 18:51:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-29 18:51:22','YYYY-MM-DD HH24:MI:SS'),100,203612,'Y','N','D','Y','N','N','Y','3bcba50b-bb0d-4c82-93cc-bd89c3e0520d','Y',0,'N','N','BXSRoundingCharge_CDocType','N','N')
;

-- Jun 29, 2022, 6:51:23 PM CEST
ALTER TABLE C_DocType ADD COLUMN RoundingCharge_ID NUMERIC(10) DEFAULT NULL 
;

-- Jun 29, 2022, 6:51:23 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207110,'Rounding rule for the document',167,214968,'Y',0,362,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-29 18:51:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-29 18:51:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2810ad71-928d-4a5c-9f95-cdd5746c8e6b','Y',362,1,2,1,'N','N','N','N')
;

-- Jun 29, 2022, 6:51:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,MandatoryLogic,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207111,'Rounding Charge',167,214969,'Y','@Rounding@!''''',0,364,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-29 18:51:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-29 18:51:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','267ba6cb-705a-48e6-89df-ccb986dd25a4','Y',364,4,2,1,'N','@Rounding@!''''','N','N','N')
;

-- Jun 29, 2022, 6:51:24 PM CEST
ALTER TABLE C_DocType ADD CONSTRAINT BXSRoundingCharge_CDocType FOREIGN KEY (RoundingCharge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 29, 2022, 7:43:04 PM CEST
UPDATE AD_Field SET DisplayLogic='@DocBaseType@=''SOO'' | @DocBaseType@=''POO'' | @DocBaseType@=''API'' | @DocBaseType@=''APC'' | @DocBaseType@=''ARI'' | @DocBaseType@=''ARC'' | @DocBaseType@=''ARF''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-29 19:43:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207110
;

