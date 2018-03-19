-- Aug 12, 2014 9:41:46 AM CEST
-- IDEMPIERE-2134 Issues found on Payment Selection process
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID,Updated) VALUES ('I','This process creates and complete payments automatically, do you want to print and at the same time create/complete payments?',200306,'D','e623e783-7b0d-4882-9ea6-0f04c30880ca','CreatePayments?','Y',100,100,TO_TIMESTAMP('2014-08-12 09:41:45','YYYY-MM-DD HH24:MI:SS'),0,0,TO_TIMESTAMP('2014-08-12 09:41:45','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 12, 2014 9:47:55 AM CEST
UPDATE AD_Message SET MsgText='Is the payment print correct ?   If answered yes, then it will create and complete payments.',Updated=TO_TIMESTAMP('2014-08-12 09:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=585
;

SELECT register_migration_script('201408120942_IDEMPIERE-2134.sql') FROM dual
;

