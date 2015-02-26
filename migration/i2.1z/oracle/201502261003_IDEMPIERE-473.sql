SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-473 Consistent ShelfHeight in m_product and i_product
-- Feb 26, 2015 10:02:41 AM COT
UPDATE AD_Column SET AD_Reference_ID=12,Updated=TO_DATE('2015-02-26 10:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7848
;

-- Feb 26, 2015 10:02:43 AM COT
ALTER TABLE I_Product MODIFY ShelfHeight NUMBER DEFAULT NULL 
;

SELECT register_migration_script('201502261003_IDEMPIERE-473.sql') FROM dual
;

