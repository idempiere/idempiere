SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3916 Process to move client between databases
-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
DROP TABLE T_MoveClient
;

CREATE TABLE T_MoveClient (AD_PInstance_ID NUMBER(10), TableName VARCHAR2(40 CHAR), Source_Key VARCHAR2(36 CHAR), Target_Key VARCHAR2(36 CHAR))
;

CREATE UNIQUE INDEX UX_T_MoveClient ON T_MoveClient (AD_PInstance_ID,TableName,Source_Key)
;

SELECT register_migration_script('202308171647_IDEMPIERE-5567.sql') FROM dual
;

