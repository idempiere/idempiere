SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 19, 2018 11:01:06 PM CEST
-- IDEMPIERE-3716 Extend the length of the Column SQL field in AD_ViewColumn to allow more advanced queries	
UPDATE AD_Column SET FieldLength=2000,Updated=TO_DATE('2018-05-19 23:01:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210586
;

-- May 19, 2018 11:01:08 PM CEST
ALTER TABLE AD_ViewColumn ADD Tmp_ColumnSQL VARCHAR2(2000) DEFAULT NULL;
UPDATE AD_ViewColumn SET Tmp_ColumnSQL = ColumnSQL;
ALTER TABLE AD_ViewColumn DROP COLUMN ColumnSQL;
ALTER TABLE AD_ViewColumn RENAME COLUMN Tmp_ColumnSQL TO ColumnSQL;

SELECT register_migration_script('201805200007_IDEMPIERE-3716.sql') FROM dual
;
