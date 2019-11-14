SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2837 Use in a better way saved searches
-- Nov 13, 2019, 2:21:30 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214110,0,'Window','Data entry or display window','The Window field identifies a unique Window in the system.',814,'AD_Window_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2019-11-13 14:21:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:21:29','YYYY-MM-DD HH24:MI:SS'),100,143,'Y','N','D','N','N','N','Y','93cc9f06-9e31-4c4f-812f-703cdd3e7246','Y',0,'N','N','N','N')
;

-- Nov 13, 2019, 2:21:35 PM CET
UPDATE AD_Column SET FKConstraintName='ADWindow_ADUserQuery', FKConstraintType='N',Updated=TO_DATE('2019-11-13 14:21:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214110
;

-- Nov 13, 2019, 2:21:35 PM CET
ALTER TABLE AD_UserQuery ADD AD_Window_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 13, 2019, 2:21:35 PM CET
ALTER TABLE AD_UserQuery ADD CONSTRAINT ADWindow_ADUserQuery FOREIGN KEY (AD_Window_ID) REFERENCES ad_window(ad_window_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 13, 2019, 2:21:57 PM CET
UPDATE AD_Column SET AD_Val_Rule_ID=163,Updated=TO_DATE('2019-11-13 14:21:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53251
;

-- Nov 13, 2019, 2:22:12 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214111,0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',814,'AD_Role_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2019-11-13 14:22:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:22:12','YYYY-MM-DD HH24:MI:SS'),100,123,'Y','N','D','N','N','N','Y','92d2a43c-1bab-4954-8824-f6ac0b963114','Y',0,'N','N','C','N')
;

-- Nov 13, 2019, 11:26:20 PM CET
UPDATE AD_Column SET FKConstraintName='ADRole_ADUserQuery', FKConstraintType='C',Updated=TO_DATE('2019-11-13 23:26:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214111
;

-- Nov 13, 2019, 11:26:20 PM CET
ALTER TABLE AD_UserQuery ADD AD_Role_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 13, 2019, 11:26:20 PM CET
ALTER TABLE AD_UserQuery ADD CONSTRAINT ADRole_ADUserQuery FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Nov 14, 2019, 12:46:57 AM CET
UPDATE AD_Column SET ReadOnlyLogic='@#ShowAdvanced@=N',Updated=TO_DATE('2019-11-14 00:46:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14361
;

-- Nov 13, 2019, 2:54:10 PM CET
INSERT INTO AD_Window (AD_Window_ID,Name,Description,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200109,'User Queries','View and maintain saved queries',0,0,'Y',TO_DATE('2019-11-13 14:54:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:54:09','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','80f23fc9-ca11-410d-96fa-e77a2c0698cf')
;

-- Nov 13, 2019, 2:55:59 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200275,'User Queries','View and maintain saved queries',200109,10,'Y',814,0,0,'Y',TO_DATE('2019-11-13 14:55:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:55:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','69116c36-1b86-42b5-85a2-6449c466d7c3','B')
;

-- Nov 13, 2019, 2:56:06 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206298,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200275,14350,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a954fc33-69e3-483d-8fae-1fc4236afe9c','Y',10,2)
;

-- Nov 13, 2019, 2:56:07 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206299,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200275,14351,'Y',10,20,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ef5a0c2f-8efc-4d48-b037-7f0eb4b1ea16','Y','Y',20,4,2)
;

-- Nov 13, 2019, 2:56:07 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206300,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200275,14357,'Y',60,30,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f72155fa-cb35-4abf-9a74-3761f78ad058','Y',30,5)
;

-- Nov 13, 2019, 2:56:07 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206301,'Description','Optional short description of the record','A description is limited to 255 characters.',200275,14358,'Y',255,40,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7efba272-19e1-4072-abd9-9141a8d197a2','Y',40,5)
;

-- Nov 13, 2019, 2:56:08 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206302,'User Query','Saved User Query',200275,14349,'N',10,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','63d375de-c962-4247-a72f-e9dcf2230522','N',2)
;

-- Nov 13, 2019, 2:56:08 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206303,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200275,14359,'Y',10,50,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dcba9aa1-8cd6-47e1-9ec6-bbfc18cda40f','Y',50,2)
;

-- Nov 13, 2019, 2:56:08 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206304,'Table','Database Table information','The Database Table provides the information of the table definition',200275,14360,'Y',10,60,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','216bf9c3-a823-4b93-8270-cebecfb4e70b','Y',60,2)
;

-- Nov 13, 2019, 2:56:09 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206305,'Validation code','Validation Code','The Validation Code displays the date, time and message of the error.',200275,14361,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d7328786-3df5-4b0c-ab76-a9f443563524','Y',70,5,5)
;

-- Nov 13, 2019, 2:56:09 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206306,'Tab','Tab within a Window','The Tab indicates a tab that displays within a window.',200275,53251,'Y',10,80,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','616f6380-09c3-4477-ab68-12e0443ec7c1','Y',80,2)
;

-- Nov 13, 2019, 2:56:09 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206307,'AD_UserQuery_UU',200275,60535,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4ab5f1b6-c98a-4229-8dfc-1c20b9baf5bf','N',2)
;

-- Nov 13, 2019, 2:56:10 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206308,'Window','Data entry or display window','The Window field identifies a unique Window in the system.',200275,214110,'Y',22,90,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e9b211a4-d7f1-485f-a7bc-efc5ad4c62e1','Y',90,2)
;

-- Nov 13, 2019, 2:56:10 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206309,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200275,214111,'Y',22,100,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6dfa486a-ae01-4913-b521-a68a97722faa','Y',100,2)
;

-- Nov 13, 2019, 2:56:10 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206310,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200275,14352,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2019-11-13 14:56:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 14:56:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d6eaca4b-2f18-4d1a-bda8-cc0bbfd8e4f6','Y',110,2,2)
;

-- Nov 13, 2019, 2:56:58 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-13 14:56:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206309
;

-- Nov 13, 2019, 2:56:58 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-13 14:56:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206308
;

-- Nov 13, 2019, 2:56:58 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-13 14:56:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206306
;

-- Nov 13, 2019, 2:56:58 PM CET
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-13 14:56:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206304
;

-- Nov 13, 2019, 2:56:58 PM CET
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-13 14:56:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206305
;

-- Nov 13, 2019, 2:56:58 PM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-13 14:56:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206307
;

-- Nov 13, 2019, 2:56:58 PM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-13 14:56:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206302
;

-- Nov 13, 2019, 3:31:38 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200172,'User Queries','View and maintain saved queries','W',200109,0,0,'Y',TO_DATE('2019-11-13 15:31:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-13 15:31:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','d0d9f558-adaa-4ef4-91b7-04b5195d4efa')
;

-- Nov 14, 2019, 12:10:20 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Share search filter with all users',0,0,'Y',TO_DATE('2019-11-14 12:10:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-11-14 12:10:20','YYYY-MM-DD HH24:MI:SS'),100,200581,'ShareFilter','D','9e9e6256-79cf-4dc0-b8c9-f06d0b51797c')
;

-- Nov 13, 2019, 3:31:38 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200172, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200172)
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200172
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200002
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=147
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=150
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53246
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=495
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200017
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50007
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200012
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=362
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=366
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=483
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=368
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=508
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200001
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53201
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=475
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200022
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53348
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53083
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200147
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200148
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200170
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200165
;

-- Nov 13, 2019, 3:32:10 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200171
;

-- Nov 14, 2019, 6:00:32 PM CET
UPDATE AD_Column SET FieldLength=0, ReadOnlyLogic=NULL,Updated=TO_DATE('2019-11-14 18:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14361
;

-- Nov 14, 2019, 6:00:43 PM CET
UPDATE AD_Tab SET ReadOnlyLogic='@#ShowAdvanced@=N',Updated=TO_DATE('2019-11-14 18:00:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200275
;

-- Nov 14, 2019, 6:04:27 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@#ShowAdvanced@=N', IsToolbarButton=NULL,Updated=TO_DATE('2019-11-14 18:04:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12249
;

-- Nov 14, 2019, 6:04:31 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@#ShowAdvanced@=N', IsToolbarButton=NULL,Updated=TO_DATE('2019-11-14 18:04:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12246
;

SELECT register_migration_script('201911141249_IDEMPIERE-2837.sql') FROM dual
;

