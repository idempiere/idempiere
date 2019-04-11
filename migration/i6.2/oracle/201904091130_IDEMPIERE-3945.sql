SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3945 Country name "Germany - Deutschland" should be named Germany
-- Apr 9, 2019, 11:22:01 AM CEST
UPDATE C_Country SET Name='Germany',Description='Deutschland',Updated=TO_DATE('2019-04-09 11:22:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Country_ID=101
;

SELECT register_migration_script('201904091130_IDEMPIERE-3945.sql') FROM dual
;

