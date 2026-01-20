-- IDEMPIERE-6650 Performance - Implement support for using the uuid postgres datatype (FHCA-7074)
-- recreate the views dropped in the pre-script
SELECT register_migration_script('202510101904_IDEMPIERE-6650-uuid-post.sql') FROM dual;

CREATE VIEW rv_unprocessed AS
 SELECT gl_journal.ad_client_id,
    gl_journal.ad_org_id,
    gl_journal.created,
    gl_journal.createdby,
    gl_journal.updated,
    gl_journal.updatedby,
    gl_journal.isactive,
    gl_journal.documentno,
    gl_journal.datedoc,
    gl_journal.dateacct,
    224 AS ad_table_id,
    gl_journal.gl_journal_id AS record_id,
    'N'::bpchar AS issotrx,
    gl_journal.posted,
    gl_journal.processing,
    gl_journal.processed,
    gl_journal.docstatus,
    gl_journal.gl_journal_uu AS rv_unprocessed_uu
   FROM gl_journal
  WHERE (gl_journal.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]))
UNION
 SELECT c_invoice.ad_client_id,
    c_invoice.ad_org_id,
    c_invoice.created,
    c_invoice.createdby,
    c_invoice.updated,
    c_invoice.updatedby,
    c_invoice.isactive,
    c_invoice.documentno,
    c_invoice.dateinvoiced AS datedoc,
    c_invoice.dateacct,
    318 AS ad_table_id,
    c_invoice.c_invoice_id AS record_id,
    c_invoice.issotrx,
    c_invoice.posted,
    c_invoice.processing,
    c_invoice.processed,
    c_invoice.docstatus,
    c_invoice.c_invoice_uu AS rv_unprocessed_uu
   FROM c_invoice
  WHERE (c_invoice.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]))
UNION
 SELECT m_inout.ad_client_id,
    m_inout.ad_org_id,
    m_inout.created,
    m_inout.createdby,
    m_inout.updated,
    m_inout.updatedby,
    m_inout.isactive,
    m_inout.documentno,
    m_inout.movementdate AS datedoc,
    m_inout.dateacct,
    319 AS ad_table_id,
    m_inout.m_inout_id AS record_id,
    m_inout.issotrx,
    m_inout.posted,
    m_inout.processing,
    m_inout.processed,
    m_inout.docstatus,
    m_inout.m_inout_uu AS rv_unprocessed_uu
   FROM m_inout
  WHERE (m_inout.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]))
UNION
 SELECT m_inventory.ad_client_id,
    m_inventory.ad_org_id,
    m_inventory.created,
    m_inventory.createdby,
    m_inventory.updated,
    m_inventory.updatedby,
    m_inventory.isactive,
    m_inventory.documentno,
    m_inventory.movementdate AS datedoc,
    m_inventory.movementdate AS dateacct,
    321 AS ad_table_id,
    m_inventory.m_inventory_id AS record_id,
    'N'::bpchar AS issotrx,
    m_inventory.posted,
    m_inventory.processing,
    m_inventory.processed,
    m_inventory.docstatus,
    m_inventory.m_inventory_uu AS rv_unprocessed_uu
   FROM m_inventory
  WHERE (m_inventory.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]))
UNION
 SELECT m_movement.ad_client_id,
    m_movement.ad_org_id,
    m_movement.created,
    m_movement.createdby,
    m_movement.updated,
    m_movement.updatedby,
    m_movement.isactive,
    m_movement.documentno,
    m_movement.movementdate AS datedoc,
    m_movement.movementdate AS dateacct,
    323 AS ad_table_id,
    m_movement.m_movement_id AS record_id,
    'N'::bpchar AS issotrx,
    m_movement.posted,
    m_movement.processing,
    m_movement.processed,
    m_movement.docstatus,
    m_movement.m_movement_uu AS rv_unprocessed_uu
   FROM m_movement
  WHERE (m_movement.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]))
UNION
 SELECT c_cash.ad_client_id,
    c_cash.ad_org_id,
    c_cash.created,
    c_cash.createdby,
    c_cash.updated,
    c_cash.updatedby,
    c_cash.isactive,
    c_cash.name AS documentno,
    c_cash.statementdate AS datedoc,
    c_cash.dateacct,
    407 AS ad_table_id,
    c_cash.c_cash_id AS record_id,
    'N'::bpchar AS issotrx,
    c_cash.posted,
    c_cash.processing,
    c_cash.processed,
    c_cash.docstatus,
    c_cash.c_cash_uu AS rv_unprocessed_uu
   FROM c_cash
  WHERE (c_cash.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]))
