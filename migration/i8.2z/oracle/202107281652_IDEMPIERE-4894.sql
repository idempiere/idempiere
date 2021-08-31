SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4894 OSGi Interface to support custom header and footer
INSERT INTO AD_Table (AccessLevel,AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES ('4',0,0,200240,'4e785f3f-dce9-4f27-900a-504122d447d0',TO_DATE('2021-07-28 17:00:08','YYYY-MM-DD HH24:MI:SS'),100,NULL,'D','Y','Y','Y','Y','N','N','N',145,'Print Header/Footer','N','L','AD_PrintHeaderFooter',TO_DATE('2021-07-28 17:00:08','YYYY-MM-DD HH24:MI:SS'),100)
;

-- July 28, 2021 5:00:11 PM SGT
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200304,'55b3e131-60d2-46fa-9665-ba039f2f37ee',TO_DATE('2021-07-28 17:00:10','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table AD_PrintHeaderFooter',1,'Y','N','Y','Y','AD_PrintHeaderFooter','N',1000000,TO_DATE('2021-07-28 17:00:10','YYYY-MM-DD HH24:MI:SS'),100)
;

-- July 28, 2021 5:00:32 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200003, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200003)
;

-- July 28, 2021 5:00:34 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,FKConstraintType,AD_Element_ID,AD_Val_Rule_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213508,'N',1,'Y','N','N','N',22,'N','N','N','N','d49721fe-2f15-43e9-ba7a-b7472cc06304',TO_DATE('2021-07-28 17:00:32','YYYY-MM-DD HH24:MI:SS'),'N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:32','YYYY-MM-DD HH24:MI:SS'),'N','D','N','D',102,129,200240,19,'N')
;

-- July 28, 2021 5:00:37 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203210,'AD_PrintHeaderFooter_ID',TO_DATE('2021-07-28 17:00:35','YYYY-MM-DD HH24:MI:SS'),'Print Header/Footer','Print Header/Footer','1c0cdce7-c3ca-4cdd-8ce2-154f0bf3c826','Y',TO_DATE('2021-07-28 17:00:35','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- July 28, 2021 5:00:38 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213509,'N',1,'Y','N','N','N',22,'N','Y','N','N','2ab090db-0460-49a6-b263-ab555919fac7',TO_DATE('2021-07-28 17:00:35','YYYY-MM-DD HH24:MI:SS'),'N','AD_PrintHeaderFooter_ID','Print Header/Footer','N','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:35','YYYY-MM-DD HH24:MI:SS'),'N','D','N',203210,200240,13,'N')
;

-- July 28, 2021 5:00:40 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203211,'AD_PrintHeaderFooter_UU',TO_DATE('2021-07-28 17:00:38','YYYY-MM-DD HH24:MI:SS'),'AD_PrintHeaderFooter_UU','AD_PrintHeaderFooter_UU','b38888ed-e649-4d99-a6b4-206305fba4af','Y',TO_DATE('2021-07-28 17:00:38','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- July 28, 2021 5:00:42 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213510,'N',1.00,'N','N','N','N',36,'N','N','N','Y','96f6a17f-1cbb-46a5-8071-a416efa85693',TO_DATE('2021-07-28 17:00:38','YYYY-MM-DD HH24:MI:SS'),'Y','AD_PrintHeaderFooter_UU','AD_PrintHeaderFooter_UU','N','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:38','YYYY-MM-DD HH24:MI:SS'),'N','D','N',203211,200240,10,'N')
;

-- July 28, 2021 5:00:43 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,FKConstraintType,AD_Element_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213511,'N',1,'N','N','N','N',6,'N','N','N','Y','b9230734-b179-4c64-9cf8-ecec62fc6e49',TO_DATE('2021-07-28 17:00:42','YYYY-MM-DD HH24:MI:SS'),'Y','AD_Language','Language for this entity','The Language identifies the language to use for display and formatting','Language','Y','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:42','YYYY-MM-DD HH24:MI:SS'),'N','D','N','N',109,106,200240,18,'N')
;

