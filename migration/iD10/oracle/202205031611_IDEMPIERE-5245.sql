-- IDEMPIERE-5245   Fix typos in dictionary
SELECT register_migration_script('202205031611_IDEMPIERE-5245.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 3/05/2022, 4:11:52 p. m. GMT+02:00
UPDATE AD_Element SET Name='Ad hoc Conversion', PrintName='Ad hoc Conversion',Updated=TO_TIMESTAMP('2022-05-03 16:11:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1608
;

-- 3/05/2022, 4:11:52 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsAdhocConversion', Name='Ad hoc Conversion', Description='Perform conversion for all amounts to currency', Help='If a currency is selected, only this currency will be reported. If adhoc conversion is selected, all currencies are converted to the defined currency', Placeholder=NULL WHERE AD_Element_ID=1608
;

-- 3/05/2022, 4:11:52 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsAdhocConversion', Name='Ad hoc Conversion', Description='Perform conversion for all amounts to currency', Help='If a currency is selected, only this currency will be reported. If adhoc conversion is selected, all currencies are converted to the defined currency', AD_Element_ID=1608 WHERE UPPER(ColumnName)='ISADHOCCONVERSION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:11:52 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsAdhocConversion', Name='Ad hoc Conversion', Description='Perform conversion for all amounts to currency', Help='If a currency is selected, only this currency will be reported. If adhoc conversion is selected, all currencies are converted to the defined currency', Placeholder=NULL WHERE AD_Element_ID=1608 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:11:52 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsAdhocConversion', Name='Ad hoc Conversion', Description='Perform conversion for all amounts to currency', Help='If a currency is selected, only this currency will be reported. If adhoc conversion is selected, all currencies are converted to the defined currency', Placeholder=NULL WHERE AD_Element_ID=1608 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:11:52 p. m. GMT+02:00
UPDATE AD_Field SET Name='Ad hoc Conversion', Description='Perform conversion for all amounts to currency', Help='If a currency is selected, only this currency will be reported. If adhoc conversion is selected, all currencies are converted to the defined currency', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1608) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:11:52 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Ad hoc Conversion', Name='Ad hoc Conversion' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1608)
;

-- 3/05/2022, 4:13:26 p. m. GMT+02:00
UPDATE AD_Element SET Name='All Fields', PrintName='All Fields',Updated=TO_TIMESTAMP('2022-05-03 16:13:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53328
;

-- 3/05/2022, 4:13:26 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='AllFields', Name='All Fields', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53328
;

-- 3/05/2022, 4:13:26 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AllFields', Name='All Fields', Description=NULL, Help=NULL, AD_Element_ID=53328 WHERE UPPER(ColumnName)='ALLFIELDS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:13:26 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AllFields', Name='All Fields', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53328 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:13:26 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='AllFields', Name='All Fields', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53328 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:13:26 p. m. GMT+02:00
UPDATE AD_Field SET Name='All Fields', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53328) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:13:26 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='All Fields', Name='All Fields' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53328)
;

-- 3/05/2022, 4:14:31 p. m. GMT+02:00
UPDATE AD_Element SET Name='Allocated Amount',Updated=TO_TIMESTAMP('2022-05-03 16:14:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2677
;

-- 3/05/2022, 4:14:31 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='AllocatedAmt', Name='Allocated Amount', Description='Amount allocated to this document', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2677
;

-- 3/05/2022, 4:14:31 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AllocatedAmt', Name='Allocated Amount', Description='Amount allocated to this document', Help=NULL, AD_Element_ID=2677 WHERE UPPER(ColumnName)='ALLOCATEDAMT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:14:31 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AllocatedAmt', Name='Allocated Amount', Description='Amount allocated to this document', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2677 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:14:31 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='AllocatedAmt', Name='Allocated Amount', Description='Amount allocated to this document', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2677 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:14:31 p. m. GMT+02:00
UPDATE AD_Field SET Name='Allocated Amount', Description='Amount allocated to this document', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2677) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:14:31 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Allocated Amt', Name='Allocated Amount' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2677)
;

-- 3/05/2022, 4:15:22 p. m. GMT+02:00
UPDATE AD_Element SET Name='Allow Info Cash Journal', PrintName='Allow Info Cash Journal',Updated=TO_TIMESTAMP('2022-05-03 16:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50048
;

-- 3/05/2022, 4:15:22 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='Allow_Info_CashJournal', Name='Allow Info Cash Journal', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50048
;

-- 3/05/2022, 4:15:22 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='Allow_Info_CashJournal', Name='Allow Info Cash Journal', Description=NULL, Help=NULL, AD_Element_ID=50048 WHERE UPPER(ColumnName)='ALLOW_INFO_CASHJOURNAL' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:15:22 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='Allow_Info_CashJournal', Name='Allow Info Cash Journal', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50048 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:15:22 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='Allow_Info_CashJournal', Name='Allow Info Cash Journal', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50048 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:15:22 p. m. GMT+02:00
UPDATE AD_Field SET Name='Allow Info Cash Journal', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=50048) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:15:22 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Allow Info Cash Journal', Name='Allow Info Cash Journal' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=50048)
;

-- 3/05/2022, 4:17:13 p. m. GMT+02:00
UPDATE AD_Element SET Description='Should allow null value for identifier field',Updated=TO_TIMESTAMP('2022-05-03 16:17:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200593
;

-- 3/05/2022, 4:17:13 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsNullIdentifier', Name='Allow Null Value', Description='Should allow null value for identifier field', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200593
;

-- 3/05/2022, 4:17:13 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsNullIdentifier', Name='Allow Null Value', Description='Should allow null value for identifier field', Help=NULL, AD_Element_ID=200593 WHERE UPPER(ColumnName)='ISNULLIDENTIFIER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:17:13 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsNullIdentifier', Name='Allow Null Value', Description='Should allow null value for identifier field', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200593 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:17:13 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsNullIdentifier', Name='Allow Null Value', Description='Should allow null value for identifier field', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200593 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:17:13 p. m. GMT+02:00
UPDATE AD_Field SET Name='Allow Null Value', Description='Should allow null value for identifier field', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200593) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:21:50 p. m. GMT+02:00
UPDATE AD_Element SET Name='Allow Product Without Price List', PrintName='Allow Product Without Price List',Updated=TO_TIMESTAMP('2022-05-03 16:21:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203543
;

-- 3/05/2022, 4:21:50 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsNoPriceListCheck', Name='Allow Product Without Price List', Description=NULL, Help='Allow product without pricelist on this document type.', Placeholder=NULL WHERE AD_Element_ID=203543
;

-- 3/05/2022, 4:21:50 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsNoPriceListCheck', Name='Allow Product Without Price List', Description=NULL, Help='Allow product without pricelist on this document type.', AD_Element_ID=203543 WHERE UPPER(ColumnName)='ISNOPRICELISTCHECK' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:21:50 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsNoPriceListCheck', Name='Allow Product Without Price List', Description=NULL, Help='Allow product without pricelist on this document type.', Placeholder=NULL WHERE AD_Element_ID=203543 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:21:50 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsNoPriceListCheck', Name='Allow Product Without Price List', Description=NULL, Help='Allow product without pricelist on this document type.', Placeholder=NULL WHERE AD_Element_ID=203543 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:21:50 p. m. GMT+02:00
UPDATE AD_Field SET Name='Allow Product Without Price List', Description=NULL, Help='Allow product without pricelist on this document type.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203543) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:21:50 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Allow Product Without Price List', Name='Allow Product Without Price List' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203543)
;

