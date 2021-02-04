-- User Favorite Panel
-- Jun 7, 2017 5:16:46 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200220,'Favorite Tree','Show user favorite menu on dashboard','AD_Tree_Favorite',0,'7',0,0,'Y',TO_TIMESTAMP('2017-06-07 17:16:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:16:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','N','L','N','Y','22aae804-ae4d-4983-8e9a-44821df6d2bf','N','N','N')
;

-- Jun 7, 2017 5:16:47 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Tree_Favorite',1000000,'N','N','Table AD_Tree_Favorite','Y','Y',0,0,TO_TIMESTAMP('2017-06-07 17:16:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:16:46','YYYY-MM-DD HH24:MI:SS'),100,200284,'Y',1000000,1,200000,'1ee2f67c-68b6-4178-b285-8b4058a77a6f')
;

-- Jun 7, 2017 5:17:53 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213049,0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200220,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:17:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:17:52','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','4cf19db8-0024-485e-9b3b-24297ed4541c','N',0,'N','N','D')
;

-- Jun 7, 2017 5:18:33 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213050,0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200220,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:18:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:18:32','YYYY-MM-DD HH24:MI:SS'),100,113,'N','Y','D','N','N','N','Y','0a285262-b6db-4300-80e5-44dcaad2bbc4','N',0,'N','N','D')
;

-- Jun 7, 2017 5:19:32 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213051,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200220,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:19:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:19:31','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','f61225c6-d01f-4bb6-9a97-12bbfa2470bb','N',0,'N','N')
;

-- Jun 7, 2017 5:20:04 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213052,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200220,'CreatedBy','@#AD_User_ID@',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:20:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:20:03','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','ce404a00-9e20-415b-8f53-66798d6d787e','N',0,'N','N','D')
;

-- Jun 7, 2017 5:20:40 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213053,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200220,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:20:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:20:39','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','b94d5376-03c8-4800-9943-2dd1a2642359','N',0,'N','N')
;

-- Jun 7, 2017 5:21:36 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213054,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200220,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:21:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:21:35','YYYY-MM-DD HH24:MI:SS'),100,607,'Y','N','D','N','N','N','Y','cf57f541-b98a-4386-bd0b-48ce1b4a3c20','N',0,'N','N')
;

-- Jun 7, 2017 5:22:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213055,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200220,'UpdatedBy','@#AD_User_ID@',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:22:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:22:09','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','b227be8e-ef36-44af-929d-313afabcb2ce','N',0,'N','N','D')
;

-- Jun 7, 2017 5:23:19 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203084,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:23:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:23:18','YYYY-MM-DD HH24:MI:SS'),100,'AD_Tree_Favorite_ID','Favorite Tree','Favorite Tree','D','ce59c6fc-02d2-4292-90dc-64ce1f51d00a')
;

-- Jun 7, 2017 5:23:41 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203085,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:23:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:23:40','YYYY-MM-DD HH24:MI:SS'),100,'AD_Tree_Favorite_UU','Favorite Tree','Favorite Tree','D','d8f6b15a-6a43-43b7-a3c5-b674443c978d')
;

-- Jun 7, 2017 5:24:20 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213056,0,'Favorite Tree',200220,'AD_Tree_Favorite_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:24:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:24:19','YYYY-MM-DD HH24:MI:SS'),100,203084,'N','N','D','N','N','N','Y','eca5978b-cad6-4301-b2e2-d852c9fa7ef6','N',0,'N','N')
;

-- Jun 7, 2017 5:25:09 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213057,0,'Favorite Tree',200220,'AD_Tree_Favorite_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:25:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:25:08','YYYY-MM-DD HH24:MI:SS'),100,203085,'N','N','D','N','N','N','Y','4d3f6761-8d45-478d-ba94-27f92b9cc058','N',0,'N','N')
;

-- Jun 7, 2017 5:26:09 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213058,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200220,'AD_User_ID',22,'N','Y','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:26:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:26:08','YYYY-MM-DD HH24:MI:SS'),100,138,'N','N','D','N','N','N','Y','e74f8bbc-7549-4e33-a0e0-e6eb9da7f9a7','Y',0,'N','N','N')
;

-- Jun 7, 2017 5:27:57 PM IST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADUser_ADTreeFavorite', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-06-07 17:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213058
;

