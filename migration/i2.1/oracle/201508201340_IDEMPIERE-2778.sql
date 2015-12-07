SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2778  2pack: column size for SQL statement shall be extended
-- Aug 20, 2015 3:37:36 PM CEST
UPDATE AD_Column SET FieldLength=4000,Updated=TO_DATE('2015-08-20 15:37:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50122
;

-- Column is NVARCHAR so we must drop it before changing its type to VARCHAR
ALTER TABLE AD_Package_Exp_Detail ADD Tmp_SQLStatement VARCHAR2(4000) DEFAULT NULL
;

UPDATE AD_Package_Exp_Detail SET Tmp_SQLStatement = TO_CHAR(SQLStatement)
;

ALTER TABLE AD_Package_Exp_Detail DROP COLUMN SQLStatement
;

ALTER TABLE AD_Package_Exp_Detail RENAME COLUMN Tmp_SQLStatement TO SQLStatement
;

SELECT register_migration_script('201508201340_IDEMPIERE-2778.sql') FROM dual
;
