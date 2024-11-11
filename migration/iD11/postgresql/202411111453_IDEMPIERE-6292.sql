-- IDEMPIERE-11
SELECT register_migration_script('202411111453_IDEMPIERE-6292.sql') FROM dual;

-- Nov 11, 2024, 2:53:06 PM BRT
UPDATE AD_Column SET IsUpdateable='N', FKConstraintType='M',Updated=TO_TIMESTAMP('2024-11-11 14:53:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213287
;

