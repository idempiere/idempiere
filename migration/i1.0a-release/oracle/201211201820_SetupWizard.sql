--  201211201820_SetupWizard

--Nov 22, 2012 3:39:39 PM COT
-- IDEMPIERE-393 Setup wizards
ALTER TABLE AD_WizardProcess ADD COLUMN AD_User_ID NUMERIC(10) DEFAULT NULL 
;

-- Nov 15, 2012 5:07:01 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200012,200913,'D','N','N','N',0,'N',30,'N',17,'N',138,'N','Y','286ad460-4317-40f1-afd5-582000e5fe0f','Y','N','AD_User_ID','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact','User/Contact','Y',TO_DATE('2012-11-15 17:07:00','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-11-15 17:07:00','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Nov 15, 2012 5:07:01 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200913 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 20, 2012 11:01:13 AM COT
INSERT INTO AD_Window 
(AD_Window_ID, AD_Client_ID, AD_Org_ID, IsActive, Created, Createdby, Updated, UpdatedBy, Name, Description, WindowType, Issotrx, entitytype, processing, isdefault, winheight, winwidth, isbetafunctionality, ad_window_uu)    
VALUES (200020,0,0,'Y',TO_DATE('2012-11-20 11:01:13','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-11-20 11:34:06','YYYY-MM-DD HH24:MI:SS'),0,'Setup Wizard Maintenance','Maintenance Setup Wizard window','M','N','D','N','N',0,0,'N','ed26f18e-c8d2-4c3c-9a7a-a292429fd1e0')
;

-- Nov 20, 2012 11:04:49
INSERT INTO AD_Tab (AD_Client_ID,AD_Org_ID,AD_Tab_ID,AD_Table_ID,AD_Window_ID,Created,CreatedBy,Description,EntityType,HasTree,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,0,200031,200012,200020,TO_DATE('2012-11-20 11:04:49','YYYY-MM-DD HH24:MI:SS'),0,'Setup Wizard','D','N','Y','N','N','Y','N','N','N','N','Setup Wizard','N',10,0,TO_DATE('2012-11-20 11:04:49','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 11:05:56
INSERT INTO AD_Field 
(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,
IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) 
VALUES ( 0,200315,200842,0,200031,TO_DATE('2012-11-20 11:05:56','YYYY-MM-DD HH24:MI:SS'),0,'Workflow Node (activity), step or process',10,'D','The Workflow Node indicates a unique step or process in a Workflow.','Y','Y','Y','N','N','N','Y','N','Node',TO_DATE('2012-11-20 15:26:20','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 11:05:57
INSERT INTO AD_Field 
(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,
IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) 
VALUES ( 0,200913,200845,0,200031,TO_DATE('2012-11-20 11:05:57','YYYY-MM-DD HH24:MI:SS'),0,'User within the system - Internal or Business Partner Contact',10,'D','The User identifies a unique user in the system. This could be an internal user or a business partner contact','Y','Y','Y','N','N','N','N','N','User/Contact',TO_DATE('2012-11-20 15:26:37','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 11:05:58
INSERT INTO AD_Field 
(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,
IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) 
VALUES ( 0,200310,200847,0,200031,TO_DATE('2012-11-20 11:05:58','YYYY-MM-DD HH24:MI:SS'),0,'',1,'D','','Y','Y','Y','N','N','N','N','N','Wizard Status',TO_DATE('2012-11-20 15:27:05','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 11:05:57
INSERT INTO AD_Field 
(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,
IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) 
VALUES ( 0,200307,200844,0,200031,TO_DATE('2012-11-20 11:05:57','YYYY-MM-DD HH24:MI:SS'),0,'Organizational entity within client',22,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','N','N','N','Y','N','Organization',TO_DATE('2012-11-20 15:27:45','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 11:05:58
INSERT INTO AD_Field 
(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,
IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) 
VALUES ( 0,200313,200846,0,200031,TO_DATE('2012-11-20 11:05:58','YYYY-MM-DD HH24:MI:SS'),0,'',22,'D','','Y','Y','Y','N','N','N','Y','N','Wizard Process',TO_DATE('2012-11-20 15:29:04','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 11:05:55
INSERT INTO AD_Field 
(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,
IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) 
VALUES ( 0,200314,200840,0,200031,TO_DATE('2012-11-20 11:05:55','YYYY-MM-DD HH24:MI:SS'),0,'',36,'D','','Y','Y','Y','N','N','N','Y','N','AD_WizardProcess_UU',TO_DATE('2012-11-20 15:29:04','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 11:05:55
INSERT INTO AD_Field 
(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,
IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) 
VALUES ( 0,200306,200841,0,200031,TO_DATE('2012-11-20 11:05:55','YYYY-MM-DD HH24:MI:SS'),0,'Client/Tenant for this installation.',22,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','Client',TO_DATE('2012-11-20 15:29:04','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 11:05:54
INSERT INTO AD_Field 
(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,
IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) 
VALUES ( 0,200312,200839,0,200031,TO_DATE('2012-11-20 11:05:54','YYYY-MM-DD HH24:MI:SS'),0,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','Y','N','Active',TO_DATE('2012-11-20 15:29:04','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 11:05:56
INSERT INTO AD_Field 
(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,
IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) 
VALUES ( 0,200311,200843,0,200031,TO_DATE('2012-11-20 11:05:56','YYYY-MM-DD HH24:MI:SS'),0,'Optional additional user defined information',2000,'D','The Note field allows for optional entry of user defined information regarding this record','Y','Y','Y','N','N','N','N','N','Note',TO_DATE('2012-11-20 15:29:04','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 12:09:23 PM COT
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,action,AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200020,200026,'N','N','N','D','Y','Setup Wizard Maintenance','W','866bfc16-4543-43ea-856d-85e0c9be6463','Y',0,0,TO_DATE('2012-11-20 12:09:22','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-11-20 12:09:22','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 20, 2012 12:09:23 PM COT
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200026 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Nov 20, 2012 12:09:23 PM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 0, SysDate, 0,t.AD_Tree_ID, 200026, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200026)
;

-- Nov 20, 2012 12:13:06 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53083
;

-- Nov 20, 2012 12:18:55 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-11-20 12:18:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0, SeqNo=10 WHERE AD_Field_ID=200842
;

-- Nov 20, 2012 12:19:56 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-11-20 12:19:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0, XPosition=3, SeqNo=40 WHERE AD_Field_ID=200844
;

-- Nov 20, 2012 12:21:33 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-11-20 12:21:33','YYYY-MM-DD HH24:MI:SS'),SeqNo=50, UpdatedBy=0 WHERE AD_Field_ID=200846
;

-- Nov 20, 2012 12:22:02 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-11-20 12:22:02','YYYY-MM-DD HH24:MI:SS'),SeqNo=60, XPosition=3, UpdatedBy=0 WHERE AD_Field_ID=200840
;

-- Nov 20, 2012 12:22:48 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-11-20 12:22:48','YYYY-MM-DD HH24:MI:SS'),SeqNo=80, XPosition=4, UpdatedBy=0 WHERE AD_Field_ID=200839
;

-- Nov 20, 2012 2:52:50 PM COT
UPDATE AD_Field SET SeqNo=90,NumLines=2, ColumnSpan=3, XPosition=3,Updated=TO_DATE('2012-11-20 14:52:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200843
;

-- Nov 20, 2012 2:55:17 PM COT
UPDATE AD_Field SET SeqNo=20, XPosition=3,Updated=TO_DATE('2012-11-20 14:55:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200845
;

-- Nov 20, 2012 2:55:17 PM COT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2012-11-20 14:55:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200841
;

-- Nov 20, 2012 2:55:17 PM COT
UPDATE AD_Field SET SeqNo=30,Updated=TO_DATE('2012-11-20 14:55:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200847
;

-- Nov 20, 2012 3:04:03 PM COT
INSERT INTO AD_TreeBar (AD_Tree_ID,AD_User_ID,Node_ID, AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy)VALUES (10,0,495,0,0,'Y',SysDate,0,SysDate,0)
;

SELECT register_migration_script('201211201820_SetupWizard.sql') FROM dual
;

