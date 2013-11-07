SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 6, 2013 3:30:58 PM COT
-- IDEMPIERE-1362 Implement support to register/unregister available dashboard content
UPDATE AD_Element SET Name='Show on Login', PrintName='Show on Login',Updated=TO_DATE('2013-11-06 15:30:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202569
;

-- Nov 6, 2013 3:30:59 PM COT
UPDATE AD_Column SET ColumnName='IsShowinLogin', Name='Show on Login', Description=NULL, Help=NULL WHERE AD_Element_ID=202569
;

-- Nov 6, 2013 3:30:59 PM COT
UPDATE AD_Process_Para SET ColumnName='IsShowinLogin', Name='Show on Login', Description=NULL, Help=NULL, AD_Element_ID=202569 WHERE UPPER(ColumnName)='ISSHOWINLOGIN' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 6, 2013 3:30:59 PM COT
UPDATE AD_Process_Para SET ColumnName='IsShowinLogin', Name='Show on Login', Description=NULL, Help=NULL WHERE AD_Element_ID=202569 AND IsCentrallyMaintained='Y'
;

-- Nov 6, 2013 3:30:59 PM COT
UPDATE AD_InfoColumn SET ColumnName='IsShowinLogin', Name='Show on Login', Description=NULL, Help=NULL WHERE AD_Element_ID=202569 AND IsCentrallyMaintained='Y'
;

-- Nov 6, 2013 3:30:59 PM COT
UPDATE AD_Field SET Name='Show on Login', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202569) AND IsCentrallyMaintained='Y'
;

-- Nov 6, 2013 3:30:59 PM COT
UPDATE AD_PrintFormatItem SET PrintName='Show on Login', Name='Show on Login' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202569)
;

SELECT register_migration_script('201311061531_IDEMPIERE-1362.sql') FROM dual
;

