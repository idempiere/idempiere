SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4997 Allow to use product (or charge) in commissions configuration
-- Oct 11, 2021, 7:19:46 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2021-10-11 19:19:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10263
;

-- Oct 11, 2021, 7:19:48 PM CEST
ALTER TABLE C_Commission MODIFY C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 11, 2021, 7:19:48 PM CEST
ALTER TABLE C_Commission MODIFY C_Charge_ID NULL
;

-- Oct 11, 2021, 7:20:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214595,0,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',429,231,'M_Product_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_DATE('2021-10-11 19:20:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-11 19:20:19','YYYY-MM-DD HH24:MI:SS'),100,454,'Y','N','D','N','N','N','Y','8e031011-e61c-4cfa-81f8-1f22ed5f8c35','Y',0,'N','N','N','N')
;

-- Oct 11, 2021, 7:20:24 PM CEST
UPDATE AD_Column SET FKConstraintName='MProduct_CCommission', FKConstraintType='N',Updated=TO_DATE('2021-10-11 19:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214595
;

-- Oct 11, 2021, 7:20:24 PM CEST
ALTER TABLE C_Commission ADD M_Product_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 11, 2021, 7:20:24 PM CEST
ALTER TABLE C_Commission ADD CONSTRAINT MProduct_CCommission FOREIGN KEY (M_Product_ID) REFERENCES m_product(m_product_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 11, 2021, 7:20:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206754,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',355,214595,'Y',22,160,'N','N','N','N',0,0,'Y',TO_DATE('2021-10-11 19:20:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-11 19:20:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','44c55d09-6b39-410e-b20b-00d285b6cdbc','Y',160,2)
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET SeqNo=10, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4460
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4461
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4471
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4466
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4469
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4462
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4464
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8617
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206754
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204700
;

-- Oct 11, 2021, 7:21:14 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-11 19:21:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4463
;

-- Oct 11, 2021, 7:21:47 PM CEST
UPDATE AD_Column SET ReadOnlyLogic='@M_Product_ID@>0',Updated=TO_DATE('2021-10-11 19:21:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10263
;

-- Oct 11, 2021, 7:22:06 PM CEST
UPDATE AD_Column SET ReadOnlyLogic='@C_Charge_ID@>0',Updated=TO_DATE('2021-10-11 19:22:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214595
;

SELECT register_migration_script('202110111922_IDEMPIERE-4997.sql') FROM dual
;

