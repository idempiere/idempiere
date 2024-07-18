-- IDEMPIERE-6176 UUID indexes without constraint
SELECT register_migration_script('202406180027_IDEMPIERE-6176.sql') FROM dual;

-- Jun 18, 2024, 12:29:20 AM CEST
UPDATE AD_IndexColumn SET IsActive='N',Updated=TO_TIMESTAMP('2024-06-18 00:29:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200980
;

-- Jun 18, 2024, 12:29:27 AM CEST
UPDATE AD_TableIndex SET IsActive='N', IsCreateConstraint='Y',Updated=TO_TIMESTAMP('2024-06-18 00:29:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=200806
;

-- Jun 18, 2024, 12:30:44 AM CEST
UPDATE AD_TableIndex SET IsCreateConstraint='Y',Updated=TO_TIMESTAMP('2024-06-18 00:30:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=201272
;

-- Jun 18, 2024, 12:31:49 AM CEST
UPDATE AD_TableIndex SET IsCreateConstraint='Y',Updated=TO_TIMESTAMP('2024-06-18 00:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=201275
;

