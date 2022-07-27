SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5180
-- Feb 5, 2022, 10:01:05 AM CET
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200153,'AD_Role of Client - Not manual only','Not manual roles of current client','S','AD_Role.AD_Client_ID=@#AD_Client_ID@ AND AD_Role.IsManual=''N''',0,0,'Y',TO_DATE('2022-02-05 10:01:05','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-02-05 10:01:05','YYYY-MM-DD HH24:MI:SS'),0,'D','c79f3aa1-27ec-429f-b8e9-72b7ddc95dc2')
;

-- Feb 5, 2022, 10:01:16 AM CET
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200153,Updated=TO_DATE('2022-02-05 10:01:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=539
;

-- Feb 8, 2022, 8:25:06 AM CET
UPDATE AD_Process SET Help='Update the access rights of a role or all roles of a client to windows, forms, processes and workflows. Note that a role is only updated if it is not marked as manual.',Updated=TO_DATE('2022-02-08 08:25:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_ID=295
;

-- Feb 8, 2022, 1:24:16 PM CET
DELETE  FROM  AD_Process_Para_Trl WHERE AD_Process_Para_ID=538
;

-- Feb 8, 2022, 1:24:16 PM CET
DELETE FROM AD_Process_Para WHERE AD_Process_Para_ID=538
;

-- Feb 8, 2022, 1:25:37 PM CET
UPDATE AD_Process SET Help='Update the access rights of a role or all roles of a client to windows, forms, processes and workflows. Note that a role is only updated if it is not marked as manual. Note that if is executed from System client and role is not set, all tenant will be udpated',Updated=TO_DATE('2022-02-08 13:25:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_ID=295
;

SELECT register_migration_script('202202041530_IDEMPIERE-5180.sql') FROM dual
;
