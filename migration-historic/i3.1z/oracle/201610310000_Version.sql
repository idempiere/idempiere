UPDATE AD_SYSTEM
   SET releaseno = '4.1',
       VERSION = '2016-10-31'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

COMMIT
;

SELECT register_migration_script('201610310000_Version.sql') FROM dual
;

