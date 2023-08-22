-- IDEMPIERE-3916 Process to move client between databases
-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
DROP TABLE T_MoveClient
;

CREATE TABLE T_MoveClient (AD_PInstance_ID NUMERIC(10), TableName VARCHAR(40), Source_Key VARCHAR(36), Target_Key VARCHAR(36))
;

CREATE UNIQUE INDEX UX_T_MoveClient ON T_MoveClient (AD_PInstance_ID,TableName,Source_Key)
;

SELECT register_migration_script('202308171647_IDEMPIERE-5567.sql') FROM dual
;

