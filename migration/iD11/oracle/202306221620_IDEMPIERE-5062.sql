SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 22, 2023, 4:20:22 PM WIB
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=11 | @AD_Reference_ID@=12 | @AD_Reference_ID@=15 | @AD_Reference_ID@=22 | @AD_Reference_ID@=29 | @AD_Reference_ID@=37 | @AD_Reference_ID@=10',Updated=TO_TIMESTAMP('2023-06-22 16:20:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=2906
;

-- Jun 22, 2023, 4:20:38 PM WIB
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=11 | @AD_Reference_ID@=12 | @AD_Reference_ID@=15 | @AD_Reference_ID@=22 | @AD_Reference_ID@=29 | @AD_Reference_ID@=37 | @AD_Reference_ID@=10',Updated=TO_TIMESTAMP('2023-06-22 16:20:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=2905
;

-- Jun 24, 2023, 3:39:38 PM WIB
UPDATE AD_Element SET Help='The Minimum Value indicates the lowest  allowable value for a field. use format yyyy-mm-dd for Date',Updated=TO_TIMESTAMP('2023-06-24 15:39:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Element_ID=1060
;

-- Jun 24, 2023, 3:39:38 PM WIB
UPDATE AD_Column SET ColumnName='ValueMin', Name='Min. Value', Description='Minimum Value for a field', Help='The Minimum Value indicates the lowest  allowable value for a field. use format yyyy-mm-dd for Date', Placeholder=NULL WHERE AD_Element_ID=1060
;

-- Jun 24, 2023, 3:39:38 PM WIB
UPDATE AD_Process_Para SET ColumnName='ValueMin', Name='Min. Value', Description='Minimum Value for a field', Help='The Minimum Value indicates the lowest  allowable value for a field. use format yyyy-mm-dd for Date', AD_Element_ID=1060 WHERE UPPER(ColumnName)='VALUEMIN' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jun 24, 2023, 3:39:38 PM WIB
UPDATE AD_Process_Para SET ColumnName='ValueMin', Name='Min. Value', Description='Minimum Value for a field', Help='The Minimum Value indicates the lowest  allowable value for a field. use format yyyy-mm-dd for Date', Placeholder=NULL WHERE AD_Element_ID=1060 AND IsCentrallyMaintained='Y'
;

-- Jun 24, 2023, 3:39:38 PM WIB
UPDATE AD_InfoColumn SET ColumnName='ValueMin', Name='Min. Value', Description='Minimum Value for a field', Help='The Minimum Value indicates the lowest  allowable value for a field. use format yyyy-mm-dd for Date', Placeholder=NULL WHERE AD_Element_ID=1060 AND IsCentrallyMaintained='Y'
;

-- Jun 24, 2023, 3:39:38 PM WIB
UPDATE AD_Field SET Name='Min. Value', Description='Minimum Value for a field', Help='The Minimum Value indicates the lowest  allowable value for a field. use format yyyy-mm-dd for Date', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1060) AND IsCentrallyMaintained='Y'
;

-- Jun 24, 2023, 3:40:41 PM WIB
UPDATE AD_Element SET Help='The Maximum Value indicates the highest allowable value for a field. use format yyyy-mm-dd for Date',Updated=TO_TIMESTAMP('2023-06-24 15:40:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Element_ID=1059
;

-- Jun 24, 2023, 3:40:41 PM WIB
UPDATE AD_Column SET ColumnName='ValueMax', Name='Max. Value', Description='Maximum Value for a field', Help='The Maximum Value indicates the highest allowable value for a field. use format yyyy-mm-dd for Date', Placeholder=NULL WHERE AD_Element_ID=1059
;

-- Jun 24, 2023, 3:40:41 PM WIB
UPDATE AD_Process_Para SET ColumnName='ValueMax', Name='Max. Value', Description='Maximum Value for a field', Help='The Maximum Value indicates the highest allowable value for a field. use format yyyy-mm-dd for Date', AD_Element_ID=1059 WHERE UPPER(ColumnName)='VALUEMAX' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jun 24, 2023, 3:40:41 PM WIB
UPDATE AD_Process_Para SET ColumnName='ValueMax', Name='Max. Value', Description='Maximum Value for a field', Help='The Maximum Value indicates the highest allowable value for a field. use format yyyy-mm-dd for Date', Placeholder=NULL WHERE AD_Element_ID=1059 AND IsCentrallyMaintained='Y'
;

-- Jun 24, 2023, 3:40:41 PM WIB
UPDATE AD_InfoColumn SET ColumnName='ValueMax', Name='Max. Value', Description='Maximum Value for a field', Help='The Maximum Value indicates the highest allowable value for a field. use format yyyy-mm-dd for Date', Placeholder=NULL WHERE AD_Element_ID=1059 AND IsCentrallyMaintained='Y'
;

-- Jun 24, 2023, 3:40:41 PM WIB
UPDATE AD_Field SET Name='Max. Value', Description='Maximum Value for a field', Help='The Maximum Value indicates the highest allowable value for a field. use format yyyy-mm-dd for Date', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1059) AND IsCentrallyMaintained='Y'
;

-- IDEMPIERE-5062
SELECT register_migration_script('202306221620_IDEMPIERE-5062.sql') FROM dual;