UNION
 SELECT c_payment.ad_client_id,
    c_payment.ad_org_id,
    c_payment.created,
    c_payment.createdby,
    c_payment.updated,
    c_payment.updatedby,
    c_payment.isactive,
    c_payment.documentno,
    c_payment.datetrx AS datedoc,
    c_payment.datetrx AS dateacct,
    335 AS ad_table_id,
    c_payment.c_payment_id AS record_id,
    'N'::bpchar AS issotrx,
    c_payment.posted,
    c_payment.processing,
    c_payment.processed,
    c_payment.docstatus,
    c_payment.c_payment_uu AS rv_unprocessed_uu
   FROM c_payment
  WHERE (c_payment.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]))
UNION
 SELECT c_allocationhdr.ad_client_id,
    c_allocationhdr.ad_org_id,
    c_allocationhdr.created,
    c_allocationhdr.createdby,
    c_allocationhdr.updated,
    c_allocationhdr.updatedby,
    c_allocationhdr.isactive,
    c_allocationhdr.documentno,
    c_allocationhdr.datetrx AS datedoc,
    c_allocationhdr.datetrx AS dateacct,
    735 AS ad_table_id,
    c_allocationhdr.c_allocationhdr_id AS record_id,
    'N'::bpchar AS issotrx,
    c_allocationhdr.posted,
    c_allocationhdr.processing,
    c_allocationhdr.processed,
    c_allocationhdr.docstatus,
    c_allocationhdr.c_allocationhdr_uu AS rv_unprocessed_uu
   FROM c_allocationhdr
  WHERE (c_allocationhdr.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]))
UNION
 SELECT c_bankstatement.ad_client_id,
    c_bankstatement.ad_org_id,
    c_bankstatement.created,
    c_bankstatement.createdby,
    c_bankstatement.updated,
    c_bankstatement.updatedby,
    c_bankstatement.isactive,
    c_bankstatement.name AS documentno,
    c_bankstatement.statementdate AS datedoc,
    c_bankstatement.statementdate AS dateacct,
    392 AS ad_table_id,
    c_bankstatement.c_bankstatement_id AS record_id,
    'N'::bpchar AS issotrx,
    c_bankstatement.posted,
    c_bankstatement.processing,
    c_bankstatement.processed,
    c_bankstatement.docstatus,
    c_bankstatement.c_bankstatement_uu AS rv_unprocessed_uu
   FROM c_bankstatement
  WHERE (c_bankstatement.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]))
UNION
 SELECT c_order.ad_client_id,
    c_order.ad_org_id,
    c_order.created,
    c_order.createdby,
    c_order.updated,
    c_order.updatedby,
    c_order.isactive,
    c_order.documentno,
    c_order.dateordered AS datedoc,
    c_order.dateacct,
    259 AS ad_table_id,
    c_order.c_order_id AS record_id,
    c_order.issotrx,
    c_order.posted,
    c_order.processing,
    c_order.processed,
    c_order.docstatus,
    c_order.c_order_uu AS rv_unprocessed_uu
   FROM c_order
  WHERE (c_order.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]))
UNION
 SELECT m_requisition.ad_client_id,
    m_requisition.ad_org_id,
    m_requisition.created,
    m_requisition.createdby,
    m_requisition.updated,
    m_requisition.updatedby,
    m_requisition.isactive,
    m_requisition.documentno,
    m_requisition.datedoc,
    m_requisition.datedoc AS dateacct,
    702 AS ad_table_id,
    m_requisition.m_requisition_id AS record_id,
    'N'::bpchar AS issotrx,
    m_requisition.posted,
    m_requisition.processing,
    m_requisition.processed,
    m_requisition.docstatus,
    m_requisition.m_requisition_uu AS rv_unprocessed_uu
   FROM m_requisition
  WHERE (m_requisition.docstatus <> ALL (ARRAY['CO'::bpchar, 'CL'::bpchar, 'VO'::bpchar, 'RE'::bpchar]));

CREATE VIEW rv_unposted AS
 SELECT gl_journal.ad_client_id,
    gl_journal.ad_org_id,
    gl_journal.created,
    gl_journal.createdby,
    gl_journal.updated,
    gl_journal.updatedby,
    gl_journal.isactive,
    gl_journal.documentno,
    gl_journal.datedoc,
    gl_journal.dateacct,
    224 AS ad_table_id,
    gl_journal.gl_journal_id AS record_id,
    'N'::text AS issotrx,
    gl_journal.posted,
    gl_journal.processing,
    gl_journal.processed,
    gl_journal.docstatus,
    gl_journal.processedon,
    dt.docbasetype,
    gl_journal.gl_journal_uu AS rv_unposted_uu
   FROM (gl_journal
     JOIN c_doctype dt ON ((dt.c_doctype_id = gl_journal.c_doctype_id)))
  WHERE ((gl_journal.posted <> 'Y'::bpchar) AND (gl_journal.docstatus <> 'VO'::bpchar))
