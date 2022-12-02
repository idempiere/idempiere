-- IDEMPIERE-5468
SELECT register_migration_script('202211301704_IDEMPIERE-5468.sql') FROM dual;

-- Nov 30, 2022, 5:04:32 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Include selected values',0,0,'Y',TO_TIMESTAMP('2022-11-30 17:04:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-30 17:04:32','YYYY-MM-DD HH24:MI:SS'),100,1000000,'IncludeSelectedValues','U','9794b1f5-cd91-4d8d-95ba-a2f53eca1af5')
;

-- Nov 30, 2022, 5:04:49 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Exclude selected values',0,0,'Y',TO_TIMESTAMP('2022-11-30 17:04:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-30 17:04:49','YYYY-MM-DD HH24:MI:SS'),100,1000001,'ExcludeSelectedValues','U','439b142f-26ab-4224-8e38-d42fc3757750')
;

-- Nov 30, 2022, 5:04:54 PM BRT
UPDATE AD_Message SET EntityType='D',Updated=TO_TIMESTAMP('2022-11-30 17:04:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=1000001
;

-- Nov 30, 2022, 5:05:08 PM BRT
UPDATE AD_Message SET EntityType='D',Updated=TO_TIMESTAMP('2022-11-30 17:05:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=1000000
;

