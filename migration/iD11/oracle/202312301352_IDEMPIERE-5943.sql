-- IDEMPIERE-5943 Implement table partitioning support
SELECT register_migration_script('202312301352_IDEMPIERE-5943.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 30, 2023, 1:52:13 PM CET
UPDATE AD_Menu SET IsCentrallyMaintained='Y',Updated=TO_TIMESTAMP('2023-12-30 13:52:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200230
;

-- Dec 30, 2023, 1:52:27 PM CET
UPDATE AD_Process SET Name='Create/Update Table Partition',Updated=TO_TIMESTAMP('2023-12-30 13:52:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200157
;

-- Dec 30, 2023, 1:52:27 PM CET
UPDATE AD_Menu SET Name='Create/Update Table Partition', Description='Process which create or update table partitions based on the table and column records', IsActive='Y',Updated=TO_TIMESTAMP('2023-12-30 13:52:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200230
;

-- Dec 30, 2023, 1:52:37 PM CET
UPDATE AD_Menu SET IsCentrallyMaintained='Y',Updated=TO_TIMESTAMP('2023-12-30 13:52:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200095
;

