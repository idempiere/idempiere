-- Set Version
UPDATE AD_SYSTEM
   SET releaseno = '7.1',
       VERSION = '2019-11-22'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;


SELECT register_migration_script('201911212227_Version.sql') FROM dual
;

