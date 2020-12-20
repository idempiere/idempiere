-- Set Version
UPDATE AD_SYSTEM
   SET releaseno = '8.2',
       VERSION = '2020-12-20'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('202012200841_Version.sql') FROM dual
;