-- 3/05/2022, 4:22:07 p. m. GMT+02:00
UPDATE AD_Element SET Help='Allow product without price list on this document type.',Updated=TO_TIMESTAMP('2022-05-03 16:22:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203543
;

-- 3/05/2022, 4:22:07 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsNoPriceListCheck', Name='Allow Product Without Price List', Description=NULL, Help='Allow product without price list on this document type.', Placeholder=NULL WHERE AD_Element_ID=203543
;

-- 3/05/2022, 4:22:07 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsNoPriceListCheck', Name='Allow Product Without Price List', Description=NULL, Help='Allow product without price list on this document type.', AD_Element_ID=203543 WHERE UPPER(ColumnName)='ISNOPRICELISTCHECK' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:22:07 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsNoPriceListCheck', Name='Allow Product Without Price List', Description=NULL, Help='Allow product without price list on this document type.', Placeholder=NULL WHERE AD_Element_ID=203543 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:22:07 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsNoPriceListCheck', Name='Allow Product Without Price List', Description=NULL, Help='Allow product without price list on this document type.', Placeholder=NULL WHERE AD_Element_ID=203543 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:22:07 p. m. GMT+02:00
UPDATE AD_Field SET Name='Allow Product Without Price List', Description=NULL, Help='Allow product without price list on this document type.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203543) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:23:36 p. m. GMT+02:00
UPDATE AD_Element SET Description='Length of alphabetical sequence to validate',Updated=TO_TIMESTAMP('2022-05-03 16:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200068
;

-- 3/05/2022, 4:23:36 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Length of alphabetical sequence to validate', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200068
;

-- 3/05/2022, 4:23:36 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Length of alphabetical sequence to validate', Help=NULL, AD_Element_ID=200068 WHERE UPPER(ColumnName)='ALPHABETICALSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:23:36 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Length of alphabetical sequence to validate', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200068 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:23:36 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Length of alphabetical sequence to validate', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200068 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:23:36 p. m. GMT+02:00
UPDATE AD_Field SET Name='Alphabetical Sequence', Description='Length of alphabetical sequence to validate', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200068) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:25:14 p. m. GMT+02:00
UPDATE AD_Element SET Name='Amount Refunded', PrintName='Amount Refunded',Updated=TO_TIMESTAMP('2022-05-03 16:25:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52022
;

-- 3/05/2022, 4:25:14 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='AmountRefunded', Name='Amount Refunded', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52022
;

-- 3/05/2022, 4:25:14 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AmountRefunded', Name='Amount Refunded', Description=NULL, Help=NULL, AD_Element_ID=52022 WHERE UPPER(ColumnName)='AMOUNTREFUNDED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:25:14 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AmountRefunded', Name='Amount Refunded', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52022 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:25:14 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='AmountRefunded', Name='Amount Refunded', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52022 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:25:14 p. m. GMT+02:00
UPDATE AD_Field SET Name='Amount Refunded', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52022) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:25:14 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Amount Refunded', Name='Amount Refunded' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52022)
;

-- 3/05/2022, 4:26:12 p. m. GMT+02:00
UPDATE AD_Element SET Name='Amount Tendered', PrintName='Amount Tendered',Updated=TO_TIMESTAMP('2022-05-03 16:26:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52021
;

-- 3/05/2022, 4:26:12 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='AmountTendered', Name='Amount Tendered', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52021
;

-- 3/05/2022, 4:26:12 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AmountTendered', Name='Amount Tendered', Description=NULL, Help=NULL, AD_Element_ID=52021 WHERE UPPER(ColumnName)='AMOUNTTENDERED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:26:12 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AmountTendered', Name='Amount Tendered', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52021 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:26:12 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='AmountTendered', Name='Amount Tendered', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52021 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:26:12 p. m. GMT+02:00
UPDATE AD_Field SET Name='Amount Tendered', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52021) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:26:12 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Amount Tendered', Name='Amount Tendered' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52021)
;

-- 3/05/2022, 4:27:50 p. m. GMT+02:00
UPDATE AD_Element SET Name='Asset Accum Depreciation Amt', PrintName='Asset Accum Depreciation Amt',Updated=TO_TIMESTAMP('2022-05-03 16:27:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53605
;

-- 3/05/2022, 4:27:50 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='AssetAccumDepreciationAmt', Name='Asset Accum Depreciation Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53605
;

-- 3/05/2022, 4:27:50 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AssetAccumDepreciationAmt', Name='Asset Accum Depreciation Amt', Description=NULL, Help=NULL, AD_Element_ID=53605 WHERE UPPER(ColumnName)='ASSETACCUMDEPRECIATIONAMT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:27:50 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AssetAccumDepreciationAmt', Name='Asset Accum Depreciation Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53605 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:27:50 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='AssetAccumDepreciationAmt', Name='Asset Accum Depreciation Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53605 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:27:50 p. m. GMT+02:00
UPDATE AD_Field SET Name='Asset Accum Depreciation Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53605) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:27:50 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Asset Accum Depreciation Amt', Name='Asset Accum Depreciation Amt' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53605)
;

-- 3/05/2022, 4:28:49 p. m. GMT+02:00
UPDATE AD_Element SET Name='Asset Book Value Amt', PrintName='Asset Book Value Amt',Updated=TO_TIMESTAMP('2022-05-03 16:28:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53604
;

-- 3/05/2022, 4:28:49 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='AssetBookValueAmt', Name='Asset Book Value Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53604
;

-- 3/05/2022, 4:28:49 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AssetBookValueAmt', Name='Asset Book Value Amt', Description=NULL, Help=NULL, AD_Element_ID=53604 WHERE UPPER(ColumnName)='ASSETBOOKVALUEAMT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:28:49 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AssetBookValueAmt', Name='Asset Book Value Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53604 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:28:49 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='AssetBookValueAmt', Name='Asset Book Value Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53604 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:28:49 p. m. GMT+02:00
UPDATE AD_Field SET Name='Asset Book Value Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53604) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:28:49 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Asset Book Value Amt', Name='Asset Book Value Amt' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53604)
;

-- 3/05/2022, 4:29:46 p. m. GMT+02:00
UPDATE AD_Element SET Name='Attachment Method',Updated=TO_TIMESTAMP('2022-05-03 16:29:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200241
;

-- 3/05/2022, 4:29:46 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='AttachmentMethod', Name='Attachment Method', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200241
;

-- 3/05/2022, 4:29:46 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AttachmentMethod', Name='Attachment Method', Description=NULL, Help=NULL, AD_Element_ID=200241 WHERE UPPER(ColumnName)='ATTACHMENTMETHOD' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:29:46 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AttachmentMethod', Name='Attachment Method', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200241 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:29:46 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='AttachmentMethod', Name='Attachment Method', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200241 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:29:46 p. m. GMT+02:00
UPDATE AD_Field SET Name='Attachment Method', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200241) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:29:46 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Attachment Method', Name='Attachment Method' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200241)
;

-- 3/05/2022, 4:31:19 p. m. GMT+02:00
UPDATE AD_Element SET Name='Attribute Set Type', PrintName='Attribute Set Type',Updated=TO_TIMESTAMP('2022-05-03 16:31:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202952
;

-- 3/05/2022, 4:31:19 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='M_AttributeSet_Type', Name='Attribute Set Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202952
;

-- 3/05/2022, 4:31:19 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='M_AttributeSet_Type', Name='Attribute Set Type', Description=NULL, Help=NULL, AD_Element_ID=202952 WHERE UPPER(ColumnName)='M_ATTRIBUTESET_TYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:31:19 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='M_AttributeSet_Type', Name='Attribute Set Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202952 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:31:19 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='M_AttributeSet_Type', Name='Attribute Set Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202952 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:31:19 p. m. GMT+02:00
UPDATE AD_Field SET Name='Attribute Set Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202952) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:31:19 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Attribute Set Type', Name='Attribute Set Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202952)
;

-- 3/05/2022, 4:32:06 p. m. GMT+02:00
UPDATE AD_Element SET Name='Auto complete', Description='Automatic completion for text fields', PrintName='Auto complete',Updated=TO_TIMESTAMP('2022-05-03 16:32:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53655
;

-- 3/05/2022, 4:32:06 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsAutocomplete', Name='Auto complete', Description='Automatic completion for text fields', Help='The autocompletion uses all existing values (from the same tenant and organization) of the field.', Placeholder=NULL WHERE AD_Element_ID=53655
;

-- 3/05/2022, 4:32:06 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsAutocomplete', Name='Auto complete', Description='Automatic completion for text fields', Help='The autocompletion uses all existing values (from the same tenant and organization) of the field.', AD_Element_ID=53655 WHERE UPPER(ColumnName)='ISAUTOCOMPLETE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:32:06 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsAutocomplete', Name='Auto complete', Description='Automatic completion for text fields', Help='The autocompletion uses all existing values (from the same tenant and organization) of the field.', Placeholder=NULL WHERE AD_Element_ID=53655 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:32:06 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsAutocomplete', Name='Auto complete', Description='Automatic completion for text fields', Help='The autocompletion uses all existing values (from the same tenant and organization) of the field.', Placeholder=NULL WHERE AD_Element_ID=53655 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:32:06 p. m. GMT+02:00
UPDATE AD_Field SET Name='Auto complete', Description='Automatic completion for text fields', Help='The autocompletion uses all existing values (from the same tenant and organization) of the field.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53655) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:32:06 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Auto complete', Name='Auto complete' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53655)
;

-- 3/05/2022, 4:35:04 p. m. GMT+02:00
UPDATE AD_Element SET Name='Base Price List',Updated=TO_TIMESTAMP('2022-05-03 16:35:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1259
;

-- 3/05/2022, 4:35:04 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='BasePriceList_ID', Name='Base Price List', Description='Pricelist to be used, if product not found on this pricelist', Help='The Base Price List identifies the default price list to be used if a product is not found on the selected price list', Placeholder=NULL WHERE AD_Element_ID=1259
;

-- 3/05/2022, 4:35:04 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='BasePriceList_ID', Name='Base Price List', Description='Pricelist to be used, if product not found on this pricelist', Help='The Base Price List identifies the default price list to be used if a product is not found on the selected price list', AD_Element_ID=1259 WHERE UPPER(ColumnName)='BASEPRICELIST_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:35:04 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='BasePriceList_ID', Name='Base Price List', Description='Pricelist to be used, if product not found on this pricelist', Help='The Base Price List identifies the default price list to be used if a product is not found on the selected price list', Placeholder=NULL WHERE AD_Element_ID=1259 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:35:04 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='BasePriceList_ID', Name='Base Price List', Description='Pricelist to be used, if product not found on this pricelist', Help='The Base Price List identifies the default price list to be used if a product is not found on the selected price list', Placeholder=NULL WHERE AD_Element_ID=1259 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:35:04 p. m. GMT+02:00
UPDATE AD_Field SET Name='Base Price List', Description='Pricelist to be used, if product not found on this pricelist', Help='The Base Price List identifies the default price list to be used if a product is not found on the selected price list', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1259) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:35:04 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Base', Name='Base Price List' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1259)
;

-- 3/05/2022, 4:35:51 p. m. GMT+02:00
UPDATE AD_Element SET Name='Cash Drawer', PrintName='Cash Drawer',Updated=TO_TIMESTAMP('2022-05-03 16:35:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52015
;

-- 3/05/2022, 4:35:51 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='CashDrawer', Name='Cash Drawer', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52015
;

-- 3/05/2022, 4:35:51 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CashDrawer', Name='Cash Drawer', Description=NULL, Help=NULL, AD_Element_ID=52015 WHERE UPPER(ColumnName)='CASHDRAWER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:35:51 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CashDrawer', Name='Cash Drawer', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52015 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:35:51 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='CashDrawer', Name='Cash Drawer', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52015 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:35:51 p. m. GMT+02:00
UPDATE AD_Field SET Name='Cash Drawer', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52015) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:35:51 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Cash Drawer', Name='Cash Drawer' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52015)
;

-- 3/05/2022, 4:37:34 p. m. GMT+02:00
UPDATE AD_Element SET Name='Change Accumulated Depreciation', PrintName='Change Accumulated Depreciation',Updated=TO_TIMESTAMP('2022-05-03 16:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54230
;

-- 3/05/2022, 4:37:35 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='A_Change_Acumulated_Depr', Name='Change Accumulated Depreciation', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=54230
;

-- 3/05/2022, 4:37:35 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='A_Change_Acumulated_Depr', Name='Change Accumulated Depreciation', Description=NULL, Help=NULL, AD_Element_ID=54230 WHERE UPPER(ColumnName)='A_CHANGE_ACUMULATED_DEPR' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:37:35 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='A_Change_Acumulated_Depr', Name='Change Accumulated Depreciation', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=54230 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:37:35 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='A_Change_Acumulated_Depr', Name='Change Accumulated Depreciation', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=54230 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:37:35 p. m. GMT+02:00
UPDATE AD_Field SET Name='Change Accumulated Depreciation', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=54230) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:37:35 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Change Accumulated Depreciation', Name='Change Accumulated Depreciation' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=54230)
;

-- 3/05/2022, 4:38:30 p. m. GMT+02:00
UPDATE AD_Element SET Name='Change Amt', PrintName='Change Amt',Updated=TO_TIMESTAMP('2022-05-03 16:38:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53611
;

-- 3/05/2022, 4:38:30 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='ChangeAmt', Name='Change Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53611
;

-- 3/05/2022, 4:38:30 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ChangeAmt', Name='Change Amt', Description=NULL, Help=NULL, AD_Element_ID=53611 WHERE UPPER(ColumnName)='CHANGEAMT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:38:30 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ChangeAmt', Name='Change Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53611 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:38:30 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='ChangeAmt', Name='Change Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53611 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:38:30 p. m. GMT+02:00
UPDATE AD_Field SET Name='Change Amt', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53611) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:38:30 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Change Amt', Name='Change Amt' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53611)
;

-- 3/05/2022, 4:39:12 p. m. GMT+02:00
UPDATE AD_Element SET Name='Change Date', PrintName='Change Date',Updated=TO_TIMESTAMP('2022-05-03 16:39:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53610
;

-- 3/05/2022, 4:39:12 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='ChangeDate', Name='Change Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53610
;

-- 3/05/2022, 4:39:12 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ChangeDate', Name='Change Date', Description=NULL, Help=NULL, AD_Element_ID=53610 WHERE UPPER(ColumnName)='CHANGEDATE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:39:12 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ChangeDate', Name='Change Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53610 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:39:12 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='ChangeDate', Name='Change Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53610 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:39:12 p. m. GMT+02:00
UPDATE AD_Field SET Name='Change Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53610) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:39:12 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Change Date', Name='Change Date' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53610)
;

-- 3/05/2022, 4:39:43 p. m. GMT+02:00
UPDATE AD_Element SET Name='Change Type', PrintName='Change Type',Updated=TO_TIMESTAMP('2022-05-03 16:39:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53609
;

-- 3/05/2022, 4:39:43 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='ChangeType', Name='Change Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53609
;

-- 3/05/2022, 4:39:43 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ChangeType', Name='Change Type', Description=NULL, Help=NULL, AD_Element_ID=53609 WHERE UPPER(ColumnName)='CHANGETYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:39:43 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ChangeType', Name='Change Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53609 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:39:43 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='ChangeType', Name='Change Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53609 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:39:43 p. m. GMT+02:00
UPDATE AD_Field SET Name='Change Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53609) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:39:43 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Change Type', Name='Change Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53609)
;

-- 3/05/2022, 4:40:40 p. m. GMT+02:00
UPDATE AD_Element SET Name='Col Value', PrintName='Col Value',Updated=TO_TIMESTAMP('2022-05-03 16:40:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50012
;

-- 3/05/2022, 4:40:40 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='ColValue', Name='Col Value', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50012
;

-- 3/05/2022, 4:40:40 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ColValue', Name='Col Value', Description=NULL, Help=NULL, AD_Element_ID=50012 WHERE UPPER(ColumnName)='COLVALUE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:40:40 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ColValue', Name='Col Value', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50012 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:40:40 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='ColValue', Name='Col Value', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50012 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:40:40 p. m. GMT+02:00
UPDATE AD_Field SET Name='Col Value', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=50012) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:40:40 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Col Value', Name='Col Value' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=50012)
;

-- 3/05/2022, 4:41:26 p. m. GMT+02:00
UPDATE AD_Element SET Name='Container XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', PrintName='Container XML',Updated=TO_TIMESTAMP('2022-05-03 16:41:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2995
;

-- 3/05/2022, 4:41:26 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='ContainerXML', Name='Container XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', Placeholder=NULL WHERE AD_Element_ID=2995
;

-- 3/05/2022, 4:41:26 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ContainerXML', Name='Container XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', AD_Element_ID=2995 WHERE UPPER(ColumnName)='CONTAINERXML' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:41:26 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ContainerXML', Name='Container XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', Placeholder=NULL WHERE AD_Element_ID=2995 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:41:26 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='ContainerXML', Name='Container XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', Placeholder=NULL WHERE AD_Element_ID=2995 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:41:26 p. m. GMT+02:00
UPDATE AD_Field SET Name='Container XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2995) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:41:26 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Container XML', Name='Container XML' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2995)
;

-- 3/05/2022, 4:42:27 p. m. GMT+02:00
UPDATE AD_Element SET Name='Convention Type', PrintName='Convention Type',Updated=TO_TIMESTAMP('2022-05-03 16:42:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53585
;

-- 3/05/2022, 4:42:27 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='ConventionType', Name='Convention Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53585
;

-- 3/05/2022, 4:42:27 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ConventionType', Name='Convention Type', Description=NULL, Help=NULL, AD_Element_ID=53585 WHERE UPPER(ColumnName)='CONVENTIONTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:42:27 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ConventionType', Name='Convention Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53585 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:42:27 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='ConventionType', Name='Convention Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53585 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:42:27 p. m. GMT+02:00
UPDATE AD_Field SET Name='Convention Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53585) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:42:27 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Convention Type', Name='Convention Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53585)
;

-- 3/05/2022, 4:42:56 p. m. GMT+02:00
UPDATE AD_Element SET Name='Created Date', PrintName='Created Date',Updated=TO_TIMESTAMP('2022-05-03 16:42:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50002
;

-- 3/05/2022, 4:42:56 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='CreatedDate', Name='Created Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50002
;

-- 3/05/2022, 4:42:56 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CreatedDate', Name='Created Date', Description=NULL, Help=NULL, AD_Element_ID=50002 WHERE UPPER(ColumnName)='CREATEDDATE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:42:56 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CreatedDate', Name='Created Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50002 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:42:56 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='CreatedDate', Name='Created Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50002 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:42:56 p. m. GMT+02:00
UPDATE AD_Field SET Name='Created Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=50002) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:42:56 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Created Date', Name='Created Date' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=50002)
;

-- 3/05/2022, 4:43:59 p. m. GMT+02:00
UPDATE AD_Element SET ColumnName='CreatorContact', Name='Creator Contact', PrintName='Creator Contact',Updated=TO_TIMESTAMP('2022-05-03 16:43:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50008
;

-- 3/05/2022, 4:43:59 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='CreatorContact', Name='Creator Contact', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50008
;

-- 3/05/2022, 4:43:59 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CreatorContact', Name='Creator Contact', Description=NULL, Help=NULL, AD_Element_ID=50008 WHERE UPPER(ColumnName)='CREATORCONTACT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:43:59 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CreatorContact', Name='Creator Contact', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50008 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:43:59 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='CreatorContact', Name='Creator Contact', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50008 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:43:59 p. m. GMT+02:00
UPDATE AD_Field SET Name='Creator Contact', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=50008) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:43:59 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Creator Contact', Name='Creator Contact' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=50008)
;

-- 3/05/2022, 4:45:08 p. m. GMT+02:00
UPDATE AD_Element SET Name='Currency Rate Type', PrintName='Currency Rate Type',Updated=TO_TIMESTAMP('2022-05-03 16:45:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53503
;

-- 3/05/2022, 4:45:08 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='CurrencyRateType', Name='Currency Rate Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53503
;

-- 3/05/2022, 4:45:08 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CurrencyRateType', Name='Currency Rate Type', Description=NULL, Help=NULL, AD_Element_ID=53503 WHERE UPPER(ColumnName)='CURRENCYRATETYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:45:08 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CurrencyRateType', Name='Currency Rate Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53503 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:45:08 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='CurrencyRateType', Name='Currency Rate Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53503 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:45:08 p. m. GMT+02:00
UPDATE AD_Field SET Name='Currency Rate Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53503) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:45:08 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Currency Rate Type', Name='Currency Rate Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53503)
;

-- 3/05/2022, 4:46:18 p. m. GMT+02:00
UPDATE AD_Element SET Description='Define number of day can reuse password',Updated=TO_TIMESTAMP('2022-05-03 16:46:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202868
;

-- 3/05/2022, 4:46:18 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='Days_Reuse_Password', Name='Days Reuse Password', Description='Define number of day can reuse password', Help='Each time change password, old password keep in history
Example this value = 60. user can''t reuse password in history has age < 60
', Placeholder=NULL WHERE AD_Element_ID=202868
;

-- 3/05/2022, 4:46:18 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='Days_Reuse_Password', Name='Days Reuse Password', Description='Define number of day can reuse password', Help='Each time change password, old password keep in history
Example this value = 60. user can''t reuse password in history has age < 60
', AD_Element_ID=202868 WHERE UPPER(ColumnName)='DAYS_REUSE_PASSWORD' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:46:18 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='Days_Reuse_Password', Name='Days Reuse Password', Description='Define number of day can reuse password', Help='Each time change password, old password keep in history
Example this value = 60. user can''t reuse password in history has age < 60
', Placeholder=NULL WHERE AD_Element_ID=202868 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:46:18 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='Days_Reuse_Password', Name='Days Reuse Password', Description='Define number of day can reuse password', Help='Each time change password, old password keep in history
Example this value = 60. user can''t reuse password in history has age < 60
', Placeholder=NULL WHERE AD_Element_ID=202868 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:46:18 p. m. GMT+02:00
UPDATE AD_Field SET Name='Days Reuse Password', Description='Define number of day can reuse password', Help='Each time change password, old password keep in history
Example this value = 60. user can''t reuse password in history has age < 60
', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202868) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:47:40 p. m. GMT+02:00
UPDATE AD_Element SET Name='DB Type', PrintName='DB Type',Updated=TO_TIMESTAMP('2022-05-03 16:47:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50026
;

-- 3/05/2022, 4:47:40 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='DBType', Name='DB Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50026
;

-- 3/05/2022, 4:47:40 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='DBType', Name='DB Type', Description=NULL, Help=NULL, AD_Element_ID=50026 WHERE UPPER(ColumnName)='DBTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:47:40 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='DBType', Name='DB Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50026 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:47:40 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='DBType', Name='DB Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50026 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:47:40 p. m. GMT+02:00
UPDATE AD_Field SET Name='DB Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=50026) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:47:40 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='DB Type', Name='DB Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=50026)
;

-- 3/05/2022, 4:49:10 p. m. GMT+02:00
UPDATE AD_Element SET Name='Depreciation Type', PrintName='Depreciation Type',Updated=TO_TIMESTAMP('2022-05-03 16:49:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53474
;

-- 3/05/2022, 4:49:10 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='DepreciationType', Name='Depreciation Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53474
;

-- 3/05/2022, 4:49:10 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='DepreciationType', Name='Depreciation Type', Description=NULL, Help=NULL, AD_Element_ID=53474 WHERE UPPER(ColumnName)='DEPRECIATIONTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:49:10 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='DepreciationType', Name='Depreciation Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53474 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:49:10 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='DepreciationType', Name='Depreciation Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53474 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:49:10 p. m. GMT+02:00
UPDATE AD_Field SET Name='Depreciation Type', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53474) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:49:10 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Depreciation Type', Name='Depreciation Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53474)
;

-- 3/05/2022, 4:50:26 p. m. GMT+02:00
UPDATE AD_Element SET Name='Discount Price List', Description='Line of the price list trade discount schema', Help='For the Price list Discount Type, you enter how the list, standard and limit price is calculated.', PrintName='Discount Price List',Updated=TO_TIMESTAMP('2022-05-03 16:50:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1716
;

-- 3/05/2022, 4:50:26 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='M_DiscountSchemaLine_ID', Name='Discount Price List', Description='Line of the price list trade discount schema', Help='For the Price list Discount Type, you enter how the list, standard and limit price is calculated.', Placeholder=NULL WHERE AD_Element_ID=1716
;

-- 3/05/2022, 4:50:26 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='M_DiscountSchemaLine_ID', Name='Discount Price List', Description='Line of the price list trade discount schema', Help='For the Price list Discount Type, you enter how the list, standard and limit price is calculated.', AD_Element_ID=1716 WHERE UPPER(ColumnName)='M_DISCOUNTSCHEMALINE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:50:26 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='M_DiscountSchemaLine_ID', Name='Discount Price List', Description='Line of the price list trade discount schema', Help='For the Price list Discount Type, you enter how the list, standard and limit price is calculated.', Placeholder=NULL WHERE AD_Element_ID=1716 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:50:26 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='M_DiscountSchemaLine_ID', Name='Discount Price List', Description='Line of the price list trade discount schema', Help='For the Price list Discount Type, you enter how the list, standard and limit price is calculated.', Placeholder=NULL WHERE AD_Element_ID=1716 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:50:26 p. m. GMT+02:00
UPDATE AD_Field SET Name='Discount Price List', Description='Line of the price list trade discount schema', Help='For the Price list Discount Type, you enter how the list, standard and limit price is calculated.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1716) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:50:26 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Discount Price List', Name='Discount Price List' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1716)
;

-- 3/05/2022, 4:51:37 p. m. GMT+02:00
UPDATE AD_Element SET Name='Document Base Type',Updated=TO_TIMESTAMP('2022-05-03 16:51:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=865
;

-- 3/05/2022, 4:51:37 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='DocBaseType', Name='Document Base Type', Description='Logical type of document', Help='The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.', Placeholder=NULL WHERE AD_Element_ID=865
;

-- 3/05/2022, 4:51:37 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='DocBaseType', Name='Document Base Type', Description='Logical type of document', Help='The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.', AD_Element_ID=865 WHERE UPPER(ColumnName)='DOCBASETYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:51:37 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='DocBaseType', Name='Document Base Type', Description='Logical type of document', Help='The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.', Placeholder=NULL WHERE AD_Element_ID=865 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:51:37 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='DocBaseType', Name='Document Base Type', Description='Logical type of document', Help='The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.', Placeholder=NULL WHERE AD_Element_ID=865 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:51:37 p. m. GMT+02:00
UPDATE AD_Field SET Name='Document Base Type', Description='Logical type of document', Help='The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=865) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:51:37 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Doc BaseType', Name='Document Base Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=865)
;

-- 3/05/2022, 4:52:06 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Doc Type Name',Updated=TO_TIMESTAMP('2022-05-03 16:52:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2098
;

-- 3/05/2022, 4:52:06 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Doc Type Name', Name='Document Type Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2098)
;

-- 3/05/2022, 4:53:09 p. m. GMT+02:00
UPDATE AD_Element SET Name='Duration Required', PrintName='Duration Required',Updated=TO_TIMESTAMP('2022-05-03 16:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53284
;

-- 3/05/2022, 4:53:09 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='DurationRequiered', Name='Duration Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53284
;

-- 3/05/2022, 4:53:09 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='DurationRequiered', Name='Duration Required', Description=NULL, Help=NULL, AD_Element_ID=53284 WHERE UPPER(ColumnName)='DURATIONREQUIERED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:53:09 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='DurationRequiered', Name='Duration Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53284 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:53:09 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='DurationRequiered', Name='Duration Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53284 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:53:09 p. m. GMT+02:00
UPDATE AD_Field SET Name='Duration Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53284) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:53:09 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Duration Required', Name='Duration Required' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53284)
;

-- 3/05/2022, 4:53:53 p. m. GMT+02:00
UPDATE AD_Element SET Name='Exclude Ser No', PrintName='Exclude Ser No',Updated=TO_TIMESTAMP('2022-05-03 16:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2831
;

-- 3/05/2022, 4:53:53 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='M_SerNoCtlExclude_ID', Name='Exclude Ser No', Description='Exclude the ability to create Serial Numbers in Attribute Sets', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2831
;

-- 3/05/2022, 4:53:53 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='M_SerNoCtlExclude_ID', Name='Exclude Ser No', Description='Exclude the ability to create Serial Numbers in Attribute Sets', Help=NULL, AD_Element_ID=2831 WHERE UPPER(ColumnName)='M_SERNOCTLEXCLUDE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:53:53 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='M_SerNoCtlExclude_ID', Name='Exclude Ser No', Description='Exclude the ability to create Serial Numbers in Attribute Sets', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2831 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:53:53 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='M_SerNoCtlExclude_ID', Name='Exclude Ser No', Description='Exclude the ability to create Serial Numbers in Attribute Sets', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2831 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:53:53 p. m. GMT+02:00
UPDATE AD_Field SET Name='Exclude Ser No', Description='Exclude the ability to create Serial Numbers in Attribute Sets', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2831) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:53:53 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Exclude Ser No', Name='Exclude Ser No' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2831)
;

-- 3/05/2022, 4:54:34 p. m. GMT+02:00
UPDATE AD_Element SET Name='Float Before', PrintName='Float Before',Updated=TO_TIMESTAMP('2022-05-03 16:54:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53301
;

-- 3/05/2022, 4:54:34 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='FloatBefored', Name='Float Before', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53301
;

-- 3/05/2022, 4:54:34 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='FloatBefored', Name='Float Before', Description=NULL, Help=NULL, AD_Element_ID=53301 WHERE UPPER(ColumnName)='FLOATBEFORED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:54:34 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='FloatBefored', Name='Float Before', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53301 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:54:34 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='FloatBefored', Name='Float Before', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53301 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:54:34 p. m. GMT+02:00
UPDATE AD_Field SET Name='Float Before', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53301) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:54:34 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Float Before', Name='Float Before' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53301)
;

-- 3/05/2022, 4:55:43 p. m. GMT+02:00
UPDATE AD_Element SET Name='Info Related', PrintName='Info Related',Updated=TO_TIMESTAMP('2022-05-03 16:55:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202556
;

-- 3/05/2022, 4:55:43 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='AD_InfoRelated_ID', Name='Info Related', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202556
;

-- 3/05/2022, 4:55:43 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AD_InfoRelated_ID', Name='Info Related', Description=NULL, Help=NULL, AD_Element_ID=202556 WHERE UPPER(ColumnName)='AD_INFORELATED_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:55:43 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AD_InfoRelated_ID', Name='Info Related', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202556 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:55:43 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='AD_InfoRelated_ID', Name='Info Related', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202556 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:55:43 p. m. GMT+02:00
UPDATE AD_Field SET Name='Info Related', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202556) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:55:43 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Info Related', Name='Info Related' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202556)
;

-- 3/05/2022, 4:56:22 p. m. GMT+02:00
UPDATE AD_Element SET Description='Input field validation query', Help='Input field validation query',Updated=TO_TIMESTAMP('2022-05-03 16:56:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203216
;

-- 3/05/2022, 4:56:22 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='InputFieldValidation', Name='Input field validation', Description='Input field validation query', Help='Input field validation query', Placeholder=NULL WHERE AD_Element_ID=203216
;

-- 3/05/2022, 4:56:22 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='InputFieldValidation', Name='Input field validation', Description='Input field validation query', Help='Input field validation query', AD_Element_ID=203216 WHERE UPPER(ColumnName)='INPUTFIELDVALIDATION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:56:22 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='InputFieldValidation', Name='Input field validation', Description='Input field validation query', Help='Input field validation query', Placeholder=NULL WHERE AD_Element_ID=203216 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:56:22 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='InputFieldValidation', Name='Input field validation', Description='Input field validation query', Help='Input field validation query', Placeholder=NULL WHERE AD_Element_ID=203216 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:56:22 p. m. GMT+02:00
UPDATE AD_Field SET Name='Input field validation', Description='Input field validation query', Help='Input field validation query', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203216) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:59:16 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Batch Time', PrintName='Is Batch Time',Updated=TO_TIMESTAMP('2022-05-03 16:59:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53309
;

-- 3/05/2022, 4:59:16 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsBatchTime', Name='Is Batch Time', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53309
;

-- 3/05/2022, 4:59:16 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsBatchTime', Name='Is Batch Time', Description=NULL, Help=NULL, AD_Element_ID=53309 WHERE UPPER(ColumnName)='ISBATCHTIME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 4:59:16 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsBatchTime', Name='Is Batch Time', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53309 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:59:16 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsBatchTime', Name='Is Batch Time', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53309 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:59:16 p. m. GMT+02:00
UPDATE AD_Field SET Name='Is Batch Time', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53309) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 4:59:16 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Is Batch Time', Name='Is Batch Time' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53309)
;

-- 3/05/2022, 5:00:06 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Auto Generate Lot',Updated=TO_TIMESTAMP('2022-05-03 17:00:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203078
;

-- 3/05/2022, 5:00:06 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsAutoGenerateLot', Name='Is Auto Generate Lot', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203078
;

-- 3/05/2022, 5:00:06 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsAutoGenerateLot', Name='Is Auto Generate Lot', Description=NULL, Help=NULL, AD_Element_ID=203078 WHERE UPPER(ColumnName)='ISAUTOGENERATELOT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:00:06 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsAutoGenerateLot', Name='Is Auto Generate Lot', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203078 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:00:06 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsAutoGenerateLot', Name='Is Auto Generate Lot', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203078 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:00:06 p. m. GMT+02:00
UPDATE AD_Field SET Name='Is Auto Generate Lot', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203078) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:00:06 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Auto Generate Lot', Name='Is Auto Generate Lot' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203078)
;

-- 3/05/2022, 5:01:17 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Discount Allowed On Total', PrintName='Is Discount Allowed On Total',Updated=TO_TIMESTAMP('2022-05-03 17:01:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52052
;

-- 3/05/2022, 5:01:17 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsDiscountAllowedOnTotal', Name='Is Discount Allowed On Total', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52052
;

-- 3/05/2022, 5:01:17 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsDiscountAllowedOnTotal', Name='Is Discount Allowed On Total', Description=NULL, Help=NULL, AD_Element_ID=52052 WHERE UPPER(ColumnName)='ISDISCOUNTALLOWEDONTOTAL' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:01:17 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsDiscountAllowedOnTotal', Name='Is Discount Allowed On Total', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52052 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:01:17 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsDiscountAllowedOnTotal', Name='Is Discount Allowed On Total', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52052 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:01:17 p. m. GMT+02:00
UPDATE AD_Field SET Name='Is Discount Allowed On Total', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52052) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:01:17 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Is Discount Allowed On Total', Name='Is Discount Allowed On Total' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52052)
;

-- 3/05/2022, 5:02:12 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Discount Up to Limit Price', PrintName='Is Discount Up to Limit Price',Updated=TO_TIMESTAMP('2022-05-03 17:02:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52051
;

-- 3/05/2022, 5:02:12 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsDiscountUptoLimitPrice', Name='Is Discount Up to Limit Price', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52051
;

-- 3/05/2022, 5:02:12 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsDiscountUptoLimitPrice', Name='Is Discount Up to Limit Price', Description=NULL, Help=NULL, AD_Element_ID=52051 WHERE UPPER(ColumnName)='ISDISCOUNTUPTOLIMITPRICE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:02:12 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsDiscountUptoLimitPrice', Name='Is Discount Up to Limit Price', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52051 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:02:12 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsDiscountUptoLimitPrice', Name='Is Discount Up to Limit Price', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52051 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:02:12 p. m. GMT+02:00
UPDATE AD_Field SET Name='Is Discount Up to Limit Price', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52051) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:02:12 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Is Discount Up to Limit Price', Name='Is Discount Up to Limit Price' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52051)
;

-- 3/05/2022, 5:03:25 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Fixed Asset',Updated=TO_TIMESTAMP('2022-05-03 17:03:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200176
;

-- 3/05/2022, 5:03:25 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsFixedAsset', Name='Is Fixed Asset', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200176
;

-- 3/05/2022, 5:03:25 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsFixedAsset', Name='Is Fixed Asset', Description=NULL, Help=NULL, AD_Element_ID=200176 WHERE UPPER(ColumnName)='ISFIXEDASSET' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:03:25 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsFixedAsset', Name='Is Fixed Asset', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200176 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:03:25 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsFixedAsset', Name='Is Fixed Asset', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200176 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:03:25 p. m. GMT+02:00
UPDATE AD_Field SET Name='Is Fixed Asset', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200176) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:03:25 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Fixed Asset ?', Name='Is Fixed Asset' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200176)
;

