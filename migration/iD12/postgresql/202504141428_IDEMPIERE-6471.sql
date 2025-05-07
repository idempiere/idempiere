-- IDEMPIERE-6471 Prevent data corruption if a plugin is missing
SELECT register_migration_script('202504141428_IDEMPIERE-6471.sql') FROM dual;

-- Apr 14, 2025, 2:28:13 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200431,'Required Plugin','Register of plugins that are required when running the System','AD_RequiredPlugin','4',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:28:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','59222177-f1a7-4210-ab95-c2ca3eb3a0ec','N')
;

-- Apr 14, 2025, 2:28:14 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_RequiredPlugin',1000000,'N','N','Table AD_RequiredPlugin','Y','Y',0,0,TO_TIMESTAMP('2025-04-14 14:28:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:13','YYYY-MM-DD HH24:MI:SS'),100,200521,'Y',1000000,1,200000,'5c633459-23b9-4970-8a90-ed746105c636')
;

-- Apr 14, 2025, 2:28:14 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217101,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200431,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:28:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:14','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','35448f0c-369d-4aca-a8ba-c39b77d92059','N')
;

-- Apr 14, 2025, 2:28:14 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217102,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200431,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:28:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:14','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','b4ae28da-e2f9-4ce6-bd10-a94305a6345e','N')
;

-- Apr 14, 2025, 2:28:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217103,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200431,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:28:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:14','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','5615a2b5-6a05-46e2-8e24-81c631d61833','N')
;

-- Apr 14, 2025, 2:28:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217104,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200431,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:28:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:15','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','7aeb9670-bce8-4c92-812c-7cba6cd34e13','N')
;

-- Apr 14, 2025, 2:28:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217105,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200431,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:28:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:15','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','ea503379-9a6d-4ae5-8427-a86d72b04b25','N')
;

-- Apr 14, 2025, 2:28:16 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217106,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200431,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:28:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:15','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','7fea105f-5a5c-4fc9-911f-5390bfa4f03f','N')
;

-- Apr 14, 2025, 2:28:16 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217107,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200431,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:28:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:16','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','d004fe2f-089d-43e5-979b-669c6785199e','N')
;

-- Apr 14, 2025, 2:28:16 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204004,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:28:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:16','YYYY-MM-DD HH24:MI:SS'),100,'AD_RequiredPlugin_UU','AD_RequiredPlugin_UU','AD_RequiredPlugin_UU','D','8b1cc0f6-a75a-4e5b-b1c0-628a01427d5b')
;

-- Apr 14, 2025, 2:28:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217108,0.0,'AD_RequiredPlugin_UU',200431,'AD_RequiredPlugin_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:28:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:28:16','YYYY-MM-DD HH24:MI:SS'),100,204004,'Y','N','D','N','19ba0aa2-43b4-413a-b183-43ce39b6cd7e','N')
;

-- Apr 14, 2025, 2:28:17 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201287,'b6c6be31-affe-4416-acb7-d00282db0933',TO_TIMESTAMP('2025-04-14 14:28:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_RequiredPlugin_UU_idx',TO_TIMESTAMP('2025-04-14 14:28:17','YYYY-MM-DD HH24:MI:SS'),100,200431,'Y','Y','N','Y')
;

-- Apr 14, 2025, 2:28:18 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201757,'0be81665-3cd5-4c32-86e5-71146d3cadc0',TO_TIMESTAMP('2025-04-14 14:28:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-04-14 14:28:17','YYYY-MM-DD HH24:MI:SS'),100,217108,201287,10)
;

