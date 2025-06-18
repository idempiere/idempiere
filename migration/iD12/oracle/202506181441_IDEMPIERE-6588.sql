-- IDEMPIERE-6588 - Payment Discount excluding freight charges
SELECT register_migration_script('202506181441_IDEMPIERE-6588.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 18, 2025, 2:41:25 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (204012,0,0,'Y',TO_TIMESTAMP('2025-06-18 14:41:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 14:41:25','YYYY-MM-DD HH24:MI:SS'),100,'IsExcludedFromDiscount','Exclude from Payment Discount','If selected, this charge is excluded from payment discount calculations. Only line amounts will be considered for discount.','Exclude from Payment Discount','D','dfe95a1f-170e-4225-81d6-1f9f7a0c9043')
;

-- Jun 18, 2025, 2:42:38 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217133,0,'Exclude from Payment Discount','If selected, this charge is excluded from payment discount calculations. Only line amounts will be considered for discount.',313,'IsExcludedFromDiscount','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2025-06-18 14:42:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 14:42:38','YYYY-MM-DD HH24:MI:SS'),100,204012,'Y','N','D','N','N','N','Y','0cb10284-38bf-4dac-a839-08f6f5f92510','Y',0,'N','N','N','N')
;

-- Jun 18, 2025, 2:42:45 PM CEST
ALTER TABLE C_Charge ADD IsExcludedFromDiscount CHAR(1) DEFAULT 'N' CHECK (IsExcludedFromDiscount IN ('Y','N')) NOT NULL
;

-- Jun 18, 2025, 2:43:33 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (208809,'Exclude from Payment Discount','If selected, this charge is excluded from payment discount calculations. Only line amounts will be considered for discount.',237,217133,'Y',0,120,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-18 14:43:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 14:43:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1bcfe8bc-d395-4384-b55e-f6d91a0f3c1b','Y',120,1,1,1,'N','N','N','N','N')
;

-- Jun 18, 2025, 2:46:47 PM CEST
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_TIMESTAMP('2025-06-18 14:46:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208809
;