-- 3/05/2022, 5:05:29 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Fixed Asset Invoice', PrintName='Is Fixed Asset Invoice',Updated=TO_TIMESTAMP('2022-05-03 17:05:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=55168
;

-- 3/05/2022, 5:05:29 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsFixedAssetInvoice', Name='Is Fixed Asset Invoice', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=55168
;

-- 3/05/2022, 5:05:29 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsFixedAssetInvoice', Name='Is Fixed Asset Invoice', Description=NULL, Help=NULL, AD_Element_ID=55168 WHERE UPPER(ColumnName)='ISFIXEDASSETINVOICE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:05:30 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsFixedAssetInvoice', Name='Is Fixed Asset Invoice', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=55168 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:05:30 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsFixedAssetInvoice', Name='Is Fixed Asset Invoice', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=55168 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:05:30 p. m. GMT+02:00
UPDATE AD_Field SET Name='Is Fixed Asset Invoice', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=55168) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:05:30 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Is Fixed Asset Invoice', Name='Is Fixed Asset Invoice' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=55168)
;

-- 3/05/2022, 5:06:32 p. m. GMT+02:00
UPDATE AD_Element SET Name='is Present For Product',Updated=TO_TIMESTAMP('2022-05-03 17:06:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52027
;

-- 3/05/2022, 5:06:32 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='isPresentForProduct', Name='is Present For Product', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52027
;

-- 3/05/2022, 5:06:33 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='isPresentForProduct', Name='is Present For Product', Description=NULL, Help=NULL, AD_Element_ID=52027 WHERE UPPER(ColumnName)='ISPRESENTFORPRODUCT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:06:33 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='isPresentForProduct', Name='is Present For Product', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52027 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:06:33 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='isPresentForProduct', Name='is Present For Product', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52027 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:06:33 p. m. GMT+02:00
UPDATE AD_Field SET Name='is Present For Product', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52027) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:06:33 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Present for Product', Name='is Present For Product' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52027)
;