-- Apr 14, 2025, 2:29:18 PM CEST
UPDATE AD_Table SET Help='Register in this window the plugins that when missing on a System can cause data corruption or failures.',Updated=TO_TIMESTAMP('2025-04-14 14:29:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200431
;

-- Apr 14, 2025, 2:29:45 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204005,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:29:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:29:33','YYYY-MM-DD HH24:MI:SS'),100,'PluginName','Plugin Name',NULL,NULL,'Plugin Name','D','72a7028c-fb75-4715-93f1-10a01e17ae14')
;

-- Apr 14, 2025, 2:30:21 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217109,0,'Plugin Name',200431,'PluginName',1000,'N','N','N','N','Y',1,'N',10,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:30:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:30:20','YYYY-MM-DD HH24:MI:SS'),100,204005,'N','Y','D','N','N','N','Y','069c7a9a-24c1-4d8d-b7c6-06a5fb266d96','Y',10,'N','N','N','N')
;

-- Apr 14, 2025, 2:31:33 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204006,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:30:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:30:59','YYYY-MM-DD HH24:MI:SS'),100,'PluginExpectedState','Expected State',NULL,NULL,'Expected State','D','d12db9b5-e668-40ab-8d7e-c6bfa9ff9662')
;

-- Apr 14, 2025, 2:33:28 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200274,'PluginExpectedState','L',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:33:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:33:27','YYYY-MM-DD HH24:MI:SS'),100,'D','N','24725672-b23c-4745-910b-50164c50b75a','N')
;

-- Apr 14, 2025, 2:33:35 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200717,'ACTIVE',200274,'ACTIVE',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:33:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:33:35','YYYY-MM-DD HH24:MI:SS'),100,'D','9dab8cd4-edc7-48f6-a6cb-8761a1193dbf')
;

-- Apr 14, 2025, 2:33:40 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200718,'INSTALLED',200274,'INSTALLED',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:33:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:33:40','YYYY-MM-DD HH24:MI:SS'),100,'D','652ddeef-c9b8-43ba-85d0-68b6a936d81a')
;

-- Apr 14, 2025, 2:33:45 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200719,'RESOLVED',200274,'RESOLVED',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:33:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:33:45','YYYY-MM-DD HH24:MI:SS'),100,'D','eb73432c-3bfe-49be-8aab-96747c141648')
;

-- Apr 14, 2025, 2:34:01 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200720,'STARTING',200274,'STARTING',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:34:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:34:00','YYYY-MM-DD HH24:MI:SS'),100,'D','7213d872-6ce4-429a-95b6-5420b59bdddb')
;

-- Apr 14, 2025, 2:34:05 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200721,'STOPPING',200274,'STOPPING',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:34:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:34:05','YYYY-MM-DD HH24:MI:SS'),100,'D','4c900f3a-4161-47f0-9079-f6c6ea263dcb')
;

-- Apr 14, 2025, 2:34:09 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200722,'UNINSTALLED',200274,'UNINSTALLED',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:34:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:34:09','YYYY-MM-DD HH24:MI:SS'),100,'D','912fb98a-c9e6-404e-b3a1-b5487e6e8965')
;

-- Apr 14, 2025, 2:34:14 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200723,'UNKNOWN',200274,'UNKNOWN',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:34:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:34:13','YYYY-MM-DD HH24:MI:SS'),100,'D','5afaffef-f57e-46c6-b257-226dd3006d95')
;

-- Apr 14, 2025, 2:34:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217110,0,'Expected State',200431,'PluginExpectedState',20,'N','N','N','N','N',0,'N',17,200274,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:34:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:34:31','YYYY-MM-DD HH24:MI:SS'),100,204006,'Y','N','D','N','N','N','Y','a139d252-ed20-4964-a9bb-7140a2ef2bb9','Y',0,'N','N','N','N')
;

-- Apr 14, 2025, 2:34:59 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200155,'Required Plugin',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:34:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:34:58','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','c7ae07fc-5736-4d51-a35c-6bd37750553f')
;

-- Apr 14, 2025, 2:34:59 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200394,'Required Plugin',200155,10,'Y',200431,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:34:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:34:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','AD_RequiredPlugin.Created DESC','N',0,'N','D','Y','N','5168d547-6f05-4b0e-ab64-a163038bb06f')
;

-- Apr 14, 2025, 2:35:00 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208766,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200394,217101,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:34:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:34:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','142b712e-7441-4dc2-89c8-018fe906fb4a','N',2)
;

-- Apr 14, 2025, 2:35:00 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208767,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200394,217102,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:35:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:35:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0e7aa8a4-5004-41c9-8040-42bb6c513d65','Y','N',4,2)
;

-- Apr 14, 2025, 2:35:00 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208768,'AD_RequiredPlugin_UU',200394,217108,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:35:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:35:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','921d5d09-695a-45b2-826a-16752bf6d7e7','N',2)
;

-- Apr 14, 2025, 2:35:01 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208769,'Plugin Name',200394,217109,'Y',1000,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:35:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:35:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','13e4627c-2257-490d-9daa-edb46116eab6','Y',10,5)
;

-- Apr 14, 2025, 2:35:01 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208770,'Expected State',200394,217110,'Y',20,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:35:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:35:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a2c3816b-087d-479b-af6a-15d7614dbdfe','Y',20,2)
;

-- Apr 14, 2025, 2:35:01 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208771,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200394,217107,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-04-14 14:35:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:35:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','97e5658b-8e90-4937-999f-026ffc2f1f07','Y',30,2,2)
;

-- Apr 14, 2025, 2:35:02 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200241,'Required Plugin','W',200155,0,0,'Y',TO_TIMESTAMP('2025-04-14 14:35:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 14:35:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','452a2ebe-7b56-4592-ad90-f6427462acb1')
;

-- Apr 14, 2025, 2:35:02 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200241, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200241)
;

