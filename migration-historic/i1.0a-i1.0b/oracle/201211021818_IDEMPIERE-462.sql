-- Nov 2, 2012 12:05:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=1,Updated=TO_DATE('2012-11-02 12:05:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3112
;

-- Nov 2, 2012 12:06:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=1,Updated=TO_DATE('2012-11-02 12:06:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3353
;

-- Nov 2, 2012 12:07:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=1,Updated=TO_DATE('2012-11-02 12:07:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3466
;

-- Nov 2, 2012 12:10:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsCentrallyMaintained='N', Name='Void It',Updated=TO_DATE('2012-11-02 12:10:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200723
;

-- Nov 2, 2012 12:10:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200723
;

-- Nov 2, 2012 12:10:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y & @IsVoided@=N & @TrxType@=A & @IsDelayedCapture@=N',Updated=TO_DATE('2012-11-02 12:10:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200723
;

-- Nov 2, 2012 12:20:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2012-11-02 12:20:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4363
;

-- Nov 2, 2012 12:21:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2012-11-02 12:21:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4039
;

-- Nov 2, 2012 12:21:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2012-11-02 12:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200631
;

-- Nov 2, 2012 4:17:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET FieldLength=100,Updated=TO_DATE('2012-11-02 16:17:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5058
;

-- Nov 2, 2012 4:17:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
ALTER TABLE C_PaymentProcessor MODIFY UserID NVARCHAR2(100)
;

-- Nov 2, 2012 4:18:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
ALTER TABLE C_PaymentProcessor MODIFY UserID NOT NULL
;

-- Nov 2, 2012 5:28:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Payment transaction already voided',200101,'D','43caa6c4-8db6-4606-8b77-e11aa7eabc8a','PaymentTransactionAlreadyVoided','Y',TO_DATE('2012-11-02 17:28:46','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-02 17:28:46','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 2, 2012 5:28:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200101 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 2, 2012 5:29:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Payment transaction already delayed capture',200102,'D','b1bb0315-ef50-4e89-85ff-a2f621ba5f79','PaymentTransactionAlreadyDelayedCapture','Y',TO_DATE('2012-11-02 17:29:20','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-02 17:29:20','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 2, 2012 5:29:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200102 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 2, 2012 5:29:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Message SET MsgType='E',Updated=TO_DATE('2012-11-02 17:29:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200102
;

-- Nov 2, 2012 5:32:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Payment already voided',200103,'D','4efe0c4f-01c3-42bd-a31d-6308d707ba5c','PaymentAlreadyVoided','Y',TO_DATE('2012-11-02 17:32:34','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-02 17:32:34','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 2, 2012 5:32:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200103 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 2, 2012 5:32:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Payment already delayed capture',200104,'D','829af1a2-0405-4110-857a-0562e70aff65','PaymentAlreadyDelayedCapture','Y',TO_DATE('2012-11-02 17:32:57','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-02 17:32:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 2, 2012 5:32:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200104 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 2, 2012 5:33:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Payment already processed',200105,'D','43f80a23-6132-4c19-94bf-a68b6d83f2cb','PaymentAlreadyProcessed','Y',TO_DATE('2012-11-02 17:33:46','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-02 17:33:46','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 2, 2012 5:33:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200105 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 2, 2012 5:34:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Payment transaction already processed',200106,'D','a801e1b6-22c7-47e1-bf5b-6a1581020a26','PaymentTransactionAlreadyProcessed','Y',TO_DATE('2012-11-02 17:34:26','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-02 17:34:26','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 2, 2012 5:34:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200106 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 2, 2012 5:38:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','No payment processor model',200107,'D','b4ed0747-80a0-45c1-b649-86543edc51cb','PaymentNoProcessorModel','Y',TO_DATE('2012-11-02 17:38:51','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-02 17:38:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 2, 2012 5:38:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200107 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 2, 2012 5:42:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Failed to delay capture authorization payment',200108,'D','257c739d-b91e-4699-9be9-57f2bea8b6bc','DelayCaptureAuthFailed','Y',TO_DATE('2012-11-02 17:42:46','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-02 17:42:46','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 2, 2012 5:42:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200108 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 2, 2012 5:43:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Failed to create a new sales payment',200109,'D','869ad1e8-db99-4b8b-b2f8-99fd3aba2005','CreateNewSalesPaymentFailed','Y',TO_DATE('2012-11-02 17:43:57','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-02 17:43:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 2, 2012 5:43:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200109 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 2, 2012 5:44:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Failed to void authorization payment',200110,'D','105415b3-d640-4c6f-9aad-41234162e640','VoidAuthorizationPaymentFailed','Y',TO_DATE('2012-11-02 17:44:39','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-02 17:44:39','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 2, 2012 5:44:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200110 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201211021818_IDEMPIERE-462.sql') FROM dual
;