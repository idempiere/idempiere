-- IDEMPIERE-4178 Replace NVL with Coalesce
CREATE or REPLACE FUNCTION nvl (anyelement, anyelement ) RETURNS anyelement
LANGUAGE plpgsql
IMMUTABLE 
AS $function$  
BEGIN
    RETURN coalesce($1, $2);
END;
$function$
;

CREATE or REPLACE FUNCTION nvl (numeric, integer ) RETURNS numeric
LANGUAGE plpgsql
IMMUTABLE 
AS $function$  
BEGIN
    RETURN nvl($1, $2::numeric);
END;
$function$
;

CREATE or REPLACE FUNCTION nvl (integer, numeric ) RETURNS numeric
LANGUAGE plpgsql
IMMUTABLE 
AS $function$  
BEGIN
    RETURN nvl($1::numeric, $2);
END;
$function$
;

SELECT register_migration_script('202002211000_IDEMPIERE-4178.sql') FROM dual
;
