-- IDEMPIERE-5259 (CRM) Labels/tags feature
SELECT register_migration_script('202210051139_IDEMPIERE-5259.sql') FROM dual;

-- Oct 5, 2022, 11:39:35 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Label / Tag',0,0,'Y',TO_TIMESTAMP('2022-10-05 11:39:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-05 11:39:34','YYYY-MM-DD HH24:MI:SS'),100,200789,'Label','D','bca2b15f-922e-45ab-a437-fb68ab314765')
;

