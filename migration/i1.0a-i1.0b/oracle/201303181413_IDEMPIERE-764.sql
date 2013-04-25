-- IDEMPIERE-764 Some tablenames starts with X whereas they have centralized IDs
ALTER TABLE X_CommodityShipment RENAME TO M_CommodityShipment
;

ALTER TABLE M_CommodityShipment RENAME COLUMN X_CommodityShipment_ID TO M_CommodityShipment_ID
;

ALTER TABLE M_CommodityShipment RENAME COLUMN X_CommodityShipment_UU TO M_CommodityShipment_UU
;

-- Mar 18, 2013 2:10:54 PM COT
UPDATE AD_Table SET TableName='M_CommodityShipment', Name='CommodityShipment',Updated=TO_DATE('2013-03-18 14:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200045
;

-- Mar 18, 2013 2:10:54 PM COT
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=200045
;

-- Mar 18, 2013 2:10:55 PM COT
UPDATE AD_Sequence SET Description='Table M_CommodityShipment', Name='M_CommodityShipment',Updated=TO_DATE('2013-03-18 14:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200041
;

-- Mar 18, 2013 2:11:27 PM COT
UPDATE AD_Element SET ColumnName='M_CommodityShipment_ID', Name='Commodity Shipment', PrintName='Commodity Shipment',Updated=TO_DATE('2013-03-18 14:11:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200317
;

-- Mar 18, 2013 2:11:27 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200317
;

-- Mar 18, 2013 2:11:27 PM COT
UPDATE AD_Column SET ColumnName='M_CommodityShipment_ID', Name='Commodity Shipment', Description=NULL, Help=NULL WHERE AD_Element_ID=200317
;

-- Mar 18, 2013 2:11:27 PM COT
UPDATE AD_Process_Para SET ColumnName='M_CommodityShipment_ID', Name='Commodity Shipment', Description=NULL, Help=NULL, AD_Element_ID=200317 WHERE UPPER(ColumnName)='M_COMMODITYSHIPMENT_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 2:11:27 PM COT
UPDATE AD_Process_Para SET ColumnName='M_CommodityShipment_ID', Name='Commodity Shipment', Description=NULL, Help=NULL WHERE AD_Element_ID=200317 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:11:27 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_CommodityShipment_ID', Name='Commodity Shipment', Description=NULL, Help=NULL WHERE AD_Element_ID=200317 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:11:27 PM COT
UPDATE AD_Field SET Name='Commodity Shipment', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200317) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:11:27 PM COT
UPDATE AD_PrintFormatItem SET PrintName='Commodity Shipment', Name='Commodity Shipment' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200317)
;

-- Mar 18, 2013 2:11:37 PM COT
UPDATE AD_Element SET ColumnName='M_CommodityShipment_UU', Name='M_CommodityShipment_UU', PrintName='M_CommodityShipment_UU',Updated=TO_DATE('2013-03-18 14:11:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200318
;

-- Mar 18, 2013 2:11:37 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200318
;

-- Mar 18, 2013 2:11:37 PM COT
UPDATE AD_Column SET ColumnName='M_CommodityShipment_UU', Name='M_CommodityShipment_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200318
;

-- Mar 18, 2013 2:11:37 PM COT
UPDATE AD_Process_Para SET ColumnName='M_CommodityShipment_UU', Name='M_CommodityShipment_UU', Description=NULL, Help=NULL, AD_Element_ID=200318 WHERE UPPER(ColumnName)='M_COMMODITYSHIPMENT_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 18, 2013 2:11:37 PM COT
UPDATE AD_Process_Para SET ColumnName='M_CommodityShipment_UU', Name='M_CommodityShipment_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200318 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:11:37 PM COT
UPDATE AD_InfoColumn SET ColumnName='M_CommodityShipment_UU', Name='M_CommodityShipment_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200318 AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:11:37 PM COT
UPDATE AD_Field SET Name='M_CommodityShipment_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200318) AND IsCentrallyMaintained='Y'
;

-- Mar 18, 2013 2:11:37 PM COT
UPDATE AD_PrintFormatItem SET PrintName='M_CommodityShipment_UU', Name='M_CommodityShipment_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200318)
;

SELECT register_migration_script('201303181413_IDEMPIERE-764.sql') FROM dual
;