-- 3/05/2022, 5:07:07 p. m. GMT+02:00
UPDATE AD_Element SET Name='Issue User',Updated=TO_TIMESTAMP('2022-05-03 17:07:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2959
;

-- 3/05/2022, 5:07:07 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='R_IssueUser_ID', Name='Issue User', Description='User who reported issues', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2959
;

-- 3/05/2022, 5:07:07 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='R_IssueUser_ID', Name='Issue User', Description='User who reported issues', Help=NULL, AD_Element_ID=2959 WHERE UPPER(ColumnName)='R_ISSUEUSER_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:07:07 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='R_IssueUser_ID', Name='Issue User', Description='User who reported issues', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2959 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:07:07 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='R_IssueUser_ID', Name='Issue User', Description='User who reported issues', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2959 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:07:07 p. m. GMT+02:00
UPDATE AD_Field SET Name='Issue User', Description='User who reported issues', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2959) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:07:07 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Issue User', Name='Issue User' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2959)
;

-- 3/05/2022, 5:07:44 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Use ASP', PrintName='Is Use ASP',Updated=TO_TIMESTAMP('2022-05-03 17:07:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53325
;

-- 3/05/2022, 5:07:44 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsUseASP', Name='Is Use ASP', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53325
;

-- 3/05/2022, 5:07:44 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsUseASP', Name='Is Use ASP', Description=NULL, Help=NULL, AD_Element_ID=53325 WHERE UPPER(ColumnName)='ISUSEASP' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:07:44 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsUseASP', Name='Is Use ASP', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53325 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:07:44 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsUseASP', Name='Is Use ASP', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53325 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:07:44 p. m. GMT+02:00
UPDATE AD_Field SET Name='Is Use ASP', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53325) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:07:44 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Is Use ASP', Name='Is Use ASP' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53325)
;

-- 3/05/2022, 5:08:20 p. m. GMT+02:00
UPDATE AD_Element SET Description='The Jasper Process used by the print engine if any process defined',Updated=TO_TIMESTAMP('2022-05-03 17:08:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50064
;

-- 3/05/2022, 5:08:20 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='JasperProcess_ID', Name='Jasper Process', Description='The Jasper Process used by the print engine if any process defined', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50064
;

-- 3/05/2022, 5:08:20 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='JasperProcess_ID', Name='Jasper Process', Description='The Jasper Process used by the print engine if any process defined', Help=NULL, AD_Element_ID=50064 WHERE UPPER(ColumnName)='JASPERPROCESS_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:08:20 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='JasperProcess_ID', Name='Jasper Process', Description='The Jasper Process used by the print engine if any process defined', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50064 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:08:20 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='JasperProcess_ID', Name='Jasper Process', Description='The Jasper Process used by the print engine if any process defined', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50064 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:08:20 p. m. GMT+02:00
UPDATE AD_Field SET Name='Jasper Process', Description='The Jasper Process used by the print engine if any process defined', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=50064) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:09:05 p. m. GMT+02:00
UPDATE AD_Element SET Name='Key Code', Description='Key Code for shortcuts', PrintName='Key Code',Updated=TO_TIMESTAMP('2022-05-03 17:09:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200020
;

-- 3/05/2022, 5:09:05 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='KeyStroke_KeyCode', Name='Key Code', Description='Key Code for shortcuts', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200020
;

-- 3/05/2022, 5:09:05 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='KeyStroke_KeyCode', Name='Key Code', Description='Key Code for shortcuts', Help=NULL, AD_Element_ID=200020 WHERE UPPER(ColumnName)='KEYSTROKE_KEYCODE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:09:05 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='KeyStroke_KeyCode', Name='Key Code', Description='Key Code for shortcuts', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200020 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:09:05 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='KeyStroke_KeyCode', Name='Key Code', Description='Key Code for shortcuts', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200020 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:09:05 p. m. GMT+02:00
UPDATE AD_Field SET Name='Key Code', Description='Key Code for shortcuts', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200020) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:09:05 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Key Code', Name='Key Code' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200020)
;

