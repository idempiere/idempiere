-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
ALTER TABLE X_OnlineTrxHistory RENAME TO C_OnlineTrxHistory
;

ALTER TABLE C_OnlineTrxHistory RENAME X_OnlineTrxHistory_ID TO C_OnlineTrxHistory_ID
;

ALTER TABLE C_OnlineTrxHistory RENAME X_OnlineTrxHistory_UU TO C_OnlineTrxHistory_UU
;

-- Mar 18, 2013 3:42:01 PM COT
UPDATE AD_Sequence SET Description='Table C_OnlineTrxHistory', Name='C_OnlineTrxHistory',Updated=TO_TIMESTAMP('2013-03-18 15:42:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200030
;

-- Mar 18, 2013 3:42:20 PM COT
UPDATE AD_Table SET TableName='C_OnlineTrxHistory',Updated=TO_TIMESTAMP('2013-03-18 15:42:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200032
;

-- Mar 18, 2013 3:42:44 PM COT
UPDATE AD_Element SET ColumnName='C_OnlineTrxHistory_ID',Updated=TO_TIMESTAMP('2013-03-18 15:42:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200201
;

-- Mar 18, 2013 3:42:44 PM COT
UPDATE AD_Column SET ColumnName='C_OnlineTrxHistory_ID', Name='Online Transaction History', Description=NULL, Help=NULL WHERE AD_Element_ID=200201
;

-- Mar 18, 2013 3:42:44 PM COT
UPDATE AD_Process_Para SET ColumnName='C_OnlineTrxHistory_ID', Name='Online Transaction History', Description=NULL, Help=NULL, AD_Element_ID=200201 WHERE UPPER(ColumnName)='C_ONLINETRXHISTORY_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 3:42:44 PM COT
UPDATE AD_Process_Para SET ColumnName='C_OnlineTrxHistory_ID', Name='Online Transaction History', Description=NULL, Help=NULL WHERE AD_Element_ID=200201 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 3:42:44 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_OnlineTrxHistory_ID', Name='Online Transaction History', Description=NULL, Help=NULL WHERE AD_Element_ID=200201 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 3:42:59 PM COT
UPDATE AD_Element SET ColumnName='C_OnlineTrxHistory_UU', Name='C_OnlineTrxHistory_UU', PrintName='C_OnlineTrxHistory_UU',Updated=TO_TIMESTAMP('2013-03-18 15:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200200
;

-- Mar 18, 2013 3:42:59 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200200
;

-- Mar 18, 2013 3:42:59 PM COT
UPDATE AD_Column SET ColumnName='C_OnlineTrxHistory_UU', Name='C_OnlineTrxHistory_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200200
;

-- Mar 18, 2013 3:42:59 PM COT
UPDATE AD_Process_Para SET ColumnName='C_OnlineTrxHistory_UU', Name='C_OnlineTrxHistory_UU', Description=NULL, Help=NULL, AD_Element_ID=200200 WHERE UPPER(ColumnName)='C_ONLINETRXHISTORY_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 3:42:59 PM COT
UPDATE AD_Process_Para SET ColumnName='C_OnlineTrxHistory_UU', Name='C_OnlineTrxHistory_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200200 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 3:42:59 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_OnlineTrxHistory_UU', Name='C_OnlineTrxHistory_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200200 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 3:42:59 PM COT
UPDATE AD_Field SET Name='C_OnlineTrxHistory_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200200) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 3:42:59 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_OnlineTrxHistory_UU', Name='C_OnlineTrxHistory_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200200)
;

SELECT register_migration_script('201303181543_IDEMPIERE-764.sql') FROM dual
;

