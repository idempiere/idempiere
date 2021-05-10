-- Jan 19, 2021, 1:34:10 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The window tab took too long to return results.',0,0,'Y',TO_TIMESTAMP('2021-01-19 13:34:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-01-19 13:34:09','YYYY-MM-DD HH24:MI:SS'),100,200659,'GridTabLoadTimeoutError','D','f016a5f8-3783-4640-b713-8f0e1b4d3bb6')
;

SELECT register_migration_script('202101190630_IDEMPIERE-4653.sql') FROM dual
;

