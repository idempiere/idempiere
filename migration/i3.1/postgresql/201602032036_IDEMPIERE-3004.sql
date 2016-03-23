-- IDEMPIERE-3004 View Column - View Component require SeqNo
-- Feb 3, 2016 8:35:41 PM CET
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2016-02-03 20:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210567
;

SELECT register_migration_script('201602032036_IDEMPIERE-3004.sql') FROM dual
;

