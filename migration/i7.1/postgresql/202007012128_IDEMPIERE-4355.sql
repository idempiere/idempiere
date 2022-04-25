-- IDEMPIERE-4355 Wrong DATE/INTEGER columns in postgresql
-- Jul 1, 2020, 9:22:53 PM CEST
INSERT INTO t_alter_column values('ad_broadcastmessage','Updated','TIMESTAMP',null,'statement_timestamp()')
;

-- Jul 1, 2020, 9:22:53 PM CEST
UPDATE AD_BroadcastMessage SET Updated=statement_timestamp() WHERE Updated IS NULL
;

-- Jul 1, 2020, 9:24:06 PM CEST
INSERT INTO t_alter_column values('ad_modelvalidator','Updated','TIMESTAMP',null,'statement_timestamp()')
;

-- Jul 1, 2020, 9:24:06 PM CEST
UPDATE AD_ModelValidator SET Updated=statement_timestamp() WHERE Updated IS NULL
;

-- Jul 1, 2020, 9:25:05 PM CEST
INSERT INTO t_alter_column values('c_bpartner','DunningGrace','TIMESTAMP',null,'NULL')
;

-- Jul 1, 2020, 9:25:38 PM CEST
INSERT INTO t_alter_column values('c_invoice','DunningGrace','TIMESTAMP',null,'NULL')
;

-- Jul 1, 2020, 9:26:03 PM CEST
INSERT INTO t_alter_column values('c_ordersource','Created','TIMESTAMP',null,'statement_timestamp()')
;

-- Jul 1, 2020, 9:26:03 PM CEST
UPDATE C_OrderSource SET Created=statement_timestamp() WHERE Created IS NULL
;

-- Jul 1, 2020, 9:26:16 PM CEST
INSERT INTO t_alter_column values('c_ordersource','Updated','TIMESTAMP',null,'statement_timestamp()')
;

-- Jul 1, 2020, 9:26:16 PM CEST
UPDATE C_OrderSource SET Updated=statement_timestamp() WHERE Updated IS NULL
;

-- Jul 1, 2020, 9:26:41 PM CEST
INSERT INTO t_alter_column values('u_rolemenu','CreatedBy','NUMERIC(10)',null,null)
;

-- Jul 1, 2020, 9:27:02 PM CEST
INSERT INTO t_alter_column values('u_rolemenu','UpdatedBy','NUMERIC(10)',null,null)
;

-- Jul 1, 2020, 9:27:25 PM CEST
INSERT INTO t_alter_column values('u_web_properties','CreatedBy','NUMERIC(10)',null,null)
;

-- Jul 1, 2020, 9:27:40 PM CEST
INSERT INTO t_alter_column values('u_web_properties','UpdatedBy','NUMERIC(10)',null,null)
;

SELECT register_migration_script('202007012128_IDEMPIERE-4355.sql') FROM dual
;

