SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 26, 2014 1:04:37 PM SGT
-- IDEMPIERE-2023 Scheduler Recipient record has incorrect defaults
UPDATE AD_Column SET DefaultValue='-1',Updated=TO_DATE('2014-06-26 13:04:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11504
;

-- Jun 26, 2014 1:04:54 PM SGT
UPDATE AD_Column SET DefaultValue='-1',Updated=TO_DATE('2014-06-26 13:04:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11512
;

SELECT register_migration_script('201406261439_IDEMPIERE-2023.sql') FROM dual
;