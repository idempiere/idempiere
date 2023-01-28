-- IDEMPIERE-5468
SELECT register_migration_script('202212021220_IDEMPIERE-5468.sql') FROM dual;

-- Dec 2, 2022, 12:20:53 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Exclude selected values',0,0,'Y',TO_TIMESTAMP('2022-12-02 12:20:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-02 12:20:52','YYYY-MM-DD HH24:MI:SS'),100,200804,'ExcludeSelectedValues','D','dce25756-d58c-42a1-a414-2bcf0efc5452')
;

-- Dec 2, 2022, 12:21:08 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Include selected values',0,0,'Y',TO_TIMESTAMP('2022-12-02 12:21:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-02 12:21:07','YYYY-MM-DD HH24:MI:SS'),100,200805,'IncludeSelectedValues','D','09414e7f-d31b-4a0f-831c-8ec50992961b')
;

