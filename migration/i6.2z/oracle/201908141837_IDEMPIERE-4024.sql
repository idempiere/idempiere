SET SQLBLANKLINES ON
SET DEFINE OFF

-- Comments: Help suggestion IDEMPIERE-4024
-- 12. aug. 2019 08.41.41 CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Your changes have been saved',0,0,'Y',TO_DATE('2019-08-12 08:41:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-08-12 08:41:41','YYYY-MM-DD HH24:MI:SS'),100,200535,'Your changes have been saved','D','626593d4-d1eb-41d8-bdc6-1f65f186aea6')
;

-- 12. aug. 2019 08.42.09 CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Your suggestions have been submitted for review',0,0,'Y',TO_DATE('2019-08-12 08:42:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-08-12 08:42:08','YYYY-MM-DD HH24:MI:SS'),100,200536,'Your suggestions have been submitted for review','D','f0808e07-6b87-4f7d-9b27-bd73ed66046a')
;

SELECT register_migration_script('201908141837_IDEMPIERE-4024.sql') FROM dual
;

