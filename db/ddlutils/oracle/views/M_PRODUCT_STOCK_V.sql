CREATE OR REPLACE VIEW m_product_stock_v AS 
 SELECT ms.isactive, ms.created, ms.createdby, ms.updated, ms.updatedby, mp.value, mp.help, ms.qtyonhand - NVL(mr.qty,0) AS qtyavailable, ms.qtyonhand, NVL(mr.qty,0) as qtyreserved, mp.description, mw.name AS warehouse, mw.m_warehouse_id, mw.ad_client_id, mw.ad_org_id, mp.documentnote
   FROM m_storageonhand ms
   JOIN m_product mp ON ms.m_product_id = mp.m_product_id
   JOIN m_locator ml ON ms.m_locator_id = ml.m_locator_id
   JOIN m_warehouse mw ON ml.m_warehouse_id = mw.m_warehouse_id
   LEFT JOIN m_storagereservation mr ON ms.m_product_id = mr.m_product_id AND mw.m_warehouse_id = mr.m_warehouse_id AND mr.isSOTrx='Y'
  ORDER BY mw.name;
