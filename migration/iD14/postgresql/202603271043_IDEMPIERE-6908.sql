-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603271043_IDEMPIERE-6908.sql') FROM dual;

-- Mar 27, 2026, 10:45:20 AM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Filter by name, description, tag: or category:',0,0,'Y',TO_TIMESTAMP('2026-03-27 10:45:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-27 10:45:19','YYYY-MM-DD HH24:MI:SS'),100,201026,'ExtensionFilterPlaceHolderText','D','019d2d2e-941d-7dad-810b-edecd222486f')
;

