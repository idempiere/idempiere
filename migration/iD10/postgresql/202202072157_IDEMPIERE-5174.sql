-- IDEMPIERE-5174 Deactivate System user
-- Feb 7, 2022, 9:52:47 PM CET
UPDATE AD_User SET IsActive='N',Password=NULL,Updated=TO_TIMESTAMP('2022-02-07 21:52:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_User_ID=0 AND IsActive='Y'
;

-- Feb 7, 2022, 9:52:55 PM CET
UPDATE AD_User_Roles SET IsActive='N',Updated=TO_TIMESTAMP('2022-02-07 21:52:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Role_ID=0 AND AD_User_ID=0 AND IsActive='Y'
;

-- Feb 7, 2022, 10:49:09 PM CET
UPDATE AD_SchedulerRecipient SET AD_User_ID=100,Updated=TO_TIMESTAMP('2022-02-07 22:49:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_User_ID=0
;

-- Feb 7, 2022, 10:59:05 PM CET
UPDATE AD_AlertProcessor SET Supervisor_ID=100,Updated=TO_TIMESTAMP('2022-02-07 22:59:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE Supervisor_ID=0
;

-- Feb 7, 2022, 10:59:05 PM CET
UPDATE AD_LdapProcessor SET Supervisor_ID=100,Updated=TO_TIMESTAMP('2022-02-07 22:59:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE Supervisor_ID=0
;

-- Feb 7, 2022, 10:59:05 PM CET
UPDATE AD_Scheduler SET Supervisor_ID=100,Updated=TO_TIMESTAMP('2022-02-07 22:59:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE Supervisor_ID=0
;

-- Feb 7, 2022, 10:59:05 PM CET
UPDATE AD_WorkflowProcessor SET Supervisor_ID=100,Updated=TO_TIMESTAMP('2022-02-07 22:59:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE Supervisor_ID=0
;

SELECT register_migration_script('202202072157_IDEMPIERE-5174.sql') FROM dual
;

