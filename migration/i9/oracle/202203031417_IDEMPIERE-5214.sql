-- IDEMPIERE-5214
SELECT register_migration_script('202203031417_IDEMPIERE-5214.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 3, 2022, 2:17:27 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203566,0,0,'Y',TO_TIMESTAMP('2022-03-03 14:17:27','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-03-03 14:17:27','YYYY-MM-DD HH24:MI:SS'),0,'IsClientAdministrator','Client Administrator','This role is a client administrator','Client Administrator','D','82757516-f616-41ee-bc22-7be819e4cafa')
;

-- Mar 3, 2022, 2:18:01 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214711,0,'Client Administrator','This role is a client administrator',156,'IsClientAdministrator','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-03-03 14:18:01','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-03-03 14:18:01','YYYY-MM-DD HH24:MI:SS'),0,203566,'Y','N','D','N','N','N','Y','62f1e781-cdde-4a70-879e-a37fa30398ea','Y',0,'N','N','N','N')
;

-- Mar 3, 2022, 2:18:02 PM CET
ALTER TABLE AD_Role ADD IsClientAdministrator CHAR(1) DEFAULT 'N' CHECK (IsClientAdministrator IN ('Y','N')) NOT NULL
;

-- Mar 3, 2022, 2:18:15 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206904,'Client Administrator','This role is a client administrator',119,214711,'Y',1,450,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-03-03 14:18:15','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-03-03 14:18:15','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','00ef90d5-1086-4c52-b0bd-a632731b8b4a','Y',450,2,2)
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206904
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=8311
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=11006
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=12367
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=12368
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=11256
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=50168
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=50178
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=50176
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=50170
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=50174
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=50173
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=50172
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=50175
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=50169
;

-- Mar 3, 2022, 2:18:33 PM CET
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-03 14:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=50177
;

-- Set GardenWorld Admin and GardenWorld Admin Not Advanced roles as Client Administrator
UPDATE AD_Role SET IsClientAdministrator = 'Y' WHERE AD_Role_ID IN (102, 200001);
