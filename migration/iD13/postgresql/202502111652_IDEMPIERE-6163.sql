-- IDEMPIERE-6163 DisplaySQL and Display Identifier field in Reference > Table Validation
SELECT register_migration_script('202502111652_IDEMPIERE-6163.sql') FROM dual;

-- Feb 11, 2025, 4:53:53 PM IST
UPDATE AD_Column SET FieldLength=4000, AD_Reference_ID=10, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2025-02-11 16:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213865
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

-- Mar 7, 2025, 2:36:47 PM IST
UPDATE AD_Column SET Description='This functionality displays lookup values using a fully qualified subquery. Make sure that the DisplaySQL field in the SELECT clause of the provided SQL query is correctly formatted as TEXT. An incompatible data type may cause casting errors.', Help='This SQL is used to display a lookup value using a fully qualified subquery.

Key Points:
    Fully Qualified Subquery: Ensures correct data retrieval by specifying complete table/schema references.
    Data Type Compatibility: The DisplaySQL field in the SELECT clause must be in TEXT format to avoid casting errors.
    Recommendation: Use CAST(DisplaySQL AS TEXT) if needed to ensure compatibility.

Ensure proper testing to avoid errors and confirm expected results.',Updated=TO_TIMESTAMP('2025-03-07 14:36:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213865
;

-- Mar 7, 2025, 2:37:29 PM IST
UPDATE AD_Field SET Description='This functionality displays lookup values using a fully qualified subquery. Make sure that the DisplaySQL field in the SELECT clause of the provided SQL query is correctly formatted as TEXT. An incompatible data type may cause casting errors.', Help='This SQL is used to display a lookup value using a fully qualified subquery.

Key Points:
    Fully Qualified Subquery: Ensures correct data retrieval by specifying complete table/schema references.
    Data Type Compatibility: The DisplaySQL field in the SELECT clause must be in TEXT format to avoid casting errors.
    Recommendation: Use CAST(DisplaySQL AS TEXT) if needed to ensure compatibility.

Ensure proper testing to avoid errors and confirm expected results.',Updated=TO_TIMESTAMP('2025-03-07 14:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205956
;

-- Nov 24, 2025, 8:31:22 PM CET
UPDATE AD_Field SET DisplayLogic='@DisplaySQL:0@=0',Updated=TO_TIMESTAMP('2025-11-24 20:31:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1266
;
