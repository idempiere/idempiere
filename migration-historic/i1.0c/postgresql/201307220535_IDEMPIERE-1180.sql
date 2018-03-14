-- Jul 16, 2013 5:16:03 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,IsActive,AD_Org_ID,AD_Client_ID) VALUES ('AD_Ref_List.Value in (''A'',''I'',''S'')',200048,'D','M_Inventory CostingMethod','S','33ab6d88-3a3e-4ef8-b46c-71e90a2e0e45',100,100,TO_TIMESTAMP('2013-07-16 17:15:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-16 17:15:58','YYYY-MM-DD HH24:MI:SS'),'Y',0,0)
;

-- Jul 16, 2013 5:18:09 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',1,321,210654,122,'N','N','N',0,'N',1,'N',17,200048,'N','N','Y','960a5140-456a-47e9-81b4-78d417b9c41a','Y','CostingMethod','Indicates how Costs will be calculated',NULL,'The Costing Method indicates how costs will be calculated (Standard, Average, Lifo, FiFo).  The default costing method is defined on accounting schema level and can be optionally overwritten in the product category.  The costing method cannot conflict with the Material Movement Policy (defined on Product Category).','Costing Method','Y',TO_TIMESTAMP('2013-07-16 17:18:06','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-16 17:18:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',241)
;

-- Jul 16, 2013 5:18:12 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210654 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 16, 2013 5:18:27 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
ALTER TABLE M_Inventory ADD COLUMN CostingMethod CHAR(1) DEFAULT NULL 
;

-- Jul 16, 2013 5:27:44 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,322,210655,'N','N','N',0,'N',22,'N',37,'N','N','Y','74297da3-3e9e-41e7-aba0-dcf30c59e9ed','N','CurrentCostPrice','The currently used cost price','0','Current Cost Price','N',TO_TIMESTAMP('2013-07-16 17:27:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-16 17:27:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1394)
;

-- Jul 16, 2013 5:27:44 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210655 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 16, 2013 5:27:53 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
ALTER TABLE M_InventoryLine ADD COLUMN CurrentCostPrice NUMERIC DEFAULT '0' 
;

-- Jul 16, 2013 5:28:37 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,322,210656,'N','N','N',0,'N',22,'N',37,'N','N','Y','271628eb-35c9-4f9a-a3f5-7a60dccea70b','Y','NewCostPrice','New current cost price after processing of M_CostDetail','0','New Cost Price','N',TO_TIMESTAMP('2013-07-16 17:28:34','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-16 17:28:34','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',200008)
;

-- Jul 16, 2013 5:28:37 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210656 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 16, 2013 5:28:43 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
ALTER TABLE M_InventoryLine ADD COLUMN NewCostPrice NUMERIC DEFAULT '0' 
;

-- Jul 16, 2013 5:57:15 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Description,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200155,200068,'Inventory Cost Adjustment','Cost Adjustment','9b6ed272-4f67-4ffa-b2b1-971541d27730','CA',TO_TIMESTAMP('2013-07-16 17:57:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-16 17:57:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 16, 2013 5:57:15 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200155 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 17, 2013 12:26:10 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Window (Processing,WindowType,Help,IsSOTrx,IsDefault,IsBetaFunctionality,EntityType,Name,Description,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,AD_Client_ID) VALUES ('N','T','The Cost Adjustment Window allow user to enter cost adjustment for products','N','N','N','D','Cost Adjustment','Enter Inventory Cost Adjustment',200043,'32f85bce-a502-4601-b5f7-29ee246fb79c',TO_TIMESTAMP('2013-07-17 00:26:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-17 00:26:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,0)
;

-- Jul 17, 2013 12:26:10 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200043 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Jul 17, 2013 12:27:57 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,WhereClause,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','Y',200043,10,'N','N',321,'N','N','M_Inventory.C_DocType_ID IN (SELECT C_DocType_ID FROM C_DocType Where DocBaseType=''MMI'' AND DocSubTypeInv=''CA'')','N','Y','N',0,'6334be0e-03c7-4e14-86e1-6c2c2e6c71f7','D','Cost Adjustment',200102,0,TO_TIMESTAMP('2013-07-17 00:27:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:27:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Jul 17, 2013 12:27:57 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200102 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jul 17, 2013 12:28:21 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'Y','N',3818,0,'Y',202291,'Y','The Perpetual Inventory identifies the Perpetual Inventory rule which generated this Physical Inventory.','D','Rules for generating physical inventory','Perpetual Inventory','ea0f17e5-62b8-4324-a8aa-0ac44c9d17ab','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:20','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,4,'N',0,2,1)
;

-- Jul 17, 2013 12:28:21 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202291 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'N','N',3542,0,'Y',202292,'N','The Physical Inventory indicates a unique parameters for a physical inventory.','D','Parameters for a Physical Inventory','Phys.Inventory','7bccbd2c-a45b-4fa1-b53c-be382416539e','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:21','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,'N',0,2,1)
;

-- Jul 17, 2013 12:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202292 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:23 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,1,'N','N',3553,0,'Y',202293,'Y','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','c103dae1-0b84-4a91-b62b-fb9b76be23cf','N','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:22','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'N',0,2,1)
;

-- Jul 17, 2013 12:28:23 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202293 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:24 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,1,'Y','N',3554,0,'Y',202294,'N','D','Process Now','a8eca033-6bf7-45cb-bbd6-e59843fb357a','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:23','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,5,'N',0,2,1)
;

-- Jul 17, 2013 12:28:24 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202294 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:24 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,23,'Y','N',3816,0,'Y',202295,'N','D','Update Quantities','e1c75a54-e02c-4590-8da2-300c51e1f6e3','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:24','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,5,'N',0,2,1)
;

-- Jul 17, 2013 12:28:24 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202295 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:25 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,23,'N','N',3817,0,'Y',202296,'N','D','Generate List','Generate List','0b6db341-a2f3-4ad3-97a6-741dc21ed7e6','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:24','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'N',0,2,1)
;

-- Jul 17, 2013 12:28:25 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202296 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:26 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,1,'N','N',3545,0,'Y',202297,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','ca26b317-dfae-487d-ab7d-7d97cecbf511','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:25','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'N',0,2,1)
;

