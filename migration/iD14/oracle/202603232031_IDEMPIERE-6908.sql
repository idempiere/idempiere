-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603232031_IDEMPIERE-6908.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 23, 2026, 8:31:43 PM GMT+08:00
INSERT INTO AD_Table (AD_Table_ID,Name,Description,Help,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions,IsPartition,CreatePartition) VALUES (200438,'Extension Registry','Manages the registry of bundled and external extensions','Maintains a record of all extensions installed in the system, whether bundled or external. It stores the JSON manifest , tracks the current deployment state (e.g., Installing, Installed, Disabled) , and helps validate dependencies before deployment.','AD_Extension',0,'4',0,0,'Y',TO_TIMESTAMP('2026-03-23 20:31:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:31:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','019d1aad-fc33-78cc-a084-b73ab4a2bcbb','N','N','N','N','N','N','N')
;

-- Mar 23, 2026, 8:31:44 PM GMT+08:00
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Extension',1000000,'N','N','Table AD_Extension','Y','Y',0,0,TO_TIMESTAMP('2026-03-23 20:31:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:31:43','YYYY-MM-DD HH24:MI:SS'),100,200529,'Y',1000000,1,200000,'019d1aad-ff93-7ed8-b3ad-c74e1612b6a9')
;

-- Mar 23, 2026, 8:33:08 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217443,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200438,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:33:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:33:08','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','N','019d1aaf-4a7e-7cb3-bede-1b761da68e6d','N',0,'N','N','D','N','N')
;

-- Mar 23, 2026, 8:33:43 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217444,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200438,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:33:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:33:42','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','N','019d1aaf-d1b0-7ac7-aab1-418815ef20ee','N',0,'N','N','D','N','N')
;

-- Mar 23, 2026, 8:34:12 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217445,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200438,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:34:12','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','N','019d1ab0-455d-7381-8b7b-ff20dc69376b','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 8:34:41 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217446,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200438,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:34:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:34:41','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','N','019d1ab0-b628-7fc9-bd06-0248385a1adf','N',0,'N','N','D','N','N')
;

-- Mar 23, 2026, 8:35:11 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217447,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200438,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:35:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:35:10','YYYY-MM-DD HH24:MI:SS'),100,607,'Y','N','D','N','N','N','Y','019d1ab1-28dd-7ca6-896b-4fb62ba48eaf','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 8:35:26 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217448,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200438,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:35:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:35:26','YYYY-MM-DD HH24:MI:SS'),100,608,'Y','N','D','N','N','N','Y','019d1ab1-65c3-7470-bcea-4313ea2c6164','N',0,'N','N','D','N','N')
;

-- Mar 23, 2026, 8:35:48 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217449,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200438,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:35:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:35:47','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','019d1ab1-b9b3-7d0b-ab2d-e645c1f53b5f','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 8:37:36 PM GMT+08:00
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204050,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:36:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:36:08','YYYY-MM-DD HH24:MI:SS'),100,'AD_Extension_ID','Extension Registry','Registry of bundled and external extensions',NULL,'Extension Registry','D','019d1ab3-5ef6-7739-af07-c0d83e1e79f3')
;

-- Mar 23, 2026, 8:38:00 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217450,0,'Extension Registry','Registry of bundled and external extensions',200438,'AD_Extension_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:37:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:37:59','YYYY-MM-DD HH24:MI:SS'),100,204050,'N','N','D','N','N','N','Y','019d1ab3-bdb5-724d-a0ab-d77dfe2902c3','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 8:45:00 PM GMT+08:00
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204051,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:41:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:41:51','YYYY-MM-DD HH24:MI:SS'),100,'ExtensionVersion','Version','Version of an extension','Semantic version of an extension (recommended to follow the semantic version definition at https://semver.org/)','Version','D','019d1aba-27d7-77c0-82a8-91dd9893a0b0')
;

-- Mar 23, 2026, 8:46:44 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217451,0,'Version','Version of an extension','Semantic version of an extension (recommended to follow the semantic version definition at https://semver.org/)',200438,'ExtensionVersion',30,'N','N','Y','N','Y',20,'N',10,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:46:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:46:44','YYYY-MM-DD HH24:MI:SS'),100,204051,'N','Y','D','N','N','N','Y','019d1abb-bdf5-79e5-ae1b-4b3cba51f0c9','N',20,'N','N','N','N')
;

-- Mar 23, 2026, 8:48:27 PM GMT+08:00
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204053,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:47:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:47:32','YYYY-MM-DD HH24:MI:SS'),100,'ExtensionId','Extension Symbolic Id','Unique symbolic id of an extension',NULL,'Extension Symbolic Id','D','019d1abd-4e2a-7fda-99c9-581b676e229d')
;

-- Mar 23, 2026, 8:49:03 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217453,0,'Extension Symbolic Id','Unique symbolic id of an extension',200438,'ExtensionId',255,'N','N','Y','N','Y',10,'N',10,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:49:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:49:02','YYYY-MM-DD HH24:MI:SS'),100,204053,'N','Y','D','N','N','N','Y','019d1abd-da92-725d-b1c8-41bf04bd4729','N',10,'N','N','N','N')
;

-- Mar 23, 2026, 8:51:53 PM GMT+08:00
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204054,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:51:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:51:15','YYYY-MM-DD HH24:MI:SS'),100,'IsBundled','Is Bundled','Indicates if the extension is bundled with the core product','A flag indicating whether this extension is distributed as part of the base iDempiere installation or if it is an externally installed extension (e.g., via a .idext archive or a GitHub repository)','Is Bundled','D','019d1ac0-72fd-773d-bdca-fbe006d891b3')
;

-- Mar 23, 2026, 8:53:01 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217454,0,'Is Bundled','Indicates if the extension is bundled with the core product','A flag indicating whether this extension is distributed as part of the base iDempiere installation or if it is an externally installed extension (e.g., via a .idext archive or a GitHub repository)',200438,'IsBundled','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-03-23 20:53:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 20:53:01','YYYY-MM-DD HH24:MI:SS'),100,204054,'N','Y','D','N','N','N','Y','019d1ac1-7f06-7901-966b-232e6f50406e','N',30,'N','N','N','N')
;

