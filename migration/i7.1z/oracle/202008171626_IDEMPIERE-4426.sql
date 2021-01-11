-- IDEMPIERE-4426 Fix add_months and adddays functions
SET SQLBLANKLINES ON
SET DEFINE OFF

CREATE OR REPLACE FUNCTION addDays
(
    p_date      DATE,
    p_days      NUMBER
)
 	RETURN DATE
AS
BEGIN
    RETURN p_date + p_days;
END;
/

SELECT register_migration_script('202008171626_IDEMPIERE-4426.sql') FROM dual
;