-- Jul 17, 2013 12:28:26 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202297 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:29 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'N','N',3543,10,'Y',202298,'Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','956a50e3-0d21-4424-9847-1b3e83d6c554','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:26','YYYY-MM-DD HH24:MI:SS'),'Y','N',10,1,'N',0,2,1)
;

-- Jul 17, 2013 12:28:29 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202298 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:30 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'Y','N',3544,20,'Y',202299,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','8e4f0029-aa8b-4278-ba23-d354d236e06a','Y','N','Y',100,0,TO_TIMESTAMP('2013-07-17 00:28:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:29','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,4,'N',0,2,1)
;

-- Jul 17, 2013 12:28:30 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202299 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:31 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES (-1,'N',200102,20,'N','N',3550,30,'Y',202300,'N','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','D','Document sequence number of the document','Document No','4f26c600-693b-4b8f-8641-2770b2ac5d1c','Y','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:30','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,'N',0,2,1)
;

-- Jul 17, 2013 12:28:31 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202300 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:31 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,60,'N','N',3551,40,'Y',202301,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','e2465a12-c85c-4d16-95b4-8b31f0c3c094','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:31','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,5,1)
;

-- Jul 17, 2013 12:28:31 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202301 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:32 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'N','N',3815,50,'Y',202302,'N','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.','D','Storage Warehouse and Service Point','Warehouse','97cad730-7876-40ac-882f-777909e5c0e4','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:31','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,1,'N',0,2,1)
;

-- Jul 17, 2013 12:28:32 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202302 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:33 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'N','N',3552,60,'Y',202303,'N','The Movement Date indicates the date that a product moved in or out of inventory.  This is the result of a shipment, receipt or inventory movement.','D','Date a product was moved in or out of inventory','Movement Date','08524253-d0b3-4d9a-bc36-9520d7dad5fe','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:32','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,1,'N',0,2,1)
;

