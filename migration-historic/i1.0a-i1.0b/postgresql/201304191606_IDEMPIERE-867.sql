-- Apr 19, 2013 3:45:19 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_Element SET ColumnName='CountryOfManufacture_ID',Updated=TO_TIMESTAMP('2013-04-19 15:45:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200319
;

-- Apr 19, 2013 3:45:19 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_Column SET ColumnName='CountryOfManufacture_ID', Name='Country Of Manufacture', Description=NULL, Help=NULL WHERE AD_Element_ID=200319
;

-- Apr 19, 2013 3:45:19 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_Process_Para SET ColumnName='CountryOfManufacture_ID', Name='Country Of Manufacture', Description=NULL, Help=NULL, AD_Element_ID=200319 WHERE UPPER(ColumnName)='COUNTRYOFMANUFACTURE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 19, 2013 3:45:19 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_Process_Para SET ColumnName='CountryOfManufacture_ID', Name='Country Of Manufacture', Description=NULL, Help=NULL WHERE AD_Element_ID=200319 AND IsCentrallyMaintained='Y'
;

-- Apr 19, 2013 3:45:19 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_InfoColumn SET ColumnName='CountryOfManufacture_ID', Name='Country Of Manufacture', Description=NULL, Help=NULL WHERE AD_Element_ID=200319 AND IsCentrallyMaintained='Y'
;

-- Apr 19, 2013 3:07:20 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
ALTER TABLE M_CommodityShipment ADD COLUMN CountryOfManufacture_ID NUMERIC(10) DEFAULT NULL 
;

UPDATE M_CommodityShipment SET CountryOfManufacture_ID = CAST(CountryOfManufacture AS NUMERIC);

ALTER TABLE M_CommodityShipment DROP COLUMN CountryOfManufacture;

-- Apr 19, 2013 3:38:59 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-04-19 15:38:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=201234
;

-- Apr 19, 2013 3:39:02 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
INSERT INTO t_alter_column values('m_commodityshipment','CountryOfManufacture_ID','NUMERIC(10)',null,null)
;

-- Apr 19, 2013 3:39:02 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
INSERT INTO t_alter_column values('m_commodityshipment','CountryOfManufacture_ID',null,'NOT NULL',null)
;

-- Apr 19, 2013 3:40:18 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_Element SET ColumnName='HoldAddress_ID',Updated=TO_TIMESTAMP('2013-04-19 15:40:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200273
;

-- Apr 19, 2013 3:40:18 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_Column SET ColumnName='HoldAddress_ID', Name='Hold Address', Description=NULL, Help=NULL WHERE AD_Element_ID=200273
;

-- Apr 19, 2013 3:40:18 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_Process_Para SET ColumnName='HoldAddress_ID', Name='Hold Address', Description=NULL, Help=NULL, AD_Element_ID=200273 WHERE UPPER(ColumnName)='HOLDADDRESS_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 19, 2013 3:40:18 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_Process_Para SET ColumnName='HoldAddress_ID', Name='Hold Address', Description=NULL, Help=NULL WHERE AD_Element_ID=200273 AND IsCentrallyMaintained='Y'
;

-- Apr 19, 2013 3:40:18 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
UPDATE AD_InfoColumn SET ColumnName='HoldAddress_ID', Name='Hold Address', Description=NULL, Help=NULL WHERE AD_Element_ID=200273 AND IsCentrallyMaintained='Y'
;

-- Apr 19, 2013 3:49:32 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
ALTER TABLE M_Package ADD COLUMN HoldAddress_ID NUMERIC(10) DEFAULT NULL 
;

UPDATE M_Package SET HoldAddress_ID = CAST(HoldAddress AS NUMERIC);

ALTER TABLE M_Package DROP COLUMN HoldAddress;

-- Apr 19, 2013 3:50:03 PM SGT
-- IDEMPIERE-867 Wrong shipping columns naming
ALTER TABLE M_ShippingTransaction ADD COLUMN HoldAddress_ID NUMERIC(10) DEFAULT NULL 
;

UPDATE M_ShippingTransaction SET HoldAddress_ID = CAST(HoldAddress AS NUMERIC);

ALTER TABLE M_ShippingTransaction DROP COLUMN HoldAddress;

SELECT register_migration_script('201304191606_IDEMPIERE-867.sql') FROM dual
;