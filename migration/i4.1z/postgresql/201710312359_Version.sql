UPDATE AD_SYSTEM
   SET releaseno = '5.1',
       VERSION = '2017-10-31'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('201710312359_Version.sql') FROM dual
;

