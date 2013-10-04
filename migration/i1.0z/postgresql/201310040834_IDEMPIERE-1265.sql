-- Oct 4, 2013 2:14:15 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,50010,210876,'N','N','N',0,'N',22,'N',19,'N','N','Y','db439ec4-6b77-4ff5-8776-8072546bc082','Y','AD_Chart_ID','Chart','Y',TO_TIMESTAMP('2013-10-04 14:14:00','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-10-04 14:14:00','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',54268,'N')
;

-- Oct 4, 2013 2:14:22 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
ALTER TABLE PA_DashboardContent ADD COLUMN AD_Chart_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 4, 2013 2:14:24 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
ALTER TABLE PA_DashboardContent ADD CONSTRAINT ADChart_PADashboardContent FOREIGN KEY (AD_Chart_ID) REFERENCES ad_chart(ad_chart_id)
;

-- Oct 4, 2013 2:15:34 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsDefaultFocus,IsAdvancedField) VALUES (0,'N',50010,0,'N','N',210876,220,'Y',202524,'N','D','Chart','f123637a-5269-42a3-ac5f-5dd3fac19b8a','Y','N',100,0,TO_TIMESTAMP('2013-10-04 14:15:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-04 14:15:25','YYYY-MM-DD HH24:MI:SS'),'Y','Y',190,1,'N',0,2,1,'N','N')
;

-- Oct 4, 2013 2:17:27 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET SeqNo=110, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-10-04 14:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57344
;

-- Oct 4, 2013 2:17:27 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET SeqNo=120, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-10-04 14:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=51013
;

-- Oct 4, 2013 2:17:27 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2013-10-04 14:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200262
;

-- Oct 4, 2013 2:17:27 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2013-10-04 14:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200261
;

-- Oct 4, 2013 2:17:27 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2013-10-04 14:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200263
;

-- Oct 4, 2013 2:17:27 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET SeqNo=160, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-10-04 14:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202524
;

-- Oct 4, 2013 2:17:27 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET SeqNo=170, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-10-04 14:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56504
;

-- Oct 4, 2013 2:17:27 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET SeqNo=180, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-10-04 14:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200268
;

-- Oct 4, 2013 2:17:27 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET SeqNo=190, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-10-04 14:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200260
;

-- Oct 4, 2013 2:17:27 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET SeqNo=200, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-10-04 14:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202286
;

-- Oct 4, 2013 2:18:25 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET DisplayLogic='@AD_Process_ID@!0',Updated=TO_TIMESTAMP('2013-10-04 14:18:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200261
;

-- Oct 4, 2013 2:18:32 PM MYT
-- IDEMPIERE-1265 Add Adaxa Sales Management
UPDATE AD_Field SET DisplayLogic='@AD_Process_ID@!0',Updated=TO_TIMESTAMP('2013-10-04 14:18:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200263
;

SELECT register_migration_script('201310040834_IDEMPIERE-1265.sql') FROM dual
;


