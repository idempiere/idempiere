-- IDEMPIERE-7156
SELECT register_migration_script('202610091200_IDEMPIERE-7156.sql') FROM dual;

-- May 12, 2025, 2:59:04 PM CEST
UPDATE AD_Column SET FieldLength=2,Updated=TO_TIMESTAMP('2025-05-12 14:59:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215695
;

-- May 12, 2025, 2:59:09 PM CEST
INSERT INTO t_alter_column values('ad_process_para','DateRangeOption','VARCHAR(2)',null,'D')
;

-- May 12, 2025, 2:58:31 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (800225,'Range Picker - Shortcuts - with Text editor',200228,'ST',0,0,'Y',TO_TIMESTAMP('2025-05-12 14:58:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-12 14:58:31','YYYY-MM-DD HH24:MI:SS'),100,'D','817931f1-5f50-5e51-bcc3-6a300dadc08c')
;

-- May 12, 2025, 3:54:34 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (800226,'Shortcuts',200217,'10',0,0,'Y',TO_TIMESTAMP('2025-05-12 15:54:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-12 15:54:33','YYYY-MM-DD HH24:MI:SS'),100,'D','e57de8c0-f460-56ec-8856-1fc1f6e71c53')
;

-- May 12, 2025, 4:24:23 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (800101,'Date Range Shortcuts',NULL,'L',0,0,'Y',TO_TIMESTAMP('2025-05-12 16:24:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-12 16:24:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','5a6264ae-f96f-5208-8bc0-efcdb5854328','N')
;

-- May 13, 2025, 9:43:57 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions,IsPartition,CreatePartition) VALUES (800173,'Date Range','AD_DateRange',0,'6',0,0,'Y',TO_TIMESTAMP('2025-05-13 09:43:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:43:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','c9b39c1c-8874-5737-91bc-a4066ec65d81','N','N','N','N','N','N','N')
;

-- May 13, 2025, 9:46:04 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802964,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',800173,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','ff1bc68b-d054-5347-873f-a38ab8e6e37c','N')
;

-- May 13, 2025, 9:46:04 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802965,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',800173,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','b2287042-bdd2-53b2-9bc6-ea7b56dde2d9','N')
;

-- May 13, 2025, 9:46:04 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802966,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',800173,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','6378ea5c-c474-5718-a03c-d49a3acc778e','N')
;

-- May 13, 2025, 9:46:04 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802967,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',800173,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','9b18621f-1869-508e-8ca4-18e8434e83a4','N')
;

-- May 13, 2025, 9:46:04 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802968,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',800173,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','542be3c2-3ec8-5b0e-ac4a-a2d68a24697e','N')
;

-- May 13, 2025, 9:46:05 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802969,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',800173,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:04','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','ae570f61-0124-5f6d-8072-2d14f151699f','N')
;

-- May 13, 2025, 9:46:05 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802970,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',800173,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','661c2a7b-61ed-5091-94d1-7e0700e155a9','N')
;

-- May 13, 2025, 9:46:05 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (800581,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,'AD_DateRange_ID','Date Range',NULL,'Date Range','D','8e1ad044-866c-5c50-a764-58a1b740fe54')
;

-- May 13, 2025, 9:46:05 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802971,0.0,'Date Range',800173,'AD_DateRange_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,800581,'N','N','D','N','3c3780fe-b83d-50e4-a19a-677e6006d916','N')
;

-- May 13, 2025, 9:46:05 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (800582,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,'AD_DateRange_UU','AD_DateRange_UU','AD_DateRange_UU','D','1f0bd425-30fd-5af2-9480-bad20181346f')
;

-- May 13, 2025, 9:46:05 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802972,0.0,'AD_DateRange_UU',800173,'AD_DateRange_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,800582,'Y','N','D','N','bb271fa6-715a-5754-bd81-a8938b7aa95b','N')
;

-- May 13, 2025, 9:46:06 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (802973,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',800173,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:05','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','c95f57ce-73af-5fc4-949b-6eb8f938de32',10,'N')
;

-- May 13, 2025, 9:46:06 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802974,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',800173,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 09:46:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 09:46:06','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','N','D','N','d291ca63-0e94-530f-98d8-b987ceb44306','N')
;