UNION
 SELECT pi.ad_client_id,
    pi.ad_org_id,
    pi.created,
    pi.createdby,
    pi.updated,
    pi.updatedby,
    pi.isactive,
    (((p.name)::text || '_'::text) || pi.line) AS documentno,
    pi.movementdate AS datedoc,
    pi.movementdate AS dateacct,
    623 AS ad_table_id,
    pi.c_projectissue_id AS record_id,
    'N'::text AS issotrx,
    pi.posted,
    pi.processing,
    pi.processed,
    'CO'::bpchar AS docstatus,
    pi.processedon,
    'PJI'::bpchar AS docbasetype,
    pi.c_projectissue_uu AS rv_unposted_uu
   FROM (c_projectissue pi
     JOIN c_project p ON ((pi.c_project_id = p.c_project_id)))
  WHERE (pi.posted <> 'Y'::bpchar)
UNION
 SELECT c_invoice.ad_client_id,
    c_invoice.ad_org_id,
    c_invoice.created,
    c_invoice.createdby,
    c_invoice.updated,
    c_invoice.updatedby,
    c_invoice.isactive,
    c_invoice.documentno,
    c_invoice.dateinvoiced AS datedoc,
    c_invoice.dateacct,
    318 AS ad_table_id,
    c_invoice.c_invoice_id AS record_id,
    c_invoice.issotrx,
    c_invoice.posted,
    c_invoice.processing,
    c_invoice.processed,
    c_invoice.docstatus,
    c_invoice.processedon,
    dt.docbasetype,
    c_invoice.c_invoice_uu AS rv_unposted_uu
   FROM (c_invoice
     JOIN c_doctype dt ON ((dt.c_doctype_id = c_invoice.c_doctype_id)))
  WHERE ((c_invoice.posted <> 'Y'::bpchar) AND (c_invoice.docstatus <> 'VO'::bpchar))
UNION
 SELECT m_inout.ad_client_id,
    m_inout.ad_org_id,
    m_inout.created,
    m_inout.createdby,
    m_inout.updated,
    m_inout.updatedby,
    m_inout.isactive,
    m_inout.documentno,
    m_inout.movementdate AS datedoc,
    m_inout.dateacct,
    319 AS ad_table_id,
    m_inout.m_inout_id AS record_id,
    m_inout.issotrx,
    m_inout.posted,
    m_inout.processing,
    m_inout.processed,
    m_inout.docstatus,
    m_inout.processedon,
    dt.docbasetype,
    m_inout.m_inout_uu AS rv_unposted_uu
   FROM (m_inout
     JOIN c_doctype dt ON ((dt.c_doctype_id = m_inout.c_doctype_id)))
  WHERE ((m_inout.posted <> 'Y'::bpchar) AND (m_inout.docstatus <> 'VO'::bpchar))
UNION
 SELECT m_inventory.ad_client_id,
    m_inventory.ad_org_id,
    m_inventory.created,
    m_inventory.createdby,
    m_inventory.updated,
    m_inventory.updatedby,
    m_inventory.isactive,
    m_inventory.documentno,
    m_inventory.movementdate AS datedoc,
    m_inventory.movementdate AS dateacct,
    321 AS ad_table_id,
    m_inventory.m_inventory_id AS record_id,
    'N'::text AS issotrx,
    m_inventory.posted,
    m_inventory.processing,
    m_inventory.processed,
    m_inventory.docstatus,
    m_inventory.processedon,
    dt.docbasetype,
    m_inventory.m_inventory_uu AS rv_unposted_uu
   FROM (m_inventory
     JOIN c_doctype dt ON ((dt.c_doctype_id = m_inventory.c_doctype_id)))
  WHERE ((m_inventory.posted <> 'Y'::bpchar) AND (m_inventory.docstatus <> 'VO'::bpchar))
UNION
 SELECT m_movement.ad_client_id,
    m_movement.ad_org_id,
    m_movement.created,
    m_movement.createdby,
    m_movement.updated,
    m_movement.updatedby,
    m_movement.isactive,
    m_movement.documentno,
    m_movement.movementdate AS datedoc,
    m_movement.movementdate AS dateacct,
    323 AS ad_table_id,
    m_movement.m_movement_id AS record_id,
    'N'::text AS issotrx,
    m_movement.posted,
    m_movement.processing,
    m_movement.processed,
    m_movement.docstatus,
    m_movement.processedon,
    dt.docbasetype,
    m_movement.m_movement_uu AS rv_unposted_uu
   FROM (m_movement
     JOIN c_doctype dt ON ((dt.c_doctype_id = m_movement.c_doctype_id)))
  WHERE ((m_movement.posted <> 'Y'::bpchar) AND (m_movement.docstatus <> 'VO'::bpchar))
