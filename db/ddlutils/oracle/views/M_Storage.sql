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
         s.m_storageonhand_uu AS m_storage_uu,
         s.datematerialpolicy AS datematerialpolicy
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
         sr.m_storagereservation_uu AS m_storage_uu,
         null as datematerialpolicy
  FROM   m_storagereservation sr
         JOIN m_warehouse w
           ON sr.m_warehouse_id = w.m_warehouse_id
  WHERE  sr.issotrx = 'Y' and sr.qty <> 0
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
         so.m_storagereservation_uu AS m_storage_uu,
         null as datematerialpolicy
  FROM   m_storagereservation so
         JOIN m_warehouse w
           ON so.m_warehouse_id = w.m_warehouse_id
  WHERE  so.issotrx = 'N' and so.qty <> 0
;
