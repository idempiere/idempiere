-- IDEMPIERE-4046 copy current issue url  No need of foreign keys on temporary tables
-- Sep 10, 2019, 11:52:45 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:52:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15898
;

-- Sep 10, 2019, 11:52:46 AM CEST
INSERT INTO t_alter_column values('t_aging','C_Activity_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:52:46 AM CEST
ALTER TABLE T_Aging DROP CONSTRAINT cactivity_taging
;

-- Sep 10, 2019, 11:52:46 AM CEST
ALTER TABLE T_Aging ADD CONSTRAINT cactivity_taging FOREIGN KEY (C_Activity_ID) REFERENCES c_activity(c_activity_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:53:00 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:53:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10139
;

-- Sep 10, 2019, 11:53:01 AM CEST
INSERT INTO t_alter_column values('t_aging','C_BP_Group_ID','NUMERIC(10)',null,null)
;

-- Sep 10, 2019, 11:53:01 AM CEST
ALTER TABLE T_Aging DROP CONSTRAINT cbpgroup_taging
;

-- Sep 10, 2019, 11:53:01 AM CEST
ALTER TABLE T_Aging ADD CONSTRAINT cbpgroup_taging FOREIGN KEY (C_BP_Group_ID) REFERENCES c_bp_group(c_bp_group_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:53:30 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:53:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15897
;

-- Sep 10, 2019, 11:53:31 AM CEST
INSERT INTO t_alter_column values('t_aging','C_Campaign_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:53:31 AM CEST
ALTER TABLE T_Aging DROP CONSTRAINT ccampaign_taging
;

-- Sep 10, 2019, 11:53:31 AM CEST
ALTER TABLE T_Aging ADD CONSTRAINT ccampaign_taging FOREIGN KEY (C_Campaign_ID) REFERENCES c_campaign(c_campaign_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:53:41 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:53:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10126
;

-- Sep 10, 2019, 11:53:42 AM CEST
INSERT INTO t_alter_column values('t_aging','C_Currency_ID','NUMERIC(10)',null,null)
;

-- Sep 10, 2019, 11:53:42 AM CEST
ALTER TABLE T_Aging DROP CONSTRAINT ccurrency_taging
;

-- Sep 10, 2019, 11:53:42 AM CEST
ALTER TABLE T_Aging ADD CONSTRAINT ccurrency_taging FOREIGN KEY (C_Currency_ID) REFERENCES c_currency(c_currency_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:53:52 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:53:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15896
;

-- Sep 10, 2019, 11:53:53 AM CEST
INSERT INTO t_alter_column values('t_aging','C_Project_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:53:53 AM CEST
ALTER TABLE T_Aging DROP CONSTRAINT cproject_taging
;

-- Sep 10, 2019, 11:53:53 AM CEST
ALTER TABLE T_Aging ADD CONSTRAINT cproject_taging FOREIGN KEY (C_Project_ID) REFERENCES c_project(c_project_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:54:18 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:54:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11813
;

-- Sep 10, 2019, 11:54:19 AM CEST
INSERT INTO t_alter_column values('t_distributionrundetail','M_DistributionRunLine_ID','NUMERIC(10)',null,null)
;

-- Sep 10, 2019, 11:54:19 AM CEST
ALTER TABLE T_DistributionRunDetail DROP CONSTRAINT mdistributionrline_tdrdetail
;

-- Sep 10, 2019, 11:54:19 AM CEST
ALTER TABLE T_DistributionRunDetail ADD CONSTRAINT mdistributionrline_tdrdetail FOREIGN KEY (M_DistributionRunLine_ID) REFERENCES m_distributionrunline(m_distributionrunline_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:54:39 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:54:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6723
;

-- Sep 10, 2019, 11:54:40 AM CEST
INSERT INTO t_alter_column values('t_inventoryvalue','C_Currency_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:54:40 AM CEST
ALTER TABLE T_InventoryValue DROP CONSTRAINT ccurrency_tinventoryvalue
;

-- Sep 10, 2019, 11:54:40 AM CEST
ALTER TABLE T_InventoryValue ADD CONSTRAINT ccurrency_tinventoryvalue FOREIGN KEY (C_Currency_ID) REFERENCES c_currency(c_currency_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:54:50 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:54:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14977
;

-- Sep 10, 2019, 11:54:51 AM CEST
INSERT INTO t_alter_column values('t_inventoryvalue','M_AttributeSetInstance_ID','NUMERIC(10)',null,null)
;

-- Sep 10, 2019, 11:54:51 AM CEST
ALTER TABLE T_InventoryValue DROP CONSTRAINT masi_tinventoryvalue
;

-- Sep 10, 2019, 11:54:51 AM CEST
ALTER TABLE T_InventoryValue ADD CONSTRAINT masi_tinventoryvalue FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:54:57 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:54:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14980
;

-- Sep 10, 2019, 11:54:58 AM CEST
INSERT INTO t_alter_column values('t_inventoryvalue','M_CostElement_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:54:58 AM CEST
ALTER TABLE T_InventoryValue DROP CONSTRAINT mcostelement_tinventoryvalue
;

-- Sep 10, 2019, 11:54:58 AM CEST
ALTER TABLE T_InventoryValue ADD CONSTRAINT mcostelement_tinventoryvalue FOREIGN KEY (M_CostElement_ID) REFERENCES m_costelement(m_costelement_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:55:06 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:55:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6721
;

-- Sep 10, 2019, 11:55:07 AM CEST
INSERT INTO t_alter_column values('t_inventoryvalue','M_PriceList_Version_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:55:07 AM CEST
ALTER TABLE T_InventoryValue DROP CONSTRAINT mplversion_tinventoryvalue
;

-- Sep 10, 2019, 11:55:07 AM CEST
ALTER TABLE T_InventoryValue ADD CONSTRAINT mplversion_tinventoryvalue FOREIGN KEY (M_PriceList_Version_ID) REFERENCES m_pricelist_version(m_pricelist_version_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:55:30 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:55:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14076
;

-- Sep 10, 2019, 11:55:32 AM CEST
INSERT INTO t_alter_column values('t_invoicegl','C_ConversionTypeReval_ID','NUMERIC(10)',null,null)
;

-- Sep 10, 2019, 11:55:32 AM CEST
ALTER TABLE T_InvoiceGL DROP CONSTRAINT cconversiontype_tinvoicegl
;

-- Sep 10, 2019, 11:55:32 AM CEST
ALTER TABLE T_InvoiceGL ADD CONSTRAINT cconversiontype_tinvoicegl FOREIGN KEY (C_ConversionTypeReval_ID) REFERENCES c_conversiontype(c_conversiontype_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:55:39 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:55:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14721
;

-- Sep 10, 2019, 11:55:40 AM CEST
INSERT INTO t_alter_column values('t_invoicegl','C_DocTypeReval_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:55:40 AM CEST
ALTER TABLE T_InvoiceGL DROP CONSTRAINT cdoctype_tinvoicegl
;

-- Sep 10, 2019, 11:55:40 AM CEST
ALTER TABLE T_InvoiceGL ADD CONSTRAINT cdoctype_tinvoicegl FOREIGN KEY (C_DocTypeReval_ID) REFERENCES c_doctype(c_doctype_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:55:56 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:55:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14707
;

-- Sep 10, 2019, 11:55:57 AM CEST
INSERT INTO t_alter_column values('t_replenish','C_DocType_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:55:57 AM CEST
ALTER TABLE T_Replenish DROP CONSTRAINT cdoctype_treplenish
;

-- Sep 10, 2019, 11:55:57 AM CEST
ALTER TABLE T_Replenish ADD CONSTRAINT cdoctype_treplenish FOREIGN KEY (C_DocType_ID) REFERENCES c_doctype(c_doctype_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:56:07 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:56:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14100
;

-- Sep 10, 2019, 11:56:08 AM CEST
INSERT INTO t_alter_column values('t_replenish','M_WarehouseSource_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:56:08 AM CEST
ALTER TABLE T_Replenish DROP CONSTRAINT mwarehousesource_treplenish
;

-- Sep 10, 2019, 11:56:08 AM CEST
ALTER TABLE T_Replenish ADD CONSTRAINT mwarehousesource_treplenish FOREIGN KEY (M_WarehouseSource_ID) REFERENCES m_warehouse(m_warehouse_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:56:26 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:56:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8191
;

-- Sep 10, 2019, 11:56:27 AM CEST
INSERT INTO t_alter_column values('t_reportstatement','AD_PInstance_ID','NUMERIC(10)',null,null)
;

-- Sep 10, 2019, 11:56:27 AM CEST
ALTER TABLE T_ReportStatement DROP CONSTRAINT adpinstance_treportstatement
;

-- Sep 10, 2019, 11:56:27 AM CEST
ALTER TABLE T_ReportStatement ADD CONSTRAINT adpinstance_treportstatement FOREIGN KEY (AD_PInstance_ID) REFERENCES ad_pinstance(ad_pinstance_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:56:44 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:56:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13370
;

-- Sep 10, 2019, 11:56:45 AM CEST
INSERT INTO t_alter_column values('t_transaction','C_ProjectIssue_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:56:45 AM CEST
ALTER TABLE T_Transaction DROP CONSTRAINT cprojectissue_ttransaction
;

-- Sep 10, 2019, 11:56:45 AM CEST
ALTER TABLE T_Transaction ADD CONSTRAINT cprojectissue_ttransaction FOREIGN KEY (C_ProjectIssue_ID) REFERENCES c_projectissue(c_projectissue_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:56:56 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:56:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13247
;

-- Sep 10, 2019, 11:56:57 AM CEST
INSERT INTO t_alter_column values('t_transaction','M_AttributeSetInstance_ID','NUMERIC(10)',null,null)
;

-- Sep 10, 2019, 11:56:57 AM CEST
ALTER TABLE T_Transaction DROP CONSTRAINT masi_ttransaction
;

-- Sep 10, 2019, 11:56:57 AM CEST
ALTER TABLE T_Transaction ADD CONSTRAINT masi_ttransaction FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:57:06 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:57:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13250
;

-- Sep 10, 2019, 11:57:07 AM CEST
INSERT INTO t_alter_column values('t_transaction','M_InOutLine_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:57:07 AM CEST
ALTER TABLE T_Transaction DROP CONSTRAINT minoutline_ttransaction
;

-- Sep 10, 2019, 11:57:07 AM CEST
ALTER TABLE T_Transaction ADD CONSTRAINT minoutline_ttransaction FOREIGN KEY (M_InOutLine_ID) REFERENCES m_inoutline(m_inoutline_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:57:15 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:57:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13256
;

-- Sep 10, 2019, 11:57:16 AM CEST
INSERT INTO t_alter_column values('t_transaction','M_InventoryLine_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:57:16 AM CEST
ALTER TABLE T_Transaction DROP CONSTRAINT minventoryline_ttransaction
;

-- Sep 10, 2019, 11:57:16 AM CEST
ALTER TABLE T_Transaction ADD CONSTRAINT minventoryline_ttransaction FOREIGN KEY (M_InventoryLine_ID) REFERENCES m_inventoryline(m_inventoryline_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:57:23 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:57:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13268
;

-- Sep 10, 2019, 11:57:24 AM CEST
INSERT INTO t_alter_column values('t_transaction','M_Locator_ID','NUMERIC(10)',null,null)
;

-- Sep 10, 2019, 11:57:24 AM CEST
ALTER TABLE T_Transaction DROP CONSTRAINT mlocator_ttransaction
;

-- Sep 10, 2019, 11:57:24 AM CEST
ALTER TABLE T_Transaction ADD CONSTRAINT mlocator_ttransaction FOREIGN KEY (M_Locator_ID) REFERENCES m_locator(m_locator_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:57:32 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:57:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13254
;

-- Sep 10, 2019, 11:57:33 AM CEST
INSERT INTO t_alter_column values('t_transaction','M_MovementLine_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:57:33 AM CEST
ALTER TABLE T_Transaction DROP CONSTRAINT mmovementline_ttransaction
;

-- Sep 10, 2019, 11:57:33 AM CEST
ALTER TABLE T_Transaction ADD CONSTRAINT mmovementline_ttransaction FOREIGN KEY (M_MovementLine_ID) REFERENCES m_movementline(m_movementline_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:57:41 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:57:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13269
;

-- Sep 10, 2019, 11:57:43 AM CEST
INSERT INTO t_alter_column values('t_transaction','M_Product_ID','NUMERIC(10)',null,null)
;

-- Sep 10, 2019, 11:57:43 AM CEST
ALTER TABLE T_Transaction DROP CONSTRAINT mproduct_ttransaction
;

-- Sep 10, 2019, 11:57:43 AM CEST
ALTER TABLE T_Transaction ADD CONSTRAINT mproduct_ttransaction FOREIGN KEY (M_Product_ID) REFERENCES m_product(m_product_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 10, 2019, 11:57:50 AM CEST
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2019-09-10 11:57:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13368
;

-- Sep 10, 2019, 11:57:51 AM CEST
INSERT INTO t_alter_column values('t_transaction','M_ProductionLine_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 10, 2019, 11:57:51 AM CEST
ALTER TABLE T_Transaction DROP CONSTRAINT mproductionline_ttransaction
;

-- Sep 10, 2019, 11:57:51 AM CEST
ALTER TABLE T_Transaction ADD CONSTRAINT mproductionline_ttransaction FOREIGN KEY (M_ProductionLine_ID) REFERENCES m_productionline(m_productionline_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201909101158_IDEMPIERE-4046.sql') FROM dual
;

