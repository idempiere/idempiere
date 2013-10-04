-- Oct 4, 2013 2:48:55 PM MYT
-- IDEMPIERE-1196 Create a service to manage Home Widgets.
UPDATE AD_Element SET Help='URI for Dashboard Gadget. This can be absolute path to a zul file or an unique gadget id which is instantiated through OSGi factory services.', Name='Gadget URI', Description='URI for Dashboard Gadget', PrintName='Gadget URI',Updated=TO_TIMESTAMP('2013-10-04 14:48:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53710
;

-- Oct 4, 2013 2:48:56 PM MYT
-- IDEMPIERE-1196 Create a service to manage Home Widgets.
UPDATE AD_Column SET ColumnName='ZulFilePath', Name='Gadget URI', Description='URI for Dashboard Gadget', Help='URI for Dashboard Gadget. This can be absolute path to a zul file or an unique gadget id which is instantiated through OSGi factory services.' WHERE AD_Element_ID=53710
;

-- Oct 4, 2013 2:48:56 PM MYT
-- IDEMPIERE-1196 Create a service to manage Home Widgets.
UPDATE AD_Process_Para SET ColumnName='ZulFilePath', Name='Gadget URI', Description='URI for Dashboard Gadget', Help='URI for Dashboard Gadget. This can be absolute path to a zul file or an unique gadget id which is instantiated through OSGi factory services.', AD_Element_ID=53710 WHERE UPPER(ColumnName)='ZULFILEPATH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 4, 2013 2:48:56 PM MYT
-- IDEMPIERE-1196 Create a service to manage Home Widgets.
UPDATE AD_Process_Para SET ColumnName='ZulFilePath', Name='Gadget URI', Description='URI for Dashboard Gadget', Help='URI for Dashboard Gadget. This can be absolute path to a zul file or an unique gadget id which is instantiated through OSGi factory services.' WHERE AD_Element_ID=53710 AND IsCentrallyMaintained='Y'
;

-- Oct 4, 2013 2:48:56 PM MYT
-- IDEMPIERE-1196 Create a service to manage Home Widgets.
UPDATE AD_InfoColumn SET ColumnName='ZulFilePath', Name='Gadget URI', Description='URI for Dashboard Gadget', Help='URI for Dashboard Gadget. This can be absolute path to a zul file or an unique gadget id which is instantiated through OSGi factory services.' WHERE AD_Element_ID=53710 AND IsCentrallyMaintained='Y'
;

-- Oct 4, 2013 2:48:56 PM MYT
-- IDEMPIERE-1196 Create a service to manage Home Widgets.
UPDATE AD_Field SET Name='Gadget URI', Description='URI for Dashboard Gadget', Help='URI for Dashboard Gadget. This can be absolute path to a zul file or an unique gadget id which is instantiated through OSGi factory services.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53710) AND IsCentrallyMaintained='Y'
;

-- Oct 4, 2013 2:48:56 PM MYT
-- IDEMPIERE-1196 Create a service to manage Home Widgets.
UPDATE AD_PrintFormatItem SET PrintName='Gadget URI', Name='Gadget URI' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53710)
;

SELECT register_migration_script('201310040650_IDEMPIERE-1196.sql') FROM dual
;

