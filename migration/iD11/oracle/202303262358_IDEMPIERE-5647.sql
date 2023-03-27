-- IDEMPIERE-5647
SELECT register_migration_script('202303262358_IDEMPIERE-5647.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 26, 2023, 11:58:42 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215806,0,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',156,'PredefinedContextVariables',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-03-26 23:58:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-26 23:58:42','YYYY-MM-DD HH24:MI:SS'),100,203475,'Y','N','D','N','N','N','Y','f5b18037-47e7-4e98-a002-ba54bfd62674','Y',0,'N','N','N','N')
;

-- Mar 26, 2023, 11:58:50 PM BRT
ALTER TABLE AD_Role ADD PredefinedContextVariables VARCHAR2(4000 CHAR) DEFAULT NULL 
;

-- Mar 26, 2023, 11:59:42 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207596,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',119,215806,'Y',4000,450,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-26 23:59:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-26 23:59:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','78a3f4d6-26a3-4af2-9342-3b4cc675f867','Y',460,5)
;

-- Mar 27, 2023, 12:00:13 AM BRT
UPDATE AD_Field SET SeqNo=420, AD_FieldGroup_ID=200015, NumLines=5,Updated=TO_TIMESTAMP('2023-03-27 00:00:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207596
;

-- Mar 27, 2023, 12:02:53 AM BRT
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N', IsAdvancedField='Y',Updated=TO_TIMESTAMP('2023-03-27 00:02:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207596
;

