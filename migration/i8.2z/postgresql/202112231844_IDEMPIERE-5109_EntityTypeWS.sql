-- Set Entity Type for Web Services Tables
UPDATE ad_table SET entitytype='EXT' WHERE tablename IN (
'WS_WebService',
'WS_WebServiceFieldInput',
'WS_WebServiceFieldOutput',
'WS_WebServiceMethod',
'WS_WebServiceType',
'WS_WebServiceTypeAccess',
'WS_WebService_Para'
)
;

SELECT register_migration_script('202112231844_IDEMPIERE-5109_EntityTypeWS.sql') FROM dual
;