-- May 13, 2025, 10:06:29 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (800583,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:06:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:06:29','YYYY-MM-DD HH24:MI:SS'),100,'RangeType','Range Type','Type of the date range, e.g. relative or absolute','Range Type','D','e60e1d36-ca15-5604-8073-3842c47d1f66')
;

-- May 13, 2025, 10:08:18 AM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (800102,'RangeType','Date range type','L',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:08:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:08:18','YYYY-MM-DD HH24:MI:SS'),100,'D','N','a4bb7f9d-0276-56e4-8d37-aeed54a23cdc','N')
;

-- May 13, 2025, 10:09:23 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (800227,'Absolute','Absolute date range',800102,'A',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:09:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:09:23','YYYY-MM-DD HH24:MI:SS'),100,'D','14d21f02-104d-5832-8654-71e024e593a3')
;

-- May 13, 2025, 10:12:03 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (800228,'Relative','Relative date range',800102,'R',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:12:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:12:03','YYYY-MM-DD HH24:MI:SS'),100,'D','d01f138e-c489-5b19-b322-337764a19521')
;

-- May 13, 2025, 10:13:27 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (802975,0,'Range Type','Type of the date range, e.g. relative or absolute',800173,'RangeType',NULL,1,'N','N','Y','N','N',0,'N',17,800102,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:13:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:13:27','YYYY-MM-DD HH24:MI:SS'),100,800583,'Y','N','D','N','N','N','Y','1384654a-6f35-5b63-ac33-8ab8d27dacb2','Y',0,'N','N','N','N')
;

-- May 13, 2025, 10:18:46 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (802976,0,'Time Unit','The unit of time for grouping chart data.',800173,'TimeUnit',1,'N','N','N','N','N',0,'N',17,53376,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:18:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:18:46','YYYY-MM-DD HH24:MI:SS'),100,54319,'Y','N','D','N','N','@RangeType@ = R','N','Y','cfe3fdfb-cf50-5f35-80c7-d7a81df5410d','Y',0,'N','N','N','N','N')
;

-- May 13, 2025, 10:19:52 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (802977,0,'Time Scope','The number of time units to include the chart result.',800173,'TimeScope',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:19:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:19:52','YYYY-MM-DD HH24:MI:SS'),100,54318,'Y','N','D','N','N','@RangeType@ = R','N','Y','11b86fc0-3b1a-5b94-abf0-533fe8c809d5','Y',0,'N','N','N','N')
;

-- May 13, 2025, 10:21:14 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (802978,0,'Date From','Starting date for a range','The Date From indicates the starting date of a range.',800173,'DateFrom',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:21:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:21:14','YYYY-MM-DD HH24:MI:SS'),100,1581,'Y','N','D','N','N','@RangeType@ = A','N','Y','b323d80e-f510-570e-ad49-3542ce204127','Y',0,'N','N','N','N','N')
;

-- May 13, 2025, 10:21:45 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (802979,0,'Date To','End date of a date range','The Date To indicates the end date of a range (inclusive)',800173,'DateTo',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:21:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:21:45','YYYY-MM-DD HH24:MI:SS'),100,1582,'Y','N','D','N','N','@RangeType@ = A','N','Y','66694ecf-143e-5acb-87f1-f1662ce5967c','Y',0,'N','N','N','N','N')
;

-- May 13, 2025, 10:30:25 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADDateRange', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:30:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802964
;

-- May 13, 2025, 10:30:25 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADDateRange', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:30:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802965
;

-- May 13, 2025, 10:30:25 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADDateRange', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:30:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802967
;

-- May 13, 2025, 10:30:25 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADDateRange', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:30:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802969
;

-- May 13, 2025, 10:30:25 AM CEST
CREATE TABLE AD_DateRange (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_DateRange_ID NUMERIC(10) NOT NULL, AD_DateRange_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, DateFrom TIMESTAMP DEFAULT NULL , DateTo TIMESTAMP DEFAULT NULL , Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, RangeType CHAR(1) NOT NULL, TimeScope NUMERIC(10) DEFAULT NULL , TimeUnit CHAR(1) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, AD_DateRangeGroup_ID NUMERIC(10) DEFAULT NULL, RangeComparisonType VARCHAR(2) DEFAULT 'S' NOT NULL, TimeOffset NUMERIC(10) DEFAULT '0', SeqNo NUMERIC(10) DEFAULT NULL, CONSTRAINT AD_DateRange_Key PRIMARY KEY (AD_DateRange_ID), CONSTRAINT AD_DateRange_UU_idx UNIQUE (AD_DateRange_UU))
;

-- May 13, 2025, 10:30:25 AM CEST
ALTER TABLE AD_DateRange ADD CONSTRAINT ADClient_ADDateRange FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:30:25 AM CEST
ALTER TABLE AD_DateRange ADD CONSTRAINT ADOrg_ADDateRange FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:30:25 AM CEST
ALTER TABLE AD_DateRange ADD CONSTRAINT CreatedBy_ADDateRange FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:30:25 AM CEST
ALTER TABLE AD_DateRange ADD CONSTRAINT UpdatedBy_ADDateRange FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:34:12 AM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (800062,'Date Range',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:12','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','N','N','N','f417cc00-5ca8-5f44-a502-0c220a00d6cf')
;

-- May 13, 2025, 10:34:12 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (800182,'Date Range',800062,10,'Y',800173,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','AD_DateRange.Name','N',0,'N','D','Y','N','edacbc58-0d92-5870-922b-60a17c79d391')
;

-- May 13, 2025, 10:34:12 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802446,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',800182,802964,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:12','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','8dee4287-5130-540c-a637-168176a9fd27','Y',10,2)
;

-- May 13, 2025, 10:34:13 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (802447,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',800182,802965,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b720711f-b20c-535d-bd82-6d6be859c639','Y','N',4,2)
;

-- May 13, 2025, 10:34:13 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802448,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',800182,802973,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7d611616-5c7d-594e-9874-eaf195d75b01','Y',20,5)
;

-- May 13, 2025, 10:34:13 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802449,'Description','Optional short description of the record','A description is limited to 255 characters.',800182,802974,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bed03910-ecbd-53a1-950e-828dc412324f','Y',30,5)
;

-- May 13, 2025, 10:34:13 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (802450,'Date Range',800182,802971,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','86a8ebe3-4531-598f-9f4e-31aabbb66e55','N',2)
;

-- May 13, 2025, 10:34:13 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (802451,'AD_DateRange_UU',800182,802972,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bfb35800-4f8e-5c05-a47d-0c480992061e','N',2)
;

-- May 13, 2025, 10:34:14 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802452,'Range Type','Type of the date range, e.g. relative or absolute',800182,802975,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8f017082-a8c7-5c13-8cf4-ddc8ec4a0cb9','Y',40,2)
;

-- May 13, 2025, 10:34:14 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802453,'Time Unit','The unit of time for grouping chart data.',800182,802976,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f1ff6dac-817b-5f63-9313-e4209ef41a35','Y',50,2)
;

-- May 13, 2025, 10:34:14 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802454,'Time Scope','The number of time units to include the chart result.',800182,802977,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','26c88ce9-b732-5755-bf6c-c9ca50d4bd8b','Y',60,2)
;

-- May 13, 2025, 10:34:14 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802455,'Date From','Starting date for a range','The Date From indicates the starting date of a range.',800182,802978,'Y',7,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','52ee5359-2f90-5dbf-8de2-df269f0bd254','Y',70,2)
;

-- May 13, 2025, 10:34:15 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802456,'Date To','End date of a date range','The Date To indicates the end date of a range (inclusive)',800182,802979,'Y',7,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','296eeffc-dd3f-5fbb-a3be-e6a7603cbfda','Y',80,2)
;

-- May 13, 2025, 10:34:15 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (802457,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',800182,802970,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3f4ba6f1-d3c1-5e8a-b7bc-19202f8c0370','Y',90,2,2)
;

-- May 13, 2025, 10:34:15 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (800114,'Date Range','W',800062,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:34:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:34:15','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','d7ecba67-a68b-5417-983c-5cae94bb66c0')
;

-- May 13, 2025, 10:34:15 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 800114, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=800114)
;

-- May 13, 2025, 10:34:15 AM CEST
UPDATE AD_Table SET AD_Window_ID=800062,Updated=TO_TIMESTAMP('2025-05-13 10:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=800173
;

-- May 13, 2025, 10:36:18 AM CEST
UPDATE AD_Field SET Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.', IsDisplayed='Y', SeqNo=60, XPosition=5, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802457
;

-- May 13, 2025, 10:36:18 AM CEST
UPDATE AD_Field SET Name='Time Unit', Description='The unit of time for grouping chart data.', Help=NULL, DisplayLogic='@RangeType@=R', SeqNo=70, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802453
;

-- May 13, 2025, 10:36:18 AM CEST
UPDATE AD_Field SET Name='Time Scope', Description='The number of time units to include the chart result.', Help=NULL, IsDisplayed='Y', DisplayLogic='@RangeType@=R', SeqNo=80, XPosition=4, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802454
;

-- May 13, 2025, 10:36:18 AM CEST
UPDATE AD_Field SET Name='Date From', Description='Starting date for a range', Help='The Date From indicates the starting date of a range.', DisplayLogic='@RangeType@=A', SeqNo=90, ColumnSpan=2, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802455
;

-- May 13, 2025, 10:36:18 AM CEST
UPDATE AD_Field SET Name='Date To', Description='End date of a date range', Help='The Date To indicates the end date of a range (inclusive)', IsDisplayed='Y', DisplayLogic='@RangeType@=A', SeqNo=100, XPosition=4, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802456
;

-- May 13, 2025, 10:36:18 AM CEST
UPDATE AD_Field SET Name='AD_DateRange_UU', Description=NULL, Help=NULL, SeqNo=0, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802451
;

-- May 13, 2025, 10:36:18 AM CEST
UPDATE AD_Field SET Name='Date Range', Description=NULL, Help=NULL, SeqNo=0, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802450
;

-- May 13, 2025, 10:37:10 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions,IsPartition,CreatePartition) VALUES (800174,'Date Range Group','Group of date ranges','AD_DateRangeGroup',0,'6',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','0135de75-c8f8-58a4-b260-5b5ed320291b','N','N','N','N','N','N','N')
;

-- May 13, 2025, 10:37:11 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_DateRangeGroup',1000000,'N','N','Table AD_DateRangeGroup','Y','Y',0,0,TO_TIMESTAMP('2025-05-13 10:37:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:10','YYYY-MM-DD HH24:MI:SS'),100,800224,'Y',1000000,1,200002,'0f091087-4b08-583e-ab05-099427fd04bd')
;

-- May 13, 2025, 10:37:11 AM CEST
CREATE SEQUENCE AD_DATERANGEGROUP_SQ INCREMENT 1 MINVALUE 1000000 MAXVALUE 2147483647 START 1000000
;

-- May 13, 2025, 10:37:11 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_DateRange',1000000,'N','N','Table AD_DateRange','Y','Y',0,0,TO_TIMESTAMP('2025-05-13 10:37:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:10','YYYY-MM-DD HH24:MI:SS'),100,800227,'Y',1000000,1,200015,'0e49b37b-b0c3-5c2b-96a1-1cb708fffb7c')
;

-- May 13, 2025, 10:37:11 AM CEST
CREATE SEQUENCE AD_DATERANGE_SQ INCREMENT 1 MINVALUE 1000000 MAXVALUE 2147483647 START 1000000
;

-- May 13, 2025, 10:37:37 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802980,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',800174,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:36','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','27e2f2e3-5073-53e4-9c82-6d8d57af1f0a','N')
;

-- May 13, 2025, 10:37:37 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802981,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',800174,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','b27a8c5b-2327-5ad6-ab4c-84ac13d9a4f2','N')
;

-- May 13, 2025, 10:37:37 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802982,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',800174,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','5b0601f9-846d-5c38-ba15-4df0fd6c2f60','N')
;

-- May 13, 2025, 10:37:37 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802983,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',800174,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','708936c6-0702-5a38-9103-10adf6a1e5ff','N')
;

-- May 13, 2025, 10:37:37 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802984,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',800174,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','daa46dd0-a431-590f-bfb0-de9b2283eecd','N')
;

-- May 13, 2025, 10:37:37 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802985,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',800174,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','a7611f61-e55d-5db4-8216-720ef0a94397','N')
;

-- May 13, 2025, 10:37:37 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802986,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',800174,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','1ffe535c-f7c2-55b6-b916-0722a837fd16','N')
;

-- May 13, 2025, 10:37:38 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (800584,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:37','YYYY-MM-DD HH24:MI:SS'),100,'AD_DateRangeGroup_ID','Date Range Group','Group of date ranges','Date Range Group','D','31724c4c-85e3-5eea-83dd-b82a137ac627')
;

-- May 13, 2025, 10:37:38 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802987,0.0,'Date Range Group','Group of date ranges',800174,'AD_DateRangeGroup_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:38','YYYY-MM-DD HH24:MI:SS'),100,800584,'N','N','D','N','8098bce2-9624-5930-9b12-323c195b6eb9','N')
;

-- May 13, 2025, 10:37:38 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (800585,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:38','YYYY-MM-DD HH24:MI:SS'),100,'AD_DateRangeGroup_UU','AD_DateRangeGroup_UU','AD_DateRangeGroup_UU','D','bb8d0aaf-87bd-5ee4-9fa1-dd6887a251d5')
;

-- May 13, 2025, 10:37:38 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802988,0.0,'AD_DateRangeGroup_UU',800174,'AD_DateRangeGroup_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:38','YYYY-MM-DD HH24:MI:SS'),100,800585,'Y','N','D','N','838cffde-19ba-5c7a-9335-13b57fa6e0c6','N')
;

-- May 13, 2025, 10:37:38 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (802989,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',800174,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:38','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','54f95a15-8193-52e5-a9cf-58bbb8a06563',10,'N')
;

-- May 13, 2025, 10:37:38 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802990,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',800174,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:37:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:37:38','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','N','D','N','2c6d29e8-2aad-571b-89fa-45f06e81e010','N')
;

-- May 13, 2025, 10:38:42 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADDateRangeGroup', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:38:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802980
;

-- May 13, 2025, 10:38:42 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADDateRangeGroup', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:38:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802981
;

-- May 13, 2025, 10:38:42 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADDateRangeGroup', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:38:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802983
;

-- May 13, 2025, 10:38:42 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADDateRangeGroup', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:38:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802985
;

-- May 13, 2025, 10:38:42 AM CEST
CREATE TABLE AD_DateRangeGroup (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_DateRangeGroup_ID NUMERIC(10) NOT NULL, AD_DateRangeGroup_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_DateRangeGroup_Key PRIMARY KEY (AD_DateRangeGroup_ID), CONSTRAINT AD_DateRangeGroup_UU_idx UNIQUE (AD_DateRangeGroup_UU))
;

-- May 13, 2025, 10:38:42 AM CEST
ALTER TABLE AD_DateRangeGroup ADD CONSTRAINT ADClient_ADDateRangeGroup FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:38:42 AM CEST
ALTER TABLE AD_DateRangeGroup ADD CONSTRAINT ADOrg_ADDateRangeGroup FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:38:42 AM CEST
ALTER TABLE AD_DateRangeGroup ADD CONSTRAINT CreatedBy_ADDateRangeGroup FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:38:42 AM CEST
ALTER TABLE AD_DateRangeGroup ADD CONSTRAINT UpdatedBy_ADDateRangeGroup FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:39:39 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (802991,0,'Date Range Group','Group of date ranges',800173,'AD_DateRangeGroup_ID',22,'N','Y','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:39:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:39:39','YYYY-MM-DD HH24:MI:SS'),100,800584,'N','N','D','N','N','N','Y','c9da834e-8d31-5575-8fcb-3254705104f6','Y',0,'N','N','N','N','N')
;

-- May 13, 2025, 10:39:41 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADDateRangeGroup_ADDateRange', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:39:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802991
;

-- May 13, 2025, 10:39:41 AM CEST
ALTER TABLE AD_DateRange ADD CONSTRAINT ADDateRangeGroup_ADDateRange FOREIGN KEY (AD_DateRangeGroup_ID) REFERENCES ad_daterangegroup(ad_daterangegroup_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:49:18 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802458,'Date Range Group','Group of date ranges',800182,802991,'Y',22,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:49:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:49:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e4c98a80-cfe0-5e72-bc17-c678f6141a63','Y',100,2)
;

-- May 13, 2025, 10:49:45 AM CEST
UPDATE AD_Field SET Name='Date Range Group', Description='Group of date ranges', Help=NULL, IsDisplayed='Y', SeqNo=30, XPosition=1, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:49:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802458
;

-- May 13, 2025, 10:49:45 AM CEST
UPDATE AD_Field SET Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.', IsDisplayed='Y', SeqNo=40, XPosition=5, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:49:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802457
;

-- May 13, 2025, 10:49:45 AM CEST
UPDATE AD_Field SET Name='Name', Description='Alphanumeric identifier of the entity', Help='The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.', SeqNo=50, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:49:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802448
;

-- May 13, 2025, 10:49:45 AM CEST
UPDATE AD_Field SET Name='Description', Description='Optional short description of the record', Help='A description is limited to 255 characters.', SeqNo=60, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:49:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802449
;

-- May 13, 2025, 10:49:45 AM CEST
UPDATE AD_Field SET Name='Range Type', Description='Type of the date range, e.g. relative or absolute', Help=NULL, SeqNo=70, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:49:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802452
;

-- May 13, 2025, 10:49:45 AM CEST
UPDATE AD_Field SET Name='Time Unit', Description='The unit of time for grouping chart data.', Help=NULL, SeqNo=80, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:49:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802453
;

-- May 13, 2025, 10:49:45 AM CEST
UPDATE AD_Field SET Name='Time Scope', Description='The number of time units to include the chart result.', Help=NULL, SeqNo=90, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:49:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802454
;

-- May 13, 2025, 10:49:45 AM CEST
UPDATE AD_Field SET Name='Date From', Description='Starting date for a range', Help='The Date From indicates the starting date of a range.', SeqNo=100, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:49:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802455
;

-- May 13, 2025, 10:49:45 AM CEST
UPDATE AD_Field SET Name='Date To', Description='End date of a date range', Help='The Date To indicates the end date of a range (inclusive)', SeqNo=110, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:49:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802456
;

-- May 13, 2025, 10:51:16 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (800175,'Date Range Group Trl','Group of date ranges Trl','AD_DateRangeGroup_Trl','6',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:15','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','D','Y','L','96ac3c6a-3ca6-5adf-99a5-7b2cd74fcf60','N')
;

-- May 13, 2025, 10:51:16 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_DateRangeGroup_Trl',1000000,'N','N','Table AD_DateRangeGroup_Trl','Y','Y',0,0,TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,800225,'Y',1000000,1,200000,'a8c2e822-4c92-55ce-bf0d-e2648f895e7c')
;

-- May 13, 2025, 10:51:16 AM CEST
CREATE SEQUENCE AD_DATERANGEGROUP_TRL_SQ INCREMENT 1 MINVALUE 1000000 MAXVALUE 2147483647 START 1000000
;

-- May 13, 2025, 10:51:16 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802992,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',800175,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','aca39e3f-66d3-5f6d-84b9-57d94f7400a4','N')
;

-- May 13, 2025, 10:51:16 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802993,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',800175,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','ea91aed6-9bc0-56b2-a535-4b2279873912','N')
;

-- May 13, 2025, 10:51:16 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802994,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',800175,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','ebe6ec28-d6d4-501c-8086-1c3c6887bb45','N')
;

