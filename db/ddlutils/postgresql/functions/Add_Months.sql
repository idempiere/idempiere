CREATE OR REPLACE FUNCTION add_months (datetime TIMESTAMP WITH TIME ZONE, months NUMERIC)
RETURNS TIMESTAMP WITH TIME ZONE AS $$
BEGIN
	if datetime is null or months is null then
		return null;
	end if;
	return datetime + (interval '1' month * TRUNC(months));
END;
$$ LANGUAGE plpgsql IMMUTABLE
;

