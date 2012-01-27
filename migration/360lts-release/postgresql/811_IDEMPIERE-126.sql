-- Jan 27, 2012 9:43:02 AM COT
-- IDEMPIERE-126 Add unprocessed documents
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,Value,IsActive,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,Created,UpdatedBy) VALUES ('M','Unprocessed Documents',200000,'D','UnprocessedDocs','Y',TO_TIMESTAMP('2012-01-27 09:43:01','YYYY-MM-DD HH24:MI:SS'),0,0,100,TO_TIMESTAMP('2012-01-27 09:43:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 9:43:02 AM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200000 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jan 27, 2012 9:43:12 AM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='Documentos sin Procesar',Updated=TO_TIMESTAMP('2012-01-27 09:43:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200000 AND AD_Language LIKE 'es_%'
;

