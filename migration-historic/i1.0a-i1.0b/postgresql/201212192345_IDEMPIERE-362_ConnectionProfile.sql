-- Dec 19, 2012 11:41:02 PM COT
-- Drop deprecated connection profile
UPDATE AD_Field SET IsDisplayed='N', IsActive='N',Updated=TO_TIMESTAMP('2012-12-19 23:41:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12640
;

-- Dec 19, 2012 11:41:44 PM COT
-- Drop deprecated connection profile
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2012-12-19 23:41:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14619
;

-- Dec 19, 2012 11:43:43 PM COT
-- Drop deprecated connection profile
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2012-12-19 23:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14618
;

SELECT register_migration_script('201212192345_IDEMPIERE-362_ConnectionProfile.sql') FROM dual
;

