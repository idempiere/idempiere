SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2778  2pack: column size for SQL statement shall be extended
-- Aug 20, 2015 3:37:36 PM CEST
UPDATE AD_Column SET FieldLength=4000,Updated=TO_DATE('2015-08-20 15:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50122
;

-- Aug 20, 2015 3:37:48 PM CEST
ALTER TABLE AD_Package_Exp_Detail MODIFY SQLStatement VARCHAR2(4000) DEFAULT NULL 
;

SELECT register_migration_script('201508201340_IDEMPIERE-2778.sql') FROM dual
;
