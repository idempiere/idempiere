-- IDEMPIERE-5238
SELECT register_migration_script('202303141224_IDEMPIERE-5238.sql') FROM dual;

-- Mar 14, 2023, 12:24:54 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','This Table has no Key Column',0,0,'Y',TO_TIMESTAMP('2023-03-14 12:24:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-14 12:24:53','YYYY-MM-DD HH24:MI:SS'),100,200826,'TableHasNoKeyColumn','D','f157fa43-7351-43fe-beae-3870f0d76363')
;

