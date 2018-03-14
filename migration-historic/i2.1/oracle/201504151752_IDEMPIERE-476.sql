SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-476 Report Engine related bugs
-- 15/04/2015 05:50:45 PM COT
UPDATE AD_Element SET Name='Calculate Maximum (↑)',Updated=TO_DATE('2015-04-15 17:50:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2207
;

-- 15/04/2015 05:50:45 PM COT
UPDATE AD_Column SET ColumnName='IsMaxCalc', Name='Calculate Maximum (↑)', Description='Calculate the maximum amount', Help='Calculate the Maximum (↑)  of the data if the field is numeric, otherwise maximum length of the field.' WHERE AD_Element_ID=2207
;

-- 15/04/2015 05:50:46 PM COT
UPDATE AD_Process_Para SET ColumnName='IsMaxCalc', Name='Calculate Maximum (↑)', Description='Calculate the maximum amount', Help='Calculate the Maximum (↑)  of the data if the field is numeric, otherwise maximum length of the field.', AD_Element_ID=2207 WHERE UPPER(ColumnName)='ISMAXCALC' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 15/04/2015 05:50:46 PM COT
UPDATE AD_Process_Para SET ColumnName='IsMaxCalc', Name='Calculate Maximum (↑)', Description='Calculate the maximum amount', Help='Calculate the Maximum (↑)  of the data if the field is numeric, otherwise maximum length of the field.' WHERE AD_Element_ID=2207 AND IsCentrallyMaintained='Y'
;

-- 15/04/2015 05:50:46 PM COT
UPDATE AD_InfoColumn SET ColumnName='IsMaxCalc', Name='Calculate Maximum (↑)', Description='Calculate the maximum amount', Help='Calculate the Maximum (↑)  of the data if the field is numeric, otherwise maximum length of the field.' WHERE AD_Element_ID=2207 AND IsCentrallyMaintained='Y'
;

-- 15/04/2015 05:50:46 PM COT
UPDATE AD_Field SET Name='Calculate Maximum (↑)', Description='Calculate the maximum amount', Help='Calculate the Maximum (↑)  of the data if the field is numeric, otherwise maximum length of the field.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2207) AND IsCentrallyMaintained='Y'
;

-- 15/04/2015 05:50:46 PM COT
UPDATE AD_PrintFormatItem SET PrintName='Calc Max', Name='Calculate Maximum (↑)' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2207)
;

SELECT register_migration_script('201504151752_IDEMPIERE-476.sql') FROM dual
;

