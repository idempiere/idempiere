-- IDEMPIERE-5247
SELECT register_migration_script('202203291027_IDEMPIERE-5247.sql') FROM dual;

-- Mar 29, 2022, 10:27:13 AM CEST
UPDATE AD_Element SET Name='Posting Type', PrintName='Posting Type',Updated=TO_TIMESTAMP('2022-03-29 10:27:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=514
;

-- Mar 29, 2022, 10:27:13 AM CEST
UPDATE AD_Column SET ColumnName='PostingType', Name='Posting Type', Description='The type of posted amount for the transaction', Help='The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.', Placeholder=NULL WHERE AD_Element_ID=514
;

-- Mar 29, 2022, 10:27:13 AM CEST
UPDATE AD_Process_Para SET ColumnName='PostingType', Name='Posting Type', Description='The type of posted amount for the transaction', Help='The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.', AD_Element_ID=514 WHERE UPPER(ColumnName)='POSTINGTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 29, 2022, 10:27:13 AM CEST
UPDATE AD_Process_Para SET ColumnName='PostingType', Name='Posting Type', Description='The type of posted amount for the transaction', Help='The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.', Placeholder=NULL WHERE AD_Element_ID=514 AND IsCentrallyMaintained='Y'
;

-- Mar 29, 2022, 10:27:13 AM CEST
UPDATE AD_InfoColumn SET ColumnName='PostingType', Name='Posting Type', Description='The type of posted amount for the transaction', Help='The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.', Placeholder=NULL WHERE AD_Element_ID=514 AND IsCentrallyMaintained='Y'
;

-- Mar 29, 2022, 10:27:14 AM CEST
UPDATE AD_Field SET Name='Posting Type', Description='The type of posted amount for the transaction', Help='The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=514) AND IsCentrallyMaintained='Y'
;

-- Mar 29, 2022, 10:27:14 AM CEST
UPDATE AD_PrintFormatItem SET PrintName='Posting Type', Name='Posting Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=514)
;

