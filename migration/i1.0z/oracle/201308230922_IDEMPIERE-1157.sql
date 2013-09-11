-- Aug 23, 2013 9:21:49 AM COT
-- IDEMPIERE-1157 Adding functionality to add charts on the standard windows
UPDATE AD_Element SET Description='Type of chart to render',Updated=TO_DATE('2013-08-23 09:21:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53894
;

-- Aug 23, 2013 9:21:49 AM COT
-- IDEMPIERE-1157 Adding functionality to add charts on the standard windows
UPDATE AD_Column SET ColumnName='ChartType', Name='Chart Type', Description='Type of chart to render', Help=NULL WHERE AD_Element_ID=53894
;

-- Aug 23, 2013 9:21:49 AM COT
-- IDEMPIERE-1157 Adding functionality to add charts on the standard windows
UPDATE AD_Process_Para SET ColumnName='ChartType', Name='Chart Type', Description='Type of chart to render', Help=NULL, AD_Element_ID=53894 WHERE UPPER(ColumnName)='CHARTTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 23, 2013 9:21:49 AM COT
-- IDEMPIERE-1157 Adding functionality to add charts on the standard windows
UPDATE AD_Process_Para SET ColumnName='ChartType', Name='Chart Type', Description='Type of chart to render', Help=NULL WHERE AD_Element_ID=53894 AND IsCentrallyMaintained='Y'
;

-- Aug 23, 2013 9:21:49 AM COT
-- IDEMPIERE-1157 Adding functionality to add charts on the standard windows
UPDATE AD_InfoColumn SET ColumnName='ChartType', Name='Chart Type', Description='Type of chart to render', Help=NULL WHERE AD_Element_ID=53894 AND IsCentrallyMaintained='Y'
;

-- Aug 23, 2013 9:21:49 AM COT
-- IDEMPIERE-1157 Adding functionality to add charts on the standard windows
UPDATE AD_Field SET Name='Chart Type', Description='Type of chart to render', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53894) AND IsCentrallyMaintained='Y'
;

SELECT register_migration_script('201308230922_IDEMPIERE-1157.sql') FROM dual
;

