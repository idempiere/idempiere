-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603281056_IDEMPIERE-6908.sql') FROM dual;

-- Mar 28, 2026, 10:56:18 AM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Incremental Pack In for bundle {0} is running in background for:{1}',0,0,'Y',TO_TIMESTAMP('2026-03-28 10:56:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-28 10:56:17','YYYY-MM-DD HH24:MI:SS'),100,201030,'IncrementalPackInRunningInBackground','D','019d325e-fb0b-7d2e-9d5d-e5e33d92498e')
;

-- Mar 28, 2026, 10:59:33 AM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Incremental Pack In for bundle {0} completed successfully',0,0,'Y',TO_TIMESTAMP('2026-03-28 10:59:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-28 10:59:33','YYYY-MM-DD HH24:MI:SS'),100,201031,'IncrementalPackInCompletedSuccessfully','D','019d3261-f4a9-7fa1-97e3-1ae009648f8c')
;

-- Mar 28, 2026, 11:00:01 AM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Incremental Pack In for bundle {0} completed with errors',0,0,'Y',TO_TIMESTAMP('2026-03-28 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-28 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,201032,'IncrementalPackInCompletedWithErrors','D','019d3262-5f7b-7305-85cb-b333fd75d841')
;

