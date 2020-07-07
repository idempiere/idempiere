SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1026 Button on table to create automatically the window
-- Jun 19, 2020, 10:31:17 AM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200118,0,0,'Y',TO_DATE('2020-06-19 10:31:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:31:16','YYYY-MM-DD HH24:MI:SS'),100,'Create Window, Tab & Field from Table','Create Window, Tab & Field record of the Table','This process will take the table definition and create the Window/Tab and field record with these options:<br>

New Window: if selected the process will create a new Window record. Otherwise, the process will create a new tab and add it to the selected window.<br>
Create Menu: if selected the process creates the menu record for the new window.','N','AD_Table_CreateWindow','N','org.compiere.process.CreateWindowFromTable','4','D',0,0,'N','N','Y','N','b1753358-c7dd-4387-ab99-355d081a5de2','P')
;

-- Jun 19, 2020, 10:35:37 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203419,0,0,'Y',TO_DATE('2020-06-19 10:35:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:35:36','YYYY-MM-DD HH24:MI:SS'),100,'IsNewWindow','New Window','Defines if it creates a new window record or creates a new tab on an existing window','New Window','D','27a201ff-ce4c-4c82-a218-201e84c621cd')
;

-- Jun 19, 2020, 10:36:10 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200294,0,0,'Y',TO_DATE('2020-06-19 10:36:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:36:10','YYYY-MM-DD HH24:MI:SS'),100,'New Window','Defines if it creates a new window record or creates a new tab on an existing window',200118,10,20,'N',0,'N','Y','IsNewWindow','Y','D',203419,'64bce238-182c-4322-81dc-6f2d1eebabea','N','N')
;

-- Jun 19, 2020, 10:39:08 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,ReadOnlyLogic,DisplayLogic,AD_Process_Para_UU,IsEncrypted,MandatoryLogic,IsAutocomplete) VALUES (200295,0,0,'Y',TO_DATE('2020-06-19 10:39:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:39:07','YYYY-MM-DD HH24:MI:SS'),100,'WindowType','Type or classification of a Window','The Window Type indicates the type of window being defined (Maintain, Transaction or Query)',200118,20,17,108,'N',0,'N','M','WindowType','Y','D',631,NULL,'@IsNewWindow@=''Y''','3ed90248-006a-4679-80a4-d8868f9787f2','N','@IsNewWindow@=''Y''','N')
;

-- Jun 19, 2020, 10:40:38 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200296,0,0,'Y',TO_DATE('2020-06-19 10:40:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:40:37','YYYY-MM-DD HH24:MI:SS'),100,'Sales Transaction','This is a Sales Transaction','The Sales Transaction checkbox indicates if this item is a Sales Transaction.',200118,30,20,'N',1,'N','IsSOTrx','Y','D',1106,'@IsNewWindow@=''Y''','6f0465a6-25c0-44ca-a7c9-7f4f775e8528','N','N')
;

-- Jun 19, 2020, 10:40:44 AM CEST
UPDATE AD_Process_Para SET FieldLength=1,Updated=TO_DATE('2020-06-19 10:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200295
;

-- Jun 19, 2020, 10:40:52 AM CEST
UPDATE AD_Process_Para SET FieldLength=1,Updated=TO_DATE('2020-06-19 10:40:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200294
;

-- Jun 19, 2020, 10:42:38 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203420,0,0,'Y',TO_DATE('2020-06-19 10:42:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:42:37','YYYY-MM-DD HH24:MI:SS'),100,'IsCreateMenu','Create Menu','Defines if it creates a new menu record for the new window','Create Menu','D','2f32e14c-2f68-410e-bf59-100686864549')
;

-- Jun 19, 2020, 10:43:12 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200297,0,0,'Y',TO_DATE('2020-06-19 10:43:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:43:11','YYYY-MM-DD HH24:MI:SS'),100,'Create Menu','Defines if it creates a new menu record for the new window',200118,40,20,'N',1,'N','N','IsCreateMenu','Y','D',203420,'@IsNewWindow@=''Y''','b69cca27-9d64-4ead-83ca-3b01cb3e0e65','N','N')
;

-- Jun 19, 2020, 10:44:27 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,MandatoryLogic,IsAutocomplete) VALUES (200298,0,0,'Y',TO_DATE('2020-06-19 10:44:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:44:26','YYYY-MM-DD HH24:MI:SS'),100,'Window','Data entry or display window','The Window field identifies a unique Window in the system.',200118,50,19,'N',22,'N',NULL,'AD_Window_ID','Y','D',143,'@IsNewWindow@=''N''','555f1f56-c2d6-412f-9d81-bdb8ea7f0a70','N','@IsNewWindow@=''N''','N')
;

