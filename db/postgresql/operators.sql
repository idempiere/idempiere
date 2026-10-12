/*
 * NOTE that the lines defining COMMUTATOR are useless
 * they are harmless but useless
 * but deleting that line implies deleting and recreating all views that depende on the operators
 * so, leaving there as harmless
 * the implication is if somebody tries to use the commutator operator postgresql will throw error
 * SQL Error [42883]: ERROR: operator is only a shell: numeric - timestamp with time zone
 * f.e.:
 *   SELECT now() - 1    -- success
 *   SELECT 1 - now()    -- it tries to apply subtractdays and fails
 * to solve it, it would require to implement a function subtractdays(numeric, timestamp with time zone)
 * and change the operator to use the COMMUTATOR with the same operator
*/

CREATE OPERATOR + (
    PROCEDURE = adddays,
    LEFTARG = interval,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(-)
);

CREATE OPERATOR + (
    PROCEDURE = adddays,
    LEFTARG = timestamp with time zone,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(+)
);

CREATE OPERATOR - (
    FUNCTION = subtractdays,
    LEFTARG = interval,
    RIGHTARG = numeric
);

CREATE OPERATOR - (
    PROCEDURE = subtractdays,
    LEFTARG = timestamp with time zone,
    RIGHTARG = numeric,
    COMMUTATOR = OPERATOR(-)
);
