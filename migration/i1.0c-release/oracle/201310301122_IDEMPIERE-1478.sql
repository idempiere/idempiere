SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 30, 2013 11:22:12 AM COT
-- IDEMPIERE-1478 Usability improvement - closing without saving
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','There are unsaved changes - are you sure to close?',200238,'D','276708d4-7bd0-4241-b996-4213e0c47144','CloseUnSave?','Y',TO_DATE('2013-10-30 11:22:11','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-10-30 11:22:11','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201310301122_IDEMPIERE-1478.sql') FROM dual
;

