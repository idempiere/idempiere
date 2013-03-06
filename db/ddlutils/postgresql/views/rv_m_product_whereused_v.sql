CREATE OR REPLACE VIEW RV_M_Product_WhereUsed_V AS 
 SELECT bom.ad_client_id, bom.ad_org_id, p2.m_product_id, p2.name AS selectedproductname, 
 p2.value AS selectedproductvalue, p2.description AS selectedproductdescription, b.pp_product_bom_id, 
 p.value, p.name, p.description, b.qtybom, b.line
   FROM m_product p2
   LEFT JOIN pp_product_bomline b ON p2.m_product_id = b.m_product_id
   LEFT JOIN pp_product_bom bom ON b.pp_product_bom_id = bom.pp_product_bom_id
   LEFT JOIN m_product p ON bom.m_product_id = p.m_product_id
  WHERE p.isactive = 'Y' AND b.isactive = 'Y' AND p2.isactive = 'Y'
;
