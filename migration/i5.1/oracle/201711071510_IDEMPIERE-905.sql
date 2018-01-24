SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-905 Post-it functionality
-- Nov 7, 2017 3:09:53 PM CET
UPDATE AD_Element SET ColumnName='AD_PostIt_ID',Updated=TO_DATE('2017-11-07 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203056
;

-- Nov 7, 2017 3:09:53 PM CET
UPDATE AD_Column SET ColumnName='AD_PostIt_ID', Name='Post-it', Description=NULL, Help=NULL WHERE AD_Element_ID=203056
;

-- Nov 7, 2017 3:09:53 PM CET
UPDATE AD_Process_Para SET ColumnName='AD_PostIt_ID', Name='Post-it', Description=NULL, Help=NULL, AD_Element_ID=203056 WHERE UPPER(ColumnName)='AD_POSTIT_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 7, 2017 3:09:53 PM CET
UPDATE AD_Process_Para SET ColumnName='AD_PostIt_ID', Name='Post-it', Description=NULL, Help=NULL WHERE AD_Element_ID=203056 AND IsCentrallyMaintained='Y'
;

-- Nov 7, 2017 3:09:53 PM CET
UPDATE AD_InfoColumn SET ColumnName='AD_PostIt_ID', Name='Post-it', Description=NULL, Help=NULL WHERE AD_Element_ID=203056 AND IsCentrallyMaintained='Y'
;

SELECT register_migration_script('201711071510_IDEMPIERE-905.sql') FROM dual
;

