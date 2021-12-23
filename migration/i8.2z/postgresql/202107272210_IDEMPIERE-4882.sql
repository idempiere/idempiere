-- IDEMPIERE-4882 : On Inventory Move, Adding Warehouse and Warehouse To field on header
-- 27-Jul-2021, 11:30:58 AM GMT-04:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214565,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',323,'M_Warehouse_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2021-07-27 11:30:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-07-27 11:30:57','YYYY-MM-DD HH24:MI:SS'),100,459,'N','N','D','N','N','N','Y','8d028366-ef8e-4dac-a4f2-4279918ce1f1','Y',0,'N','N','N')
;

-- 27-Jul-2021, 11:31:00 AM GMT-04:00
UPDATE AD_Column SET FKConstraintName='MWarehouse_MMovement', FKConstraintType='N',Updated=TO_TIMESTAMP('2021-07-27 11:31:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214565
;

-- 27-Jul-2021, 11:31:00 AM GMT-04:00
ALTER TABLE M_Movement ADD COLUMN M_Warehouse_ID NUMERIC(10) DEFAULT NULL 
;

-- 27-Jul-2021, 11:31:00 AM GMT-04:00
ALTER TABLE M_Movement ADD CONSTRAINT MWarehouse_MMovement FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- 27-Jul-2021, 11:32:58 AM GMT-04:00
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203528,0,0,'Y',TO_TIMESTAMP('2021-07-27 11:32:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-07-27 11:32:57','YYYY-MM-DD HH24:MI:SS'),100,'M_WarehouseTo_ID','Warehouse To','To Storage Warehouse and Service Point','The Warehouse To indicates the Warehouse where the inventory is being moved to','Warehouse To','D','20ff85b3-c694-476f-b814-c37db421ca2d')
;

-- 27-Jul-2021, 11:36:21 AM GMT-04:00
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200194,'M_WarehouseTo of Client',NULL,'T',0,0,'Y',TO_TIMESTAMP('2021-07-27 11:36:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-07-27 11:36:20','YYYY-MM-DD HH24:MI:SS'),100,'D','N','aaf2b0dd-b8a8-4888-a808-2238c280c1aa')
;

-- 27-Jul-2021, 11:37:28 AM GMT-04:00
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200194,190,1151,1152,0,0,'Y',TO_TIMESTAMP('2021-07-27 11:37:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-07-27 11:37:28','YYYY-MM-DD HH24:MI:SS'),100,'N','D','d78e159c-b941-4d67-b759-e87c518cc346')
;

-- 27-Jul-2021, 11:37:53 AM GMT-04:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214566,0,'Warehouse To','To Storage Warehouse and Service Point','The Warehouse To indicates the Warehouse where the inventory is being moved to',323,'M_WarehouseTo_ID',10,'N','N','N','N','N',0,'N',18,200194,0,0,'Y',TO_TIMESTAMP('2021-07-27 11:37:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-07-27 11:37:52','YYYY-MM-DD HH24:MI:SS'),100,203528,'Y','N','D','N','N','N','Y','bdf4a32d-eab7-4263-bb13-2eaa1f6c4baa','Y',0,'N','N','N','N')
;

-- 27-Jul-2021, 11:37:55 AM GMT-04:00
UPDATE AD_Column SET FKConstraintName='MWarehouseTo_MMovement', FKConstraintType='N',Updated=TO_TIMESTAMP('2021-07-27 11:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214566
;

-- 27-Jul-2021, 11:37:55 AM GMT-04:00
ALTER TABLE M_Movement ADD COLUMN M_WarehouseTo_ID NUMERIC(10) DEFAULT NULL 
;

-- 27-Jul-2021, 11:37:55 AM GMT-04:00
ALTER TABLE M_Movement ADD CONSTRAINT MWarehouseTo_MMovement FOREIGN KEY (M_WarehouseTo_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- 27-Jul-2021, 11:39:41 AM GMT-04:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206735,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',259,214565,'Y',22,330,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-07-27 11:39:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-07-27 11:39:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','694bab3e-cc0f-40d2-863e-cbf018d38ce4','Y',330,2)
;

-- 27-Jul-2021, 11:39:42 AM GMT-04:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206736,'Warehouse To','To Storage Warehouse and Service Point','The Warehouse To indicates the Warehouse where the inventory is being moved to',259,214566,'Y',10,340,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-07-27 11:39:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-07-27 11:39:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dba3f582-023b-4c8b-bcee-a34175a2fc5a','Y',340,2)
;

-- 27-Jul-2021, 11:40:17 AM GMT-04:00
UPDATE AD_Field SET SeqNo=95, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-07-27 11:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206735
;

-- 27-Jul-2021, 11:40:24 AM GMT-04:00
UPDATE AD_Field SET SeqNo=96, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-07-27 11:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206736
;

-- 27-Jul-2021, 11:40:36 AM GMT-04:00
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=95, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-07-27 11:40:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206735
;

-- 27-Jul-2021, 11:40:41 AM GMT-04:00
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=96, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-07-27 11:40:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206736
;

-- 27-Jul-2021, 12:13:55 PM GMT-04:00
UPDATE AD_Column SET Callout='org.compiere.model.CalloutMovement.warehouse',Updated=TO_TIMESTAMP('2021-07-27 12:13:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214565
;

-- Nov 15, 2021, 1:05:33 PM CET
UPDATE AD_Column SET DefaultValue='NULL', Callout=NULL, IsUpdateable='Y',Updated=TO_TIMESTAMP('2021-11-15 13:05:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214565
;

-- Nov 15, 2021, 1:06:49 PM CET
UPDATE AD_Column SET AD_Val_Rule_ID=189,Updated=TO_TIMESTAMP('2021-11-15 13:06:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214565
;

-- Nov 15, 2021, 1:11:53 PM CET
UPDATE AD_Column SET ReadOnlyLogic='@SQL=SELECT 1 FROM M_MovementLine WHERE M_Movement_ID=@M_Movement_ID:0@',Updated=TO_TIMESTAMP('2021-11-15 13:11:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214565
;

-- Nov 15, 2021, 1:13:03 PM CET
UPDATE AD_Column SET ReadOnlyLogic='@SQL=SELECT 1 FROM M_MovementLine WHERE M_Movement_ID=@M_Movement_ID:0@',Updated=TO_TIMESTAMP('2021-11-15 13:13:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214566
;

SELECT register_migration_script('202107272210_IDEMPIERE-4882.sql') FROM dual
;
