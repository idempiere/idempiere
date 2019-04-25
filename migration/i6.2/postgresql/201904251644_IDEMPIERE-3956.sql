-- IDEMPIERE-3956 Add Close Windows to the Left/Right - expanding IDEMPIERE-2335
-- Apr 25, 2019, 4:43:29 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Close Windows to the Right',0,0,'Y',TO_TIMESTAMP('2019-04-25 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-04-25 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,200510,'CloseWindowsToTheRight','D','b90cf739-eb4d-41eb-a8cb-7c1960e7af2a')
;

-- Apr 25, 2019, 4:44:18 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Close Windows to the Left',0,0,'Y',TO_TIMESTAMP('2019-04-25 16:44:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-04-25 16:44:17','YYYY-MM-DD HH24:MI:SS'),100,200511,'CloseWindowsToTheLeft','D','c150a69a-ae19-4403-8d03-0040e7714ef9')
;

SELECT register_migration_script('201904251644_IDEMPIERE-3956.sql') FROM dual
;

