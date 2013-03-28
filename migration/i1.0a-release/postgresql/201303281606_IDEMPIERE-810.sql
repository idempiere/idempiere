-- Mar 19, 2013 2:48:21 PM COT
-- Mar 19, 2013 2:48:21 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Import ZIP',200156,'D','2f5186f7-44bf-4e1f-a7b7-a4061809eeae','ImportZIP','Y',TO_TIMESTAMP('2013-03-19 14:48:20','YYYY-MM-DD HH24:MI:SS'),0,0,0,0,TO_TIMESTAMP('2013-03-19 14:48:20','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 19, 2013 2:48:21 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200156 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201303281606_IDEMPIERE-810.sql') FROM dual
;

