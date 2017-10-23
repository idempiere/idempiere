SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3518 Improvement For Mobile Compatibility
-- Oct 24, 2017 7:34:07 AM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Select location to move selected item to',0,0,'Y',TO_DATE('2017-10-24 07:34:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-10-24 07:34:06','YYYY-MM-DD HH24:MI:SS'),100,200437,'MoveSelectedTreeItem','D','95d7bb4b-c7af-4b17-b274-23916870a7fa')
;

SELECT register_migration_script('201710240900_IDEMPIERE-3518.sql') FROM dual
;

