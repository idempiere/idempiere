-- Set Version
UPDATE AD_SYSTEM
   SET releaseno = '13',
       VERSION = '2026-03-09'
 WHERE ad_system_id = 0 AND ad_client_id = 0
;

SELECT register_migration_script('202603090019_IDEMPIERE-6894_Version.sql') FROM dual
;

