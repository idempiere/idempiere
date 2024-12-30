-- IDEMPIERE-6326 Rename "Automatic Commit" user preference to "Save on Navigate"
SELECT register_migration_script('202411301658_IDEMPIERE-6326.sql') FROM dual;

-- Nov 30, 2024, 5:03:05 PM MYT
UPDATE AD_Element SET Name='Save on Navigate', PrintName='Save on Navigate', Description='Automatically save changes to the current record upon user navigation.', Help='Automatically save changes to the current record when the user navigates to another record, switches to a detail tab, or performs an action (e.g., running a process) that requires saving the current changes.',Updated=TO_TIMESTAMP('2024-11-30 17:03:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202879
;

-- Nov 30, 2024, 5:03:05 PM MYT
UPDATE AD_Column SET ColumnName='AutoCommit', Name='Save on Navigate', Description='Automatically save changes to the current record upon user navigation.', Help='Automatically save changes to the current record when the user navigates to another record, switches to a detail tab, or performs an action (e.g., running a process) that requires saving the current changes.', Placeholder=NULL WHERE AD_Element_ID=202879
;

-- Nov 30, 2024, 5:03:05 PM MYT
UPDATE AD_Process_Para SET ColumnName='AutoCommit', Name='Save on Navigate', Description='Automatically save changes to the current record upon user navigation.', Help='Automatically save changes to the current record when the user navigates to another record, switches to a detail tab, or performs an action (e.g., running a process) that requires saving the current changes.', AD_Element_ID=202879 WHERE UPPER(ColumnName)='AUTOCOMMIT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 30, 2024, 5:03:05 PM MYT
UPDATE AD_Process_Para SET ColumnName='AutoCommit', Name='Save on Navigate', Description='Automatically save changes to the current record upon user navigation.', Help='Automatically save changes to the current record when the user navigates to another record, switches to a detail tab, or performs an action (e.g., running a process) that requires saving the current changes.', Placeholder=NULL WHERE AD_Element_ID=202879 AND IsCentrallyMaintained='Y'
;

-- Nov 30, 2024, 5:03:05 PM MYT
UPDATE AD_InfoColumn SET ColumnName='AutoCommit', Name='Save on Navigate', Description='Automatically save changes to the current record upon user navigation.', Help='Automatically save changes to the current record when the user navigates to another record, switches to a detail tab, or performs an action (e.g., running a process) that requires saving the current changes.', Placeholder=NULL WHERE AD_Element_ID=202879 AND IsCentrallyMaintained='Y'
;

-- Nov 30, 2024, 5:03:05 PM MYT
UPDATE AD_Field SET Name='Save on Navigate', Description='Automatically save changes to the current record upon user navigation.', Help='Automatically save changes to the current record when the user navigates to another record, switches to a detail tab, or performs an action (e.g., running a process) that requires saving the current changes.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202879) AND IsCentrallyMaintained='Y'
;

-- Nov 30, 2024, 5:03:05 PM MYT
UPDATE AD_PrintFormatItem SET PrintName='Save on Navigate', Name='Save on Navigate' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202879)
;
