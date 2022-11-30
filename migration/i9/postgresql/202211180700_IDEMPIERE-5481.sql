SELECT register_migration_script('202211180700_IDEMPIERE-5481.sql') FROM dual;

CREATE OR REPLACE FUNCTION trunc(datetime TIMESTAMP WITHOUT TIME ZONE, format varchar)
RETURNS DATE AS $$
BEGIN
	IF format = 'Q' THEN
		RETURN CAST(DATE_Trunc('quarter',datetime) as DATE);
	ELSIF format = 'Y' or format = 'YEAR' THEN
		RETURN CAST(DATE_Trunc('year',datetime) as DATE);
	ELSIF format = 'MM' or format = 'MONTH' THEN
		RETURN CAST(DATE_Trunc('month',datetime) as DATE);
	ELSIF format = 'DD' THEN
		RETURN CAST(DATE_Trunc('day',datetime) as DATE);
	ELSIF format = 'DY' THEN
		RETURN CAST(DATE_Trunc('day',datetime) as DATE);
	ELSE
		RETURN CAST(datetime AS DATE);
	END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION trunc(datetime TIMESTAMP WITH TIME ZONE, format varchar)
RETURNS DATE AS $$
BEGIN
		RETURN trunc(cast(datetime as timestamp without time zone), format);
END;
$$ LANGUAGE plpgsql IMMUTABLE;
