SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2540: Allowing Vendor qty break to specify breaks for all customers
-- Mar 25, 2015 12:46:56 PM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2015-03-25 12:46:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56928
;

-- Mar 25, 2015 12:46:59 PM IST
ALTER TABLE M_ProductPriceVendorBreak MODIFY C_BPartner_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 25, 2015 12:47:00 PM IST
ALTER TABLE M_ProductPriceVendorBreak MODIFY C_BPartner_ID NULL
;

-- Mar 25, 2015 12:47:00 PM IST
ALTER TABLE M_ProductPriceVendorBreak DROP CONSTRAINT cbpartner_mproductpricevendorb
;

-- Mar 25, 2015 12:47:00 PM IST
ALTER TABLE M_ProductPriceVendorBreak ADD CONSTRAINT cbpartner_mproductpricevendorb FOREIGN KEY (C_BPartner_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201503251255_IDEMPIERE-2540.sql') FROM dual
;