-- Jul 17, 2013 12:28:33 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202303 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:34 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Reference_ID,EntityType,AD_Val_Rule_ID,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'Y','N',12797,70,'Y',202304,'N','The Document Type determines document sequence and processing rules',19,'D',200034,'Document type or rules','Document Type','a4c8ca68-3ab8-4af6-aefc-81f1eba283c3','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:33','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,4,'N',0,2,1)
;

-- Jul 17, 2013 12:28:34 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202304 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:35 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_FieldGroup_ID,DisplayLogic,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'N','N',9592,80,'Y',202305,'N','A Project allows you to track and control internal or external activities.',104,'@$Element_PJ@=Y','D','Financial Project','Project','53f0200a-0c6d-4313-ae79-a916115225ff','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:34','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,1,'N',0,2,1)
;

-- Jul 17, 2013 12:28:35 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202305 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:36 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_FieldGroup_ID,DisplayLogic,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'Y','N',9589,90,'Y',202306,'N','Activities indicate tasks that are performed and used to utilize Activity based Costing',104,'@$Element_AY@=Y','D','Business Activity','Activity','7404ec3e-0e07-4fee-ac02-45f9d209d903','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:35','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,4,'N',0,2,1)
;

-- Jul 17, 2013 12:28:36 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202306 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:37 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_FieldGroup_ID,DisplayLogic,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'N','N',9590,100,'Y',202307,'N','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.',104,'@$Element_MC@=Y','D','Marketing Campaign','Campaign','5e74e268-5a72-464e-a0a5-5dd165c6d5b0','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:36','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,1,'N',0,2,1)
;

-- Jul 17, 2013 12:28:37 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202307 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_FieldGroup_ID,DisplayLogic,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'Y','N',9591,110,'Y',202308,'N','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.',104,'@$Element_OT@=Y','D','Performing or initiating organization','Trx Organization','13b92c02-e955-47bd-aab7-f633ef8fce77','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:37','YYYY-MM-DD HH24:MI:SS'),'Y','Y',110,4,'N',0,2,1)
;

-- Jul 17, 2013 12:28:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202308 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:39 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_FieldGroup_ID,DisplayLogic,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'N','N',9588,120,'Y',202309,'N','The user defined element displays the optional elements that have been defined for this account combination.',104,'@$Element_U1@=Y','D','User defined list element #1','User List 1','25bf48b9-9abb-40b9-aca2-34d4663a6352','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:38','YYYY-MM-DD HH24:MI:SS'),'Y','Y',120,1,'N',0,2,1)
;

-- Jul 17, 2013 12:28:39 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202309 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:39 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_FieldGroup_ID,DisplayLogic,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'Y','N',9587,130,'Y',202310,'N','The user defined element displays the optional elements that have been defined for this account combination.',104,'@$Element_U2@=Y','D','User defined list element #2','User List 2','43bcb8fa-34f4-4373-8395-452567f9be2e','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:39','YYYY-MM-DD HH24:MI:SS'),'Y','Y',130,4,'N',0,2,1)
;

-- Jul 17, 2013 12:28:39 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202310 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_FieldGroup_ID,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,1,'N','N',12414,140,'Y',202311,'Y','The Approved checkbox indicates if this document requires approval before it can be processed.',101,'D','Indicates if this document requires approval','Approved','10b5e67d-2795-4a16-8cab-f5f886a94c8d','Y','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:39','YYYY-MM-DD HH24:MI:SS'),'Y','Y',140,2,'N',0,2,1)
;

-- Jul 17, 2013 12:28:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202311 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:41 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,26,'Y','N',12411,150,'Y',202312,'Y','Approval Amount for Workflow','D','Document Approval Amount','Approval Amount','0b02a56f-4643-442d-b8b9-608cd6c258ae','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:40','YYYY-MM-DD HH24:MI:SS'),'Y','Y',150,4,'N',0,2,1)
;

-- Jul 17, 2013 12:28:41 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202312 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:42 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,14,'N','N',12413,160,'Y',202313,'Y','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field','D','The current status of the document','Document Status','37e34455-419e-4c99-8043-502ef6b4e569','Y','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:41','YYYY-MM-DD HH24:MI:SS'),'Y','Y',160,1,'N',0,2,1)
;