-- July 28, 2021 5:00:46 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,FKConstraintType,AD_Element_ID,AD_Val_Rule_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213512,'N',1,'Y','N','N','N',22,'N','N','N','N','50c1a0f8-dde9-4557-b4a3-5524424eafe5',TO_DATE('2021-07-28 17:00:43','YYYY-MM-DD HH24:MI:SS'),'N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:43','YYYY-MM-DD HH24:MI:SS'),'N','D','N','D',113,104,200240,19,'N')
;

-- July 28, 2021 5:00:48 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213513,'N',1,'N','N','N','N',2000,'N','N','N','Y','811cd8be-9f60-4d1b-9f5b-3eb514aa3148',TO_DATE('2021-07-28 17:00:46','YYYY-MM-DD HH24:MI:SS'),'Y','Code','Validation Code','The Validation Code displays the date, time and message of the error.','Validation code','Y','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:46','YYYY-MM-DD HH24:MI:SS'),'N','D','N',227,200240,10,'N')
;

-- July 28, 2021 5:00:49 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213514,'N',1,'Y','N','N','N',7,'N','N','N','N','0666c09c-9082-4a51-b936-9cf95a76c171',TO_DATE('2021-07-28 17:00:48','YYYY-MM-DD HH24:MI:SS'),'N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:48','YYYY-MM-DD HH24:MI:SS'),'N','D','N',245,200240,16,'N')
;

-- July 28, 2021 5:00:50 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,FKConstraintType,AD_Element_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213515,'N',1,'Y','N','N','N',22,'N','N','N','N','6754886f-9531-4435-9881-6aeb117c5d9f',TO_DATE('2021-07-28 17:00:49','YYYY-MM-DD HH24:MI:SS'),'N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:49','YYYY-MM-DD HH24:MI:SS'),'N','D','N','D',246,110,200240,18,'N')
;

-- July 28, 2021 5:00:52 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213516,'N',1,'Y','N','N','N',1,'N','N','N','Y','11b3d43d-e42d-4212-b5ff-be3f4344b044',TO_DATE('2021-07-28 17:00:50','YYYY-MM-DD HH24:MI:SS'),'Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:50','YYYY-MM-DD HH24:MI:SS'),'N','D','N',348,200240,20,'N')
;

-- July 28, 2021 5:00:52 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213517,'N',1,'Y','N','Y',1,'N',60,'Y','N','N','Y','0d3ae0bf-64e9-4aef-a657-d0ccc402bf30',TO_DATE('2021-07-28 17:00:52','YYYY-MM-DD HH24:MI:SS'),'Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:52','YYYY-MM-DD HH24:MI:SS'),'N','D','N',469,200240,10,'N')
;

-- July 28, 2021 5:00:53 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213518,'N',1,'Y','N','N','N',7,'N','N','N','N','07ea1bc7-a0b4-4bc5-952a-35cdb8da475f',TO_DATE('2021-07-28 17:00:52','YYYY-MM-DD HH24:MI:SS'),'N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:52','YYYY-MM-DD HH24:MI:SS'),'N','D','N',607,200240,16,'N')
;

-- July 28, 2021 5:01:02 PM SGT
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,FKConstraintType,AD_Element_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213519,'N',1,'Y','N','N','N',22,'N','N','N','N','29ac01ef-6553-4f9a-853d-40423438a032',TO_DATE('2021-07-28 17:00:53','YYYY-MM-DD HH24:MI:SS'),'N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:00:53','YYYY-MM-DD HH24:MI:SS'),'N','D','N','D',608,110,200240,18,'N')
;

-- July 28, 2021 5:01:27 PM SGT
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=213511
;

-- July 28, 2021 5:01:27 PM SGT
DELETE FROM AD_Column WHERE AD_Column_ID=213511
;

-- July 28, 2021 5:01:29 PM SGT
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=213513
;

-- July 28, 2021 5:01:29 PM SGT
DELETE FROM AD_Column WHERE AD_Column_ID=213513
;