UNION
 SELECT m_production.ad_client_id,
    m_production.ad_org_id,
    m_production.created,
    m_production.createdby,
    m_production.updated,
    m_production.updatedby,
    m_production.isactive,
    m_production.documentno,
    m_production.movementdate AS datedoc,
    m_production.movementdate AS dateacct,
    325 AS ad_table_id,
    m_production.m_production_id AS record_id,
    'N'::text AS issotrx,
    m_production.posted,
    m_production.processing,
    m_production.processed,
    m_production.docstatus,
    m_production.processedon,
    'MMP'::bpchar AS docbasetype,
    m_production.m_production_uu AS rv_unposted_uu
   FROM m_production
  WHERE ((m_production.posted <> 'Y'::bpchar) AND ((m_production.docstatus)::text <> 'VO'::text))
UNION
 SELECT c_cash.ad_client_id,
    c_cash.ad_org_id,
    c_cash.created,
    c_cash.createdby,
    c_cash.updated,
    c_cash.updatedby,
    c_cash.isactive,
    c_cash.name AS documentno,
    c_cash.statementdate AS datedoc,
    c_cash.dateacct,
    407 AS ad_table_id,
    c_cash.c_cash_id AS record_id,
    'N'::text AS issotrx,
    c_cash.posted,
    c_cash.processing,
    c_cash.processed,
    c_cash.docstatus,
    c_cash.processedon,
    'CMC'::bpchar AS docbasetype,
    c_cash.c_cash_uu AS rv_unposted_uu
   FROM c_cash
  WHERE ((c_cash.posted <> 'Y'::bpchar) AND (c_cash.docstatus <> 'VO'::bpchar))
UNION
 SELECT c_payment.ad_client_id,
    c_payment.ad_org_id,
    c_payment.created,
    c_payment.createdby,
    c_payment.updated,
    c_payment.updatedby,
    c_payment.isactive,
    c_payment.documentno,
    c_payment.datetrx AS datedoc,
    c_payment.dateacct,
    335 AS ad_table_id,
    c_payment.c_payment_id AS record_id,
    'N'::text AS issotrx,
    c_payment.posted,
    c_payment.processing,
    c_payment.processed,
    c_payment.docstatus,
    c_payment.processedon,
    dt.docbasetype,
    c_payment.c_payment_uu AS rv_unposted_uu
   FROM (c_payment
     JOIN c_doctype dt ON ((dt.c_doctype_id = c_payment.c_doctype_id)))
  WHERE ((c_payment.posted <> 'Y'::bpchar) AND (c_payment.docstatus <> 'VO'::bpchar))
UNION
 SELECT c_allocationhdr.ad_client_id,
    c_allocationhdr.ad_org_id,
    c_allocationhdr.created,
    c_allocationhdr.createdby,
    c_allocationhdr.updated,
    c_allocationhdr.updatedby,
    c_allocationhdr.isactive,
    c_allocationhdr.documentno,
    c_allocationhdr.datetrx AS datedoc,
    c_allocationhdr.dateacct,
    735 AS ad_table_id,
    c_allocationhdr.c_allocationhdr_id AS record_id,
    'N'::text AS issotrx,
    c_allocationhdr.posted,
    c_allocationhdr.processing,
    c_allocationhdr.processed,
    c_allocationhdr.docstatus,
    c_allocationhdr.processedon,
    dt.docbasetype,
    c_allocationhdr.c_allocationhdr_uu AS rv_unposted_uu
   FROM (c_allocationhdr
     JOIN c_doctype dt ON ((dt.c_doctype_id = c_allocationhdr.c_doctype_id)))
  WHERE ((c_allocationhdr.posted <> 'Y'::bpchar) AND (c_allocationhdr.docstatus <> 'VO'::bpchar))
UNION
 SELECT c_bankstatement.ad_client_id,
    c_bankstatement.ad_org_id,
    c_bankstatement.created,
    c_bankstatement.createdby,
    c_bankstatement.updated,
    c_bankstatement.updatedby,
    c_bankstatement.isactive,
    c_bankstatement.name AS documentno,
    c_bankstatement.statementdate AS datedoc,
    c_bankstatement.statementdate AS dateacct,
    392 AS ad_table_id,
    c_bankstatement.c_bankstatement_id AS record_id,
    'N'::text AS issotrx,
    c_bankstatement.posted,
    c_bankstatement.processing,
    c_bankstatement.processed,
    c_bankstatement.docstatus,
    c_bankstatement.processedon,
    'CMB'::bpchar AS docbasetype,
    c_bankstatement.c_bankstatement_uu AS rv_unposted_uu
   FROM c_bankstatement
  WHERE ((c_bankstatement.posted <> 'Y'::bpchar) AND (c_bankstatement.docstatus <> 'VO'::bpchar))
