-- IDEMPIERE-4911 Silent fail when translated column is shorter than original column (FHCA-2888)
-- Aug 18, 2021, 8:01:59 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','...',0,0,'Y',TO_TIMESTAMP('2021-08-18 20:01:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-18 20:01:59','YYYY-MM-DD HH24:MI:SS'),100,200714,'MismatchTrlColumnSize','D','14ca00be-1dc1-4e27-b908-257704aae45d')
;

-- Aug 18, 2021, 8:13:56 PM CEST
UPDATE AD_Message SET MsgText='Error synchronizing translation, string too long', MsgTip='There is a mismatch in the size of a translated column.  Please contact the system administrator to correct the problem.',Updated=TO_TIMESTAMP('2021-08-18 20:13:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200714
;

-- Aug 18, 2021, 9:24:16 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Do not forget to create the corresponding translation table {0} with column {1}',0,0,'Y',TO_TIMESTAMP('2021-08-18 21:24:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-18 21:24:15','YYYY-MM-DD HH24:MI:SS'),100,200715,'WarnCreateTrlTable','D','df97a71a-bb65-4ed5-b7dc-000610f807f5')
;

-- Aug 18, 2021, 9:24:27 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Do not forget to create the translation column {0}.{1}',0,0,'Y',TO_TIMESTAMP('2021-08-18 21:24:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-18 21:24:26','YYYY-MM-DD HH24:MI:SS'),100,200716,'WarnCreateTrlColumn','D','7bd54fc7-40cc-408d-b88e-ec25f9ae28fa')
;

-- Aug 18, 2021, 9:24:38 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Do not forget to increase the size on translation column {0}.{1} to {2}',0,0,'Y',TO_TIMESTAMP('2021-08-18 21:24:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-18 21:24:38','YYYY-MM-DD HH24:MI:SS'),100,200717,'WarnUpdateSizeTrlTable','D','d5951ecd-3d4f-4438-bc48-8d3fbace8693')
;

SELECT register_migration_script('202108182002_IDEMPIERE-4911.sql') FROM dual
;

