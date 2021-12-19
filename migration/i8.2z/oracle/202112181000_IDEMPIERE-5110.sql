SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dic 18, 2021, 10:00:00 AM ART
CREATE INDEX pp_product_bom_product_id_idx ON PP_Product_BOM (M_Product_ID)
;

-- Dic 18, 2021, 10:00:00 AM ART
CREATE INDEX pp_product_bomline_pp_product_bom_id_idx ON PP_Product_BOMLine (PP_Product_BOM_ID)
;

SELECT register_migration_script('202112181000_IDEMPIERE-5110.sql') FROM dual
;

