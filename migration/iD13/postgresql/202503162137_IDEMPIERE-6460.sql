-- 
SELECT register_migration_script('202503162137_IDEMPIERE-6460.sql') FROM dual;

-- Mar 16, 2025, 9:37:40 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200430,'Workflow Node Set Variable','Workflow Node Variable to set on Execution','AD_WF_Node_Var',0,'6',0,0,'Y',TO_TIMESTAMP('2025-03-16 21:37:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:37:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','cbe87cdb-6049-44a0-9a5b-05daa09b3e93','N','N','N')
;

-- Mar 16, 2025, 9:37:41 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_WF_Node_Var',1000000,'N','N','Table AD_WF_Node_Var','Y','Y',0,0,TO_TIMESTAMP('2025-03-16 21:37:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:37:40','YYYY-MM-DD HH24:MI:SS'),100,200520,'Y',1000000,1,200000,'1ceac621-8be9-471e-a92b-fe0cf61e1d74')
;

-- Mar 16, 2025, 9:37:41 PM IST
CREATE SEQUENCE AD_WF_Node_Var_SQ INCREMENT 1 MINVALUE 1000000 MAXVALUE 2147483647 START 1000000
;
-- Mar 16, 2025, 9:39:04 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (217087,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200430,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:39:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:39:03','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','44757a62-83a0-4ef8-9022-ca490d7a6618','N',0,'N','N','D','N')
;

-- Mar 16, 2025, 9:40:01 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (217088,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200430,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:40:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:40:01','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','87a004f6-e69b-4dc0-9917-af5886a85d14','N',0,'N','N','D','N')
;

-- Mar 16, 2025, 9:40:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (217089,0,'Node','Workflow Node (activity), step or process','The Workflow Node indicates a unique step or process in a Workflow.',200430,'AD_WF_Node_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:40:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:40:28','YYYY-MM-DD HH24:MI:SS'),100,142,'Y','N','D','N','N','N','Y','c377da57-bf3f-4898-9952-2bedd70049a4','Y',0,'N','N','N','N')
;

-- Mar 16, 2025, 9:41:44 PM IST
UPDATE AD_Column SET DefaultValue='@1|AD_WF_Node_ID@', IsMandatory='Y', IsIdentifier='Y',Updated=TO_TIMESTAMP('2025-03-16 21:41:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217089
;

-- Mar 16, 2025, 9:43:10 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204000,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:43:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:43:08','YYYY-MM-DD HH24:MI:SS'),100,'AD_WF_Node_Var_ID','Workflow Node Set Variable','Workflow Node Set Variable','D','59869f94-6f54-446c-a03a-add658d538d7')
;

-- Mar 16, 2025, 9:45:07 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (217090,0,'Workflow Node Set Variable',200430,'AD_WF_Node_Var_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:45:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:45:07','YYYY-MM-DD HH24:MI:SS'),100,204000,'N','N','D','N','N','N','Y','a2991a8b-3475-45f0-aa81-4b8afd51a234','N',0,'N','N','N')
;

-- Mar 16, 2025, 9:46:22 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204001,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:46:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:46:22','YYYY-MM-DD HH24:MI:SS'),100,'AD_WF_Node_Var_UU','AD_WF_Node_Var_UU','AD_WF_Node_Var_UU','D','c2090491-9b89-42c9-a85a-7a87c60e3655')
;

-- Mar 16, 2025, 9:47:01 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (217091,0,'AD_WF_Node_Var_UU',200430,'AD_WF_Node_Var_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:47:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:47:01','YYYY-MM-DD HH24:MI:SS'),100,204001,'Y','N','D','N','N','N','Y','e918b992-151d-4275-90eb-2300641c4257','N',0,'N','N','N')
;

