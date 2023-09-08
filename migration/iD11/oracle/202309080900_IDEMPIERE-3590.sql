SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 8, 2023, 9:00:02 AM WIB
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No QuickEntry Field Set on User Preference',0,0,'Y',TO_TIMESTAMP('2023-09-08 09:00:00','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-09-08 09:00:00','YYYY-MM-DD HH24:MI:SS'),10,200835,'NoQuickEntryPreference','D','56cf1ebf-a4fa-4375-bdaf-751c80aa72c9')
;

-- IDEMPIERE-3590
SELECT register_migration_script('202309080900_IDEMPIERE-3590.sql') FROM dual;