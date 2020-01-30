-- IDEMPIERE-4084 improve toolbar more configurable
-- Jan 24, 2020, 8:22:03 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Help,PrintName,EntityType,AD_Element_UU) VALUES (203396,0,0,'Y',TO_TIMESTAMP('2020-01-24 20:22:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-01-24 20:22:02','YYYY-MM-DD HH24:MI:SS'),100,'IsShowMore','Group in show more',NULL,'Group in show more','D','ba2bc74f-3b73-48c0-b1fa-8182d5275c77')
;

-- Jan 24, 2020, 8:22:34 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214166,0,'Group in show more',200003,'IsShowMore','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2020-01-24 20:22:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-01-24 20:22:34','YYYY-MM-DD HH24:MI:SS'),100,203396,'Y','N','D','N','N','N','Y','065f4119-dd27-42bf-997a-cfa9af541363','Y',0,'N','N','N')
;

-- Jan 24, 2020, 8:22:51 PM CET
ALTER TABLE AD_ToolBarButton ADD COLUMN IsShowMore CHAR(1) DEFAULT 'N' CHECK (IsShowMore IN ('Y','N'))
;

-- Jan 24, 2020, 8:23:08 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206377,'Group in show more',200002,214166,'Y',1,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-01-24 20:23:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-01-24 20:23:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','df8fdfc2-139d-4246-95bb-89c62b72ab98','Y',160,2,2)
;

-- Jan 24, 2020, 8:23:47 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-01-24 20:23:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206377
;

-- Jan 24, 2020, 8:23:47 PM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-01-24 20:23:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200753
;

-- Jan 24, 2020, 8:23:47 PM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-01-24 20:23:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202546
;

-- Jan 24, 2020, 8:23:47 PM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-01-24 20:23:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202547
;

-- Jan 24, 2020, 8:33:05 PM CET
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','More','',0,0,'Y',TO_TIMESTAMP('2020-01-24 20:33:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-01-24 20:33:05','YYYY-MM-DD HH24:MI:SS'),100,200593,'ShowMore','D','a0b7f1d7-4bfd-4a5a-a86b-6e85aae57d17')
;

-- Jan 24, 2020, 8:33:46 PM CET
UPDATE AD_Field SET DisplayLogic='@Action@=W', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-01-24 20:33:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206377
;

SELECT register_migration_script('202001291950_IDEMPIERE-4084.sql') FROM dual
;

