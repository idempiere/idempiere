-- Aug 22, 2013 7:13:56 PM COT
-- IDEMPIERE-1157 Adding functionality to add charts on the standard windows
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200142,'Table AD_Chart','AD_Chart',1,'ebc24c0c-e7bf-4f4c-a2bd-d1170ef873d6',0,TO_DATE('2013-08-22 19:13:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-22 19:13:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Aug 22, 2013 7:13:56 PM COT
UPDATE AD_Sequence s SET Name = (SELECT TableName FROM AD_Table t WHERE t.IsView='N' AND UPPER(s.Name)=UPPER(t.TableName)) WHERE s.IsTableID='Y' AND EXISTS (SELECT * FROM AD_Table t WHERE t.IsActive='Y' AND t.IsView='N' AND UPPER(s.Name)=UPPER(t.TableName) AND s.Name<>t.TableName)
;

-- Aug 22, 2013 7:16:35 PM COT
UPDATE AD_Field SET SeqNo=10, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:16:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59599
;

-- Aug 22, 2013 7:16:35 PM COT
UPDATE AD_Field SET SeqNo=20, IsDisplayed='Y', IsAllowCopy='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:16:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59602
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=30, ColumnSpan=5,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59601
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=40, ColumnSpan=5,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59600
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=50, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59598
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59603
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59673
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=80, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59674
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=90, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59679
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59680
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=110, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59676
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=120, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59677
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=130, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59675
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=5,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59596
;

-- Aug 22, 2013 7:16:36 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2013-08-22 19:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59597
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=10, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59608
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=20, IsDisplayed='Y', IsAllowCopy='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59614
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=30, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59606
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=40, ColumnSpan=5,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59613
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=50, ColumnSpan=5,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59610
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=60, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59611
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=70, ColumnSpan=5, NumLines=3,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59615
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=80, ColumnSpan=5, NumLines=3,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59616
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202285
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=100, ColumnSpan=5,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59605
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=110, ColumnSpan=5,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59609
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=120, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59678
;

-- Aug 22, 2013 7:17:55 PM COT
UPDATE AD_Field SET SeqNo=130, ColumnSpan=5,Updated=TO_DATE('2013-08-22 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59618
;

-- Aug 22, 2013 7:17:56 PM COT
UPDATE AD_Field SET SeqNo=140, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:17:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59617
;

-- Aug 22, 2013 7:17:56 PM COT
UPDATE AD_Field SET SeqNo=150, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-08-22 19:17:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59612
;

-- Aug 22, 2013 7:17:56 PM COT
UPDATE AD_Field SET SeqNo=160, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-08-22 19:17:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59604
;

-- Aug 22, 2013 7:17:56 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2013-08-22 19:17:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59607
;

SELECT register_migration_script('201308221919_IDEMPIERE-1157.sql') FROM dual
;

