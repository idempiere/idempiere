-- IDEMPIERE-7080 Shipment/Receipt Create Lines From: show only completed orders and allow purchase order over-receipts
SELECT register_migration_script('202608150743_IDEMPIERE-7080.sql') FROM dual;

-- Aug 15, 2026, 7:43:46 AM CEST
UPDATE AD_Val_Rule SET Code='C_BPartner_ID=@C_BPartner_ID@ AND IsSOTrx=''@IsSOTrx@'' AND
(
 (IsSOTrx=''N'' AND DocStatus=''CO'')
 OR
 (IsSOTrx=''Y'' AND DocStatus=''CO'' AND C_Order_ID IN (SELECT C_Order_ID FROM C_OrderLine WHERE QtyOrdered-QtyDelivered!=0))
)
AND M_Warehouse_ID = (CASE WHEN @M_Warehouse_ID@>0 THEN @M_Warehouse_ID@ ELSE M_Warehouse_ID END)',Updated=TO_TIMESTAMP('2026-08-15 07:43:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200164
;
