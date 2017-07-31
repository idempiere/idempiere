-- Jul 5, 2016 8:48:54 PM MYT
-- 1006079 Ease edit of OnLine Context Help
INSERT INTO AD_Form (AD_Form_ID,Updated,Classname,Created,IsBetaFunctionality,AD_Client_ID,EntityType,Description,Name,AD_Org_ID,UpdatedBy,AccessLevel,CreatedBy,IsActive,AD_Form_UU) VALUES (200010,TO_TIMESTAMP('2016-07-05 20:48:53','YYYY-MM-DD HH24:MI:SS'),'org.adempiere.webui.apps.form.CompareCtxHelpSuggestion',TO_TIMESTAMP('2016-07-05 20:48:53','YYYY-MM-DD HH24:MI:SS'),'N',0,'D','Review changes for context help','Compare Context Help Suggestion',0,100,'4',100,'Y','09e0322d-5eb9-4dc8-a332-7534fac86de0')
;

-- Jul 5, 2016 8:48:55 PM MYT
INSERT INTO AD_Window (AD_Window_ID,AD_Client_ID,AD_Org_ID,Updated,Processing,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,Created,WinHeight,WinWidth,EntityType,Name,UpdatedBy,CreatedBy,Description,AD_Window_UU,IsActive) VALUES (200088,0,0,TO_TIMESTAMP('2016-07-05 20:48:55','YYYY-MM-DD HH24:MI:SS'),'N','M','N','N','N',TO_TIMESTAMP('2016-07-05 20:48:55','YYYY-MM-DD HH24:MI:SS'),0,0,'D','Context Help Suggestion',100,100,'Review context help suggestion from tenant','09616484-7415-4b61-94f5-19ec432650a6','Y')
;

-- Jul 5, 2016 8:48:55 PM MYT
INSERT INTO AD_Menu (AD_Menu_ID,AD_Client_ID,Updated,Created,AD_Menu_UU,IsSummary,"action",IsSOTrx,IsReadOnly,AD_Org_ID,UpdatedBy,CreatedBy,IsCentrallyMaintained,Name,IsActive,AD_Window_ID,EntityType) VALUES (200143,0,TO_TIMESTAMP('2016-07-05 20:48:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2016-07-05 20:48:55','YYYY-MM-DD HH24:MI:SS'),'05a76d62-2448-4629-92fd-5b17d76e7f8f','N','W','N','N',0,100,100,'Y','Context Help Suggestion','Y',200088,'D')
;

-- Jul 5, 2016 8:48:55 PM MYT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200143, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=116 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200143)
;

-- Jul 5, 2016 8:48:55 PM MYT
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 153,28, 10, 200143)
;

-- Jul 5, 2016 8:49:07 PM MYT
INSERT INTO AD_Table (AD_Table_ID,AD_Client_ID,ImportTable,CopyColumnsFromTable,AccessLevel,IsHighVolume,IsDeleteable,IsView,AD_Org_ID,IsChangeLog,Created,Updated,ReplicationType,EntityType,UpdatedBy,CreatedBy,IsCentrallyMaintained,TableName,Description,Name,IsSecurityEnabled,IsActive,AD_Table_UU,Processing,DatabaseViewDrop,LoadSeq) VALUES (200210,0,'N','N','4','N','N','N',0,'N',TO_TIMESTAMP('2016-07-05 20:49:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2016-07-05 20:49:07','YYYY-MM-DD HH24:MI:SS'),'L','D',100,100,'Y','AD_CtxHelpSuggestion','Suggestion for context help content','Context Help Suggestion','N','Y','5da7de59-f193-4b03-afe7-f53f381fbe3a','N','N',0)
;