-- 3/05/2022, 5:10:28 p. m. GMT+02:00
UPDATE AD_Element SET Name='Layout Type',Updated=TO_TIMESTAMP('2022-05-03 17:10:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202714
;

-- 3/05/2022, 5:10:28 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='LayoutType', Name='Layout Type', Description='Layout type of info process', Help='Process info can display as button, list, menu', Placeholder=NULL WHERE AD_Element_ID=202714
;

-- 3/05/2022, 5:10:28 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='LayoutType', Name='Layout Type', Description='Layout type of info process', Help='Process info can display as button, list, menu', AD_Element_ID=202714 WHERE UPPER(ColumnName)='LAYOUTTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:10:28 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='LayoutType', Name='Layout Type', Description='Layout type of info process', Help='Process info can display as button, list, menu', Placeholder=NULL WHERE AD_Element_ID=202714 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:10:28 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='LayoutType', Name='Layout Type', Description='Layout type of info process', Help='Process info can display as button, list, menu', Placeholder=NULL WHERE AD_Element_ID=202714 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:10:28 p. m. GMT+02:00
UPDATE AD_Field SET Name='Layout Type', Description='Layout type of info process', Help='Process info can display as button, list, menu', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202714) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:10:28 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Layout Type', Name='Layout Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202714)
;

-- 3/05/2022, 5:10:57 p. m. GMT+02:00
UPDATE AD_Element SET Name='Link URL', PrintName='Link URL',Updated=TO_TIMESTAMP('2022-05-03 17:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3027
;

-- 3/05/2022, 5:10:57 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='LinkURL', Name='Link URL', Description='Contains URL to a target', Help='A Link should contain info on how to get to more information', Placeholder=NULL WHERE AD_Element_ID=3027
;

-- 3/05/2022, 5:10:57 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='LinkURL', Name='Link URL', Description='Contains URL to a target', Help='A Link should contain info on how to get to more information', AD_Element_ID=3027 WHERE UPPER(ColumnName)='LINKURL' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:10:57 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='LinkURL', Name='Link URL', Description='Contains URL to a target', Help='A Link should contain info on how to get to more information', Placeholder=NULL WHERE AD_Element_ID=3027 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:10:57 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='LinkURL', Name='Link URL', Description='Contains URL to a target', Help='A Link should contain info on how to get to more information', Placeholder=NULL WHERE AD_Element_ID=3027 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:10:57 p. m. GMT+02:00
UPDATE AD_Field SET Name='Link URL', Description='Contains URL to a target', Help='A Link should contain info on how to get to more information', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=3027) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:10:57 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Link URL', Name='Link URL' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=3027)
;

-- 3/05/2022, 5:11:34 p. m. GMT+02:00
UPDATE AD_Element SET Name='List Price',Updated=TO_TIMESTAMP('2022-05-03 17:11:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2590
;

-- 3/05/2022, 5:11:34 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='PriceEnteredList', Name='List Price', Description='Entered List Price', Help='Price List converted to entered UOM', Placeholder=NULL WHERE AD_Element_ID=2590
;

-- 3/05/2022, 5:11:34 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='PriceEnteredList', Name='List Price', Description='Entered List Price', Help='Price List converted to entered UOM', AD_Element_ID=2590 WHERE UPPER(ColumnName)='PRICEENTEREDLIST' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:11:34 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='PriceEnteredList', Name='List Price', Description='Entered List Price', Help='Price List converted to entered UOM', Placeholder=NULL WHERE AD_Element_ID=2590 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:11:34 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='PriceEnteredList', Name='List Price', Description='Entered List Price', Help='Price List converted to entered UOM', Placeholder=NULL WHERE AD_Element_ID=2590 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:11:34 p. m. GMT+02:00
UPDATE AD_Field SET Name='List Price', Description='Entered List Price', Help='Price List converted to entered UOM', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2590) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:11:34 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='List Price', Name='List Price' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2590)
;

-- 3/05/2022, 5:12:31 p. m. GMT+02:00
UPDATE AD_Element SET Description='Want to Log the Acknowledgment of Message?',Updated=TO_TIMESTAMP('2022-05-03 17:12:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200246
;

-- 3/05/2022, 5:12:31 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='LogAcknowledge', Name='Log Acknowledge', Description='Want to Log the Acknowledgment of Message?', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200246
;

-- 3/05/2022, 5:12:31 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='LogAcknowledge', Name='Log Acknowledge', Description='Want to Log the Acknowledgment of Message?', Help=NULL, AD_Element_ID=200246 WHERE UPPER(ColumnName)='LOGACKNOWLEDGE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:12:31 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='LogAcknowledge', Name='Log Acknowledge', Description='Want to Log the Acknowledgment of Message?', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200246 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:12:31 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='LogAcknowledge', Name='Log Acknowledge', Description='Want to Log the Acknowledgment of Message?', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200246 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:12:31 p. m. GMT+02:00
UPDATE AD_Field SET Name='Log Acknowledge', Description='Want to Log the Acknowledgment of Message?', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200246) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:13:57 p. m. GMT+02:00
UPDATE AD_Element SET Description='The Client ID or Login submitted to the Lookup URL', Help='Enter the Client ID or Login for your account provided by the post code web service provider',Updated=TO_TIMESTAMP('2022-05-03 17:13:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=51002
;

-- 3/05/2022, 5:13:57 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='LookupClientID', Name='Lookup Tenant ID', Description='The Client ID or Login submitted to the Lookup URL', Help='Enter the Client ID or Login for your account provided by the post code web service provider', Placeholder=NULL WHERE AD_Element_ID=51002
;

-- 3/05/2022, 5:13:57 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='LookupClientID', Name='Lookup Tenant ID', Description='The Client ID or Login submitted to the Lookup URL', Help='Enter the Client ID or Login for your account provided by the post code web service provider', AD_Element_ID=51002 WHERE UPPER(ColumnName)='LOOKUPCLIENTID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:13:57 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='LookupClientID', Name='Lookup Tenant ID', Description='The Client ID or Login submitted to the Lookup URL', Help='Enter the Client ID or Login for your account provided by the post code web service provider', Placeholder=NULL WHERE AD_Element_ID=51002 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:13:57 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='LookupClientID', Name='Lookup Tenant ID', Description='The Client ID or Login submitted to the Lookup URL', Help='Enter the Client ID or Login for your account provided by the post code web service provider', Placeholder=NULL WHERE AD_Element_ID=51002 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:13:57 p. m. GMT+02:00
UPDATE AD_Field SET Name='Lookup Tenant ID', Description='The Client ID or Login submitted to the Lookup URL', Help='Enter the Client ID or Login for your account provided by the post code web service provider', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=51002) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:15:06 p. m. GMT+02:00
UPDATE AD_Element SET Name='Model Package', PrintName='Model Package',Updated=TO_TIMESTAMP('2022-05-03 17:15:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3053
;

-- 3/05/2022, 5:15:06 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='ModelPackage', Name='Model Package', Description='Java Package of the model classes', Help='By default, the Java model classes for extensions are in the compiere.model package.  If you provide a jar file in the classpath, you can define here your specific model package.  The model classes are used to save/modify/delete entries and as well as in Workflow.  Refer to the Compiere naming convention to make sure that your class is used rather then the base classes.', Placeholder=NULL WHERE AD_Element_ID=3053
;

-- 3/05/2022, 5:15:06 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ModelPackage', Name='Model Package', Description='Java Package of the model classes', Help='By default, the Java model classes for extensions are in the compiere.model package.  If you provide a jar file in the classpath, you can define here your specific model package.  The model classes are used to save/modify/delete entries and as well as in Workflow.  Refer to the Compiere naming convention to make sure that your class is used rather then the base classes.', AD_Element_ID=3053 WHERE UPPER(ColumnName)='MODELPACKAGE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:15:06 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ModelPackage', Name='Model Package', Description='Java Package of the model classes', Help='By default, the Java model classes for extensions are in the compiere.model package.  If you provide a jar file in the classpath, you can define here your specific model package.  The model classes are used to save/modify/delete entries and as well as in Workflow.  Refer to the Compiere naming convention to make sure that your class is used rather then the base classes.', Placeholder=NULL WHERE AD_Element_ID=3053 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:15:06 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='ModelPackage', Name='Model Package', Description='Java Package of the model classes', Help='By default, the Java model classes for extensions are in the compiere.model package.  If you provide a jar file in the classpath, you can define here your specific model package.  The model classes are used to save/modify/delete entries and as well as in Workflow.  Refer to the Compiere naming convention to make sure that your class is used rather then the base classes.', Placeholder=NULL WHERE AD_Element_ID=3053 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:15:06 p. m. GMT+02:00
UPDATE AD_Field SET Name='Model Package', Description='Java Package of the model classes', Help='By default, the Java model classes for extensions are in the compiere.model package.  If you provide a jar file in the classpath, you can define here your specific model package.  The model classes are used to save/modify/delete entries and as well as in Workflow.  Refer to the Compiere naming convention to make sure that your class is used rather then the base classes.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=3053) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:15:06 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Model Package', Name='Model Package' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=3053)
;

-- 3/05/2022, 5:16:07 p. m. GMT+02:00
UPDATE AD_Element SET Description='Print column headers on multiple lines if necessary.',Updated=TO_TIMESTAMP('2022-05-03 17:16:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53690
;

-- 3/05/2022, 5:16:07 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsMultiLineHeader', Name='Multi Line Header', Description='Print column headers on multiple lines if necessary.', Help='If selected, column header text will wrap onto the next line -- otherwise the text will be truncated.', Placeholder=NULL WHERE AD_Element_ID=53690
;

-- 3/05/2022, 5:16:07 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsMultiLineHeader', Name='Multi Line Header', Description='Print column headers on multiple lines if necessary.', Help='If selected, column header text will wrap onto the next line -- otherwise the text will be truncated.', AD_Element_ID=53690 WHERE UPPER(ColumnName)='ISMULTILINEHEADER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:16:07 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsMultiLineHeader', Name='Multi Line Header', Description='Print column headers on multiple lines if necessary.', Help='If selected, column header text will wrap onto the next line -- otherwise the text will be truncated.', Placeholder=NULL WHERE AD_Element_ID=53690 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:16:07 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsMultiLineHeader', Name='Multi Line Header', Description='Print column headers on multiple lines if necessary.', Help='If selected, column header text will wrap onto the next line -- otherwise the text will be truncated.', Placeholder=NULL WHERE AD_Element_ID=53690 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:16:07 p. m. GMT+02:00
UPDATE AD_Field SET Name='Multi Line Header', Description='Print column headers on multiple lines if necessary.', Help='If selected, column header text will wrap onto the next line -- otherwise the text will be truncated.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53690) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:17:19 p. m. GMT+02:00
UPDATE AD_Element SET Name='New Password Confirm',Updated=TO_TIMESTAMP('2022-05-03 17:17:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200064
;

-- 3/05/2022, 5:17:19 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='NewPasswordConfirm', Name='New Password Confirm', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200064
;

-- 3/05/2022, 5:17:19 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='NewPasswordConfirm', Name='New Password Confirm', Description=NULL, Help=NULL, AD_Element_ID=200064 WHERE UPPER(ColumnName)='NEWPASSWORDCONFIRM' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:17:19 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='NewPasswordConfirm', Name='New Password Confirm', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200064 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:17:19 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='NewPasswordConfirm', Name='New Password Confirm', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200064 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:17:19 p. m. GMT+02:00
UPDATE AD_Field SET Name='New Password Confirm', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200064) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:17:19 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='New Password Confirm', Name='New Password Confirm' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200064)
;

-- 3/05/2022, 5:18:16 p. m. GMT+02:00
UPDATE AD_Element SET Name='Next Maintenance', Description='Next Maintenance Date', PrintName='Next Maintenance',Updated=TO_TIMESTAMP('2022-05-03 17:18:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2932
;

-- 3/05/2022, 5:18:16 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='NextMaintenenceDate', Name='Next Maintenance', Description='Next Maintenance Date', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2932
;

-- 3/05/2022, 5:18:16 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='NextMaintenenceDate', Name='Next Maintenance', Description='Next Maintenance Date', Help=NULL, AD_Element_ID=2932 WHERE UPPER(ColumnName)='NEXTMAINTENENCEDATE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:18:16 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='NextMaintenenceDate', Name='Next Maintenance', Description='Next Maintenance Date', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2932 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:18:16 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='NextMaintenenceDate', Name='Next Maintenance', Description='Next Maintenance Date', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2932 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:18:16 p. m. GMT+02:00
UPDATE AD_Field SET Name='Next Maintenance', Description='Next Maintenance Date', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2932) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:18:16 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Next Maintenance', Name='Next Maintenance' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2932)
;

