-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603312254_IDEMPIERE-6908.sql') FROM dual;

-- Mar 31, 2026, 10:54:34 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Cannot uninstall {0} because other extensions depend on it. Please remove the following dependents first: [{1}]',0,0,'Y',TO_TIMESTAMP('2026-03-31 22:54:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-31 22:54:33','YYYY-MM-DD HH24:MI:SS'),100,201037,'ExtensionHasDependents','D','019d4463-a4d5-7163-aa2a-f540b13a53fc')
;

-- Mar 31, 2026, 10:59:45 PM GMT+08:00
UPDATE AD_Message SET MsgText='Cannot uninstall/disable {0} because other extensions depend on it. Please remove/disable the following dependents first: [{1}]',Updated=TO_TIMESTAMP('2026-03-31 22:59:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=201037
;

