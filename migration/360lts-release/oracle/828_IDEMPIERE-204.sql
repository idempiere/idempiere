CREATE OR REPLACE VIEW RV_M_REQUISITION
(M_REQUISITION_ID, AD_CLIENT_ID, AD_ORG_ID, ISACTIVE, CREATED, 
 CREATEDBY, UPDATED, UPDATEDBY, DOCUMENTNO, DESCRIPTION, 
 HELP, AD_USER_ID, M_PRICELIST_ID, M_WAREHOUSE_ID, ISAPPROVED, 
 PRIORITYRULE, DATEREQUIRED, TOTALLINES, DOCACTION, DOCSTATUS, 
 PROCESSED, M_REQUISITIONLINE_ID, LINE, QTY, QTYORDERED,
 M_PRODUCT_ID, LINEDESCRIPTION, PRICEACTUAL, LINENETAMT, C_CHARGE_ID)
AS 
SELECT r.M_Requisition_ID,
    r.AD_Client_ID, r.AD_Org_ID, r.IsActive, r.Created, r.CreatedBy, r.Updated, r.UpdatedBy,
    r.DocumentNo, r.Description, r.Help,
    r.AD_User_ID, r.M_PriceList_ID, r.M_Warehouse_ID, r.IsApproved, r.PriorityRule,
    r.DateRequired, r.TotalLines, r.DocAction, r.DocStatus, r.Processed,
    l.M_RequisitionLine_ID, l.Line,
    l.Qty,
	(CASE WHEN l.C_OrderLine_ID IS NOT NULL THEN l.Qty ELSE 0 END) AS QtyOrdered,
	l.M_Product_ID,
    l.Description AS LineDescription,
    l.PriceActual, l.LineNetAmt, l.C_Charge_ID
FROM M_Requisition r
  INNER JOIN M_RequisitionLine l ON (r.M_Requisition_ID=l.M_Requisition_ID);


-- Mar 22, 2012 9:47:24 AM COT
-- IDEMPIERE-204 Add charge to Open Requisitions report
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200082,711,'U',0,'N','N','N','The Charge indicates a type of Charge (Handling, Shipping, Restocking)','N',10,'N',19,'N',968,'N','N','N','C_Charge_ID','Additional document charges','Charge',100,TO_DATE('2012-03-22 09:47:22','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-22 09:47:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 22, 2012 9:47:24 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200082 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 22, 2012 9:47:47 AM COT
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-03-22 09:47:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200082
;

UPDATE AD_System
  SET LastMigrationScriptApplied='828_IDEMPIERE-204.sql'
WHERE LastMigrationScriptApplied<'828_IDEMPIERE-204.sql'
   OR LastMigrationScriptApplied IS NULL
;
