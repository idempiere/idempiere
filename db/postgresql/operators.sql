CREATE OPERATOR adempiere.+ (
    PROCEDURE = adempiere.adddays,
    LEFTARG = interval,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(adempiere.-)
);

CREATE OPERATOR adempiere.+ (
    PROCEDURE = adempiere.adddays,
    LEFTARG = timestamp with time zone,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(adempiere.+)
);

CREATE OPERATOR adempiere.- (
    PROCEDURE = adempiere.subtractdays,
    LEFTARG = interval,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(adempiere.-)
);

CREATE OPERATOR adempiere.- (
    PROCEDURE = adempiere.subtractdays,
    LEFTARG = timestamp with time zone,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(adempiere.-)
);
