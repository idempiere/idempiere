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
ALTER TABLE AD_InfoProcess MODIFY EntityType NOT NULL
;

-- Apr 21, 2019, 12:48:28 PM CEST
ALTER TABLE AD_InfoRelated MODIFY EntityType NOT NULL
;

-- Apr 21, 2019, 12:48:48 PM CEST
ALTER TABLE AD_SearchDefinition MODIFY EntityType NOT NULL
;

-- Apr 21, 2019, 12:49:00 PM CEST
ALTER TABLE AD_Style MODIFY EntityType NOT NULL
;

-- Apr 21, 2019, 12:49:10 PM CEST
ALTER TABLE AD_StyleLine MODIFY EntityType NOT NULL
;

-- Apr 21, 2019, 12:49:26 PM CEST
ALTER TABLE AD_ToolBarButton MODIFY EntityType NOT NULL
;

-- Apr 21, 2019, 12:49:46 PM CEST
ALTER TABLE AD_ZoomCondition MODIFY EntityType NOT NULL
;

-- Apr 21, 2019, 12:49:59 PM CEST
ALTER TABLE PA_DocumentStatus MODIFY EntityType NOT NULL
;

SELECT register_migration_script('201904211240_IDEMPIERE-3952.sql') FROM dual
;

