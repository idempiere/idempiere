SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 26, 2014 10:31:26 PM ICT
-- IDEMPIERE-1334 Run one or more processes from Info Window
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Processing,DatabaseViewDrop,AD_Client_ID,Created) VALUES ('N','N','N','4',0,385,200129,'N','N','Y','D','L','399fcb47-f46c-4789-9e45-962cc5379c16','Y','Y','AD_InfoProcess','define process for info window','Info Process','Y',0,100,TO_DATE('2014-05-26 22:31:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,TO_DATE('2014-05-26 22:31:25','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:27 PM ICT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID,Created) VALUES ('N',200000,'Y',1000000,'N','Y',200176,'Table AD_InfoProcess','AD_InfoProcess',1,'48700d65-3ba4-4888-8242-6af9a613206a',0,100,TO_DATE('2014-05-26 22:31:26','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0,TO_DATE('2014-05-26 22:31:26','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:28 PM ICT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created,Updated) VALUES ('AD_InfoProcess_ID',202712,'Info Process','Info Process','ebfa3db8-e6b2-43aa-9eaa-e3dc1b2eb7f1',0,100,100,'Y',0,'D',TO_DATE('2014-05-26 22:31:27','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-05-26 22:31:27','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:28 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211241,'Y','N','N','N',10,'N','Y','N','Y','e3154b48-b2ac-4ad2-ba43-92744e8c6a4c','N','AD_InfoProcess_ID','Info Process','N',TO_DATE('2014-05-26 22:31:28','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:28','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',202712,13,200129)
;

-- May 26, 2014 10:31:28 PM ICT
CREATE TABLE AD_InfoProcess (AD_InfoProcess_ID NUMBER(10) NOT NULL, CONSTRAINT AD_InfoProcess_Key PRIMARY KEY (AD_InfoProcess_ID))
;

-- May 26, 2014 10:31:29 PM ICT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created,Updated) VALUES ('AD_InfoProcess_UU',202713,'AD_InfoProcess_UU','AD_InfoProcess_UU','dde8ccd5-449b-4b9b-84a2-720e77eff87b',0,100,100,'Y',0,'D',TO_DATE('2014-05-26 22:31:29','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-05-26 22:31:29','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:30 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211242,'Y','N','N','N',36,'N','N','N','Y','8f961362-5939-48a4-8c8d-8d8b5d86a83e','N','AD_InfoProcess_UU','AD_InfoProcess_UU','N',TO_DATE('2014-05-26 22:31:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',202713,10,200129)
;

-- May 26, 2014 10:31:30 PM ICT
ALTER TABLE AD_InfoProcess ADD AD_InfoProcess_UU VARCHAR2(36) NOT NULL
;

-- May 26, 2014 10:31:30 PM ICT
ALTER TABLE AD_InfoProcess ADD CONSTRAINT AD_InfoProcess_UU_idx UNIQUE (AD_InfoProcess_UU)
;

-- May 26, 2014 10:31:31 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID) VALUES ('Y',0.0,211243,'Y','N','N','N',10,'N','N','N','Y','e8fa9743-e852-4fb3-a8ba-aba7190f5d26','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2014-05-26 22:31:30','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:30','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','ADClient_ADInfoProcess','N',102,19,200129,129)
;

-- May 26, 2014 10:31:31 PM ICT
ALTER TABLE AD_InfoProcess ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- May 26, 2014 10:31:31 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID) VALUES ('Y',0.0,211244,'Y','N','N','N',10,'N','N','N','Y','48046a19-4d3c-40e6-93f2-49858061c1ff','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2014-05-26 22:31:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','ADOrg_ADInfoProcess','N',113,19,200129,104)
;

-- May 26, 2014 10:31:31 PM ICT
ALTER TABLE AD_InfoProcess ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- May 26, 2014 10:31:32 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211245,'Y','N','N','N',1,'N','N','N','Y','0d5a6a7a-b436-4958-814a-18ecafbc8971','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2014-05-26 22:31:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',348,20,200129)
;

-- May 26, 2014 10:31:32 PM ICT
ALTER TABLE AD_InfoProcess ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- May 26, 2014 10:31:33 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211246,'Y','N','N','N',29,'N','N','N','Y','a8315f0c-3cbd-4092-bcc7-8e1f0bc4021c','N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2014-05-26 22:31:32','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:32','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',245,16,200129)
;

-- May 26, 2014 10:31:33 PM ICT
ALTER TABLE AD_InfoProcess ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- May 26, 2014 10:31:34 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES ('Y',0.0,211247,'Y','N','N','N',10,'N','N','N','Y','f2e43604-537c-46a7-a08a-425589a290de','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2014-05-26 22:31:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',246,18,110,200129)
;

-- May 26, 2014 10:31:34 PM ICT
ALTER TABLE AD_InfoProcess ADD CreatedBy NUMBER(10) NOT NULL
;

-- May 26, 2014 10:31:35 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211248,'Y','N','N','N',29,'N','N','N','Y','87143907-1038-4c5d-90f6-3114a6fc7edf','N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2014-05-26 22:31:34','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:34','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',607,16,200129)
;