-- July 28, 2021 5:03:53 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213520,0,'N',0,'N','N','N',0,'N',255,'Y','N','N','Y','3e4f5498-0035-486a-b14a-846b501ddb40',TO_DATE('2021-07-28 17:03:52','YYYY-MM-DD HH24:MI:SS'),'Y','SourceClassName','Source Class Name','Source Class','Y','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:03:52','YYYY-MM-DD HH24:MI:SS'),'N','U','N',2942,200240,10,'N')
;

-- July 28, 2021 5:03:56 PM SGT
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2021-07-28 17:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213520
;

-- July 28, 2021 5:04:16 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200004, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200004)
;

-- July 28, 2021 5:04:17 PM SGT
CREATE TABLE AD_PrintHeaderFooter (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_PrintHeaderFooter_ID NUMBER(10) NOT NULL, AD_PrintHeaderFooter_UU VARCHAR2(36 CHAR) DEFAULT NULL , Created DATE DEFAULT SYSDATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR2(60 CHAR) NOT NULL, SourceClassName VARCHAR2(255 CHAR) DEFAULT NULL , Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_PrintHeaderFooter_Key PRIMARY KEY (AD_PrintHeaderFooter_ID), CONSTRAINT AD_PrintHeaderFooter_UU_idx UNIQUE (AD_PrintHeaderFooter_UU))
;

-- July 28, 2021 5:04:58 PM SGT
INSERT INTO AD_Window (WindowType,Help,IsSOTrx,IsDefault,IsBetaFunctionality,Processing,AD_Org_ID,Name,Description,AD_Window_ID,AD_Window_UU,IsActive,AD_Client_ID,Updated,CreatedBy,UpdatedBy,EntityType,Created) VALUES ('M',NULL,'Y','N','N','N',0,'Print Header/Footer','Maintain Print Header/Footer',200100,'681b8621-d60e-4d33-9c10-ca6effe4b23e','Y',0,TO_DATE('2021-07-28 17:04:57','YYYY-MM-DD HH24:MI:SS'),100,100,'D',TO_DATE('2021-07-28 17:04:57','YYYY-MM-DD HH24:MI:SS'))
;

-- July 28, 2021 5:06:41 PM SGT
INSERT INTO AD_Tab (AD_Client_ID,AD_Org_ID,AD_Tab_ID,AD_Table_ID,AD_Tab_UU,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,TreeDisplayedOn,Updated,UpdatedBy) VALUES (0,0,200249,200240,'b3beffb9-ab5f-4d40-9a6b-2f849306e9e6',200100,TO_DATE('2021-07-28 17:06:39','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','Y','N','Y','N','N','Print Header/Footer','N',10,0,'M',TO_DATE('2021-07-28 17:06:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- July 28, 2021 5:06:57 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200005, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200005)
;

-- July 28, 2021 5:07:00 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205577,'N',22,'N','N',10,'Y','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,TO_DATE('2021-07-28 17:06:58','YYYY-MM-DD HH24:MI:SS'),'Client/Tenant for this installation.','Client','4bc05f5f-d904-4027-a467-508d13ba967a','Y','N',100,100,'Y','Y',10,0,TO_DATE('2021-07-28 17:06:58','YYYY-MM-DD HH24:MI:SS'),2,213508,'D',200249)
;

-- July 28, 2021 5:07:03 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205578,'N',22,'N','N',20,'Y','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',0,TO_DATE('2021-07-28 17:07:00','YYYY-MM-DD HH24:MI:SS'),'Organizational entity within client','Organization','051d2a8a-4dbd-4706-9f80-897e5b3986c4','Y','N','Y',100,100,'Y','Y',20,4,0,TO_DATE('2021-07-28 17:07:00','YYYY-MM-DD HH24:MI:SS'),2,213512,'D',200249)
;

-- July 28, 2021 5:07:05 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205579,'N',60,'N','N',30,'Y','N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',0,TO_DATE('2021-07-28 17:07:03','YYYY-MM-DD HH24:MI:SS'),'Alphanumeric identifier of the entity','Name','acc95b14-bff5-4d21-8b2d-c3a07d008d4e','Y','N',100,100,'Y','Y',30,0,TO_DATE('2021-07-28 17:07:03','YYYY-MM-DD HH24:MI:SS'),5,213517,'D',200249)
;

-- July 28, 2021 5:07:06 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205580,'N',22,'N','N','Y','N',0,TO_DATE('2021-07-28 17:07:05','YYYY-MM-DD HH24:MI:SS'),'Print Header/Footer','636434ea-cb1a-4f20-8ca7-34c1fcf6a4ff','N','N',100,100,'Y','N',0,TO_DATE('2021-07-28 17:07:05','YYYY-MM-DD HH24:MI:SS'),2,213509,'D',200249)
;

