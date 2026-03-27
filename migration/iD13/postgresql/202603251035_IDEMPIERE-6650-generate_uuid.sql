-- IDEMPIERE-6650 Performance - Implement support for using the uuid postgres datatype (FHCA-7074)
-- recreate generate_uuid function to return uuid instead of varchar
-- changed to return a uuidv7 - if you want to stay with v4 then uncomment the lines at the end

-- v7
CREATE OR REPLACE FUNCTION Generate_UUID(ts timestamp with time zone DEFAULT clock_timestamp())
RETURNS uuid AS $$
DECLARE
  unix_ts_ms bigint;
  uuid_bytes bytea;
  random_part bytea;
BEGIN
  IF current_setting('server_version_num')::int >= 180000 THEN
    /* postgresql 18 uuidv7 use native */
    RETURN uuidv7(ts - clock_timestamp());
  ELSE
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
  END IF;
END;
$$ LANGUAGE plpgsql VOLATILE;

SELECT register_migration_script('202603251035_IDEMPIERE-6650-generate_uuid.sql') FROM dual;

