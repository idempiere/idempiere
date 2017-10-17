-- IDEMPIERE-3519:column updated, created of c_salesregion_trl isn't yet sync so miss default value
-- Oct 13, 2017 12:41:29 PM ICT
INSERT INTO t_alter_column values('c_salesregion_trl','Created','TIMESTAMP',null,'statement_timestamp()')
;

-- Oct 13, 2017 12:41:53 PM ICT
INSERT INTO t_alter_column values('c_salesregion_trl','Updated','TIMESTAMP',null,'statement_timestamp()')
;

SELECT register_migration_script('201710131604-IDEMPIERE-3519.sql') FROM dual
;
