-- IDEMPIERE-5152
-- Jan 12, 2022, 3:59:08 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214661,0,'Title','Name this entity is referred to as','The Title indicates the name that an entity is referred to as.',200038,'Title',60,'N','N','N','Y','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-01-12 15:59:08','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-12 15:59:08','YYYY-MM-DD HH24:MI:SS'),0,982,'Y','N','D','N','N','N','Y','aca757b4-155c-462a-9321-3204ddb596ea','Y',0,'N','N','N')
;

-- Jan 12, 2022, 3:59:10 PM CET
ALTER TABLE AD_BroadcastMessage ADD COLUMN Title VARCHAR(60) DEFAULT NULL 
;

-- Jan 12, 2022, 3:59:33 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214662,0,'Title','Name this entity is referred to as','The Title indicates the name that an entity is referred to as.',200123,'Title',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-01-12 15:59:33','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-12 15:59:33','YYYY-MM-DD HH24:MI:SS'),0,982,'N','N','D','N','N','N','Y','a882c8f2-3b33-41d9-83e9-05f0a26a47e2','Y',0,'N','N','N')
;

-- Jan 12, 2022, 3:59:34 PM CET
ALTER TABLE AD_BroadcastMessage_Trl ADD COLUMN Title VARCHAR(60) DEFAULT NULL 
;

-- Jan 12, 2022, 3:59:47 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206833,'Title','Name this entity is referred to as','The Title indicates the name that an entity is referred to as.',200033,214661,'Y',60,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-01-12 15:59:46','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-12 15:59:46','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','3b030cbb-f4bb-49cf-8892-f1d7491e3e48','Y',160,5)
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206833
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200876
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200872
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200888
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200889
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200885
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200878
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200880
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200886
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=204472
;

-- Jan 12, 2022, 4:00:08 PM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200881
;

-- Jan 12, 2022, 4:00:24 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206834,'Title','Name this entity is referred to as','The Title indicates the name that an entity is referred to as.',200133,214662,'Y',60,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-01-12 16:00:23','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-12 16:00:23','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','1a7fe587-23de-4b26-9faf-a948262a9228','Y',10,5)
;

-- Jan 12, 2022, 4:00:36 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206834
;

-- Jan 12, 2022, 4:00:36 PM CET
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-12 16:00:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=202810
;

-- Jan 12, 2022, 4:20:02 PM CET
UPDATE AD_Column SET IsAlwaysUpdateable='N',Updated=TO_TIMESTAMP('2022-01-12 16:20:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=211151
;

-- Jan 12, 2022, 4:23:51 PM CET
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2022-01-12 16:23:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214662
;

SELECT register_migration_script('202201121630_IDEMPIERE-5152.sql') FROM dual
;
