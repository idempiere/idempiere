-- IDEMPIERE-5576
SELECT register_migration_script('202302170941_IDEMPIERE-5576.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 17, 2023, 9:41:40 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not close Period Control because of un-processed Documents:',0,0,'Y',TO_TIMESTAMP('2023-02-17 09:41:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-17 09:41:39','YYYY-MM-DD HH24:MI:SS'),100,200822,'CouldNotClosePeriodControl','D','391105fb-12ab-4cc1-a5da-7854bcb9a23e')
;

