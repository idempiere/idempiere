-- Oct 19, 2012 5:46:54 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='AD_Role.AD_Client_ID=@#AD_Client_ID@ AND AD_Role.IsMasterRole=''N''',Updated=TO_TIMESTAMP('2012-10-19 17:46:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=158
;

-- Oct 19, 2012 6:18:21 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Column SET AD_Val_Rule_ID=158,Updated=TO_TIMESTAMP('2012-10-19 18:18:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10478
;

-- Oct 19, 2012 6:32:03 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_Role.IsMasterRole=''N''',200010,'D','NoMasterRoles','S','9344cb3b-dfaf-4950-adb9-95449fcc10d8',100,100,TO_TIMESTAMP('2012-10-19 18:32:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-19 18:32:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Oct 19, 2012 6:33:32 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Column SET AD_Val_Rule_ID=200010,Updated=TO_TIMESTAMP('2012-10-19 18:33:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11504
;

-- Oct 19, 2012 6:37:16 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Column SET AD_Val_Rule_ID=200010,Updated=TO_TIMESTAMP('2012-10-19 18:37:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13488
;

-- Oct 19, 2012 6:42:04 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Column SET AD_Val_Rule_ID=200010,Updated=TO_TIMESTAMP('2012-10-19 18:42:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14854
;

-- Oct 19, 2012 6:46:23 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Column SET AD_Val_Rule_ID=200010,Updated=TO_TIMESTAMP('2012-10-19 18:46:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200251
;

SELECT register_migration_script('942_IDEMPIERE_366.sql') FROM dual
;

