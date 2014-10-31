UPDATE AD_SYSTEM
   SET releaseno = '2.1',
       VERSION = '2014-10-31'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('201410310000_Version.sql') FROM dual
;

