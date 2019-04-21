UPDATE AD_ZoomCondition SET EntityType='D' WHERE AD_ZoomCondition_ID<1000000 AND EntityType IS NULL;
UPDATE AD_Style SET EntityType='D' WHERE AD_Style_ID<1000000 AND EntityType IS NULL;
UPDATE AD_StyleLine SET EntityType='D' WHERE AD_StyleLine_ID<1000000 AND EntityType IS NULL;
UPDATE AD_ToolBarButton SET EntityType='D' WHERE AD_ToolBarButton_ID<1000000 AND EntityType IS NULL;
UPDATE AD_SearchDefinition SET EntityType='D' WHERE AD_SearchDefinition_ID<1000000 AND EntityType IS NULL;
UPDATE PA_DocumentStatus SET EntityType='D' WHERE PA_DocumentStatus_ID<1000000 AND EntityType IS NULL;
UPDATE AD_InfoRelated SET EntityType='D' WHERE AD_InfoRelated_ID<1000000 AND EntityType IS NULL;
UPDATE AD_InfoProcess SET EntityType='D' WHERE AD_InfoProcess_ID<1000000 AND EntityType IS NULL;

UPDATE AD_ZoomCondition SET EntityType='U' WHERE AD_ZoomCondition_ID>=1000000 AND EntityType IS NULL;
UPDATE AD_Style SET EntityType='U' WHERE AD_Style_ID>=1000000 AND EntityType IS NULL;
UPDATE AD_StyleLine SET EntityType='U' WHERE AD_StyleLine_ID>=1000000 AND EntityType IS NULL;
UPDATE AD_ToolBarButton SET EntityType='U' WHERE AD_ToolBarButton_ID>=1000000 AND EntityType IS NULL;
UPDATE AD_SearchDefinition SET EntityType='U' WHERE AD_SearchDefinition_ID>=1000000 AND EntityType IS NULL;
UPDATE PA_DocumentStatus SET EntityType='U' WHERE PA_DocumentStatus_ID>=1000000 AND EntityType IS NULL;
UPDATE AD_InfoRelated SET EntityType='U' WHERE AD_InfoRelated_ID>=1000000 AND EntityType IS NULL;
UPDATE AD_InfoProcess SET EntityType='U' WHERE AD_InfoProcess_ID>=1000000 AND EntityType IS NULL;

-- Apr 21, 2019, 12:47:36 PM CEST
INSERT INTO t_alter_column values('ad_infoprocess','EntityType',null,'NOT NULL',null)
;

-- Apr 21, 2019, 12:48:28 PM CEST
INSERT INTO t_alter_column values('ad_inforelated','EntityType',null,'NOT NULL',null)
;

-- Apr 21, 2019, 12:48:48 PM CEST
INSERT INTO t_alter_column values('ad_searchdefinition','EntityType',null,'NOT NULL',null)
;

-- Apr 21, 2019, 12:49:00 PM CEST
INSERT INTO t_alter_column values('ad_style','EntityType',null,'NOT NULL',null)
;

-- Apr 21, 2019, 12:49:10 PM CEST
INSERT INTO t_alter_column values('ad_styleline','EntityType',null,'NOT NULL',null)
;

-- Apr 21, 2019, 12:49:26 PM CEST
INSERT INTO t_alter_column values('ad_toolbarbutton','EntityType',null,'NOT NULL',null)
;

-- Apr 21, 2019, 12:49:46 PM CEST
INSERT INTO t_alter_column values('ad_zoomcondition','EntityType',null,'NOT NULL',null)
;

-- Apr 21, 2019, 12:49:59 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','EntityType',null,'NOT NULL',null)
;

SELECT register_migration_script('201904211240_IDEMPIERE-3952.sql') FROM dual
;