-- Jul 5, 2016 8:49:08 PM MYT
INSERT INTO AD_Sequence (AD_Sequence_ID,AD_Org_ID,Updated,UpdatedBy,CreatedBy,IsTableID,CurrentNext,IsAutoSequence,StartNo,IsAudited,CurrentNextSys,AD_Client_ID,Created,Name,Description,IncrementNo,StartNewYear,AD_Sequence_UU,IsActive) VALUES (200289,0,TO_TIMESTAMP('2016-07-05 20:49:08','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',1000000,'Y',1000000,'N',200000,0,TO_TIMESTAMP('2016-07-05 20:49:08','YYYY-MM-DD HH24:MI:SS'),'AD_CtxHelpSuggestion','Table AD_CtxHelpSuggestion',1,'N','bdbdb075-36e3-4046-89ad-e15a84fe6502','Y')
;

-- Jul 5, 2016 8:49:09 PM MYT
INSERT INTO AD_Element (AD_Element_ID,Updated,Created,AD_Client_ID,Name,PrintName,ColumnName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,EntityType) VALUES (203026,TO_TIMESTAMP('2016-07-05 20:49:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2016-07-05 20:49:08','YYYY-MM-DD HH24:MI:SS'),0,'Context Help Suggestion','Context Help Suggestion','AD_CtxHelpSuggestion_ID','f06b6b92-3e7f-42f6-90ed-65b80dfd6fa5',0,100,100,'Y','D')
;

-- Jul 5, 2016 8:49:09 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212800,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:09','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,0,22,'Y','N',TO_TIMESTAMP('2016-07-05 20:49:09','YYYY-MM-DD HH24:MI:SS'),'N','N','N',100,'N','AD_CtxHelpSuggestion_ID','Context Help Suggestion','N','bbffa49b-d465-4013-8ee4-af498c5c9350',100,'Y','N','N',203026,13,200210)
;

-- Jul 5, 2016 8:49:09 PM MYT
CREATE TABLE AD_CtxHelpSuggestion (AD_CtxHelpSuggestion_ID NUMERIC(10) NOT NULL, CONSTRAINT AD_CtxHelpSuggestion_Key PRIMARY KEY (AD_CtxHelpSuggestion_ID))
;

-- Jul 5, 2016 8:49:10 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,AD_Val_Rule_ID,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,DefaultValue,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212797,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:10','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,22,'N','N',129,TO_TIMESTAMP('2016-07-05 20:49:10','YYYY-MM-DD HH24:MI:SS'),'N','N','Y',100,'N','Client/Tenant for this installation.','AD_Client_ID','Client','@#AD_Client_ID@','N','7b636940-4f00-4786-933a-cb1eb80d93f1',100,'Y','N','D',102,19,200210)
;

-- Jul 5, 2016 8:49:10 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN AD_Client_ID NUMERIC(10) NOT NULL
;

-- Jul 5, 2016 8:49:10 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Version,FieldLength,IsKey,IsTranslated,AD_Val_Rule_ID,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212798,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:10','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,0,10,'N','N',200030,TO_TIMESTAMP('2016-07-05 20:49:10','YYYY-MM-DD HH24:MI:SS'),'N','N','Y',100,'N','AD_CtxHelp_ID','Context Help','Y','f8ca41fa-783b-4a5d-9e25-efa8059f5dfe',100,'Y','N','N','ADCtxHelp_ADCtxHelpSuggestion',202212,19,200210)
;

-- Jul 5, 2016 8:49:11 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN AD_CtxHelp_ID NUMERIC(10) NOT NULL
;

-- Jul 5, 2016 8:49:11 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212799,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:11','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,0,22,'N','N',TO_TIMESTAMP('2016-07-05 20:49:11','YYYY-MM-DD HH24:MI:SS'),'N','N','Y',100,'N','AD_CtxHelpMsg_ID','Context Help Message','N','5a7abfbc-fd0b-40b7-9265-fea9511d705d',100,'Y','N','N','ADCtxHelpMsg_ADCtxHelpSuggesti',202215,19,200210)
;

-- Jul 5, 2016 8:49:11 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN AD_CtxHelpMsg_ID NUMERIC(10) NOT NULL
;

-- Jul 5, 2016 8:49:11 PM MYT
INSERT INTO AD_Element (AD_Element_ID,Updated,Created,AD_Client_ID,Name,PrintName,ColumnName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,EntityType) VALUES (203027,TO_TIMESTAMP('2016-07-05 20:49:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2016-07-05 20:49:11','YYYY-MM-DD HH24:MI:SS'),0,'Context Help Suggestion UUID','Context Help Suggestion UUID','AD_CtxHelpSuggestion_UU','9d382e5d-4478-40d7-b65f-9b30f78fd224',0,100,100,'Y','D')
;

