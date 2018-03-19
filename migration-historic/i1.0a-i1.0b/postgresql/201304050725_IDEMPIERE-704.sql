-- Apr 5, 2013 3:20:49 PM MYT
-- IDEMPIERE-704 The Min. value and Max. value validation of column is not working
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Maximum value must be greater than or equal to minimum value.',200170,'D','3b17f511-d109-4e5a-9d22-3bd81699c4b4','MaxLessThanMin','Y',TO_TIMESTAMP('2013-04-05 15:20:48','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2013-04-05 15:20:48','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 5, 2013 3:20:50 PM MYT
-- IDEMPIERE-704 The Min. value and Max. value validation of column is not working
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200170 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201304050725_IDEMPIERE-704.sql') FROM dual
;

