-- IDEMPIERE-475 Show quotation number on invoice
-- Apr 20, 2015 2:46:17 PM COT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (200199,0,0,'Y',TO_TIMESTAMP('2015-04-20 14:46:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-20 14:46:17','YYYY-MM-DD HH24:MI:SS'),100,'QuotationOrder_ID','Quotation','Quotation used for generating this order','Quotation','D','2490fc7b-55b8-4957-b7b3-66d92142f301')
;

-- Apr 20, 2015 2:50:54 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (200819,0,'Quotation','Quotation used for generating this order',259,'QuotationOrder_ID',10,'N','N','N','N','N',0,'N',30,290,0,0,'Y',TO_TIMESTAMP('2015-04-20 14:50:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-20 14:50:54','YYYY-MM-DD HH24:MI:SS'),100,200199,'Y','N','D','N','N','N','Y','f0bc7f90-eca2-412b-ae6f-da8fe38b08d3','Y',0,'N','N')
;

-- Apr 20, 2015 2:57:31 PM COT
UPDATE AD_Column SET FKConstraintName='QuotationOrder_COrder', FKConstraintType='N',Updated=TO_TIMESTAMP('2015-04-20 14:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200819
;

-- Apr 20, 2015 2:57:31 PM COT
ALTER TABLE C_Order ADD COLUMN QuotationOrder_ID NUMERIC(10) DEFAULT NULL 
;

-- Apr 20, 2015 2:57:32 PM COT
ALTER TABLE C_Order ADD CONSTRAINT QuotationOrder_COrder FOREIGN KEY (QuotationOrder_ID) REFERENCES c_order(c_order_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 20, 2015 2:58:16 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (200756,'Quotation','Quotation used for generating this order',186,200819,'Y',10,570,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-04-20 14:58:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-20 14:58:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','479c2982-2986-4b25-9171-172921522732','Y',570,2)
;

-- Apr 20, 2015 3:00:55 PM COT
UPDATE AD_Field SET DisplayLogic='@QuotationOrder_ID@>0', IsReadOnly='Y',Updated=TO_TIMESTAMP('2015-04-20 15:00:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200756
;

SELECT register_migration_script('201504201502_IDEMPIERE-475.sql') FROM dual
;

