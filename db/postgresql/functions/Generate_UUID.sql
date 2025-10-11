/*
*This file is part of iDempiere ERP
*http://www.idempiere.org
*
*This program is free software; you can redistribute it and/or
*modify it under the terms of the GNU General Public License
*as published by the Free Software Foundation; either version 2
*of the License, or (at your option) any later version.
*
*This program is distributed in the hope that it will be useful,
*but WITHOUT ANY WARRANTY; without even the implied warranty of
*MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*GNU General Public License for more details.
*
*You should have received a copy of the GNU General Public License
*along with this program; if not, write to the Free Software
*Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.of
*/

-- DROP FUNCTION IF EXISTS Generate_UUID();

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

/*
-- Function that extracts the timestamp from uuidv7, it must be the same as the Created column
CREATE OR REPLACE FUNCTION uuid_v7_to_timestamp(uuid_val uuid)
RETURNS timestamp with time zone AS $$
DECLARE
  uuid_bytes bytea;
  unix_ts_ms bigint;
BEGIN
  -- Convert UUID to bytes
  uuid_bytes = decode(replace(uuid_val::text, '-', ''), 'hex');
  -- Extract first 48 bits (6 bytes) as timestamp in milliseconds
  unix_ts_ms = (get_byte(uuid_bytes, 0)::bigint << 40) |
               (get_byte(uuid_bytes, 1)::bigint << 32) |
               (get_byte(uuid_bytes, 2)::bigint << 24) |
               (get_byte(uuid_bytes, 3)::bigint << 16) |
               (get_byte(uuid_bytes, 4)::bigint << 8) |
               get_byte(uuid_bytes, 5)::bigint;
  -- Convert milliseconds to timestamp
  RETURN to_timestamp(unix_ts_ms / 1000.0);
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
*/
