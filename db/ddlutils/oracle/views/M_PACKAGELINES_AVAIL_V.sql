CREATE OR REPLACE VIEW m_packagelines_avail_v AS 
         SELECT DISTINCT iol.ad_client_id, iol.ad_org_id, iol.m_inout_id, iol.m_inoutline_id, iol.line, iol.qtyentered - COALESCE(( SELECT sum(m_packageline.qty) AS sum
                   FROM m_packageline
                  WHERE m_packageline.m_inoutline_id = iol.m_inoutline_id), 0 ) AS qty, iol.m_product_id, p.name AS productname, uom.name AS uom
           FROM m_inoutline iol
      LEFT JOIN m_packageline mpl ON iol.m_inoutline_id = mpl.m_inoutline_id
   JOIN m_product p ON iol.m_product_id = p.m_product_id
   JOIN c_uom uom ON iol.c_uom_id = uom.c_uom_id
   JOIN ad_clientinfo ci ON ci.ad_client_id = iol.ad_client_id
  WHERE p.ispicklistprintdetails = 'N'  AND iol.m_product_id <> COALESCE(ci.m_productfreight_id, 0 ) AND (iol.qtyentered - COALESCE(( SELECT sum(m_packageline.qty) AS sum
   FROM m_packageline
  WHERE m_packageline.m_inoutline_id = iol.m_inoutline_id), 0 )) <> 0 
UNION 
         SELECT DISTINCT iol.ad_client_id, iol.ad_org_id, iol.m_inout_id, iol.m_inoutline_id, iol.line + pbom.line / 100  AS line, iol.qtyentered * pbom.bomqty - COALESCE(( SELECT sum(m_packageline.qty) AS sum
                   FROM m_packageline
                  WHERE m_packageline.m_product_id = p2.m_product_id AND (m_packageline.m_package_id IN ( SELECT m_package.m_package_id
                           FROM m_package
                          WHERE m_package.m_inout_id = iol.m_inout_id))), 0 ) AS qty, pbom.m_productbom_id AS m_product_id, p2.name AS productname, uom.name AS uom
           FROM m_inoutline iol
      LEFT JOIN m_packageline mpl ON iol.m_inoutline_id = mpl.m_inoutline_id
   JOIN m_product p ON iol.m_product_id = p.m_product_id
   JOIN m_product_bom pbom ON p.m_product_id = pbom.m_product_id
   JOIN m_product p2 ON pbom.m_productbom_id = p2.m_product_id
   JOIN c_uom uom ON iol.c_uom_id = uom.c_uom_id
  WHERE p.isbom = 'Y'  AND p.isverified = 'Y'  AND p.ispicklistprintdetails = 'Y'  AND (iol.qtyentered * pbom.bomqty - COALESCE(( SELECT sum(m_packageline.qty) AS sum
   FROM m_packageline
  WHERE m_packageline.m_product_id = p2.m_product_id AND (m_packageline.m_package_id IN ( SELECT m_package.m_package_id
           FROM m_package
          WHERE m_package.m_inout_id = iol.m_inout_id))), 0 )) <> 0 
  ORDER BY 1, 2, 3, 5;