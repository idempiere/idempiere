-- IDEMPIERE-6758 - Hide Business Partner from material receipt info window
SELECT register_migration_script('202512051850_IDEMPIERE-6758.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 5, 2025, 6:50:50 PM CET
UPDATE AD_InfoColumn SET IsQueryCriteria='N', IsMandatory='N',Updated=TO_TIMESTAMP('2025-12-05 18:50:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200253
;