-- Jul 17, 2013 12:28:42 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202313 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:43 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,23,'Y','N',12412,170,'Y',202314,'N','You find the current status in the Document Status field. The options are listed in a popup','D','The targeted status of the document','Document Action','8965ec38-47e3-4b40-a3f2-5118211f1872','Y','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',170,5,'N',0,2,1)
;

-- Jul 17, 2013 12:28:43 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202314 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:28:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200102,23,'N','N',6535,180,'Y',202315,'N','The Posted field indicates the status of the Generation of General Ledger Accounting Lines ','@Processed@=Y & @#ShowAcct@=Y','D','Posting status','Posted','3877102c-7efd-455d-801c-26c408482447','Y','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:28:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:28:43','YYYY-MM-DD HH24:MI:SS'),'Y','Y',180,2,'N',0,2,1)
;

-- Jul 17, 2013 12:28:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202315 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:34:56 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,IsMandatory,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES (0,'N',200102,0,'N','N',210654,190,'Y',202316,'N','The Costing Method indicates how costs will be calculated (Standard, Average, Lifo, FiFo).  The default costing method is defined on accounting schema level and can be optionally overwritten in the product category.  The costing method cannot conflict with the Material Movement Policy (defined on Product Category).','Y','D','Indicates how Costs will be calculated','Costing Method','b50356fa-f349-4431-a0f9-7fc59720d584','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:34:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:34:53','YYYY-MM-DD HH24:MI:SS'),'Y','Y',190,1,'N',0,1,1)
;

-- Jul 17, 2013 12:34:56 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202316 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:40:43 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-07-17 00:40:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202304
;

-- Jul 17, 2013 12:40:43 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-07-17 00:40:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202316
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202303
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202302
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202305
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202306
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202307
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202308
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202309
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202310
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202313
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202314
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202315
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202312
;

-- Jul 17, 2013 12:40:44 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_TIMESTAMP('2013-07-17 00:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202311
;

-- Jul 17, 2013 12:43:24 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','N',200043,20,'N','N',322,'N','N','N','Y','N',0,'eb716dc1-f0c8-4596-8b76-7ec4bca13fd4','D','Cost Adjustment Line',200103,0,TO_TIMESTAMP('2013-07-17 00:43:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:43:24','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Jul 17, 2013 12:43:24 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200103 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jul 17, 2013 12:43:57 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,1,'N','N',3558,0,'Y',202317,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','667ed102-9fca-4ae9-afe0-2abcf981b763','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:43:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:43:55','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'N',0,2,1)
;

-- Jul 17, 2013 12:43:57 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202317 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:43:58 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,14,'N','N',9951,0,'Y',202318,'N','The type of inventory difference determines which account is used. The default is the Inventory Difference account defined for the warehouse.  Alternatively, you could select any charge.  This allows you to account for Internal Use or extraordinary inventory losses.','D','Type of inventory difference','Inventory Type','2f9cca5d-4101-414a-8eff-06d5f344ff05','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:43:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:43:57','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,'N',0,2,1)
;

-- Jul 17, 2013 12:43:58 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202318 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:43:59 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,1,'N','N',12071,0,'Y',202319,'N','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','9f83de38-67bf-452e-9590-015e388f419b','N','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:43:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:43:58','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'N',0,2,1)
;

-- Jul 17, 2013 12:43:59 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202319 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:00 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,14,'N','N',3555,0,'Y',202320,'N','The Physical Inventory Line indicates the inventory document line (if applicable) for this transaction','D','Unique line in an Inventory document','Phys.Inventory Line','6d592b79-35f2-49c2-98c5-5866cfa9659e','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:43:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:43:59','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,'N',0,2,1)
;

-- Jul 17, 2013 12:44:00 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202320 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:01 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,26,'N','N',3567,0,'Y',202321,'N','The Quantity Count indicates the actual inventory count taken for a product in inventory','D','Counted Quantity','Quantity count','fef09a5f-7d96-43f1-93a8-fb2caabca1d0','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:00','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,'N',0,2,1)
;

