-- Jun 21, 2013 6:13:10 PM COT
-- IDEMPIERE-966  When Order document(Both PO and SO) close, I think that MOrder.closeIt() method should calculate tax again. 
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','Error calculating tax',200185,'D','1618f1de-2741-4c84-953d-667cc833b977','Error calculating tax','Y',TO_DATE('2013-06-21 18:13:09','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-06-21 18:13:09','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jun 21, 2013 6:13:11 PM COT
-- IDEMPIERE-966  When Order document(Both PO and SO) close, I think that MOrder.closeIt() method should calculate tax again. 
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200185 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;


SELECT register_migration_script('20130621183000_IDEMPIERE-966.sql') FROM dual
;
