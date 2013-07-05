-- 4/07/2013 06:07:52 PM COT
-- IDEMPIERE-1133 Customize grid not translated
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('I','Save Column Width',200186,'e55bb769-5507-483c-bfd4-c938c5c5d93f','SaveColumnWidth','Y',TO_TIMESTAMP('2013-07-04 18:07:52','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-04 18:07:52','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- 4/07/2013 06:07:52 PM COT
-- IDEMPIERE-1133 Customize grid not translated
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200186 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201307041818_IDEMPIERE-1133.sql') FROM dual
;

