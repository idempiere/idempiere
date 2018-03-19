-- Sep 11, 2013 11:30:06 AM COT
-- IDEMPIERE-1357 Tree panel not is updated with result of "Find" window
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Record is not in current search',200231,'D','6380f694-62e5-4368-96a2-418b006e240a','RecordIsNotInCurrentSearch','Y',TO_DATE('2013-09-11 11:30:05','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-09-11 11:30:05','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201309111130_IDEMPIERE-1357.sql') FROM dual
;

