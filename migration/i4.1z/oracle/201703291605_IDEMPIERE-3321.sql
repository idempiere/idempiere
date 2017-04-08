SET SQLBLANKLINES ON
SET DEFINE OFF

ALTER TABLE AD_Process_Para
ADD mandatorylogic VARCHAR2(2000) DEFAULT NULL
;

-- Mar 27, 2017 9:06:38 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212967,0,'Mandatory Logic',285,'MandatoryLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2017-03-27 21:06:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-03-27 21:06:37','YYYY-MM-DD HH24:MI:SS'),100,50074,'Y','N','D','N','N','N','Y','e9fab689-db8f-4d61-8ef6-9f08c2c405a4','Y',0,'N','N')
;
-- Mar 27, 2017 9:24:30 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204372,'Mandatory Logic',246,212967,'Y',0,270,0,'N','N','N','N',0,0,'Y',TO_DATE('2017-03-27 21:24:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-03-27 21:24:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3f1360c0-d89e-4b28-aaef-2b6ae45678f5','Y',270,1,1,1,'N','N','N')
;

-- Mar 27, 2017 9:26:58 PM SGT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=2, IsToolbarButton=NULL,Updated=TO_DATE('2017-03-27 21:26:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204372
;

-- Mar 27, 2017 9:28:23 PM SGT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=5, IsToolbarButton=NULL,Updated=TO_DATE('2017-03-27 21:28:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204372
;

-- Mar 27, 2017 9:29:19 PM SGT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=3, IsToolbarButton=NULL,Updated=TO_DATE('2017-03-27 21:29:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204372
;

-- Mar 27, 2017 9:35:44 PM SGT
UPDATE AD_Field SET Help='Logic expression or @SQL=SELECT something FROM ... (Both can contain context variables). For @SQL=, the field is mandatory if the SQL statement return a non-empty result set. ', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-03-27 21:35:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204372
;


SELECT register_migration_script('201703291605_IDEMPIERE-3321.sql') FROM dual
;
