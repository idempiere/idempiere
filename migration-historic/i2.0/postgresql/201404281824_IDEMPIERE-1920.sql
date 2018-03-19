-- Apr 28, 2014 5:35:23 PM COT
-- Decrease AccessLevel For Security Related Processes
UPDATE AD_Process SET AccessLevel='6',Updated=TO_TIMESTAMP('2014-04-28 17:35:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=50010
;

-- Apr 28, 2014 5:35:54 PM COT
UPDATE AD_Process SET AccessLevel='6',Updated=TO_TIMESTAMP('2014-04-28 17:35:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200008
;

-- Apr 29, 2014 5:47:13 PM COT
UPDATE AD_Process SET Help='Copy role access records from one role to another.  The existing access records for the destination role will be deleted.  This process can be executed just by advanced roles.',Updated=TO_TIMESTAMP('2014-04-29 17:47:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=50010
;

SELECT register_migration_script('201404281824_IDEMPIERE-1920.sql') FROM dual
;