-- May 26, 2014 10:31:35 PM ICT
ALTER TABLE AD_InfoProcess ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- May 26, 2014 10:31:35 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES ('Y',0.0,211249,'Y','N','N','N',10,'N','N','N','Y','197f9f68-6340-45a8-9d75-9d027f8bcc75','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2014-05-26 22:31:35','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:35','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',608,18,110,200129)
;

-- May 26, 2014 10:31:35 PM ICT
ALTER TABLE AD_InfoProcess ADD UpdatedBy NUMBER(10) NOT NULL
;

-- May 26, 2014 10:31:36 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211250,'Y','N','Y','N',60,'Y','N','N','Y','cba0a7f1-a35e-4410-b53d-b47a0a81b8d5','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_DATE('2014-05-26 22:31:35','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:35','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',469,10,200129)
;

-- May 26, 2014 10:31:36 PM ICT
ALTER TABLE AD_InfoProcess ADD Name VARCHAR2(60) NOT NULL
;

-- May 26, 2014 10:31:37 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211251,'N','N','N','N',255,'Y','N','N','Y','da7faea4-1447-4912-975d-9916325f892c','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_DATE('2014-05-26 22:31:36','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:36','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',275,10,200129)
;

-- May 26, 2014 10:31:37 PM ICT
ALTER TABLE AD_InfoProcess ADD Description VARCHAR2(255) DEFAULT NULL 
;

-- May 26, 2014 10:31:38 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211252,'N','N','N','N',120,'N','N','N','Y','54fdf7c3-564a-48ea-af3c-314efca2f0ed','Y','ImageURL','URL of  image','URL of image; The image is not stored in the database, but retrieved at runtime. The image can be a gif, jpeg or png.','Image URL','Y',TO_DATE('2014-05-26 22:31:37','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:37','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',1720,10,200129)
;

-- May 26, 2014 10:31:38 PM ICT
ALTER TABLE AD_InfoProcess ADD ImageURL VARCHAR2(120) DEFAULT NULL 
;

-- May 26, 2014 10:31:38 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211253,'Y','N','N','N',10,'N','N','N','Y','b9449134-fe06-4a9a-b1a6-54077974de21','Y','SeqNo','Method of ordering records; lowest number comes first','@SQL=SELECT NVL(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_InfoProcess WHERE AD_InfoWindow_ID=@AD_InfoWindow_ID@','The Sequence indicates the order of records','Sequence','N',TO_DATE('2014-05-26 22:31:38','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:38','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',566,11,200129)
;

-- May 26, 2014 10:31:38 PM ICT
ALTER TABLE AD_InfoProcess ADD SeqNo NUMBER(10) NOT NULL
;

-- May 26, 2014 10:31:39 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211254,'Y','N','N','N',10,'N','N','N','Y','be4dc8ea-58bf-4238-bff2-71099c2f36f9','Y','AD_Process_ID','Process or Report','The Process field identifies a unique Process or Report in the system.','Process','Y',TO_DATE('2014-05-26 22:31:38','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:38','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','ADProcess_ADInfoProcess','N',117,19,200129)
;

-- May 26, 2014 10:31:39 PM ICT
ALTER TABLE AD_InfoProcess ADD AD_Process_ID NUMBER(10) NOT NULL
;

-- May 26, 2014 10:31:40 PM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0.0,211255,'N','N','N','Y',10,'N','N','N','Y','d9a775c3-dd5c-4e91-8416-60b78c33eb4e','N','AD_InfoWindow_ID','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.','Info Window','Y',TO_DATE('2014-05-26 22:31:39','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:39','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','ADInfoWindow_ADInfoProcess','C',3068,19,200129)
;

-- May 26, 2014 10:31:40 PM ICT
ALTER TABLE AD_InfoProcess ADD AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- May 26, 2014 10:31:41 PM ICT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,'Y',0,211256,'N','N','N',0,'N',2000,'N','N','N','Y','54387a92-4caa-4ab2-a765-51cf779a537c','Y','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',TO_DATE('2014-05-26 22:31:40','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:40','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',326,14,200129)
;

-- May 26, 2014 10:31:41 PM ICT
ALTER TABLE AD_InfoProcess ADD Help VARCHAR2(2000) DEFAULT NULL 
;

