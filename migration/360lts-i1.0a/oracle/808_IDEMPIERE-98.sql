-- Nov 22, 2011 8:15:34 PM COT
-- IDEMPIERE-98 Implement void for completed RMAs
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,Value,IsActive,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,Created,UpdatedBy) VALUES ('E','This RMA cannot be voided because it has associated returns, please void the returns first',53161,'D','RMACannotBeVoided','Y',TO_DATE('2011-11-22 20:15:33','YYYY-MM-DD HH24:MI:SS'),0,0,100,TO_DATE('2011-11-22 20:15:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Nov 22, 2011 8:15:34 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=53161 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 22, 2011 8:16:43 PM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='Esta autorización no puede anularse porque tiene devoluciones asociadas, por favor anular primero las devoluciones',Updated=TO_DATE('2011-11-22 20:16:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53161 AND AD_Language='es_CO'
;

