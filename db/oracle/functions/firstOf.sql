CREATE OR REPLACE FUNCTION firstOf
(
    p_date      DATE,
    p_datePart  VARCHAR2
)
 	RETURN DATE
AS
BEGIN
    RETURN TRUNC(p_date, p_datePart);
END;
/
