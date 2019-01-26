-- IDEMPIERE-3509:Message about can't find out direct table reference 
-- Sep 30, 2017 11:59:56 PM ICT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Can''''t resolve reference table for column "{0}"',0,0,'Y',TO_TIMESTAMP('2017-09-30 23:59:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-09-30 23:59:55','YYYY-MM-DD HH24:MI:SS'),100,200432,'NotReferenceTable','D','4f338d58-5c2d-4dda-8817-93f1954ab4eb')
;

SELECT register_migration_script('201901261333_IDEMPIERE-3509.sql') FROM dual
;

