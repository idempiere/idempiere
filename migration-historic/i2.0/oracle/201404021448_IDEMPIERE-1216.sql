SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 2, 2014 2:46:52 PM COT
-- fix wrong length of PA_DashboardContent_Trl.Name
UPDATE AD_Column SET FieldLength=120,Updated=TO_DATE('2014-04-02 14:46:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=60126
;

-- Apr 2, 2014 2:46:54 PM COT
ALTER TABLE PA_DashboardContent_Trl MODIFY Name NVARCHAR2(120)
;

SELECT register_migration_script('201404021448_IDEMPIERE-1216.sql') FROM dual
;

