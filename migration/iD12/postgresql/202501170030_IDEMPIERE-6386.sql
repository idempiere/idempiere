-- IDEMPIERE-6386 Detail tabs don't have control over slow or big queries (FHCA-6139)
SELECT register_migration_script('202501170030_IDEMPIERE-6386.sql') FROM dual;

-- Jan 17, 2025, 12:30:29 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The background loading of the records has finished.',0,0,'Y',TO_TIMESTAMP('2025-01-17 00:30:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-17 00:30:28','YYYY-MM-DD HH24:MI:SS'),100,200927,'BackgroundLoadFinished','D','4ba78ee4-45c3-4359-92e1-f42e92f26a0e')
;

