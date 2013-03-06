-- Mar 7, 2013 12:06:48 AM MYT
-- IDEMPIERE-698 AssetInvoiceWithMixedLines_LRO not translated
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Invoice contains products of both Fixed and Non-Fixed Assets, cannot complete',200149,'D','991f5978-2922-4fc2-a6bb-151ed6b7aeaf','AssetInvoiceWithMixedLines','Y',TO_DATE('2013-03-07 00:06:47','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2013-03-07 00:06:47','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 7, 2013 12:06:48 AM MYT
-- IDEMPIERE-698 AssetInvoiceWithMixedLines_LRO not translated
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200149 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201303062333_IDEMPIERE-698.sql') FROM dual
;

