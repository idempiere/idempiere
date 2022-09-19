-- IDEMPIERE-5057 Implement Deductible and non deductible input tax for purchasing and costing
SELECT register_migration_script('202204011738_IDEMPIERE-5057.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 1, 2022, 5:38:03 PM MYT
UPDATE AD_Element SET Description='Type of input tax (deductible and non deductible)', Help='Separate Tax Posting: Tax is calculated on the full amount of the item and posted separately.
Distribute Tax with Relevant Expense: Tax amount is added to the item amount during account posting time and for updating of Product Cost.',Updated=TO_TIMESTAMP('2022-04-01 17:38:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203283
;

-- Apr 1, 2022, 5:38:03 PM MYT
UPDATE AD_Column SET ColumnName='TaxPostingIndicator', Name='Posting Indicator', Description='Type of input tax (deductible and non deductible)', Help='Separate Tax Posting: Tax is calculated on the full amount of the item and posted separately.
Distribute Tax with Relevant Expense: Tax amount is added to the item amount during account posting time and for updating of Product Cost.', Placeholder=NULL WHERE AD_Element_ID=203283
;

-- Apr 1, 2022, 5:38:03 PM MYT
UPDATE AD_Process_Para SET ColumnName='TaxPostingIndicator', Name='Posting Indicator', Description='Type of input tax (deductible and non deductible)', Help='Separate Tax Posting: Tax is calculated on the full amount of the item and posted separately.
Distribute Tax with Relevant Expense: Tax amount is added to the item amount during account posting time and for updating of Product Cost.', AD_Element_ID=203283 WHERE UPPER(ColumnName)='TAXPOSTINGINDICATOR' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 1, 2022, 5:38:03 PM MYT
UPDATE AD_Process_Para SET ColumnName='TaxPostingIndicator', Name='Posting Indicator', Description='Type of input tax (deductible and non deductible)', Help='Separate Tax Posting: Tax is calculated on the full amount of the item and posted separately.
Distribute Tax with Relevant Expense: Tax amount is added to the item amount during account posting time and for updating of Product Cost.', Placeholder=NULL WHERE AD_Element_ID=203283 AND IsCentrallyMaintained='Y'
;

-- Apr 1, 2022, 5:38:03 PM MYT
UPDATE AD_InfoColumn SET ColumnName='TaxPostingIndicator', Name='Posting Indicator', Description='Type of input tax (deductible and non deductible)', Help='Separate Tax Posting: Tax is calculated on the full amount of the item and posted separately.
Distribute Tax with Relevant Expense: Tax amount is added to the item amount during account posting time and for updating of Product Cost.', Placeholder=NULL WHERE AD_Element_ID=203283 AND IsCentrallyMaintained='Y'
;

-- Apr 1, 2022, 5:38:03 PM MYT
UPDATE AD_Field SET Name='Posting Indicator', Description='Type of input tax (deductible and non deductible)', Help='Separate Tax Posting: Tax is calculated on the full amount of the item and posted separately.
Distribute Tax with Relevant Expense: Tax amount is added to the item amount during account posting time and for updating of Product Cost.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203283) AND IsCentrallyMaintained='Y'
;

