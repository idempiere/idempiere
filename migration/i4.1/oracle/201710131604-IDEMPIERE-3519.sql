SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3519:column updated, created of c_salesregion_trl isn't yet sync so miss default value
-- Oct 13, 2017 12:41:29 PM ICT
ALTER TABLE C_SalesRegion_Trl MODIFY Created DATE DEFAULT SYSDATE
;

-- Oct 13, 2017 12:41:53 PM ICT
ALTER TABLE C_SalesRegion_Trl MODIFY Updated DATE DEFAULT SYSDATE
;

SELECT register_migration_script('201710131604-IDEMPIERE-3519.sql') FROM dual
;
