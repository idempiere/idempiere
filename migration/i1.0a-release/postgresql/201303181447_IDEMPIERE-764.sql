-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
ALTER TABLE X_DepositBatch RENAME TO C_DepositBatch
;

ALTER TABLE C_DepositBatch RENAME X_DepositBatch_ID TO C_DepositBatch_ID
;

ALTER TABLE C_DepositBatch RENAME X_DepositBatch_UU TO C_DepositBatch_UU
;

ALTER TABLE X_DepositBatchLine RENAME TO C_DepositBatchLine
;

ALTER TABLE C_DepositBatchLine RENAME X_DepositBatchLine_ID TO C_DepositBatchLine_ID
;

ALTER TABLE C_DepositBatchLine RENAME X_DepositBatchLine_UU TO C_DepositBatchLine_UU
;

ALTER TABLE C_DepositBatchLine RENAME X_DepositBatch_ID TO C_DepositBatch_ID
;

ALTER TABLE C_Payment RENAME X_DepositBatch_ID TO C_DepositBatch_ID
;

-- Mar 18, 2013 2:45:55 PM COT
UPDATE AD_Sequence SET Description='Table C_DepositBatch', Name='C_DepositBatch',Updated=TO_TIMESTAMP('2013-03-18 14:45:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200051
;

-- Mar 18, 2013 2:46:00 PM COT
UPDATE AD_Sequence SET Description='Table C_DepositBatchLine', Name='C_DepositBatchLine',Updated=TO_TIMESTAMP('2013-03-18 14:46:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200052
;

-- Mar 18, 2013 2:46:19 PM COT
UPDATE AD_Table SET TableName='C_DepositBatch',Updated=TO_TIMESTAMP('2013-03-18 14:46:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200056
;

-- Mar 18, 2013 2:46:23 PM COT
UPDATE AD_Table SET TableName='C_DepositBatchLine',Updated=TO_TIMESTAMP('2013-03-18 14:46:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200057
;

-- Mar 18, 2013 2:46:36 PM COT
UPDATE AD_Element SET ColumnName='C_DepositBatch_ID',Updated=TO_TIMESTAMP('2013-03-18 14:46:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202195
;

-- Mar 18, 2013 2:46:36 PM COT
UPDATE AD_Column SET ColumnName='C_DepositBatch_ID', Name='Deposit Batch', Description=NULL, Help=NULL WHERE AD_Element_ID=202195
;

-- Mar 18, 2013 2:46:36 PM COT
UPDATE AD_Process_Para SET ColumnName='C_DepositBatch_ID', Name='Deposit Batch', Description=NULL, Help=NULL, AD_Element_ID=202195 WHERE UPPER(ColumnName)='C_DEPOSITBATCH_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 2:46:36 PM COT
UPDATE AD_Process_Para SET ColumnName='C_DepositBatch_ID', Name='Deposit Batch', Description=NULL, Help=NULL WHERE AD_Element_ID=202195 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:46:36 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_DepositBatch_ID', Name='Deposit Batch', Description=NULL, Help=NULL WHERE AD_Element_ID=202195 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:46:40 PM COT
UPDATE AD_Element SET ColumnName='C_DepositBatchLine_ID',Updated=TO_TIMESTAMP('2013-03-18 14:46:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202199
;

-- Mar 18, 2013 2:46:40 PM COT
UPDATE AD_Column SET ColumnName='C_DepositBatchLine_ID', Name='Deposit Batch Line', Description=NULL, Help=NULL WHERE AD_Element_ID=202199
;

-- Mar 18, 2013 2:46:41 PM COT
UPDATE AD_Process_Para SET ColumnName='C_DepositBatchLine_ID', Name='Deposit Batch Line', Description=NULL, Help=NULL, AD_Element_ID=202199 WHERE UPPER(ColumnName)='C_DEPOSITBATCHLINE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 2:46:41 PM COT
UPDATE AD_Process_Para SET ColumnName='C_DepositBatchLine_ID', Name='Deposit Batch Line', Description=NULL, Help=NULL WHERE AD_Element_ID=202199 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:46:41 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_DepositBatchLine_ID', Name='Deposit Batch Line', Description=NULL, Help=NULL WHERE AD_Element_ID=202199 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:46:47 PM COT
UPDATE AD_Element SET ColumnName='C_DepositBatchLine_UU', Name='C_DepositBatchLine_UU', PrintName='C_DepositBatchLine_UU',Updated=TO_TIMESTAMP('2013-03-18 14:46:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202200
;

-- Mar 18, 2013 2:46:47 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202200
;

-- Mar 18, 2013 2:46:47 PM COT
UPDATE AD_Column SET ColumnName='C_DepositBatchLine_UU', Name='C_DepositBatchLine_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202200
;

-- Mar 18, 2013 2:46:47 PM COT
UPDATE AD_Process_Para SET ColumnName='C_DepositBatchLine_UU', Name='C_DepositBatchLine_UU', Description=NULL, Help=NULL, AD_Element_ID=202200 WHERE UPPER(ColumnName)='C_DEPOSITBATCHLINE_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 2:46:47 PM COT
UPDATE AD_Process_Para SET ColumnName='C_DepositBatchLine_UU', Name='C_DepositBatchLine_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202200 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:46:47 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_DepositBatchLine_UU', Name='C_DepositBatchLine_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202200 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:46:47 PM COT
UPDATE AD_Field SET Name='C_DepositBatchLine_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202200) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:46:47 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_DepositBatchLine_UU', Name='C_DepositBatchLine_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202200)
;

-- Mar 18, 2013 2:46:54 PM COT
UPDATE AD_Element SET ColumnName='C_DepositBatch_UU', Name='C_DepositBatch_UU', PrintName='C_DepositBatch_UU',Updated=TO_TIMESTAMP('2013-03-18 14:46:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202196
;

-- Mar 18, 2013 2:46:54 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202196
;

-- Mar 18, 2013 2:46:54 PM COT
UPDATE AD_Column SET ColumnName='C_DepositBatch_UU', Name='C_DepositBatch_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202196
;

-- Mar 18, 2013 2:46:54 PM COT
UPDATE AD_Process_Para SET ColumnName='C_DepositBatch_UU', Name='C_DepositBatch_UU', Description=NULL, Help=NULL, AD_Element_ID=202196 WHERE UPPER(ColumnName)='C_DEPOSITBATCH_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 2:46:54 PM COT
UPDATE AD_Process_Para SET ColumnName='C_DepositBatch_UU', Name='C_DepositBatch_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202196 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:46:54 PM COT
UPDATE AD_InfoColumn SET ColumnName='C_DepositBatch_UU', Name='C_DepositBatch_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202196 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:46:54 PM COT
UPDATE AD_Field SET Name='C_DepositBatch_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202196) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:46:54 PM COT
UPDATE AD_PrintFormatItem SET PrintName='C_DepositBatch_UU', Name='C_DepositBatch_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202196)
;

-- Mar 18, 2013 3:12:20 PM COT
-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
UPDATE AD_Column SET DefaultValue='@SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM C_DepositBatchLine WHERE C_DepositBatch_ID=@C_DepositBatch_ID@',Updated=TO_TIMESTAMP('2013-03-18 15:12:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208438
;

SELECT register_migration_script('201303181447_IDEMPIERE-764.sql') FROM dual
;

