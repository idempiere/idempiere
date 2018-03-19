SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 25, 2014 8:16:32 AM MYT
-- IDEMPIERE-1711 InfoWindow Process
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,'N',0,210944,'N','N','N',0,'N',22,'N','N','N','Y','31b21b81-8828-47c0-9b47-14cfd046ccf7','Y','AD_Process_ID','Process or Report','The Process field identifies a unique Process or Report in the system.','Process','Y',TO_DATE('2014-01-25 08:16:26','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-01-25 08:16:26','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',117,19,895)
;

-- Jan 25, 2014 8:25:41 AM MYT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType) VALUES (0,'N',842,0,'N','N',180,'Y',202596,'N','The Process field identifies a unique Process or Report in the system.','Process or Report','Process','939b9169-77cc-4ca0-b3e8-68478ae01d66','Y','N',100,0,TO_DATE('2014-01-25 08:25:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-01-25 08:25:35','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,1,'N',0,1,1,'N','N',210944,'D')
;

-- Jan 25, 2014 8:29:22 AM MYT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202596
;

-- Jan 25, 2014 8:29:22 AM MYT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=201634
;

-- Jan 25, 2014 8:29:22 AM MYT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=13579
;

-- Jan 25, 2014 8:29:22 AM MYT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=13580
;

-- Jan 25, 2014 8:29:22 AM MYT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=201627
;

-- Jan 25, 2014 8:29:22 AM MYT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=201628
;

-- Jan 25, 2014 8:29:22 AM MYT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=201639
;

-- Jan 25, 2014 8:29:22 AM MYT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=201807
;

-- Jan 25, 2014 8:29:54 AM MYT
UPDATE AD_Field SET IsSameLine='Y', XPosition=3,Updated=TO_DATE('2014-01-25 09:27:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202596
;

-- Jan 25, 2014 8:30:12 AM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADProcess_ADInfoWindow',Updated=TO_DATE('2014-01-25 09:06:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210944
;

-- Jan 25, 2014 8:30:12 AM MYT
ALTER TABLE AD_InfoWindow ADD AD_Process_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 25, 2014 8:30:14 AM MYT
ALTER TABLE AD_InfoWindow ADD CONSTRAINT ADProcess_ADInfoWindow FOREIGN KEY (AD_Process_ID) REFERENCES ad_process(ad_process_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 24, 2014 10:16:49 PM COT
-- IDEMPIERE-1711 InfoWindow Process
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13575
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13582
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202596
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13581
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201621
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201634
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13579
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13580
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201627
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=170,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201628
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=180, IsDisplayed='Y', XPosition=4, ColumnSpan=1,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201639
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=190, IsDisplayed='Y', XPosition=5, ColumnSpan=1,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202198
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=200,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201807
;

-- Jan 24, 2014 10:16:49 PM COT
UPDATE AD_Field SET SeqNo=210, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2014-01-24 22:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202196
;

SELECT register_migration_script('201401242121_IDEMPIERE-1711.sql') FROM dual
;

