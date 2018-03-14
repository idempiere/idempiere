SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2757 Key for M_Storage wrongly defined on dictionary
-- Aug 13, 2015 5:54:15 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203834,'M_Warehouse_UU',177,60958,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 17:54:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 17:54:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f8ba8ff7-14a1-4eb4-a68d-708095cfc0e9','N',2)
;

-- Aug 13, 2015 5:55:21 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203835,'M_Storage_UU',179,60954,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 17:55:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 17:55:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','89dd5676-731e-4d60-868a-8c710e9e280d','N',2)
;

-- Aug 13, 2015 5:55:21 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203836,'Date  Material Policy','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy',179,210887,'Y',7,110,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 17:55:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 17:55:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b93cc4d5-e6a6-4a15-acc4-393d54520736','Y',110,2)
;

-- Aug 13, 2015 5:58:03 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_DATE('2015-08-13 17:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203836
;

-- Aug 13, 2015 5:58:03 PM COT
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2015-08-13 17:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1011
;

-- Aug 13, 2015 5:58:03 PM COT
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2015-08-13 17:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6529
;

-- Aug 13, 2015 5:58:03 PM COT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2015-08-13 17:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1009
;

-- Aug 13, 2015 5:58:03 PM COT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2015-08-13 17:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1013
;

-- Aug 13, 2015 5:58:03 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=4,Updated=TO_DATE('2015-08-13 17:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3078
;

-- Aug 13, 2015 5:58:03 PM COT
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2015-08-13 17:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1014
;

-- Aug 13, 2015 5:58:03 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=4,Updated=TO_DATE('2015-08-13 17:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3282
;

-- Aug 13, 2015 5:58:03 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2015-08-13 17:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203835
;

-- Aug 13, 2015 5:59:19 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_DATE('2015-08-13 17:59:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202534
;

-- Aug 13, 2015 5:59:19 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=1,Updated=TO_DATE('2015-08-13 17:59:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57394
;

-- Aug 13, 2015 5:59:19 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=4,Updated=TO_DATE('2015-08-13 17:59:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57391
;

-- Aug 13, 2015 5:59:19 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=2,Updated=TO_DATE('2015-08-13 17:59:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57390
;

-- Aug 13, 2015 5:59:19 PM COT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2015-08-13 17:59:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57395
;

-- Aug 13, 2015 5:59:19 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=4,Updated=TO_DATE('2015-08-13 17:59:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57393
;

SELECT register_migration_script('201508131800_IDEMPIERE-2757.sql') FROM dual
;

