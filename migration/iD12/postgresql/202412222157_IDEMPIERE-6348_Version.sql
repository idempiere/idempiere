-- Set Version
UPDATE AD_SYSTEM
   SET releaseno = '12',
       VERSION = '2024-12-24'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('202412222157_IDEMPIERE-6348_Version.sql') FROM dual
;

