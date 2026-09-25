-- IDEMPIERE-6774: Create a Error message.
SELECT register_migration_script('202603211220_IDEMPIERE-6774.sql') FROM dual;

-- Mar 21, 2026, 12:20:03 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Product must be set when selecting Material Attribute',0,0,'Y',TO_TIMESTAMP('2026-03-21 12:20:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-21 12:20:02','YYYY-MM-DD HH24:MI:SS'),100,200992,'ProductRequiredForMaterialASI','D','019c9ddc-8f9a-77f6-8b70-c93ef18878e1')
;
