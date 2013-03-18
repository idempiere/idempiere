-- Mar 13, 2013 4:02:09 PM COT
-- IDEMPIERE-661 OrderLineCreateProduction not passing accounting data from SO to Production
UPDATE AD_Column SET ColumnSQL=NULL, IsAllowCopy='N',Updated=TO_TIMESTAMP('2013-03-13 16:02:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=61942
;

-- Mar 13, 2013 4:02:19 PM COT
-- IDEMPIERE-661 OrderLineCreateProduction not passing accounting data from SO to Production
ALTER TABLE M_Production ADD COLUMN C_BPartner_ID NUMERIC(10) DEFAULT NULL 
;

update m_production 
set c_bpartner_id=(select o.c_bpartner_id from c_order o join c_orderline ol on o.c_order_id=ol.c_order_id where ol.c_orderline_id=m_production.c_orderline_id)
where c_orderline_id>0
;

-- Mar 17, 2013 4:23:40 PM COT
UPDATE AD_Table SET AD_Window_ID=53127,Updated=TO_TIMESTAMP('2013-03-17 16:23:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=325
;

SELECT register_migration_script('201303131830_IDEMPIERE-661.sql') FROM dual
;
