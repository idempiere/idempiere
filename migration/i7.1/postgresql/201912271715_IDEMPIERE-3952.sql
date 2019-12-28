-- IDEMPIERE-3952  EntityType and Data Access Level review for tables
-- Dec 27, 2019, 5:14:30 PM CET
INSERT INTO t_alter_column values('AD_InfoProcess','EntityType','VARCHAR(40)',null,'U')
;

INSERT INTO t_alter_column values('AD_InfoRelated','EntityType','VARCHAR(40)',null,'U')
;

INSERT INTO t_alter_column values('AD_SearchDefinition','EntityType','VARCHAR(40)',null,'U')
;

INSERT INTO t_alter_column values('AD_Style','EntityType','VARCHAR(40)',null,'U')
;

INSERT INTO t_alter_column values('AD_StyleLine','EntityType','VARCHAR(40)',null,'U')
;

INSERT INTO t_alter_column values('AD_ToolBarButton','EntityType','VARCHAR(40)',null,'U')
;

INSERT INTO t_alter_column values('AD_ZoomCondition','EntityType','VARCHAR(40)',null,'U')
;

INSERT INTO t_alter_column values('PA_DocumentStatus','EntityType','VARCHAR(40)',null,'U')
;

SELECT register_migration_script('201912271715_IDEMPIERE-3952.sql') FROM dual
;

