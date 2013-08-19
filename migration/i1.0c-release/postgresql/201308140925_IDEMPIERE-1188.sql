-- Jul 22, 2013 8:56:39 PM MYT
-- IDEMPIERE-1188 Invoice Price Variance for Average PO Costing
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',1,808,210662,'N','N','N',0,'N',22,'N',30,'N','N','Y','c5983338-dac3-4173-ac05-81bc1bdb1ce7','N','M_MatchInv_ID','Match Shipment/Receipt to Invoice','Match Invoice','N',TO_TIMESTAMP('2013-07-22 20:56:37','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-22 20:56:37','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1689)
;

-- Jul 22, 2013 8:56:39 PM MYT
-- IDEMPIERE-1188 Invoice Price Variance for Average PO Costing
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210662 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 22, 2013 8:56:45 PM MYT
-- IDEMPIERE-1188 Invoice Price Variance for Average PO Costing
ALTER TABLE M_CostDetail ADD COLUMN M_MatchInv_ID NUMERIC(10) DEFAULT NULL 
;

DROP VIEW m_costmovement_v;

CREATE VIEW m_costmovement_v AS 
SELECT a.ad_client_id, a.ad_org_id, b.c_acctschema_id, a.m_costhistory_id, a.m_costtype_id, a.m_costelement_id, a.m_attributesetinstance_id, 
   b.m_product_id, a.oldqty, a.newqty, a.oldcostprice, a.newcostprice, a.oldcqty, a.newcqty, a.oldcamt, a.newcamt, b.qty, b.amt, b.deltaqty, 
   b.deltaamt, b.c_orderline_id, b.m_inoutline_id, b.c_invoiceline_id, b.m_movementline_id, b.m_inventoryline_id, b.m_productionline_id, 
   b.c_projectissue_id, b.m_matchinv_id, a.m_costdetail_id, b.description, a.created, a.createdby, a.updated, a.updatedby, a.isactive
   FROM m_costhistory a
   JOIN m_costdetail b ON a.m_costdetail_id = b.m_costdetail_id
   ORDER BY a.m_costhistory_id
;



-- Jul 23, 2013 7:55:31 AM MYT
-- IDEMPIERE-1188 Invoice Price Variance for Average PO Costing
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',1,200002,210663,'N','N','N',0,'N',22,'N',30,'N','N','Y','10f7d192-2c18-497c-bcf3-548f8546fd41','N','M_MatchInv_ID','Match Shipment/Receipt to Invoice','Match Invoice','N',TO_TIMESTAMP('2013-07-23 07:55:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-23 07:55:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1689)
;

-- Jul 23, 2013 7:55:31 AM MYT
-- IDEMPIERE-1188 Invoice Price Variance for Average PO Costing
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210663 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2013 7:56:36 AM MYT
-- IDEMPIERE-1188 Invoice Price Variance for Average PO Costing
INSERT INTO AD_Field (NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan) VALUES (1,0,'N',200000,0,'N','N',210663,270,'Y',202340,'N','D','Match Shipment/Receipt to Invoice','Match Invoice','Y','N','624749f1-6544-45d7-a6b7-cebc6bcdfc93',100,0,TO_TIMESTAMP('2013-07-23 07:56:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-23 07:56:34','YYYY-MM-DD HH24:MI:SS'),'Y','Y',270,1,'N',0,1)
;

-- Jul 23, 2013 7:56:36 AM MYT
-- IDEMPIERE-1188 Invoice Price Variance for Average PO Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202340 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2013 7:57:03 AM MYT
-- IDEMPIERE-1188 Invoice Price Variance for Average PO Costing
UPDATE AD_Field SET SeqNo=270, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-07-23 07:57:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202340
;

SELECT register_migration_script('201308140925_IDEMPIERE-1188.sql') FROM dual
;

