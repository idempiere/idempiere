-- IDEMPIERE-4297 Improve test data - not advanced role
-- Oct 16, 2020, 6:43:50 PM CEST
UPDATE AD_Role SET IsAccessAdvanced='N',Updated=TO_TIMESTAMP('2020-10-16 18:43:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Role_ID=200001
;

SELECT register_migration_script('202010161844_IDEMPIERE-4297_NotAdvancedRole.sql') FROM dual
;

