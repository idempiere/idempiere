-- IDEMPIERE - 5206
SELECT register_migration_script('202202280901_IDEMPIERE-5206.sql') FROM dual;

-- Feb 28, 2022, 9:08:21 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214710,0,'Field Style','Field CSS Style ',489,'AD_FieldStyle_ID',10,'N','N','N','N','N',0,'N',18,200121,0,0,'Y',TO_TIMESTAMP('2022-02-28 09:08:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-02-28 09:08:20','YYYY-MM-DD HH24:MI:SS'),100,203012,'Y','N','D','N','N','N','Y','351765e8-316e-419c-b264-a717b9148ffe','Y',0,'N','N','N','N')
;

-- Feb 28, 2022, 9:08:31 AM CET
UPDATE AD_Column SET FKConstraintName='ADFieldStyle_ADPrintFormatItem', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-02-28 09:08:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214710
;

-- Feb 28, 2022, 9:08:31 AM CET
ALTER TABLE AD_PrintFormatItem ADD COLUMN AD_FieldStyle_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 28, 2022, 9:08:31 AM CET
ALTER TABLE AD_PrintFormatItem ADD CONSTRAINT ADFieldStyle_ADPrintFormatItem FOREIGN KEY (AD_FieldStyle_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 28, 2022, 9:15:01 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206903,'Field Style','Field CSS Style ',426,214710,'Y',0,412,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-28 09:15:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-02-28 09:15:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2cc55c6b-6341-4d0b-83ca-7494809f5701','Y',580,1,1,1,'N','N','N','N')
;

