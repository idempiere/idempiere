-- IDEMPIERE-2679 Account panel : propose confirmation before closing
-- Jul 3, 2015 9:48:50 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Do you want to create a new account combination ?',0,0,'Y',TO_TIMESTAMP('2015-07-03 21:48:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-07-03 21:48:49','YYYY-MM-DD HH24:MI:SS'),100,200354,'CreateNewAccountCombination','D','e66e11ee-9f0c-4fac-a057-14a6cf820e43')
;

-- Jul 3, 2015 9:49:14 PM CEST
UPDATE AD_Message SET Value='CreateNewAccountCombination?',Updated=TO_TIMESTAMP('2015-07-03 21:49:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200354
;

SELECT register_migration_script('201507032149_IDEMPIERE-2679.sql') FROM dual
;