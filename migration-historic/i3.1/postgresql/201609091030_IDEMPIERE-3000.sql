-- IDEMPIERE-3000
-- Jan 12, 2016 10:23:45 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (202958,0,0,'Y',TO_TIMESTAMP('2016-01-12 10:23:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:23:44','YYYY-MM-DD HH24:MI:SS'),100,'IsFavourite','Favourite','This record is a favourite','Favourite','U','0a31aa8d-9aad-48b2-855c-746f80b9f261')
;

-- Jan 12, 2016 10:23:50 AM CET
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2016-01-12 10:23:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202958
;

-- Jan 12, 2016 10:24:57 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (202959,0,0,'Y',TO_TIMESTAMP('2016-01-12 10:24:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:24:57','YYYY-MM-DD HH24:MI:SS'),100,'LoginOpenSeqNo','Login automatic open sequence','Determine the order items will be automatically opened when user logs in','Login automatic open sequence','D','4f45e332-f582-45ef-be7e-35f970fb3f74')
;

-- Jan 12, 2016 10:25:30 AM CET
UPDATE AD_Column SET AD_Val_Rule_ID=150, IsUpdateable='N',Updated=TO_TIMESTAMP('2016-01-12 10:25:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6212
;

-- Jan 12, 2016 10:26:05 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212587,0,'Favourite','This record is a favourite',456,'IsFavourite','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2016-01-12 10:26:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:26:04','YYYY-MM-DD HH24:MI:SS'),100,202958,'Y','N','U','N','N','N','Y','05a76d6a-3357-4ad7-b594-43652f111d49','Y',0,'N','N')
;

-- Jan 12, 2016 10:26:06 AM CET
ALTER TABLE AD_TreeBar ADD COLUMN IsFavourite CHAR(1) DEFAULT 'Y' CHECK (IsFavourite IN ('Y','N')) NOT NULL
;

-- Jan 12, 2016 10:26:09 AM CET
INSERT INTO t_alter_column values('ad_treebar','IsFavourite','CHAR(1)',null,'Y')
;

-- Jan 12, 2016 10:26:09 AM CET
UPDATE AD_TreeBar SET IsFavourite='Y' WHERE IsFavourite IS NULL
;

-- Jan 12, 2016 10:26:25 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212588,0,'Login automatic open sequence','Determine the order items will be automatically opened when user logs in',456,'LoginOpenSeqNo',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2016-01-12 10:26:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:26:25','YYYY-MM-DD HH24:MI:SS'),100,202959,'Y','N','U','N','N','N','Y','c0e29ca1-f92d-48aa-bd6b-b4d6ffb56ad5','Y',0,'N','N')
;

-- Jan 12, 2016 10:26:25 AM CET
ALTER TABLE AD_TreeBar ADD COLUMN LoginOpenSeqNo NUMERIC(10) DEFAULT NULL 
;

-- Jan 12, 2016 10:26:38 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,ColumnSQL,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212589,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',456,'Name',60,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2016-01-12 10:26:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:26:38','YYYY-MM-DD HH24:MI:SS'),100,469,'N','Y','U','N','N','(SELECT Name FROM AD_Menu WHERE AD_Menu_ID = AD_TreeBar.Node_ID)','N','Y','b9dd089d-3bdf-4140-a9bf-9801221cbb58','N',0,'N','N')
;