-- July 28, 2021 5:07:08 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205581,'N',36,'N','N','Y','N',0,TO_DATE('2021-07-28 17:07:06','YYYY-MM-DD HH24:MI:SS'),'AD_PrintHeaderFooter_UU','0374e4a2-7b93-40d8-9928-f883f54803ad','N','N',100,100,'Y','N',0,TO_DATE('2021-07-28 17:07:06','YYYY-MM-DD HH24:MI:SS'),2,213510,'D',200249)
;

-- July 28, 2021 5:07:09 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205582,'N',255,'N','N',40,'Y','N',0,TO_DATE('2021-07-28 17:07:08','YYYY-MM-DD HH24:MI:SS'),'Source Class Name','Source Class','246e8579-9378-45c8-8c5e-dbc77f29abc2','Y','N',100,100,'Y','Y',40,0,TO_DATE('2021-07-28 17:07:08','YYYY-MM-DD HH24:MI:SS'),5,213520,'D',200249)
;

-- July 28, 2021 5:07:10 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205583,'N',1,'N','N',50,'Y','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,TO_DATE('2021-07-28 17:07:09','YYYY-MM-DD HH24:MI:SS'),'The record is active in the system','Active','f1bbff39-345a-4511-9501-5303b4fada21','Y','N',100,100,'Y','Y',50,2,0,TO_DATE('2021-07-28 17:07:09','YYYY-MM-DD HH24:MI:SS'),2,213516,'D',200249)
;

-- July 28, 2021 5:09:08 PM SGT
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,AD_Menu_UU,IsSOTrx,IsReadOnly,IsCentrallyMaintained,Name,Description,Action,IsActive,CreatedBy,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,EntityType,AD_Window_ID) VALUES (200156,'N','4544341f-cd36-4d72-8484-2f5908a9dfd9','Y','N','Y','Print Header/Footer','Maintain Print Header/Footer','W','Y',100,0,0,TO_DATE('2021-07-28 17:09:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2021-07-28 17:09:07','YYYY-MM-DD HH24:MI:SS'),100,'D',200100)
;

-- July 28, 2021 5:09:08 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200156, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=116 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200156)
;

-- July 28, 2021 5:09:08 PM SGT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200156, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200156)
;

-- July 28, 2021 5:09:28 PM SGT
UPDATE AD_TreeNodeMM SET Parent_ID=326, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200156
;

-- July 28, 2021 5:15:07 PM SGT
-- AP2-274 Configure Header and Footer for financial reports
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,IsSecure,EntityType,IsEncrypted,FKConstraintType,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213521,0,'N',0,'N','N','N',0,'N',22,'N','N','N','Y','6f222c63-afaf-4774-a704-d2437b879cb6',TO_DATE('2021-07-28 17:16:57','YYYY-MM-DD HH24:MI:SS'),'N','AD_PrintHeaderFooter_ID','Print Header/Footer','Y','Y',100,100,'N',0,0,TO_DATE('2021-07-28 17:16:57','YYYY-MM-DD HH24:MI:SS'),'N','U','N','N',203210,493,19,'N')
;

-- July 28, 2021 5:17:04 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200006, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200006)
;

-- July 28, 2021 5:17:05 PM SGT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADPrintHeaderFooter_ADPrintFor',Updated=TO_DATE('2021-07-28 17:17:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213521
;

