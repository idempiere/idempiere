-- Jul 1, 2014 3:44:10 PM MYT
-- 1003719 Modify "Update Costing" process to create a cost adjustment document
UPDATE AD_Process_Para SET SeqNo=120,Updated=TO_TIMESTAMP('2014-07-01 15:44:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53378
;

-- Jul 1, 2014 3:46:18 PM MYT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,IsRange,AD_Process_Para_UU,AD_Process_ID,AD_Reference_ID,AD_Val_Rule_ID,IsMandatory,DisplayLogic,EntityType,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,Created) VALUES (200102,'N','8e8036a8-ae8d-4470-a607-9cd048741419',219,19,200050,'N','@IsUpdateCosting@=''Y''','D','Cost Adjustment Document Type','C_DocType_ID',10,'N',110,'Y',100,TO_TIMESTAMP('2014-07-01 15:46:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,TO_TIMESTAMP('2014-07-01 15:46:18','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 1, 2014 3:51:17 PM MYT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,Name,Description,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('M_CostingLine_ID',202750,'The Cost Adjustment Line indicates the inventory cost adjustment document line (if applicable) for this transaction','Cost Adjustment Line','Unique line in an Inventory cost adjustment document','Cost Adjustment Line','e60cd491-bd9f-4f5f-b031-7401461264c1',TO_TIMESTAMP('2014-07-01 15:51:16','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-07-01 15:51:16','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 1, 2014 3:53:05 PM MYT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,IsActive,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Org_ID,Created) VALUES (0,'N',0,211562,'N','N','N',0,'N',10,'N','N','N','Y','044a1793-a72b-49a0-aa64-f1b99565a884','Y','M_CostingLine_ID','Unique line in an Inventory cost adjustment document','The Cost Adjustment Line indicates the inventory cost adjustment document line (if applicable) for this transaction','Cost Adjustment Line','N',100,TO_TIMESTAMP('2014-07-01 15:53:04','YYYY-MM-DD HH24:MI:SS'),'Y',100,'N','N',0,'D','N','N','N',202750,30,296,572,0,TO_TIMESTAMP('2014-07-01 15:53:04','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 1, 2014 3:53:13 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='MCostingLine_IInventory',Updated=TO_TIMESTAMP('2014-07-01 15:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211562
;

-- Jul 1, 2014 3:53:13 PM MYT
ALTER TABLE I_Inventory ADD COLUMN M_CostingLine_ID NUMERIC(10) DEFAULT NULL 
;

-- Jul 1, 2014 3:53:15 PM MYT
ALTER TABLE I_Inventory ADD CONSTRAINT MCostingLine_IInventory FOREIGN KEY (M_CostingLine_ID) REFERENCES m_inventoryline(m_inventoryline_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 1, 2014 3:54:41 PM MYT
UPDATE AD_Field SET SeqNo=300, SeqNoGrid=300,Updated=TO_TIMESTAMP('2014-07-01 15:54:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6697
;

-- Jul 1, 2014 3:56:40 PM MYT
INSERT INTO AD_Field (SortNo,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID,EntityType,Created) VALUES (0,'N',0,'N','N',290,'Y',203261,'N','The Cost Adjustment Line indicates the inventory cost adjustment document line (if applicable) for this transaction','Unique line in an Inventory cost adjustment document','Cost Adjustment Line','c8667068-b4f9-43dd-a80d-2b910584a565','Y','N',100,0,100,TO_TIMESTAMP('2014-07-01 15:56:39','YYYY-MM-DD HH24:MI:SS'),'Y','Y',290,1,'N',0,2,1,'N','N',211562,481,'D',TO_TIMESTAMP('2014-07-01 15:56:39','YYYY-MM-DD HH24:MI:SS'))
;

SELECT register_migration_script('201407021018_1003719.sql') FROM dual
;