-- Jul 5, 2016 8:49:12 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212801,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:11','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,0,36,'N','N',TO_TIMESTAMP('2016-07-05 20:49:11','YYYY-MM-DD HH24:MI:SS'),'N','N','N',100,'N','AD_CtxHelpSuggestion_UU','Context Help Suggestion UUID','N','b99875c8-9475-4fc6-b850-9e870ddbbb0b',100,'Y','N','N',203027,10,200210)
;

-- Jul 5, 2016 8:49:12 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN AD_CtxHelpSuggestion_UU VARCHAR(36) NOT NULL
;

-- Jul 5, 2016 8:49:12 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD CONSTRAINT AD_CtxHelpSuggestion_UU_idx UNIQUE (AD_CtxHelpSuggestion_UU)
;

-- Jul 5, 2016 8:49:12 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (0,212802,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:12','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'The Language identifies the language to use for display and formatting',0,6,'N','N',TO_TIMESTAMP('2016-07-05 20:49:12','YYYY-MM-DD HH24:MI:SS'),'N','N','Y',100,'Y','Language for this entity','AD_Language','Language','N','99787bb4-ac50-447a-905a-85cc98c2dc72',100,'Y','N','N','ADLanguage_ADCtxHelpSuggestion',109,18,106,200210)
;

-- Jul 5, 2016 8:49:12 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN AD_Language VARCHAR(6) NOT NULL
;

-- Jul 5, 2016 8:49:13 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,AD_Val_Rule_ID,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,DefaultValue,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212803,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:12','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',0,22,'N','N',104,TO_TIMESTAMP('2016-07-05 20:49:12','YYYY-MM-DD HH24:MI:SS'),'N','N','Y',100,'N','Organizational entity within client','AD_Org_ID','Organization','@#AD_Org_ID@','N','2dcae5cd-6fdb-436d-afeb-ae8098ab0b7f',100,'Y','N','D',113,19,200210)
;

-- Jul 5, 2016 8:49:13 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN AD_Org_ID NUMERIC(10) NOT NULL
;

-- Jul 5, 2016 8:49:13 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (0,212804,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:13','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,0,10,'N','N',TO_TIMESTAMP('2016-07-05 20:49:13','YYYY-MM-DD HH24:MI:SS'),'N','N','Y',100,'N','AD_UserClient_ID','Tenant of User','N','6c813190-2366-445e-a57e-c07d8ad0b039',100,'Y','N','N','ADUserClient_ADCtxHelpSuggesti',203019,18,129,200210)
;

-- Jul 5, 2016 8:49:13 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN AD_UserClient_ID NUMERIC(10) NOT NULL
;

-- Jul 5, 2016 8:49:14 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212805,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:14','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'The User identifies a unique user in the system. This could be an internal user or a business partner contact',0,10,'N','N',TO_TIMESTAMP('2016-07-05 20:49:14','YYYY-MM-DD HH24:MI:SS'),'N','N','N',100,'N','User within the system - Internal or Business Partner Contact','AD_User_ID','User/Contact','N','17f91d87-08bd-4922-ad15-e5e53f47b955',100,'Y','N','N','ADUser_ADCtxHelpSuggestion',138,19,200210)
;

-- Jul 5, 2016 8:49:14 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN AD_User_ID NUMERIC(10) NOT NULL
;

-- Jul 5, 2016 8:49:14 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,DefaultValue,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212806,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:14','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'The Created field indicates the date that this record was created.',0,7,'N','N',TO_TIMESTAMP('2016-07-05 20:49:14','YYYY-MM-DD HH24:MI:SS'),'N','N','N',100,'N','Date this record was created','Created','Created','SYSDATE','N','9b44d677-9e7a-4773-895a-5de84574cbe1',100,'Y','N','N',245,16,200210)
;

