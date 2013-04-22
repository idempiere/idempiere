-- Apr 8, 2013 2:05:44 PM COT
-- IDEMPIERE-832 , not shows the new request created in the Calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Complete Plan, must be greater that Start Plan',200171,'D','aa911a40-6c9d-42fa-8a9c-1d95b86013eb','DateCompletePlan','Y',TO_TIMESTAMP('2013-04-08 14:05:42','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-08 14:05:42','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 8, 2013 2:05:44 PM COT
-- IDEMPIERE-832 , not shows the new request created in the Calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200171 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 8, 2013 2:07:56 PM COT
-- IDEMPIERE-832 , not shows the new request created in the Calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Start Time, must be less than End Time',200172,'D','f0740826-d6c9-4606-821c-6b3b147b1a18','CheckTime','Y',TO_TIMESTAMP('2013-04-08 14:07:55','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-08 14:07:55','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 8, 2013 2:07:56 PM COT
-- IDEMPIERE-832 , not shows the new request created in the Calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200172 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201304081425_IDEMPIERE-832.sql') FROM dual;