-- May 13, 2025, 10:51:16 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802995,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',800175,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','04990f1a-419d-56fa-bfb1-89058ae8088e','N')
;

-- May 13, 2025, 10:51:16 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802996,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',800175,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:16','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','2da9ef78-a0cb-5a3e-bebf-5a068d7fe363','N')
;

-- May 13, 2025, 10:51:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802997,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',800175,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','7b2a00c2-46e7-5e91-919a-221a0b82e79c','N')
;

-- May 13, 2025, 10:51:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (802998,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',800175,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','d89f47cd-593d-59f1-a370-04a6eec3ae94','N')
;

-- May 13, 2025, 10:51:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (802999,0.0,'Date Range Group','Group of date ranges',800175,'AD_DateRangeGroup_ID',10,'N','Y','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,800584,'N','N','D','N','78f168f1-f192-50a8-a440-3a054a0cc5fd','N','C')
;

-- May 13, 2025, 10:51:17 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (800586,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,'AD_DateRangeGroup_Trl_UU','AD_DateRangeGroup_Trl_UU','AD_DateRangeGroup_Trl_UU','D','b672a929-3081-57e4-adbc-5e5c2d118291')
;

-- May 13, 2025, 10:51:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803000,0.0,'AD_DateRangeGroup_Trl_UU',800175,'AD_DateRangeGroup_Trl_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,800586,'Y','N','D','N','51269192-37e2-56dc-a7d8-9f60c5205e01','N')
;

-- May 13, 2025, 10:51:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803001,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',800175,'AD_Language',6,'N','Y','Y','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','ea7466f8-d805-57c5-95b1-3cc92d087d0f','N')
;

-- May 13, 2025, 10:51:18 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803002,0.0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',800175,'IsTranslated','N',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,420,'Y','N','D','N','69c87906-810d-5dbb-af9c-8ba891db3d7e','N')
;

-- May 13, 2025, 10:51:18 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,800026,'96e8c7d1-32ef-578c-8dad-eaf80affda64',TO_TIMESTAMP('2025-05-13 10:51:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_DateRangeGroup_Trl_pkey',TO_TIMESTAMP('2025-05-13 10:51:18','YYYY-MM-DD HH24:MI:SS'),100,800175,'Y','Y','N','Y')
;

-- May 13, 2025, 10:51:18 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,800050,'616bfe89-7964-5c73-a790-069309736c80',TO_TIMESTAMP('2025-05-13 10:51:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-05-13 10:51:18','YYYY-MM-DD HH24:MI:SS'),100,803001,800026,1)
;

