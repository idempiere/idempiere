SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 30, 2013 9:09:59 PM COT
-- IDEMPIERE-1409 Validate format for AD_User.EMail
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','EMail format is invalid: ',200235,'D','c2fb0472-795b-41ff-806c-1c1e0895e9b3','InvalidEMailFormat','Y',TO_DATE('2013-09-30 21:09:57','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-09-30 21:09:57','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201309302110_IDEMPIERE-1409.sql') FROM dual
;