-- Jul 5, 2016 8:49:14 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Jul 5, 2016 8:49:15 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (0,212807,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:15','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'The Created By field indicates the user who created this record.',0,22,'N','N',TO_TIMESTAMP('2016-07-05 20:49:15','YYYY-MM-DD HH24:MI:SS'),'N','N','N',100,'N','User who created this records','CreatedBy','Created By','N','023f197c-3fd7-4838-825b-4da2c1629e47',100,'Y','N','D',246,18,110,200210)
;

-- Jul 5, 2016 8:49:15 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN CreatedBy NUMERIC(10) NOT NULL
;

-- Jul 5, 2016 8:49:15 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212808,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:15','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'The Message Text indicates the message that will display ',0,2000,'N','N',TO_TIMESTAMP('2016-07-05 20:49:15','YYYY-MM-DD HH24:MI:SS'),'Y','N','Y',100,'Y','Textual Informational, Menu or Error Message','MsgText','Message Text','N','34f589b2-f0bd-4c2f-96be-a48bd7ecfbbd',100,'Y','N','N',463,14,200210)
;

-- Jul 5, 2016 8:49:15 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN MsgText VARCHAR(2000) NOT NULL
;

-- Jul 5, 2016 8:49:16 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,DefaultValue,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212809,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:16','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,1,'N','N',TO_TIMESTAMP('2016-07-05 20:49:16','YYYY-MM-DD HH24:MI:SS'),'Y','N','Y',100,'N','The record is active in the system','IsActive','Active','Y','N','e86dd94b-8edd-4dc3-91c5-01e4fb268140',100,'Y','N','N',348,20,200210)
;

-- Jul 5, 2016 8:49:16 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jul 5, 2016 8:49:16 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,DefaultValue,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212810,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:16','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'The Approved checkbox indicates if this document requires approval before it can be processed.',0,1,'N','N',TO_TIMESTAMP('2016-07-05 20:49:16','YYYY-MM-DD HH24:MI:SS'),'Y','N','Y',100,'N','Indicates if this document requires approval','IsApproved','Approved','N','N','6ef2b833-9691-4353-ad1b-d2b09ab90803',100,'Y','N','N',351,20,200210)
;

-- Jul 5, 2016 8:49:17 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN IsApproved CHAR(1) DEFAULT 'N' CHECK (IsApproved IN ('Y','N')) NOT NULL
;

-- Jul 5, 2016 8:49:17 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,DefaultValue,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212811,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:17','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'The Processed checkbox indicates that a document has been processed.',0,1,'N','N',TO_TIMESTAMP('2016-07-05 20:49:17','YYYY-MM-DD HH24:MI:SS'),'Y','N','Y',100,'N','The document has been processed','Processed','Processed','N','N','0c0cde02-0b0e-4ff3-95e7-df230cc96d0a',100,'Y','N','N',1047,20,200210)
;

-- Jul 5, 2016 8:49:17 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN Processed CHAR(1) DEFAULT 'N' CHECK (Processed IN ('Y','N')) NOT NULL
;

-- Jul 5, 2016 8:49:18 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,DefaultValue,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212812,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:17','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'The Updated field indicates the date that this record was updated.',0,7,'N','N',TO_TIMESTAMP('2016-07-05 20:49:17','YYYY-MM-DD HH24:MI:SS'),'Y','N','Y',100,'N','Date this record was updated','Updated','Updated','SYSDATE','N','e52797cb-9333-4ade-b80f-d58594f31a17',100,'Y','N','N',607,16,200210)
;

-- Jul 5, 2016 8:49:18 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Jul 5, 2016 8:49:18 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (0,212813,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:18','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'The Updated By field indicates the user who updated this record.',0,22,'N','N',TO_TIMESTAMP('2016-07-05 20:49:18','YYYY-MM-DD HH24:MI:SS'),'Y','N','Y',100,'N','User who updated this records','UpdatedBy','Updated By','N','3927ef9f-a095-4589-ab18-4fa7494ca478',100,'Y','N','D',608,18,110,200210)
;

-- Jul 5, 2016 8:49:18 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN UpdatedBy NUMERIC(10) NOT NULL
;

