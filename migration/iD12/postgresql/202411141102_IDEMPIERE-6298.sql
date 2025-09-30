-- IDEMPIERE-6298 : custom delete message for recent item widget
SELECT register_migration_script('202411141102_IDEMPIERE-6298.sql') FROM dual;

-- Nov 14, 2024, 11:02:19 AM WIB
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Drag and Drop here to delete recent item',0,0,'Y',TO_TIMESTAMP('2024-11-14 11:02:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-14 11:02:18','YYYY-MM-DD HH24:MI:SS'),100,200911,'DeleteRecentItem','D','dbc5f72c-4ae0-44fe-86f9-da897ddfbfe8')
;

