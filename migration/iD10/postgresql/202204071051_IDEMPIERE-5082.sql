-- IDEMPIERE-5082 Drop Shipment: Pass shipper and tracking number from MR to Customer Shipment
SELECT register_migration_script('202204071051_IDEMPIERE-5082.sql') FROM dual;

-- Apr 7, 2022, 10:51:05 AM MYT
UPDATE AD_Field SET DisplayLogic='@MovementType@=''C-'' |@IsDropShip@=''Y''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 10:51:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3495
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=55426
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=55427
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=55425
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=55428
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=6882
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=4248
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=4249
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=7804
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=7802
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=7803
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=7805
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=7801
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=7800
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3482
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10347
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=9236
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=9235
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3505
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3506
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10531
;

-- Apr 7, 2022, 10:53:06 AM MYT
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=5146
;

-- Apr 7, 2022, 10:55:15 AM MYT
UPDATE AD_Field SET DisplayLogic='@IsDropShip@=''Y''&@DeliveryViaRule@=''Y''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='Y', SeqNoGrid=290, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 10:55:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6882
;

-- Apr 7, 2022, 10:56:51 AM MYT
UPDATE AD_Field SET DisplayLogic='@IsDropShip@=''Y''&@DeliveryViaRule@=''S''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 10:56:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6882
;

-- Apr 7, 2022, 10:57:20 AM MYT
UPDATE AD_Field SET DisplayLogic='@DeliveryViaRule@=''S'' &@IsDropShip@=''Y''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 10:57:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3504
;

