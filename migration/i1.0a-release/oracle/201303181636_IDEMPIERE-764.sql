-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
ALTER TABLE X_Shipper RENAME TO M_ShipperCfg
;

ALTER TABLE X_ShipperPickupTypes RENAME TO M_ShipperPickupTypesCfg
;

ALTER TABLE X_ShipperPackaging RENAME TO M_ShipperPackagingCfg
;

ALTER TABLE X_ShipperLabels RENAME TO M_ShipperLabelsCfg
;

ALTER TABLE X_ShippingProcessor RENAME TO M_ShippingProcessorCfg
;

ALTER TABLE M_Shipper RENAME COLUMN X_Shipper_ID TO M_ShipperCfg_ID
;

ALTER TABLE M_ShipperCfg RENAME COLUMN X_Shipper_ID TO M_ShipperCfg_ID
;

ALTER TABLE M_ShipperCfg RENAME COLUMN X_Shipper_UU TO M_ShipperCfg_UU
;

ALTER TABLE M_ShipperCfg RENAME COLUMN X_ShippingProcessor_ID TO M_ShippingProcessorCfg_ID
;

ALTER TABLE M_ShipperLabels RENAME COLUMN X_ShipperLabels_ID TO M_ShipperLabelsCfg_ID
;

ALTER TABLE M_ShipperLabelsCfg RENAME COLUMN X_Shipper_ID TO M_ShipperCfg_ID
;

ALTER TABLE M_ShipperLabelsCfg RENAME COLUMN X_ShipperLabels_ID TO M_ShipperLabelsCfg_ID
;

ALTER TABLE M_ShipperLabelsCfg RENAME COLUMN X_ShipperLabels_UU TO M_ShipperLabelsCfg_UU
;

ALTER TABLE M_ShipperPackaging RENAME COLUMN X_ShipperPackaging_ID TO M_ShipperPackagingCfg_ID
;

ALTER TABLE M_ShipperPackagingCfg RENAME COLUMN X_Shipper_ID TO M_ShipperCfg_ID
;

ALTER TABLE M_ShipperPackagingCfg RENAME COLUMN X_ShipperPackaging_ID TO M_ShipperPackagingCfg_ID
;

ALTER TABLE M_ShipperPackagingCfg RENAME COLUMN X_ShipperPackaging_UU TO M_ShipperPackagingCfg_UU
;

ALTER TABLE M_ShipperPickupTypes RENAME COLUMN X_ShipperPickupTypes_ID TO M_ShipperPickupTypesCfg_ID
;

ALTER TABLE M_ShipperPickupTypesCfg RENAME COLUMN X_Shipper_ID TO M_ShipperCfg_ID
;

ALTER TABLE M_ShipperPickupTypesCfg RENAME COLUMN X_ShipperPickupTypes_ID TO M_ShipperPickupTypesCfg_ID
;

ALTER TABLE M_ShipperPickupTypesCfg RENAME COLUMN X_ShipperPickupTypes_UU TO M_ShipperPickupTypesCfg_UU
;

ALTER TABLE M_ShippingProcessor RENAME COLUMN X_ShippingProcessor_ID TO M_ShippingProcessorCfg_ID
;

ALTER TABLE M_ShippingProcessorCfg RENAME COLUMN X_ShippingProcessor_ID TO M_ShippingProcessorCfg_ID
;

ALTER TABLE M_ShippingProcessorCfg RENAME COLUMN X_ShippingProcessor_UU TO M_ShippingProcessorCfg_UU
;

