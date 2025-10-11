-- IDEMPIERE-6650 Performance - Implement support for using the uuid postgres datatype (FHCA-7074)
-- recreate generate_uuid function to return uuid instead of varchar
-- changed to return a uuidv7 - if you want to stay with v4 then uncomment the lines at the end

DROP FUNCTION IF EXISTS Generate_UUID();

-- v7
CREATE OR REPLACE FUNCTION Generate_UUID(ts timestamp with time zone DEFAULT clock_timestamp())
RETURNS uuid AS $$
DECLARE
  unix_ts_ms bigint;
  uuid_bytes bytea;
  random_part bytea;
BEGIN
  /* NOTE: in postgresql 18 uuidv7 will be native, and you can change this script to benefit from the native function */
  -- Get timestamp in milliseconds
  unix_ts_ms = floor(extract(epoch from ts) * 1000)::bigint;
  -- Convert timestamp to 6 bytes (48 bits)
  unix_ts_ms = unix_ts_ms & x'FFFFFFFFFFFF'::bigint;
  -- Get random bytes from gen_random_uuid()
  random_part = decode(replace(gen_random_uuid()::text, '-', ''), 'hex');
  -- Construct UUID v7: 48-bit timestamp + version/variant + random
  uuid_bytes = 
    substring(int8send(unix_ts_ms) from 3 for 6) || -- 48-bit timestamp
    substring(random_part from 7 for 2) ||           -- 16-bit random (with version)
    substring(random_part from 9 for 8);             -- 64-bit random (with variant)
  -- Set version to 7 (0111)
  uuid_bytes = set_byte(uuid_bytes, 6, (get_byte(uuid_bytes, 6) & 15) | 112);
  -- Set variant to 10
  uuid_bytes = set_byte(uuid_bytes, 8, (get_byte(uuid_bytes, 8) & 63) | 128);
  RETURN encode(uuid_bytes, 'hex')::uuid;
END;
$$ LANGUAGE plpgsql VOLATILE;

/*
-- v4
CREATE FUNCTION Generate_UUID()
RETURNS uuid AS $$
  SELECT uuid_generate_v4();
$$ LANGUAGE SQL VOLATILE;
*/

CREATE OR REPLACE FUNCTION torecordid(
	p_tablename  IN 	VARCHAR,
	p_uu_value IN 	VARCHAR
)
  RETURNS INTEGER AS $body$
DECLARE
     id_column VARCHAR;
     uu_column VARCHAR;
     o_id INTEGER;
BEGIN
     SELECT a.ColumnName 
     INTO id_column
     FROM AD_Column a 
     JOIN AD_Table b ON (a.AD_Table_ID=b.AD_Table_ID) 
     WHERE a.IsActive='Y' AND a.IsKey='Y' AND  lower(b.TableName) = lower(p_tablename);

     IF (id_column IS NULL) THEN
         RAISE EXCEPTION 'ID column not found for table %', p_tablename;
     END IF;

     IF (length(p_tablename) <= 27) THEN
         uu_column = p_tablename || '_UU';
     ELSE
         SELECT a.ColumnName 
         INTO uu_column
         FROM AD_Column a 
        JOIN AD_Table b ON (a.AD_Table_ID=b.AD_Table_ID) 
         WHERE a.IsActive='Y' AND lower(ColumnName) like (lower(substring(p_tablename from 0 for 27)) || '%UU')
         AND  lower(b.TableName) = lower(p_tablename);
     END IF;
     
     IF (uu_column IS NULL) THEN
         RAISE EXCEPTION 'UUID column not found for table %', p_tablename;
     END IF;

     EXECUTE 'SELECT ' || quote_ident(lower(id_column)) || ' FROM ' || quote_ident(lower(p_tablename)) || ' WHERE ' ||  uu_column || '=$1::uuid'
     INTO STRICT o_id
     USING p_uu_value;

     RETURN o_id;
END;
$body$ LANGUAGE plpgsql;

SELECT register_migration_script('202510101903_IDEMPIERE-6650-generate_uuid.sql') FROM dual;