-- July 28, 2021 5:17:05 PM SGT
ALTER TABLE AD_PrintFormat ADD AD_PrintHeaderFooter_ID NUMBER(10) DEFAULT NULL 
;

-- July 28, 2021 5:17:05 PM SGT
ALTER TABLE AD_PrintFormat ADD CONSTRAINT ADPrintHeaderFooter_ADPrintFor FOREIGN KEY (AD_PrintHeaderFooter_ID) REFERENCES ad_printheaderfooter(ad_printheaderfooter_id) DEFERRABLE INITIALLY DEFERRED
;

-- July 28, 2021 5:18:08 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200007, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200007)
;

-- July 28, 2021 5:18:09 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205584,'N',22,'N','N',260,'Y','N',0,TO_DATE('2021-07-28 17:18:08','YYYY-MM-DD HH24:MI:SS'),'Print Header/Footer','baaa8cef-c923-4a89-b73b-06e6345c2bd4','Y','N',100,100,'Y','Y',260,0,TO_DATE('2021-07-28 17:18:08','YYYY-MM-DD HH24:MI:SS'),2,213521,'U',425)
;

-- July 28, 2021 5:18:16 PM SGT
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2021-07-28 17:18:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213521
;

-- July 28, 2021 5:20:18 PM SGT
UPDATE AD_Field SET SeqNo=125, AD_Val_Rule_ID=NULL, SeqNoGrid=125, AD_Reference_Value_ID=NULL, EntityType='D', IsToolbarButton=NULL,Updated=TO_DATE('2021-07-28 17:20:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205584
;

-- July 28, 2021 5:20:43 PM SGT
UPDATE AD_Field SET DisplayLogic='@IsStandardHeaderFooter@=N', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-28 17:20:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205584
;

-- July 28, 2021 5:20:54 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, XPosition=4, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-28 17:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205584
;

-- July 28, 2021 5:22:33 PM SGT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2021-07-28 17:22:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213521
;

-- Jul 29, 2021, 2:54:24 PM MYT
UPDATE AD_Column SET IsMandatory='Y', SeqNoSelection=10,Updated=TO_DATE('2021-07-29 14:54:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213520
;

-- Jul 29, 2021, 2:54:29 PM MYT
ALTER TABLE AD_PrintHeaderFooter MODIFY SourceClassName VARCHAR2(255 CHAR)
;

-- Jul 29, 2021, 2:54:29 PM MYT
ALTER TABLE AD_PrintHeaderFooter MODIFY SourceClassName NOT NULL
;

-- Jul 29, 2021, 2:56:11 PM MYT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201089,'87fdd27c-eb34-4183-a0e1-92ad668dc7c8',TO_DATE('2021-07-29 14:56:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintHeaderFooter_Name_Idx',TO_DATE('2021-07-29 14:56:10','YYYY-MM-DD HH24:MI:SS'),100,200240,'Y','Y','N','N','N')
;

-- Jul 29, 2021, 2:56:23 PM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201428,'33e8b8f8-cab8-4d3e-a979-473e5226f145',TO_DATE('2021-07-29 14:56:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-07-29 14:56:23','YYYY-MM-DD HH24:MI:SS'),100,213508,201089,10)
;

-- Jul 29, 2021, 2:56:34 PM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201429,'afa25fab-0832-48cf-bb0e-9ed3fe5c22b3',TO_DATE('2021-07-29 14:56:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-07-29 14:56:33','YYYY-MM-DD HH24:MI:SS'),100,213517,201089,20)
;

-- Jul 29, 2021, 2:56:40 PM MYT
ALTER TABLE AD_PrintHeaderFooter ADD CONSTRAINT AD_PrintHeaderFooter_Name_Idx UNIQUE (AD_Client_ID,Name)
;

-- Jul 29, 2021, 2:59:52 PM MYT
UPDATE AD_TableIndex SET AD_Message_ID=502,Updated=TO_DATE('2021-07-29 14:59:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=201089
;

SELECT register_migration_script('202107281652_IDEMPIERE-4894.sql') FROM dual
;

