-- May 6, 2021, 2:19:42 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Open run dialog',0,0,'Y',TO_TIMESTAMP('2021-05-06 14:19:41','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-05-06 14:19:41','YYYY-MM-DD HH24:MI:SS'),0,200675,'OpenRunDialog','D','37c7d67f-2a8b-479e-85e2-53cce5861fd7')
;

-- May 6, 2021, 2:20:03 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','View report in new tab',0,0,'Y',TO_TIMESTAMP('2021-05-06 14:20:03','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-05-06 14:20:03','YYYY-MM-DD HH24:MI:SS'),0,200676,'ViewReportInNewTab','D','df6e54ee-dc5b-46a6-b2fe-29f8a4a72b93')
;

SELECT register_migration_script('202105061420_IDEMPIERE-4780.sql') FROM dual
;
