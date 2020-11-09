SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1117 Attachment -> Disable preview over certain size
-- 11.2020.09 20:42:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Preview',0,0,'Y',TO_DATE('2020-11-09 20:42:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-09 20:42:00','YYYY-MM-DD HH24:MI:SS'),100,200651,'Preview','D','ee9dfe12-97b3-41fb-8449-e47dbb6d5fe2')
;

SELECT register_migration_script('202011092042_IDEMPIERE-1117.sql') FROM dual
;

