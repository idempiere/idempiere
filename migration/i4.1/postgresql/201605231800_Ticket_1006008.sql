-- May 23, 2016 6:17:30 PM MYT
-- 1006008 Add field type for dashboard content
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212763,0,'N',0,'N','N','N',0,'N',22,'N','N','N','Y','84c773d0-4cdf-45e0-a0cd-0ce63907e53d',TO_TIMESTAMP('2016-05-23 18:17:24','YYYY-MM-DD HH24:MI:SS'),'N','PA_DashboardContent_ID','Dashboard Content','Y','Y',100,100,'N','N',0,0,TO_TIMESTAMP('2016-05-23 18:17:24','YYYY-MM-DD HH24:MI:SS'),'U','N','N','N',51006,19,464)
;

-- May 23, 2016 6:25:24 PM MYT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2016-05-23 18:25:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212763
;

-- May 23, 2016 6:28:36 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,DisplayLogic,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,204221,'N',0,'N','N',300,'Y','N','@AD_Reference_ID@=200122',0,TO_TIMESTAMP('2016-05-23 18:28:29','YYYY-MM-DD HH24:MI:SS'),'Dashboard Content','f6d15a90-273e-4810-866d-6a1842a23c32','Y','N',100,100,'Y','Y',280,1,'N',0,TO_TIMESTAMP('2016-05-23 18:28:29','YYYY-MM-DD HH24:MI:SS'),1,1,'N','N',212763,'D',395)
;

-- May 23, 2016 6:29:09 PM MYT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2016-05-23 18:29:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204221
;

-- May 23, 2016 6:29:31 PM MYT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=204221
;

-- May 23, 2016 6:29:31 PM MYT
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=5054
;

-- May 23, 2016 6:29:31 PM MYT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=200849
;

-- May 23, 2016 6:29:32 PM MYT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200851
;

-- May 23, 2016 6:29:32 PM MYT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=200852
;

-- May 23, 2016 6:29:32 PM MYT
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=200854
;

-- May 23, 2016 6:29:32 PM MYT
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=5051
;

-- May 23, 2016 6:29:32 PM MYT
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=5057
;

-- May 23, 2016 8:25:15 PM MYT
-- 1006008 Add field type for dashboard content
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='PADashboardContent_ADUserDefFi',Updated=TO_TIMESTAMP('2016-05-23 20:25:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212763
;

-- May 23, 2016 8:25:15 PM MYT
ALTER TABLE AD_UserDef_Field ADD COLUMN PA_DashboardContent_ID NUMERIC(10) DEFAULT NULL 
;

-- May 23, 2016 8:25:16 PM MYT
ALTER TABLE AD_UserDef_Field ADD CONSTRAINT PADashboardContent_ADUserDefFi FOREIGN KEY (PA_DashboardContent_ID) REFERENCES pa_dashboardcontent(pa_dashboardcontent_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 23, 2016 8:49:33 PM MYT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2016-05-23 20:49:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212763
;

SELECT register_migration_script('201605231800_Ticket_1006008.sql') FROM dual
;

