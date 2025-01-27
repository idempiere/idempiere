-- IDEMPIERE-5647 Allow definition of context variables by Role
SELECT register_migration_script('202501201433_IDEMPIERE-5647.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 20, 2025, 2:33:28 PM CET
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2025-01-20 14:33:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207596
;

-- Jan 20, 2025, 2:33:58 PM CET
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N',Updated=TO_TIMESTAMP('2025-01-20 14:33:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206904
;

