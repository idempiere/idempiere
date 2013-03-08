-- Mar 7, 2013 8:21:59 PM MYT
-- IDEMPIERE-704 The Min. value and Max. value validation of column is not working
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Entered value is more than the maximum ({0}) allowed',200150,'D','af92320e-f5a9-4dee-a1d4-3bfa8bbf3dbd','MoreThanMaxValue','Y',TO_DATE('2013-03-07 20:21:57','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2013-03-07 20:21:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 7, 2013 8:21:59 PM MYT
-- IDEMPIERE-704 The Min. value and Max. value validation of column is not working
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200150 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Mar 7, 2013 8:22:22 PM MYT
-- IDEMPIERE-704 The Min. value and Max. value validation of column is not working
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Entered value is less than the minimum ({0}) required',200151,'D','4402e2b3-803e-4bd2-b77c-86059fe10346','LessThanMinValue','Y',TO_DATE('2013-03-07 20:22:21','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2013-03-07 20:22:21','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 7, 2013 8:22:22 PM MYT
-- IDEMPIERE-704 The Min. value and Max. value validation of column is not working
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200151 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201303071224_IDEMPIERE-704.sql') FROM dual
;