-- Jul 17, 2013 12:44:01 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202321 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:01 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,26,'Y','N',3566,0,'Y',202322,'Y','The Quantity Book indicates the line count stored in the system for a product in inventory','D','Book Quantity','Quantity book','c84f0dbd-5e9c-4613-b0a0-c2e9f94f72c1','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:01','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,4,'N',0,2,1)
;

-- Jul 17, 2013 12:44:01 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202322 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,14,'N','N',3556,10,'Y',202323,'Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','7201bd88-249d-45e7-ba3e-837b23b6ee10','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:01','YYYY-MM-DD HH24:MI:SS'),'Y','N',10,1,'N',0,2,1)
;

-- Jul 17, 2013 12:44:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202323 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:03 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,14,'Y','N',3557,20,'Y',202324,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','95af8082-8322-419f-9eab-95199c40ef00','Y','N','Y',100,0,TO_TIMESTAMP('2013-07-17 00:44:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:02','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,4,'N',0,2,1)
;

-- Jul 17, 2013 12:44:03 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202324 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,14,'N','N',3563,30,'Y',202325,'Y','The Physical Inventory indicates a unique parameters for a physical inventory.','D','Parameters for a Physical Inventory','Phys.Inventory','45d7ab54-515d-4f3b-b78e-6842b0231b98','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:03','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,'N',0,2,1)
;

-- Jul 17, 2013 12:44:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202325 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:05 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES (1,'N',200103,11,'N','N',3819,40,'Y',202326,'N','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','D','Unique line for this document','Line No','4469c1a1-80c8-4a20-b0f8-7154de6f75ec','Y','N','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:04','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,2,1)
;

-- Jul 17, 2013 12:44:05 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202326 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:06 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,14,'N','N',3564,50,'Y',202327,'N','The Locator indicates where in a Warehouse a product is located.','D','Warehouse Locator','Locator','84eb6f1d-7c90-495e-b93e-1ce8cab4d041','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:05','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,1,'N',0,2,1)
;

-- Jul 17, 2013 12:44:06 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202327 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:06 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,26,'N','N',3565,60,'Y',202328,'N','Identifies an item which is either purchased or sold in this organization.','D','Product, Service, Item','Product','a125bc2c-dbe1-4f0f-90ed-777d08e403ab','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:06','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,1,'N',0,2,1)
;

-- Jul 17, 2013 12:44:06 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202328 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:07 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,26,'Y','N',8550,70,'Y',202329,'N','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.','D','Product Attribute Set Instance','Attribute Set Instance','374eb2f5-41b6-45e4-8032-877d6f401c93','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:06','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,4,'N',0,2,1)
;

-- Jul 17, 2013 12:44:07 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202329 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,60,'N','N',3568,80,'Y',202330,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','b4ca82d1-23be-4213-8d99-a9a9f8c4f109','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:07','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,1,'N',0,5,1)
;

-- Jul 17, 2013 12:44:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202330 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:09 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,26,'N','N',13023,90,'Y',202331,'N','Quantity of product inventory used internally (positive if taken out - negative if returned)','D','Internal Use Quantity removed from Inventory','Internal Use Qty','f55f6c38-e991-4787-a047-dfc4995553ce','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:08','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,1,'N',0,2,1)
;

-- Jul 17, 2013 12:44:09 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202331 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:44:10 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200103,14,'Y','N',9950,100,'Y',202332,'N','The Charge indicates a type of Charge (Handling, Shipping, Restocking)','D','Additional document charges','Charge','09f7ae08-eda6-4dd8-ab52-faa5d2424656','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:44:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:44:09','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,4,'N',0,2,1)
;

-- Jul 17, 2013 12:44:10 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202332 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:46:24 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES (0,'N',200103,0,'N','N',210655,110,'Y',202333,'Y','D','The currently used cost price','Current Cost Price','077fa0cb-7d6a-4647-a8d3-9bdfcebdd397','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:46:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:46:23','YYYY-MM-DD HH24:MI:SS'),'Y','Y',110,1,'N',0,1,1)
;

-- Jul 17, 2013 12:46:24 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202333 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 12:46:55 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,IsMandatory,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES (0,'N',200103,0,'N','N',210656,120,'Y',202334,'N','Y','D','New current cost price after processing of M_CostDetail','New Cost Price','052b09f3-51e8-491c-8267-7bf0f34fbbee','Y','N',100,0,TO_TIMESTAMP('2013-07-17 00:46:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 00:46:54','YYYY-MM-DD HH24:MI:SS'),'Y','Y',120,1,'N',0,1,1)
;

