-- Jul 29, 2013 5:05:15 PM MYT
-- IDEMPIERE-1207 Fixed inconsistent error message for well known database exception
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','The database operation timed out. Please try again later.',200217,'D','bfc4529a-0ec2-4e8b-92d4-f86ca829cd4d','DatabaseOperationTimeout','Y',TO_TIMESTAMP('2013-07-29 17:05:02','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-29 17:05:02','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 29, 2013 5:05:15 PM MYT
-- IDEMPIERE-1207 Fixed inconsistent error message for well known database exception
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200217 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201307290906_IDEMPIERE-1207.sql') FROM dual
;

