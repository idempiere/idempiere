-- Accounting Schema and COA Migration As-Of Date
SELECT register_migration_script('202409241818_IDEMPIERE-6254.sql') FROM dual;

-- Sep 24, 2024, 6:18:19 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216884,0,'Start Date','First effective day (inclusive)','The Start Date indicates the first or starting date',265,'StartDate',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2024-09-24 18:18:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-24 18:18:19','YYYY-MM-DD HH24:MI:SS'),100,574,'Y','N','D','N','N','N','Y','d8343625-a903-4920-943e-3ed41f3a4fc7','Y',0,'N','N','N','N')
;

-- Sep 24, 2024, 6:18:22 PM IST
ALTER TABLE C_AcctSchema ADD COLUMN StartDate TIMESTAMP DEFAULT NULL 
;

-- Sep 24, 2024, 6:18:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216885,0,'End Date','Last effective date (inclusive)','The End Date indicates the last date in this range.',265,'EndDate',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2024-09-24 18:18:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-24 18:18:37','YYYY-MM-DD HH24:MI:SS'),100,294,'Y','N','D','N','N','N','Y','8bf3b1c0-6f07-432d-b67c-1965ee236179','Y',0,'N','N','N','N')
;

-- Sep 24, 2024, 6:18:39 PM IST
ALTER TABLE C_AcctSchema ADD COLUMN EndDate TIMESTAMP DEFAULT NULL 
;

-- Sep 24, 2024, 6:21:34 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203950,0,0,'Y',TO_TIMESTAMP('2024-09-24 18:21:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-24 18:21:34','YYYY-MM-DD HH24:MI:SS'),100,'IsAlwaysPosted','Always Posted','Posts the document if "AlwaysPosted" is checked, regardless of accounting schema.','Posts the document if "AlwaysPosted" is checked, even without a valid accounting schema.','Always Posted','D','f78c9715-2709-4ae3-8244-b406370a939e')
;

-- Sep 24, 2024, 6:23:20 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216886,0,'Always Posted','Posts the document if "AlwaysPosted" is checked, even without a valid accounting schema.','Posts the document if "AlwaysPosted" is checked, even without a valid accounting schema.',217,'IsAlwaysPosted','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-09-24 18:23:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-24 18:23:19','YYYY-MM-DD HH24:MI:SS'),100,203950,'Y','N','D','N','N','N','Y','9a2b0d22-28e2-4d18-9424-86dae2f09d9a','Y',0,'N','N','N','N')
;

-- Sep 24, 2024, 6:23:26 PM IST
ALTER TABLE C_DocType ADD COLUMN IsAlwaysPosted CHAR(1) DEFAULT 'N' CHECK (IsAlwaysPosted IN ('Y','N')) NOT NULL
;

-- Sep 24, 2024, 6:23:40 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208513,'Start Date','First effective day (inclusive)','The Start Date indicates the first or starting date',199,216884,'Y',7,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-09-24 18:23:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-24 18:23:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','186bf489-3f0c-49c5-90fa-3f74d2592780','Y',290,2)
;

-- Sep 24, 2024, 6:23:41 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208514,'End Date','Last effective date (inclusive)','The End Date indicates the last date in this range.',199,216885,'Y',7,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-09-24 18:23:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-24 18:23:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d8c38d4a-367c-43c1-9cce-151243070047','Y',300,2)
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1358
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12361
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1360
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1361
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1362
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1363
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1519
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1520
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4858
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53281
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13696
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50180
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12180
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12522
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208123
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208513
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=280, XPosition=4,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208514
;

-- Sep 24, 2024, 6:23:59 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-09-24 18:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204658
;

-- Sep 24, 2024, 6:24:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208515,'Always Posted','Posts the document if "AlwaysPosted" is checked, regardless of accounting schema.','Posts the document if "AlwaysPosted" is checked, even without a valid accounting schema.',167,216886,'Y',1,370,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-09-24 18:24:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-24 18:24:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5d68bd10-32f7-4d57-b6d6-c3e6ed4812eb','Y',370,2,2)
;

-- Sep 24, 2024, 6:24:34 PM IST
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2024-09-24 18:24:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206817
;

-- Sep 24, 2024, 6:24:34 PM IST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2024-09-24 18:24:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10340
;

-- Sep 24, 2024, 6:24:34 PM IST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2024-09-24 18:24:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200004
;

-- Sep 24, 2024, 6:24:34 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=340, XPosition=5,Updated=TO_TIMESTAMP('2024-09-24 18:24:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208515
;

-- Sep 24, 2024, 6:24:34 PM IST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2024-09-24 18:24:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205278
;

-- Sep 24, 2024, 6:24:34 PM IST
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2024-09-24 18:24:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206430
;

-- Sep 24, 2024, 6:24:34 PM IST
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2024-09-24 18:24:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6567
;

-- Sep 24, 2024, 6:24:34 PM IST
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2024-09-24 18:24:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3125
;

