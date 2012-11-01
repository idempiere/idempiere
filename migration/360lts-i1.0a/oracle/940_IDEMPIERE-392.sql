-- Oct 19, 2012 4:08:01 PM SGT
-- IDEMPIERE-392 Redesign payment button
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Failed to create payment',200077,'D','da079a31-b0e8-4e39-8d06-5861235240cd','PaymentNotCreated','Y',TO_DATE('2012-10-19 16:08:00','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-19 16:08:00','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 19, 2012 4:08:05 PM SGT
-- IDEMPIERE-392 Redesign payment button
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200077 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 19, 2012 4:08:20 PM SGT
-- IDEMPIERE-392 Redesign payment button
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Failed to cancel payment',200078,'D','147fef6f-7a60-4579-9b20-2bcb1836cbbb','PaymentNotCancelled','Y',TO_DATE('2012-10-19 16:08:20','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-19 16:08:20','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 19, 2012 4:08:20 PM SGT
-- IDEMPIERE-392 Redesign payment button
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200078 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 19, 2012 4:09:32 PM SGT
-- IDEMPIERE-392 Redesign payment button
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Failed to create cash',200079,'D','2a395bb4-e2cc-4c5c-ad6c-e5d96bb8b16e','CashNotCancelled','Y',TO_DATE('2012-10-19 16:09:31','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-19 16:09:31','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 19, 2012 4:09:32 PM SGT
-- IDEMPIERE-392 Redesign payment button
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200079 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 19, 2012 4:09:57 PM SGT
-- IDEMPIERE-392 Redesign payment button
UPDATE AD_Message SET MsgText='Failed to cancel cash',Updated=TO_DATE('2012-10-19 16:09:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200079
;

-- Oct 19, 2012 4:09:57 PM SGT
-- IDEMPIERE-392 Redesign payment button
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200079
;

-- Oct 19, 2012 4:10:18 PM SGT
-- IDEMPIERE-392 Redesign payment button
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Failed to create cash',200080,'D','9a1b19b9-03a4-4a94-a4be-3c330e6ef800','CashNotCreated','Y',TO_DATE('2012-10-19 16:10:18','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-19 16:10:18','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 19, 2012 4:10:18 PM SGT
-- IDEMPIERE-392 Redesign payment button
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200080 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 19, 2012 4:10:55 PM SGT
-- IDEMPIERE-392 Redesign payment button
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Card not processed',200081,'D','743abddc-b21d-4317-b959-9e7dba185313','CardNotProcessed','Y',TO_DATE('2012-10-19 16:10:55','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-19 16:10:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 19, 2012 4:10:55 PM SGT
-- IDEMPIERE-392 Redesign payment button
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200081 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('940_IDEMPIERE-392.sql') FROM dual
;