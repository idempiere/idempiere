-- Sep 9, 2013 4:25:23 PM COT
-- IDEMPIERE-1345 Allow Translation Export from webui
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Export ZIP',200230,'D','d68b4fb8-d613-47a5-879b-c54aa9d3c415','ExportZIP','Y',TO_TIMESTAMP('2013-09-09 16:25:22','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-09-09 16:25:22','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201309091625_IDEMPIERE-1345.sql') FROM dual
;