-- Mar 23, 2026, 9:02:25 PM GMT+08:00
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204055,0,0,'Y',TO_TIMESTAMP('2026-03-23 21:01:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 21:01:19','YYYY-MM-DD HH24:MI:SS'),100,'ExtensionMetadata','Extension Metadata','The JSON manifest containing extension details and dependencies','Stores the complete metadata.json payload associated with the extension. This includes the unique identifier, versioning, OSGi bundle references, and prerequisite dependencies required for installation.','Extension Metadata','D','019d1aca-17e5-734a-92af-cc39492fb143')
;

-- Mar 23, 2026, 9:03:01 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217455,0,'Extension Metadata','The JSON manifest containing extension details and dependencies','Stores the complete metadata.json payload associated with the extension. This includes the unique identifier, versioning, OSGi bundle references, and prerequisite dependencies required for installation.',200438,'ExtensionMetadata',0,'N','N','Y','N','N',0,'N',200267,0,0,'Y',TO_TIMESTAMP('2026-03-23 21:03:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 21:03:00','YYYY-MM-DD HH24:MI:SS'),100,204055,'N','N','D','N','N','N','Y','019d1aca-a5d2-76b8-b257-395b63dda935','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 9:07:13 PM GMT+08:00
UPDATE AD_Element SET Name='Extension', Description='System Extension', Help='Internal unique identifier for a System Extension record', PrintName='Extension',Updated=TO_TIMESTAMP('2026-03-23 21:07:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=204050
;

-- Mar 23, 2026, 9:07:13 PM GMT+08:00
UPDATE AD_Column SET ColumnName='AD_Extension_ID', Name='Extension', Description='System Extension', Help='Internal unique identifier for a System Extension record', Placeholder=NULL WHERE AD_Element_ID=204050
;

-- Mar 23, 2026, 9:07:13 PM GMT+08:00
UPDATE AD_Process_Para SET ColumnName='AD_Extension_ID', Name='Extension', Description='System Extension', Help='Internal unique identifier for a System Extension record', AD_Element_ID=204050 WHERE UPPER(ColumnName)='AD_EXTENSION_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 23, 2026, 9:07:13 PM GMT+08:00
UPDATE AD_Process_Para SET ColumnName='AD_Extension_ID', Name='Extension', Description='System Extension', Help='Internal unique identifier for a System Extension record', Placeholder=NULL WHERE AD_Element_ID=204050 AND IsCentrallyMaintained='Y'
;

-- Mar 23, 2026, 9:07:13 PM GMT+08:00
UPDATE AD_InfoColumn SET ColumnName='AD_Extension_ID', Name='Extension', Description='System Extension', Help='Internal unique identifier for a System Extension record', Placeholder=NULL WHERE AD_Element_ID=204050 AND IsCentrallyMaintained='Y'
;

-- Mar 23, 2026, 9:07:13 PM GMT+08:00
UPDATE AD_Field SET Name='Extension', Description='System Extension', Help='Internal unique identifier for a System Extension record', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=204050) AND IsCentrallyMaintained='Y'
;

