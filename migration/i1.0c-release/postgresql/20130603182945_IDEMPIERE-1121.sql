-- Jul 3, 2013 6:25:43 PM COT
-- IDEMPIERE-1121 Field Customization IsUpdateable mandatory on DB not in dict
INSERT INTO t_alter_column values('ad_userdef_field','IsUpdateable','CHAR(1)',null,'NULL')
;

-- Jul 3, 2013 6:25:44 PM COT
-- IDEMPIERE-1121 Field Customization IsUpdateable mandatory on DB not in dict
INSERT INTO t_alter_column values('ad_userdef_field','IsUpdateable',null,'NULL',null)
;

SELECT register_migration_script('20130603182945_IDEMPIERE-1121.sql') FROM dual
;

