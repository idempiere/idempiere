-- IDEMPIERE-3589 Add a 'Warning' Message
-- Dec 29, 2017 9:22:30 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Warning',0,0,'Y',TO_TIMESTAMP('2017-12-29 09:22:30','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2017-12-29 09:22:30','YYYY-MM-DD HH24:MI:SS'),0,200442,'Warning','D','ef025d76-6391-4a0c-88c0-64d12196b53e')
;

SELECT register_migration_script('201712290930_IDEMPIERE-3589.sql') FROM dual
;