-- Jul 5, 2016 8:49:19 PM MYT
INSERT INTO AD_Process (AD_Process_ID,Classname,Created,CreatedBy,Value,CopyFromProcess,AD_Process_UU,IsReport,AccessLevel,IsDirectPrint,IsBetaFunctionality,Updated,IsServerProcess,AD_Client_ID,ShowHelp,EntityType,Name,Statistic_Seconds,Statistic_Count,UpdatedBy,Description,IsActive,AD_Org_ID) VALUES (200096,'org.adempiere.base.process.AcceptCtxHelpSuggestion',TO_TIMESTAMP('2016-07-05 20:49:19','YYYY-MM-DD HH24:MI:SS'),100,'AcceptCtxHelpSuggestion','N','dbabdf46-c3bc-4e02-ab0a-f61f6ae60b4b','N','4','N','N',TO_TIMESTAMP('2016-07-05 20:49:19','YYYY-MM-DD HH24:MI:SS'),'N',0,'Y','D','Accept Context Help Suggestion',4,4,100,'Accept suggested changes for context help','Y',0)
;

-- Jul 5, 2016 8:49:19 PM MYT
INSERT INTO AD_Element (AD_Element_ID,Updated,Help,Created,AD_Client_ID,Description,Name,PrintName,ColumnName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,EntityType) VALUES (203028,TO_TIMESTAMP('2016-07-05 20:49:19','YYYY-MM-DD HH24:MI:SS'),'Changes is keep as tenant specific customization and wouldn''t effect other tenants in the system',TO_TIMESTAMP('2016-07-05 20:49:19','YYYY-MM-DD HH24:MI:SS'),0,'Apply changes as tenant customization','Save As Tenant Customization','Save As Tenant Customization','IsSaveAsTenantCustomization','d41d4789-83ca-4fc6-aa4b-75889746bf81',0,100,100,'Y','D')
;

-- Jul 5, 2016 8:49:20 PM MYT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,Updated,IsEncrypted,Help,AD_Reference_ID,SeqNo,FieldLength,IsRange,IsCentrallyMaintained,IsMandatory,Created,AD_Client_ID,EntityType,Name,Description,ColumnName,UpdatedBy,AD_Org_ID,CreatedBy,DefaultValue,IsActive,AD_Process_Para_UU,AD_Element_ID,AD_Process_ID) VALUES (200178,TO_TIMESTAMP('2016-07-05 20:49:19','YYYY-MM-DD HH24:MI:SS'),'N','Changes is keep as tenant specific customization and wouldn''t effect other tenants in the system',20,10,1,'N','Y','Y',TO_TIMESTAMP('2016-07-05 20:49:19','YYYY-MM-DD HH24:MI:SS'),0,'D','Save As Tenant Customization','Apply changes as tenant customization','IsSaveAsTenantCustomization',100,0,100,'N','Y','b6836b0b-6d3a-4f4a-8344-05fd04ee1ffa',203028,200096)
;

-- Jul 5, 2016 8:49:20 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Version,FieldLength,IsKey,IsTranslated,AD_Process_ID,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212814,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:20','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','N','N',0,0,1,'N','N',200096,TO_TIMESTAMP('2016-07-05 20:49:20','YYYY-MM-DD HH24:MI:SS'),'Y','N','N',100,'N','Accept suggested changes','AcceptSuggestion','Accept','N','6523b5b2-7f9e-4595-9976-1a0550ec9b35',100,'Y','N','N',203023,28,200210)
;

-- Jul 5, 2016 8:49:20 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN AcceptSuggestion CHAR(1) DEFAULT NULL 
;

