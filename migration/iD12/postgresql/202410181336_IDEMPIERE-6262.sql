-- IDEMPIERE-6262 UI Enhancements for Consistency with IceBlue_c Theme
SELECT register_migration_script('202410181336_IDEMPIERE-6262.sql') FROM dual;

-- Oct 18, 2024, 1:36:24 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','Login',0,0,'Y',TO_TIMESTAMP('2024-10-18 13:36:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-10-18 13:36:23','YYYY-MM-DD HH24:MI:SS'),10,200908,'LoginHeader','D','3b795676-7f94-4da3-a5c3-a9310c692f5e')
;

