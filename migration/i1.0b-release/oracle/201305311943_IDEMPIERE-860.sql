-- May 31, 2013 7:34:01 PM SGT
-- IDEMPIERE-860 Review Payment Processors
UPDATE AD_Column SET ReadOnlyLogic='@CustomerPaymentProfileID@!''''',Updated=TO_DATE('2013-05-31 19:34:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5240
;

-- May 31, 2013 7:34:10 PM SGT
-- IDEMPIERE-860 Review Payment Processors
UPDATE AD_Column SET ReadOnlyLogic='@CustomerPaymentProfileID@!''''',Updated=TO_DATE('2013-05-31 19:34:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5239
;

-- May 31, 2013 7:34:17 PM SGT
-- IDEMPIERE-860 Review Payment Processors
UPDATE AD_Column SET ReadOnlyLogic='@CustomerPaymentProfileID@!''''',Updated=TO_DATE('2013-05-31 19:34:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5232
;

-- May 31, 2013 7:35:47 PM SGT
-- IDEMPIERE-860 Review Payment Processors
INSERT INTO AD_Message (AD_Client_ID,EntityType,MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created) VALUES (0,'D','E','Inactive payment processor',200176,'e9638795-bd2f-405b-b3cb-567036b3871d','InactivePaymentProcessor','Y',TO_DATE('2013-05-31 19:35:45','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-05-31 19:35:45','YYYY-MM-DD HH24:MI:SS'))
;

-- May 31, 2013 7:35:47 PM SGT
-- IDEMPIERE-860 Review Payment Processors
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200176 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201305311943_IDEMPIERE-860.sql') FROM dual
;