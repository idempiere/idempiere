UPDATE AD_SYSTEM
   SET releaseno = '1.0c',
       VERSION = '2013-06-27'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('201306262016_Version.sql') FROM dual
;