-- 3/05/2022, 5:19:20 p. m. GMT+02:00
UPDATE AD_Element SET Name='Not Committed Amount',Updated=TO_TIMESTAMP('2022-05-03 17:19:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2416
;

-- 3/05/2022, 5:19:20 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='NonCommittedAmt', Name='Not Committed Amount', Description='Amount not committed yet', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2416
;

-- 3/05/2022, 5:19:20 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='NonCommittedAmt', Name='Not Committed Amount', Description='Amount not committed yet', Help=NULL, AD_Element_ID=2416 WHERE UPPER(ColumnName)='NONCOMMITTEDAMT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:19:20 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='NonCommittedAmt', Name='Not Committed Amount', Description='Amount not committed yet', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2416 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:19:20 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='NonCommittedAmt', Name='Not Committed Amount', Description='Amount not committed yet', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=2416 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:19:20 p. m. GMT+02:00
UPDATE AD_Field SET Name='Not Committed Amount', Description='Amount not committed yet', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2416) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:19:20 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Not Committed Amt', Name='Not Committed Amount' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2416)
;

-- 3/05/2022, 5:20:32 p. m. GMT+02:00
UPDATE AD_Element SET Name='Overwrite Trx Organization',Updated=TO_TIMESTAMP('2022-05-03 17:20:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2612
;

-- 3/05/2022, 5:20:32 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='OverwriteOrgTrx', Name='Overwrite Trx Organization', Description='Overwrite the account segment Transaction Organization with the value specified', Help='If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.', Placeholder=NULL WHERE AD_Element_ID=2612
;

-- 3/05/2022, 5:20:32 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='OverwriteOrgTrx', Name='Overwrite Trx Organization', Description='Overwrite the account segment Transaction Organization with the value specified', Help='If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.', AD_Element_ID=2612 WHERE UPPER(ColumnName)='OVERWRITEORGTRX' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:20:32 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='OverwriteOrgTrx', Name='Overwrite Trx Organization', Description='Overwrite the account segment Transaction Organization with the value specified', Help='If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.', Placeholder=NULL WHERE AD_Element_ID=2612 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:20:32 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='OverwriteOrgTrx', Name='Overwrite Trx Organization', Description='Overwrite the account segment Transaction Organization with the value specified', Help='If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.', Placeholder=NULL WHERE AD_Element_ID=2612 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:20:32 p. m. GMT+02:00
UPDATE AD_Field SET Name='Overwrite Trx Organization', Description='Overwrite the account segment Transaction Organization with the value specified', Help='If not overwritten, the value of the original account combination is used. If selected, but not specified, the segment is set to null.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2612) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:20:32 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Overwrite Trx Org', Name='Overwrite Trx Organization' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2612)
;

-- 3/05/2022, 5:22:44 p. m. GMT+02:00
UPDATE AD_Element SET Name='Posting Type', PrintName='Posting Type',Updated=TO_TIMESTAMP('2022-05-03 17:22:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=514
;

-- 3/05/2022, 5:22:44 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='PostingType', Name='Posting Type', Description='The type of posted amount for the transaction', Help='The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.', Placeholder=NULL WHERE AD_Element_ID=514
;

-- 3/05/2022, 5:22:44 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='PostingType', Name='Posting Type', Description='The type of posted amount for the transaction', Help='The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.', AD_Element_ID=514 WHERE UPPER(ColumnName)='POSTINGTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:22:44 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='PostingType', Name='Posting Type', Description='The type of posted amount for the transaction', Help='The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.', Placeholder=NULL WHERE AD_Element_ID=514 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:22:44 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='PostingType', Name='Posting Type', Description='The type of posted amount for the transaction', Help='The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.', Placeholder=NULL WHERE AD_Element_ID=514 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:22:44 p. m. GMT+02:00
UPDATE AD_Field SET Name='Posting Type', Description='The type of posted amount for the transaction', Help='The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=514) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:22:44 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Posting Type', Name='Posting Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=514)
;

-- 3/05/2022, 5:23:51 p. m. GMT+02:00
UPDATE AD_Element SET Name='Privileged Rate', PrintName='Privileged Rate',Updated=TO_TIMESTAMP('2022-05-03 17:23:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=201981
;

-- 3/05/2022, 5:23:51 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsPriviledgedRate', Name='Privileged Rate', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=201981
;

-- 3/05/2022, 5:23:51 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsPriviledgedRate', Name='Privileged Rate', Description=NULL, Help=NULL, AD_Element_ID=201981 WHERE UPPER(ColumnName)='ISPRIVILEDGEDRATE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:23:51 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsPriviledgedRate', Name='Privileged Rate', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=201981 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:23:51 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsPriviledgedRate', Name='Privileged Rate', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=201981 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:23:51 p. m. GMT+02:00
UPDATE AD_Field SET Name='Privileged Rate', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=201981) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:23:51 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Privileged Rate', Name='Privileged Rate' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=201981)
;

-- 3/05/2022, 5:24:58 p. m. GMT+02:00
UPDATE AD_Element SET Name='Purchase Price List', PrintName='Purchase Price List',Updated=TO_TIMESTAMP('2022-05-03 17:24:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=480
;

-- 3/05/2022, 5:24:58 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='PO_PriceList_ID', Name='Purchase Price List', Description='Price List used by this Business Partner', Help='Identifies the price list used by a Vendor for products purchased by this organization.', Placeholder=NULL WHERE AD_Element_ID=480
;

-- 3/05/2022, 5:24:58 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='PO_PriceList_ID', Name='Purchase Price List', Description='Price List used by this Business Partner', Help='Identifies the price list used by a Vendor for products purchased by this organization.', AD_Element_ID=480 WHERE UPPER(ColumnName)='PO_PRICELIST_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:24:58 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='PO_PriceList_ID', Name='Purchase Price List', Description='Price List used by this Business Partner', Help='Identifies the price list used by a Vendor for products purchased by this organization.', Placeholder=NULL WHERE AD_Element_ID=480 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:24:58 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='PO_PriceList_ID', Name='Purchase Price List', Description='Price List used by this Business Partner', Help='Identifies the price list used by a Vendor for products purchased by this organization.', Placeholder=NULL WHERE AD_Element_ID=480 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:24:58 p. m. GMT+02:00
UPDATE AD_Field SET Name='Purchase Price List', Description='Price List used by this Business Partner', Help='Identifies the price list used by a Vendor for products purchased by this organization.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=480) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:24:58 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Purchase Price List', Name='Purchase Price List' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=480)
;

-- 3/05/2022, 5:26:24 p. m. GMT+02:00
UPDATE AD_Element SET Name='Qty Batch', PrintName='Qty Batch',Updated=TO_TIMESTAMP('2022-05-03 17:26:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53302
;

-- 3/05/2022, 5:26:24 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='QtyBatchs', Name='Qty Batch', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53302
;

-- 3/05/2022, 5:26:24 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='QtyBatchs', Name='Qty Batch', Description=NULL, Help=NULL, AD_Element_ID=53302 WHERE UPPER(ColumnName)='QTYBATCHS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:26:24 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='QtyBatchs', Name='Qty Batch', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53302 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:26:24 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='QtyBatchs', Name='Qty Batch', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53302 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:26:24 p. m. GMT+02:00
UPDATE AD_Field SET Name='Qty Batch', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53302) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:26:24 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Qty Batch', Name='Qty Batch' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53302)
;

-- 3/05/2022, 5:27:26 p. m. GMT+02:00
UPDATE AD_Element SET Name='Qty Required',Updated=TO_TIMESTAMP('2022-05-03 17:27:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53288
;

-- 3/05/2022, 5:27:26 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='QtyRequiered', Name='Qty Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53288
;

-- 3/05/2022, 5:27:26 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='QtyRequiered', Name='Qty Required', Description=NULL, Help=NULL, AD_Element_ID=53288 WHERE UPPER(ColumnName)='QTYREQUIERED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:27:26 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='QtyRequiered', Name='Qty Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53288 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:27:26 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='QtyRequiered', Name='Qty Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53288 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:27:26 p. m. GMT+02:00
UPDATE AD_Field SET Name='Qty Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53288) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:27:26 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Qty Required', Name='Qty Required' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53288)
;

-- 3/05/2022, 5:28:21 p. m. GMT+02:00
UPDATE AD_Element SET Name='Qty Csv', PrintName='Qty Csv',Updated=TO_TIMESTAMP('2022-05-03 17:28:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52053
;

-- 3/05/2022, 5:28:21 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='QtyCsv', Name='Qty Csv', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52053
;

-- 3/05/2022, 5:28:21 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='QtyCsv', Name='Qty Csv', Description=NULL, Help=NULL, AD_Element_ID=52053 WHERE UPPER(ColumnName)='QTYCSV' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:28:21 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='QtyCsv', Name='Qty Csv', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52053 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:28:21 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='QtyCsv', Name='Qty Csv', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52053 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:28:21 p. m. GMT+02:00
UPDATE AD_Field SET Name='Qty Csv', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52053) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:28:21 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Qty Csv', Name='Qty Csv' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52053)
;

-- 3/05/2022, 5:29:19 p. m. GMT+02:00
UPDATE AD_Element SET Description='Length of QWERTY sequences to validate',Updated=TO_TIMESTAMP('2022-05-03 17:29:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200029
;

-- 3/05/2022, 5:29:19 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Length of QWERTY sequences to validate', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200029
;

-- 3/05/2022, 5:29:19 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Length of QWERTY sequences to validate', Help=NULL, AD_Element_ID=200029 WHERE UPPER(ColumnName)='QWERTYSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:29:19 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Length of QWERTY sequences to validate', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200029 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:29:19 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Length of QWERTY sequences to validate', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200029 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:29:19 p. m. GMT+02:00
UPDATE AD_Field SET Name='QWERTY Sequence', Description='Length of QWERTY sequences to validate', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200029) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:30:27 p. m. GMT+02:00
UPDATE AD_Element SET Name='Require Credit Card Verification Code',Updated=TO_TIMESTAMP('2022-05-03 17:30:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1499
;

-- 3/05/2022, 5:30:27 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='RequireVV', Name='Require Credit Card Verification Code', Description='Require 3/4 digit Credit Verification Code', Help='The Require CC Verification checkbox indicates if this bank accounts requires a verification number for credit card transactions.', Placeholder=NULL WHERE AD_Element_ID=1499
;

-- 3/05/2022, 5:30:27 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='RequireVV', Name='Require Credit Card Verification Code', Description='Require 3/4 digit Credit Verification Code', Help='The Require CC Verification checkbox indicates if this bank accounts requires a verification number for credit card transactions.', AD_Element_ID=1499 WHERE UPPER(ColumnName)='REQUIREVV' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:30:27 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='RequireVV', Name='Require Credit Card Verification Code', Description='Require 3/4 digit Credit Verification Code', Help='The Require CC Verification checkbox indicates if this bank accounts requires a verification number for credit card transactions.', Placeholder=NULL WHERE AD_Element_ID=1499 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:30:27 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='RequireVV', Name='Require Credit Card Verification Code', Description='Require 3/4 digit Credit Verification Code', Help='The Require CC Verification checkbox indicates if this bank accounts requires a verification number for credit card transactions.', Placeholder=NULL WHERE AD_Element_ID=1499 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:30:27 p. m. GMT+02:00
UPDATE AD_Field SET Name='Require Credit Card Verification Code', Description='Require 3/4 digit Credit Verification Code', Help='The Require CC Verification checkbox indicates if this bank accounts requires a verification number for credit card transactions.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1499) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:30:27 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Require Verification Code', Name='Require Credit Card Verification Code' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1499)
;

-- 3/05/2022, 5:31:31 p. m. GMT+02:00
UPDATE AD_Element SET Name='Sales Price List', PrintName='Sales Price List',Updated=TO_TIMESTAMP('2022-05-03 17:31:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52046
;

-- 3/05/2022, 5:31:31 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='SO_PriceList_ID', Name='Sales Price List', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52046
;

-- 3/05/2022, 5:31:31 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='SO_PriceList_ID', Name='Sales Price List', Description=NULL, Help=NULL, AD_Element_ID=52046 WHERE UPPER(ColumnName)='SO_PRICELIST_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:31:31 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='SO_PriceList_ID', Name='Sales Price List', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52046 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:31:31 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='SO_PriceList_ID', Name='Sales Price List', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52046 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:31:31 p. m. GMT+02:00
UPDATE AD_Field SET Name='Sales Price List', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52046) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:31:31 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Sales Price List', Name='Sales Price List' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52046)
;

-- 3/05/2022, 5:33:23 p. m. GMT+02:00
UPDATE AD_Element SET Description='Scrap % Quantity for this component', Help='Scrap % Quantity for this component',Updated=TO_TIMESTAMP('2022-05-03 17:33:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53289
;

-- 3/05/2022, 5:33:23 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='QtyScrap', Name='Scrap %', Description='Scrap % Quantity for this component', Help='Scrap % Quantity for this component', Placeholder=NULL WHERE AD_Element_ID=53289
;

-- 3/05/2022, 5:33:23 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='QtyScrap', Name='Scrap %', Description='Scrap % Quantity for this component', Help='Scrap % Quantity for this component', AD_Element_ID=53289 WHERE UPPER(ColumnName)='QTYSCRAP' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:33:23 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='QtyScrap', Name='Scrap %', Description='Scrap % Quantity for this component', Help='Scrap % Quantity for this component', Placeholder=NULL WHERE AD_Element_ID=53289 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:33:23 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='QtyScrap', Name='Scrap %', Description='Scrap % Quantity for this component', Help='Scrap % Quantity for this component', Placeholder=NULL WHERE AD_Element_ID=53289 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:33:23 p. m. GMT+02:00
UPDATE AD_Field SET Name='Scrap %', Description='Scrap % Quantity for this component', Help='Scrap % Quantity for this component', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53289) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:39:10 p. m. GMT+02:00
UPDATE AD_Element SET Name='Ser No Char End Overwrite', PrintName='Ser No Char End',Updated=TO_TIMESTAMP('2022-05-03 17:39:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2857
;

-- 3/05/2022, 5:39:10 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='SerNoCharEOverwrite', Name='Ser No Char End Overwrite', Description='Serial Number End Indicator overwrite - default empty', Help='If not defined, no character is used', Placeholder=NULL WHERE AD_Element_ID=2857
;

-- 3/05/2022, 5:39:10 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='SerNoCharEOverwrite', Name='Ser No Char End Overwrite', Description='Serial Number End Indicator overwrite - default empty', Help='If not defined, no character is used', AD_Element_ID=2857 WHERE UPPER(ColumnName)='SERNOCHAREOVERWRITE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:39:10 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='SerNoCharEOverwrite', Name='Ser No Char End Overwrite', Description='Serial Number End Indicator overwrite - default empty', Help='If not defined, no character is used', Placeholder=NULL WHERE AD_Element_ID=2857 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:39:10 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='SerNoCharEOverwrite', Name='Ser No Char End Overwrite', Description='Serial Number End Indicator overwrite - default empty', Help='If not defined, no character is used', Placeholder=NULL WHERE AD_Element_ID=2857 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:39:10 p. m. GMT+02:00
UPDATE AD_Field SET Name='Ser No Char End Overwrite', Description='Serial Number End Indicator overwrite - default empty', Help='If not defined, no character is used', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2857) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:39:10 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Ser No Char End', Name='Ser No Char End Overwrite' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2857)
;

-- 3/05/2022, 5:40:12 p. m. GMT+02:00
UPDATE AD_Element SET Name='Ser No Char Start Overwrite', PrintName='Ser No Char Start',Updated=TO_TIMESTAMP('2022-05-03 17:40:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2856
;

-- 3/05/2022, 5:40:12 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='SerNoCharSOverwrite', Name='Ser No Char Start Overwrite', Description='Serial Number Start Indicator overwrite - default #', Help='If not defined, the default character # is used', Placeholder=NULL WHERE AD_Element_ID=2856
;

-- 3/05/2022, 5:40:12 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='SerNoCharSOverwrite', Name='Ser No Char Start Overwrite', Description='Serial Number Start Indicator overwrite - default #', Help='If not defined, the default character # is used', AD_Element_ID=2856 WHERE UPPER(ColumnName)='SERNOCHARSOVERWRITE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:40:12 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='SerNoCharSOverwrite', Name='Ser No Char Start Overwrite', Description='Serial Number Start Indicator overwrite - default #', Help='If not defined, the default character # is used', Placeholder=NULL WHERE AD_Element_ID=2856 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:40:12 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='SerNoCharSOverwrite', Name='Ser No Char Start Overwrite', Description='Serial Number Start Indicator overwrite - default #', Help='If not defined, the default character # is used', Placeholder=NULL WHERE AD_Element_ID=2856 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:40:12 p. m. GMT+02:00
UPDATE AD_Field SET Name='Ser No Char Start Overwrite', Description='Serial Number Start Indicator overwrite - default #', Help='If not defined, the default character # is used', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2856) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:40:12 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Ser No Char Start', Name='Ser No Char Start Overwrite' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2856)
;

-- 3/05/2022, 5:47:31 p. m. GMT+02:00
UPDATE AD_Element SET Name='Setup Time Required', PrintName='Setup Time Required',Updated=TO_TIMESTAMP('2022-05-03 17:47:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53291
;

-- 3/05/2022, 5:47:31 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='SetupTimeRequiered', Name='Setup Time Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53291
;

-- 3/05/2022, 5:47:31 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='SetupTimeRequiered', Name='Setup Time Required', Description=NULL, Help=NULL, AD_Element_ID=53291 WHERE UPPER(ColumnName)='SETUPTIMEREQUIERED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:47:31 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='SetupTimeRequiered', Name='Setup Time Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53291 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:47:31 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='SetupTimeRequiered', Name='Setup Time Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53291 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:47:31 p. m. GMT+02:00
UPDATE AD_Field SET Name='Setup Time Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53291) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:47:31 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Setup Time Required', Name='Setup Time Required' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53291)
;

-- 3/05/2022, 5:48:04 p. m. GMT+02:00
UPDATE AD_Element SET Name='Shipper Name',Updated=TO_TIMESTAMP('2022-05-03 17:48:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54240
;

-- 3/05/2022, 5:48:04 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='ShipperName', Name='Shipper Name', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=54240
;

-- 3/05/2022, 5:48:04 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ShipperName', Name='Shipper Name', Description=NULL, Help=NULL, AD_Element_ID=54240 WHERE UPPER(ColumnName)='SHIPPERNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:48:04 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='ShipperName', Name='Shipper Name', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=54240 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:48:04 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='ShipperName', Name='Shipper Name', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=54240 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:48:04 p. m. GMT+02:00
UPDATE AD_Field SET Name='Shipper Name', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=54240) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:48:04 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Shipper Name', Name='Shipper Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=54240)
;

