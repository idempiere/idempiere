SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4863 Enable save column width in WListBox
-- Oct 28, 2021, 4:29:47 PM CEST
UPDATE AD_Table SET AccessLevel='6',Updated=TO_DATE('2021-10-28 16:29:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200279
;

-- Oct 28, 2021, 4:30:31 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200119,'Customization of the Wlistbox',0,0,'Y',TO_DATE('2021-10-28 16:30:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:31','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','34dc4aad-f985-44ad-9d5f-5d388007dbb4')
;

-- Oct 28, 2021, 4:30:32 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200299,'Customization of the Wlistbox',200119,10,'Y',200279,0,0,'Y',TO_DATE('2021-10-28 16:30:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:32','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','AD_Wlistbox_Customization.Created DESC','N',0,'N','D','Y','N','f4b5b7e6-43e2-4a25-b827-167e019cd18e')
;

-- Oct 28, 2021, 4:30:32 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206756,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200299,214533,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-10-28 16:30:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b8837d9a-86b7-48be-982c-97c3a2f3b9ca','Y',10,2)
;

-- Oct 28, 2021, 4:30:33 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (206757,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200299,214534,'Y',10,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-10-28 16:30:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c0fb3d24-2639-44b1-8342-e58ad140b6d0','Y','N',4,2)
;

-- Oct 28, 2021, 4:30:33 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206758,'Customization of the Wlistbox',200299,214535,'N',10,'N','N','N','N',0,0,'Y',TO_DATE('2021-10-28 16:30:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a54e9baf-f56e-4fec-bbeb-0692488b1fa8','N',2)
;

-- Oct 28, 2021, 4:30:33 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206759,'WlistboxName',200299,214536,'Y',80,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-10-28 16:30:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4c9e1520-138e-4656-b23f-29be39b19045','Y',20,5)
;

-- Oct 28, 2021, 4:30:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206760,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200299,214537,'Y',10,40,'N','N','N','N',0,0,'Y',TO_DATE('2021-10-28 16:30:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0ff3ce8c-649d-4db8-b384-f4470a829e7e','Y',30,2)
;

-- Oct 28, 2021, 4:30:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206761,'Custom',200299,214540,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-10-28 16:30:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f819608b-facf-4a7b-826e-afaff5a8577c','Y',40,5)
;

-- Oct 28, 2021, 4:30:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206762,'AD_Wlistbox_Customization_UU',200299,214544,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2021-10-28 16:30:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','116e0705-fdc5-4adf-afe9-06fd00e2aa76','N',2)
;

-- Oct 28, 2021, 4:30:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206763,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200299,214541,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2021-10-28 16:30:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a8aa191-e7be-4cd2-982d-0a088cfc1f11','Y',50,2,2)
;

-- Oct 28, 2021, 4:30:35 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200197,'Customization of the Wlistbox','W',200119,0,0,'Y',TO_DATE('2021-10-28 16:30:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-28 16:30:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','d0e3ae27-f31d-44b8-b161-658bfd6412ec')
;

-- Oct 28, 2021, 4:30:35 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200197, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200197)
;

-- Oct 28, 2021, 4:30:35 PM CEST
UPDATE AD_Table SET AD_Window_ID=200119,Updated=TO_DATE('2021-10-28 16:30:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200279
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=11,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200175
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=12,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=101
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=13,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=294
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=14,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=395
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=15,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=296
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=16,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=221
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=17,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=233
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=18,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=290
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=19,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=109
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=20,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200093
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=21,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=50008
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=22,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200195
;

-- Oct 28, 2021, 4:31:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=23,Updated=TO_DATE('2021-10-28 16:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200197
;

-- Oct 28, 2021, 4:32:34 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=5, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-28 16:32:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206761
;

-- Oct 28, 2021, 4:32:35 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-28 16:32:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206762
;

-- Oct 28, 2021, 4:32:35 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-28 16:32:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206758
;

SELECT register_migration_script('202110281633_IDEMPIERE-4863.sql') FROM dual
;

