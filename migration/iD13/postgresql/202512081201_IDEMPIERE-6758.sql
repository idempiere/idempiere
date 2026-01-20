-- IDEMPIERE-6758 - Hide Business Partner from material receipt info window
SELECT register_migration_script('202512081201_IDEMPIERE-6758.sql') FROM dual;

-- Dec 8, 2025, 12:01:02 PM CET
UPDATE AD_Column SET ReadOnlyLogic='@SQL=SELECT 1 FROM M_InOutLine WHERE M_InOut_ID=@M_InOut_ID:0@',Updated=TO_TIMESTAMP('2025-12-08 12:01:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3795
;