-- Jul 5, 2016 8:49:21 PM MYT
INSERT INTO AD_Process (AD_Process_ID,Classname,Created,CreatedBy,Value,CopyFromProcess,AD_Process_UU,IsReport,AccessLevel,IsDirectPrint,IsBetaFunctionality,Updated,IsServerProcess,AD_Client_ID,ShowHelp,EntityType,Name,Statistic_Seconds,Statistic_Count,UpdatedBy,Description,IsActive,AD_Org_ID) VALUES (200097,'org.adempiere.base.process.RejectCtxHelpSuggestion',TO_TIMESTAMP('2016-07-05 20:49:21','YYYY-MM-DD HH24:MI:SS'),100,'RejectCtxHelpSuggestion','N','9e375e8d-dfff-446d-be92-8a6104c76717','N','4','N','N',TO_TIMESTAMP('2016-07-05 20:49:21','YYYY-MM-DD HH24:MI:SS'),'N',0,'Y','D','Reject Context Help Suggestion',1,1,100,'Reject suggested changes for context help','Y',0)
;

-- Jul 5, 2016 8:49:21 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Version,FieldLength,IsKey,IsTranslated,AD_Process_ID,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212815,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:21','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','N','N',0,0,1,'N','N',200097,TO_TIMESTAMP('2016-07-05 20:49:21','YYYY-MM-DD HH24:MI:SS'),'Y','N','N',100,'N','Reject suggested changes','RejectSuggestion','Reject','N','0cd1e13e-0b60-4d46-9e1e-dc01ca5243b3',100,'Y','N','N',203022,28,200210)
;

-- Jul 5, 2016 8:49:21 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN RejectSuggestion CHAR(1) DEFAULT NULL 
;

-- Jul 5, 2016 8:49:22 PM MYT
INSERT INTO AD_Process (AD_Process_ID,Created,CreatedBy,Value,CopyFromProcess,AD_Process_UU,IsReport,AccessLevel,IsDirectPrint,IsBetaFunctionality,Updated,IsServerProcess,AD_Client_ID,ShowHelp,EntityType,Name,Statistic_Seconds,Statistic_Count,UpdatedBy,IsActive,AD_Org_ID,AD_Form_ID) VALUES (200098,TO_TIMESTAMP('2016-07-05 20:49:22','YYYY-MM-DD HH24:MI:SS'),100,'CompareCtxHelpSuggestion','N','830ac0f4-128c-4e61-9cb7-f2bb6bdcb7d0','N','4','N','N',TO_TIMESTAMP('2016-07-05 20:49:22','YYYY-MM-DD HH24:MI:SS'),'N',0,'N','D','Compare Context Help Suggestion',0,0,100,'Y',0,200010)
;

-- Jul 5, 2016 8:49:22 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Version,FieldLength,IsKey,IsTranslated,AD_Process_ID,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212816,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:22','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','N','N',0,0,1,'N','N',200098,TO_TIMESTAMP('2016-07-05 20:49:22','YYYY-MM-DD HH24:MI:SS'),'Y','N','N',100,'N','Compare suggested text with original text','CompareSuggestion','Compare','N','b995f823-f29c-43e7-8d27-8a7f072ed83e',100,'Y','N','N',203024,28,200210)
;

-- Jul 5, 2016 8:49:22 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN CompareSuggestion CHAR(1) DEFAULT NULL 
;

-- Jul 5, 2016 8:49:23 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,DefaultValue,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212817,'N','Y',0,0,TO_TIMESTAMP('2016-07-05 20:49:23','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,'Changes is keep as tenant specific customization and wouldn''t effect other tenants in the system',0,1,'N','N',TO_TIMESTAMP('2016-07-05 20:49:23','YYYY-MM-DD HH24:MI:SS'),'Y','N','Y',100,'N','Apply changes as tenant customization','IsSaveAsTenantCustomization','Save As Tenant Customization','N','N','54b65699-0feb-4537-bdb3-cd20c0b1c24d',100,'Y','N','N',203028,20,200210)
;

-- Jul 5, 2016 8:49:23 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD COLUMN IsSaveAsTenantCustomization CHAR(1) DEFAULT 'N' CHECK (IsSaveAsTenantCustomization IN ('Y','N')) NOT NULL
;

-- Jul 5, 2016 8:49:24 PM MYT
INSERT INTO AD_Tab (ImportFields,Processing,AD_Client_ID,AD_Org_ID,Updated,EntityType,WhereClause,IsSingleRow,SeqNo,HasTree,AD_Tab_ID,IsReadOnly,IsSortTab,TabLevel,Created,IsInsertRecord,IsAdvancedTab,CreatedBy,Name,UpdatedBy,IsTranslationTab,IsInfoTab,IsActive,AD_Tab_UU,AD_Table_ID,TreeDisplayedOn,AD_Window_ID) VALUES ('N','N',0,0,TO_TIMESTAMP('2016-07-05 20:49:23','YYYY-MM-DD HH24:MI:SS'),'D','Processed=''N''','Y',10,'N',200216,'N','N',0,TO_TIMESTAMP('2016-07-05 20:49:23','YYYY-MM-DD HH24:MI:SS'),'Y','N',100,'Suggestion',100,'N','N','Y','335fe0e0-5044-4262-9e4b-0fdfe35a38fd',200210,'M',200088)
;

-- Jul 5, 2016 8:49:24 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204252,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:24','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N','N',0,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:24','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Context Help Suggestion','N',22,'7a65e820-9743-4835-b97b-c6c1e80766a6','Y',1,'N','N',212800,200216)
;

