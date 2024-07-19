-- IDEMPIERE-5484 Import GL Journal fails with SQL error because of NVL
SELECT register_migration_script('202211201304_IDEMPIERE-5484.sql') FROM dual;

CREATE or REPLACE FUNCTION nvl (text, text ) RETURNS text
LANGUAGE plpgsql
IMMUTABLE 
AS $function$  
BEGIN
    RETURN COALESCE($1, $2);
END;
$function$
;

