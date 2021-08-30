SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 9, 2021 12:54:11 PM GMT+08:00
-- IDEMPIERE-4904 Add custom query clause support to report parameter
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213185,0,'N',0,'N','N','N',0,'N',2000,'N','N','N','Y',NULL,'04f9c29a-7806-444f-a313-45204f9efa84',TO_DATE('2021-08-09 12:54:09','YYYY-MM-DD HH24:MI:SS'),'Y','Query','SQL','Query','N','Y',100,100,'N',0,0,TO_DATE('2021-08-09 12:54:09','YYYY-MM-DD HH24:MI:SS'),'D','N','N',53775,14,285,'N')
;

-- Aug 9, 2021 12:54:23 PM GMT+08:00
ALTER TABLE AD_Process_Para ADD Query VARCHAR2(2000 CHAR) DEFAULT NULL
;

-- Aug 9, 2021 12:57:18 PM GMT+08:00
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,DisplayLogic,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,205193,'N',0,'N','N',270,'Y','N','@IsReport@=Y',0,TO_DATE('2021-08-09 12:57:17','YYYY-MM-DD HH24:MI:SS'),'SQL','Query','ed208c1d-a58a-43d5-912f-af8294e5d276','Y','N',100,100,'Y','Y',270,1,'N',0,TO_DATE('2021-08-09 12:57:17','YYYY-MM-DD HH24:MI:SS'),5,3,'N','N',213185,'D',246)
;

SELECT register_migration_script('202108091122_IDEMPIERE-4904.sql') FROM dual
;
