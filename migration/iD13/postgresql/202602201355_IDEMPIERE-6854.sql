-- IDEMPIERE-6854 Organization field in some Asset window tabs is empty
SELECT register_migration_script('202602201355_IDEMPIERE-6854.sql') FROM dual;

-- Feb 20, 2026, 1:55:46 PM CET
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@',Updated=TO_TIMESTAMP('2026-02-20 13:55:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55656
;

-- Feb 20, 2026, 1:56:33 PM CET
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@',Updated=TO_TIMESTAMP('2026-02-20 13:56:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55756
;

-- Feb 20, 2026, 1:56:42 PM CET
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@', IsUpdateable='N',Updated=TO_TIMESTAMP('2026-02-20 13:56:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55807
;

-- Feb 20, 2026, 1:57:09 PM CET
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@', IsUpdateable='N',Updated=TO_TIMESTAMP('2026-02-20 13:57:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55913
;

-- Feb 20, 2026, 1:58:04 PM CET
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@', IsUpdateable='N',Updated=TO_TIMESTAMP('2026-02-20 13:58:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55898
;

-- Feb 20, 2026, 1:58:36 PM CET
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@', IsUpdateable='N',Updated=TO_TIMESTAMP('2026-02-20 13:58:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55928
;

-- Feb 20, 2026, 1:58:46 PM CET
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@', IsUpdateable='N',Updated=TO_TIMESTAMP('2026-02-20 13:58:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55792
;

-- Feb 20, 2026, 1:59:03 PM CET
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@',Updated=TO_TIMESTAMP('2026-02-20 13:59:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55397
;

-- Feb 20, 2026, 1:59:14 PM CET
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@',Updated=TO_TIMESTAMP('2026-02-20 13:59:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14321
;

