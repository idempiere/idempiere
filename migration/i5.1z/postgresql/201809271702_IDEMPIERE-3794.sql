-- IDEMPIERE-3794 Improvement to Housekeeping
-- Sep 27, 2018 4:49:40 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2018-09-27 16:49:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56346
;

-- Sep 27, 2018 4:49:43 PM CEST
INSERT INTO t_alter_column values('ad_housekeeping','AD_Table_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 27, 2018 4:49:43 PM CEST
INSERT INTO t_alter_column values('ad_housekeeping','AD_Table_ID',null,'NULL',null)
;

-- Sep 27, 2018 4:51:05 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213696,0,'DB Table Name','Name of the table in the database','The DB Table Name indicates the name of the table in database.',53147,'TableName',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2018-09-27 16:51:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-27 16:51:04','YYYY-MM-DD HH24:MI:SS'),100,587,'Y','N','D','N','N','@AD_Table_ID@=0','N','Y','60eaa9cd-381b-4385-b4a4-245510ad0718','Y',0,'N','N')
;

-- Sep 27, 2018 4:51:16 PM CEST
UPDATE AD_Column SET MandatoryLogic='@TableName@=''''',Updated=TO_TIMESTAMP('2018-09-27 16:51:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56346
;

-- Sep 27, 2018 4:51:23 PM CEST
ALTER TABLE AD_HouseKeeping ADD COLUMN TableName VARCHAR(40) DEFAULT NULL 
;

-- Sep 27, 2018 4:51:59 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205834,'DB Table Name','Name of the table in the database','The DB Table Name indicates the name of the table in database.',53178,213696,'Y',40,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-09-27 16:51:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-27 16:51:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bbc73a31-615b-4045-92f9-e37a64fc5b6c','Y',160,2)
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205834
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56367
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56365
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56358
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56354
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56364
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56361
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56360
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56353
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204515
;

-- Sep 27, 2018 4:52:20 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56359
;

-- Sep 27, 2018 4:53:13 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Table_ID@>0', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56358
;

-- Sep 27, 2018 4:53:21 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsExportXMLBackup@=Y & @AD_Table_ID@>0', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:53:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56354
;

-- Sep 27, 2018 4:56:14 PM CEST
UPDATE AD_Field SET DisplayLogic='@TableName@=''''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:56:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56368
;

-- Sep 27, 2018 4:56:32 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Table_ID@=0', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-27 16:56:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205834
;

SELECT register_migration_script('201809271702_IDEMPIERE-3794.sql') FROM dual
;

