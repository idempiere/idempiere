-- IDEMPIERE-6650 Performance - Implement support for using the uuid postgres datatype (FHCA-7074)
-- drop views that don't allow the UUIDs to be converted - they'll be recreated in the post script
SELECT register_migration_script('202510101901_IDEMPIERE-6650-uuid-pre.sql') FROM dual;

DROP VIEW rv_unprocessed;

DROP VIEW rv_unposted;

DROP VIEW m_product_stock_v;

DROP VIEW m_product_substituterelated_v;

DROP VIEW rv_pp_order_receipt_issue;

DROP VIEW rv_pp_order_storage;

DROP VIEW rv_storage_per_product;

DROP VIEW rv_storage;

DROP VIEW m_storage;