-- Mar 23, 2026, 9:07:13 PM GMT+08:00
UPDATE AD_PrintFormatItem SET PrintName='Extension', Name='Extension' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=204050)
;

-- Mar 23, 2026, 9:33:47 PM GMT+08:00
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204056,0,0,'Y',TO_TIMESTAMP('2026-03-23 21:32:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 21:32:59','YYYY-MM-DD HH24:MI:SS'),100,'ExtensionState','Extension State','Current installation and deployment state of the extension','Indicates the current lifecycle status of the extension within the system, such as Installed, Disabled, Error, or Uninstalled.','Extension State','D','019d1ae6-d1bf-7cf6-b7d3-88a6ded0ee8d')
;

-- Mar 23, 2026, 9:42:23 PM GMT+08:00
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,Help,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200284,'AD_Extension ExtensionState List','List of valid states for an extension''s lifecycle','Defines the allowed deployment and operational states for records in the AD_Extension table','L',0,0,'Y',TO_TIMESTAMP('2026-03-23 21:42:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 21:42:22','YYYY-MM-DD HH24:MI:SS'),100,'D','N','019d1aee-afd6-7455-bddb-ccd08b61d4a9','N')
;

-- Mar 23, 2026, 9:45:29 PM GMT+08:00
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200761,'Installed','Extension is fully deployed and active',200284,'IN',0,0,'Y',TO_TIMESTAMP('2026-03-23 21:45:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 21:45:27','YYYY-MM-DD HH24:MI:SS'),100,'D','019d1af1-84f9-7fa4-bfa6-b730f5ae26ef')
;

-- Mar 23, 2026, 9:45:56 PM GMT+08:00
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200762,'Disabled','Extension is deactivated',200284,'DI',0,0,'Y',TO_TIMESTAMP('2026-03-23 21:45:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 21:45:55','YYYY-MM-DD HH24:MI:SS'),100,'D','019d1af1-ee76-7f34-bc61-1c3aab4c3f22')
;

-- Mar 23, 2026, 9:47:37 PM GMT+08:00
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200763,'Uninstalled','The OSGi bundles have been uninstalled and the underlying database dictionary objects have been deactivated',200284,'UN',0,0,'Y',TO_TIMESTAMP('2026-03-23 21:47:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 21:47:36','YYYY-MM-DD HH24:MI:SS'),100,'D','019d1af3-797f-7f5a-9cbc-abf3c11805f1')
;

-- Mar 23, 2026, 9:48:13 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217456,0,'Extension State','Current installation and deployment state of the extension','Indicates the current lifecycle status of the extension within the system, such as Installed, Disabled, Error, or Uninstalled.',200438,'ExtensionState',2,'N','N','Y','N','N',0,'N',17,200284,0,0,'Y',TO_TIMESTAMP('2026-03-23 21:48:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 21:48:13','YYYY-MM-DD HH24:MI:SS'),100,204056,'Y','Y','D','N','N','N','Y','019d1af4-08fb-741e-a7e0-f075058851a0','N',40,'N','N','N','N')
;

-- Mar 23, 2026, 9:49:14 PM GMT+08:00
CREATE TABLE AD_Extension (AD_Client_ID NUMBER(10) NOT NULL, AD_Extension_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE DEFAULT SYSDATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, ExtensionId VARCHAR2(255 CHAR) NOT NULL, ExtensionMetadata CLOB CONSTRAINT AD_Extension_ExtensionMetadata_isjson CHECK (ExtensionMetadata IS JSON) NOT NULL, ExtensionState VARCHAR2(2 CHAR) NOT NULL, ExtensionVersion VARCHAR2(30 CHAR) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsBundled CHAR(1) DEFAULT 'N' CHECK (IsBundled IN ('Y','N')) NOT NULL, Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_Extension_Key PRIMARY KEY (AD_Extension_ID))
;