UNION
 SELECT m_matchinv.ad_client_id,
    m_matchinv.ad_org_id,
    m_matchinv.created,
    m_matchinv.createdby,
    m_matchinv.updated,
    m_matchinv.updatedby,
    m_matchinv.isactive,
    m_matchinv.documentno,
    m_matchinv.datetrx AS datedoc,
    m_matchinv.dateacct,
    472 AS ad_table_id,
    m_matchinv.m_matchinv_id AS record_id,
    'N'::text AS issotrx,
    m_matchinv.posted,
    m_matchinv.processing,
    m_matchinv.processed,
    'CO'::bpchar AS docstatus,
    m_matchinv.processedon,
    'MXI'::bpchar AS docbasetype,
    m_matchinv.m_matchinv_uu AS rv_unposted_uu
   FROM m_matchinv
  WHERE (m_matchinv.posted <> 'Y'::bpchar)
UNION
 SELECT m_matchpo.ad_client_id,
    m_matchpo.ad_org_id,
    m_matchpo.created,
    m_matchpo.createdby,
    m_matchpo.updated,
    m_matchpo.updatedby,
    m_matchpo.isactive,
    m_matchpo.documentno,
    m_matchpo.datetrx AS datedoc,
    m_matchpo.dateacct,
    473 AS ad_table_id,
    m_matchpo.m_matchpo_id AS record_id,
    'N'::text AS issotrx,
    m_matchpo.posted,
    m_matchpo.processing,
    m_matchpo.processed,
    'CO'::bpchar AS docstatus,
    m_matchpo.processedon,
    'MXP'::bpchar AS docbasetype,
    m_matchpo.m_matchpo_uu AS rv_unposted_uu
   FROM m_matchpo
  WHERE (m_matchpo.posted <> 'Y'::bpchar)
UNION
 SELECT c_order.ad_client_id,
    c_order.ad_org_id,
    c_order.created,
    c_order.createdby,
    c_order.updated,
    c_order.updatedby,
    c_order.isactive,
    c_order.documentno,
    c_order.dateordered AS datedoc,
    c_order.dateacct,
    259 AS ad_table_id,
    c_order.c_order_id AS record_id,
    c_order.issotrx,
    c_order.posted,
    c_order.processing,
    c_order.processed,
    c_order.docstatus,
    c_order.processedon,
    dt.docbasetype,
    c_order.c_order_uu AS rv_unposted_uu
   FROM (c_order
     JOIN c_doctype dt ON ((dt.c_doctype_id = c_order.c_doctype_id)))
  WHERE ((c_order.posted <> 'Y'::bpchar) AND (c_order.docstatus <> 'VO'::bpchar))
UNION
 SELECT m_requisition.ad_client_id,
    m_requisition.ad_org_id,
    m_requisition.created,
    m_requisition.createdby,
    m_requisition.updated,
    m_requisition.updatedby,
    m_requisition.isactive,
    m_requisition.documentno,
    m_requisition.datedoc,
    m_requisition.datedoc AS dateacct,
    702 AS ad_table_id,
    m_requisition.m_requisition_id AS record_id,
    'N'::text AS issotrx,
    m_requisition.posted,
    m_requisition.processing,
    m_requisition.processed,
    m_requisition.docstatus,
    m_requisition.processedon,
    dt.docbasetype,
    m_requisition.m_requisition_uu AS rv_unposted_uu
   FROM (m_requisition
     JOIN c_doctype dt ON ((dt.c_doctype_id = m_requisition.c_doctype_id)))
  WHERE ((m_requisition.posted <> 'Y'::bpchar) AND (m_requisition.docstatus <> 'VO'::bpchar));

CREATE VIEW m_storage AS
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
    s.datematerialpolicy
   FROM m_storageonhand s
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
    0 AS qtyonhand,
    sr.qty AS qtyreserved,
    0 AS qtyordered,
    sr.datelastinventory,
    sr.m_attributesetinstance_id,
    sr.m_storagereservation_uu AS m_storage_uu,
    NULL::timestamp without time zone AS datematerialpolicy
   FROM (m_storagereservation sr
     JOIN m_warehouse w ON ((sr.m_warehouse_id = w.m_warehouse_id)))
  WHERE ((sr.issotrx = 'Y'::bpchar) AND (sr.qty <> (0)::numeric))
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
    0 AS qtyonhand,
    0 AS qtyreserved,
    so.qty AS qtyordered,
    so.datelastinventory,
    so.m_attributesetinstance_id,
    so.m_storagereservation_uu AS m_storage_uu,
    NULL::timestamp without time zone AS datematerialpolicy
   FROM (m_storagereservation so
     JOIN m_warehouse w ON ((so.m_warehouse_id = w.m_warehouse_id)))
  WHERE ((so.issotrx = 'N'::bpchar) AND (so.qty <> (0)::numeric));

