-- IDEMPIERE-3691 "Row" tooltip is not translated
-- Apr 17, 2018 9:04:04 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Row',0,0,'Y',TO_TIMESTAMP('2018-04-17 09:04:03','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2018-04-17 09:04:03','YYYY-MM-DD HH24:MI:SS'),0,200452,'Row','D','df5d9baf-0fd2-477c-aa27-da90069bbd07')
;

SELECT register_migration_script('201804170900_IDEMPIERE-3691.sql') FROM dual
;