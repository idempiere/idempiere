UPDATE AD_SYSTEM
   SET releaseno = '1.0a',
       VERSION = '2012-10-31'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('958_Version.sql') FROM dual
;

