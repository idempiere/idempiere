-- IDEMPIERE-5623 Create Lines From in Shipment must show pending quantities
SELECT register_migration_script('202303091847_IDEMPIERE-5623.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 9, 2023, 6:47:01 PM CET
UPDATE AD_ViewColumn SET ColumnSQL='CASE o.issotrx WHEN ''Y'' THEN l.qtyordered-l.qtydelivered ELSE l.qtyordered - sum(COALESCE(m.qty, 0)) - COALESCE(( SELECT sum(iol.movementqty) AS sum FROM m_inoutline iol JOIN m_inout io ON iol.m_inout_id = io.m_inout_id WHERE l.c_orderline_id = iol.c_orderline_id AND io.processed = ''N''), 0) END',Updated=TO_TIMESTAMP('2023-03-09 18:47:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_UU='33132bfe-bb61-4475-b646-7ad03d0fd8a4'
;

-- View updated in 202303141611_IDEMPIERE-5623.sql


