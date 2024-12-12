-- IDEMPIERE-6327 Interest Area Window: Subscription tab should not enable "Insert Record"
SELECT register_migration_script('202412021125_IDEMPIERE-6327.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 2, 2024, 11:25:16 AM MYT
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2024-12-02 11:25:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=536
;

-- Dec 2, 2024, 11:25:32 AM MYT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2024-12-02 11:25:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7625
;