-- May 13, 2025, 10:51:18 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,800051,'cb786072-7e41-54da-b06c-7ecb2d283f2a',TO_TIMESTAMP('2025-05-13 10:51:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-05-13 10:51:18','YYYY-MM-DD HH24:MI:SS'),100,802999,800026,2)
;

-- May 13, 2025, 10:51:43 AM CEST
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2025-05-13 10:51:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802989
;

-- May 13, 2025, 10:52:44 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (803003,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',800175,'Name',60,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:52:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:52:44','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','32da5615-d79d-5aff-bf7f-a99f45999a8b','Y',10,'N','N','N','N')
;

-- May 13, 2025, 10:52:45 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADDateRangeGroupTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:52:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802992
;

-- May 13, 2025, 10:52:45 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADLanguage_ADDateRangeGroupTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:52:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=803001
;

-- May 13, 2025, 10:52:46 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADDateRangeGroupTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:52:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802993
;

-- May 13, 2025, 10:52:46 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADDateRangeGroup_ADDateRangeGrou', FKConstraintType='C',Updated=TO_TIMESTAMP('2025-05-13 10:52:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802999
;

-- May 13, 2025, 10:52:46 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADDateRangeGroupTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:52:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802995
;

-- May 13, 2025, 10:52:46 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADDateRangeGroupTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:52:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802997
;

-- May 13, 2025, 10:52:46 AM CEST
CREATE TABLE AD_DateRangeGroup_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_DateRangeGroup_ID NUMERIC(10) NOT NULL, AD_DateRangeGroup_Trl_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL, CONSTRAINT AD_DateRangeGroup_Trl_UU_idx UNIQUE (AD_DateRangeGroup_Trl_UU))
;

-- May 13, 2025, 10:52:46 AM CEST
ALTER TABLE AD_DateRangeGroup_Trl ADD CONSTRAINT ADClient_ADDateRangeGroupTrl FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:52:46 AM CEST
ALTER TABLE AD_DateRangeGroup_Trl ADD CONSTRAINT ADLanguage_ADDateRangeGroupTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:52:46 AM CEST
ALTER TABLE AD_DateRangeGroup_Trl ADD CONSTRAINT ADOrg_ADDateRangeGroupTrl FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:52:46 AM CEST
ALTER TABLE AD_DateRangeGroup_Trl ADD CONSTRAINT ADDateRangeGroup_ADDateRangeGrou FOREIGN KEY (AD_DateRangeGroup_ID) REFERENCES ad_daterangegroup(ad_daterangegroup_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:52:46 AM CEST
ALTER TABLE AD_DateRangeGroup_Trl ADD CONSTRAINT CreatedBy_ADDateRangeGroupTrl FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:52:46 AM CEST
ALTER TABLE AD_DateRangeGroup_Trl ADD CONSTRAINT UpdatedBy_ADDateRangeGroupTrl FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:52:58 AM CEST
ALTER TABLE AD_DateRangeGroup_Trl ADD CONSTRAINT AD_DateRangeGroup_Trl_pkey PRIMARY KEY (AD_Language,AD_DateRangeGroup_ID)
;

-- May 13, 2025, 10:53:20 AM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (800063,'Date Range Group',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:53:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:53:20','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','N','N','N','c7a0becf-f1ff-57c7-9c42-144f280effab')
;

-- May 13, 2025, 10:53:21 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (800183,'Date Range Group',800063,10,'Y',800174,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:53:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:53:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','AD_DateRangeGroup.Name','N',0,'N','D','Y','N','83c37140-ac18-50fe-9c64-319bec5c65db')
;

-- May 13, 2025, 10:53:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802459,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',800183,802980,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','73069a64-e6d9-5cfb-9106-07b04d684585','Y',10,2)
;

-- May 13, 2025, 10:53:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (802460,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',800183,802981,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a8cfb7b6-1f64-52f8-9668-1ca86aa0590e','Y','N',4,2)
;

-- May 13, 2025, 10:53:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802461,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',800183,802989,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8e62afa9-f8b0-5f6e-8add-292e40b49034','Y',20,5)
;

-- May 13, 2025, 10:53:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802462,'Description','Optional short description of the record','A description is limited to 255 characters.',800183,802990,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','36727deb-525d-55d3-9537-b6ef56732cda','Y',30,5)
;

-- May 13, 2025, 10:53:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (802463,'Date Range Group','Group of date ranges',800183,802987,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fdea4e73-3d22-5e5c-bd4e-54d1b699eecf','N',2)
;

-- May 13, 2025, 10:53:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (802464,'AD_DateRangeGroup_UU',800183,802988,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','080afb26-ec7d-54c9-b3b9-d25736c15483','N',2)
;

-- May 13, 2025, 10:53:22 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (802465,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',800183,802986,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:53:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5b552d35-8ef0-595d-890e-5c871fa812ce','Y',40,2,2)
;

-- May 13, 2025, 10:53:22 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (800115,'Date Range Group','W',800063,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:53:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:53:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','286013ef-5678-53e9-b9ed-d25428a645b0')
;

-- May 13, 2025, 10:53:22 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 800115, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=800115)
;

-- May 13, 2025, 10:53:22 AM CEST
UPDATE AD_Table SET AD_Window_ID=800063,Updated=TO_TIMESTAMP('2025-05-13 10:53:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=800174
;

-- May 13, 2025, 10:55:11 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (800184,'Date Range Group Trl',800063,20,'Y',800175,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','AD_DateRangeGroup_Trl.AD_Language','N',1,'N','D','N','N','1aad6f4e-061a-5d43-b0ce-1f5f70656226')
;

-- May 13, 2025, 10:55:11 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802466,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',800184,802992,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','aed5a873-9e37-5729-96e1-e150d168b73a','Y',10,2)
;

-- May 13, 2025, 10:55:11 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (802467,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',800184,802993,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e88a9630-e37e-53e8-9ff5-0bda5fad76db','Y','N',4,2)
;

-- May 13, 2025, 10:55:11 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802468,'Language','Language for this entity','The Language identifies the language to use for display and formatting',800184,803001,'Y',6,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6046c942-332b-52cc-94ce-6e1c56b7aac5','Y',20,2)
;

-- May 13, 2025, 10:55:12 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802469,'Date Range Group','Group of date ranges',800184,802999,'Y',10,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','db7a81d8-f65c-5877-bc7c-f9e79728f2cb','Y',30,2)
;

-- May 13, 2025, 10:55:12 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802470,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',800184,803003,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:55:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:55:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d0824784-d065-566f-800f-282b3877781d','Y',40,5)
;

-- May 13, 2025, 10:55:12 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (802471,'AD_DateRangeGroup_Trl_UU',800184,803000,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:55:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:55:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eee14535-d121-5605-bcd5-a54f5340a10b','N',2)
;

-- May 13, 2025, 10:55:12 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (802472,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',800184,803002,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:55:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:55:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','82fca384-5c3c-5b4f-84fc-51d938faf027','Y',50,2,2)
;

-- May 13, 2025, 10:55:12 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (802473,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',800184,802998,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:55:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:55:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8e7a2142-7a4b-54d8-9e8a-d3994109a212','Y',60,2,2)
;

-- May 13, 2025, 10:55:12 AM CEST
UPDATE AD_Table SET AD_Window_ID=800063,Updated=TO_TIMESTAMP('2025-05-13 10:55:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=800175
;

-- May 13, 2025, 10:55:50 AM CEST
UPDATE AD_Field SET Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.', IsDisplayed='Y', SeqNo=40, XPosition=5, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:55:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802473
;

-- May 13, 2025, 10:55:50 AM CEST
UPDATE AD_Field SET Name='Date Range Group', Description='Group of date ranges', Help=NULL, SeqNo=50, IsReadOnly='Y', Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:55:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802469
;

-- May 13, 2025, 10:55:50 AM CEST
UPDATE AD_Field SET Name='Translated', Description='This column is translated', Help='The Translated checkbox indicates if this column is translated.', IsDisplayed='Y', SeqNo=60, XPosition=5, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:55:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802472
;

-- May 13, 2025, 10:55:50 AM CEST
UPDATE AD_Field SET Name='Name', Description='Alphanumeric identifier of the entity', Help='The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.', SeqNo=70, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:55:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802470
;

-- May 13, 2025, 10:55:50 AM CEST
UPDATE AD_Field SET Name='AD_DateRangeGroup_Trl_UU', Description=NULL, Help=NULL, SeqNo=0, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:55:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802471
;

-- May 13, 2025, 10:56:32 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (800176,'Date Range Trl','AD_DateRange_Trl','6',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','D','Y','L','ea681530-d13a-5d13-9c7b-1b4c6e53b20e','N')
;

-- May 13, 2025, 10:56:32 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_DateRange_Trl',1000000,'N','N','Table AD_DateRange_Trl','Y','Y',0,0,TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,800226,'Y',1000000,1,200000,'8900aa52-bb9d-5edc-86b4-5bd7c3b6f98f')
;

-- May 13, 2025, 10:56:32 AM CEST
CREATE SEQUENCE AD_DATERANGE_TRL_SQ INCREMENT 1 MINVALUE 1000000 MAXVALUE 2147483647 START 1000000
;

-- May 13, 2025, 10:56:32 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803004,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',800176,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','22cd5d0a-7db2-5412-882f-507772230b64','N')
;

-- May 13, 2025, 10:56:32 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803005,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',800176,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','78a7bc34-a774-5f8d-8a48-ab9d8fce9f16','N')
;

-- May 13, 2025, 10:56:32 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803006,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',800176,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','d4e61a87-c6a0-521f-ada8-e6c724d982fd','N')
;

-- May 13, 2025, 10:56:33 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803007,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',800176,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:32','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','4c0dacc5-2b1a-5187-8ab9-3ca545814511','N')
;

-- May 13, 2025, 10:56:33 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803008,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',800176,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','3158a9d8-401a-5b21-abbd-eb2b15049754','N')
;

-- May 13, 2025, 10:56:33 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803009,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',800176,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','ec97c61c-b321-5bf7-8d17-ac041732d698','N')
;