-- Jun 7, 2017 5:27:57 PM IST
CREATE TABLE AD_Tree_Favorite (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Tree_Favorite_ID NUMERIC(10) NOT NULL, AD_Tree_Favorite_UU VARCHAR(36) DEFAULT NULL , AD_User_ID NUMERIC(10) NOT NULL, Created TIMESTAMP DEFAULT statement_timestamp(), CreatedBy NUMERIC(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated TIMESTAMP DEFAULT statement_timestamp(), UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_Tree_Favorite_Key PRIMARY KEY (AD_Tree_Favorite_ID), CONSTRAINT AD_Tree_Favorite_UU_idx UNIQUE (AD_Tree_Favorite_UU))
;

-- Jun 7, 2017 5:27:57 PM IST
ALTER TABLE AD_Tree_Favorite ADD CONSTRAINT ADUser_ADTreeFavorite FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 7, 2017 5:30:39 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200221,'Favorite Node Tree','AD_Tree_Favorite_Node',0,'7',0,0,'Y',TO_TIMESTAMP('2017-06-07 17:30:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:30:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','N','L','N','Y','8235cfa4-0ef7-4a74-9f98-c1bf56c3ac68','N','N','N')
;

-- Jun 7, 2017 5:30:40 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Tree_Favorite_Node',1000000,'N','N','Table AD_Tree_Favorite_Node','Y','Y',0,0,TO_TIMESTAMP('2017-06-07 17:30:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:30:39','YYYY-MM-DD HH24:MI:SS'),100,200285,'Y',1000000,1,200000,'e7bd8544-7e2c-4cb4-9e33-37de2ced1ac3')
;

-- Jun 7, 2017 5:31:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213060,0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200221,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:31:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:31:36','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','af5536e6-c0bd-4576-9873-124a3efe5bf4','N',0,'N','N','D')
;

-- Jun 7, 2017 5:31:59 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213061,0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200221,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:31:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:31:58','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','709a9598-5719-4c9d-92bb-a6049bfeec03','N',0,'N','N','D')
;

-- Jun 7, 2017 5:32:35 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213062,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200221,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:32:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:32:34','YYYY-MM-DD HH24:MI:SS'),100,245,'Y','N','D','N','N','N','Y','53ddb0b9-4fe2-44d7-bbfc-bac7c9425f20','N',0,'N','N')
;

-- Jun 7, 2017 5:33:40 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213063,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200221,'CreatedBy','@#AD_User_ID@',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:33:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:33:39','YYYY-MM-DD HH24:MI:SS'),100,246,'Y','N','D','N','N','N','Y','cff8d4ca-f835-4cc3-a8ca-0a7d5b9fd53c','N',0,'N','N','D')
;

-- Jun 7, 2017 5:34:06 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213064,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200221,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:34:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:34:05','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','56fb740d-48fc-4d39-a43a-540694efadab','N',0,'N','N')
;

-- Jun 7, 2017 5:34:34 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213065,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200221,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:34:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:34:33','YYYY-MM-DD HH24:MI:SS'),100,607,'Y','N','D','N','N','N','Y','3b597bf5-0cbe-4cf9-8233-0c28e67cc321','N',0,'N','N')
;

-- Jun 7, 2017 5:35:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213066,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200221,'UpdatedBy','@#AD_User_ID@',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:35:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:35:11','YYYY-MM-DD HH24:MI:SS'),100,608,'Y','N','D','N','N','N','Y','5452ee32-2bba-42a1-b60b-68de07d348c7','N',0,'N','N','D')
;

-- Jun 7, 2017 5:36:09 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203086,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:36:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:36:08','YYYY-MM-DD HH24:MI:SS'),100,'AD_Tree_Favorite_Node_ID','Favorite Node Tree','Favorite Node Tree','D','471c6cba-b917-4bfc-b0ed-007a7f7d2c62')
;

-- Jun 7, 2017 5:36:32 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203087,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:36:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:36:31','YYYY-MM-DD HH24:MI:SS'),100,'AD_Tree_Favorite_Node_UU','Favorite Node Tree','Favorite Node Tree','D','a6af8334-c55d-46c7-9002-d8225fa87c77')
;

-- Jun 7, 2017 5:37:24 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213067,0,'Favorite Node Tree',200221,'AD_Tree_Favorite_Node_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:37:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:37:23','YYYY-MM-DD HH24:MI:SS'),100,203086,'N','N','D','N','N','N','Y','0302266a-defe-4a79-8112-5cc262086965','N',0,'N','N')
;

-- Jun 7, 2017 5:37:44 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213068,0,'Favorite Node Tree',200221,'AD_Tree_Favorite_Node_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:37:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:37:43','YYYY-MM-DD HH24:MI:SS'),100,203087,'N','N','D','N','N','N','Y','b349c3e3-c713-4339-a5bf-0f3b3fa97b3a','N',0,'N','N')
;

