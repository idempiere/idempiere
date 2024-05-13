-- Set Version
UPDATE AD_SYSTEM
   SET releaseno = '11',
       VERSION = '2023-12-24'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('202312221325_IDEMPIERE-5967_Version.sql') FROM dual
;