-- 3/05/2022, 5:49:38 p. m. GMT+02:00
UPDATE AD_Element SET Name='Structure XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', PrintName='Structure XML',Updated=TO_TIMESTAMP('2022-05-03 17:49:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2994
;

-- 3/05/2022, 5:49:38 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='StructureXML', Name='Structure XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', Placeholder=NULL WHERE AD_Element_ID=2994
;

-- 3/05/2022, 5:49:38 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='StructureXML', Name='Structure XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', AD_Element_ID=2994 WHERE UPPER(ColumnName)='STRUCTUREXML' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:49:38 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='StructureXML', Name='Structure XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', Placeholder=NULL WHERE AD_Element_ID=2994 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:49:38 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='StructureXML', Name='Structure XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', Placeholder=NULL WHERE AD_Element_ID=2994 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:49:38 p. m. GMT+02:00
UPDATE AD_Field SET Name='Structure XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2994) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:49:38 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Structure XML', Name='Structure XML' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2994)
;

-- 3/05/2022, 5:50:14 p. m. GMT+02:00
UPDATE AD_Element SET Name='Template XST', PrintName='Template XST',Updated=TO_TIMESTAMP('2022-05-03 17:50:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2984
;

-- 3/05/2022, 5:50:14 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='TemplateXST', Name='Template XST', Description='Contains the template code itself', Help='Here we include the template code itself', Placeholder=NULL WHERE AD_Element_ID=2984
;

-- 3/05/2022, 5:50:14 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='TemplateXST', Name='Template XST', Description='Contains the template code itself', Help='Here we include the template code itself', AD_Element_ID=2984 WHERE UPPER(ColumnName)='TEMPLATEXST' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:50:14 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='TemplateXST', Name='Template XST', Description='Contains the template code itself', Help='Here we include the template code itself', Placeholder=NULL WHERE AD_Element_ID=2984 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:50:14 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='TemplateXST', Name='Template XST', Description='Contains the template code itself', Help='Here we include the template code itself', Placeholder=NULL WHERE AD_Element_ID=2984 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:50:14 p. m. GMT+02:00
UPDATE AD_Field SET Name='Template XST', Description='Contains the template code itself', Help='Here we include the template code itself', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2984) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:50:14 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Template XST', Name='Template XST' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2984)
;

-- 3/05/2022, 5:50:53 p. m. GMT+02:00
UPDATE AD_Element SET Name='Time Out In Seconds', PrintName='Time out In Seconds',Updated=TO_TIMESTAMP('2022-05-03 17:50:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200256
;

-- 3/05/2022, 5:50:53 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='TimeOutInSeconds', Name='Time Out In Seconds', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200256
;

-- 3/05/2022, 5:50:53 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='TimeOutInSeconds', Name='Time Out In Seconds', Description=NULL, Help=NULL, AD_Element_ID=200256 WHERE UPPER(ColumnName)='TIMEOUTINSECONDS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:50:53 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='TimeOutInSeconds', Name='Time Out In Seconds', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200256 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:50:53 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='TimeOutInSeconds', Name='Time Out In Seconds', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200256 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:50:53 p. m. GMT+02:00
UPDATE AD_Field SET Name='Time Out In Seconds', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200256) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:50:53 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Time out In Seconds', Name='Time Out In Seconds' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200256)
;

-- 3/05/2022, 5:51:52 p. m. GMT+02:00
UPDATE AD_Element SET Name='Token Type',Updated=TO_TIMESTAMP('2022-05-03 17:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3103
;

-- 3/05/2022, 5:51:52 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='TokenType', Name='Token Type', Description='Wiki Token Type', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=3103
;

-- 3/05/2022, 5:51:52 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='TokenType', Name='Token Type', Description='Wiki Token Type', Help=NULL, AD_Element_ID=3103 WHERE UPPER(ColumnName)='TOKENTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:51:52 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='TokenType', Name='Token Type', Description='Wiki Token Type', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=3103 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:51:52 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='TokenType', Name='Token Type', Description='Wiki Token Type', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=3103 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:51:52 p. m. GMT+02:00
UPDATE AD_Field SET Name='Token Type', Description='Wiki Token Type', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=3103) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:51:52 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Token Type', Name='Token Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=3103)
;

-- 3/05/2022, 5:54:01 p. m. GMT+02:00
UPDATE AD_Element SET Name='Transfer Check trx to',Updated=TO_TIMESTAMP('2022-05-03 17:54:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52036
;

-- 3/05/2022, 5:54:01 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='CheckTransferBankAccount_ID', Name='Transfer Check trx to', Description='Bank account on which to transfer Check transactions', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52036
;

-- 3/05/2022, 5:54:01 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CheckTransferBankAccount_ID', Name='Transfer Check trx to', Description='Bank account on which to transfer Check transactions', Help=NULL, AD_Element_ID=52036 WHERE UPPER(ColumnName)='CHECKTRANSFERBANKACCOUNT_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:54:01 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CheckTransferBankAccount_ID', Name='Transfer Check trx to', Description='Bank account on which to transfer Check transactions', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52036 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:54:01 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='CheckTransferBankAccount_ID', Name='Transfer Check trx to', Description='Bank account on which to transfer Check transactions', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52036 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:54:01 p. m. GMT+02:00
UPDATE AD_Field SET Name='Transfer Check trx to', Description='Bank account on which to transfer Check transactions', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52036) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:54:01 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Transfer Check trx to', Name='Transfer Check trx to' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52036)
;

-- 3/05/2022, 5:55:04 p. m. GMT+02:00
UPDATE AD_Element SET Name='Transfer Time', PrintName='Transfer Time',Updated=TO_TIMESTAMP('2022-05-03 17:55:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53271
;

-- 3/05/2022, 5:55:04 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='TransfertTime', Name='Transfer Time', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53271
;

-- 3/05/2022, 5:55:04 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='TransfertTime', Name='Transfer Time', Description=NULL, Help=NULL, AD_Element_ID=53271 WHERE UPPER(ColumnName)='TRANSFERTTIME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:55:04 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='TransfertTime', Name='Transfer Time', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53271 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:55:04 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='TransfertTime', Name='Transfer Time', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53271 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:55:04 p. m. GMT+02:00
UPDATE AD_Field SET Name='Transfer Time', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53271) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:55:04 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Transfer Time', Name='Transfer Time' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53271)
;

