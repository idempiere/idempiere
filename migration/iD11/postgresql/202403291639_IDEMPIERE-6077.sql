-- IDEMPIERE-6077
SELECT register_migration_script('202403291639_IDEMPIERE-6077.sql') FROM dual;

-- Mar 29, 2024, 4:39:08 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The query returns more than one record',0,0,'Y',TO_TIMESTAMP('2024-03-29 16:39:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2024-03-29 16:39:08','YYYY-MM-DD HH24:MI:SS'),10,200880,'QueryMoreThanOneRecordsFound','D','f17d9113-2d74-4822-bfb2-21fa8db41021')
;

