-- IDEMPIERE-5747 When using Generate PO from SO - cannot delete the generated PO, neither the SO lines
SELECT register_migration_script('202306211841_IDEMPIERE-5747.sql') FROM dual;

-- Jun 21, 2023, 6:41:18 PM CEST
UPDATE AD_Column SET FKConstraintType='S',Updated=TO_TIMESTAMP('2023-06-21 18:41:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55323
;

-- Jun 21, 2023, 6:42:32 PM CEST
ALTER TABLE C_OrderLine DROP CONSTRAINT linkorderline_corderline
;

-- Jun 21, 2023, 6:42:32 PM CEST
ALTER TABLE C_OrderLine ADD CONSTRAINT linkorderline_corderline FOREIGN KEY (Link_OrderLine_ID) REFERENCES c_orderline(c_orderline_id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED
;

-- Jun 21, 2023, 6:44:46 PM CEST
UPDATE AD_Column SET FKConstraintType='S',Updated=TO_TIMESTAMP('2023-06-21 18:44:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55322
;

-- Jun 21, 2023, 6:44:50 PM CEST
ALTER TABLE C_Order DROP CONSTRAINT linkorder_corder
;

-- Jun 21, 2023, 6:44:50 PM CEST
ALTER TABLE C_Order ADD CONSTRAINT linkorder_corder FOREIGN KEY (Link_Order_ID) REFERENCES c_order(c_order_id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED
;