-- Jul 5, 2016 8:49:24 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204253,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:24','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N','Y',0,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:24','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Context Help Suggestion UUID','N',36,'2f9a21c3-5a52-42e2-a03c-169c6165f885','Y',1,'N','N',212801,200216)
;

-- Jul 5, 2016 8:49:25 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,Help,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204258,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:25','YYYY-MM-DD HH24:MI:SS'),'N','The Approved checkbox indicates if this document requires approval before it can be processed.','N','N','N','Y',0,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:25','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Approved','Indicates if this document requires approval','N',1,'e7670815-650e-4169-a0a8-102c07fe7318','Y',1,'N','N',212810,200216)
;

-- Jul 5, 2016 8:49:25 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,Help,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204259,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:25','YYYY-MM-DD HH24:MI:SS'),'N','The Processed checkbox indicates that a document has been processed.','N','N','N','Y',0,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:25','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Processed','The document has been processed','N',1,'6bb39c69-3ce1-4ed4-93d9-5f45692e28d3','Y',1,'N','N',212811,200216)
;

-- Jul 5, 2016 8:49:25 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,Help,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204263,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:25','YYYY-MM-DD HH24:MI:SS'),'N','Changes is keep as tenant specific customization and wouldn''t effect other tenants in the system','N','N','N','Y',0,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:25','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Save As Tenant Customization','Apply changes as tenant customization','N',1,'9fefd083-93e6-4c26-b059-0f9c781e9879','Y',1,'N','N',212817,200216)
;

-- Jul 5, 2016 8:49:25 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204251,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:25','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N','Y',0,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:25','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Context Help Message','N',22,'b090049b-8417-489f-88bc-18571ec62b60','Y',1,'N','N',212799,200216)
;

-- Jul 5, 2016 8:49:26 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,Help,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204248,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:26','YYYY-MM-DD HH24:MI:SS'),'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','N','N',10,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:26','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Client','Client/Tenant for this installation.','N',22,'1a29ddcf-ff2c-4834-8119-6c7b35fcfa78','Y',1,'N','N',212797,200216)
;

-- Jul 5, 2016 8:49:26 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,IsAllowCopy,Help,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204249,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:26','YYYY-MM-DD HH24:MI:SS'),'N','Y','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','N','N',20,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:26','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Organization','Organizational entity within client','N',22,'d7fa999d-4130-4b8c-b5aa-a8c1df846a29','Y',4,'N','N',212803,200216)
;

-- Jul 5, 2016 8:49:26 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204250,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:26','YYYY-MM-DD HH24:MI:SS'),'N','Y','N','N','Y',30,'Y','Y',TO_TIMESTAMP('2016-07-05 20:49:26','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Context Help','N',10,'f3ca9572-0e9c-486e-8f2b-0b5f8413048e','Y',1,'N','N',212798,200216)
;