-- May 13, 2025, 10:56:33 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803010,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',800176,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','f20d22fd-5e00-5323-8038-d4c55108e63e','N')
;

-- May 13, 2025, 10:56:33 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (803011,0.0,'Date Range',800176,'AD_DateRange_ID',10,'N','Y','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,800581,'N','N','D','N','8688bf17-c068-5b0f-9066-37fb222c8e2f','N','C')
;

-- May 13, 2025, 10:56:34 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (800587,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:33','YYYY-MM-DD HH24:MI:SS'),100,'AD_DateRange_Trl_UU','AD_DateRange_Trl_UU','AD_DateRange_Trl_UU','D','c544c509-974e-53ee-a72c-004bd7d5c25c')
;

-- May 13, 2025, 10:56:34 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803012,0.0,'AD_DateRange_Trl_UU',800176,'AD_DateRange_Trl_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,800587,'Y','N','D','N','3391da04-7290-5334-90eb-c217a1b5eab5','N')
;

-- May 13, 2025, 10:56:34 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803013,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',800176,'AD_Language',6,'N','Y','Y','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','836a01b7-b8c3-58c8-93c5-461ea98bac7f','N')
;

-- May 13, 2025, 10:56:34 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (803014,0.0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',800176,'IsTranslated','N',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,420,'Y','N','D','N','2592625b-25c5-5932-abcc-eb498b6ec25f','N')
;

-- May 13, 2025, 10:56:34 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,800027,'76551858-d7ee-5e03-8915-2681e9c0e032',TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_DateRange_Trl_pkey',TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,800176,'Y','Y','N','Y')
;

-- May 13, 2025, 10:56:34 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,800052,'e652dee5-7fca-5e7c-8ed2-bbd410106f82',TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,803013,800027,1)
;

-- May 13, 2025, 10:56:34 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,800053,'43e6a587-2793-5519-b164-483ee5e3e3e8',TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-05-13 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,803011,800027,2)
;

-- May 13, 2025, 10:57:06 AM CEST
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2025-05-13 10:57:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802973
;

-- May 13, 2025, 10:57:15 AM CEST
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2025-05-13 10:57:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802974
;

-- May 13, 2025, 10:57:38 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (803015,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',800176,'Name',60,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:57:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:57:37','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','3cbfabf3-f4ea-59a9-9e39-aca10c0b16c6','Y',10,'N','N','N','N')
;

-- May 13, 2025, 10:57:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (803016,0,'Description','Optional short description of the record','A description is limited to 255 characters.',800176,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:57:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:57:57','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','N','N','Y','219b8418-1755-5d1a-a2ff-f017e22e3ccf','Y',20,'N','N','N','N')
;

-- May 13, 2025, 10:58:00 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADDateRangeTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:58:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=803004
;

-- May 13, 2025, 10:58:00 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADLanguage_ADDateRangeTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:58:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=803013
;

-- May 13, 2025, 10:58:00 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADDateRangeTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:58:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=803005
;

-- May 13, 2025, 10:58:00 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADDateRange_ADDateRangeTrl', FKConstraintType='C',Updated=TO_TIMESTAMP('2025-05-13 10:58:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=803011
;

-- May 13, 2025, 10:58:00 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADDateRangeTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:58:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=803007
;

-- May 13, 2025, 10:58:00 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADDateRangeTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-05-13 10:58:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=803009
;

-- May 13, 2025, 10:58:00 AM CEST
CREATE TABLE AD_DateRange_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_DateRange_ID NUMERIC(10) NOT NULL, AD_DateRange_Trl_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_DateRange_Trl_UU_idx UNIQUE (AD_DateRange_Trl_UU))
;

-- May 13, 2025, 10:58:00 AM CEST
ALTER TABLE AD_DateRange_Trl ADD CONSTRAINT ADClient_ADDateRangeTrl FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:58:00 AM CEST
ALTER TABLE AD_DateRange_Trl ADD CONSTRAINT ADLanguage_ADDateRangeTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:58:00 AM CEST
ALTER TABLE AD_DateRange_Trl ADD CONSTRAINT ADOrg_ADDateRangeTrl FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:58:00 AM CEST
ALTER TABLE AD_DateRange_Trl ADD CONSTRAINT ADDateRange_ADDateRangeTrl FOREIGN KEY (AD_DateRange_ID) REFERENCES ad_daterange(ad_daterange_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:58:00 AM CEST
ALTER TABLE AD_DateRange_Trl ADD CONSTRAINT CreatedBy_ADDateRangeTrl FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:58:00 AM CEST
ALTER TABLE AD_DateRange_Trl ADD CONSTRAINT UpdatedBy_ADDateRangeTrl FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 13, 2025, 10:58:29 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (800185,'Date Range Trl',800062,20,'Y',800176,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:58:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:58:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','AD_DateRange_Trl.AD_Language','N',1,'N','D','N','N','bcef58a6-ce08-5256-91f7-8e1cc936a121')
;

-- May 13, 2025, 10:58:29 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802474,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',800185,803004,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:58:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:58:29','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','52e75ea0-ef8a-5467-aa40-d80b24ccb2da','Y',10,2)
;

-- May 13, 2025, 10:58:30 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (802475,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',800185,803005,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:58:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:58:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2b02e334-8a53-5bb5-b90b-ce459b5ef41c','Y','N',4,2)
;

-- May 13, 2025, 10:58:30 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802476,'Date Range',800185,803011,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4dd646ba-1cb2-5599-b0bb-cff43448e39d','Y',20,2)
;

-- May 13, 2025, 10:58:30 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802477,'Language','Language for this entity','The Language identifies the language to use for display and formatting',800185,803013,'Y',6,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','54ab11d4-a007-5a5a-8172-c9a4b9ef3ae5','Y',30,2)
;

-- May 13, 2025, 10:58:30 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802478,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',800185,803015,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','adc97d07-35a3-52bc-9b9e-c85c9ee2fae2','Y',40,5)
;

-- May 13, 2025, 10:58:30 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802479,'Description','Optional short description of the record','A description is limited to 255 characters.',800185,803016,'Y',255,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9b10a3cf-d5a5-58f0-b850-86444cf3c40f','Y',50,5)
;

-- May 13, 2025, 10:58:30 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (802480,'AD_DateRange_Trl_UU',800185,803012,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d075eed7-9e77-56df-90c0-933c04479088','N',2)
;

-- May 13, 2025, 10:58:30 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (802481,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',800185,803014,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c8c7f127-563d-5578-afab-0e52fb02dfb0','Y',60,2,2)
;

-- May 13, 2025, 10:58:31 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (802482,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',800185,803010,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a236c5dd-c189-5ed9-a5fa-a6c19b3c84b6','Y',70,2,2)
;

-- May 13, 2025, 10:58:31 AM CEST
UPDATE AD_Table SET AD_Window_ID=800062,Updated=TO_TIMESTAMP('2025-05-13 10:58:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=800176
;

-- May 13, 2025, 10:58:45 AM CEST
UPDATE AD_Field SET Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.', IsDisplayed='Y', SeqNo=40, XPosition=5, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:58:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802482
;

-- May 13, 2025, 10:58:45 AM CEST
UPDATE AD_Field SET Name='Language', Description='Language for this entity', Help='The Language identifies the language to use for display and formatting', SeqNo=50, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:58:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802477
;

-- May 13, 2025, 10:58:45 AM CEST
UPDATE AD_Field SET Name='Translated', Description='This column is translated', Help='The Translated checkbox indicates if this column is translated.', IsDisplayed='Y', SeqNo=60, XPosition=5, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:58:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802481
;

-- May 13, 2025, 10:58:45 AM CEST
UPDATE AD_Field SET Name='Name', Description='Alphanumeric identifier of the entity', Help='The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.', SeqNo=70, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:58:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802478
;

-- May 13, 2025, 10:58:45 AM CEST
UPDATE AD_Field SET Name='Description', Description='Optional short description of the record', Help='A description is limited to 255 characters.', SeqNo=80, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:58:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802479
;

-- May 13, 2025, 10:58:45 AM CEST
UPDATE AD_Field SET Name='AD_DateRange_Trl_UU', Description=NULL, Help=NULL, SeqNo=0, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 10:58:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802480
;

-- May 13, 2025, 10:59:00 AM CEST
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2025-05-13 10:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802990
;

-- May 13, 2025, 10:59:10 AM CEST
ALTER TABLE AD_DateRange_Trl ADD CONSTRAINT AD_DateRange_Trl_pkey PRIMARY KEY (AD_Language,AD_DateRange_ID)
;

-- May 13, 2025, 10:59:32 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (803017,0,'Description','Optional short description of the record','A description is limited to 255 characters.',800175,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-05-13 10:59:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:59:32','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','N','N','Y','a7e21dda-27af-52a6-a094-92e2045e2ce7','Y',20,'N','N','N','N')
;

-- May 13, 2025, 10:59:55 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802483,'Description','Optional short description of the record','A description is limited to 255 characters.',800184,803017,'Y',255,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 10:59:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 10:59:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d63d3ac9-b4b3-5f04-9510-b500c85b4062','Y',70,5)
;

-- May 13, 2025, 11:11:06 AM CEST
DELETE FROM AD_Reference WHERE AD_Reference_UU='5a6264ae-f96f-5208-8bc0-efcdb5854328'
;

-- May 13, 2025, 4:12:35 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (800588,0,0,'Y',TO_TIMESTAMP('2025-05-13 16:12:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 16:12:35','YYYY-MM-DD HH24:MI:SS'),100,'RangeComparisonType','Range Comparison Type','Comparison type of the date range, e.g. comparision or standard range.','Range Comparison Type','D','1a45f4a8-561c-546a-9974-9b11f5ba6ccc')
;

-- May 13, 2025, 4:13:14 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (800103,'RangeComparisonType','L',0,0,'Y',TO_TIMESTAMP('2025-05-13 16:13:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 16:13:14','YYYY-MM-DD HH24:MI:SS'),100,'D','N','8b7ebf89-13d8-5544-85c4-fd83f9571302','N')
;

-- May 13, 2025, 4:13:41 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (800229,'Standard Range',800103,'S',0,0,'Y',TO_TIMESTAMP('2025-05-13 16:13:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 16:13:40','YYYY-MM-DD HH24:MI:SS'),100,'D','0723cf46-47cc-5414-8cc7-df452a829c85')
;

-- May 13, 2025, 4:13:53 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (800230,'Comparison Range',800103,'C',0,0,'Y',TO_TIMESTAMP('2025-05-13 16:13:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 16:13:53','YYYY-MM-DD HH24:MI:SS'),100,'D','88e53531-bf33-505a-a1f7-f5c5dd6ce7e5')
;

-- May 13, 2025, 4:14:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (803018,0,'Range Comparison Type','Comparison type of the date range, e.g. comparision or standard range.',800173,'RangeComparisonType','S',1,'N','N','Y','N','N',0,'N',17,800103,0,0,'Y',TO_TIMESTAMP('2025-05-13 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,800588,'Y','N','D','N','N','N','Y','cb3bb573-6ee1-5332-b39b-8491a1be4c5a','Y',0,'N','N','N','N')
;

-- May 13, 2025, 4:15:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (803019,0,'Time Offset','Number of time units to offset displayed chart data from the current date.','For example an offset of -12 with a chart time unit of Month will result in previous year data being displayed.',800173,'TimeOffset','0',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2025-05-13 16:15:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 16:15:11','YYYY-MM-DD HH24:MI:SS'),100,54320,'Y','N','D','N','N','N','Y','50c2b99f-c0d9-53ee-99c4-28b01a5e11b7','Y',0,'N','N','N','N','N')
;

-- May 13, 2025, 4:15:39 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802484,'Range Comparison Type','Comparison type of the date range, e.g. comparision or standard range.',800182,803018,'Y',1,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 16:15:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 16:15:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f87fc110-a7c2-5beb-942c-edf26a294bab','Y',110,2)
;

-- May 13, 2025, 4:15:40 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802485,'Time Offset','Number of time units to offset displayed chart data from the current date.','For example an offset of -12 with a chart time unit of Month will result in previous year data being displayed.',800182,803019,'Y',10,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-13 16:15:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-13 16:15:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f41ef327-3b6f-5447-8fe9-48c5134e55af','Y',120,2)
;

-- May 13, 2025, 4:16:23 PM CEST
UPDATE AD_Field SET Name='Range Comparison Type', Description='Comparison type of the date range, e.g. comparision or standard range.', Help=NULL, IsDisplayed='Y', SeqNo=80, XPosition=4, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 16:16:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802484
;

-- May 13, 2025, 4:16:23 PM CEST
UPDATE AD_Field SET Name='Time Unit', Description='The unit of time for grouping chart data.', Help=NULL, SeqNo=90, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 16:16:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802453
;

-- May 13, 2025, 4:16:23 PM CEST
UPDATE AD_Field SET Name='Time Scope', Description='The number of time units to include the chart result.', Help=NULL, SeqNo=100, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 16:16:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802454
;

-- May 13, 2025, 4:16:23 PM CEST
UPDATE AD_Field SET Name='Time Offset', Description='Number of time units to offset displayed chart data from the current date.', Help='For example an offset of -12 with a chart time unit of Month will result in previous year data being displayed.', IsDisplayed='Y', DisplayLogic='@RangeType@=R', SeqNo=110, XPosition=1, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 16:16:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802485
;

-- May 13, 2025, 4:16:23 PM CEST
UPDATE AD_Field SET Name='Date From', Description='Starting date for a range', Help='The Date From indicates the starting date of a range.', SeqNo=120, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 16:16:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802455
;

-- May 13, 2025, 4:16:23 PM CEST
UPDATE AD_Field SET Name='Date To', Description='End date of a date range', Help='The Date To indicates the end date of a range (inclusive)', SeqNo=130, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-13 16:16:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802456
;

-- May 13, 2025, 4:16:50 PM CEST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2025-05-13 16:16:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802991
;

-- May 13, 2025, 4:17:08 PM CEST
UPDATE AD_Column SET MandatoryLogic='@RangeType@ = R',Updated=TO_TIMESTAMP('2025-05-13 16:17:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=803019
;

-- May 14, 2025, 8:46:30 AM CEST
UPDATE AD_Element SET ColumnName='RangeComparisonType', Name='Range Comparison Type', Description='Comparison type of the date range, e.g. comparison or standard range.', PrintName='Range Comparison Type',Updated=TO_TIMESTAMP('2025-05-14 08:46:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=800588
;

-- May 14, 2025, 8:46:30 AM CEST
UPDATE AD_Column SET ColumnName='RangeComparisonType', Name='Range Comparison Type', Description='Comparison type of the date range, e.g. comparison or standard range.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=800588
;

-- May 14, 2025, 8:46:30 AM CEST
UPDATE AD_Process_Para SET ColumnName='RangeComparisonType', Name='Range Comparison Type', Description='Comparison type of the date range, e.g. comparison or standard range.', Help=NULL, AD_Element_ID=800588 WHERE UPPER(ColumnName)='RANGECOMPARISONTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- May 14, 2025, 8:46:30 AM CEST
UPDATE AD_Process_Para SET ColumnName='RangeComparisonType', Name='Range Comparison Type', Description='Comparison type of the date range, e.g. comparison or standard range.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=800588 AND IsCentrallyMaintained='Y'
;

-- May 14, 2025, 8:46:30 AM CEST
UPDATE AD_InfoColumn SET ColumnName='RangeComparisonType', Name='Range Comparison Type', Description='Comparison type of the date range, e.g. comparison or standard range.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=800588 AND IsCentrallyMaintained='Y'
;

-- May 14, 2025, 8:46:30 AM CEST
UPDATE AD_Field SET Name='Range Comparison Type', Description='Comparison type of the date range, e.g. comparison or standard range.', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=800588) AND IsCentrallyMaintained='Y'
;

-- May 14, 2025, 8:46:30 AM CEST
UPDATE AD_PrintFormatItem SET PrintName='Range Comparison Type', Name='Range Comparison Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=800588)
;

-- May 14, 2025, 12:03:44 PM CEST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2025-05-14 12:03:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802991
;

-- May 14, 2025, 12:05:51 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (803021,0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',800173,'SeqNo','@SQL=SELECT COALESCE(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_DateRange WHERE AD_DateRangeGroup_ID=@AD_DateRangeGroup_ID@',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2025-05-14 12:05:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:05:51','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','N','N','Y','3e9ce25e-7707-50df-aaa2-4f2732b7d4e5','Y',0,'N','N','N','N','N')
;

-- May 14, 2025, 12:06:11 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802487,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',800182,803021,'Y',10,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:06:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:06:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dae66ccf-8822-5517-8070-304c0138f5b9','Y',130,2)
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Sequence', Description='Method of ordering records; lowest number comes first', Help='The Sequence indicates the order of records', IsDisplayed='Y', SeqNo=40, XPosition=4, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802487
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.', SeqNo=50, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802457
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Name', Description='Alphanumeric identifier of the entity', Help='The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.', SeqNo=60, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802448
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Description', Description='Optional short description of the record', Help='A description is limited to 255 characters.', SeqNo=70, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802449
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Range Type', Description='Type of the date range, e.g. relative or absolute', Help=NULL, SeqNo=80, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802452
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Range Comparison Type', Description='Comparison type of the date range, e.g. comparison or standard range.', Help=NULL, SeqNo=90, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802484
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Time Unit', Description='The unit of time for grouping chart data.', Help=NULL, SeqNo=100, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802453
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Time Scope', Description='The number of time units to include the chart result.', Help=NULL, SeqNo=110, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802454
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Time Offset', Description='Number of time units to offset displayed chart data from the current date.', Help='For example an offset of -12 with a chart time unit of Month will result in previous year data being displayed.', SeqNo=120, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802485
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Date From', Description='Starting date for a range', Help='The Date From indicates the starting date of a range.', SeqNo=130, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802455
;

-- May 14, 2025, 12:06:31 PM CEST
UPDATE AD_Field SET Name='Date To', Description='End date of a date range', Help='The Date To indicates the end date of a range (inclusive)', SeqNo=140, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802456
;

-- May 14, 2025, 12:06:56 PM CEST
UPDATE AD_Tab SET OrderByClause='AD_DateRange.SeqNo',Updated=TO_TIMESTAMP('2025-05-14 12:06:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=800182
;

-- May 14, 2025, 12:08:23 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (800186,'Date Range',800063,30,'Y',800173,0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','AD_DateRange.Name','N',1,'N','D','Y','N','94cde323-2be2-5403-8e10-04c8366331dd')
;

-- May 14, 2025, 12:08:23 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802488,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',800186,802964,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','ab806992-32cf-5067-9264-8e778501eb12','Y',10,2)
;

-- May 14, 2025, 12:08:23 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (802489,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',800186,802965,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5f4f9e9e-cfc2-59af-9512-845a4ded4ee1','Y','N',4,2)
;

-- May 14, 2025, 12:08:23 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802490,'Date Range Group','Group of date ranges',800186,802991,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','75a8a0bf-b7b8-5a8a-b8da-f8ae9fe408d1','Y',20,2)
;

-- May 14, 2025, 12:08:23 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802491,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',800186,802973,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3633be12-996c-509f-b85c-9e56df71e28b','Y',30,5)
;

-- May 14, 2025, 12:08:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802492,'Description','Optional short description of the record','A description is limited to 255 characters.',800186,802974,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','544fd80a-b118-58fb-86ba-77cd6ff402ca','Y',40,5)
;

-- May 14, 2025, 12:08:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (802493,'Date Range',800186,802971,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','07666941-d533-5025-8194-c51819f1db59','N',2)
;

-- May 14, 2025, 12:08:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (802494,'AD_DateRange_UU',800186,802972,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8b9a7d26-70a9-59c9-9fb7-728fed6e78db','N',2)
;

-- May 14, 2025, 12:08:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802495,'Range Type','Type of the date range, e.g. relative or absolute',800186,802975,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','30601a32-416d-5751-ab4b-79d4a1cb0fe4','Y',50,2)
;

-- May 14, 2025, 12:08:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802496,'Time Unit','The unit of time for grouping chart data.',800186,802976,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2fb72aa6-ea3f-56f7-9091-98a4156b8085','Y',60,2)
;

-- May 14, 2025, 12:08:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802497,'Time Scope','The number of time units to include the chart result.',800186,802977,'Y',10,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0db23116-73a7-5825-800c-8458df79af1f','Y',70,2)
;

-- May 14, 2025, 12:08:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802498,'Date From','Starting date for a range','The Date From indicates the starting date of a range.',800186,802978,'Y',7,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','994c4550-7c66-5553-80a7-cdec0fb4a807','Y',80,2)
;

-- May 14, 2025, 12:08:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802499,'Date To','End date of a date range','The Date To indicates the end date of a range (inclusive)',800186,802979,'Y',7,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f398fcd2-2e3d-54ca-8987-ff164bd15cf7','Y',90,2)
;

-- May 14, 2025, 12:08:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802500,'Range Comparison Type','Comparison type of the date range, e.g. comparison or standard range.',800186,803018,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f9083b3c-6aab-564b-abba-e21c88072bf2','Y',100,2)
;

-- May 14, 2025, 12:08:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802501,'Time Offset','Number of time units to offset displayed chart data from the current date.','For example an offset of -12 with a chart time unit of Month will result in previous year data being displayed.',800186,803019,'Y',10,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','350b421b-30a4-5482-8f2b-295f12353baa','Y',110,2)
;

-- May 14, 2025, 12:08:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (802502,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',800186,803021,'Y',10,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5fd96882-8350-5a76-a5eb-fc09018a53be','Y',120,2)
;

-- May 14, 2025, 12:08:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (802503,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',800186,802970,'Y',1,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-14 12:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-14 12:08:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','09fbaa16-33d2-541e-9c01-c33ebe71ff06','Y',130,2,2)
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Sequence', Description='Method of ordering records; lowest number comes first', Help='The Sequence indicates the order of records', IsDisplayed='Y', SeqNo=40, XPosition=4, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802502
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Active', Description='The record is active in the system', Help='There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.', IsDisplayed='Y', SeqNo=50, XPosition=5, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802503
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Name', Description='Alphanumeric identifier of the entity', Help='The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.', SeqNo=60, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802491
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Description', Description='Optional short description of the record', Help='A description is limited to 255 characters.', SeqNo=70, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802492
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Range Type', Description='Type of the date range, e.g. relative or absolute', Help=NULL, SeqNo=80, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802495
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Range Comparison Type', Description='Comparison type of the date range, e.g. comparison or standard range.', Help=NULL, IsDisplayed='Y', SeqNo=90, XPosition=4, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802500
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Time Unit', Description='The unit of time for grouping chart data.', Help=NULL, SeqNo=100, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802496
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Time Scope', Description='The number of time units to include the chart result.', Help=NULL, IsDisplayed='Y', SeqNo=110, XPosition=4, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802497
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Date From', Description='Starting date for a range', Help='The Date From indicates the starting date of a range.', SeqNo=130, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802498
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Date To', Description='End date of a date range', Help='The Date To indicates the end date of a range (inclusive)', IsDisplayed='Y', SeqNo=140, XPosition=4, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802499
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='AD_DateRange_UU', Description=NULL, Help=NULL, SeqNo=0, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802494
;

-- May 14, 2025, 12:09:39 PM CEST
UPDATE AD_Field SET Name='Date Range', Description=NULL, Help=NULL, SeqNo=0, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802493
;

-- May 14, 2025, 12:11:01 PM CEST
UPDATE AD_Field SET Name='Time Unit', Description='The unit of time for grouping chart data.', Help=NULL, DisplayLogic='@RangeType@=R', SeqNo=100, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:11:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802496
;

-- May 14, 2025, 12:11:01 PM CEST
UPDATE AD_Field SET Name='Time Scope', Description='The number of time units to include the chart result.', Help=NULL, DisplayLogic='@RangeType@=R', SeqNo=110, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:11:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802497
;

-- May 14, 2025, 12:11:01 PM CEST
UPDATE AD_Field SET Name='Time Offset', Description='Number of time units to offset displayed chart data from the current date.', Help='For example an offset of -12 with a chart time unit of Month will result in previous year data being displayed.', DisplayLogic='@RangeType@=R', SeqNo=120, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:11:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802501
;

-- May 14, 2025, 12:11:01 PM CEST
UPDATE AD_Field SET Name='Date From', Description='Starting date for a range', Help='The Date From indicates the starting date of a range.', DisplayLogic='@RangeType@=A', SeqNo=130, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:11:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802498
;

-- May 14, 2025, 12:11:01 PM CEST
UPDATE AD_Field SET Name='Date To', Description='End date of a date range', Help='The Date To indicates the end date of a range (inclusive)', DisplayLogic='@RangeType@=A', SeqNo=140, ColumnSpan=3, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:11:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802499
;

-- May 14, 2025, 12:11:23 PM CEST
UPDATE AD_Tab SET OrderByClause='AD_DateRange.SeqNo',Updated=TO_TIMESTAMP('2025-05-14 12:11:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=800186
;

-- May 14, 2025, 12:14:31 PM CEST
UPDATE AD_Column SET MandatoryLogic=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:14:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802976
;

-- May 14, 2025, 12:14:37 PM CEST
UPDATE AD_Column SET MandatoryLogic=NULL,Updated=TO_TIMESTAMP('2025-05-14 12:14:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=802977
;

-- May 28, 2025, 11:47:49 AM CEST
UPDATE AD_Ref_List SET Name='Presets',Updated=TO_TIMESTAMP('2025-05-28 11:47:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=800226
;

-- May 28, 2025, 11:48:29 AM CEST
UPDATE AD_Ref_List SET Name='Range Picker - Presets - with Text editor',Updated=TO_TIMESTAMP('2025-05-28 11:48:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=800225
;

-- Jun 2, 2025, 10:03:04 AM CEST
UPDATE AD_Ref_List SET Name='Comparison Range',Updated=TO_TIMESTAMP('2025-06-02 10:03:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=800230
;

-- Jun 3, 2025, 8:48:23 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (800233,'Standard and Comparison Range',800103,'SC',0,0,'Y',TO_TIMESTAMP('2025-06-03 08:48:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-03 08:48:23','YYYY-MM-DD HH24:MI:SS'),100,'D','6fd44576-7934-584b-817a-6f2c6a2c703e')
;

-- Jun 3, 2025, 9:00:47 AM CEST
UPDATE AD_Column SET FieldLength=2,Updated=TO_TIMESTAMP('2025-06-03 09:00:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=803018
;

-- Jul 1, 2025, 10:22:17 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (800244,'Comparison Range - Previous Period with Offset','Returns the previous period relative to the main date range, which is offseted. E.g. if main range is "This Month", then previous period with offset 1 year means "same Month in previous year".',800103,'PO',0,0,'Y',TO_TIMESTAMP('2025-07-01 10:22:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-01 10:22:17','YYYY-MM-DD HH24:MI:SS'),100,'D','202b797f-0fa6-5e03-a677-eec01c5f08ac')
;

-- Jul 1, 2025, 10:27:11 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (800245,'Previous Period','Returns the previous period relative to the main date range. E.g. if main range is "This Month", then previous period means "Previous Month".',800102,'P',0,0,'Y',TO_TIMESTAMP('2025-07-01 10:27:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-01 10:27:11','YYYY-MM-DD HH24:MI:SS'),100,'D','7c9fd033-7211-556c-a97d-73f6362c0782')
;

-- Jul 1, 2025, 10:27:33 AM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (800246,'Previous Period with Offset','Returns the previous period relative to the main date range, which is offseted. E.g. if main range is "This Month", then previous period with offset 1 year means "same Month in previous year".',800102,'O',0,0,'Y',TO_TIMESTAMP('2025-07-01 10:27:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-01 10:27:33','YYYY-MM-DD HH24:MI:SS'),100,'D','18f7ed86-9163-5ee8-81eb-281d591613b0')
;

-- Jul 1, 2025, 10:27:43 AM CEST
DELETE FROM AD_Ref_List WHERE AD_Ref_List_UU='202b797f-0fa6-5e03-a677-eec01c5f08ac'
;

-- Jul 1, 2025, 10:29:02 AM CEST
UPDATE AD_Field SET Name='Time Unit', Description='The unit of time for grouping chart data.', Help=NULL, DisplayLogic='@RangeType@=R | @RangeType@=O', SeqNo=100, ColumnSpan=2, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-07-01 10:29:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802453
;

-- Jul 1, 2025, 10:29:02 AM CEST
UPDATE AD_Field SET Name='Time Offset', Description='Number of time units to offset displayed chart data from the current date.', Help='For example an offset of -12 with a chart time unit of Month will result in previous year data being displayed.', DisplayLogic='@RangeType@=R | @RangeType@=O', SeqNo=120, Placeholder=NULL,Updated=TO_TIMESTAMP('2025-07-01 10:29:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802485
;

-- Jul 1, 2025, 10:38:10 AM CEST
UPDATE AD_Field SET Name='Range Comparison Type', Description='Comparison type of the date range, e.g. comparison or standard range.', Help=NULL, SeqNo=90, ReadOnlyLogic='@RangeType@=P | @RangeType@=O', Placeholder=NULL,Updated=TO_TIMESTAMP('2025-07-01 10:38:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802484
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRangeGroup (AD_Client_ID,AD_Org_ID,AD_DateRangeGroup_ID,AD_DateRangeGroup_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,Description) VALUES (0,0,200000,'d4a379fa-9be9-5f1d-8fa2-ef5ac7f586d9',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Rolling Periods','Periods that end today')
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRangeGroup (AD_Client_ID,AD_Org_ID,AD_DateRangeGroup_ID,AD_DateRangeGroup_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,Description) VALUES (0,0,200001,'1b2a36a0-982e-508d-b827-dd7f3242203a',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Past Years','Previous calendar years')
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200000,'9a3b3cf9-3b25-5099-8426-839dfab39596',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Today',10,'R','S','D',0,1,NULL)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200001,'25cfd067-7b50-588b-b9c5-49350b8609b6',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Yesterday',20,'R','S','D',-1,1,NULL)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200002,'2126ffea-68de-50bb-a45d-aa0ac1292742',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','This Week',30,'R','S','W',0,1,NULL)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200003,'822bd647-67a2-5397-a80a-8e144e543f89',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Last Week',40,'R','S','W',-1,1,NULL)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200004,'fe6030e8-962c-5043-8c7c-a520270ee2f4',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','This Month',50,'R','S','M',0,1,NULL)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200005,'2c642227-88b6-5fc0-ae93-bd7e76b12b4b',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Last Month',60,'R','S','M',-1,1,NULL)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200006,'679887fe-f225-5466-a637-4a618f4d1675',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','This Quarter',70,'R','S','Q',0,1,NULL)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200007,'612bad5d-2d97-5fdd-93d0-a92c74034f58',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Last Quarter',80,'R','S','Q',-1,1,NULL)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200008,'aeb6eeef-d3ca-53cf-9abb-bf47dd672cdc',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','This Year',90,'R','S','Y',0,1,NULL)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200009,'520d46d8-a0ed-5389-8fbb-a58c42e2594b',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Last Year',100,'R','S','Y',-1,1,NULL)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200010,'497b609f-9397-5854-934c-97d5ab2a9e0b',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Last 7 Days',110,'R','S','D',-6,7,200000)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200011,'d8fecda6-6bf6-57ef-a30c-58a11e77d1a8',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Last 30 Days',120,'R','S','D',-29,30,200000)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200012,'0868c7d9-f216-5c33-ac36-0d73c87dc969',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Last 90 Days',130,'R','S','D',-89,90,200000)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200013,'183550dd-6ff9-5469-b316-d7716718b983',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Two Years Ago',140,'R','S','Y',-2,1,200001)
;

-- Oct 9, 2026, 12:00:00 PM CEST
INSERT INTO AD_DateRange (AD_Client_ID,AD_Org_ID,AD_DateRange_ID,AD_DateRange_UU,Created,CreatedBy,Updated,UpdatedBy,IsActive,Name,SeqNo,RangeType,RangeComparisonType,TimeUnit,TimeOffset,TimeScope,AD_DateRangeGroup_ID) VALUES (0,0,200014,'946130de-d822-584e-bb23-1a85ff9a84b1',TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Last 3 Years',150,'R','S','Y',-3,3,200001)
;
