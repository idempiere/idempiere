-- IDEMPIERE-4819 Private Lock - Allow Unlock other users Private Records
SELECT register_migration_script('202401221103_IDEMPIERE-4819.sql') FROM dual;

-- Jan 22, 2024, 11:03:58 AM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200147,'AD_Private_Access',0,0,'Y',TO_TIMESTAMP('2024-01-22 11:03:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 11:03:57','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','6386f17e-56c8-4ace-b587-909b829d9e51')
;

-- Jan 22, 2024, 11:03:59 AM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200382,'AD_Private_Access',200147,10,'Y',627,0,0,'Y',TO_TIMESTAMP('2024-01-22 11:03:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 11:03:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','AD_Private_Access.Created DESC','N',0,'N','D','Y','N','70138aff-fa85-4b6a-bf87-819a0d9cef2c')
;

-- Jan 22, 2024, 11:03:59 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208194,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200382,9947,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 11:03:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 11:03:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','80a110f4-fff5-467a-9721-c847ac90e0af','Y',10,2)
;

-- Jan 22, 2024, 11:03:59 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208195,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200382,9941,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 11:03:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 11:03:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4ce4fd8c-b561-46f4-a0ab-15e28b2b3519','Y','N',4,2)
;

-- Jan 22, 2024, 11:04:00 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208196,'Table','Database Table information','The Database Table provides the information of the table definition',200382,9940,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 11:03:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 11:03:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','12735934-235b-4eb3-80de-176816f07063','Y',20,2)
;

-- Jan 22, 2024, 11:04:00 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208197,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200382,9942,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 11:04:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 11:04:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','59b79804-0c70-42af-b160-f9a10581b616','Y',30,2)
;

-- Jan 22, 2024, 11:04:00 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208198,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200382,9943,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 11:04:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 11:04:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b2cc6ded-73c8-4dac-9ced-d46d5e161a7e','Y',40,2)
;

-- Jan 22, 2024, 11:04:01 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208199,'AD_Private_Access_UU',200382,60467,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 11:04:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 11:04:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','49461907-db5b-4f67-893d-faa9e612570a','N',2)
;

-- Jan 22, 2024, 11:04:01 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208200,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200382,9946,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-22 11:04:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 11:04:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a3efdb8d-1a0f-4076-9cac-8d845c7ebb5c','Y',50,2,2)
;

-- Jan 22, 2024, 11:04:02 AM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200231,'AD_Private_Access','W',200147,0,0,'Y',TO_TIMESTAMP('2024-01-22 11:04:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-22 11:04:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','8ab4c605-463d-4d4c-9325-1243767520bd')
;

-- Jan 22, 2024, 11:04:02 AM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200231, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200231)
;

-- Jan 22, 2024, 11:04:02 AM CET
UPDATE AD_Table SET AD_Window_ID=200147,Updated=TO_TIMESTAMP('2024-01-22 11:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=627
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=1000004
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=10,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200231
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=11,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=366
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=12,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=483
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=13,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=368
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=14,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=508
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=15,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200001
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=16,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53201
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=17,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=475
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=18,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200022
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=19,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53348
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=20,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53083
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=21,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200147
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=22,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200148
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=23,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200170
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=24,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200165
;

-- Jan 22, 2024, 11:06:01 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=25,Updated=TO_TIMESTAMP('2024-01-22 11:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200171
;

-- Jan 22, 2024, 11:06:49 AM CET
UPDATE AD_Tab SET Name='Private Access',Updated=TO_TIMESTAMP('2024-01-22 11:06:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200382
;

-- Jan 22, 2024, 11:07:26 AM CET
UPDATE AD_Table SET Name='Private Access',Updated=TO_TIMESTAMP('2024-01-22 11:07:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=627
;

-- Jan 22, 2024, 11:08:43 AM CET
UPDATE AD_Window SET Name='Private Access',Updated=TO_TIMESTAMP('2024-01-22 11:08:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200147
;

-- Jan 22, 2024, 11:08:43 AM CET
UPDATE AD_Menu SET Name='Private Access', Description=NULL, IsActive='Y',Updated=TO_TIMESTAMP('2024-01-22 11:08:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200231
;

-- Jan 22, 2024, 11:10:07 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2024-01-22 11:10:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208197
;

-- Jan 22, 2024, 11:10:07 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=5,Updated=TO_TIMESTAMP('2024-01-22 11:10:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208200
;

-- Jan 22, 2024, 11:10:07 AM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2024-01-22 11:10:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208196
;

-- Jan 22, 2024, 11:10:07 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=4,Updated=TO_TIMESTAMP('2024-01-22 11:10:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208198
;

-- Jan 22, 2024, 11:10:07 AM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-01-22 11:10:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208199
;

-- Jan 22, 2024, 11:14:38 AM CET
UPDATE AD_Tab SET OrderByClause='AD_Private_Access.AD_User_ID, AD_Private_Access.AD_Table_ID, AD_Private_Access.Created DESC',Updated=TO_TIMESTAMP('2024-01-22 11:14:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200382
;

-- Jan 22, 2024, 11:26:41 AM CET
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2024-01-22 11:26:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200382
;

-- Jan 22, 2024, 11:52:02 AM CET
UPDATE AD_Tab SET WhereClause='(AD_Private_Access.AD_User_ID=@#AD_User_ID@ OR (SELECT AD_Role.IsPersonalAccess FROM AD_Role WHERE AD_Role.AD_Role_ID=@#AD_Role_ID@)=''Y'')',Updated=TO_TIMESTAMP('2024-01-22 11:52:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200382
;

