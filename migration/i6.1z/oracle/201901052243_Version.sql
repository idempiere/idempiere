UPDATE AD_SYSTEM
   SET releaseno = '6.2',
       VERSION = '2019-01-06'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

COMMIT
;

SELECT register_migration_script('201901052243_Version.sql') FROM dual
;