-- Jun 7, 2017 5:38:40 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213069,0,'Favorite Tree',200221,'AD_Tree_Favorite_ID',22,'N','Y','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:38:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:38:39','YYYY-MM-DD HH24:MI:SS'),100,203084,'N','N','D','N','N','N','Y','6ba5cc25-925e-4490-89ad-dd560334174e','Y',0,'N','N','N')
;

-- Jun 7, 2017 5:39:42 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213070,0,'Parent','Parent of Entity','The Parent indicates the value used to represent the next level in a hierarchy or report to level for a record',200221,'Parent_ID',10,'N','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:39:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:39:41','YYYY-MM-DD HH24:MI:SS'),100,496,'Y','N','D','N','N','N','Y','a510e39a-78e0-4888-b7c3-85b164f437c2','Y',0,'N','N')
;

-- Jun 7, 2017 5:40:39 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213071,0,'Summary Level','This is a summary entity','A summary entity represents a branch in a tree rather than an end-node. Summary entities are used for reporting and do not have own values.',200221,'IsSummary','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:40:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:40:38','YYYY-MM-DD HH24:MI:SS'),100,416,'Y','Y','D','N','N','N','Y','30f402c7-8b4e-43ce-87d1-9251782be4d3','Y',0,'N','N')
;

-- Jun 7, 2017 5:41:19 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213072,0,'Menu','Identifies a Menu','The Menu identifies a unique Menu.  Menus are used to control the display of those screens a user has access to.',200221,'AD_Menu_ID',10,'N','Y','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:41:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:41:18','YYYY-MM-DD HH24:MI:SS'),100,110,'N','Y','D','N','N','N','Y','e5112a1f-260d-4d3d-931e-add3cb91bd08','Y',0,'N','N','N')
;

-- Jun 7, 2017 5:41:52 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213073,0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200221,'SeqNo',22,'N','N','Y','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:41:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:41:51','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','N','N','Y','44bb0318-34c7-40fd-99cc-f393e4f27819','Y',0,'N','N')
;

-- Jun 7, 2017 5:42:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213074,0,'Collapsible','Flag to indicate the state of the dashboard panel','Flag to indicate the state of the dashboard panel (i.e. collapsible or static)',200221,'IsCollapsible','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:42:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:42:28','YYYY-MM-DD HH24:MI:SS'),100,53715,'Y','N','D','N','N','N','Y','5c53a75f-8ffb-41c7-a463-c7103eee18f3','Y',0,'N','N')
;

-- Jun 7, 2017 5:44:53 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213075,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200221,'Name',120,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2017-06-07 17:44:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:44:52','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','7ca11262-ac52-44f9-aa10-839ddea6e92a','Y',0,'N','N')
;

-- Jun 7, 2017 5:54:31 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Start With Expanded',0,0,'Y',TO_TIMESTAMP('2017-06-07 17:54:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:54:30','YYYY-MM-DD HH24:MI:SS'),100,200417,'StartWithExpanded','D','0f0c4535-582e-47ca-850d-3526a5cac5b5')
;

-- Jun 7, 2017 5:56:09 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Start With Collapsed',0,0,'Y',TO_TIMESTAMP('2017-06-07 17:56:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:56:08','YYYY-MM-DD HH24:MI:SS'),100,200418,'StartWithCollapsed','D','a9572f15-a0a3-431b-869d-5251893457d3')
;

-- Jun 7, 2017 5:56:55 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Add Root',0,0,'Y',TO_TIMESTAMP('2017-06-07 17:56:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:56:54','YYYY-MM-DD HH24:MI:SS'),100,200419,'AddAsRoot','D','afff706d-1680-4abd-b051-99557ad2b56e')
;

-- Jun 7, 2017 5:57:37 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Add a folder to Favorite Tree',0,0,'Y',TO_TIMESTAMP('2017-06-07 17:57:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 17:57:35','YYYY-MM-DD HH24:MI:SS'),100,200420,'AddFolderFavTree','D','e19815e6-2830-469d-ab52-2c682cb3fdf1')
;

-- Jun 7, 2017 6:03:16 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Could not create Node.',0,0,'Y',TO_TIMESTAMP('2017-06-07 18:03:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-07 18:03:15','YYYY-MM-DD HH24:MI:SS'),100,200421,'NodeNotCreate','D','4a212f59-33f2-4317-a1e7-9ca3d3cdaf6f')
;

-- Jun 12, 2017 12:55:53 PM IST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADMenu_ADTreeFavoriteNode', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-06-12 12:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213072
;