CREATE VIEW rv_pp_order_storage AS
 SELECT obl.ad_client_id,
    obl.ad_org_id,
    obl.createdby,
    obl.updatedby,
    obl.updated,
    obl.created,
    obl.isactive,
    obl.pp_order_bom_id,
    obl.pp_order_bomline_id,
    obl.pp_order_id,
    obl.iscritical,
    obl.m_product_id,
    ( SELECT p.name
           FROM m_product p
          WHERE (p.m_product_id = o.m_product_id)) AS name,
    obl.c_uom_id,
    s.qtyonhand,
    round(obl.qtyrequiered, 4) AS qtyrequiered,
        CASE
            WHEN (o.qtybatchs = (0)::numeric) THEN (1)::numeric
            ELSE round((obl.qtyrequiered / o.qtybatchs), 4)
        END AS qtybatchsize,
    round(bomqtyreserved(obl.m_product_id, obl.m_warehouse_id, (0)::numeric), 4) AS qtyreserved,
    round(bomqtyavailable(obl.m_product_id, obl.m_warehouse_id, (0)::numeric), 4) AS qtyavailable,
    obl.m_warehouse_id,
    obl.qtybom,
    obl.isqtypercentage,
    round(obl.qtybatch, 4) AS qtybatch,
    obl.m_attributesetinstance_id,
    l.m_locator_id,
    l.x,
    l.y,
    l.z
   FROM (((pp_order_bomline obl
     JOIN pp_order o ON ((o.pp_order_id = obl.pp_order_id)))
     LEFT JOIN m_storage s ON (((s.m_product_id = obl.m_product_id) AND (s.qtyonhand <> (0)::numeric) AND (obl.m_warehouse_id = ( SELECT ld.m_warehouse_id
           FROM m_locator ld
          WHERE (s.m_locator_id = ld.m_locator_id))))))
     LEFT JOIN m_locator l ON ((l.m_locator_id = s.m_locator_id)))
  ORDER BY obl.m_product_id;

CREATE VIEW m_product_stock_v AS
 SELECT ms.isactive,
    ms.created,
    ms.createdby,
    ms.updated,
    ms.updatedby,
    mp.value,
    mp.help,
    (
        CASE
            WHEN (COALESCE(lt.isavailableforreservation, 'Y'::bpchar) = 'Y'::bpchar) THEN ms.qtyonhand
            ELSE (0)::numeric
        END - ms.qtyreserved) AS qtyavailable,
    ms.qtyonhand,
    ms.qtyreserved,
    mp.description,
    mw.name AS warehouse,
    mw.m_warehouse_id,
    mw.ad_client_id,
    mw.ad_org_id,
    mp.documentnote,
    mp.m_product_id
   FROM ((((m_storage ms
     JOIN m_product mp ON ((ms.m_product_id = mp.m_product_id)))
     JOIN m_locator ml ON ((ms.m_locator_id = ml.m_locator_id)))
     LEFT JOIN m_locatortype lt ON ((ml.m_locatortype_id = lt.m_locatortype_id)))
     JOIN m_warehouse mw ON ((ml.m_warehouse_id = mw.m_warehouse_id)))
  ORDER BY mw.name;

CREATE VIEW m_product_substituterelated_v AS
 SELECT s.ad_client_id,
    s.ad_org_id,
    s.isactive,
    s.created,
    s.createdby,
    s.updated,
    s.updatedby,
    s.m_product_id,
    s.substitute_id,
    'S'::text AS rowtype,
    mp.name,
    sum((
        CASE
            WHEN (COALESCE(lt.isavailableforreservation, 'Y'::bpchar) = 'Y'::bpchar) THEN ms.qtyonhand
            ELSE (0)::numeric
        END - ms.qtyreserved)) AS qtyavailable,
    sum(ms.qtyonhand) AS qtyonhand,
    sum(ms.qtyreserved) AS qtyreserved,
    currencyround(max(mpr.pricestd), mpl.c_currency_id, 'N'::character varying) AS pricestd,
    mpr.m_pricelist_version_id,
    mw.m_warehouse_id,
    org.name AS orgname
   FROM (((((((((m_substitute s
     JOIN m_storage ms ON ((ms.m_product_id = s.substitute_id)))
     JOIN m_product mp ON ((ms.m_product_id = mp.m_product_id)))
     JOIN m_locator ml ON ((ms.m_locator_id = ml.m_locator_id)))
     LEFT JOIN m_locatortype lt ON ((ml.m_locatortype_id = lt.m_locatortype_id)))
     JOIN m_warehouse mw ON ((ml.m_warehouse_id = mw.m_warehouse_id)))
     JOIN m_productprice mpr ON ((ms.m_product_id = mpr.m_product_id)))
     JOIN m_pricelist_version mplv ON ((mplv.m_pricelist_version_id = mpr.m_pricelist_version_id)))
     JOIN m_pricelist mpl ON ((mplv.m_pricelist_id = mpl.m_pricelist_id)))
     JOIN ad_org org ON ((org.ad_org_id = mw.ad_org_id)))
  GROUP BY s.ad_client_id, s.ad_org_id, s.isactive, s.created, s.createdby, s.updated, s.updatedby, s.m_product_id, s.substitute_id, mw.m_warehouse_id, mpr.m_pricelist_version_id, org.name, mp.name, mpl.c_currency_id
