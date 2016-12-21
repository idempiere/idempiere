-- Jul 15, 2016 6:12:46 PM MYT
-- 1006181 Speed-up windows - Field to show read-only grid
UPDATE AD_Field SET Included_Tab_ID = NULL WHERE Included_Tab_ID IS NOT NULL
;

INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,AD_Org_ID,ValidationType,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType) VALUES (200127,'Single Selection Grid','ce2bb5f1-efab-44ba-b5b7-7308a509c39c','N',0,'D',TO_TIMESTAMP('2016-07-15 18:12:40','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_TIMESTAMP('2016-07-15 18:12:40','YYYY-MM-DD HH24:MI:SS'),'D')
;

-- Jul 15, 2016 6:13:13 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,AD_Org_ID,ValidationType,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType) VALUES (200128,'Multiple Selection Grid','ca6d9bef-47eb-4278-a11f-20a8a99257cd','N',0,'D',TO_TIMESTAMP('2016-07-15 18:13:13','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_TIMESTAMP('2016-07-15 18:13:13','YYYY-MM-DD HH24:MI:SS'),'D')
;

-- Jul 15, 2016 6:24:20 PM MYT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=6432
;

-- Jul 15, 2016 6:24:20 PM MYT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=132
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200276
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200771
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=924
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=133
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=137
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200274
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=138
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=202362
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=142
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=8343
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=140
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=202341
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=141
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=204213
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=204214
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Jul 15, 2016 6:24:21 PM MYT
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Jul 15, 2016 6:24:22 PM MYT
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Jul 15, 2016 6:24:22 PM MYT
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Jul 15, 2016 6:24:22 PM MYT
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Jul 15, 2016 6:24:22 PM MYT
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Jul 15, 2016 6:24:22 PM MYT
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Jul 15, 2016 6:24:22 PM MYT
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Jul 15, 2016 6:24:22 PM MYT
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Jul 15, 2016 6:24:22 PM MYT
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Jul 15, 2016 6:24:22 PM MYT
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Jul 15, 2016 6:24:22 PM MYT
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=139
;

-- Jul 15, 2016 6:27:18 PM MYT
UPDATE AD_Field SET DisplayLogic='@AD_Column_ID.AD_Reference_ID@=200127|@AD_Column_ID.AD_Reference_ID@=200128', IsActive='Y', SeqNoGrid=120,Updated=TO_TIMESTAMP('2016-07-15 18:27:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6432
;

SELECT register_migration_script('201607191600_Ticket_1006181.sql') FROM dual
;

