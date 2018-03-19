-- Jan 24, 2013 12:10:51 PM CET
-- IDEMPIERE 90
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,Description,EntityType,Help,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202202,'7d389ba2-a5c9-4a9f-a93c-a42588b6e62d',0,'IsShortList',TO_TIMESTAMP('2013-01-24 12:10:49','YYYY-MM-DD HH24:MI:SS'),100,'This record is in the short list','D','The most used records could be set into the short list in order to be selected faster','Y','Short list','Short list',TO_TIMESTAMP('2013-01-24 12:10:49','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 24, 2013 12:10:51 PM CET
-- IDEMPIERE 90
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202202 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 24, 2013 12:11:24 PM CET
-- IDEMPIERE 90
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200136,'a8e26155-174f-4fdb-b575-ba4bd3fe0523',0,TO_TIMESTAMP('2013-01-24 12:11:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','All records','I',TO_TIMESTAMP('2013-01-24 12:11:23','YYYY-MM-DD HH24:MI:SS'),100,'ShortListListAllItems')
;

-- Jan 24, 2013 12:11:24 PM CET
-- IDEMPIERE 90
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200136 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jan 24, 2013 12:11:32 PM CET
-- IDEMPIERE 90
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200137,'eb83b9c3-95c6-4324-870b-975965aa033f',0,TO_TIMESTAMP('2013-01-24 12:11:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Short list items','I',TO_TIMESTAMP('2013-01-24 12:11:32','YYYY-MM-DD HH24:MI:SS'),100,'ShortListShortListItems')
;

-- Jan 24, 2013 12:11:32 PM CET
-- IDEMPIERE 90
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200137 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jan 24, 2013 12:11:41 PM CET
-- IDEMPIERE 90
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200138,'ac962f08-3465-4be3-b330-ba0b4e8e388f',0,TO_TIMESTAMP('2013-01-24 12:11:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Short list / All','I',TO_TIMESTAMP('2013-01-24 12:11:40','YYYY-MM-DD HH24:MI:SS'),100,'ShortListSwitchSearchMode')
;

-- Jan 24, 2013 12:11:41 PM CET
-- IDEMPIERE 90
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200138 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('2013012430719_IDEMPIERE-90.sql') FROM dual
;

