ALTER TABLE M_Shipper DROP CONSTRAINT m_shipper_unique_columns;

-- Feb 19, 2013 2:59:58 PM SGT
-- IDEMPIERE-602 Remove Furniture/Fertilizer Internal Shipper from System
DELETE FROM X_Shipper WHERE X_Shipper_ID=200000
;

-- Feb 19, 2013 3:00:01 PM SGT
-- IDEMPIERE-602 Remove Furniture/Fertilizer Internal Shipper from System
DELETE FROM X_Shipper WHERE X_Shipper_ID=200001
;

-- Feb 19, 2013 3:00:04 PM SGT
-- IDEMPIERE-602 Remove Furniture/Fertilizer Internal Shipper from System
DELETE FROM X_Shipper WHERE X_Shipper_ID=200002
;

UPDATE M_Shipper SET X_Shipper_ID = NULL WHERE X_Shipper_ID NOT IN (SELECT X_Shipper_ID FROM X_Shipper);

SELECT register_migration_script('201302191525_IDEMPIERE-602.sql') FROM dual
;