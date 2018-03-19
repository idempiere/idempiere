-- Feb 13, 2014 11:26:31 AM SGT
-- IDEMPIERE-1598 Window Price List Schema - field Discount Type must be Schema Type
UPDATE AD_Field SET IsCentrallyMaintained='N', Help='Type of procedure used to calculate the trade schema percentage', Description='Type of trade schema calculation', Name='Schema Type',Updated=TO_TIMESTAMP('2014-02-13 11:26:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10769
;

SELECT register_migration_script('201402131154_IDEMPIERE-1598.sql') FROM dual
;