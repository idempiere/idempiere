-- Sep 4, 2012 11:47:10 AM COT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-09-04 11:47:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200405
;

-- Sep 4, 2012 11:47:26 AM COT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET XPosition=3, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-09-04 11:47:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200400
;

-- Sep 4, 2012 11:47:36 AM COT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-09-04 11:47:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200403
;

-- Sep 4, 2012 11:47:51 AM COT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-09-04 11:47:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200401
;

-- Sep 4, 2012 11:47:58 AM COT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-09-04 11:47:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200400
;

-- Sep 4, 2012 11:48:09 AM COT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-09-04 11:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200406
;

-- Sep 4, 2012 11:48:19 AM COT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-09-04 11:48:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200405
;

-- Sep 4, 2012 11:48:30 AM COT
-- IDEMPIERE-373 Implement User Locking
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-09-04 11:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200402
;

UPDATE AD_System
  SET LastMigrationScriptApplied='900_IDEMPIERE-373_User_Locking.sql'
WHERE LastMigrationScriptApplied<'900_IDEMPIERE-373_User_Locking.sql'
   OR LastMigrationScriptApplied IS NULL
;

