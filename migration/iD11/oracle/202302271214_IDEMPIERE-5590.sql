-- IDEMPIERE-5590
SELECT register_migration_script('202302271214_IDEMPIERE-5590.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 27, 2023, 12:14:48 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200151,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:14:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:14:48','YYYY-MM-DD HH24:MI:SS'),100,'Generate Test Data for SO/PO','Generate random Sales or Purchase Orders with the selected parameters.','N','10000000','N','3','D',0,0,'N','Y','N','cf319328-2122-47c2-b93d-e89975d0273c','P')
;

-- Feb 27, 2023, 12:15:07 PM CET
UPDATE AD_Process SET Value='GenerateTestDataforSO/PO',Updated=TO_TIMESTAMP('2023-02-27 12:15:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200151
;

-- Feb 27, 2023, 12:16:27 PM CET
DELETE  FROM  AD_Process_Trl WHERE AD_Process_ID=200151
;

-- Feb 27, 2023, 12:16:28 PM CET
DELETE FROM AD_Process WHERE AD_Process_ID=200151
;

-- Feb 27, 2023, 12:19:32 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,AD_Process_UU,AllowMultipleExecution) VALUES (200152,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:31','YYYY-MM-DD HH24:MI:SS'),100,'Generate Test Data for SO/PO','N','GenerateTestData','N','org.cloudempiere.process.GenerateTestDataCOrder','3','D',2,15,'N','Y','d9f83970-4922-4fe4-87c1-7c9dff3b72e5','P')
;

-- Feb 27, 2023, 12:19:32 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200419,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:32','YYYY-MM-DD HH24:MI:SS'),100,'Target Document Type','Target document type for conversing documents','You can convert document types (e.g. from Offer to Order or Invoice).  The conversion is then reflected in the current type.  This processing is initiated by selecting the appropriate Document Action.',200152,30,19,'N',0,'Y','C_DocTypeTarget_ID','Y','D',197,'4680ad41-4d3d-415d-8417-2f00ca3fcd1f','N','N')
;

-- Feb 27, 2023, 12:19:32 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200420,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:32','YYYY-MM-DD HH24:MI:SS'),100,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200152,20,19,'N',0,'Y','M_Warehouse_ID','Y','D',459,'87b385d7-c676-4072-96d8-853db445242a','N','N')
;

-- Feb 27, 2023, 12:19:32 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200421,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:32','YYYY-MM-DD HH24:MI:SS'),100,'Price List Version','Identifies a unique instance of a Price List','Each Price List can have multiple versions.  The most common use is to indicate the dates that a Price List is valid for.',200152,40,19,'N',0,'N','M_PriceList_Version_ID','Y','D',450,'36c8902d-84cd-4fcb-a8eb-afcc4d4d5c1e','N','N')
;

-- Feb 27, 2023, 12:19:33 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200422,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:32','YYYY-MM-DD HH24:MI:SS'),100,'Product Category','Category of a Product','Identifies the category which this product belongs to.  Product categories are used for pricing and selection.',200152,50,19,'N',10,'N','M_Product_Category_ID','Y','D',453,'bbce9c2c-aa1b-431b-a622-bf9fcd0d9bca','N','N')
;

-- Feb 27, 2023, 12:19:33 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200423,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:33','YYYY-MM-DD HH24:MI:SS'),100,'Transaction Date','Transaction Date','The Transaction Date indicates the date of the transaction.',200152,70,15,'Y',0,'N','DateTrx','Y','D',1297,'3836db3f-e7b5-444d-8e89-bf6de69e907e','N','N')
;

-- Feb 27, 2023, 12:19:33 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203788,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:33','YYYY-MM-DD HH24:MI:SS'),100,'GenMaxNoOfDocument','Max No of Documents','Max No of Documents','D','2a10d1a5-d821-4c05-958e-5619d77f9755')
;

-- Feb 27, 2023, 12:19:34 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200424,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:33','YYYY-MM-DD HH24:MI:SS'),100,'Max No of Documents',200152,80,11,'N',0,'N','GenMaxNoOfDocument','Y','D',203788,'bd031abd-29c5-4346-a459-fbcf791c219a','N','N')
;

-- Feb 27, 2023, 12:19:34 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200425,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:34','YYYY-MM-DD HH24:MI:SS'),100,'Max Value',200152,90,11,'N',10,'N','MaxValue','Y','D',53399,'6be39912-e864-43cb-bc58-2c21e30c1d43','N','N')
;

-- Feb 27, 2023, 12:19:34 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203789,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:34','YYYY-MM-DD HH24:MI:SS'),100,'isUseProductWithQtyAvailable','Products with Qty Available','Products with Qty Available','D','1a1b74d8-fe42-4a1a-b89b-948e5d376357')
;

-- Feb 27, 2023, 12:19:34 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200426,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:34','YYYY-MM-DD HH24:MI:SS'),100,'Products with Qty Available',200152,100,20,'N',0,'N','isUseProductWithQtyAvailable','Y','D',203789,'ab64e3cf-2937-403a-8bcd-cccc1e743913','N','N')
;

-- Feb 27, 2023, 12:19:35 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203790,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:34','YYYY-MM-DD HH24:MI:SS'),100,'GenMaxNoOfDocumentLines','Max No of Documents Lines','Max No of Documents Lines','U','084e54fb-b058-446b-9da5-17da7315fbcb')
;

-- Feb 27, 2023, 12:19:35 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200427,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:35','YYYY-MM-DD HH24:MI:SS'),100,'Max No of Documents Lines',200152,110,11,'N',0,'N','GenMaxNoOfDocumentLines','Y','D',203790,'a1585764-e3d5-4419-88be-60984549ca96','N','N')
;

-- Feb 27, 2023, 12:19:35 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200428,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:35','YYYY-MM-DD HH24:MI:SS'),100,'Sales Transaction','This is a Sales Transaction','The Sales Transaction checkbox indicates if this item is a Sales Transaction.',200152,120,20,'N',0,'N','Y','IsSOTrx','Y','D',1106,'e0689b66-2bf4-4382-9fff-8813b8109977','N','N')
;

-- Feb 27, 2023, 12:19:36 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200429,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:35','YYYY-MM-DD HH24:MI:SS'),100,'Sales Rep','Sales Representative or Company Agent','The Sales Representative indicates the Sales Rep for this Region.  Any Sales Rep must be a valid internal user.',200152,60,18,190,'N',0,'N','SalesRep_ID','Y','D',1063,'7453b07b-41d9-4b19-9a82-99aa0f807272','N','N')
;

-- Feb 27, 2023, 12:19:36 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200430,0,0,'Y',TO_TIMESTAMP('2023-02-27 12:19:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:19:36','YYYY-MM-DD HH24:MI:SS'),100,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200152,10,19,'N',130,0,'Y','AD_Org_ID','Y','D',113,'64ec1fee-2f8f-494c-8e87-550e001713fb','N','N')
;

