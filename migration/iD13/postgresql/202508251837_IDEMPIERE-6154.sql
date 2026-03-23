-- Update Project Balance Help
SELECT register_migration_script('202508251837_IDEMPIERE-6154.sql') FROM dual;

-- Aug 25, 2025, 6:37:02 PM IST
UPDATE AD_Element SET Help='The project balance is the sum of all Issue to Project.',Updated=TO_TIMESTAMP('2025-08-25 18:37:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2054
;

-- Aug 25, 2025, 6:37:02 PM IST
UPDATE AD_Column SET ColumnName='ProjectBalanceAmt', Name='Project Balance', Description='Total Project Balance', Help='The project balance is the sum of all Issue to Project.', Placeholder=NULL WHERE AD_Element_ID=2054
;

-- Aug 25, 2025, 6:37:02 PM IST
UPDATE AD_Process_Para SET ColumnName='ProjectBalanceAmt', Name='Project Balance', Description='Total Project Balance', Help='The project balance is the sum of all Issue to Project.', AD_Element_ID=2054 WHERE UPPER(ColumnName)='PROJECTBALANCEAMT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 25, 2025, 6:37:02 PM IST
UPDATE AD_Process_Para SET ColumnName='ProjectBalanceAmt', Name='Project Balance', Description='Total Project Balance', Help='The project balance is the sum of all Issue to Project.', Placeholder=NULL WHERE AD_Element_ID=2054 AND IsCentrallyMaintained='Y'
;

-- Aug 25, 2025, 6:37:02 PM IST
UPDATE AD_InfoColumn SET ColumnName='ProjectBalanceAmt', Name='Project Balance', Description='Total Project Balance', Help='The project balance is the sum of all Issue to Project.', Placeholder=NULL WHERE AD_Element_ID=2054 AND IsCentrallyMaintained='Y'
;

-- Aug 25, 2025, 6:37:02 PM IST
UPDATE AD_Field SET Name='Project Balance', Description='Total Project Balance', Help='The project balance is the sum of all Issue to Project.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2054) AND IsCentrallyMaintained='Y'
;
