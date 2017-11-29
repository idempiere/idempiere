-- IDEMPIERE-1052
-- Nov 23, 2017 3:40:33 PM CET
UPDATE AD_Column SET AD_Reference_ID=30, IsUpdateable='N',Updated=TO_TIMESTAMP('2017-11-23 15:40:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=1638
;

-- Nov 23, 2017 3:40:49 PM CET
UPDATE AD_Column SET AD_Reference_ID=30, IsUpdateable='N',Updated=TO_TIMESTAMP('2017-11-23 15:40:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=1667
;

-- Nov 23, 2017 3:41:06 PM CET
UPDATE AD_Column SET AD_Reference_ID=30, IsUpdateable='N',Updated=TO_TIMESTAMP('2017-11-23 15:41:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=4934
;

SELECT register_migration_script('201711211700_IDEMPIERE-1052.sql') FROM dual
;