UNION
 SELECT r.ad_client_id,
    r.ad_org_id,
    r.isactive,
    r.created,
    r.createdby,
    r.updated,
    r.updatedby,
    r.m_product_id,
    r.relatedproduct_id AS substitute_id,
    'R'::text AS rowtype,
    mp.name,
    sum((
        CASE
            WHEN (COALESCE(lt.isavailableforreservation, 'Y'::bpchar) = 'Y'::bpchar) THEN ms.qtyonhand
            ELSE (0)::numeric
        END - ms.qtyreserved)) AS qtyavailable,
    sum(ms.qtyonhand) AS qtyonhand,
    sum(ms.qtyreserved) AS qtyreserved,
    currencyround(max(mpr.pricestd), mpl.c_currency_id, 'N'::character varying) AS pricestd,
    mpr.m_pricelist_version_id,
    mw.m_warehouse_id,
    org.name AS orgname
   FROM (((((((((m_relatedproduct r
     JOIN m_storage ms ON ((ms.m_product_id = r.relatedproduct_id)))
     JOIN m_product mp ON ((ms.m_product_id = mp.m_product_id)))
     JOIN m_locator ml ON ((ms.m_locator_id = ml.m_locator_id)))
     LEFT JOIN m_locatortype lt ON ((ml.m_locatortype_id = lt.m_locatortype_id)))
     JOIN m_warehouse mw ON ((ml.m_warehouse_id = mw.m_warehouse_id)))
     JOIN m_productprice mpr ON ((ms.m_product_id = mpr.m_product_id)))
     JOIN m_pricelist_version mplv ON ((mplv.m_pricelist_version_id = mpr.m_pricelist_version_id)))
     JOIN m_pricelist mpl ON ((mplv.m_pricelist_id = mpl.m_pricelist_id)))
     JOIN ad_org org ON ((org.ad_org_id = mw.ad_org_id)))
  GROUP BY r.ad_client_id, r.ad_org_id, r.isactive, r.created, r.createdby, r.updated, r.updatedby, r.m_product_id, r.relatedproduct_id, mw.m_warehouse_id, mpr.m_pricelist_version_id, org.name, mp.name, mpl.c_currency_id;

CREATE VIEW rv_pp_order_receipt_issue AS
 SELECT obl.pp_order_bomline_id,
    obl.iscritical,
    p.value,
    obl.m_product_id,
    mos.name AS productname,
    mos.m_attributesetinstance_id,
    asi.description AS instancename,
    mos.c_uom_id,
    u.name AS uomname,
    obl.qtyrequiered,
    obl.qtyreserved AS qtyreserved_order,
    mos.qtyonhand,
    mos.qtyreserved AS qtyreserved_storage,
    mos.qtyavailable,
    mos.m_locator_id,
    mos.m_warehouse_id,
    w.name AS warehousename,
    mos.qtybom,
    mos.isqtypercentage,
    mos.qtybatch,
    obl.componenttype,
    (mos.qtyrequiered - obl.qtydelivered) AS qtyopen,
    obl.pp_order_id
   FROM (((((rv_pp_order_storage mos
     JOIN pp_order_bomline obl ON ((mos.pp_order_bomline_id = obl.pp_order_bomline_id)))
     JOIN m_attributesetinstance asi ON ((mos.m_attributesetinstance_id = asi.m_attributesetinstance_id)))
     JOIN c_uom u ON ((mos.c_uom_id = u.c_uom_id)))
     JOIN m_product p ON ((mos.m_product_id = p.m_product_id)))
     JOIN m_warehouse w ON ((mos.m_warehouse_id = w.m_warehouse_id)));

