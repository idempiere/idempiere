-- Aug 21, 2012 12:33:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Column SET AD_Process_ID=53229,Updated=TO_DATE('2012-08-21 12:33:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4712
;

-- Aug 21, 2012 12:34:01 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Tab SET IsActive='N',Updated=TO_DATE('2012-08-21 12:34:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53287
;

-- Aug 21, 2012 12:34:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Tab SET IsActive='N',Updated=TO_DATE('2012-08-21 12:34:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53286
;

-- Aug 21, 2012 12:34:08 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Tab SET IsActive='Y',Updated=TO_DATE('2012-08-21 12:34:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=317
;

-- Aug 21, 2012 12:35:09 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',317,1,'Y','N','N',62001,'N','Y',200289,'N','The Bill of Materials check box indicates if this product consists of a bill of materials.','U','Bill of Materials','Bill of Materials',100,0,'Y',TO_DATE('2012-08-21 12:35:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-21 12:35:08','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 21, 2012 12:35:09 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200289 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 21, 2012 12:35:09 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',317,10,'Y','N','N',62000,'N','Y',200290,'N','U','Part Type',100,0,'Y',TO_DATE('2012-08-21 12:35:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-21 12:35:09','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 21, 2012 12:35:09 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200290 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 21, 2012 12:35:10 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',317,22,'Y','N','N',61999,'N','Y',200291,'N','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','U','Search key for the record in the format required - must be unique','Search Key',100,0,'Y',TO_DATE('2012-08-21 12:35:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-21 12:35:09','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 21, 2012 12:35:10 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200291 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 21, 2012 12:35:10 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',317,10,'Y','N','N',62002,'N','Y',200292,'N','Standard (plan) costs.','U','Standard Costs','Standard Cost',100,0,'Y',TO_DATE('2012-08-21 12:35:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-21 12:35:10','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 21, 2012 12:35:10 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200292 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 21, 2012 12:35:11 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',317,10,'Y','N','N',62003,'N','Y',200293,'N','Current cumulative amount for calculating the standard cost difference based on (actual) invoice price','U','Standard Cost Invoice Amount Sum (internal)','Std Cost Amount Sum',100,0,'Y',TO_DATE('2012-08-21 12:35:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-21 12:35:10','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 21, 2012 12:35:11 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200293 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=3751
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=3752
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=3753
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=3755
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=3812
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=3754
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=3758
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=6557
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=3756
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=3757
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200290
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200291
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200289
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200292
;

-- Aug 21, 2012 12:35:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200293
;

-- Aug 21, 2012 12:36:29 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-21 12:36:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200291
;

-- Aug 21, 2012 12:37:09 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-21 12:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200293
;

-- Aug 21, 2012 12:37:10 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET IsAllowCopy='N',Updated=TO_DATE('2012-08-21 12:37:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59831
;

-- Aug 21, 2012 12:37:37 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Tab SET DisplayLogic='@IsBOM@=''Y''',Updated=TO_DATE('2012-08-21 12:37:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=317
;

-- Aug 21, 2012 12:38:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2012-08-21 12:38:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3743
;

-- Aug 21, 2012 12:40:48 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',180,1,'Y','N','N',61997,'N',540,'Y',200294,'N','D','This product is manufactured','Manufactured',100,0,'Y',TO_DATE('2012-08-21 12:40:47','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-21 12:40:47','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 21, 2012 12:40:48 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200294 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 21, 2012 12:41:05 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',180,1,'Y','Y','N',200242,'N',550,'Y',200295,'N','Phantom Component are not stored and produced with the product. This is an option to avild maintaining an Engineering and Manufacturing Bill of Materials.','D','Phantom Component','Phantom',100,0,'Y',TO_DATE('2012-08-21 12:41:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-21 12:41:04','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 21, 2012 12:41:05 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200295 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 21, 2012 12:41:22 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',180,1,'Y','N','N',61996,'N',560,'Y',200296,'N','D','This part is Kanban controlled','Kanban controlled',100,0,'Y',TO_DATE('2012-08-21 12:41:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-21 12:41:21','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 21, 2012 12:41:22 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200296 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 21, 2012 12:41:43 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',180,10,'Y','N','N',61995,'N',570,'Y',200297,'N','D','Part Type',100,0,'Y',TO_DATE('2012-08-21 12:41:43','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-21 12:41:43','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 21, 2012 12:41:43 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200297 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200294
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=200295
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=200296
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=200297
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=7646
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=1319
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=1320
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=1321
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=1322
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=3743
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=3746
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=3747
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=3744
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=3745
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=1027
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=1028
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=1568
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y' WHERE AD_Field_ID=1569
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y' WHERE AD_Field_ID=5381
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y' WHERE AD_Field_ID=5383
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y' WHERE AD_Field_ID=9286
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=470,IsDisplayed='Y' WHERE AD_Field_ID=12418
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=480,IsDisplayed='Y' WHERE AD_Field_ID=5910
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y' WHERE AD_Field_ID=5911
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y' WHERE AD_Field_ID=6130
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=510,IsDisplayed='Y' WHERE AD_Field_ID=8307
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=520,IsDisplayed='Y' WHERE AD_Field_ID=6343
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=530,IsDisplayed='Y' WHERE AD_Field_ID=6344
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=540,IsDisplayed='Y' WHERE AD_Field_ID=8608
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=550,IsDisplayed='Y' WHERE AD_Field_ID=8613
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=560,IsDisplayed='Y' WHERE AD_Field_ID=52015
;

-- Aug 21, 2012 12:43:03 PM COT
-- IDEMPIERE-246 Integrate Manufacturing Light
UPDATE AD_Field SET SeqNo=570,IsDisplayed='Y' WHERE AD_Field_ID=52016
;

-- GardenWorld seed BOMs
INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200001, 11, 0, 'Y', TO_DATE('2003-01-21 20:05:55','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2009-02-17 17:20:59','YYYY-MM-DD HH24:MI:SS'), 100, 30, 145, 135, 1, '1 table, 4 Chairs and 1 Sun Screen', 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200002, 11, 0, 'Y', TO_DATE('2003-01-21 20:05:20','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2003-12-30 18:18:34','YYYY-MM-DD HH24:MI:SS'), 100, 10, 145, 134, 1, '1 table, 4 Chairs and 1 Sun Screen', 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200003, 11, 0, 'Y', TO_DATE('2003-01-21 20:05:46','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2003-12-30 18:19:08','YYYY-MM-DD HH24:MI:SS'), 100, 20, 145, 133, 4, '1 table, 4 Chairs and 1 Sun Screen', 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200004, 11, 0, 'Y', TO_DATE('2008-09-22 14:45:22','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 14:45:22','YYYY-MM-DD HH24:MI:SS'), 100, 10, 133, 50004, 1, 'Nice Chair for outdoors', 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200005, 11, 0, 'Y', TO_DATE('2008-09-22 14:46:01','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 14:46:01','YYYY-MM-DD HH24:MI:SS'), 100, 20, 133, 50005, 1, 'Nice Chair for outdoors', 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200006, 11, 0, 'Y', TO_DATE('2008-09-22 15:21:09','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 15:21:09','YYYY-MM-DD HH24:MI:SS'), 100, 30, 50001, 50003, 650, NULL, 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200007, 11, 0, 'Y', TO_DATE('2008-09-22 15:20:01','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 15:21:30','YYYY-MM-DD HH24:MI:SS'), 100, 20, 50001, 50002, 8, NULL, 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200008, 11, 0, 'Y', TO_DATE('2008-09-22 15:16:14','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 15:21:33','YYYY-MM-DD HH24:MI:SS'), 100, 10, 50001, 50015, 2, NULL, 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200009, 11, 0, 'Y', TO_DATE('2008-09-22 14:55:46','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 15:21:48','YYYY-MM-DD HH24:MI:SS'), 100, 10, 50000, 50016, 2, NULL, 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200010, 11, 0, 'Y', TO_DATE('2008-09-22 14:56:13','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 15:21:51','YYYY-MM-DD HH24:MI:SS'), 100, 20, 50000, 50002, 8, NULL, 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200011, 11, 0, 'Y', TO_DATE('2008-09-22 15:00:48','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 15:22:00','YYYY-MM-DD HH24:MI:SS'), 100, 30, 50000, 50003, 500, NULL, 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200012, 11, 0, 'Y', TO_DATE('2008-09-22 16:06:55','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 16:06:55','YYYY-MM-DD HH24:MI:SS'), 100, 20, 136, 50013, 1, '50 # Bag of Lawn Fertilizer', 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200013, 11, 0, 'Y', TO_DATE('2008-09-22 16:05:35','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 16:08:19','YYYY-MM-DD HH24:MI:SS'), 100, 10, 136, 50008, 50, '50 # Bag of Lawn Fertilizer', 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200014, 11, 0, 'Y', TO_DATE('2008-09-22 16:09:35','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 16:09:35','YYYY-MM-DD HH24:MI:SS'), 100, 10, 50007, 50008, 70, '70 # Bag of Lawn Fertilizer', 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200015, 11, 0, 'Y', TO_DATE('2008-09-22 16:10:47','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 16:10:47','YYYY-MM-DD HH24:MI:SS'), 100, 20, 50007, 50014, 1, '70 # Bag of Lawn Fertilizer', 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200016, 11, 0, 'Y', TO_DATE('2008-09-22 16:58:21','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 16:58:21','YYYY-MM-DD HH24:MI:SS'), 100, 10, 50008, 50010, 0, NULL, 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200017, 11, 0, 'Y', TO_DATE('2008-09-22 16:59:05','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 16:59:05','YYYY-MM-DD HH24:MI:SS'), 100, 20, 50008, 50009, 0, NULL, 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200018, 11, 0, 'Y', TO_DATE('2008-09-22 16:59:58','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 17:28:14','YYYY-MM-DD HH24:MI:SS'), 100, 30, 50008, 50012, 0, NULL, 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200019, 11, 0, 'Y', TO_DATE('2008-09-22 17:06:47','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2008-09-22 17:28:19','YYYY-MM-DD HH24:MI:SS'), 100, 40, 50008, 50017, 0, NULL, 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200020, 11, 0, 'Y', TO_DATE('2008-09-22 14:49:24','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2009-01-08 20:21:42','YYYY-MM-DD HH24:MI:SS'), 100, 30, 133, 50000, 1, 'Nice Chair for outdoors', 'P');

INSERT INTO m_product_bom(m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, bomtype)
  VALUES(200021, 11, 0, 'Y', TO_DATE('2008-09-22 14:50:11','YYYY-MM-DD HH24:MI:SS'), 100, TO_DATE('2009-01-08 20:21:45','YYYY-MM-DD HH24:MI:SS'), 100, 40, 133, 50001, 1, 'Nice Chair for outdoors', 'P');

-- in case BOMs are configured
INSERT 
INTO m_product_bom 
	(
		m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, bomqty, description, 
		bomtype
	)
SELECT nextidfunc(320, 'N'), l.ad_client_id, l.ad_org_id, l.isactive, l.created, l.createdby, l.updated, l.updatedby, l.line, b.m_product_id, l.m_product_id, l.qtybom, b.description,
cast(decode(l.componenttype,'OP','O','CO','P','PH','P','PK','P','VA',(case when l.feature in ('1','2','3','4','5','6','7','8','9') then cast(l.feature as char) else 'O' end),'P') as char)
from pp_product_bom b join pp_product_bomline l on b.pp_product_bom_id=l.pp_product_bom_id
where b.bomtype='A' and b.bomuse='M' and not exists (select 1 from m_product_bom b1 where b1.m_product_id=b.m_product_id and b1.m_productbom_id=l.m_product_id)
and b.pp_product_bom_id>999999;

update m_product set isphantom='Y' where m_product_id in (select m_product_id from pp_product_bomline where componenttype='PH');

UPDATE AD_System
  SET LastMigrationScriptApplied='884_IDEMPIERE-246.sql'
WHERE LastMigrationScriptApplied<'884_IDEMPIERE-246.sql'
   OR LastMigrationScriptApplied IS NULL
;