-- Jul 5, 2016 8:49:27 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,Help,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204254,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:27','YYYY-MM-DD HH24:MI:SS'),'N','The Language identifies the language to use for display and formatting','Y','N','N','Y',40,'Y','Y',TO_TIMESTAMP('2016-07-05 20:49:27','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Language','Language for this entity','N',6,'e019e08d-63d0-411f-8812-e5a9120f2caa','Y',4,'N','N',212802,200216)
;

-- Jul 5, 2016 8:49:27 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,Help,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204256,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:27','YYYY-MM-DD HH24:MI:SS'),'N','The User identifies a unique user in the system. This could be an internal user or a business partner contact','Y','N','N','Y',50,'Y','Y',TO_TIMESTAMP('2016-07-05 20:49:27','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'User/Contact','User within the system - Internal or Business Partner Contact','N',10,'6cdb0b43-9888-48ef-bfec-58965b0a3789','Y',1,'N','N',212805,200216)
;

-- Jul 5, 2016 8:49:27 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204255,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:27','YYYY-MM-DD HH24:MI:SS'),'N','Y','N','N','Y',60,'Y','Y',TO_TIMESTAMP('2016-07-05 20:49:27','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Tenant of User','N',10,'3cf3f5e9-180a-4023-8c89-c299d393fc72','Y',4,'N','N',212804,200216)
;

-- Jul 5, 2016 8:49:28 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,Help,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204264,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:27','YYYY-MM-DD HH24:MI:SS'),'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','N','Y',70,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:27','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Active','The record is active in the system','N',1,'6e82ce54-836f-4ef7-8d90-3b4624deb3c6','Y',2,'N','N',212809,200216)
;

-- Jul 5, 2016 8:49:28 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,Help,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (5,8,204257,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:28','YYYY-MM-DD HH24:MI:SS'),'N','The Message Text indicates the message that will display ','Y','N','N','Y',80,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:28','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Message Text','Textual Informational, Menu or Error Message','N',2000,'cb0bef2e-0e8c-4f8b-8d5a-da88453eca18','Y',1,'N','N',212808,200216)
;

-- Jul 5, 2016 8:49:28 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204262,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:28','YYYY-MM-DD HH24:MI:SS'),'N','Y','N','N','Y',90,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:28','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Compare','Compare suggested text with original text','N',1,'58fd277a-85e0-48e8-b15d-77ceccfec563','Y',2,'N','N',212816,200216)
;

-- Jul 5, 2016 8:49:28 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204261,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:28','YYYY-MM-DD HH24:MI:SS'),'N','Y','N','N','Y',100,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:28','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Reject','Reject suggested changes','N',1,'f5e8615b-43ef-4681-9a3f-e84cda031a7d','Y',2,'N','N',212815,200216)
;

-- Jul 5, 2016 8:49:29 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204260,'N',0,0,TO_TIMESTAMP('2016-07-05 20:49:28','YYYY-MM-DD HH24:MI:SS'),'N','Y','N','N','Y',110,'N','Y',TO_TIMESTAMP('2016-07-05 20:49:28','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Accept','Accept suggested changes','N',1,'c0c7dcde-67ee-4b93-8587-1396dd215355','Y',5,'N','N',212814,200216)
;

-- Jul 5, 2016 8:49:30 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD CONSTRAINT ADCtxHelp_ADCtxHelpSuggestion FOREIGN KEY (AD_CtxHelp_ID) REFERENCES ad_ctxhelp(ad_ctxhelp_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 5, 2016 8:49:32 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD CONSTRAINT ADCtxHelpMsg_ADCtxHelpSuggesti FOREIGN KEY (AD_CtxHelpMsg_ID) REFERENCES ad_ctxhelpmsg(ad_ctxhelpmsg_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 5, 2016 8:49:32 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD CONSTRAINT ADLanguage_ADCtxHelpSuggestion FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 5, 2016 8:49:32 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD CONSTRAINT ADUserClient_ADCtxHelpSuggesti FOREIGN KEY (AD_UserClient_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 5, 2016 8:49:32 PM MYT
ALTER TABLE AD_CtxHelpSuggestion ADD CONSTRAINT ADUser_ADCtxHelpSuggestion FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201607051800_Ticket_1006079.sql') FROM dual
;

