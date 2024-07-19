-- IDEMPIERE-5621
SELECT register_migration_script('202303101443_IDEMPIERE-5621.sql') FROM dual;

-- Mar 10, 2023, 2:43:41 PM CET
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Fill mandatory parameters!','Mandatory parameters should be filled in the Process Parameter field of the Dashboard Content.',0,0,'Y',TO_TIMESTAMP('2023-03-10 14:43:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-10 14:43:41','YYYY-MM-DD HH24:MI:SS'),100,200824,'FillMandatoryParametersDashboard','D','e490d702-11b5-40e8-bea9-0221ae6ae3c9')
;

-- Mar 15, 2023, 2:23:02 PM CET
UPDATE AD_Message SET MsgText='Fill mandatory parameters: {0}',Updated=TO_TIMESTAMP('2023-03-15 14:23:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200824
;

-- Mar 15, 2023, 2:27:16 PM CET
UPDATE AD_Message SET MsgText='Fill mandatory parameters: {0}<br>
Mandatory parameters should be filled in the Process Parameter field of the Dashboard Content.', MsgTip=NULL,Updated=TO_TIMESTAMP('2023-03-15 14:27:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200824
;

-- Mar 15, 2023, 2:29:00 PM CET
UPDATE AD_Message SET MsgText='Fill mandatory parameters: {0}; Mandatory parameters should be filled in the Process Parameter field of the Dashboard Content.',Updated=TO_TIMESTAMP('2023-03-15 14:29:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200824
;

