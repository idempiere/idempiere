-- IDEMPIERE-7010 - Support UOM and QtyEntered on Inventory documents
SELECT register_migration_script('202605191839_IDEMPIERE-7010.sql') FROM dual;

-- May 19, 2026, 6:39:50 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217575,0,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',322,210,'C_UOM_ID','@#C_UOM_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-05-19 18:39:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-19 18:39:50','YYYY-MM-DD HH24:MI:SS'),100,215,'Y','N','D','N','N','N','Y','019e411b-a282-732d-8a4f-aa72aeab7f76','Y',0,'N','N','N','N','N')
;

-- May 19, 2026, 6:40:12 PM CEST
UPDATE AD_Column SET FKConstraintName='CUOM_MInventoryLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-19 18:40:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217575
;

-- May 19, 2026, 6:40:12 PM CEST
ALTER TABLE M_InventoryLine ADD COLUMN C_UOM_ID NUMERIC(10) DEFAULT NULL 
;

-- May 19, 2026, 6:40:12 PM CEST
UPDATE M_InventoryLine SET C_UOM_ID = (select c_uom_id from m_product where m_product_id=M_InventoryLine.m_product_id)
;

-- May 19, 2026, 6:40:12 PM CEST
ALTER TABLE M_InventoryLine ADD CONSTRAINT CUOM_MInventoryLine FOREIGN KEY (C_UOM_ID) REFERENCES c_uom(c_uom_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 19, 2026, 6:40:30 PM CEST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2026-05-19 18:40:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217575
;

-- May 19, 2026, 6:40:33 PM CEST
INSERT INTO t_alter_column values('m_inventoryline','C_UOM_ID','NUMERIC(10)',null,null)
;

-- May 19, 2026, 6:40:33 PM CEST
INSERT INTO t_alter_column values('m_inventoryline','C_UOM_ID',null,'NOT NULL',null)
;

-- May 19, 2026, 6:41:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217576,0,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',322,'QtyEntered','0',22,'N','N','Y','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2026-05-19 18:41:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-19 18:41:32','YYYY-MM-DD HH24:MI:SS'),100,2589,'Y','N','D','N','N','N','Y','019e411d-2f8a-723b-bbf9-3cfaf5a641bb','Y',0,'N','N','N','N')
;

-- May 19, 2026, 6:41:35 PM CEST
ALTER TABLE M_InventoryLine ADD COLUMN QtyEntered NUMERIC DEFAULT '0' NOT NULL
;

-- May 19, 2026, 6:41:35 PM CEST
UPDATE M_InventoryLine SET QtyEntered = QtyCount WHERE EXISTS (
    SELECT 1
    FROM M_Inventory i
    JOIN C_DocType dt ON dt.C_DocType_ID = i.C_DocType_ID
    WHERE i.M_Inventory_ID = M_InventoryLine.M_Inventory_ID
      AND dt.DocSubTypeInv = 'PI'
)
AND M_InventoryLine.QtyEntered = 0
;

-- May 19, 2026, 6:41:35 PM CEST
UPDATE M_InventoryLine SET QtyEntered = QtyInternalUse WHERE EXISTS (
    SELECT 1
    FROM M_Inventory i
    JOIN C_DocType dt ON dt.C_DocType_ID = i.C_DocType_ID
    WHERE i.M_Inventory_ID = M_InventoryLine.M_Inventory_ID
      AND dt.DocSubTypeInv = 'IU'
)
AND M_InventoryLine.QtyEntered = 0
;

-- May 19, 2026, 6:41:49 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209179,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',256,217575,'Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-19 18:41:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-19 18:41:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019e411d-7185-7bb6-8162-a6dadaee33fb','Y',130,2)
;

-- May 19, 2026, 6:41:49 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209180,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',256,217576,'Y',22,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-19 18:41:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-19 18:41:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019e411d-7283-71ee-a69c-62a60f51eefb','Y',140,2)
;

-- May 19, 2026, 6:42:08 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=1,Updated=TO_TIMESTAMP('2026-05-19 18:42:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209180
;

-- May 19, 2026, 6:42:08 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=4,Updated=TO_TIMESTAMP('2026-05-19 18:42:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209179
;

-- May 19, 2026, 6:42:08 PM CEST
UPDATE AD_Field SET SeqNo=100, IsReadOnly='Y',Updated=TO_TIMESTAMP('2026-05-19 18:42:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2699
;

-- May 19, 2026, 6:42:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209181,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',683,217575,'Y',22,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-19 18:42:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-19 18:42:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019e411d-ff14-740a-81e0-4ca7d3509979','Y',110,2)
;

-- May 19, 2026, 6:42:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209182,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',683,217576,'Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-19 18:42:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-19 18:42:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019e411e-010e-7bf9-9d75-b622c9b82e62','Y',120,2)
;

-- May 19, 2026, 6:42:39 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=1,Updated=TO_TIMESTAMP('2026-05-19 18:42:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209182
;

-- May 19, 2026, 6:42:39 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4,Updated=TO_TIMESTAMP('2026-05-19 18:42:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209181
;

-- May 19, 2026, 6:42:39 PM CEST
UPDATE AD_Field SET SeqNo=110, IsReadOnly='Y',Updated=TO_TIMESTAMP('2026-05-19 18:42:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10998
;

-- May 19, 2026, 7:06:11 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutInventory.qty',Updated=TO_TIMESTAMP('2026-05-19 19:06:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217575
;

-- May 19, 2026, 7:06:18 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutInventory.qty',Updated=TO_TIMESTAMP('2026-05-19 19:06:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217576
;