CREATE VIEW rv_storage AS
 SELECT s.ad_client_id,
    s.ad_org_id,
    s.m_product_id,
    p.value,
    p.name,
    p.description,
    p.upc,
    p.sku,
    p.c_uom_id,
    p.m_product_category_id,
    p.classification,
    p.weight,
    p.volume,
    p.versionno,
    p.guaranteedays,
    p.guaranteedaysmin,
    s.m_locator_id,
    l.m_warehouse_id,
    l.x,
    l.y,
    l.z,
    s.qtyonhand,
    s.qtyreserved,
    (
        CASE
            WHEN (COALESCE(lt.isavailableforreservation, 'Y'::bpchar) = 'Y'::bpchar) THEN s.qtyonhand
            ELSE (0)::numeric
        END - s.qtyreserved) AS qtyavailable,
    s.qtyordered,
    s.datelastinventory,
    s.m_attributesetinstance_id,
    asi.m_attributeset_id,
    asi.serno,
    asi.lot,
    asi.m_lot_id,
    asi.guaranteedate,
    daysbetween((asi.guaranteedate)::timestamp with time zone, statement_timestamp()) AS shelflifedays,
    ((daysbetween((asi.guaranteedate)::timestamp with time zone, statement_timestamp()))::numeric - p.guaranteedaysmin) AS goodfordays,
        CASE
            WHEN (COALESCE(p.guaranteedays, (0)::numeric) > (0)::numeric) THEN round((((daysbetween((asi.guaranteedate)::timestamp with time zone, statement_timestamp()))::numeric / p.guaranteedays) * (100)::numeric), 0)
            ELSE NULL::numeric
        END AS shelfliferemainingpct,
    s.isactive AS m_storage_isactive,
    s.updated AS m_storage_updated,
    s.updatedby AS m_storage_updatedby,
    l.ad_org_id AS m_locator_ad_org_id,
    l.isactive AS m_locator_isactive,
    l.isdefault,
    l.priorityno,
    l.value AS m_locator_value,
    p.ad_org_id AS m_product_ad_org_id,
    p.copyfrom AS m_product_copyfrom,
    p.created AS m_product_created,
    p.createdby AS m_product_createdby,
    p.c_revenuerecognition_id,
    p.c_subscriptiontype_id,
    p.c_taxcategory_id,
    p.descriptionurl,
    p.discontinued AS m_product_discontinued,
    p.discontinuedat AS m_product_discontinuedat,
    p.documentnote,
    p.group1,
    p.group2,
    p.help,
    p.imageurl,
    p.isactive AS m_product_isactive,
    p.isbom,
    p.isdropship,
    p.isexcludeautodelivery,
    p.isinvoiceprintdetails,
    p.ispicklistprintdetails,
    p.ispurchased,
    p.isselfservice,
    p.issold,
    p.isstocked,
    p.issummary AS m_product_issummary,
    p.isverified,
    p.iswebstorefeatured,
    p.lowlevel,
    p.m_attributeset_id AS m_product_m_attributeset_id,
    p.m_attributesetinstance_id AS m_product_m_asi_id,
    p.m_freightcategory_id,
    p.m_locator_id AS m_product_m_locator_id,
    p.processing AS m_product_processing,
    p.producttype,
    p.r_mailtext_id,
    p.salesrep_id AS m_product_salesrep_id,
    p.s_expensetype_id,
    p.shelfdepth,
    p.shelfheight,
    p.shelfwidth,
    p.s_resource_id,
    p.unitsperpack,
    p.unitsperpallet,
    p.updated AS m_product_updated,
    p.updatedby AS m_product_updatedby,
    asi.ad_org_id AS m_asi_ad_org_id,
    asi.created AS m_asi_created,
    asi.createdby AS m_asi_createdby,
    asi.description AS m_asi_description,
    asi.isactive AS m_asi_isactive,
    asi.updated AS m_asi_updated,
    asi.updatedby AS m_asi_updatedby
   FROM ((((m_storage s
     JOIN m_locator l ON ((s.m_locator_id = l.m_locator_id)))
     LEFT JOIN m_locatortype lt ON ((l.m_locatortype_id = lt.m_locatortype_id)))
     JOIN m_product p ON ((s.m_product_id = p.m_product_id)))
     LEFT JOIN m_attributesetinstance asi ON ((s.m_attributesetinstance_id = asi.m_attributesetinstance_id)));

CREATE VIEW rv_storage_per_product AS
 SELECT strg.ad_client_id,
    strg.ad_org_id,
    p.m_product_id,
    p.value,
    p.name,
    p.description,
    p.upc,
    p.sku,
    p.c_uom_id,
    p.m_product_category_id,
    p.classification,
    p.weight,
    p.volume,
    p.versionno,
    p.guaranteedays,
    p.guaranteedaysmin,
    strg.sumqtyonhand,
    strg.sumqtyavailable,
    strg.sumqtyordered,
    strg.sumqtyreserved
   FROM ((m_product p
     JOIN ( SELECT rv_storage.m_product_id,
            rv_storage.m_locator_id,
            sum(rv_storage.qtyonhand) AS sumqtyonhand,
            sum(rv_storage.qtyavailable) AS sumqtyavailable,
            sum(rv_storage.qtyordered) AS sumqtyordered,
            sum(rv_storage.qtyreserved) AS sumqtyreserved,
            rv_storage.ad_client_id,
            rv_storage.ad_org_id
           FROM rv_storage
          GROUP BY rv_storage.m_product_id, rv_storage.m_locator_id, rv_storage.ad_client_id, rv_storage.ad_org_id) strg ON ((p.m_product_id = strg.m_product_id)))
     JOIN m_locator l ON ((strg.m_locator_id = l.m_locator_id)));

