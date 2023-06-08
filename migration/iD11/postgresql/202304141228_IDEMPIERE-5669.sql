-- IDEMPIERE-5669
SELECT register_migration_script('202304141228_IDEMPIERE-5669.sql') FROM dual;

-- Apr 14, 2023, 12:28:05 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Row count: {0}',0,0,'Y',TO_TIMESTAMP('2023-04-14 12:28:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-14 12:28:05','YYYY-MM-DD HH24:MI:SS'),100,200833,'RowCount','D','50409fb4-405e-4370-8256-c15a56204c45')
;

