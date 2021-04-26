-- Feb 20, 2021, 1:45:25 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200504,'Script',255,'S',0,0,'Y',TO_TIMESTAMP('2021-02-20 13:45:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-20 13:45:25','YYYY-MM-DD HH24:MI:SS'),100,'D','f3acb050-7407-481a-9177-022c134cf3a5')
;

-- Feb 20, 2021, 1:46:44 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214413,0,'Script','Dynamic Java Language Script to calculate result','Use Java language constructs to define the result of the calculation',489,'Script',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2021-02-20 13:46:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-20 13:46:44','YYYY-MM-DD HH24:MI:SS'),100,1718,'Y','N','D','N','N','N','Y','d0873a87-64d0-4d21-bf51-5b5b6ce1645a','Y',0,'N','N','N')
;

-- Feb 20, 2021, 1:46:46 PM BRT
ALTER TABLE AD_PrintFormatItem ADD COLUMN Script VARCHAR(2000) DEFAULT NULL 
;

-- Feb 20, 2021, 1:51:41 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206598,'Script','Dynamic Java Language Script to calculate result','Use Java language constructs to define the result of the calculation',426,214413,'Y',2000,570,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-20 13:51:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-20 13:51:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c0a3c732-4ea1-4597-8a6f-c26cac7715e6','Y',570,5,3)
;

-- Feb 20, 2021, 1:51:58 PM BRT
UPDATE AD_Field SET DisplayLogic='@PrintFormatType@=''S''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-20 13:51:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206598
;

-- Feb 20, 2021, 1:58:50 PM BRT
UPDATE AD_Field SET DisplayLogic='@PrintFormatType@=F | @PrintFormatType@=S', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-20 13:58:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56373
;

-- Feb 20, 2021, 1:59:31 PM BRT
UPDATE AD_Field SET DisplayLogic='@PrintFormatType@=S', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@PrintFormatType@=S', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-20 13:59:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206598
;

-- Feb 20, 2021, 2:00:40 PM BRT
UPDATE AD_Field SET AD_FieldGroup_ID=200015, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-20 14:00:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206598
;

-- Apr 22, 2021, 8:05:02 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@#ShowAdvanced@=N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-22 20:05:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206598
;

SELECT register_migration_script('202102201441_IDEMPIERE-4709.sql') FROM dual
;
