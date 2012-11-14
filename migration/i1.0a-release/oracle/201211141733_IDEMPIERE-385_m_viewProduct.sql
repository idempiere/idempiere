CREATE OR REPLACE VIEW m_product_stock_v AS 
 SELECT ms.isactive, ms.created, ms.createdby, ms.updated, ms.updatedby, mp.value, mp.help, ms.qtyonhand - NVL(mr.qty,0) AS qtyavailable, ms.qtyonhand, NVL(mr.qty,0) as qtyreserved, mp.description, mw.name AS warehouse, mw.m_warehouse_id, mw.ad_client_id, mw.ad_org_id, mp.documentnote
   FROM m_storageonhand ms
   JOIN m_product mp ON ms.m_product_id = mp.m_product_id
   JOIN m_locator ml ON ms.m_locator_id = ml.m_locator_id
   JOIN m_warehouse mw ON ml.m_warehouse_id = mw.m_warehouse_id
   LEFT JOIN m_storagereservation mr ON ms.m_product_id = mr.m_product_id AND mw.m_warehouse_id = mr.m_warehouse_id AND mr.isSOTrx='Y'
  ORDER BY mw.name;

CREATE OR REPLACE VIEW m_product_substituterelated_v AS 
         SELECT s.ad_client_id, s.ad_org_id, s.isactive, s.created, s.createdby, s.updated, s.updatedby, s.m_product_id, s.substitute_id, 'S'::text AS rowtype, mp.name, sum(ms.qtyonhand - NVL(mr.qty,0)) AS qtyavailable, sum(ms.qtyonhand) AS qtyonhand, NVL(sum(mr.qty),0) AS qtyreserved, round(max(mpr.pricestd), 0) AS pricestd, mpr.m_pricelist_version_id, mw.m_warehouse_id, org.name AS orgname
           FROM m_substitute s
      JOIN m_storageonhand ms ON ms.m_product_id = s.substitute_id
   JOIN m_product mp ON ms.m_product_id = mp.m_product_id
   JOIN m_locator ml ON ms.m_locator_id = ml.m_locator_id
   JOIN m_warehouse mw ON ml.m_warehouse_id = mw.m_warehouse_id
   JOIN m_productprice mpr ON ms.m_product_id = mpr.m_product_id
   JOIN ad_org org ON org.ad_org_id = mw.ad_org_id
   LEFT JOIN m_storagereservation mr ON ms.m_product_id = mr.m_product_id AND mw.m_warehouse_id = mr.m_warehouse_id AND mr.isSOTrx='Y'
  GROUP BY s.ad_client_id, s.ad_org_id, s.isactive, s.created, s.createdby, s.updated, s.updatedby, s.m_product_id, s.substitute_id, mw.m_warehouse_id, mpr.m_pricelist_version_id, org.name, mp.name
UNION 
         SELECT r.ad_client_id, r.ad_org_id, r.isactive, r.created, r.createdby, r.updated, r.updatedby, r.m_product_id, r.relatedproduct_id AS substitute_id, 'R'::text AS rowtype, mp.name, sum(ms.qtyonhand - NVL(mr.qty,0)) AS qtyavailable, sum(ms.qtyonhand) AS qtyonhand, NVL(sum(mr.qty),0) AS qtyreserved, round(max(mpr.pricestd), 0) AS pricestd, mpr.m_pricelist_version_id, mw.m_warehouse_id, org.name AS orgname
           FROM m_relatedproduct r
      JOIN m_storageonhand ms ON ms.m_product_id = r.relatedproduct_id
   JOIN m_product mp ON ms.m_product_id = mp.m_product_id
   JOIN m_locator ml ON ms.m_locator_id = ml.m_locator_id
   JOIN m_warehouse mw ON ml.m_warehouse_id = mw.m_warehouse_id
   JOIN m_productprice mpr ON ms.m_product_id = mpr.m_product_id
   JOIN ad_org org ON org.ad_org_id = mw.ad_org_id
   LEFT JOIN m_storagereservation mr ON ms.m_product_id = mr.m_product_id AND mw.m_warehouse_id = mr.m_warehouse_id AND mr.isSOTrx='Y'
  GROUP BY r.ad_client_id, r.ad_org_id, r.isactive, r.created, r.createdby, r.updated, r.updatedby, r.m_product_id, r.relatedproduct_id, mw.m_warehouse_id, mpr.m_pricelist_version_id, org.name, mp.name;