-- Mar 23, 2026, 9:52:29 PM GMT+08:00
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204057,0,0,'Y',TO_TIMESTAMP('2026-03-23 21:52:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 21:52:29','YYYY-MM-DD HH24:MI:SS'),100,'AD_Extension_UU','Extension UUID','System Extension','Internal UUID for a System Extension record','Extension UUID','D','019d1af7-f0b2-7a5f-93b0-af60ccf926f9')
;

-- Mar 23, 2026, 9:52:49 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217457,0,'Extension UUID','System Extension','Internal UUID for a System Extension record',200438,'AD_Extension_UU',36,'N','N','Y','N','N',0,'N',200231,0,0,'Y',TO_TIMESTAMP('2026-03-23 21:52:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 21:52:48','YYYY-MM-DD HH24:MI:SS'),100,204057,'N','N','D','N','N','N','Y','019d1af8-3db0-7b25-b446-1c1dc38e7110','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 9:52:52 PM GMT+08:00
ALTER TABLE AD_Extension ADD AD_Extension_UU VARCHAR2/*UUID*/(36) NOT NULL
;

-- Mar 23, 2026, 9:52:52 PM GMT+08:00
ALTER TABLE AD_Extension ADD CONSTRAINT AD_Extension_UU_idx UNIQUE (AD_Extension_UU)
;

-- Mar 23, 2026, 9:54:36 PM GMT+08:00
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201308,'019d1af9-de0f-701d-b0f0-cabec5a06960',TO_TIMESTAMP('2026-03-23 21:54:35','YYYY-MM-DD HH24:MI:SS'),100,'ExtensionId Unique Index','D','Y','AD_ExtensionId_Idx',TO_TIMESTAMP('2026-03-23 21:54:35','YYYY-MM-DD HH24:MI:SS'),100,200438,'N','Y','N','N','N')
;

-- Mar 23, 2026, 9:54:45 PM GMT+08:00
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201801,'019d1afa-0120-798b-97dc-281bc9497752',TO_TIMESTAMP('2026-03-23 21:54:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-03-23 21:54:44','YYYY-MM-DD HH24:MI:SS'),100,217453,201308,10)
;

-- Mar 23, 2026, 9:54:58 PM GMT+08:00
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201802,'019d1afa-3508-73e6-9938-817362171ee2',TO_TIMESTAMP('2026-03-23 21:54:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-03-23 21:54:57','YYYY-MM-DD HH24:MI:SS'),100,217451,201308,20)
;

-- Mar 23, 2026, 9:55:06 PM GMT+08:00
CREATE UNIQUE INDEX AD_ExtensionId_Idx ON AD_Extension (ExtensionId,ExtensionVersion)
;

