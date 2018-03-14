UPDATE AD_SYSTEM
   SET releaseno = '2.0',
       VERSION = '2013-10-31'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('201310312246_Version.sql') FROM dual
;