-- Apr 14, 2025, 2:35:02 PM CEST
UPDATE AD_Table SET AD_Window_ID=200155,Updated=TO_TIMESTAMP('2025-04-14 14:35:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200431
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=1000004
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200241
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200072
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=27,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=28,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=29,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200150
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=30,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200174
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=31,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200238
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=32,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=33,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=34,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=35,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200143
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=36,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=37,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200198
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=38,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200206
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=39,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200207
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=40,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200208
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=41,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200227
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=42,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200228
;

-- Apr 14, 2025, 2:36:56 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=43,Updated=TO_TIMESTAMP('2025-04-14 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Apr 14, 2025, 2:41:00 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADRequiredPlugin', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-04-14 14:41:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217101
;

-- Apr 14, 2025, 2:41:00 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADRequiredPlugin', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-04-14 14:41:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217102
;

-- Apr 14, 2025, 2:41:00 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADRequiredPlugin', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-04-14 14:41:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217104
;

-- Apr 14, 2025, 2:41:00 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADRequiredPlugin', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-04-14 14:41:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217106
;

-- Apr 14, 2025, 2:41:00 PM CEST
CREATE TABLE AD_RequiredPlugin (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_RequiredPlugin_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, PluginExpectedState VARCHAR(20) DEFAULT NULL , PluginName VARCHAR(1000) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_RequiredPlugin_UU_idx PRIMARY KEY (AD_RequiredPlugin_UU))
;

-- Apr 14, 2025, 2:41:00 PM CEST
ALTER TABLE AD_RequiredPlugin ADD CONSTRAINT ADClient_ADRequiredPlugin FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 14, 2025, 2:41:00 PM CEST
ALTER TABLE AD_RequiredPlugin ADD CONSTRAINT ADOrg_ADRequiredPlugin FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 14, 2025, 2:41:00 PM CEST
ALTER TABLE AD_RequiredPlugin ADD CONSTRAINT CreatedBy_ADRequiredPlugin FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 14, 2025, 2:41:00 PM CEST
ALTER TABLE AD_RequiredPlugin ADD CONSTRAINT UpdatedBy_ADRequiredPlugin FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 14, 2025, 2:59:43 PM CEST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2025-04-14 14:59:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217109
;

-- Apr 14, 2025, 3:20:10 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217111,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200431,'EntityType','@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_TIMESTAMP('2025-04-14 15:20:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 15:20:10','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','30cbb7f7-a682-4c7a-89aa-523c048450db','Y',0,'N','N','N','N','N')
;

-- Apr 14, 2025, 3:20:58 PM CEST
INSERT INTO t_alter_column values('ad_requiredplugin','PluginName','VARCHAR(1000)',null,'NULL')
;

-- Apr 14, 2025, 3:20:58 PM CEST
UPDATE AD_Column SET FKConstraintName='EntityType_ADRequiredPlugin', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-04-14 15:20:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217111
;

-- Apr 14, 2025, 3:20:58 PM CEST
ALTER TABLE AD_RequiredPlugin ADD COLUMN EntityType VARCHAR(40) DEFAULT NULL 
;

-- Apr 14, 2025, 3:20:58 PM CEST
ALTER TABLE AD_RequiredPlugin ADD CONSTRAINT EntityType_ADRequiredPlugin FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 14, 2025, 3:21:22 PM CEST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2025-04-14 15:21:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217111
;

-- Apr 14, 2025, 3:21:24 PM CEST
INSERT INTO t_alter_column values('ad_requiredplugin','EntityType','VARCHAR(40)',null,null)
;

-- Apr 14, 2025, 3:21:24 PM CEST
INSERT INTO t_alter_column values('ad_requiredplugin','EntityType',null,'NOT NULL',null)
;

-- Apr 14, 2025, 3:21:39 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208772,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200394,217111,'Y',40,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-04-14 15:21:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 15:21:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bf9857f4-2708-4ec9-9b3c-edc977f1a1bd','Y',40,2)
;

-- Apr 14, 2025, 3:21:56 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=4,Updated=TO_TIMESTAMP('2025-04-14 15:21:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208772
;

-- Apr 14, 2025, 3:21:56 PM CEST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2025-04-14 15:21:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208771
;

-- Apr 14, 2025, 3:21:56 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-04-14 15:21:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208768
;

-- Apr 14, 2025, 5:01:12 PM CEST
UPDATE AD_Column SET Callout='org.idempiere.model.CalloutRequiredPlugin.validate',Updated=TO_TIMESTAMP('2025-04-14 17:01:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217110
;

-- Apr 14, 2025, 5:01:28 PM CEST
UPDATE AD_Column SET Callout='org.idempiere.model.CalloutRequiredPlugin.validate',Updated=TO_TIMESTAMP('2025-04-14 17:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217109
;

-- Apr 14, 2025, 5:10:44 PM CEST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2025-04-14 17:10:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217109
;

-- Apr 14, 2025, 5:10:45 PM CEST
INSERT INTO t_alter_column values('ad_requiredplugin','PluginName','VARCHAR(1000)',null,null)
;

-- Apr 14, 2025, 5:10:45 PM CEST
INSERT INTO t_alter_column values('ad_requiredplugin','PluginName',null,'NOT NULL',null)
;

-- Apr 14, 2025, 5:14:38 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','This plugin does not exist in this server, saving this record is dangerous as potentially the server cannot be started next time',0,0,'Y',TO_TIMESTAMP('2025-04-14 17:14:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 17:14:38','YYYY-MM-DD HH24:MI:SS'),100,200942,'RequiredPluginDoesNotExist','D','ca638393-c2f6-40bc-a640-197e8a20b2cf')
;

-- Apr 14, 2025, 5:16:06 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The plugin exists, but is in a different state, saving this record is dangerous as potentially the server cannot be started next time',0,0,'Y',TO_TIMESTAMP('2025-04-14 17:16:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-04-14 17:16:05','YYYY-MM-DD HH24:MI:SS'),100,200943,'RequiredPluginInDifferentState','D','79bc2732-c3ff-42b7-b101-cc9cd995a38e')
;

