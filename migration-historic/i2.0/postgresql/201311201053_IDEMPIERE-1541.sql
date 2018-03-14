-- 20/11/2013 10:53:00 AM COT
-- IDEMPIERE-1541 missing translation - mini calendar - more
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','more',200239,'D','ce211d63-ece3-4ac8-bd30-c2d3456527c0','more','Y',TO_TIMESTAMP('2013-11-20 10:52:59','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-11-20 10:52:59','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201311201053_IDEMPIERE-1541.sql') FROM dual
;

