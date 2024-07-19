-- IDEMPIERE-5259 New window Label Assignment
SELECT register_migration_script('202206241449_IDEMPIERE-5259.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 24, 2022, 2:49:05 PM BRT
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200130,'Label Assignment',0,0,'Y',TO_TIMESTAMP('2022-06-24 14:49:05','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:49:05','YYYY-MM-DD HH24:MI:SS'),10,'M','N','D','N','N',0,0,'N','592aed77-8bce-4903-8b77-ad839869a525')
;

-- Jun 24, 2022, 2:50:25 PM BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200324,'Assignment',200130,10,'Y',200347,0,0,'Y',TO_TIMESTAMP('2022-06-24 14:50:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:50:25','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','N','N','N',0,'N','D','Y','N','379bc7ea-82fb-4be7-867e-17706d30d156','B','N','Y',0)
;

-- Jun 24, 2022, 2:50:38 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207100,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200324,214893,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-24 14:50:38','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:50:38','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','358c70ff-aec5-4677-aacb-9e335675d5b6','Y',10,2)
;

-- Jun 24, 2022, 2:50:39 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207101,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200324,214894,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-24 14:50:38','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:50:38','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','25b2fc93-0c1e-4110-a073-bb41f9557aaa','Y','N',4,2)
;

-- Jun 24, 2022, 2:50:39 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207102,'Description','Optional short description of the record','A description is limited to 255 characters.',200324,214900,'Y',255,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-24 14:50:39','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:50:39','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','1ddb9684-ad07-42d8-a636-fb79088e7463','Y',20,5)
;

-- Jun 24, 2022, 2:50:40 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207103,'Label Assignment',200324,214891,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-24 14:50:39','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:50:39','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','b017a1fb-6746-490d-bac0-bbb27e927cae','N',2)
;

-- Jun 24, 2022, 2:50:40 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207104,'Label Assignment',200324,214892,'Y',36,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-24 14:50:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:50:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','28742ba6-5278-4575-8511-2e0ad1ed68d5','Y',30,2)
;

-- Jun 24, 2022, 2:50:41 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207105,'Label','Record Label',200324,214901,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-24 14:50:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:50:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','8cdcaee7-69df-470b-80d0-6ee4ef9a2b5f','Y',40,2)
;

-- Jun 24, 2022, 2:50:41 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207106,'Table','Database Table information','The Database Table provides the information of the table definition',200324,214902,'Y',10,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-24 14:50:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:50:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','b6395b2e-fbeb-4f6c-ab4d-fb8215386427','Y',50,2)
;

-- Jun 24, 2022, 2:50:42 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207107,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200324,214903,'Y',22,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-24 14:50:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:50:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','4d74432a-d903-4c46-86bb-816d904836e5','Y',60,2,2)
;

-- Jun 24, 2022, 2:50:42 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207108,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200324,214899,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-24 14:50:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:50:42','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','03e15bd2-379c-4cc7-a1c8-62e9fcac125d','Y',70,2,2)
;

-- Jun 24, 2022, 2:54:33 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-24 14:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207108
;

-- Jun 24, 2022, 2:54:33 PM BRT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-24 14:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207104
;

-- Jun 24, 2022, 2:54:33 PM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-24 14:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207103
;

-- Jun 24, 2022, 2:55:00 PM BRT
UPDATE AD_Table SET AD_Window_ID=200130,Updated=TO_TIMESTAMP('2022-06-24 14:55:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Table_ID=200347
;

-- Jun 24, 2022, 2:55:52 PM BRT
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200208,'Label Assignment','W',200130,0,0,'Y',TO_TIMESTAMP('2022-06-24 14:55:51','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-06-24 14:55:51','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','D','Y','0e5d5883-2839-46c8-993a-24ea51a20b61')
;

-- Jun 24, 2022, 2:55:52 PM BRT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 10, getDate(), 10,t.AD_Tree_ID, 200208, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200208)
;

-- Jun 24, 2022, 2:56:08 PM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=37,Updated=TO_TIMESTAMP('2022-06-24 14:56:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200208
;

-- Jun 24, 2022, 2:56:08 PM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=38,Updated=TO_TIMESTAMP('2022-06-24 14:56:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Jun 24, 2022, 2:59:40 PM BRT
UPDATE AD_Column SET IsToolbarButton='N',Updated=TO_TIMESTAMP('2022-06-24 14:59:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214903
;

-- Jun 24, 2022, 3:00:20 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-24 15:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207107
;

-- Jun 24, 2022, 3:02:56 PM BRT
UPDATE AD_Column SET IsSelectionColumn='Y', SeqNoSelection=20,Updated=TO_TIMESTAMP('2022-06-24 15:02:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214902
;

-- Jun 24, 2022, 3:03:08 PM BRT
UPDATE AD_Column SET IsSelectionColumn='Y', SeqNoSelection=30,Updated=TO_TIMESTAMP('2022-06-24 15:03:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214901
;

-- Jun 24, 2022, 3:05:58 PM BRT
UPDATE AD_Column SET IsSelectionColumn='N',Updated=TO_TIMESTAMP('2022-06-24 15:05:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214900
;

-- Jun 24, 2022, 3:10:01 PM BRT
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2022-06-24 15:10:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=214901
;

