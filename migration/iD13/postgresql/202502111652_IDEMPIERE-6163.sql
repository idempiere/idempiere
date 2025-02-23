-- IDEMPIERE-6163 DisplaySQL and Display Identifier field in Reference > Table Validation
SELECT register_migration_script('202502111652_IDEMPIERE-6163.sql') FROM dual;

-- Feb 11, 2025, 4:53:53 PM IST
UPDATE AD_Column SET FieldLength=4000, AD_Reference_ID=10, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2025-02-11 16:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213865
;

-- Feb 11, 2025, 4:53:55 PM IST
INSERT INTO t_alter_column values('ad_ref_table','DisplaySQL','VARCHAR(4000)',null,'NULL')
;

-- Feb 11, 2025, 4:55:21 PM IST
UPDATE AD_Field SET NumLines=3,Updated=TO_TIMESTAMP('2025-02-11 16:55:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205956
;

-- Feb 11, 2025, 5:07:41 PM IST
UPDATE AD_Field SET DisplayLogic='@IsDisplayIdentifier@=N & @DisplaySQL:0@=0',Updated=TO_TIMESTAMP('2025-02-11 17:07:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1266
;

-- Feb 11, 2025, 5:08:19 PM IST
UPDATE AD_Field SET DisplayLogic='@IsDisplayIdentifier@=N & @IsValueDisplayed@=N',Updated=TO_TIMESTAMP('2025-02-11 17:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205956
;

