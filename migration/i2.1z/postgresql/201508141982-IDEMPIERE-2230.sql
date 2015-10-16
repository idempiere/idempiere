-- IDEMPIERE-2230 Info Window - remember selection during pagination
-- Aug 14, 2015 6:52:36 AM WITA
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Selected {0} rows',0,0,'Y',TO_TIMESTAMP('2015-08-14 06:52:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-08-14 06:52:36','YYYY-MM-DD HH24:MI:SS'),100,200355,'IWStatusSelected','D','316251b1-093c-4f33-bf37-4d5af0f000d5')
;
SELECT register_migration_script('201508141982-IDEMPIERE-2230.sql') FROM dual
;

