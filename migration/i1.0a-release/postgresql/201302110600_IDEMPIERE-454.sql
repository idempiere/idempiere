-- Feb 11, 2013 5:42:41 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Table name {0} does not correspond to the parent''s table name {1}',200146,'D','18535f25-f9d7-47c0-9c21-de68afa04444','DiffTableName','Y',TO_TIMESTAMP('2013-02-11 17:42:40','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2013-02-11 17:42:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 11, 2013 5:42:41 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200146 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 11, 2013 5:43:20 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Record not processed, due to master record failure',200147,'D','ffc51041-2111-4944-9ac5-35d7688194ef','NotProcessed','Y',TO_TIMESTAMP('2013-02-11 17:43:20','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2013-02-11 17:43:20','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 11, 2013 5:43:20 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200147 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 11, 2013 5:45:35 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Different parent value: Master value {0} Detail value {1}',200148,'D','3516b3e0-6f8c-458d-af58-b6e22e6f0156','DiffParentValue','Y',TO_TIMESTAMP('2013-02-11 17:45:35','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2013-02-11 17:45:35','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 11, 2013 5:45:35 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200148 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Mar 11, 2013 3:58:04 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Csv file must not contain ''>'' in header record {0}. ',200152,'D','1d9054fa-48d7-4e65-b74a-3164eaa156b8','WrongHeader','Y',TO_TIMESTAMP('2013-03-11 15:58:02','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2013-03-11 15:58:02','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 11, 2013 3:58:04 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200152 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Mar 11, 2013 3:59:21 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','No child tab was found with such table {0}. ',200153,'D','027a1bdf-7b45-4afc-93c5-a6113b5f1acb','NoChildTab','Y',TO_TIMESTAMP('2013-03-11 15:59:20','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2013-03-11 15:59:20','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 11, 2013 3:59:21 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200153 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Mar 11, 2013 4:04:53 PM COT
-- IDEMPIERE-454 Easy import
UPDATE C_AcctProcessor SET DateNextRun=TO_TIMESTAMP('2013-03-11 16:14:53','YYYY-MM-DD HH24:MI:SS'), DateLastRun=TO_TIMESTAMP('2013-03-11 16:04:53','YYYY-MM-DD HH24:MI:SS'),Updated=TO_TIMESTAMP('2013-03-11 16:04:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_AcctProcessor_ID=100
;

-- Mar 11, 2013 4:10:39 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Wrong detail name{0}, it must contain the character ''>'':{1} ',200154,'D','b82cafbc-f6d0-4002-b358-a4a9783f77c2','WrongDetailName','Y',TO_TIMESTAMP('2013-03-11 16:10:38','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2013-03-11 16:10:38','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 11, 2013 4:10:39 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200154 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Mar 11, 2013 4:12:48 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Parent value cannot be deleted {0}!',200155,'D','31e87e31-75b2-4555-8251-5d5d7dfe7ada','NoParentDelete','Y',TO_TIMESTAMP('2013-03-11 16:12:47','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2013-03-11 16:12:47','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 11, 2013 4:12:48 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200155 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201302110600_IDEMPIERE-454.sql') FROM dual
;

