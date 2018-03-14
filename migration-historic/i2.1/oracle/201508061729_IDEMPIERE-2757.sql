SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2757 Key for M_Storage wrongly defined on dictionary
-- Aug 6, 2015 5:28:43 PM COT
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_DATE('2015-08-06 17:28:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210887
;

SELECT register_migration_script('201508061729_IDEMPIERE-2757.sql') FROM dual
;