-- 3/05/2022, 5:56:44 p. m. GMT+02:00
UPDATE AD_Element SET Name='Translation Tab', PrintName='Translation Tab',Updated=TO_TIMESTAMP('2022-05-03 17:56:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=421
;

-- 3/05/2022, 5:56:44 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='IsTranslationTab', Name='Translation Tab', Description='This Tab contains translation information', Help='The Translation Tab checkbox indicate if a tab contains translation information. To display translation information, enable this in Tools>Preference.', Placeholder=NULL WHERE AD_Element_ID=421
;

-- 3/05/2022, 5:56:44 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsTranslationTab', Name='Translation Tab', Description='This Tab contains translation information', Help='The Translation Tab checkbox indicate if a tab contains translation information. To display translation information, enable this in Tools>Preference.', AD_Element_ID=421 WHERE UPPER(ColumnName)='ISTRANSLATIONTAB' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:56:44 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='IsTranslationTab', Name='Translation Tab', Description='This Tab contains translation information', Help='The Translation Tab checkbox indicate if a tab contains translation information. To display translation information, enable this in Tools>Preference.', Placeholder=NULL WHERE AD_Element_ID=421 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:56:44 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='IsTranslationTab', Name='Translation Tab', Description='This Tab contains translation information', Help='The Translation Tab checkbox indicate if a tab contains translation information. To display translation information, enable this in Tools>Preference.', Placeholder=NULL WHERE AD_Element_ID=421 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:56:44 p. m. GMT+02:00
UPDATE AD_Field SET Name='Translation Tab', Description='This Tab contains translation information', Help='The Translation Tab checkbox indicate if a tab contains translation information. To display translation information, enable this in Tools>Preference.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=421) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:56:44 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Translation Tab', Name='Translation Tab' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=421)
;

-- 3/05/2022, 5:57:14 p. m. GMT+02:00
UPDATE AD_Element SET Name='Units Per Pack', PrintName='Units Per Pack',Updated=TO_TIMESTAMP('2022-05-03 17:57:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52054
;

-- 3/05/2022, 5:57:14 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='UnitsPerPack', Name='Units Per Pack', Description='The Units Per Pack indicates the no of units of a product packed together.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52054
;

-- 3/05/2022, 5:57:14 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='UnitsPerPack', Name='Units Per Pack', Description='The Units Per Pack indicates the no of units of a product packed together.', Help=NULL, AD_Element_ID=52054 WHERE UPPER(ColumnName)='UNITSPERPACK' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:57:14 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='UnitsPerPack', Name='Units Per Pack', Description='The Units Per Pack indicates the no of units of a product packed together.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52054 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:57:14 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='UnitsPerPack', Name='Units Per Pack', Description='The Units Per Pack indicates the no of units of a product packed together.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52054 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:57:14 p. m. GMT+02:00
UPDATE AD_Field SET Name='Units Per Pack', Description='The Units Per Pack indicates the no of units of a product packed together.', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52054) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:57:14 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Units Per Pack', Name='Units Per Pack' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52054)
;

-- 3/05/2022, 5:57:59 p. m. GMT+02:00
UPDATE AD_Element SET Name='Unlocking Time', PrintName='Unlocking Time',Updated=TO_TIMESTAMP('2022-05-03 17:57:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52047
;

-- 3/05/2022, 5:57:59 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='UnlockingTime', Name='Unlocking Time', Description='Time at which the terminal should be unlocked', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52047
;

-- 3/05/2022, 5:57:59 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='UnlockingTime', Name='Unlocking Time', Description='Time at which the terminal should be unlocked', Help=NULL, AD_Element_ID=52047 WHERE UPPER(ColumnName)='UNLOCKINGTIME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:57:59 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='UnlockingTime', Name='Unlocking Time', Description='Time at which the terminal should be unlocked', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52047 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:57:59 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='UnlockingTime', Name='Unlocking Time', Description='Time at which the terminal should be unlocked', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52047 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:57:59 p. m. GMT+02:00
UPDATE AD_Field SET Name='Unlocking Time', Description='Time at which the terminal should be unlocked', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52047) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:57:59 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Unlocking Time', Name='Unlocking Time' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52047)
;

-- 3/05/2022, 5:58:31 p. m. GMT+02:00
UPDATE AD_Element SET Name='Updated Date', PrintName='Updated Date',Updated=TO_TIMESTAMP('2022-05-03 17:58:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50004
;

-- 3/05/2022, 5:58:31 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='UpdatedDate', Name='Updated Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50004
;

-- 3/05/2022, 5:58:31 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='UpdatedDate', Name='Updated Date', Description=NULL, Help=NULL, AD_Element_ID=50004 WHERE UPPER(ColumnName)='UPDATEDDATE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 5:58:31 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='UpdatedDate', Name='Updated Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50004 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:58:31 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='UpdatedDate', Name='Updated Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50004 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:58:31 p. m. GMT+02:00
UPDATE AD_Field SET Name='Updated Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=50004) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 5:58:31 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Updated Date', Name='Updated Date' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=50004)
;

-- 3/05/2022, 6:00:07 p. m. GMT+02:00
UPDATE AD_Element SET Name='Use Date', PrintName='Use Date',Updated=TO_TIMESTAMP('2022-05-03 18:00:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53643
;

-- 3/05/2022, 6:00:07 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='UseDate', Name='Use Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53643
;

-- 3/05/2022, 6:00:07 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='UseDate', Name='Use Date', Description=NULL, Help=NULL, AD_Element_ID=53643 WHERE UPPER(ColumnName)='USEDATE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 6:00:07 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='UseDate', Name='Use Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53643 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:00:07 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='UseDate', Name='Use Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53643 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:00:07 p. m. GMT+02:00
UPDATE AD_Field SET Name='Use Date', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53643) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:00:07 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Use Date', Name='Use Date' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53643)
;

-- 3/05/2022, 6:00:34 p. m. GMT+02:00
UPDATE AD_Element SET Name='User Discount', PrintName='User Discount',Updated=TO_TIMESTAMP('2022-05-03 18:00:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52024
;

-- 3/05/2022, 6:00:34 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='UserDiscount', Name='User Discount', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52024
;

-- 3/05/2022, 6:00:34 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='UserDiscount', Name='User Discount', Description=NULL, Help=NULL, AD_Element_ID=52024 WHERE UPPER(ColumnName)='USERDISCOUNT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 6:00:34 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='UserDiscount', Name='User Discount', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52024 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:00:34 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='UserDiscount', Name='User Discount', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=52024 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:00:34 p. m. GMT+02:00
UPDATE AD_Field SET Name='User Discount', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=52024) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:00:34 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='User Discount', Name='User Discount' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=52024)
;

-- 3/05/2022, 6:01:04 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Validate workflow',Updated=TO_TIMESTAMP('2022-05-03 18:01:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2463
;

-- 3/05/2022, 6:01:04 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Validate workflow', Name='Validate Workflow' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2463)
;

-- 3/05/2022, 6:01:28 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Web Param1',Updated=TO_TIMESTAMP('2022-05-03 18:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1989
;

-- 3/05/2022, 6:01:28 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Web Param1', Name='Web Parameter 1' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1989)
;

-- 3/05/2022, 6:01:50 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Web Param2',Updated=TO_TIMESTAMP('2022-05-03 18:01:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1990
;

-- 3/05/2022, 6:01:50 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Web Param2', Name='Web Parameter 2' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1990)
;

-- 3/05/2022, 6:02:13 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Web Param3',Updated=TO_TIMESTAMP('2022-05-03 18:02:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1991
;

-- 3/05/2022, 6:02:13 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Web Param3', Name='Web Parameter 3' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1991)
;

-- 3/05/2022, 6:02:41 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Web Param 4',Updated=TO_TIMESTAMP('2022-05-03 18:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1992
;

-- 3/05/2022, 6:02:41 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Web Param 4', Name='Web Parameter 4' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1992)
;

-- 3/05/2022, 6:03:21 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Web Param 6',Updated=TO_TIMESTAMP('2022-05-03 18:03:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2176
;

-- 3/05/2022, 6:03:21 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Web Param 6', Name='Web Parameter 6' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2176)
;

-- 3/05/2022, 6:03:56 p. m. GMT+02:00
UPDATE AD_Element SET Name='Window Type', PrintName='Window Type',Updated=TO_TIMESTAMP('2022-05-03 18:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=631
;

-- 3/05/2022, 6:03:56 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='WindowType', Name='Window Type', Description='Type or classification of a Window', Help='The Window Type indicates the type of window being defined (Maintain, Transaction or Query)', Placeholder=NULL WHERE AD_Element_ID=631
;

-- 3/05/2022, 6:03:57 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='WindowType', Name='Window Type', Description='Type or classification of a Window', Help='The Window Type indicates the type of window being defined (Maintain, Transaction or Query)', AD_Element_ID=631 WHERE UPPER(ColumnName)='WINDOWTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 6:03:57 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='WindowType', Name='Window Type', Description='Type or classification of a Window', Help='The Window Type indicates the type of window being defined (Maintain, Transaction or Query)', Placeholder=NULL WHERE AD_Element_ID=631 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:03:57 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='WindowType', Name='Window Type', Description='Type or classification of a Window', Help='The Window Type indicates the type of window being defined (Maintain, Transaction or Query)', Placeholder=NULL WHERE AD_Element_ID=631 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:03:57 p. m. GMT+02:00
UPDATE AD_Field SET Name='Window Type', Description='Type or classification of a Window', Help='The Window Type indicates the type of window being defined (Maintain, Transaction or Query)', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=631) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:03:57 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Window Type', Name='Window Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=631)
;

-- 3/05/2022, 6:04:29 p. m. GMT+02:00
UPDATE AD_Element SET Name='Workflow Processor Log',Updated=TO_TIMESTAMP('2022-05-03 18:04:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2359
;

-- 3/05/2022, 6:04:29 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='AD_WorkflowProcessorLog_ID', Name='Workflow Processor Log', Description='Result of the execution of the Workflow Processor', Help='Result of the execution of the Workflow Processor', Placeholder=NULL WHERE AD_Element_ID=2359
;

-- 3/05/2022, 6:04:29 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AD_WorkflowProcessorLog_ID', Name='Workflow Processor Log', Description='Result of the execution of the Workflow Processor', Help='Result of the execution of the Workflow Processor', AD_Element_ID=2359 WHERE UPPER(ColumnName)='AD_WORKFLOWPROCESSORLOG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 6:04:29 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='AD_WorkflowProcessorLog_ID', Name='Workflow Processor Log', Description='Result of the execution of the Workflow Processor', Help='Result of the execution of the Workflow Processor', Placeholder=NULL WHERE AD_Element_ID=2359 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:04:29 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='AD_WorkflowProcessorLog_ID', Name='Workflow Processor Log', Description='Result of the execution of the Workflow Processor', Help='Result of the execution of the Workflow Processor', Placeholder=NULL WHERE AD_Element_ID=2359 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:04:29 p. m. GMT+02:00
UPDATE AD_Field SET Name='Workflow Processor Log', Description='Result of the execution of the Workflow Processor', Help='Result of the execution of the Workflow Processor', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2359) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:04:29 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Workflow Processor Log', Name='Workflow Processor Log' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2359)
;

-- 3/05/2022, 6:04:55 p. m. GMT+02:00
UPDATE AD_Element SET Name='Year Month', PrintName='Year Month',Updated=TO_TIMESTAMP('2022-05-03 18:04:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200062
;

-- 3/05/2022, 6:04:55 p. m. GMT+02:00
UPDATE AD_Column SET ColumnName='CalendarYearMonth', Name='Year Month', Description='YYYYMM', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200062
;

-- 3/05/2022, 6:04:55 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CalendarYearMonth', Name='Year Month', Description='YYYYMM', Help=NULL, AD_Element_ID=200062 WHERE UPPER(ColumnName)='CALENDARYEARMONTH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 3/05/2022, 6:04:55 p. m. GMT+02:00
UPDATE AD_Process_Para SET ColumnName='CalendarYearMonth', Name='Year Month', Description='YYYYMM', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200062 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:04:55 p. m. GMT+02:00
UPDATE AD_InfoColumn SET ColumnName='CalendarYearMonth', Name='Year Month', Description='YYYYMM', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200062 AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:04:55 p. m. GMT+02:00
UPDATE AD_Field SET Name='Year Month', Description='YYYYMM', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200062) AND IsCentrallyMaintained='Y'
;

-- 3/05/2022, 6:04:55 p. m. GMT+02:00
UPDATE AD_PrintFormatItem SET PrintName='Year Month', Name='Year Month' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200062)
;