-- Mar 16, 2025, 9:48:06 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (217092,0,'Attribute Value','Value of the Attribute','iDempiere converts the (string) field values to the attribute data type.  Booleans (Yes-No) may have the values "true" and "false", the date format is YYYY-MM-DD',200430,'AttributeValue',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:48:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:48:05','YYYY-MM-DD HH24:MI:SS'),100,2317,'Y','N','D','N','N','N','Y','1f449536-141b-4245-bcc1-13838288f162','Y',0,'N','N','N')
;

-- Mar 16, 2025, 9:49:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (217093,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200430,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:49:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:49:10','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','04f3f98a-dcb0-46ee-ad00-f86da2c74c40','N',0,'N','N','N')
;

-- Mar 16, 2025, 9:49:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (217094,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200430,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:49:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:49:42','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','9dc9f8a2-a4d2-465b-b95c-965d50d2a41f','N',0,'N','N','D','N')
;

-- Mar 16, 2025, 9:50:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (217095,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200430,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:50:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:50:36','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','N','N','Y','b1c43fef-fadc-4721-b01a-646a690f9f31','Y',10,'N','N','N')
;

-- Mar 16, 2025, 9:52:20 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (217096,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200430,'EntityType','@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:52:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:52:19','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D & AD_WF_Node_Var_ID>0','D','N','N','N','Y','c671c712-7c1e-42bb-a0d7-7d88548d050e','Y',0,'N','N','N','N')
;

-- Mar 16, 2025, 9:52:39 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (217097,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200430,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:52:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:52:39','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','8ec6e28d-295c-4ada-addc-b65b8cd101d4','N',0,'N','N','N')
;

-- Mar 16, 2025, 9:53:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (217098,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200430,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:53:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:53:16','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','dcec2ef1-633f-434d-bd73-a32a26b3ec4f','N',0,'N','N','N')
;

-- Mar 16, 2025, 9:53:42 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (217099,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200430,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:53:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:53:41','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','0f999817-e39f-400e-9670-bd2c6a15e6f7','N',0,'N','N','D','N')
;

-- Mar 16, 2025, 9:55:55 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (217100,0,'Column','Column in the table','Link to the database column of the table',200430,100,'AD_Column_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-03-16 21:55:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 21:55:54','YYYY-MM-DD HH24:MI:SS'),100,104,'Y','N','D','N','N','N','Y','c7459f14-c855-4fed-a7e3-01e4b32dcbc7','Y',0,'N','N','N','N')
;

-- Mar 16, 2025, 9:56:06 PM IST
UPDATE AD_Column SET FKConstraintName='ADColumn_ADWFNodeVar', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-03-16 21:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217100
;

-- Mar 16, 2025, 9:56:06 PM IST
UPDATE AD_Column SET FKConstraintName='ADWFNode_ADWFNodeVar', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-03-16 21:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217089
;

-- Mar 16, 2025, 9:56:06 PM IST
UPDATE AD_Column SET FKConstraintName='EntityType_ADWFNodeVar', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-03-16 21:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217096
;

-- Mar 16, 2025, 9:56:06 PM IST
CREATE TABLE AD_WF_Node_Var (AD_Client_ID NUMERIC(10) NOT NULL, AD_Column_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_WF_Node_ID NUMERIC(10) NOT NULL, AD_WF_Node_Var_ID NUMERIC(10) NOT NULL, AD_WF_Node_Var_UU VARCHAR(36) DEFAULT NULL , AttributeValue VARCHAR(60) DEFAULT NULL , Created TIMESTAMP DEFAULT statement_timestamp(), CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , EntityType VARCHAR(40) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_WF_Node_Var_Key PRIMARY KEY (AD_WF_Node_Var_ID), CONSTRAINT AD_WF_Node_Var_UU_idx UNIQUE (AD_WF_Node_Var_UU))
;

-- Mar 16, 2025, 9:56:06 PM IST
ALTER TABLE AD_WF_Node_Var ADD CONSTRAINT ADColumn_ADWFNodeVar FOREIGN KEY (AD_Column_ID) REFERENCES ad_column(ad_column_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 16, 2025, 9:56:06 PM IST
ALTER TABLE AD_WF_Node_Var ADD CONSTRAINT ADWFNode_ADWFNodeVar FOREIGN KEY (AD_WF_Node_ID) REFERENCES ad_wf_node(ad_wf_node_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 16, 2025, 9:56:06 PM IST
ALTER TABLE AD_WF_Node_Var ADD CONSTRAINT EntityType_ADWFNodeVar FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 16, 2025, 10:00:51 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,DisplayLogic,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200393,'Variable','Set Variable','Variable to set on execution of the Workflow Node',113,35,'Y',200430,0,0,'Y',TO_TIMESTAMP('2025-03-16 22:00:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:00:50','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',2,'N','D','@Action@=C|@Action@=V','Y','N','3d32b7c4-9a63-4995-97fc-2471b2edfcfb','B','N','Y',0)
;

-- Mar 16, 2025, 10:01:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208756,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200393,217087,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-16 22:01:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:01:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a9648242-50de-48eb-8752-9f52221a3b42','Y',10,2)
;

-- Mar 16, 2025, 10:01:08 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208757,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200393,217088,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-16 22:01:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:01:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','45da68dc-b873-48f8-b07b-a1fb82f90558','Y','N',4,2)
;

-- Mar 16, 2025, 10:01:09 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208758,'Description','Optional short description of the record','A description is limited to 255 characters.',200393,217095,'Y',255,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-16 22:01:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:01:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b64c2656-a9d9-4fa6-8032-2fde0799b5d0','Y',20,5)
;

-- Mar 16, 2025, 10:01:09 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208759,'Node','Workflow Node (activity), step or process','The Workflow Node indicates a unique step or process in a Workflow.',200393,217089,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-16 22:01:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:01:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','41576dab-2f0b-479b-b3aa-4200833d90a8','Y',30,2)
;

-- Mar 16, 2025, 10:01:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208760,'Workflow Node Set Variable',200393,217090,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-16 22:01:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:01:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','99fb7755-f7a3-41a1-be2d-c1514493cf8c','N',2)
;

-- Mar 16, 2025, 10:01:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208761,'AD_WF_Node_Var_UU',200393,217091,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-16 22:01:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:01:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5266a5d6-c069-40ef-b682-3d78cc146b5d','N',2)
;

-- Mar 16, 2025, 10:01:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208762,'Attribute Value','Value of the Attribute','iDempiere converts the (string) field values to the attribute data type.  Booleans (Yes-No) may have the values "true" and "false", the date format is YYYY-MM-DD',200393,217092,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-16 22:01:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:01:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cfbaa133-0216-4e33-a082-787f3f694278','Y',40,5)
;

-- Mar 16, 2025, 10:01:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208763,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200393,217096,'Y',40,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-16 22:01:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:01:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a93868d5-d13d-47be-b71c-cca513189fde','Y',50,2)
;

-- Mar 16, 2025, 10:01:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208764,'Column','Column in the table','Link to the database column of the table',200393,217100,'Y',22,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-16 22:01:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:01:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6fc64a7c-61bf-4793-897c-9de631cc9891','Y',60,2)
;

-- Mar 16, 2025, 10:01:15 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208765,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200393,217097,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-03-16 22:01:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-16 22:01:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','56fd508e-89ad-4312-94c7-4d8da39902b0','Y',70,2,2)
;

-- Mar 16, 2025, 10:02:25 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2025-03-16 22:02:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208764
;

-- Mar 16, 2025, 10:02:25 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=5,Updated=TO_TIMESTAMP('2025-03-16 22:02:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208765
;

-- Mar 16, 2025, 10:02:25 PM IST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2025-03-16 22:02:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208758
;

-- Mar 16, 2025, 10:02:25 PM IST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2025-03-16 22:02:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208763
;

-- Mar 16, 2025, 10:02:25 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-03-16 22:02:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208761
;

-- Mar 16, 2025, 10:02:25 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2025-03-16 22:02:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208759
;

-- Mar 16, 2025, 10:02:25 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-03-16 22:02:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208760
;

-- 17-Mar-2025, 9:50:36 AM IST
UPDATE AD_Tab SET DisplayLogic='@Action@=C|@Action@=V|@Action@=U',Updated=TO_TIMESTAMP('2025-03-17 09:50:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200393
;

-- 17-Mar-2025, 1:42:15 PM IST
INSERT INTO t_alter_column values('ad_wf_node_var','AD_Client_ID','NUMERIC(10)',null,null)
;


-- 17-Mar-2025, 1:44:39 PM IST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2025-03-17 13:44:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217089
;

-- 17-Mar-2025, 1:44:54 PM IST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-03-17 13:44:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208759
;

-- 17-Mar-2025, 7:02:35 PM IST
UPDATE AD_Tab SET AD_Column_ID=217089,Updated=TO_TIMESTAMP('2025-03-17 19:02:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200393
;

-- 27-Mar-2025, 1:24:03 PM IST
UPDATE AD_Column SET DefaultValue='@5|AD_WF_NodeNext_ID@', IsUpdateable='N',Updated=TO_TIMESTAMP('2025-03-27 13:24:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11571
;
