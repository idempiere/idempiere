-- Dec 26, 2012 11:13:27 AM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','In order mark a column as a Key,the character ''K'' must be used in capital letter.',' ''K'' must be used in capital letter.',200131,'D','cbb24b89-0807-42c8-a027-98a4d87f0dc1','ColumnKey','Y',TO_DATE('2012-12-26 11:13:26','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-12-26 11:13:26','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 26, 2012 11:13:27 AM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200131 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Dec 26, 2012 11:15:03 AM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','There must be key columns in order to update or merge record(s).',200132,'D','805c64e8-6071-4bc9-821d-f52fe23ac1ad','NoKeyFound','Y',TO_DATE('2012-12-26 11:14:27','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-12-26 11:14:27','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 26, 2012 11:15:03 AM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200132 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Dec 26, 2012 11:15:51 AM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','More than one row has been found and this record cannot be inserted or updated',200133,'D','6386e48b-6055-4f65-87c9-dc42863526cd','TooManyRows','Y',TO_DATE('2012-12-26 11:15:51','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-12-26 11:15:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 26, 2012 11:15:51 AM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200133 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Dec 26, 2012 11:16:42 AM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Import Mode: ','Import Mode',200134,'D','753fad5d-5b0c-4ec0-8ba1-f748669e85c1','import.mode','Y',TO_DATE('2012-12-26 11:16:42','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-12-26 11:16:42','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 26, 2012 11:16:42 AM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200134 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201301161610_IDEMPIERE-454.sql') FROM dual
;

