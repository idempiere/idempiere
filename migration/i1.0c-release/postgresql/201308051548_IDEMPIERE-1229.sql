-- Aug 1, 2013 12:32:12 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,493,210681,'N','N','N',0,'N',22,'N',19,'N','N','Y','01406b24-b108-4ef9-9533-688ceb8615c4','Y','AD_Window_ID','Data entry or display window','The Window field identifies a unique Window in the system.','Window','Y',TO_TIMESTAMP('2013-08-01 12:32:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-01 12:32:11','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',143,'N')
;

-- Aug 1, 2013 12:32:12 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210681 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 1, 2013 12:32:17 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
ALTER TABLE AD_PrintFormat ADD COLUMN AD_Window_ID NUMERIC(10) DEFAULT NULL 
;

-- Aug 1, 2013 12:35:28 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',425,36,'N','N',60458,220,'Y',202367,'N','D','AD_PrintFormat_UU','d856c59c-850d-4f62-98c2-b30edf36641b','N','N',100,0,TO_TIMESTAMP('2013-08-01 12:35:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-01 12:35:27','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 1, 2013 12:35:28 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202367 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 1, 2013 12:35:29 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',425,22,'N','N',210681,230,'Y',202368,'N','The Window field identifies a unique Window in the system.','D','Data entry or display window','Window','588d3710-0a9b-497d-a5fc-f03a565b8b2d','Y','N',100,0,TO_TIMESTAMP('2013-08-01 12:35:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-01 12:35:28','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 1, 2013 12:35:29 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202368 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 1, 2013 12:36:10 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET DisplayLength=14,Updated=TO_TIMESTAMP('2013-08-01 12:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202368
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=5666
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=5662
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=5664
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=5659
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=5665
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=5652
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=8291
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=5655
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=5744
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=5656
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=5651
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=5663
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=5653
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=5762
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=6503
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=5657
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=5661
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=5654
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=5658
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=50179
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=202368
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=52009
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=5660
;

-- Aug 1, 2013 12:37:49 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=52008
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202367
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=5666
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=5662
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=5664
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=5659
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=5665
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=5652
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=8291
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=5655
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=5744
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=5656
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=5651
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=5663
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=5653
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=5762
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=6503
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=5657
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=5661
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=5654
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=5658
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=50179
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=202368
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=52009
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=5660
;

-- Aug 1, 2013 12:37:56 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=52008
;

-- Aug 1, 2013 12:38:10 PM SGT
-- IDEMPIERE-1229 Purchase Order print format needs to be removed from SO window
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-08-01 12:38:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202368
;

SELECT register_migration_script('201308051548_IDEMPIERE-1229.sql') FROM dual
;