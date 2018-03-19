--IDEMPIERE-1459 - Improving performance on InfoWindows
CREATE OR REPLACE VIEW M_PRODUCT_STOCK_V
AS
SELECT 
ms.IsActive, ms.Created, ms.CreatedBy, ms.Updated, ms.UpdatedBy,
mp.VALUE, mp.help, (ms.qtyonhand - ms.qtyreserved) AS qtyavailable, ms.qtyonhand, 
ms.qtyreserved, mp.description, mw.NAME AS warehouse, mw.m_warehouse_id, mw.ad_client_id, 
mw.ad_org_id, mp.documentnote, mp.m_product_id
FROM M_STORAGE ms 
JOIN M_PRODUCT mp ON ms.m_product_id = mp.m_product_id
JOIN M_LOCATOR ml ON ms.m_locator_id = ml.m_locator_id
JOIN M_WAREHOUSE mw ON ml.m_warehouse_id = mw.m_warehouse_id 
ORDER BY mw.NAME;

--IDEMPIERE-1459 - Improving performance on InfoWindows
CREATE OR REPLACE VIEW m_storage
AS
  SELECT s.m_product_id,
         s.m_locator_id,
         s.ad_client_id,
         s.ad_org_id,
         s.isactive,
         s.created,
         s.createdby,
         s.updated,
         s.updatedby,
         s.qtyonhand,
         0 AS qtyreserved,
         0 AS qtyordered,
         s.datelastinventory,
         s.m_attributesetinstance_id,
         s.m_storageonhand_uu AS m_storage_uu
  FROM   m_storageonhand s
  UNION ALL
  SELECT sr.m_product_id,
         w.m_reservelocator_id AS m_locator_id,
         sr.ad_client_id,
         sr.ad_org_id,
         sr.isactive,
         sr.created,
         sr.createdby,
         sr.updated,
         sr.updatedby,
         0                     AS qtyonhand,
         sr.qty                AS qtyreserved,
         0                     AS qtyordered,
         sr.datelastinventory,
         sr.m_attributesetinstance_id,
         sr.m_storagereservation_uu AS m_storage_uu
  FROM   m_storagereservation sr
         JOIN m_warehouse w
           ON sr.m_warehouse_id = w.m_warehouse_id
  WHERE  sr.issotrx = 'Y'
  UNION ALL
  SELECT so.m_product_id,
         w.m_reservelocator_id AS m_locator_id,
         so.ad_client_id,
         so.ad_org_id,
         so.isactive,
         so.created,
         so.createdby,
         so.updated,
         so.updatedby,
         0                     AS qtyonhand,
         0                     AS qtyreserved,
         so.qty                AS qtyordered,
         so.datelastinventory,
         so.m_attributesetinstance_id,
         so.m_storagereservation_uu AS m_storage_uu
  FROM   m_storagereservation so
         JOIN m_warehouse w
           ON so.m_warehouse_id = w.m_warehouse_id
  WHERE  so.issotrx = 'N'
;


SELECT register_migration_script('201310231101_IDEMPIERE-1459.sql') FROM dual
;
