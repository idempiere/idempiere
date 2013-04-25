-- IDEMPIERE-765 Client Name must be non unique / search key must be unique 
DROP INDEX ad_client_name;

CREATE UNIQUE INDEX ad_client_value
	ON AD_Client (value);

SELECT register_migration_script('201303151137_IDEMPIERE-765.sql') FROM dual;