-- May 26, 2014 10:31:41 PM ICT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,Name,Description,PrintName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created,Updated) VALUES ('LayoutType',202714,'Process info can display as button, list, menu','LayoutType','Layout type of info process','Layout Type','913eafda-0cdc-4c44-85f8-487d77a3787c',0,100,100,'Y',0,'D',TO_DATE('2014-05-26 22:31:41','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-05-26 22:31:41','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:42 PM ICT
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (200083,'AD_InfoProcess LayoutType','D','2171ebd2-e11a-4612-9885-128f155d65e8','N','Define layout type of info process button','L',0,100,TO_DATE('2014-05-26 22:31:42','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2014-05-26 22:31:42','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- May 26, 2014 10:31:43 PM ICT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Description,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,EntityType,AD_Client_ID,AD_Org_ID) VALUES (200185,200083,'Display as button','Button','6884dcd1-bc9a-4d16-9b2c-fe40968747f8','B',TO_DATE('2014-05-26 22:31:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-05-26 22:31:42','YYYY-MM-DD HH24:MI:SS'),100,'Y','D',0,0)
;

-- May 26, 2014 10:31:44 PM ICT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Description,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,EntityType,AD_Client_ID,AD_Org_ID) VALUES (200186,200083,'Display as menu on a gear button','Menu','7b539591-296a-43ee-916c-c87c35acc84d','M',TO_DATE('2014-05-26 22:31:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-05-26 22:31:43','YYYY-MM-DD HH24:MI:SS'),100,'Y','D',0,0)
;

-- May 26, 2014 10:31:44 PM ICT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Description,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,EntityType,AD_Client_ID,AD_Org_ID) VALUES (200187,200083,'Display as list','List','ff0cba3e-e82c-4aa8-9f9b-bedf681b822d','L',TO_DATE('2014-05-26 22:31:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-05-26 22:31:44','YYYY-MM-DD HH24:MI:SS'),100,'Y','D',0,0)
;

-- May 26, 2014 10:31:45 PM ICT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (0,'Y',0,211257,'N','N','N',0,'N',1,'N','N','N','Y','a0e8f5b5-ac5f-44ba-a2c9-060dd3231c4e','Y','LayoutType','Layout type of info process','Process info can display as button, list, menu','LayoutType','Y',TO_DATE('2014-05-26 22:31:45','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-26 22:31:45','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',202714,17,200083,200129)
;

-- May 26, 2014 10:31:45 PM ICT
ALTER TABLE AD_InfoProcess ADD LayoutType VARCHAR2(1) DEFAULT NULL 
;

-- 28/05/2014 01:24:40 PM COT
UPDATE AD_Column SET IsMandatory='Y', DefaultValue='B',Updated=TO_DATE('2014-05-28 13:24:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211257
;

-- 28/05/2014 01:24:44 PM COT
ALTER TABLE AD_InfoProcess MODIFY LayoutType VARCHAR2(10) DEFAULT 'B'
;

-- 28/05/2014 01:24:44 PM COT
ALTER TABLE AD_InfoProcess MODIFY LayoutType NOT NULL
;

-- May 26, 2014 10:31:48 PM ICT
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Table_ID,AD_Client_ID,TreeDisplayedOn) VALUES ('N','N','Y',385,60,'N','N','N','N','N','Y','N',1,'2a39f93a-2062-404a-8e28-19fc45982162','D','Process',200142,0,TO_DATE('2014-05-26 22:31:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-05-26 22:31:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',200129,0,'B')
;

-- May 26, 2014 10:31:49 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,36,'N','N',0,'Y',203026,'N','AD_InfoProcess_UU','87361dd1-cfc0-412d-a344-e5f602650e32','N','N',100,0,100,TO_DATE('2014-05-26 22:31:48','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211242,'D',TO_DATE('2014-05-26 22:31:48','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:49 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,10,'N','N',0,'Y',203027,'N','Info Process','8020c77c-816a-4be9-a38c-747aed3afcf2','N','N',100,0,100,TO_DATE('2014-05-26 22:31:49','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211241,'D',TO_DATE('2014-05-26 22:31:49','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:50 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,10,'N','N',10,'Y',203028,'Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','a6fccb4a-2521-4369-a1bb-06602ae9c840','Y','N',100,0,100,TO_DATE('2014-05-26 22:31:49','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N','N',211243,'D',TO_DATE('2014-05-26 22:31:49','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:51 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,10,'N','N',20,'Y',203029,'Y','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','60f9d173-cefb-417c-8080-8bb16aebff7e','Y','N','Y',100,0,100,TO_DATE('2014-05-26 22:31:50','YYYY-MM-DD HH24:MI:SS'),'Y','N',4,'N',0,2,1,'N','N',211244,'D',TO_DATE('2014-05-26 22:31:50','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:51 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,10,'N','N',30,'Y',203030,'Y','The Info window is used to search and select records as well as display information relevant to the selection.','Info and search/select Window','Info Window','ecc17f1a-a61e-4449-a35b-9915088cad60','Y','N',100,0,100,TO_DATE('2014-05-26 22:31:51','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,1,'N',0,2,1,'N','N',211255,'D',TO_DATE('2014-05-26 22:31:51','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:52 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,120,'N','N',40,'Y',203031,'N','URL of image; The image is not stored in the database, but retrieved at runtime. The image can be a gif, jpeg or png.','URL of  image','Image URL','8a9c636e-677b-464c-a942-3e0e8f5ad3a4','Y','N',100,0,100,TO_DATE('2014-05-26 22:31:51','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,4,'N',0,2,1,'N','N',211252,'D',TO_DATE('2014-05-26 22:31:51','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:53 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,60,'N','N',50,'Y',203032,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name','af4c42ad-5b90-474a-80f4-41341a08d3cf','Y','N',100,0,100,TO_DATE('2014-05-26 22:31:52','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,5,1,'N','N',211250,'D',TO_DATE('2014-05-26 22:31:52','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:53 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,255,'N','N',60,'Y',203033,'N','A description is limited to 255 characters.','Optional short description of the record','Description','cc49a78e-2927-484e-990e-8c303be44b4c','Y','N',100,0,100,TO_DATE('2014-05-26 22:31:53','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,'N',0,5,1,'N','N',211251,'D',TO_DATE('2014-05-26 22:31:53','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:54 PM ICT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES (0,'N',200142,0,'N','N',70,'Y',203034,'N','The Help field contains a hint, comment or help about the use of this item.','Comment or Hint','Comment/Help','4b9118d1-4cc9-47fe-beee-b24e4d1263cb','Y','N',100,0,100,TO_DATE('2014-05-26 22:31:53','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,1,'N',0,5,3,'N','N',211256,'D',TO_DATE('2014-05-26 22:31:53','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:55 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,10,'N','N',80,'Y',203035,'N','The Process field identifies a unique Process or Report in the system.','Process or Report','Process','2f7cb5e4-1af9-4912-b9dd-bbc8ccbae537','Y','N',100,0,100,TO_DATE('2014-05-26 22:31:54','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,1,'N',0,2,1,'N','N',211254,'D',TO_DATE('2014-05-26 22:31:54','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:55 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,10,'N','N',90,'Y',203036,'N','The Sequence indicates the order of records','Method of ordering records; lowest number comes first','Sequence','c5ee4976-735e-40f8-8cd4-4bacc36adcdf','Y','N',100,0,100,TO_DATE('2014-05-26 22:31:55','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,4,'N',0,2,1,'N','N',211253,'D',TO_DATE('2014-05-26 22:31:55','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:56 PM ICT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES (0,'N',200142,0,'N','N',100,'Y',203037,'N','Process info can display as button, list, menu','Layout type of info process','LayoutType','106b208d-b39b-4ab0-b839-7d0c95951bea','Y','N',100,0,100,TO_DATE('2014-05-26 22:31:55','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,1,'N',0,2,1,'N','N',211257,'D',TO_DATE('2014-05-26 22:31:55','YYYY-MM-DD HH24:MI:SS'))
;

-- May 26, 2014 10:31:57 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200142,1,'N','N',110,'Y',203038,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','e45bfa22-f210-4a87-9b0c-b3ab2da35161','Y','N',100,0,100,TO_DATE('2014-05-26 22:31:56','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,5,'N',0,2,1,'N','N',211245,'D',TO_DATE('2014-05-26 22:31:56','YYYY-MM-DD HH24:MI:SS'))
;

-- migrate for anyone use red1 process in info panel start
INSERT INTO AD_InfoProcess 
(ad_infoprocess_id, ad_infowindow_id, ad_client_id, ad_org_id, isactive,createdby, updatedby, seqno, name, ad_process_id, description, help, ad_infoprocess_uu)
(SELECT nextidfunc(200176,'N'), ad_infowindow_id, iw.ad_client_id, iw.ad_org_id, 'Y', 100, 100, 10, pr.name, iw.ad_process_id, pr.description, pr.help, generate_uuid()
FROM ad_infowindow iw INNER JOIN ad_process pr ON pr.ad_process_ID = iw.ad_process_ID	
WHERE iw.ad_process_ID IS NOT NULL
);

-- May 23, 2014 4:01:30 PM ICT
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=202596
;

-- May 23, 2014 4:01:30 PM ICT
DELETE FROM AD_Field WHERE AD_Field_ID=202596
;

-- May 23, 2014 4:01:51 PM ICT
UPDATE AD_Column SET IsActive='N' WHERE AD_Column_ID=210944
;

SELECT register_migration_script('201405261604_IDEMPIERE-1334.sql') FROM dual
;