-- Mar 18, 2013 4:23:18 PM COT
UPDATE AD_Field SET DisplayLogic='@M_ShipperCfg_ID@>0',Updated=TO_DATE('2013-03-18 16:23:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201502
;

-- Mar 18, 2013 4:25:00 PM COT
UPDATE AD_Sequence SET Description='Table M_ShipperCfg', Name='M_ShipperCfg',Updated=TO_DATE('2013-03-18 16:25:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200043
;

-- Mar 18, 2013 4:25:10 PM COT
UPDATE AD_Sequence SET Description='Table M_ShipperLabelsCfg', Name='M_ShipperLabelsCfg',Updated=TO_DATE('2013-03-18 16:25:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200044
;

-- Mar 18, 2013 4:25:22 PM COT
UPDATE AD_Sequence SET Description='Table M_ShipperPackagingCfg', Name='M_ShipperPackagingCfg',Updated=TO_DATE('2013-03-18 16:25:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200045
;

-- Mar 18, 2013 4:25:32 PM COT
UPDATE AD_Sequence SET Description='Table M_ShipperPickupTypesCfg', Name='M_ShipperPickupTypesCfg',Updated=TO_DATE('2013-03-18 16:25:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200046
;

-- Mar 18, 2013 4:25:42 PM COT
UPDATE AD_Sequence SET Description='Table M_ShippingProcessorCfg', Name='M_ShippingProcessorCfg',Updated=TO_DATE('2013-03-18 16:25:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200042
;

-- Mar 18, 2013 4:27:57 PM COT
UPDATE AD_Table SET TableName='M_ShipperCfg',Updated=TO_DATE('2013-03-18 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200047
;

-- Mar 18, 2013 4:28:05 PM COT
UPDATE AD_Table SET TableName='M_ShipperLabelsCfg',Updated=TO_DATE('2013-03-18 16:28:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200048
;

-- Mar 18, 2013 4:28:12 PM COT
UPDATE AD_Table SET TableName='M_ShipperPackagingCfg',Updated=TO_DATE('2013-03-18 16:28:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200049
;

-- Mar 18, 2013 4:28:19 PM COT
UPDATE AD_Table SET TableName='M_ShipperPickupTypesCfg',Updated=TO_DATE('2013-03-18 16:28:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200050
;

-- Mar 18, 2013 4:28:27 PM COT
UPDATE AD_Table SET TableName='M_ShippingProcessorCfg',Updated=TO_DATE('2013-03-18 16:28:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200046
;

-- Mar 18, 2013 4:30:20 PM COT
UPDATE AD_Element SET ColumnName='M_ShipperCfg_ID',Updated=TO_DATE('2013-03-18 16:30:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200601
;

-- Mar 18, 2013 4:30:20 PM COT
UPDATE AD_Column SET ColumnName='M_ShipperCfg_ID', Name='Shipper Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200601
;

-- Mar 18, 2013 4:30:20 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperCfg_ID', Name='Shipper Configuration', Description=NULL, Help=NULL, AD_Element_ID=200601 WHERE UPPER(ColumnName)='M_SHIPPERCFG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 4:30:20 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperCfg_ID', Name='Shipper Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200601 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:30:20 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_ShipperCfg_ID', Name='Shipper Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200601 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:31:43 PM COT
UPDATE AD_Element SET ColumnName='M_ShipperLabelsCfg_ID',Updated=TO_DATE('2013-03-18 16:31:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200603
;

-- Mar 18, 2013 4:31:43 PM COT
UPDATE AD_Column SET ColumnName='M_ShipperLabelsCfg_ID', Name='Shipper Labels Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200603
;

-- Mar 18, 2013 4:31:43 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperLabelsCfg_ID', Name='Shipper Labels Configuration', Description=NULL, Help=NULL, AD_Element_ID=200603 WHERE UPPER(ColumnName)='M_SHIPPERLABELSCFG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 4:31:43 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperLabelsCfg_ID', Name='Shipper Labels Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200603 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:31:43 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_ShipperLabelsCfg_ID', Name='Shipper Labels Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200603 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:31:57 PM COT
UPDATE AD_Element SET ColumnName='M_ShipperLabelsCfg_UU', Name='M_ShipperLabelsCfg_UU', PrintName='M_ShipperLabelsCfg_UU',Updated=TO_DATE('2013-03-18 16:31:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200604
;

-- Mar 18, 2013 4:31:57 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200604
;

-- Mar 18, 2013 4:31:57 PM COT
UPDATE AD_Column SET ColumnName='M_ShipperLabelsCfg_UU', Name='M_ShipperLabelsCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200604
;

-- Mar 18, 2013 4:31:57 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperLabelsCfg_UU', Name='M_ShipperLabelsCfg_UU', Description=NULL, Help=NULL, AD_Element_ID=200604 WHERE UPPER(ColumnName)='M_SHIPPERLABELSCFG_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 4:31:57 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperLabelsCfg_UU', Name='M_ShipperLabelsCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200604 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:31:57 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_ShipperLabelsCfg_UU', Name='M_ShipperLabelsCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200604 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:31:57 PM COT
UPDATE AD_Field SET Name='M_ShipperLabelsCfg_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200604) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:31:57 PM COT
UPDATE AD_PrintFormatItem SET PrintName='M_ShipperLabelsCfg_UU', Name='M_ShipperLabelsCfg_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200604)
;

-- Mar 18, 2013 4:32:09 PM COT
UPDATE AD_Element SET ColumnName='M_ShipperPackagingCfg_ID',Updated=TO_DATE('2013-03-18 16:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200605
;

-- Mar 18, 2013 4:32:09 PM COT
UPDATE AD_Column SET ColumnName='M_ShipperPackagingCfg_ID', Name='Shipper Packaging Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200605
;

-- Mar 18, 2013 4:32:09 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperPackagingCfg_ID', Name='Shipper Packaging Configuration', Description=NULL, Help=NULL, AD_Element_ID=200605 WHERE UPPER(ColumnName)='M_SHIPPERPACKAGINGCFG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 4:32:09 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperPackagingCfg_ID', Name='Shipper Packaging Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200605 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:32:09 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_ShipperPackagingCfg_ID', Name='Shipper Packaging Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200605 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:32:22 PM COT
UPDATE AD_Element SET ColumnName='M_ShipperPackagingCfg_UU', Name='M_ShipperPackagingCfg_UU', PrintName='M_ShipperPackagingCfg_UU',Updated=TO_DATE('2013-03-18 16:32:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200606
;

-- Mar 18, 2013 4:32:22 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200606
;

-- Mar 18, 2013 4:32:22 PM COT
UPDATE AD_Column SET ColumnName='M_ShipperPackagingCfg_UU', Name='M_ShipperPackagingCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200606
;

-- Mar 18, 2013 4:32:22 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperPackagingCfg_UU', Name='M_ShipperPackagingCfg_UU', Description=NULL, Help=NULL, AD_Element_ID=200606 WHERE UPPER(ColumnName)='M_SHIPPERPACKAGINGCFG_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 4:32:22 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperPackagingCfg_UU', Name='M_ShipperPackagingCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200606 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:32:22 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_ShipperPackagingCfg_UU', Name='M_ShipperPackagingCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200606 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:32:22 PM COT
UPDATE AD_Field SET Name='M_ShipperPackagingCfg_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200606) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:32:22 PM COT
UPDATE AD_PrintFormatItem SET PrintName='M_ShipperPackagingCfg_UU', Name='M_ShipperPackagingCfg_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200606)
;

-- Mar 18, 2013 4:32:35 PM COT
UPDATE AD_Element SET ColumnName='M_ShipperPickupTypesCfg_ID',Updated=TO_DATE('2013-03-18 16:32:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200607
;

-- Mar 18, 2013 4:32:35 PM COT
UPDATE AD_Column SET ColumnName='M_ShipperPickupTypesCfg_ID', Name='Shipper Pickup Types Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200607
;

-- Mar 18, 2013 4:32:35 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperPickupTypesCfg_ID', Name='Shipper Pickup Types Configuration', Description=NULL, Help=NULL, AD_Element_ID=200607 WHERE UPPER(ColumnName)='M_SHIPPERPICKUPTYPESCFG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 4:32:35 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperPickupTypesCfg_ID', Name='Shipper Pickup Types Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200607 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:32:35 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_ShipperPickupTypesCfg_ID', Name='Shipper Pickup Types Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200607 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:32:49 PM COT
UPDATE AD_Element SET ColumnName='M_ShipperPickupTypesCfg_UU', Name='M_ShipperPickupTypesCfg_UU', PrintName='M_ShipperPickupTypesCfg_UU',Updated=TO_DATE('2013-03-18 16:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200608
;

-- Mar 18, 2013 4:32:49 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200608
;

-- Mar 18, 2013 4:32:49 PM COT
UPDATE AD_Column SET ColumnName='M_ShipperPickupTypesCfg_UU', Name='M_ShipperPickupTypesCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200608
;

-- Mar 18, 2013 4:32:49 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperPickupTypesCfg_UU', Name='M_ShipperPickupTypesCfg_UU', Description=NULL, Help=NULL, AD_Element_ID=200608 WHERE UPPER(ColumnName)='M_SHIPPERPICKUPTYPESCFG_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 4:32:49 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperPickupTypesCfg_UU', Name='M_ShipperPickupTypesCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200608 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:32:49 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_ShipperPickupTypesCfg_UU', Name='M_ShipperPickupTypesCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200608 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:32:49 PM COT
UPDATE AD_Field SET Name='M_ShipperPickupTypesCfg_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200608) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:32:49 PM COT
UPDATE AD_PrintFormatItem SET PrintName='M_ShipperPickupTypesCfg_UU', Name='M_ShipperPickupTypesCfg_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200608)
;

-- Mar 18, 2013 4:33:03 PM COT
UPDATE AD_Element SET ColumnName='M_ShipperCfg_UU', Name='M_ShipperCfg_UU', PrintName='M_ShipperCfg_UU',Updated=TO_DATE('2013-03-18 16:33:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200602
;

-- Mar 18, 2013 4:33:03 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200602
;

-- Mar 18, 2013 4:33:03 PM COT
UPDATE AD_Column SET ColumnName='M_ShipperCfg_UU', Name='M_ShipperCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200602
;

-- Mar 18, 2013 4:33:03 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperCfg_UU', Name='M_ShipperCfg_UU', Description=NULL, Help=NULL, AD_Element_ID=200602 WHERE UPPER(ColumnName)='M_SHIPPERCFG_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 4:33:03 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShipperCfg_UU', Name='M_ShipperCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200602 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:33:03 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_ShipperCfg_UU', Name='M_ShipperCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200602 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:33:03 PM COT
UPDATE AD_Field SET Name='M_ShipperCfg_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200602) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:33:03 PM COT
UPDATE AD_PrintFormatItem SET PrintName='M_ShipperCfg_UU', Name='M_ShipperCfg_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200602)
;

-- Mar 18, 2013 4:33:14 PM COT
UPDATE AD_Element SET ColumnName='M_ShippingProcessorCfg_ID',Updated=TO_DATE('2013-03-18 16:33:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200599
;

-- Mar 18, 2013 4:33:14 PM COT
UPDATE AD_Column SET ColumnName='M_ShippingProcessorCfg_ID', Name='Shipping Processor Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200599
;

-- Mar 18, 2013 4:33:14 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShippingProcessorCfg_ID', Name='Shipping Processor Configuration', Description=NULL, Help=NULL, AD_Element_ID=200599 WHERE UPPER(ColumnName)='M_SHIPPINGPROCESSORCFG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 4:33:14 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShippingProcessorCfg_ID', Name='Shipping Processor Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200599 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:33:14 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_ShippingProcessorCfg_ID', Name='Shipping Processor Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200599 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:33:27 PM COT
UPDATE AD_Element SET ColumnName='M_ShippingProcessorCfg_UU', Name='M_ShippingProcessorCfg_UU', PrintName='M_ShippingProcessorCfg_UU',Updated=TO_DATE('2013-03-18 16:33:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200600
;

-- Mar 18, 2013 4:33:27 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200600
;

-- Mar 18, 2013 4:33:27 PM COT
UPDATE AD_Column SET ColumnName='M_ShippingProcessorCfg_UU', Name='M_ShippingProcessorCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200600
;

-- Mar 18, 2013 4:33:27 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShippingProcessorCfg_UU', Name='M_ShippingProcessorCfg_UU', Description=NULL, Help=NULL, AD_Element_ID=200600 WHERE UPPER(ColumnName)='M_SHIPPINGPROCESSORCFG_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 4:33:27 PM COT
UPDATE AD_Process_Para SET ColumnName='M_ShippingProcessorCfg_UU', Name='M_ShippingProcessorCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200600 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:33:27 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_ShippingProcessorCfg_UU', Name='M_ShippingProcessorCfg_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200600 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:33:27 PM COT
UPDATE AD_Field SET Name='M_ShippingProcessorCfg_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200600) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 4:33:27 PM COT
UPDATE AD_PrintFormatItem SET PrintName='M_ShippingProcessorCfg_UU', Name='M_ShippingProcessorCfg_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200600)
;

SELECT register_migration_script('201303181636_IDEMPIERE-764.sql') FROM dual
;

