-- IDEMPIERE-1906 Use postgresql SIMILAR TO instead of LIKE
-- Jan 19, 2018 10:55:51 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203158,0,0,'Y',TO_TIMESTAMP('2018-01-19 22:54:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 22:54:41','YYYY-MM-DD HH24:MI:SS'),100,'IsUseSimilarTo','Use Similar To',NULL,'In PostgreSQL database enable using the more powerful SIMILAR TO instead of LIKE for matching queries.','Use Similar To','D','6917772a-f465-411c-95ed-8a834249a578')
;

-- Jan 19, 2018 10:56:06 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213340,0,'Use Similar To','In PostgreSQL database enable using the more powerful SIMILAR TO instead of LIKE for matching queries.',200174,'IsUseSimilarTo','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2018-01-19 22:56:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 22:56:06','YYYY-MM-DD HH24:MI:SS'),100,203158,'Y','N','D','N','N','N','Y','81564050-9da4-492f-b298-cf8aac897583','Y',0,'N','N')
;

-- Jan 19, 2018 10:56:07 PM CET
ALTER TABLE AD_UserPreference ADD COLUMN IsUseSimilarTo CHAR(1) DEFAULT 'N' CHECK (IsUseSimilarTo IN ('Y','N'))
;

-- Jan 19, 2018 10:56:20 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205304,'Use Similar To','In PostgreSQL database enable using the more powerful SIMILAR TO instead of LIKE for matching queries.',200189,213340,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-01-19 22:56:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 22:56:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','92dd69a0-5640-41d9-b26f-2546a71eb75b','Y',100,2,2)
;

-- Jan 19, 2018 10:56:41 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-01-19 22:56:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205304
;

-- Jan 19, 2018 10:56:41 PM CET
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-01-19 22:56:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203798
;

-- Jan 19, 2018 10:59:21 PM CET
UPDATE AD_Field SET DisplayLogic='@#DBType@=PostgreSQL', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-01-19 22:59:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205304
;

SELECT register_migration_script('201801192257_IDEMPIERE-1906.sql') FROM dual
;

