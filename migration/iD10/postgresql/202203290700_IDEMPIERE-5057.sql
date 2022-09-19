SELECT register_migration_script('202203290700_IDEMPIERE-5057.sql') FROM dual
;

-- Mar 28, 2022 3:27:22 PM MYT
-- IDEMPIERE-5057 Implement Deductible and non deductible input tax for purchasing and costing
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,CreatedBy,UpdatedBy,AD_Client_ID,EntityType,AD_Org_ID) VALUES (203283,'TaxPostingIndicator',TO_TIMESTAMP('2022-03-28 15:27:21','YYYY-MM-DD HH24:MI:SS'),'Posting Indicator','Posting Indicator','6de750b3-2872-44ba-a78b-94fa6af96acf','Y',TO_TIMESTAMP('2022-03-28 15:27:21','YYYY-MM-DD HH24:MI:SS'),100,100,0,'D',0)
;

-- Mar 28, 2022 3:32:00 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,ValidationType,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType,AD_Org_ID) VALUES (200160,'C_Tax Posting Indicator','429065e5-80c4-458e-a7ae-d20761dcb5a8','N','L',TO_TIMESTAMP('2022-03-28 15:31:59','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_TIMESTAMP('2022-03-28 15:31:59','YYYY-MM-DD HH24:MI:SS'),'D',0)
;

-- Mar 28, 2022 3:35:42 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Description,AD_Ref_List_UU,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,Updated,EntityType,AD_Reference_ID,Value,AD_Org_ID) VALUES (200446,'Tax is calculated on the full amount of the item and posted separately.','e84b618c-a8b3-47cf-89a6-dd674e52d3e4','Separate Tax Posting','Y',100,100,0,TO_TIMESTAMP('2022-03-28 15:35:41','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-03-28 15:35:41','YYYY-MM-DD HH24:MI:SS'),'D',200160,'0',0)
;

-- Mar 28, 2022 3:37:59 PM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Description,AD_Ref_List_UU,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,Updated,EntityType,AD_Reference_ID,Value,AD_Org_ID) VALUES (200447,'Tax amount is added to the item amount during account posting time and for updating of Product Cost.','3e8e0d29-29ac-4c67-ae2c-92c0ee43d2e6','Distribute Tax with Relevant Expense','Y',100,100,0,TO_TIMESTAMP('2022-03-28 15:37:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-03-28 15:37:58','YYYY-MM-DD HH24:MI:SS'),'D',200160,'1',0)
;

-- Mar 28, 2022 3:38:05 PM MYT
UPDATE AD_Reference SET IsOrderByValue='Y',Updated=TO_TIMESTAMP('2022-03-28 15:38:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200160
;

-- Mar 28, 2022 3:42:45 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,Updated,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID,IsHtml) VALUES (213805,0,'N',0,'N','N','N',0,'N',1,'N','N','@IsSummary@=Y','N','Y','@IsSummary@=N','e7a97d28-f550-4253-a77b-b6fab1e7b38a',TO_TIMESTAMP('2022-03-28 15:42:44','YYYY-MM-DD HH24:MI:SS'),'Y','TaxPostingIndicator','0','Posting Indicator','Y','Y',100,100,'N',0,TO_TIMESTAMP('2022-03-28 15:42:44','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203283,200160,261,17,'N',0,'N')
;

-- Mar 28, 2022 3:42:52 PM MYT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200012, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200012)
;

-- Mar 28, 2022 3:42:53 PM MYT
ALTER TABLE C_Tax ADD COLUMN TaxPostingIndicator CHAR(1) DEFAULT '0' 
;

-- Mar 28, 2022 3:55:05 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,DisplayLogic,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,205862,'N',0,'N','N',1010,'Y','N','@IsDocumentLevel@=N',TO_TIMESTAMP('2022-03-28 15:55:04','YYYY-MM-DD HH24:MI:SS'),'Posting Indicator','96a2af5a-4a6f-4d44-ab54-da4713d70fc5','Y','N',100,100,'Y','Y',1010,4,'N',0,TO_TIMESTAMP('2022-03-28 15:55:04','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213805,'D',174,0)
;

-- Mar 28, 2022 3:55:33 PM MYT
UPDATE AD_Field SET SeqNo=180,SeqNoGrid=180,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=205862
;

-- Mar 28, 2022 3:55:33 PM MYT
UPDATE AD_Field SET SeqNo=190,SeqNoGrid=190,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=203325
;

-- Mar 28, 2022 3:55:33 PM MYT
UPDATE AD_Field SET SeqNo=200,SeqNoGrid=200,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=203326
;

-- Mar 28, 2022 3:55:33 PM MYT
UPDATE AD_Field SET SeqNo=210,SeqNoGrid=210,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=974
;

-- Mar 28, 2022 3:55:33 PM MYT
UPDATE AD_Field SET SeqNo=220,SeqNoGrid=220,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=976
;

-- Mar 28, 2022 3:55:33 PM MYT
UPDATE AD_Field SET SeqNo=230,SeqNoGrid=230,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=975
;

UPDATE AD_Field SET SeqNo=240,SeqNoGrid=240,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=977
;

UPDATE AD_Field SET SeqNo=250,SeqNoGrid=250,IsDisplayed='Y', Updated=Now(), UpdatedBy=100 WHERE AD_Field_ID=202402
;

-- Mar 28, 2022 3:56:15 PM MYT
UPDATE AD_Column SET ReadOnlyLogic='@IsDocumentLevel@=Y', MandatoryLogic='@IsDocumentLevel@=N',Updated=TO_TIMESTAMP('2022-03-28 15:56:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213805
;

-- Mar 28, 2022 6:43:36 PM MYT
UPDATE AD_Field SET DisplayLogic='@IsDocumentLevel@=N & @IsSummary@=N', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-28 18:43:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205862
;

-- Mar 28, 2022 8:10:21 PM MYT
UPDATE AD_Field SET DisplayLogic='@IsDocumentLevel@=N & @IsSummary@=N & @SOPOType@!S', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-28 20:10:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205862
;

-- Mar 28, 2022 8:10:34 PM MYT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200014, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200014)
;