-- Jun 19, 2020, 10:45:31 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ValueMin,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,MandatoryLogic,IsAutocomplete) VALUES (200299,0,0,'Y',TO_DATE('2020-06-19 10:45:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:45:30','YYYY-MM-DD HH24:MI:SS'),100,'Tab Level','Hierarchical Tab Level (0 = top)','Hierarchical level of the tab. If the level is 0, it is the top entity. Level 1 entries are dependent on level 0, etc.',200118,60,11,'N',22,'N','0','TabLevel','Y','D',1725,'@IsNewWindow@=''N''','a618adee-33fd-4b4d-9c8d-746e265da407','N','@IsNewWindow@=''N''','N')
;

-- Jun 19, 2020, 10:48:38 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203422,0,0,'Y',TO_DATE('2020-06-19 10:48:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:48:38','YYYY-MM-DD HH24:MI:SS'),100,'CreateWindowFromTable','Create Window From Table','Create Window From Table','D','486d22a4-faaa-4d2e-ba7a-0ba49c40c06b')
;

-- Jun 19, 2020, 10:49:02 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,AD_Process_ID,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,IsHtml) VALUES (214207,1,'Create Window From Table',100,'CreateWindowFromTable',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_DATE('2020-06-19 10:49:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:49:01','YYYY-MM-DD HH24:MI:SS'),100,203422,'Y',200118,'N','D','N','N','N','Y','a68ccf9f-3997-4dab-a7d2-65a17f64d00c','Y','Y','N','N')
;

-- Jun 19, 2020, 10:49:07 AM CEST
ALTER TABLE AD_Table ADD CreateWindowFromTable CHAR(1) DEFAULT NULL 
;

-- Jun 19, 2020, 10:51:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206414,'Create Window From Table',100,214207,'Y',1,230,'N','N','N','N',0,0,'Y',TO_DATE('2020-06-19 10:51:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 10:51:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','083abcc3-842b-498d-a228-514d9d458136','Y',160,2,2,1,'N','N','N','N')
;

-- Jun 19, 2020, 11:09:59 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The table is not valid to create a new window, please verify that it has these columns: AD_Client_ID, AD_Org_ID, Created, CreatedBy, IsActive, Updated, UpdatedBy.',0,0,'Y',TO_DATE('2020-06-19 11:09:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 11:09:57','YYYY-MM-DD HH24:MI:SS'),100,200615,'NewWindowNoValid','D','2bc73265-448f-4102-95f8-da94484e286f')
;

-- Jun 19, 2020, 11:49:59 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Transaction windows require to have a Processed column. Please create the column and try again.',0,0,'Y',TO_DATE('2020-06-19 11:49:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-19 11:49:59','YYYY-MM-DD HH24:MI:SS'),100,200616,'TrxWindowMandatoryProcessed','D','eb358a84-5395-4ee8-9ad6-5c532a2dd6a8')
;

-- Jun 22, 2020, 2:23:37 PM CEST
UPDATE AD_Process_Para SET DefaultValue=NULL,Updated=TO_DATE('2020-06-22 14:23:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200076
;

-- Jun 24, 2020, 1:25:07 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','There is already a window with the name {0}',0,0,'Y',TO_DATE('2020-06-24 13:25:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-24 13:25:07','YYYY-MM-DD HH24:MI:SS'),100,200617,'DuplicatedWindowName','D','12dbf77d-06a0-4300-92e0-ce0c2f1cdedb')
;

-- Jun 24, 2020, 1:30:43 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No column is defined as Parent Link, therefore, the table cannot be a detail tab.',0,0,'Y',TO_DATE('2020-06-24 13:30:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-24 13:30:42','YYYY-MM-DD HH24:MI:SS'),100,200618,'NoParentLink','D','5383b8b1-9434-4148-8ce0-7c901f9e5507')
;

-- Jun 24, 2020, 1:40:00 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The maximum tab level for this window can be {0}.',0,0,'Y',TO_DATE('2020-06-24 13:40:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-24 13:40:00','YYYY-MM-DD HH24:MI:SS'),100,200619,'MaxTabLevel','D','5ceed3b5-080a-4eab-b408-7f4eb2744624')
;

SELECT register_migration_script('202006191355_IDEMPIERE-1026.sql') FROM dual
;

