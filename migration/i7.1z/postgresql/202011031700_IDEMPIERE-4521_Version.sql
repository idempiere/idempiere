-- Set Version
UPDATE AD_SYSTEM
   SET releaseno = '8.1',
       VERSION = '2020-11-03'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('202011031700_IDEMPIERE-4521_Version.sql') FROM dual
;

