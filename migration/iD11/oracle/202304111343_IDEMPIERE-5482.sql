-- IDEMPIERE-5482
SELECT register_migration_script('202304111343_IDEMPIERE-5482.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 11, 2023, 1:43:46 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203805,0,0,'Y',TO_TIMESTAMP('2023-04-11 13:43:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-11 13:43:45','YYYY-MM-DD HH24:MI:SS'),100,'IsWrapWithSpan','Wrap With Span','Wrap content in Span and apply the Style to it.','Wrap With Span','D','8c87a12e-eded-48c5-89d4-7c49fd29f4fa')
;

-- Apr 11, 2023, 1:46:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215834,0,'Wrap With Span','Wrap content in Span and apply the Style to it.',200207,'IsWrapWithSpan','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-04-11 13:46:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-11 13:46:32','YYYY-MM-DD HH24:MI:SS'),100,203805,'Y','N','D','N','N','N','Y','5ca5f2d0-6f43-4643-b63d-6e299d20f869','Y',0,'N','N','N','N')
;

-- Apr 11, 2023, 1:46:36 PM CEST
ALTER TABLE AD_Style ADD IsWrapWithSpan CHAR(1) DEFAULT 'N' CHECK (IsWrapWithSpan IN ('Y','N')) NOT NULL
;

-- Apr 11, 2023, 1:46:55 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207618,'Wrap With Span','Wrap content in Span and apply the Style to it.',200213,215834,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-11 13:46:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-11 13:46:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7ee72596-5bcd-47ea-a2ad-b6631a969034','Y',50,2,2)
;

-- Apr 11, 2023, 1:47:29 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_TIMESTAMP('2023-04-11 13:47:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207618
;

-- Apr 11, 2023, 1:47:29 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=5,Updated=TO_TIMESTAMP('2023-04-11 13:47:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204202
;

