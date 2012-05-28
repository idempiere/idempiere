/* iDempiere NOTE:
Use this script to enable uuid generation JUST on postgresql versions prior to 9.1
For Postgresql 9.1, run the CREATE EXTENSION "uuid-ossp" sql command instead of using this script
*/


/* $PostgreSQL: pgsql/contrib/uuid-ossp/uuid-ossp.sql.in,v 1.6 2007/11/13 04:24:29 momjian Exp $ */

-- Adjust this setting to control where the objects get created.
SET search_path = adempiere;

CREATE OR REPLACE FUNCTION uuid_nil()
RETURNS uuid
AS '$libdir/uuid-ossp', 'uuid_nil'
IMMUTABLE STRICT LANGUAGE C;

CREATE OR REPLACE FUNCTION uuid_ns_dns()
RETURNS uuid
AS '$libdir/uuid-ossp', 'uuid_ns_dns'
IMMUTABLE STRICT LANGUAGE C;

CREATE OR REPLACE FUNCTION uuid_ns_url()
RETURNS uuid
AS '$libdir/uuid-ossp', 'uuid_ns_url'
IMMUTABLE STRICT LANGUAGE C;

CREATE OR REPLACE FUNCTION uuid_ns_oid()
RETURNS uuid
AS '$libdir/uuid-ossp', 'uuid_ns_oid'
IMMUTABLE STRICT LANGUAGE C;

CREATE OR REPLACE FUNCTION uuid_ns_x500()
RETURNS uuid
AS '$libdir/uuid-ossp', 'uuid_ns_x500'
IMMUTABLE STRICT LANGUAGE C;

CREATE OR REPLACE FUNCTION uuid_generate_v1()
RETURNS uuid
AS '$libdir/uuid-ossp', 'uuid_generate_v1'
VOLATILE STRICT LANGUAGE C;

CREATE OR REPLACE FUNCTION uuid_generate_v1mc()
RETURNS uuid
AS '$libdir/uuid-ossp', 'uuid_generate_v1mc'
VOLATILE STRICT LANGUAGE C;

CREATE OR REPLACE FUNCTION uuid_generate_v3(namespace uuid, name text)
RETURNS uuid
AS '$libdir/uuid-ossp', 'uuid_generate_v3'
IMMUTABLE STRICT LANGUAGE C;

CREATE OR REPLACE FUNCTION uuid_generate_v4()
RETURNS uuid
AS '$libdir/uuid-ossp', 'uuid_generate_v4'
VOLATILE STRICT LANGUAGE C;

CREATE OR REPLACE FUNCTION uuid_generate_v5(namespace uuid, name text)
RETURNS uuid
AS '$libdir/uuid-ossp', 'uuid_generate_v5'
IMMUTABLE STRICT LANGUAGE C;
