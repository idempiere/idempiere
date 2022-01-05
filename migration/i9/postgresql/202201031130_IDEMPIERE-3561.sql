-- IDEMPIERE-3561
-- Jan 3, 2022, 10:44:39 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214656,0,'Window','Data entry or display window','The Window field identifies a unique Window in the system.',895,'AD_Window_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-01-03 10:44:38','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-03 10:44:38','YYYY-MM-DD HH24:MI:SS'),0,143,'Y','N','D','N','N','N','Y','0d69d1c3-81aa-42d6-8515-eb8d67194d5c','Y',0,'N','N','N','N')
;

-- Jan 3, 2022, 10:44:53 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214657,0,'PO Window','Purchase Order Window','Window for Purchase Order (AP) Zooms',895,'PO_Window_ID',22,'N','N','N','N','N',0,'N',18,284,0,0,'Y',TO_TIMESTAMP('2022-01-03 10:44:53','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-03 10:44:53','YYYY-MM-DD HH24:MI:SS'),0,2136,'Y','N','D','N','N','N','Y','57c86a93-1d2f-4c67-9d47-e89192de18a2','Y',0,'N','N','N','N')
;

-- Jan 3, 2022, 10:44:58 AM CET
UPDATE AD_Column SET FKConstraintName='ADWindow_ADInfoWindow', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-01-03 10:44:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214656
;

-- Jan 3, 2022, 10:44:58 AM CET
ALTER TABLE AD_InfoWindow ADD COLUMN AD_Window_ID NUMERIC(10) DEFAULT NULL 
;

-- Jan 3, 2022, 10:44:58 AM CET
ALTER TABLE AD_InfoWindow ADD CONSTRAINT ADWindow_ADInfoWindow FOREIGN KEY (AD_Window_ID) REFERENCES ad_window(ad_window_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 3, 2022, 10:44:58 AM CET
UPDATE AD_Column SET FKConstraintName='POWindow_ADInfoWindow', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-01-03 10:44:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214657
;

-- Jan 3, 2022, 10:44:58 AM CET
ALTER TABLE AD_InfoWindow ADD COLUMN PO_Window_ID NUMERIC(10) DEFAULT NULL 
;

-- Jan 3, 2022, 10:44:58 AM CET
ALTER TABLE AD_InfoWindow ADD CONSTRAINT POWindow_ADInfoWindow FOREIGN KEY (PO_Window_ID) REFERENCES ad_window(ad_window_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 3, 2022, 10:45:40 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206819,'Window','Data entry or display window','The Window field identifies a unique Window in the system.',842,214656,'Y',22,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-01-03 10:45:40','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-03 10:45:40','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','61158a17-db64-4d3e-bd5b-0ecb4b84c3d8','Y',150,2)
;

-- Jan 3, 2022, 10:45:40 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206820,'PO Window','Purchase Order Window','Window for Purchase Order (AP) Zooms',842,214657,'Y',22,250,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-01-03 10:45:40','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-03 10:45:40','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','0bcdb675-a41d-4322-b3bc-7500a71d1458','Y',160,2)
;

-- Jan 3, 2022, 10:45:49 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-03 10:45:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206820
;

-- Jan 3, 2022, 10:46:11 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214658,0,'Window','Data entry or display window','The Window field identifies a unique Window in the system.',200266,'AD_Window_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-01-03 10:46:10','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-03 10:46:10','YYYY-MM-DD HH24:MI:SS'),0,143,'Y','N','D','N','N','N','Y','c27982a3-9d94-4d98-a033-6fc9d4f3e9ca','Y',0,'N','N','N','N')
;

-- Jan 3, 2022, 10:46:18 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214659,0,'PO Window','Purchase Order Window','Window for Purchase Order (AP) Zooms',200266,'PO_Window_ID',22,'N','N','N','N','N',0,'N',18,284,0,0,'Y',TO_TIMESTAMP('2022-01-03 10:46:18','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-03 10:46:18','YYYY-MM-DD HH24:MI:SS'),0,2136,'Y','N','D','N','N','N','Y','27bd2166-8981-4e75-9669-d73160524e7a','Y',0,'N','N','N','N')
;

-- Jan 3, 2022, 10:46:23 AM CET
UPDATE AD_Column SET FKConstraintName='ADWindow_ADUserDefInfo', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-01-03 10:46:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214658
;

-- Jan 3, 2022, 10:46:23 AM CET
ALTER TABLE AD_UserDef_Info ADD COLUMN AD_Window_ID NUMERIC(10) DEFAULT NULL 
;

-- Jan 3, 2022, 10:46:23 AM CET
ALTER TABLE AD_UserDef_Info ADD CONSTRAINT ADWindow_ADUserDefInfo FOREIGN KEY (AD_Window_ID) REFERENCES ad_window(ad_window_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 3, 2022, 10:46:23 AM CET
UPDATE AD_Column SET FKConstraintName='POWindow_ADUserDefInfo', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-01-03 10:46:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214659
;

-- Jan 3, 2022, 10:46:23 AM CET
ALTER TABLE AD_UserDef_Info ADD COLUMN PO_Window_ID NUMERIC(10) DEFAULT NULL 
;

-- Jan 3, 2022, 10:46:23 AM CET
ALTER TABLE AD_UserDef_Info ADD CONSTRAINT POWindow_ADUserDefInfo FOREIGN KEY (PO_Window_ID) REFERENCES ad_window(ad_window_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 3, 2022, 10:46:37 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206821,'Window','Data entry or display window','The Window field identifies a unique Window in the system.',200280,214658,'Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-01-03 10:46:37','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-03 10:46:37','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','1429e754-70e3-4a6f-b4f4-86291ce22f29','Y',160,2)
;

-- Jan 3, 2022, 10:46:37 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206822,'PO Window','Purchase Order Window','Window for Purchase Order (AP) Zooms',200280,214659,'Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-01-03 10:46:37','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-01-03 10:46:37','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','2a4ac066-9694-4905-9aa3-8d5bd60a7593','Y',170,2)
;

-- Jan 3, 2022, 10:46:45 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-03 10:46:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206822
;

SELECT register_migration_script('202201031130_IDEMPIERE-3561.sql') FROM dual
;
