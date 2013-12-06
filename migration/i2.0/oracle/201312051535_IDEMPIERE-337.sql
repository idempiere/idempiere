SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-337 zkwebui - Improve Info Product window
UPDATE M_Product_PO po 
SET IsCurrentVendor='N' 
WHERE po.IsActive='Y' 
AND po.IsCurrentVendor='Y' 
AND po.C_BPartner_ID NOT IN (
	SELECT MAX(ppo.C_BPartner_ID) 
	FROM M_Product_PO ppo 
	WHERE ppo.IsActive='Y' 
	AND ppo.IsCurrentVendor='Y' 
	AND ppo.M_Product_ID = po.M_Product_ID
);

SELECT register_migration_script('201312051535_IDEMPIERE-337.sql') FROM dual
;
