-- Jan 20, 2016 2:26:58 PM CET
-- IDEMPIERE-2954
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200393,'0e4f4eec-17f8-478e-a598-ed833bf5493c',0,TO_TIMESTAMP('2016-01-20 14:26:57','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','Could not convert currency {0} to base currency {1}','I',TO_TIMESTAMP('2016-01-20 14:26:57','YYYY-MM-DD HH24:MI:SS'),0,'ErrorConvertingCurrencyToProjectCurrency')
;

UPDATE AD_Message SET MsgText='Could not convert currency {0} to base currency {1} - converstion type : {2} / Date : {3}',Updated=TO_TIMESTAMP('2016-01-20 15:34:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Message_ID=200393
;

-- Jan 20, 2016 3:34:28 PM CET
UPDATE AD_Message SET MsgText='Could not convert currency {0} to project currency {1} - converstion type : {2} / Date : {3}',Updated=TO_TIMESTAMP('2016-01-20 15:34:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Message_ID=200393
;

-- Jan 20, 2016 3:34:38 PM CET
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200394,'64dd01ce-7afb-4db6-8641-bd80f7248ecd',0,TO_TIMESTAMP('2016-01-20 15:34:37','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','Could not convert currency {0} to base currency {1} - converstion type : {2} / Date : {3}','I',TO_TIMESTAMP('2016-01-20 15:34:37','YYYY-MM-DD HH24:MI:SS'),0,'ErrorConvertingCurrencyToBaseCurrency')
;

-- Jan 20, 2016 3:35:50 PM CET
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200395,'66d383a0-ad94-435c-ac96-f03903fcda59',0,TO_TIMESTAMP('2016-01-20 15:35:50','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','Could not convert allocation currency {0} to base currency {1} - conversion type : {2} / conversion date : {3}','I',TO_TIMESTAMP('2016-01-20 15:35:50','YYYY-MM-DD HH24:MI:SS'),0,'ErrorConvertingAllocationCurrencyToBaseCurrency')
;

-- Jan 20, 2016 3:36:05 PM CET
UPDATE AD_Message SET EntityType='D', MsgText='Could not convert currency {0} to base currency {1} - conversion type : {2} / conversion date : {3}',Updated=TO_TIMESTAMP('2016-01-20 15:36:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Message_ID=200394
;

-- Jan 20, 2016 3:36:15 PM CET
UPDATE AD_Message SET MsgText='Could not convert currency {0} to project currency {1} - conversion type : {2} / conversion date : {3}',Updated=TO_TIMESTAMP('2016-01-20 15:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Message_ID=200393
;

-- Jan 20, 2016 3:36:20 PM CET
UPDATE AD_Message SET EntityType='D',Updated=TO_TIMESTAMP('2016-01-20 15:36:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Message_ID=200395
;

-- Jan 20, 2016 3:36:59 PM CET
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200396,'449bfa95-a175-4862-98c2-525c6a564c60',0,TO_TIMESTAMP('2016-01-20 15:36:59','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','Could not convert invoice currency {0} to base currency {1} - conversion type : {2} / conversion date : {3}','I',TO_TIMESTAMP('2016-01-20 15:36:59','YYYY-MM-DD HH24:MI:SS'),0,'ErrorConvertingInvoiceCurrencyToBaseCurrency')
;

-- Jan 20, 2016 4:47:30 PM CET
UPDATE AD_Message SET MsgText='Could not convert currency {0} to base currency {1} - conversion type : {2} / conversion date : {3,date,short}',Updated=TO_TIMESTAMP('2016-01-20 16:47:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200394
;

-- Jan 20, 2016 4:47:33 PM CET
UPDATE AD_Message SET MsgText='Could not convert currency {0} to project currency {1} - conversion type : {2} / conversion date : {3,date,short}',Updated=TO_TIMESTAMP('2016-01-20 16:47:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200393
;

-- Jan 20, 2016 4:47:37 PM CET
UPDATE AD_Message SET MsgText='Could not convert invoice currency {0} to base currency {1} - conversion type : {2} / conversion date : {3,date,short}',Updated=TO_TIMESTAMP('2016-01-20 16:47:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200396
;

SELECT register_migration_script('201601201427_IDEMPIERE-2954.sql') FROM dual
;
