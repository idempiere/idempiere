-- Nov 9, 2012 12:22:47 PM COT
-- IDEMPIERE-316 Inform when the user is not approver of a workflow doc
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Cannot Approve - No Approver',200111,'D','56d07e7f-7414-4e55-9083-1818e0a6c4f9','NoApprover','Y',TO_TIMESTAMP('2012-11-09 12:22:46','YYYY-MM-DD HH24:MI:SS'),0,0,0,0,TO_TIMESTAMP('2012-11-09 12:22:46','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 9, 2012 12:22:47 PM COT
-- IDEMPIERE-316 Inform when the user is not approver of a workflow doc
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200111 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201211091228_IDEMPIERE-316.sql') FROM dual
;

