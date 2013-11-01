-- Jul 3, 2013 6:25:43 PM COT
-- IDEMPIERE-1121 Field Customization IsUpdateable mandatory on DB not in dict
ALTER TABLE AD_UserDef_Field MODIFY IsUpdateable CHAR(1) DEFAULT NULL 
;

-- Jul 3, 2013 6:25:44 PM COT
-- IDEMPIERE-1121 Field Customization IsUpdateable mandatory on DB not in dict
ALTER TABLE AD_UserDef_Field MODIFY IsUpdateable NULL
;

SELECT register_migration_script('20130603182945_IDEMPIERE-1121.sql') FROM dual
;

