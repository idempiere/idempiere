-- Dic 18, 2021, 10:00:00 AM ART
CREATE INDEX pp_product_bom_product_id_idx ON pp_product_bom (m_product_id ASC NULLS LAST)
;

-- Dic 18, 2021, 10:00:00 AM ART
CREATE INDEX pp_product_bomline_pp_product_bom_id_idx ON pp_product_bomline (pp_product_bom_id ASC NULLS LAST)
;

SELECT register_migration_script('202112181000_IDEMPIERE-5110.sql') FROM dual
;