-- Jun 12, 2017 12:55:53 PM IST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADTreeFavorite_ADTreeFavoriteN', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-06-12 12:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213069
;

-- Jun 12, 2017 12:55:53 PM IST
CREATE TABLE AD_Tree_Favorite_Node (AD_Client_ID NUMERIC(10) NOT NULL, AD_Menu_ID NUMERIC(10) DEFAULT NULL , AD_Org_ID NUMERIC(10) NOT NULL, AD_Tree_Favorite_ID NUMERIC(10) NOT NULL, AD_Tree_Favorite_Node_ID NUMERIC(10) NOT NULL, AD_Tree_Favorite_Node_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsCollapsible CHAR(1) DEFAULT 'Y' CHECK (IsCollapsible IN ('Y','N')) NOT NULL, IsSummary CHAR(1) DEFAULT 'N' CHECK (IsSummary IN ('Y','N')) NOT NULL, Name VARCHAR(120) DEFAULT NULL , Parent_ID NUMERIC(10) DEFAULT NULL , SeqNo NUMERIC(10) NOT NULL, Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_Tree_Favorite_Node_Key PRIMARY KEY (AD_Tree_Favorite_Node_ID), CONSTRAINT AD_Tree_Favorite_Node_UU_idx UNIQUE (AD_Tree_Favorite_Node_UU))
;

-- Jun 12, 2017 12:55:54 PM IST
ALTER TABLE AD_Tree_Favorite_Node ADD CONSTRAINT ADMenu_ADTreeFavoriteNode FOREIGN KEY (AD_Menu_ID) REFERENCES ad_menu(ad_menu_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 12, 2017 12:55:54 PM IST
ALTER TABLE AD_Tree_Favorite_Node ADD CONSTRAINT ADTreeFavorite_ADTreeFavoriteN FOREIGN KEY (AD_Tree_Favorite_ID) REFERENCES ad_tree_favorite(ad_tree_favorite_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 12, 2017 1:13:43 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Could not create Favorite Tree.',0,0,'Y',TO_TIMESTAMP('2017-06-12 13:13:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-12 13:13:41','YYYY-MM-DD HH24:MI:SS'),100,200423,'FavTreeNotCreate','D','6270a5e3-fb23-4cb2-9616-1cdf34833551')
;

-- Jun 12, 2017 1:22:04 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Please drag an item from a menu.',0,0,'Y',TO_TIMESTAMP('2017-06-12 13:22:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-12 13:22:03','YYYY-MM-DD HH24:MI:SS'),100,200424,'DragItemMenu','D','8b3ed4ca-6cee-4b8c-a0b3-1664ce31dedc')
;

-- Jun 12, 2017 6:31:02 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200137,'AD_Tree_Favorite_Node list','T',0,0,'Y',TO_TIMESTAMP('2017-06-12 18:31:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-12 18:31:00','YYYY-MM-DD HH24:MI:SS'),100,'D','N','47f185a4-37d5-426e-b386-8fabc0f0f49d')
;

-- Jun 12, 2017 6:31:54 PM IST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200137,200221,213067,213067,0,0,'Y',TO_TIMESTAMP('2017-06-12 18:31:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-12 18:31:54','YYYY-MM-DD HH24:MI:SS'),100,'N','D','aa2ae14c-2b0f-43e3-84bb-eac6d3aa2c5d')
;

-- Jun 12, 2017 6:35:17 PM IST
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=200137, FKConstraintType='C',Updated=TO_TIMESTAMP('2017-06-12 18:35:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213070
;

-- Jun 12, 2017 6:38:26 PM IST
UPDATE AD_Column SET FKConstraintName='Parent_ADTreeFavoriteNode', FKConstraintType='C',Updated=TO_TIMESTAMP('2017-06-12 18:38:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213070
;

-- Jun 12, 2017 6:38:26 PM IST
ALTER TABLE AD_Tree_Favorite_Node ADD CONSTRAINT Parent_ADTreeFavoriteNode FOREIGN KEY (Parent_ID) REFERENCES ad_tree_favorite_node(ad_tree_favorite_node_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Jun 13, 2017 12:22:06 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Edit Folder',0,0,'Y',TO_TIMESTAMP('2017-06-13 12:22:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-06-13 12:22:05','YYYY-MM-DD HH24:MI:SS'),100,200425,'EditFolder','D','651947f5-cce5-4ce9-8b59-7d1859f734e1')
;

SELECT register_migration_script('201706131200_IDEMPIERE-3340.sql') FROM dual
;