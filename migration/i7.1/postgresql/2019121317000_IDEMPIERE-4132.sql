-- IDEMPIERE-4132 / Nederland/Netherlands
-- 2019-12-13 05:17:29
UPDATE C_Country SET Name='Netherlands',Updated=TO_TIMESTAMP('2019-12-13 17:17:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Country_ID=105
;

SELECT register_migration_script('2019121317000_IDEMPIERE-4132.sql') FROM dual
;