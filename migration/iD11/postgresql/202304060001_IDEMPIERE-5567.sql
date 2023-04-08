-- IDEMPIERE-5567 Support of UUID on Search (FHCA-4195)
SELECT register_migration_script('202304060001_IDEMPIERE-5567.sql') FROM dual;

-- Apr 6, 2023, 12:01:14 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','UUID based table is not compatible with Record_ID',0,0,'Y',TO_TIMESTAMP('2023-04-06 00:01:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-06 00:01:13','YYYY-MM-DD HH24:MI:SS'),100,200830,'UUTableNotCompatibleWithRecordID','D','5b220b22-2a21-493c-81f0-877dbc083874')
;

ALTER TABLE t_selection ADD COLUMN t_selection_uu VARCHAR(36) NOT NULL DEFAULT '';

ALTER TABLE t_selection ALTER COLUMN t_selection_id SET DEFAULT 0;

ALTER TABLE t_selection DROP CONSTRAINT t_selection_pkey;

ALTER TABLE t_selection ADD CONSTRAINT t_selection_pkey PRIMARY KEY (ad_pinstance_id, t_selection_id, t_selection_uu);

ALTER TABLE t_selection_infowindow ADD COLUMN t_selection_uu VARCHAR(36) NOT NULL DEFAULT '';

ALTER TABLE t_selection_infowindow ALTER COLUMN t_selection_id SET DEFAULT 0;

ALTER TABLE t_selection_infowindow DROP CONSTRAINT t_selection_infowindow_key;

ALTER TABLE t_selection_infowindow ADD CONSTRAINT t_selection_infowindow_key PRIMARY KEY (ad_pinstance_id, t_selection_id, t_selection_uu, columnname);

-- Apr 6, 2023, 1:39:46 AM CEST
UPDATE AD_Reference SET IsActive='Y',Updated=TO_TIMESTAMP('2023-04-06 01:39:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200235
;

-- Apr 8, 2023, 12:42:49 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200240,'Record UUID','D',0,0,'Y',TO_TIMESTAMP('2023-04-08 12:42:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-08 12:42:49','YYYY-MM-DD HH24:MI:SS'),100,'D','N','9bab064f-725d-4fc2-bdab-3ea690905549','N')
;

-- Apr 8, 2023, 1:00:34 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203804,0,0,'Y',TO_TIMESTAMP('2023-04-08 13:00:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-08 13:00:22','YYYY-MM-DD HH24:MI:SS'),100,'Record_UU','Record UUID',NULL,NULL,'Record UUID','D','0f02ad7f-7837-494f-b67f-092f3bba2fbc')
;

-- Apr 8, 2023, 1:00:51 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215833,0,'Record UUID',135,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-04-08 13:00:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-08 13:00:51','YYYY-MM-DD HH24:MI:SS'),100,203804,'Y','N','D','N','N','N','Y','b608cf28-12a4-48ec-9e73-cecefa353432','Y',0,'N','N','N','N')
;

-- Apr 8, 2023, 1:01:07 PM CEST
ALTER TABLE Test ADD COLUMN Record_UU VARCHAR(36) DEFAULT NULL 
;

-- Apr 8, 2023, 1:01:18 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207617,'Record UUID',152,215833,'Y',36,300,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-08 13:01:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-08 13:01:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','008d5c60-1fca-4f56-9494-96041e502a1c','Y',280,2)
;

-- Apr 8, 2023, 1:02:12 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, XPosition=4,Updated=TO_TIMESTAMP('2023-04-08 13:02:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207617
;

-- Apr 8, 2023, 1:02:12 PM CEST
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2023-04-08 13:02:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205590
;

-- Apr 8, 2023, 1:02:12 PM CEST
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2023-04-08 13:02:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8351
;

-- Apr 8, 2023, 1:02:12 PM CEST
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2023-04-08 13:02:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8352
;

-- Apr 8, 2023, 1:02:12 PM CEST
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2023-04-08 13:02:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3060
;

-- Apr 8, 2023, 1:02:12 PM CEST
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2023-04-08 13:02:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3061
;

-- Apr 8, 2023, 1:02:12 PM CEST
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2023-04-08 13:02:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206818
;

