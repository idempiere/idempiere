-- IDEMPIERE-4925 - Adding column for UOM and QtyEntered on inventory documents
SELECT register_migration_script('202501091801_IDEMPIERE-4925.sql') FROM dual;

-- Jan 9, 2025, 6:01:19 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217029,0,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',324,'QtyEntered','1',22,'N','N','Y','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2025-01-09 18:01:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-09 18:01:18','YYYY-MM-DD HH24:MI:SS'),100,2589,'Y','N','D','N','N','N','Y','093ccbe2-a73e-4ac8-aa75-47e4a6f35d38','Y',0,'N','N','N','N')
;

-- Jan 9, 2025, 6:04:24 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217031,0,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',324,210,'C_UOM_ID','@#C_UOM_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-01-09 18:04:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-09 18:04:23','YYYY-MM-DD HH24:MI:SS'),100,215,'Y','N','D','N','N','N','Y','0d7ae178-c716-4750-b758-c21299c3c941','Y',0,'N','N','N','N','N')
;

-- Jan 9, 2025, 6:06:48 PM CET
ALTER TABLE M_MovementLine ADD COLUMN QtyEntered NUMERIC DEFAULT '1' NOT NULL
;

-- Jan 9, 2025, 6:06:48 PM CET
UPDATE AD_Column SET FKConstraintName='CUOM_MMovementLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-01-09 18:06:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217031
;

-- Jan 9, 2025, 6:06:48 PM CET
ALTER TABLE M_MovementLine ADD COLUMN C_UOM_ID NUMERIC(10) DEFAULT NULL 
;

UPDATE M_MovementLine SET C_UOM_ID = (select c_uom_id from m_product where m_product_id=m_movementline.m_product_id)
;

UPDATE M_MovementLine SET QtyEntered = MovementQty
;

-- Jan 9, 2025, 6:15:48 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2025-01-10 12:25:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217031
;

-- Jan 9, 2025, 6:15:48 PM CET
INSERT INTO t_alter_column values('m_movementline','C_UOM_ID','NUMERIC(10)',null,null)
;

-- Jan 9, 2025, 6:15:48 PM CET
INSERT INTO t_alter_column values('m_movementline','C_UOM_ID',null,'NOT NULL',null)
;

-- Jan 9, 2025, 6:15:20 PM CET
ALTER TABLE M_MovementLine ADD CONSTRAINT CUOM_MMovementLine FOREIGN KEY (C_UOM_ID) REFERENCES c_uom(c_uom_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 10, 2025, 12:33:41 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208688,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',256,217030,'Y',22,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-01-10 12:33:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-10 12:33:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ff291c45-8b59-403b-b0c8-0e1e2a05a5b5','Y',130,2)
;

-- Jan 10, 2025, 12:33:41 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208689,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',256,217032,'Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-01-10 12:33:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-10 12:33:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1333d835-9f4f-4f63-8fe2-69b9bc713b0b','Y',140,2)
;

-- Jan 10, 2025, 12:33:54 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=1,Updated=TO_TIMESTAMP('2025-01-10 12:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208688
;

-- Jan 10, 2025, 12:33:54 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=4,Updated=TO_TIMESTAMP('2025-01-10 12:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208689
;

-- Jan 10, 2025, 12:33:54 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2025-01-10 12:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2699
;

-- Jan 10, 2025, 12:33:54 PM CET
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2025-01-10 12:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2698
;

-- Jan 10, 2025, 12:33:54 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2025-01-10 12:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2692
;

-- Jan 10, 2025, 12:33:54 PM CET
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2025-01-10 12:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8290
;

-- Jan 10, 2025, 12:33:54 PM CET
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2025-01-10 12:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8289
;

-- Jan 10, 2025, 12:33:54 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-01-10 12:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204914
;

-- Jan 10, 2025, 12:34:10 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2025-01-10 12:34:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2699
;

-- Jan 10, 2025, 12:34:51 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208690,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',683,217030,'Y',22,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-01-10 12:34:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-10 12:34:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','28016e93-1d7c-4b28-8e39-15fcf997b887','Y',110,2)
;

-- Jan 10, 2025, 12:34:52 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208691,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',683,217032,'Y',22,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-01-10 12:34:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-10 12:34:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e08bec64-b26f-4f29-a5c0-59bdb0132640','Y',120,2)
;

-- Jan 10, 2025, 12:35:16 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=1,Updated=TO_TIMESTAMP('2025-01-10 12:35:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208690
;

-- Jan 10, 2025, 12:35:16 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4,Updated=TO_TIMESTAMP('2025-01-10 12:35:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208691
;

-- Jan 10, 2025, 12:35:16 PM CET
UPDATE AD_Field SET SeqNo=110, IsReadOnly='Y',Updated=TO_TIMESTAMP('2025-01-10 12:35:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10998
;

-- Jan 10, 2025, 12:35:16 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2025-01-10 12:35:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10997
;

-- Jan 10, 2025, 12:35:16 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-01-10 12:35:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204913
;

-- Jan 10, 2025, 12:36:23 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208692,'Quantity','The Quantity Entered is based on the selected UoM','The Quantity Entered is converted to base product UoM quantity',260,217029,'Y',22,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-01-10 12:36:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-10 12:36:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','462ed343-2ba0-44a9-a862-d305fb3bf81e','Y',170,2)
;

-- Jan 10, 2025, 12:36:23 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208693,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',260,217031,'Y',22,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-01-10 12:36:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-10 12:36:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','da5f32dc-33fa-4f63-8727-84ef9f236f1d','Y',180,2)
;

-- Jan 10, 2025, 12:37:18 PM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2025-01-10 12:37:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2731
;

-- Jan 10, 2025, 12:37:18 PM CET
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2025-01-10 12:37:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2732
;

-- Jan 10, 2025, 12:37:18 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_FieldGroup_ID=102, XPosition=1,Updated=TO_TIMESTAMP('2025-01-10 12:37:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208692
;

-- Jan 10, 2025, 12:37:18 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_FieldGroup_ID=102, XPosition=4,Updated=TO_TIMESTAMP('2025-01-10 12:37:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208693
;

-- Jan 10, 2025, 12:37:18 PM CET
UPDATE AD_Field SET SeqNo=150, IsReadOnly='Y',Updated=TO_TIMESTAMP('2025-01-10 12:37:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2738
;

-- Jan 10, 2025, 12:37:18 PM CET
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2025-01-10 12:37:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9226
;

-- Jan 10, 2025, 12:37:18 PM CET
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2025-01-10 12:37:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9227
;

-- Jan 10, 2025, 12:37:18 PM CET
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2025-01-10 12:37:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9225
;

-- Jan 10, 2025, 12:37:18 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-01-10 12:37:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204930
;

-- Jan 10, 2025, 3:38:25 PM CET
UPDATE AD_Column SET Callout='org.compiere.model.CalloutMovement.qtyEntered',Updated=TO_TIMESTAMP('2025-01-10 15:38:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217029
;

-- Jan 10, 2025, 3:39:13 PM CET
UPDATE AD_Column SET Callout='org.compiere.model.CalloutMovement.qtyEntered; org.compiere.model.CalloutMovement.qty',Updated=TO_TIMESTAMP('2025-01-10 15:39:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217029
;

-- Jan 10, 2025, 3:39:25 PM CET
UPDATE AD_Column SET Callout='org.compiere.model.CalloutMovement.qtyEntered',Updated=TO_TIMESTAMP('2025-01-10 15:39:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217031
;

