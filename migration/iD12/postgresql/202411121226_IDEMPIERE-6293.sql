-- IDEMPIERE-6293
SELECT register_migration_script('202411121226_IDEMPIERE-6293.sql') FROM dual;

-- Nov 12, 2024, 12:26:43 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216921,0,'Stylesheet','CSS (Stylesheet) used','Base Stylesheet (.css file) to use - if empty, the default (standard.css) is used. The Style sheet can be a URL.',200421,'Stylesheet',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-11-12 12:26:43','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 12:26:43','YYYY-MM-DD HH24:MI:SS'),10,3036,'Y','N','D','N','N','N','Y','93a0ecf3-afdd-4cd3-8226-8edceef393f2','Y',0,'N','N','N','N')
;

-- Nov 12, 2024, 12:26:44 PM CET
ALTER TABLE AD_UserDef_Theme ADD COLUMN Stylesheet VARCHAR(60) DEFAULT NULL 
;

-- Nov 12, 2024, 12:27:09 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208544,'Stylesheet','CSS (Stylesheet) used','Base Stylesheet (.css file) to use - if empty, the default (standard.css) is used. The Style sheet can be a URL.',200386,216921,'Y',60,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-12 12:27:09','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-11-12 12:27:09','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','U','57a0e641-eb4c-4976-bb5e-19882f0965f0','Y',80,5)
;

-- Nov 12, 2024, 12:27:25 PM CET
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2024-11-12 12:27:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208544
;

-- Nov 12, 2024, 12:27:49 PM CET
UPDATE AD_Field SET SeqNo=90, ColumnSpan=2,Updated=TO_TIMESTAMP('2024-11-12 12:27:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208544
;

