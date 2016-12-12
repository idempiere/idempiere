-- IDEMPIERE-2271 iDempiere is hardcoded EMail to support subject
-- Dec 12, 2016 4:50:36 PM ICT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','@#System_Name@ Trace Information',0,0,'Y',TO_TIMESTAMP('2016-12-12 16:50:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-12-12 16:50:35','YYYY-MM-DD HH24:MI:SS'),100,200414,'FeedBackHeader','D','1a27d0a9-0832-4e63-b49b-bb26eeceafc4')
;
SELECT register_migration_script('201612121604-IDEMPIERE-2271.sql') FROM dual
;
