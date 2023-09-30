-- IDEMPIERE-5229 After migrate helper (FHCA-4070)
SELECT register_migration_script('202309271721_IDEMPIERE-5229.sql') FROM dual;

-- Sep 27, 2023, 5:21:22 PM CEST
UPDATE AD_Message SET MsgText='Column View does not exist in database.
The view column {0} was created on {1,date,long} by {2}',Updated=TO_TIMESTAMP('2023-09-27 17:21:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200818
;

-- Sep 27, 2023, 5:22:53 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','View does not exist in database.
The view {0} was created on {1,date,long} by {2}',0,0,'Y',TO_TIMESTAMP('2023-09-27 17:22:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-27 17:22:52','YYYY-MM-DD HH24:MI:SS'),100,200836,'VM_ViewNotInDB','D','27048f83-7f7d-491d-b424-47c29a19aa66')
;

-- Sep 27, 2023, 6:27:17 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Column View does not exist in dictionary.
The view column {0} exists in database but is not defined in dictionary',0,0,'Y',TO_TIMESTAMP('2023-09-27 18:27:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-27 18:27:17','YYYY-MM-DD HH24:MI:SS'),100,200837,'VM_ViewColumnNotInDict','D','ba575690-245d-4615-bf7e-e2bbe3cd4917')
;

