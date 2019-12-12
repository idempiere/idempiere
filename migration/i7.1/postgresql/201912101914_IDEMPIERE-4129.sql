-- IDEMPIERE-4129  Increase field size t_selection.viewid (FHCA-1130)
-- Dec 10, 2019, 7:14:05 PM CET
INSERT INTO t_alter_column values('T_Selection','ViewID','VARCHAR(2000)',null,null)
;

INSERT INTO t_alter_column values('T_Selection_InfoWindow','ViewID','VARCHAR(2000)',null,null)
;

SELECT register_migration_script('201912101914_IDEMPIERE-4129.sql') FROM dual
;

