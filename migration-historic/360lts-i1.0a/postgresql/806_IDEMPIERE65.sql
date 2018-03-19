SET CLIENT_ENCODING TO 'UTF8';

-- Sep 23, 2011 6:53:12 PM COT
-- IDEMPIERE-65 - Implement conversations on chat window
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,Value,IsActive,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,Created,UpdatedBy) VALUES ('I','Add',53148,'D','Add','Y',TO_TIMESTAMP('2011-09-23 18:53:11','YYYY-MM-DD HH24:MI:SS'),0,0,100,TO_TIMESTAMP('2011-09-23 18:53:11','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 23, 2011 6:53:12 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=53148 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 23, 2011 6:54:06 PM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='Añadir',Updated=TO_TIMESTAMP('2011-09-23 18:54:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53148 AND AD_Language LIKE 'es%'
;

-- Sep 23, 2011 6:54:37 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,Value,IsActive,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,Created,UpdatedBy) VALUES ('I','Reply',53149,'D','Reply','Y',TO_TIMESTAMP('2011-09-23 18:54:35','YYYY-MM-DD HH24:MI:SS'),0,0,100,TO_TIMESTAMP('2011-09-23 18:54:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 23, 2011 6:54:37 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=53149 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 23, 2011 6:55:58 PM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='Responder',Updated=TO_TIMESTAMP('2011-09-23 18:55:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53149 AND AD_Language LIKE 'es%'
;

