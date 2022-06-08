-- shipment (on availability) should be created only if products are available
-- Jun 08, 2022, 10:38:20 AM CEST
CREATE INDEX m_inout_docstatus ON m_inout(docstatus, issotrx, m_warehouse_id);

SELECT register_migration_script('202206081040_IDEMPIERE-4269.sql') FROM dual;