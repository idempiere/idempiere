-- Feb 13, 2013 7:08:02 PM COT
--  
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Zoom Action',200144,'D','8ba56d3a-1fff-4e6c-b1a6-34cbe8a50071','ZoomLabel','Y',TO_TIMESTAMP('2013-02-13 19:08:01','YYYY-MM-DD HH24:MI:SS'),0,0,0,0,TO_TIMESTAMP('2013-02-13 19:08:01','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 13, 2013 7:08:02 PM COT
--  
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200144 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 13, 2013 7:25:37 PM COT
--  
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Setup Task:',200145,'D','ed196c88-09f4-40a7-8959-e6747b890420','Setup Task','Y',TO_TIMESTAMP('2013-02-13 19:25:37','YYYY-MM-DD HH24:MI:SS'),0,0,0,0,TO_TIMESTAMP('2013-02-13 19:25:37','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 13, 2013 7:25:37 PM COT
--  
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200145 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 13, 2013 7:28:34 PM COT
--  
UPDATE AD_Message SET Value='SetupTask',Updated=TO_TIMESTAMP('2013-02-13 19:28:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Message_ID=200145
;

SELECT register_migration_script('201302190934_IDEMPIERE-393.sql') FROM dual
;


