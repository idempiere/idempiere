UPDATE AD_SYSTEM
   SET releaseno = '1.0b',
       VERSION = '2013-04-24'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('201304241732_Version.sql') FROM dual
;