-- Feb 27, 2023, 12:49:10 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200223,'Generate Test Data for SO/PO','P',0,0,'Y',TO_TIMESTAMP('2023-02-27 12:49:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 12:49:09','YYYY-MM-DD HH24:MI:SS'),100,'N',200152,'Y','N','D','Y','1833bdec-8ee4-4571-8e9d-93a0ba7ea3c2')
;

-- Feb 27, 2023, 12:49:10 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200223, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200223)
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200223
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Feb 27, 2023, 12:49:23 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14,Updated=TO_TIMESTAMP('2023-02-27 12:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Feb 27, 2023, 12:49:42 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=6,Updated=TO_TIMESTAMP('2023-02-27 12:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200223
;

-- Feb 27, 2023, 12:51:50 PM CET
DELETE  FROM  AD_Process_Para_Trl WHERE AD_Process_Para_ID=200428
;

-- Feb 27, 2023, 12:51:50 PM CET
DELETE FROM AD_Process_Para WHERE AD_Process_Para_ID=200428
;

-- Feb 27, 2023, 12:54:39 PM CET
UPDATE AD_Process SET Classname='org.compiere.process.GenerateTestDataCOrder',Updated=TO_TIMESTAMP('2023-02-27 12:54:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200152
;

-- Feb 27, 2023, 1:29:09 PM CET
UPDATE AD_Process_Para SET AD_Val_Rule_ID=172,Updated=TO_TIMESTAMP('2023-02-27 13:29:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200419
;

-- Feb 27, 2023, 1:32:31 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200431,0,0,'Y',TO_TIMESTAMP('2023-02-27 13:32:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-27 13:32:31','YYYY-MM-DD HH24:MI:SS'),100,'Sales Transaction','This is a Sales Transaction','The Sales Transaction checkbox indicates if this item is a Sales Transaction.',200152,120,20,'N',0,'N','Y','IsSOTrx','Y','D',1106,'babd71ff-8ed4-47f3-a7b6-7457d7987343','N','N')
;

-- Feb 27, 2023, 1:32:51 PM CET
UPDATE AD_Process_Para SET SeqNo=25,Updated=TO_TIMESTAMP('2023-02-27 13:32:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200431
;

-- Feb 27, 2023, 1:38:35 PM CET
UPDATE AD_Process_Para SET AD_Val_Rule_ID=133,Updated=TO_TIMESTAMP('2023-02-27 13:38:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200419
;

-- Feb 27, 2023, 2:01:42 PM CET
UPDATE AD_Process_Para SET AD_Val_Rule_ID=189,Updated=TO_TIMESTAMP('2023-02-27 14:01:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200420
;

-- Feb 27, 2023, 2:24:50 PM CET
UPDATE AD_Process SET Description='Generate Test Data for Sales Order/Purchase Order', Help='This process generates random Sales or Purchase Orders based on the defined parameters.',Updated=TO_TIMESTAMP('2023-02-27 14:24:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200152
;

-- Feb 27, 2023, 2:24:50 PM CET
UPDATE AD_Menu SET Name='Generate Test Data for SO/PO', Description='Generate Test Data for Sales Order/Purchase Order', IsActive='Y',Updated=TO_TIMESTAMP('2023-02-27 14:24:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200223
;

