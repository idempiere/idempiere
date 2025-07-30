-- Typo on name QtyRequiered in PP_ related tables
SELECT register_migration_script('202507172039_IDEMPIERE-6627.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_Element SET ColumnName='QtyRequired',Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53288
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_Column SET ColumnName='QtyRequired', Name='Qty Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53288
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_Process_Para SET ColumnName='QtyRequired', Name='Qty Required', Description=NULL, Help=NULL, AD_Element_ID=53288 WHERE UPPER(ColumnName)='QTYREQUIRED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jul 17, 2025, 5:14:16 PM IST
UPDATE AD_Process_Para SET ColumnName='QtyRequired', Name='Qty Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53288 AND IsCentrallyMaintained='Y'
;

-- Jul 17, 2025, 8:39:48 PM IST
ALTER TABLE PP_Order_Node RENAME COLUMN QtyRequiered TO QtyRequired
; 

-- Jul 17, 2025, 8:39:48 PM IST
ALTER TABLE PP_Order_BOMLine RENAME COLUMN QtyRequiered TO QtyRequired
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_InfoColumn SET ColumnName='QtyRequired', Name='Qty Required', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53288 AND IsCentrallyMaintained='Y'
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_ViewColumn SET ColumnSQL='round(obl.qtyrequired, 4)', ColumnName='QtyRequired', Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_ViewColumn_ID=215675
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_ViewColumn SET ColumnSQL='CASE WHEN o.qtybatchs = 0 THEN 1 ELSE round(obl.qtyrequired / o.qtybatchs, 4) END', Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_ViewColumn_ID=215683
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_ViewColumn SET ColumnSQL='round(obl.qtyrequired, 4)',  ColumnName='QtyRequired', Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_ViewColumn_ID=215722
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_ViewColumn SET ColumnSQL='CASE WHEN o.qtybatchs = 0 THEN 1 ELSE round(obl.qtyrequired / o.qtybatchs, 4) END', Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_ViewColumn_ID=215723
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_ViewColumn SET ColumnSQL='round(obl.qtyrequired, 4)', ColumnName='QtyRequired', Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_ViewColumn_ID=212308
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_ViewColumn SET ColumnSQL='CASE WHEN o.qtybatchs = 0 THEN 1 ELSE round(obl.qtyrequired / o.qtybatchs, 4) END', Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_ViewColumn_ID=212315
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_ViewColumn SET ColumnSQL='onode.qtyrequired', ColumnName='QtyRequired', Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_ViewColumn_ID=212525
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_ViewColumn SET ColumnSQL='onode.qtyrequired', ColumnName='QtyRequired', Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_ViewColumn_ID=212569
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_ViewColumn SET ColumnSQL='round(obl.qtyrequired, 4)', ColumnName='QtyRequired',Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=212354
;

-- Jul 17, 2025, 8:39:48 PM IST
UPDATE AD_ViewColumn SET ColumnSQL='CASE WHEN o.qtybatchs = 0 THEN 1 ELSE round(obl.qtyrequired / o.qtybatchs, 4) END', Updated=TO_TIMESTAMP('2025-07-17 17:14:16','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_ViewColumn_ID=212361

;

-- Jul 17, 2025, 8:39:48 PM IST
DROP VIEW IF EXISTS RV_PP_Order_BOMLine
;

-- Jul 17, 2025, 8:39:48 PM IST
DROP VIEW IF EXISTS RV_PP_Order_Receipt_Issue
;

-- Jul 17, 2025, 8:39:48 PM IST
DROP VIEW IF EXISTS RV_PP_Order_Storage
;

-- Jul 17, 2025, 8:39:48 PM IST
DROP VIEW IF EXISTS PP_Order_BOMLine_v
;

-- Jul 17, 2025, 8:39:48 PM IST
DROP VIEW IF EXISTS PP_Order_BOMLine_vt
;

-- Jul 17, 2025, 8:39:48 PM IST
DROP VIEW IF EXISTS PP_Order_Node_v
;

-- Jul 17, 2025, 8:39:48 PM IST
DROP VIEW IF EXISTS PP_Order_Node_vt
;

-- Jul 17, 2025, 8:39:48 PM IST
CREATE OR REPLACE VIEW RV_PP_Order_BOMLine(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Updated, Created, IsActive, PP_Order_BOM_ID, PP_Order_BOMLine_ID, PP_Order_ID, IsCritical, ComponentType, M_Product_ID, C_UOM_ID, QtyRequired, QtyReserved, QtyAvailable, QtyOnHand, M_Warehouse_ID, QtyBOM, IsQtyPercentage, QtyBatch, QtyBatchSize) AS SELECT obl.ad_client_id AS AD_Client_ID, obl.ad_org_id AS AD_Org_ID, obl.createdby AS CreatedBy, obl.updatedby AS UpdatedBy, obl.updated AS Updated, obl.created AS Created, obl.isactive AS IsActive, obl.pp_order_bom_id AS PP_Order_BOM_ID, obl.pp_order_bomline_id AS PP_Order_BOMLine_ID, obl.pp_order_id AS PP_Order_ID, obl.iscritical AS IsCritical, obl.componenttype AS ComponentType, obl.m_product_id AS M_Product_ID, obl.c_uom_id AS C_UOM_ID, round(obl.qtyrequired, 4) AS QtyRequired, round(bomqtyreserved(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyReserved, round(bomqtyavailable(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyAvailable, round(bomqtyonhand(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyOnHand, obl.m_warehouse_id AS M_Warehouse_ID, round(obl.qtybom, 4) AS QtyBOM, obl.isqtypercentage AS IsQtyPercentage, round(obl.qtybatch, 4) AS QtyBatch, CASE WHEN o.qtybatchs = 0 THEN 1 ELSE round(obl.qtyrequired / o.qtybatchs, 4) END AS QtyBatchSize FROM pp_order_bomline obl JOIN pp_order o ON o.pp_order_id = obl.pp_order_id
;

-- Jul 17, 2025, 8:39:48 PM IST
CREATE OR REPLACE VIEW RV_PP_Order_Storage(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Updated, Created, IsActive, PP_Order_BOM_ID, PP_Order_BOMLine_ID, PP_Order_ID, IsCritical, M_Product_ID, Name, C_UOM_ID, QtyOnHand, QtyRequired, QtyBatchSize, QtyReserved, QtyAvailable, M_Warehouse_ID, QtyBOM, IsQtyPercentage, QtyBatch, M_AttributeSetInstance_ID, M_Locator_ID, X, Y, Z) AS SELECT obl.ad_client_id AS AD_Client_ID, obl.ad_org_id AS AD_Org_ID, obl.createdby AS CreatedBy, obl.updatedby AS UpdatedBy, obl.updated AS Updated, obl.created AS Created, obl.isactive AS IsActive, obl.pp_order_bom_id AS PP_Order_BOM_ID, obl.pp_order_bomline_id AS PP_Order_BOMLine_ID, obl.pp_order_id AS PP_Order_ID, obl.iscritical AS IsCritical, obl.m_product_id AS M_Product_ID, ( SELECT p.name FROM m_product p WHERE p.m_product_id = o.m_product_id) AS Name, obl.c_uom_id AS C_UOM_ID, s.qtyonhand AS QtyOnHand, round(obl.qtyrequired, 4) AS QtyRequired, CASE WHEN o.qtybatchs = 0 THEN 1 ELSE round(obl.qtyrequired / o.qtybatchs, 4) END AS QtyBatchSize, round(bomqtyreserved(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyReserved, round(bomqtyavailable(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyAvailable, obl.m_warehouse_id AS M_Warehouse_ID, obl.qtybom AS QtyBOM, obl.isqtypercentage AS IsQtyPercentage, round(obl.qtybatch, 4) AS QtyBatch, obl.m_attributesetinstance_id AS M_AttributeSetInstance_ID, l.m_locator_id AS M_Locator_ID, l.x AS X, l.y AS Y, l.z AS Z FROM pp_order_bomline obl JOIN pp_order o ON o.pp_order_id = obl.pp_order_id LEFT JOIN m_storage s ON s.m_product_id = obl.m_product_id AND s.qtyonhand <> 0 AND obl.m_warehouse_id = (SELECT ld.m_warehouse_id FROM m_locator ld WHERE s.m_locator_id = ld.m_locator_id) LEFT JOIN m_locator l ON l.m_locator_id = s.m_locator_id ORDER BY obl.m_product_id
;

-- Jul 17, 2025, 8:39:48 PM IST
CREATE OR REPLACE VIEW PP_Order_BOMLine_v(AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, AD_Language, Description, Feature, M_Product_ID, BackflushGroup, C_UOM_ID, ComponentType, DateDelivered, Forecast, Help, IsCritical, IssueMethod, LeadTimeOffset, Line, M_AttributeSetInstance_ID, M_ChangeNotice_ID, M_Locator_ID, M_Warehouse_ID, PP_Order_BOM_ID, PP_Order_BOMLine_ID, PP_Order_ID, QtyDelivered, QtyPost, QtyReject, QtyScrap, Scrap, ValidFrom, ValidTo, Assay, AD_User_ID, QtyRequired, QtyReserved, QtyAvailable, QtyOnHand, QtyBOM, IsQtyPercentage, QtyBatch, QtyBatchSize) AS SELECT obl.ad_client_id AS AD_Client_ID, obl.ad_org_id AS AD_Org_ID, obl.isactive AS IsActive, obl.created AS Created, obl.createdby AS CreatedBy, obl.updated AS Updated, obl.updatedby AS UpdatedBy, CAST('en_US' AS CHARACTER VARYING(6)) AS AD_Language, obl.description AS Description, obl.feature AS Feature, obl.m_product_id AS M_Product_ID, obl.backflushgroup AS BackflushGroup, obl.c_uom_id AS C_UOM_ID, obl.componenttype AS ComponentType, obl.datedelivered AS DateDelivered, obl.forecast AS Forecast, obl.help AS Help, obl.iscritical AS IsCritical, obl.issuemethod AS IssueMethod, obl.leadtimeoffset AS LeadTimeOffset, obl.line AS Line, obl.m_attributesetinstance_id AS M_AttributeSetInstance_ID, obl.m_changenotice_id AS M_ChangeNotice_ID, obl.m_locator_id AS M_Locator_ID, obl.m_warehouse_id AS M_Warehouse_ID, obl.pp_order_bom_id AS PP_Order_BOM_ID, obl.pp_order_bomline_id AS PP_Order_BOMLine_ID, obl.pp_order_id AS PP_Order_ID, obl.qtydelivered AS QtyDelivered, obl.qtypost AS QtyPost, obl.qtyreject AS QtyReject, obl.qtyscrap AS QtyScrap, obl.scrap AS Scrap, obl.validfrom AS ValidFrom, obl.validto AS ValidTo, obl.assay AS Assay, obl.ad_user_id AS AD_User_ID, round(obl.qtyrequired, 4) AS QtyRequired, round(bomqtyreserved(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyReserved, round(bomqtyavailable(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyAvailable, round(bomqtyonhand(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyOnHand, round(obl.qtybom, 4) AS QtyBOM, obl.isqtypercentage AS IsQtyPercentage, round(obl.qtybatch, 4) AS QtyBatch, CASE WHEN o.qtybatchs = 0 THEN 1 ELSE round(obl.qtyrequired / o.qtybatchs, 4) END AS QtyBatchSize FROM pp_order_bomline obl JOIN pp_order o ON o.pp_order_id = obl.pp_order_id
;

-- Jul 17, 2025, 8:39:49 PM IST
CREATE OR REPLACE VIEW PP_Order_BOMLine_vt(AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, AD_Language, Description, Feature, M_Product_ID, BackflushGroup, C_UOM_ID, ComponentType, DateDelivered, Forecast, Help, IsCritical, IssueMethod, LeadTimeOffset, Line, M_AttributeSetInstance_ID, M_ChangeNotice_ID, M_Locator_ID, M_Warehouse_ID, PP_Order_BOM_ID, PP_Order_BOMLine_ID, PP_Order_ID, QtyDelivered, QtyPost, QtyReject, QtyScrap, Scrap, ValidFrom, ValidTo, Assay, AD_User_ID, QtyBatchs, QtyRequired, QtyReserved, QtyAvailable, QtyOnHand, QtyBOM, IsQtyPercentage, QtyBatch, QtyBatchSize) AS SELECT obl.ad_client_id AS AD_Client_ID, obl.ad_org_id AS AD_Org_ID, obl.isactive AS IsActive, obl.created AS Created, obl.createdby AS CreatedBy, obl.updated AS Updated, obl.updatedby AS UpdatedBy, oblt.ad_language AS AD_Language, oblt.description AS Description, obl.feature AS Feature, obl.m_product_id AS M_Product_ID, obl.backflushgroup AS BackflushGroup, obl.c_uom_id AS C_UOM_ID, obl.componenttype AS ComponentType, obl.datedelivered AS DateDelivered, obl.forecast AS Forecast, oblt.help AS Help, obl.iscritical AS IsCritical, obl.issuemethod AS IssueMethod, obl.leadtimeoffset AS LeadTimeOffset, obl.line AS Line, obl.m_attributesetinstance_id AS M_AttributeSetInstance_ID, obl.m_changenotice_id AS M_ChangeNotice_ID, obl.m_locator_id AS M_Locator_ID, obl.m_warehouse_id AS M_Warehouse_ID, obl.pp_order_bom_id AS PP_Order_BOM_ID, obl.pp_order_bomline_id AS PP_Order_BOMLine_ID, obl.pp_order_id AS PP_Order_ID, obl.qtydelivered AS QtyDelivered, obl.qtypost AS QtyPost, obl.qtyreject AS QtyReject, obl.qtyscrap AS QtyScrap, obl.scrap AS Scrap, obl.validfrom AS ValidFrom, obl.validto AS ValidTo, obl.assay AS Assay, obl.ad_user_id AS AD_User_ID, o.qtybatchs AS QtyBatchs, round(obl.qtyrequired, 4) AS QtyRequired, round(bomqtyreserved(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyReserved, round(bomqtyavailable(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyAvailable, round(bomqtyonhand(obl.m_product_id, obl.m_warehouse_id, 0), 4) AS QtyOnHand, round(obl.qtybom, 4) AS QtyBOM, obl.isqtypercentage AS IsQtyPercentage, round(obl.qtybatch, 4) AS QtyBatch, CASE WHEN o.qtybatchs = 0 THEN 1 ELSE round(obl.qtyrequired / o.qtybatchs, 4) END AS QtyBatchSize FROM pp_order_bomline obl JOIN pp_order o ON o.pp_order_id = obl.pp_order_id LEFT JOIN pp_order_bomline_trl oblt ON oblt.pp_order_bomline_id = obl.pp_order_bomline_id
;

-- Jul 17, 2025, 8:39:49 PM IST
CREATE OR REPLACE VIEW PP_Order_Node_v(AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, AD_Language, Name, C_BPartner_ID, Cost, DateFinish, DateFinishSchedule, DateStart, DateStartSchedule, Description, DocAction, DocStatus, Duration, DurationReal, DurationRequiered, Help, IsMilestone, IsSubcontracting, MovingTime, OverlapUnits, PP_Order_ID, PP_Order_Workflow_ID, PP_Order_Node_ID, Priority, QtyDelivered, QtyRequired, QtyScrap, QueuingTime, S_Resource_ID, SetupTime, SetupTimeReal, UnitsCycles, ValidFrom, ValidTo, Value, WaitingTime, WorkingTime, Yield) AS SELECT onode.ad_client_id AS AD_Client_ID, onode.ad_org_id AS AD_Org_ID, onode.isactive AS IsActive, onode.created AS Created, onode.createdby AS CreatedBy, onode.updated AS Updated, onode.updatedby AS UpdatedBy, CAST('en_US' AS CHARACTER VARYING(6)) AS AD_Language, onode.name AS Name, onode.c_bpartner_id AS C_BPartner_ID, onode.cost AS Cost, onode.datefinish AS DateFinish, onode.datefinishschedule AS DateFinishSchedule, onode.datestart AS DateStart, onode.datestartschedule AS DateStartSchedule, onode.description AS Description, onode.docaction AS DocAction, onode.docstatus AS DocStatus, onode.duration AS Duration, onode.durationreal AS DurationReal, onode.durationrequiered AS DurationRequiered, onode.help AS Help, onode.ismilestone AS IsMilestone, onode.issubcontracting AS IsSubcontracting, onode.movingtime AS MovingTime, onode.overlapunits AS OverlapUnits, onode.pp_order_id AS PP_Order_ID, onode.pp_order_workflow_id AS PP_Order_Workflow_ID, onode.pp_order_node_id AS PP_Order_Node_ID, onode.priority AS Priority, onode.qtydelivered AS QtyDelivered, onode.qtyrequired AS QtyRequired, onode.qtyscrap AS QtyScrap, onode.queuingtime AS QueuingTime, onode.s_resource_id AS S_Resource_ID, onode.setuptime AS SetupTime, onode.setuptimereal AS SetupTimeReal, onode.unitscycles AS UnitsCycles, onode.validfrom AS ValidFrom, onode.validto AS ValidTo, onode.value AS Value, onode.waitingtime AS WaitingTime, onode.workingtime AS WorkingTime, onode.yield AS Yield FROM pp_order_node onode
;

-- Jul 17, 2025, 8:39:49 PM IST
CREATE OR REPLACE VIEW PP_Order_Node_vt(AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, AD_Language, Name, C_BPartner_ID, Cost, DateFinish, DateFinishSchedule, DateStart, DateStartSchedule, Description, DocAction, DocStatus, Duration, DurationReal, DurationRequiered, Help, IsMilestone, IsSubcontracting, MovingTime, OverlapUnits, PP_Order_ID, PP_Order_Workflow_ID, PP_Order_Node_ID, Priority, QtyDelivered, QtyRequired, QtyScrap, QueuingTime, S_Resource_ID, SetupTime, SetupTimeReal, UnitsCycles, ValidFrom, ValidTo, Value, WaitingTime, WorkingTime, Yield) AS SELECT onode.ad_client_id AS AD_Client_ID, onode.ad_org_id AS AD_Org_ID, onode.isactive AS IsActive, onode.created AS Created, onode.createdby AS CreatedBy, onode.updated AS Updated, onode.updatedby AS UpdatedBy, ont.ad_language AS AD_Language, ont.name AS Name, onode.c_bpartner_id AS C_BPartner_ID, onode.cost AS Cost, onode.datefinish AS DateFinish, onode.datefinishschedule AS DateFinishSchedule, onode.datestart AS DateStart, onode.datestartschedule AS DateStartSchedule, ont.description AS Description, onode.docaction AS DocAction, onode.docstatus AS DocStatus, onode.duration AS Duration, onode.durationreal AS DurationReal, onode.durationrequiered AS DurationRequiered, ont.help AS Help, onode.ismilestone AS IsMilestone, onode.issubcontracting AS IsSubcontracting, onode.movingtime AS MovingTime, onode.overlapunits AS OverlapUnits, onode.pp_order_id AS PP_Order_ID, onode.pp_order_workflow_id AS PP_Order_Workflow_ID, onode.pp_order_node_id AS PP_Order_Node_ID, onode.priority AS Priority, onode.qtydelivered AS QtyDelivered, onode.qtyrequired AS QtyRequired, onode.qtyscrap AS QtyScrap, onode.queuingtime AS QueuingTime, onode.s_resource_id AS S_Resource_ID, onode.setuptime AS SetupTime, onode.setuptimereal AS SetupTimeReal, onode.unitscycles AS UnitsCycles, onode.validfrom AS ValidFrom, onode.validto AS ValidTo, onode.value AS Value, onode.waitingtime AS WaitingTime, onode.workingtime AS WorkingTime, onode.yield AS Yield FROM pp_order_node onode LEFT JOIN pp_order_node_trl ont ON ont.pp_order_node_id = onode.pp_order_node_id
;

-- Jul 17, 2025, 8:39:49 PM IST
CREATE OR REPLACE VIEW rv_pp_order_receipt_issue AS SELECT obl.pp_order_bomline_id, obl.iscritical, p.value, obl.m_product_id, mos.name AS productname, mos.m_attributesetinstance_id, asi.description AS instancename, mos.c_uom_id, u.name AS uomname, obl.qtyrequired AS qtyrequired, obl.qtyreserved AS qtyreserved_order, mos.qtyonhand, mos.qtyreserved AS qtyreserved_storage, mos.qtyavailable, mos.m_locator_id, mos.m_warehouse_id, w.name AS warehousename, mos.qtybom, mos.isqtypercentage, mos.qtybatch, obl.componenttype, mos.qtyrequired - obl.qtydelivered AS qtyopen, obl.pp_order_id FROM adempiere.rv_pp_order_storage mos JOIN adempiere.pp_order_bomline obl ON mos.pp_order_bomline_id = obl.pp_order_bomline_id JOIN adempiere.m_attributesetinstance asi ON mos.m_attributesetinstance_id = asi.m_attributesetinstance_id JOIN adempiere.c_uom u ON mos.c_uom_id = u.c_uom_id JOIN adempiere.m_product p ON mos.m_product_id = p.m_product_id JOIN adempiere.m_warehouse w ON mos.m_warehouse_id = w.m_warehouse_id
;

