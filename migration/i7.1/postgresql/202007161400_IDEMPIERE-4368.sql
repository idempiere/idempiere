-- IDEMPIERE-4368
-- Jul 16, 2020, 12:30:03 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214215,0,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',814,'IsDefault','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2020-07-16 12:30:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-16 12:30:02','YYYY-MM-DD HH24:MI:SS'),100,1103,'Y','N','D','N','N','N','Y','d3ac9ca1-7806-449b-81fc-ffdc20be02b1','Y',0,'N','N','N')
;

-- Jul 16, 2020, 12:30:24 PM CEST
ALTER TABLE AD_UserQuery ADD COLUMN IsDefault CHAR(1) DEFAULT 'N' CHECK (IsDefault IN ('Y','N'))
;

-- Jul 16, 2020, 12:36:23 PM CEST
INSERT INTO t_alter_column values('ad_userquery','IsDefault','CHAR(1)',null,'N')
;

-- Jul 16, 2020, 1:56:10 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206419,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200275,214215,'Y',1,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-07-16 13:56:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-16 13:56:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','046cd713-95d0-4ab4-95b4-fe1ebddde62d','Y',120,2,2)
;

-- Jul 16, 2020, 1:56:57 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206420,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',757,214215,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-07-16 13:56:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-16 13:56:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','46e6f0ed-c348-479d-881e-39036bef7756','Y',90,2,2)
;

-- Jul 16, 2020, 2:01:14 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-07-16 14:01:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206420
;

-- Jul 16, 2020, 2:01:14 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-07-16 14:01:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12246
;

-- Jul 16, 2020, 2:01:14 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-07-16 14:01:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12249
;

-- Jul 16, 2020, 2:01:14 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-07-16 14:01:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204619
;

SELECT register_migration_script('202007161400_IDEMPIERE-4368.sql') FROM dual
;
