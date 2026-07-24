--     IDEMPIERE-7065  Allow requests without initial SalesRep
SELECT register_migration_script('202607221326_IDEMPIERE-7065.sql') FROM dual;

-- Jul 22, 2026, 1:26:01 PM CEST
INSERT INTO t_alter_column values('r_request','SalesRep_ID','NUMERIC(10)',null,'NULL')
;

-- Jul 22, 2026, 1:26:01 PM CEST
INSERT INTO t_alter_column values('r_request','SalesRep_ID',null,'NULL',null)
;

