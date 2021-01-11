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

