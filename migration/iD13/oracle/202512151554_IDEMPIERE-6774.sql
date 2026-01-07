-- IDEMPIERE-6774:GL Journal allows posting with Attribute Set Instance (ASI) but no Product - invalid data posted to Fact_Acct.
SELECT register_migration_script('202512151554_IDEMPIERE-6774.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 15, 2025, 3:54:12 PM IST
UPDATE AD_Field SET ReadOnlyLogic='@M_Product_ID@=0',Updated=TO_TIMESTAMP('2025-12-15 15:54:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208672
;

