SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5136
-- Jan 4, 2022, 11:02:53 AM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200191,0,0,TO_DATE('2022-01-04 11:02:53','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2022-01-04 11:02:53','YYYY-MM-DD HH24:MI:SS'),0,0,'Y','MESSAGES_AT_TENANT_LEVEL','N','Turn it to Y to allow loading of tenant level messages (see IDEMPIERE-5136)','D','C','6e180e21-59a8-45c0-83c1-35582ae631c5')
;

-- Jan 4, 2022, 11:03:15 AM CET
UPDATE AD_Table SET AccessLevel='6',Updated=TO_DATE('2022-01-04 11:03:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Table_ID=119
;

-- Jan 4, 2022, 11:03:31 AM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201099,'53b63823-b226-48ff-b99f-8a0f6f948526',TO_DATE('2022-01-04 11:03:30','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','ad_message_trl_pkey',TO_DATE('2022-01-04 11:03:30','YYYY-MM-DD HH24:MI:SS'),0,119,'Y','Y','N','N','Y')
;

-- Jan 4, 2022, 11:03:36 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201447,'867b99df-c3fe-4643-951d-1a057138905a',TO_DATE('2022-01-04 11:03:36','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_DATE('2022-01-04 11:03:36','YYYY-MM-DD HH24:MI:SS'),0,6767,201099,10)
;

-- Jan 4, 2022, 11:03:39 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201448,'d0730eae-18e9-46db-a38f-0992e919139b',TO_DATE('2022-01-04 11:03:38','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_DATE('2022-01-04 11:03:38','YYYY-MM-DD HH24:MI:SS'),0,341,201099,20)
;

-- Jan 4, 2022, 11:03:40 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201449,'b0a1cb37-ff82-4e10-a1e7-0492e69f9b83',TO_DATE('2022-01-04 11:03:40','YYYY-MM-DD HH24:MI:SS'),0,'D','Y',TO_DATE('2022-01-04 11:03:40','YYYY-MM-DD HH24:MI:SS'),0,1192,201099,30)
;

-- Jan 4, 2022, 11:03:44 AM CET
ALTER TABLE AD_Message_Trl DROP CONSTRAINT ad_message_trl_key CASCADE
;

-- Jan 4, 2022, 11:03:44 AM CET
ALTER TABLE AD_Message_Trl ADD CONSTRAINT ad_message_trl_pkey PRIMARY KEY (AD_Message_ID,AD_Language,AD_Client_ID)
;

-- Jan 4, 2022, 11:04:20 AM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200120,'Tenant level messages',0,0,'Y',TO_DATE('2022-01-04 11:04:19','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:19','YYYY-MM-DD HH24:MI:SS'),0,'M','N','D','Y','N',0,0,'N','c58c9213-2d4e-4b9d-ad1f-735c1cc8d3ae')
;

-- Jan 4, 2022, 11:04:50 AM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,WhereClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200302,'Tenant level messages',200120,10,'N',119,0,0,'Y',TO_DATE('2022-01-04 11:04:50','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:50','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N','N','AD_Message_Trl.AD_Client_ID = @#AD_Client_ID@','N','N',0,'N','D','Y','N','64d37a62-cc02-4beb-b3e1-ab7bf6c6f2b7','B','N','Y',0)
;

-- Jan 4, 2022, 11:04:55 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206823,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200302,1192,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-04 11:04:55','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:55','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','9fc4aabb-4b36-4690-a361-8a7a1ba4ddd2','Y',10,2)
;

-- Jan 4, 2022, 11:04:56 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (206824,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200302,1193,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-04 11:04:55','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:55','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','17836fb6-baba-4eac-b652-bb5cf2329781','Y','N',4,2)
;

-- Jan 4, 2022, 11:04:56 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206825,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200302,341,'Y',6,30,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-04 11:04:56','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:56','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','bf20379e-ae47-472b-8e18-7a58a7876a2f','Y',20,2)
;

-- Jan 4, 2022, 11:04:56 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206826,'Message','System Message','Information and Error messages',200302,6767,'Y',22,40,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-04 11:04:56','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:56','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','4caa0815-bc2c-40ee-a547-c462ebb12d9f','Y',30,2)
;

-- Jan 4, 2022, 11:04:57 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206827,'Message Text','Textual Informational, Menu or Error Message','The Message Text indicates the message that will display ',200302,342,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-04 11:04:56','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:56','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','87664b81-2842-4499-bae2-fe72ed13341f','Y',40,5,3)
;

-- Jan 4, 2022, 11:04:57 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206828,'Message Tip','Additional tip or help for this message','The Message Tip defines additional help or information about this message.',200302,343,'Y',2000,60,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-04 11:04:57','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:57','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','00df9659-25af-48d7-918a-3bedf7d05a89','Y',50,5,3)
;

-- Jan 4, 2022, 11:04:57 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206829,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200302,344,'Y',1,70,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-04 11:04:57','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:57','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','c198c571-4669-4695-9e8a-f3b76e651b07','Y',60,2,2)
;

-- Jan 4, 2022, 11:04:57 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206830,'AD_Message_Trl_UU',200302,60435,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-04 11:04:57','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:57','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','db7d3fc0-25e1-4803-9fbf-294c9b99aa44','N',2)
;

-- Jan 4, 2022, 11:04:58 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206831,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200302,608,'Y',1,80,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-04 11:04:57','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:04:57','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','aa09d719-0562-435e-810f-6fd5cc433c7f','Y',70,2,2)
;

-- Jan 4, 2022, 11:05:27 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-04 11:05:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206826
;

-- Jan 4, 2022, 11:05:27 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-04 11:05:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206831
;

-- Jan 4, 2022, 11:05:27 AM CET
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-04 11:05:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206825
;

-- Jan 4, 2022, 11:05:27 AM CET
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-04 11:05:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206827
;

-- Jan 4, 2022, 11:05:27 AM CET
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-04 11:05:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206828
;

-- Jan 4, 2022, 11:05:27 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-04 11:05:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206830
;

-- Jan 4, 2022, 11:05:27 AM CET
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-04 11:05:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206829
;

-- Jan 4, 2022, 11:05:44 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206829
;

-- Jan 4, 2022, 11:05:44 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206823
;

-- Jan 4, 2022, 11:05:44 AM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206826
;

-- Jan 4, 2022, 11:05:44 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206827
;

-- Jan 4, 2022, 11:05:44 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206828
;

-- Jan 4, 2022, 11:05:44 AM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206831
;

-- Jan 4, 2022, 11:06:08 AM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200198,'Tenant level messages','W',0,0,'Y',TO_DATE('2022-01-04 11:06:08','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-04 11:06:08','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','N','D','Y','6a3754ed-8a1b-44b8-8585-1da3d6d5e494')
;

-- Jan 4, 2022, 11:06:08 AM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 0, getDate(), 0,t.AD_Tree_ID, 200198, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200198)
;

-- Jan 4, 2022, 11:06:31 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25,Updated=TO_DATE('2022-01-04 11:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- Jan 4, 2022, 11:06:31 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26,Updated=TO_DATE('2022-01-04 11:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- Jan 4, 2022, 11:06:31 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=27,Updated=TO_DATE('2022-01-04 11:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200150
;

-- Jan 4, 2022, 11:06:31 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=28,Updated=TO_DATE('2022-01-04 11:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200174
;

-- Jan 4, 2022, 11:06:31 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=29,Updated=TO_DATE('2022-01-04 11:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Jan 4, 2022, 11:06:31 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=30,Updated=TO_DATE('2022-01-04 11:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Jan 4, 2022, 11:06:31 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=31,Updated=TO_DATE('2022-01-04 11:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Jan 4, 2022, 11:06:31 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=32,Updated=TO_DATE('2022-01-04 11:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200143
;

-- Jan 4, 2022, 11:06:31 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=33,Updated=TO_DATE('2022-01-04 11:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- Jan 4, 2022, 11:06:31 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=34,Updated=TO_DATE('2022-01-04 11:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200198
;

-- Jan 4, 2022, 11:20:28 AM CET
UPDATE AD_Menu SET AD_Window_ID=200120,Updated=TO_DATE('2022-01-04 11:20:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Menu_ID=200198
;

-- Jan 4, 2022, 11:24:44 AM CET
UPDATE AD_Field SET AD_Reference_ID=18, AD_Reference_Value_ID=327,Updated=TO_DATE('2022-01-04 11:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206825
;

-- Jan 4, 2022, 4:14:20 PM CET
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_DATE('2022-01-04 16:14:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=1192
;

-- Jan 4, 2022, 4:14:40 PM CET
UPDATE AD_Tab SET Name='Client level messages', IsSingleRow='Y',Updated=TO_DATE('2022-01-04 16:14:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=200302
;

-- Jan 4, 2022, 4:14:45 PM CET
UPDATE AD_Window SET Name='Client level messages',Updated=TO_DATE('2022-01-04 16:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Window_ID=200120
;

-- Jan 4, 2022, 4:14:45 PM CET
UPDATE AD_Menu SET Name='Client level messages', Description=NULL, IsActive='Y',Updated=TO_DATE('2022-01-04 16:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Menu_ID=200198
;

-- Jan 4, 2022, 4:38:38 PM CET
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_DATE('2022-01-04 16:38:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206825
;

SELECT register_migration_script('202201041130_IDEMPIERE-5136.sql') FROM dual
;