-- Jan 12, 2016 10:26:54 AM CET
UPDATE AD_Column SET IsUpdateable='N', IsSelectionColumn='Y', SeqNoSelection=1,Updated=TO_TIMESTAMP('2016-01-12 10:26:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6212
;

-- Jan 12, 2016 10:26:58 AM CET
UPDATE AD_Column SET IsUpdateable='N', IsSelectionColumn='Y', SeqNoSelection=2,Updated=TO_TIMESTAMP('2016-01-12 10:26:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6214
;

-- Jan 12, 2016 10:27:03 AM CET
UPDATE AD_Column SET SeqNoSelection=3,Updated=TO_TIMESTAMP('2016-01-12 10:27:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212589
;

-- Jan 12, 2016 10:27:19 AM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200083,'Menu favourites',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:27:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:27:18','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','6cc7d70f-6937-4dd0-bb29-1ae097e0e0c1')
;

-- Jan 12, 2016 10:27:27 AM CET
UPDATE AD_Table SET AD_Window_ID=200083,Updated=TO_TIMESTAMP('2016-01-12 10:27:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=456
;

-- Jan 12, 2016 10:27:51 AM CET
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2016-01-12 10:27:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212587
;

-- Jan 12, 2016 10:27:58 AM CET
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2016-01-12 10:27:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212588
;

-- Jan 12, 2016 10:28:03 AM CET
UPDATE AD_Table SET IsHighVolume='Y',Updated=TO_TIMESTAMP('2016-01-12 10:28:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=456
;

-- Jan 12, 2016 10:29:03 AM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200209,'Menu entries','In this tab, you''ll be able to manage favourites and entries which will open automatically on login',200083,10,'N',456,0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','U','Y','N','aca32c5d-0142-42f5-809a-770e152efa85','B')
;

-- Jan 12, 2016 10:29:13 AM CET
UPDATE AD_Tab SET EntityType='D',Updated=TO_TIMESTAMP('2016-01-12 10:29:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200209
;

-- Jan 12, 2016 10:29:17 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204110,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200209,6205,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0740e23c-ec14-40b7-a389-56cee8660550','Y',10,2)
;

-- Jan 12, 2016 10:29:17 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204111,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200209,6206,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5c0062ec-c924-4ef1-871f-f6e184696c2a','Y','Y',20,4,2)
;

-- Jan 12, 2016 10:29:18 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204112,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200209,212589,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','9eae7aa7-cf87-4dc7-b00c-b00ec8a6c18b','Y',30,5)
;

-- Jan 12, 2016 10:29:18 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204113,'Tree','Identifies a Tree','The Tree field identifies a unique Tree in the system. Trees define roll ups or summary levels of information.  They are used in reports for defining report points and summarization levels.',200209,6212,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','62d8ad00-5561-4acb-9cca-4da54c032efc','Y',40,2)
;

-- Jan 12, 2016 10:29:19 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204114,'Node',200209,6213,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b4e6196a-f267-436f-b0a3-fdbd7e1dcba5','Y',50,2)
;

-- Jan 12, 2016 10:29:19 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204115,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200209,6214,'Y',22,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ba68215d-7892-4dc8-99e6-be917d88e551','Y',60,2)
;

-- Jan 12, 2016 10:29:20 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (204116,'AD_TreeBar_UU',200209,60515,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','faf67edd-1c7f-4f41-a90a-7d5aad242f95','N',2)
;

-- Jan 12, 2016 10:29:20 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204117,'Favourite','This record is a favourite',200209,212587,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','87f06de6-7c31-4342-9c9a-8f7884362608','Y',70,2,2)
;

-- Jan 12, 2016 10:29:20 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204118,'Login automatic open sequence','Determine the order items will be automatically opened when user logs in',200209,212588,'Y',10,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1b3476cb-954d-4cc4-8eaf-b7c8cb2d084b','Y',80,2)
;

-- Jan 12, 2016 10:29:21 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204119,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200209,6207,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-12 10:29:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:29:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','741ce933-585b-4ff0-aac0-a8090f9bf61d','Y',90,2,2)
;

-- Jan 12, 2016 10:29:44 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=204113
;

-- Jan 12, 2016 10:29:44 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=204115
;

-- Jan 12, 2016 10:29:44 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=204112
;

-- Jan 12, 2016 10:35:49 AM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200137,'Menu favourites','W',200083,0,0,'Y',TO_TIMESTAMP('2016-01-12 10:35:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-12 10:35:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','Y','4c077852-7b04-4107-a383-f3273363dbf5')
;

-- Jan 12, 2016 10:35:49 AM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200137, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200137)
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=334
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=498
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=224
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=145
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=336
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=341
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=144
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=170
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=465
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200137
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=101
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=294
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=395
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=296
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=221
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=233
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=290
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=109
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200093
;

-- Jan 12, 2016 10:36:19 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=50008
;



SELECT register_migration_script('201609091030_IDEMPIERE-3000.sql') FROM dual
;