-- Mar 23, 2026, 11:23:26 PM GMT+08:00
INSERT INTO AD_Table (AD_Table_ID,Name,Description,Help,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions,IsPartition,CreatePartition) VALUES (200439,'System Extension Entities','The database dictionary objects belonging to an installed extension','A detail table linking an installed extension to its specific database objects. During a soft uninstallation or deactivation, the system uses this mapping to set IsActive = ''N'' on all related dictionary records, preserving historical data integrity.','AD_ExtensionEntity',0,'4',0,0,'Y',TO_TIMESTAMP('2026-03-23 23:23:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:23:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','019d1b4b-342f-7e2e-a5e5-f86e594c8979','N','N','N','N','N','N','N')
;

-- Mar 23, 2026, 11:23:27 PM GMT+08:00
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_ExtensionEntity',1000000,'N','N','Table AD_ExtensionEntity','Y','Y',0,0,TO_TIMESTAMP('2026-03-23 23:23:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:23:26','YYYY-MM-DD HH24:MI:SS'),100,200530,'Y',1000000,1,200000,'019d1b4b-369a-71c7-92f7-4898ee12a1f1')
;

-- Mar 23, 2026, 11:28:52 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217458,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200439,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:28:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:28:51','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','019d1b50-2b6d-7e56-be1a-71bd1cf60e21','N',0,'N','N','D','N','N')
;

-- Mar 23, 2026, 11:29:08 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217459,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200439,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:29:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:29:07','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','019d1b50-6a08-73e0-ae2f-638b2bb66a1a','N',0,'N','N','D','N','N')
;

-- Mar 23, 2026, 11:29:23 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217460,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200439,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:29:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:29:22','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','019d1b50-a4ff-7719-956d-211ade3a43ea','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 11:29:35 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217461,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200439,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:29:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:29:34','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','019d1b50-d49c-7617-adfa-119a11501ae1','N',0,'N','N','D','N','N')
;

-- Mar 23, 2026, 11:29:48 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217462,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200439,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:29:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:29:47','YYYY-MM-DD HH24:MI:SS'),100,607,'Y','N','D','N','N','N','Y','019d1b51-0641-7541-a98a-fa7900ca8841','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 11:30:01 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217463,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200439,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:30:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:30:00','YYYY-MM-DD HH24:MI:SS'),100,608,'Y','N','D','N','N','N','Y','019d1b51-38b5-713e-93f2-41dd3df7d9fc','N',0,'N','N','D','N','N')
;

-- Mar 23, 2026, 11:30:19 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217464,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200439,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:30:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:30:18','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','019d1b51-7f7d-71c4-9a33-02e6ebc4520b','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 11:50:40 PM GMT+08:00
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204058,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:31:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:31:13','YYYY-MM-DD HH24:MI:SS'),100,'AD_ExtensionEntity_ID','Extension Entity','System Extension Entity','Internal unique identifier for a System Extension Entity record','Extension Entity','D','019d1b64-23eb-7433-a043-7beeb69ecdce')
;

-- Mar 23, 2026, 11:50:55 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217465,0,'Extension Entity','System Extension Entity','Internal unique identifier for a System Extension Entity record',200439,'AD_ExtensionEntity_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:50:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:50:54','YYYY-MM-DD HH24:MI:SS'),100,204058,'N','N','D','N','N','N','Y','019d1b64-5b83-764f-8423-36be8f670c55','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 11:51:26 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217466,0,'Extension','System Extension','Internal unique identifier for a System Extension record',200439,'AD_Extension_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:51:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:51:25','YYYY-MM-DD HH24:MI:SS'),100,204050,'N','N','D','N','N','N','Y','019d1b64-d585-70d9-a247-b29d5d0ae2c5','N',0,'N','N','N','N','N')
;

-- Mar 23, 2026, 11:52:40 PM GMT+08:00
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204059,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:51:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:51:46','YYYY-MM-DD HH24:MI:SS'),100,'AD_ExtensionEntity_UU','Extension Entity UUID','System Extension Entity UUID','Internal UUID for a System Extension Entity record','Extension Entity UUID','D','019d1b65-f84c-730c-9a7e-c3fe93e1b5d1')
;

-- Mar 23, 2026, 11:52:57 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217467,0,'Extension Entity UUID','System Extension Entity UUID','Internal UUID for a System Extension Entity record',200439,'AD_ExtensionEntity_UU',36,'N','N','Y','N','N',0,'N',200231,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:52:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:52:57','YYYY-MM-DD HH24:MI:SS'),100,204059,'N','N','D','N','N','N','Y','019d1b66-3a31-791c-9bf3-bdc4af3d64e8','N',0,'N','N','N','N')
;

-- Mar 23, 2026, 11:54:11 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217468,0,'Table','Database Table information','The Database Table provides the information of the table definition',200439,'AD_Table_ID',10,'N','N','Y','N','Y',10,'N',19,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:54:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:54:10','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','Y','D','N','N','N','Y','019d1b67-59ec-7064-a5d4-e3b4705b15d4','N',10,'N','N','N','N','N')
;

-- Mar 23, 2026, 11:54:43 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217469,0,'Record UUID',200439,'Record_UU',36,'N','N','Y','N','Y',20,'N',200240,0,0,'Y',TO_TIMESTAMP('2026-03-23 23:54:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-23 23:54:41','YYYY-MM-DD HH24:MI:SS'),100,203804,'Y','Y','D','N','N','N','Y','019d1b67-d5f2-77ce-8d7d-aa94a2284c0c','N',20,'N','N','M','N','N')
;

