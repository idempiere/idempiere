-- Set Version
UPDATE AD_SYSTEM
   SET releaseno = '10',
       VERSION = '2022-12-24'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

COMMIT
;

SELECT register_migration_script('202212231232_IDEMPIERE-5523_Version.sql') FROM dual
;

