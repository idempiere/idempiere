-- IDEMPIERE-6709
SELECT register_migration_script('202510250858_IDEMPIERE-6709.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 25, 2025, 8:58:21 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Create Journal to balance posting',0,0,'Y',TO_TIMESTAMP('2025-10-25 08:58:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-10-25 08:58:21','YYYY-MM-DD HH24:MI:SS'),10,200981,'FactReconcileCreateJournalWindowTitle','D','974ef808-18ea-4238-aee4-ab9b94b35e4a')
;

-- Oct 25, 2025, 8:59:12 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Automatic balance','A journal is created to balance selected posting',0,0,'Y',TO_TIMESTAMP('2025-10-25 08:59:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-10-25 08:59:11','YYYY-MM-DD HH24:MI:SS'),10,200982,'FactReconcileCreateJournalCheckboxLabel','D','f1dcf2e9-b82a-40bf-9f40-d51ac04babf1')
;

-- Oct 25, 2025, 9:04:44 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','You can''t create a journal to balance posting as {0} {1} is set as DocControlled',0,0,'Y',TO_TIMESTAMP('2025-10-25 09:04:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-10-25 09:04:44','YYYY-MM-DD HH24:MI:SS'),10,200983,'FactReconcileCantCreateJournalAccountDocControlled','D','7dccfa5f-27c7-4526-a803-56c655f0ffe7')
;

-- Oct 25, 2025, 9:08:33 AM CEST
UPDATE AD_Message SET MsgText='You can''''t create a journal to balance posting as {0} {1} is set as DocControlled',Updated=TO_TIMESTAMP('2025-10-25 09:08:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Message_ID=200983
;


-- Oct 6, 2026, 1:53:16 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200331,0,0,TO_TIMESTAMP('2026-10-06 13:53:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-10-06 13:53:16','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','FACT_RECONCILE_MAXIMUM_DIFFERENCE_AMOUNT','0','Maximum difference amount allowed for reconciliation, in the primary accounting schema currency','D','C','01a1110f-958b-7c75-abf7-c192b30c06ac')
;