-- Mar 23, 2026, 11:56:30 PM GMT+08:00
UPDATE AD_Column SET FieldLength=36, AD_Reference_ID=200235, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2026-03-23 23:56:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217469
;

-- Mar 23, 2026, 11:57:17 PM GMT+08:00
UPDATE AD_Column SET FKConstraintName='ADExtension_ADExtensionEntity', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-23 23:57:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217466
;

-- Mar 23, 2026, 11:57:17 PM GMT+08:00
UPDATE AD_Column SET FKConstraintName='ADTable_ADExtensionEntity', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-23 23:57:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217468
;

-- Mar 23, 2026, 11:57:17 PM GMT+08:00
CREATE TABLE AD_ExtensionEntity (AD_Client_ID NUMBER(10) NOT NULL, AD_ExtensionEntity_ID NUMBER(10) NOT NULL, AD_ExtensionEntity_UU VARCHAR2/*UUID*/(36) NOT NULL, AD_Extension_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_Table_ID NUMBER(10) NOT NULL, Created DATE DEFAULT SYSDATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Record_UU VARCHAR2/*UUID*/(36) NOT NULL, Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_ExtensionEntity_Key PRIMARY KEY (AD_ExtensionEntity_ID), CONSTRAINT AD_ExtensionEntity_UU_idx UNIQUE (AD_ExtensionEntity_UU))
;

-- Mar 23, 2026, 11:57:17 PM GMT+08:00
ALTER TABLE AD_ExtensionEntity ADD CONSTRAINT ADExtension_ADExtensionEntity FOREIGN KEY (AD_Extension_ID) REFERENCES ad_extension(ad_extension_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 23, 2026, 11:57:17 PM GMT+08:00
ALTER TABLE AD_ExtensionEntity ADD CONSTRAINT ADTable_ADExtensionEntity FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 23, 2026, 11:58:10 PM GMT+08:00
UPDATE AD_Column SET FieldLength=36, AD_Reference_ID=200240,Updated=TO_TIMESTAMP('2026-03-23 23:58:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217469
;

-- Mar 23, 2026, 11:58:13 PM GMT+08:00
UPDATE AD_Column SET FKConstraintName='ADExtension_ADExtensionEntity', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-23 23:58:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217466
;

-- Mar 23, 2026, 11:58:13 PM GMT+08:00
UPDATE AD_Column SET FKConstraintName='ADTable_ADExtensionEntity', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-23 23:58:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217468
;

-- Mar 24, 2026, 12:00:59 AM GMT+08:00
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201309,'019d1b6d-93f6-7efc-91a3-d8807ec19a31',TO_TIMESTAMP('2026-03-24 00:00:57','YYYY-MM-DD HH24:MI:SS'),100,'AD_ExtensionEntity Unique Index for table and record uuid','D','Y','AD_ExtensionEntity_Unq_Idx',TO_TIMESTAMP('2026-03-24 00:00:57','YYYY-MM-DD HH24:MI:SS'),100,200439,'N','Y','N','N','N')
;

-- Mar 24, 2026, 12:01:16 AM GMT+08:00
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201803,'019d1b6d-d661-761a-a0fd-d22ebd256a19',TO_TIMESTAMP('2026-03-24 00:01:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-03-24 00:01:14','YYYY-MM-DD HH24:MI:SS'),100,217466,201309,10)
;

-- Mar 24, 2026, 12:01:23 AM GMT+08:00
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201804,'019d1b6d-f0c5-7d0e-8b9c-7ba7e4de4bb5',TO_TIMESTAMP('2026-03-24 00:01:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-03-24 00:01:22','YYYY-MM-DD HH24:MI:SS'),100,217468,201309,20)
;

-- Mar 24, 2026, 12:01:30 AM GMT+08:00
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201805,'019d1b6e-0e72-7e3d-b1e6-10087b78326b',TO_TIMESTAMP('2026-03-24 00:01:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-03-24 00:01:30','YYYY-MM-DD HH24:MI:SS'),100,217469,201309,30)
;

-- Mar 24, 2026, 12:01:46 AM GMT+08:00
CREATE UNIQUE INDEX AD_ExtensionEntity_Unq_Idx ON AD_ExtensionEntity (AD_Extension_ID,AD_Table_ID,Record_UU)
;

