-- Set Version
UPDATE AD_SYSTEM
   SET releaseno = '9',
       VERSION = '2021-12-24'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

COMMIT
;

SELECT register_migration_script('202112231543_IDEMPIERE-5109_Version.sql') FROM dual
;