-- Jul 17, 2013 12:46:55 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202334 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 11:28:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Description,"action",AD_Menu_UU,IsActive,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy,AD_Client_ID) VALUES (200043,200064,'N','N','N','D','Y','Cost Adjustment','Enter inventory cost adjustment','W','caecfe93-7496-4890-8840-573e8896ba68','Y',100,TO_TIMESTAMP('2013-07-17 11:28:03','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-07-17 11:28:03','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 17, 2013 11:28:05 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200064 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Jul 17, 2013 11:28:05 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200064, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200064)
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=167
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=357
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=229
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=412
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=256
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=197
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=477
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=181
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=484
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=179
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=503
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=196
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=479
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200064
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=482
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=481
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=411
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53253
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=426
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=537
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=311
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=292
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=504
;

-- Jul 17, 2013 11:28:22 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=515
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=167
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=357
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=229
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=412
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=256
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=197
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=477
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=181
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=484
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=179
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=503
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=196
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200064
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=479
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=482
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=481
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=411
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53253
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=426
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=537
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=311
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=292
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=504
;

-- Jul 17, 2013 11:29:02 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=515
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=167
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=357
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=229
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=412
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=256
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=197
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=477
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=181
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=484
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=179
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=503
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=196
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200064
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=479
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=482
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=481
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=411
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53253
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=426
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=537
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=311
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=292
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=504
;

-- Jul 17, 2013 11:29:04 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=515
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=167
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=357
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=229
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=412
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=256
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=197
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=477
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=181
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=484
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=179
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=503
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=196
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200064
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=479
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=482
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=481
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=411
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53253
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=426
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=537
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=311
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=292
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=504
;

-- Jul 17, 2013 11:29:08 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=515
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=167
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=357
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=229
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=412
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=256
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=197
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=477
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=181
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=484
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=179
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=503
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=196
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200064
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=479
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=482
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=481
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=411
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53253
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=426
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=537
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=311
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=292
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=504
;

-- Jul 17, 2013 11:29:38 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=515
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=167
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=357
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=229
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=412
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=256
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=197
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=477
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=181
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=484
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=179
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=503
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200064
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=196
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=479
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=482
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=481
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=411
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53253
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=426
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=537
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=311
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=292
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=504
;

-- Jul 17, 2013 11:29:40 AM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=515
;

-- Jul 17, 2013 3:11:26 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2013-07-17 15:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202305
;

-- Jul 17, 2013 3:11:26 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2013-07-17 15:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202306
;

-- Jul 17, 2013 3:11:26 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2013-07-17 15:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202307
;

-- Jul 17, 2013 3:11:26 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2013-07-17 15:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202308
;

-- Jul 17, 2013 3:11:26 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2013-07-17 15:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202309
;

-- Jul 17, 2013 3:11:26 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2013-07-17 15:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202310
;

-- Jul 17, 2013 3:11:26 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2013-07-17 15:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202313
;

-- Jul 17, 2013 3:11:26 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2013-07-17 15:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202314
;

-- Jul 17, 2013 3:11:26 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2013-07-17 15:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202315
;

-- Jul 17, 2013 3:11:26 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_TIMESTAMP('2013-07-17 15:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202302
;

-- Jul 17, 2013 3:13:30 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,IsActive,AD_Org_ID,AD_Client_ID) VALUES ('C_DocType.DocBaseType=''MMI'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@ AND C_DocType.DocSubTypeInv=''CA''',200050,'D','C_DocType Cost Adjustment','S','6a030a3a-0eff-4122-a453-eaf809c079e5',100,100,TO_TIMESTAMP('2013-07-17 15:13:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-17 15:13:19','YYYY-MM-DD HH24:MI:SS'),'Y',0,0)
;

-- Jul 17, 2013 3:13:43 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET AD_Val_Rule_ID=200050,Updated=TO_TIMESTAMP('2013-07-17 15:13:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202304
;

-- Jul 17, 2013 3:50:17 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO C_DocType (GL_Category_ID,C_DocType_ID,IsDefault,DocBaseType,IsSOTrx,DocumentCopies,IsCreateCounter,IsIndexed,IsShipConfirm,IsSplitWhenDifference,IsDefaultCounterDoc,IsInTransit,IsPickQAConfirm,IsOverwriteDateOnComplete,IsOverwriteSeqOnComplete,C_DocType_UU,IsPrepareSplitDocument,PrintName,Name,IsDocNoControlled,HasCharges,HasProforma,CreatedBy,UpdatedBy,Updated,AD_Org_ID,IsActive,Created,IsChargeOrProductMandatory,AD_Client_ID,DocSubTypeInv) VALUES (111,200004,'N','MMI','N',0,'Y','Y','N','N','N','N','N','N','N','e6e7229e-4a6d-4c28-8406-77557f3c4e37','Y','Cost Adjustment','Cost Adjustment','N','N','N',101,101,TO_TIMESTAMP('2013-07-17 15:50:00','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-07-17 15:50:00','YYYY-MM-DD HH24:MI:SS'),'N',11,'CA')
;

-- Jul 17, 2013 3:50:18 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO C_DocType_Trl (AD_Language,C_DocType_ID, DocumentNote,PrintName,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_DocType_Trl_UU ) SELECT l.AD_Language,t.C_DocType_ID, t.DocumentNote,t.PrintName,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, C_DocType t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_DocType_ID=200004 AND NOT EXISTS (SELECT * FROM C_DocType_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_DocType_ID=t.C_DocType_ID)
;

-- Jul 17, 2013 4:27:33 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Tab SET TabLevel=1,Updated=TO_TIMESTAMP('2013-07-17 16:27:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200103
;

-- Jul 17, 2013 4:28:33 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2013-07-17 16:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202328
;

-- Jul 17, 2013 4:28:34 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2013-07-17 16:28:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202329
;

-- Jul 17, 2013 4:28:34 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2013-07-17 16:28:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202330
;

-- Jul 17, 2013 4:28:34 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-07-17 16:28:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202333
;

-- Jul 17, 2013 4:28:34 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2013-07-17 16:28:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202334
;

-- Jul 17, 2013 4:28:34 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_TIMESTAMP('2013-07-17 16:28:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202331
;

-- Jul 17, 2013 4:28:34 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_TIMESTAMP('2013-07-17 16:28:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202327
;

-- Jul 17, 2013 4:29:47 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET IsCentrallyMaintained='N', Help='The Inventory Cost Adjustment document allows user to enter cost adjustment for products', Description='Inventory Cost Adjustment', Name='Cost Adjustment',Updated=TO_TIMESTAMP('2013-07-17 16:29:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202325
;

-- Jul 17, 2013 11:51:40 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Column SET ReadOnlyLogic='@CostingMethod@!x',Updated=TO_TIMESTAMP('2013-07-17 23:51:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13478
;

-- Jul 17, 2013 11:56:34 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Column SET ReadOnlyLogic='@CostingMethod@!x',Updated=TO_TIMESTAMP('2013-07-17 23:56:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56076
;

-- Jul 18, 2013 12:42:38 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,AD_Reference_ID,AD_Val_Rule_ID,IsMandatory,AD_Reference_Value_ID,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID) VALUES ('N',200071,'25ddfed2-c614-4c36-bfa5-76f8d495517d',182,18,200050,'N',170,'D','Document Type','C_DocType_ID','Inventory Cost Adjustment Document Type',0,'N',50,'Y',100,TO_TIMESTAMP('2013-07-18 12:42:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 12:42:28','YYYY-MM-DD HH24:MI:SS'),0,'N',0)
;

-- Jul 18, 2013 12:42:39 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200071 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Jul 18, 2013 12:52:30 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2013-07-18 12:52:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3815
;

-- Jul 18, 2013 12:52:34 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO t_alter_column values('m_inventory','M_Warehouse_ID','NUMERIC(10)',null,'NULL')
;

-- Jul 18, 2013 12:52:34 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO t_alter_column values('m_inventory','M_Warehouse_ID',null,'NULL',null)
;

-- Jul 18, 2013 12:53:27 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-07-18 12:53:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2924
;

-- Jul 18, 2013 12:54:25 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-07-18 12:54:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10966
;

-- Jul 18, 2013 1:00:33 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2013-07-18 13:00:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3564
;

-- Jul 18, 2013 1:00:36 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO t_alter_column values('m_inventoryline','M_Locator_ID','NUMERIC(10)',null,'NULL')
;

-- Jul 18, 2013 1:00:36 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO t_alter_column values('m_inventoryline','M_Locator_ID',null,'NULL',null)
;

-- Jul 18, 2013 1:01:32 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-07-18 13:01:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2696
;

-- Jul 18, 2013 1:01:58 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-07-18 13:01:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10990
;

-- Jul 18, 2013 6:25:52 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Description,Name,AD_Org_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Classname,Value,AD_Client_ID) VALUES ('N',200059,'N','N','69348301-fc79-40b9-9df4-3bf90b9b317a','3','N','N',0,0,'S','D','Refresh current cost for cost adjustment line','CostAdjustmentLine_RefreshCurrentCost',0,TO_TIMESTAMP('2013-07-18 18:25:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-18 18:25:29','YYYY-MM-DD HH24:MI:SS'),'Y',100,'org.idempiere.process.CostAdjustmentLineRefreshCost','CostAdjustmentLine_RefreshCurrentCost',0)
;

-- Jul 18, 2013 6:25:52 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200059 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Jul 18, 2013 6:28:09 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
INSERT INTO AD_ToolBarButton ("action",AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,IsCustomization,Name,ComponentName,AD_Org_ID,Created,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,IsActive,AD_ToolBarButton_UU,AD_Client_ID) VALUES ('W',200103,200059,'@Processed@=N&@M_Product_ID@>0',10,'N','Refresh Current Cost','RefreshCurrentCost',0,TO_TIMESTAMP('2013-07-18 18:28:02','YYYY-MM-DD HH24:MI:SS'),100,200075,TO_TIMESTAMP('2013-07-18 18:28:02','YYYY-MM-DD HH24:MI:SS'),100,'Y','6c28566b-e561-4ebf-99ac-cfc7e125bf85',0)
;

-- Jul 18, 2013 6:30:46 PM MYT
-- IDEMPIERE-1180 Cost Adjustment Document for Standard and Average Costing
UPDATE AD_Process SET Name='Refresh Current Cost',Updated=TO_TIMESTAMP('2013-07-18 18:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200059
;

-- Jul 22, 2013 2:24:54 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_ZoomCondition (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Window_ID,AD_ZoomCondition_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,SeqNo,WhereClause,Name) VALUES (0,0,321,200043,200001,TO_TIMESTAMP('2013-07-22 14:24:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2013-07-22 14:24:51','YYYY-MM-DD HH24:MI:SS'),100,10,'M_Inventory.C_DocType_ID in ( select c_doctype_id from c_doctype where c_doctype.ad_client_id=m_inventory.ad_client_id and c_doctype.docsubtypeinv=''CA'' )','Zoom to Cost Adjustment')
;

-- Jul 22, 2013 2:27:06 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_ZoomCondition (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Window_ID,AD_ZoomCondition_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,SeqNo,WhereClause,Name) VALUES (0,0,321,341,200002,TO_TIMESTAMP('2013-07-22 14:27:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2013-07-22 14:27:04','YYYY-MM-DD HH24:MI:SS'),100,20,'M_Inventory.C_DocType_ID in ( select c_doctype_id from c_doctype where c_doctype.ad_client_id=m_inventory.ad_client_id and c_doctype.docsubtypeinv=''IU'' )','Zoom to Internal Use')
;

-- Jul 22, 2013 8:00:01 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','No costing record.',200216,'D','f469bff5-1cc7-4041-aa68-7a8c3035ef3b','NoCostingRecord','Y',TO_TIMESTAMP('2013-07-22 20:00:00','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-22 20:00:00','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 22, 2013 8:00:02 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200216 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201307220535_IDEMPIERE-1180.sql') FROM dual
;

