-- IDEMPIERE-5493 [Workflow Activities] - Activity persists after delete related record
SELECT register_migration_script('202308301811_IDEMPIERE-5493.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 30, 2023, 6:11:46 PM CEST
UPDATE AD_Column SET FKConstraintType='M',Updated=TO_TIMESTAMP('2023-08-30 18:11:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11545
;

-- Aug 30, 2023, 6:12:11 PM CEST
UPDATE AD_Column SET FKConstraintType='M',Updated=TO_TIMESTAMP('2023-08-30 18:12:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11683
;

-- Aug 30, 2023, 6:12:24 PM CEST
UPDATE AD_Column SET FKConstraintType='M',Updated=TO_TIMESTAMP('2023-08-30 18:12:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11549
;

