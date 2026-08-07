-- IDEMPIERE-7060 -  Redesign "Forgot Password" flow: code-based reset via shared core service
SELECT register_migration_script('202607072011_IDEMPIERE-7060.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 7, 2026, 8:11:31 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions,IsPartition,CreatePartition) VALUES (200449,'Password Reset Token','AD_PasswordResetToken',0,'4',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:11:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:11:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','019f3dc7-2ed6-7832-b98c-8c438d15870d','N','N','N','N','N','N','N')
;

-- Jul 7, 2026, 8:11:31 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_PasswordResetToken',1000000,'N','N','Table AD_PasswordResetToken','Y','Y',0,0,TO_TIMESTAMP('2026-07-07 20:11:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:11:31','YYYY-MM-DD HH24:MI:SS'),100,200540,'Y',1000000,1,200000,'019f3dc7-2ff7-78d3-9fa6-df940a586d1b')
;

-- Jul 7, 2026, 8:12:25 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217636,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200449,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:24','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','019f3dc8-002e-7f2c-956e-cc631c11e620','N')
;

-- Jul 7, 2026, 8:12:25 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217637,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200449,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:25','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','019f3dc8-016c-700d-9a90-d96ba0893c21','N')
;

-- Jul 7, 2026, 8:12:25 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217638,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200449,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:25','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','019f3dc8-027f-7753-bb79-b0262af01fe2','N')
;

-- Jul 7, 2026, 8:12:26 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217639,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200449,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:25','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','019f3dc8-0387-79bf-ac12-26c42b30b439','N')
;

-- Jul 7, 2026, 8:12:26 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217640,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200449,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:26','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','019f3dc8-0488-7d39-b8f8-f81a1e4a4c31','N')
;

-- Jul 7, 2026, 8:12:26 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217641,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200449,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:26','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','019f3dc8-0589-71b3-abc0-c74e921abf27','N')
;

-- Jul 7, 2026, 8:12:26 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217642,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200449,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:26','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','019f3dc8-0697-78d6-bf3c-96cef155403b','N')
;

-- Jul 7, 2026, 8:12:27 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204111,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:26','YYYY-MM-DD HH24:MI:SS'),100,'AD_PasswordResetToken_ID','Password Reset Token','Password Reset Token','D','019f3dc8-07a9-760f-a2df-9ea6430202e5')
;

-- Jul 7, 2026, 8:12:27 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217643,0.0,'Password Reset Token',200449,'AD_PasswordResetToken_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:27','YYYY-MM-DD HH24:MI:SS'),100,204111,'N','N','D','N','019f3dc8-08b9-7c2d-8571-df078b959ea3','N')
;

-- Jul 7, 2026, 8:12:27 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204112,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:27','YYYY-MM-DD HH24:MI:SS'),100,'AD_PasswordResetToken_UU','AD_PasswordResetToken_UU','AD_PasswordResetToken_UU','D','019f3dc8-09b0-7b61-b816-52c8613dac4c')
;

-- Jul 7, 2026, 8:12:27 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217644,0.0,'AD_PasswordResetToken_UU',200449,'AD_PasswordResetToken_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:12:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:12:27','YYYY-MM-DD HH24:MI:SS'),100,204112,'Y','N','D','N','019f3dc8-0abf-7d94-b02e-4d80218feeea','N')
;

-- Jul 7, 2026, 8:12:28 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201325,'019f3dc8-0bbf-7371-b94a-ac78d00a4a29',TO_TIMESTAMP('2026-07-07 20:12:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PasswordResetToken_UU_idx',TO_TIMESTAMP('2026-07-07 20:12:27','YYYY-MM-DD HH24:MI:SS'),100,200449,'Y','Y','N','N')
;

-- Jul 7, 2026, 8:12:28 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201832,'019f3dc8-0ccd-7ce1-9447-25718f4604d3',TO_TIMESTAMP('2026-07-07 20:12:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-07-07 20:12:28','YYYY-MM-DD HH24:MI:SS'),100,217644,201325,10)
;

-- Jul 7, 2026, 8:13:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217645,0,'EMail Address','Electronic Mail Address','The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.',200449,'EMail',60,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:13:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:13:15','YYYY-MM-DD HH24:MI:SS'),100,881,'Y','N','D','N','N','N','Y','019f3dc8-c47d-7127-9f65-26831ebf3778','Y',0,'N','N','N','N')
;

-- Jul 7, 2026, 8:13:53 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204113,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:13:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:13:34','YYYY-MM-DD HH24:MI:SS'),100,'OneTimeCode','One Time Code',NULL,NULL,'One Time Code','D','019f3dc9-59bb-7559-82d6-332055d91ccb')
;

-- Jul 7, 2026, 8:14:05 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217646,0,'One Time Code',200449,'OneTimeCode',10,'N','N','Y','N','N',0,'Y',10,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:14:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:14:04','YYYY-MM-DD HH24:MI:SS'),100,204113,'Y','N','D','N','N','N','N','019f3dc9-8685-7399-b8bb-86dcaf03c9c0','N',0,'N','Y','N','N')
;

-- Jul 7, 2026, 8:15:09 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204114,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:14:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:14:55','YYYY-MM-DD HH24:MI:SS'),100,'TokenStatus','Token Status',NULL,NULL,'Token Status','D','019f3dca-81d8-7a8a-ad10-560f0c4a472a')
;

-- Jul 7, 2026, 8:15:38 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200288,'AD_PasswordResetToken Status','L',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:15:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:15:38','YYYY-MM-DD HH24:MI:SS'),100,'D','N','019f3dca-f337-7c25-ae04-ea8ce4ca5112','N')
;

-- Jul 7, 2026, 8:15:46 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200773,'Pending',200288,'P',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:15:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:15:46','YYYY-MM-DD HH24:MI:SS'),100,'D','019f3dcb-1240-7db0-8e44-dd897bfe5811')
;

-- Jul 7, 2026, 8:15:53 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200774,'Verified',200288,'V',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:15:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:15:53','YYYY-MM-DD HH24:MI:SS'),100,'D','019f3dcb-2ec4-7149-bbca-e1ff150a7d0f')
;

-- Jul 7, 2026, 8:15:59 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200775,'Completed',200288,'C',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:15:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:15:59','YYYY-MM-DD HH24:MI:SS'),100,'D','019f3dcb-457e-7938-8fc6-b14a402deb37')
;

-- Jul 7, 2026, 8:16:10 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200776,'Expired',200288,'X',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:16:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:16:09','YYYY-MM-DD HH24:MI:SS'),100,'D','019f3dcb-6f2b-745f-93a5-091afa01ebbb')
;

-- Jul 7, 2026, 8:16:22 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200777,'Cancelled',200288,'N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:16:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:16:21','YYYY-MM-DD HH24:MI:SS'),100,'D','019f3dcb-9dba-7cda-9fc1-b91e44d8c395')
;

-- Jul 7, 2026, 8:16:44 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217647,0,'Token Status',200449,'TokenStatus','P',1,'N','N','Y','N','N',0,'N',17,200288,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:16:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:16:44','YYYY-MM-DD HH24:MI:SS'),100,204114,'Y','N','D','N','N','N','Y','019f3dcb-f45d-70cc-a25d-c0d438132701','Y',0,'N','N','N','N')
;

-- Jul 7, 2026, 8:17:04 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217648,0,'Expire On','Expire On',200449,'Expiration',29,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:17:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:17:03','YYYY-MM-DD HH24:MI:SS'),100,200245,'Y','N','D','N','N','N','Y','019f3dcc-4197-76d7-82e1-1a168077a095','Y',0,'N','N','N','N','N')
;

-- Jul 7, 2026, 8:17:22 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204115,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:17:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:17:12','YYYY-MM-DD HH24:MI:SS'),100,'AttemptsUsed','Attempts Used',NULL,NULL,'Attempts Used','D','019f3dcc-87e0-7038-97f4-13956b66fae1')
;

-- Jul 7, 2026, 8:17:38 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217649,0,'Attempts Used',200449,'AttemptsUsed','0',11,'N','N','Y','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:17:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:17:38','YYYY-MM-DD HH24:MI:SS'),100,204115,'Y','N','D','N','N','N','Y','019f3dcc-c6d4-72f5-8ef2-15008810ff0d','Y',0,'N','N','N','N')
;

-- Jul 7, 2026, 8:18:28 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204116,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:18:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:18:17','YYYY-MM-DD HH24:MI:SS'),100,'VerifiedTokenHash','Verified Token Hash',NULL,NULL,'Verified Token Hash','D','019f3dcd-8c6d-71a7-bb20-9862b67f1571')
;

-- Jul 7, 2026, 8:18:38 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217650,0,'Verified Token Hash',200449,'VerifiedTokenHash',10,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:18:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:18:38','YYYY-MM-DD HH24:MI:SS'),100,204116,'Y','N','D','N','N','N','Y','019f3dcd-b286-71ab-8288-9d930632d9d5','Y',0,'N','N','N','N')
;

-- Jul 7, 2026, 8:22:36 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204117,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:21:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:21:46','YYYY-MM-DD HH24:MI:SS'),100,'VerifiedTokenExpires','Verified Token Expires','Deadline to submit the new password after verifying','It must be short (recommended 5 minutes) because at that point the user is actively in the dialog.','Verified Token Expires','D','019f3dd1-53dd-7468-9538-e7d0f7050080')
;

-- Jul 7, 2026, 8:22:48 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217651,0,'Verified Token Expires','Deadline to submit the new password after verifying','It must be short (recommended 5 minutes) because at that point the user is actively in the dialog.',200449,'VerifiedTokenExpires',29,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:22:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:22:48','YYYY-MM-DD HH24:MI:SS'),100,204117,'Y','N','D','N','N','N','Y','019f3dd1-824a-7fc4-a327-45aa5b7be948','Y',0,'N','N','N','N')
;

-- Jul 7, 2026, 8:22:57 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADPasswordResetToken', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-07-07 20:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217636
;

-- Jul 7, 2026, 8:22:57 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADPasswordResetToken', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-07-07 20:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217637
;

-- Jul 7, 2026, 8:22:57 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADPasswordResetToken', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-07-07 20:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217639
;

-- Jul 7, 2026, 8:22:57 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADPasswordResetToken', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-07-07 20:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217641
;

-- Jul 7, 2026, 8:22:57 PM CEST
CREATE TABLE AD_PasswordResetToken (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_PasswordResetToken_ID NUMBER(10) NOT NULL, AD_PasswordResetToken_UU VARCHAR2/*UUID*/(36) DEFAULT NULL , AttemptsUsed NUMBER(10) DEFAULT 0 NOT NULL, OneTimeCode VARCHAR2(10 CHAR) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, EMail VARCHAR2(60 CHAR) NOT NULL, Expiration DATE NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, TokenStatus CHAR(1) DEFAULT 'P' NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, VerifiedTokenExpires DATE DEFAULT NULL , VerifiedTokenHash VARCHAR2(10 CHAR) DEFAULT NULL , CONSTRAINT AD_PasswordResetToken_Key PRIMARY KEY (AD_PasswordResetToken_ID), CONSTRAINT AD_PasswordResetToken_UU_idx UNIQUE (AD_PasswordResetToken_UU))
;

-- Jul 7, 2026, 8:22:57 PM CEST
ALTER TABLE AD_PasswordResetToken ADD CONSTRAINT ADClient_ADPasswordResetToken FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 7, 2026, 8:22:57 PM CEST
ALTER TABLE AD_PasswordResetToken ADD CONSTRAINT ADOrg_ADPasswordResetToken FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 7, 2026, 8:22:57 PM CEST
ALTER TABLE AD_PasswordResetToken ADD CONSTRAINT CreatedBy_ADPasswordResetToken FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 7, 2026, 8:22:57 PM CEST
ALTER TABLE AD_PasswordResetToken ADD CONSTRAINT UpdatedBy_ADPasswordResetToken FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 7, 2026, 8:23:13 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200165,'Password Reset Token',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:13','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','N','N','N','019f3dd1-e5be-7ee2-bd40-0adea693f1dc')
;

-- Jul 7, 2026, 8:23:14 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200428,'Password Reset Token',200165,10,'Y',200449,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:13','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','AD_PasswordResetToken.Created DESC','N',0,'N','D','Y','N','019f3dd1-e7c7-7308-8822-61307550b5e4')
;

-- Jul 7, 2026, 8:23:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209226,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200428,217636,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-e9f7-7bbe-8524-dd7e1b6f8f4a','N',2)
;

-- Jul 7, 2026, 8:23:15 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (209227,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200428,217637,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-eb0d-77bf-9f41-eeb07a59a34b','Y','N',4,2)
;

-- Jul 7, 2026, 8:23:15 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209228,'Password Reset Token',200428,217643,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-ecd9-7166-a0c1-816db4378b67','N',2)
;

-- Jul 7, 2026, 8:23:16 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209229,'AD_PasswordResetToken_UU',200428,217644,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-eea4-77f0-897b-e893a5991b64','N',2)
;

-- Jul 7, 2026, 8:23:16 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209230,'EMail Address','Electronic Mail Address','The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.',200428,217645,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-f071-798a-9c58-c88384e16bff','Y',10,5)
;

-- Jul 7, 2026, 8:23:17 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209231,'One Time Code',200428,217646,'Y',10,40,'N','N','N','Y',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-f23d-70f9-86eb-89bbbad1d330','Y',20,2)
;

-- Jul 7, 2026, 8:23:17 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209232,'Token Status',200428,217647,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-f408-708f-97dd-8c641b14d380','Y',30,2)
;

-- Jul 7, 2026, 8:23:17 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209233,'Expire On','Expire On',200428,217648,'Y',29,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-f5d5-75cb-929e-489aa5245176','Y',40,2)
;

-- Jul 7, 2026, 8:23:18 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209234,'Attempts Used',200428,217649,'Y',11,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-f7a0-7588-852c-04376d02905a','Y',50,2)
;

-- Jul 7, 2026, 8:23:18 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209235,'Verified Token Hash',200428,217650,'Y',10,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-f96c-74db-be10-53d95e96987f','Y',60,2)
;

-- Jul 7, 2026, 8:23:19 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209236,'Verified Token Expires','Deadline to submit the new password after verifying','It must be short (recommended 5 minutes) because at that point the user is actively in the dialog.',200428,217651,'Y',29,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-fb37-7a86-b517-34b1d5644f0d','Y',70,2)
;

-- Jul 7, 2026, 8:23:19 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209237,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200428,217642,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f3dd1-fd04-7274-b8d2-45ce99f977b3','Y',80,2,2)
;

-- Jul 7, 2026, 8:23:20 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200255,'Password Reset Token','W',200165,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:23:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:23:19','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','019f3dd1-fed0-7bae-a73c-8868e2a64061')
;

-- Jul 7, 2026, 8:23:20 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200255, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200255)
;

-- Jul 7, 2026, 8:23:20 PM CEST
UPDATE AD_Table SET AD_Window_ID=200165,Updated=TO_TIMESTAMP('2026-07-07 20:23:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200449
;

-- Jul 7, 2026, 8:24:24 PM CEST
UPDATE AD_Field SET SeqNo=30, IsReadOnly='Y',Updated=TO_TIMESTAMP('2026-07-07 20:24:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209230
;

-- Jul 7, 2026, 8:24:24 PM CEST
UPDATE AD_Field SET SeqNo=40, IsReadOnly='Y',Updated=TO_TIMESTAMP('2026-07-07 20:24:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209231
;

-- Jul 7, 2026, 8:24:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=4,Updated=TO_TIMESTAMP('2026-07-07 20:24:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209232
;

-- Jul 7, 2026, 8:24:24 PM CEST
UPDATE AD_Field SET SeqNo=60, IsReadOnly='Y',Updated=TO_TIMESTAMP('2026-07-07 20:24:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209233
;

-- Jul 7, 2026, 8:24:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, IsReadOnly='Y', XPosition=4,Updated=TO_TIMESTAMP('2026-07-07 20:24:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209234
;

-- Jul 7, 2026, 8:24:24 PM CEST
UPDATE AD_Field SET SeqNo=80, IsReadOnly='Y',Updated=TO_TIMESTAMP('2026-07-07 20:24:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209235
;

-- Jul 7, 2026, 8:24:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, IsReadOnly='Y', XPosition=4,Updated=TO_TIMESTAMP('2026-07-07 20:24:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209236
;

-- Jul 7, 2026, 8:24:24 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-07-07 20:24:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209229
;

-- Jul 7, 2026, 8:24:24 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-07-07 20:24:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209228
;

-- Jul 7, 2026, 8:25:00 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200316,0,0,TO_TIMESTAMP('2026-07-07 20:24:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-07-07 20:24:59','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','PASSWORD_RESET_CODE_EXPIRY_MINUTES','10',' code stays valid','D','S','019f3dd3-84be-7409-8cca-e2bb38f0eb10')
;

-- Jul 7, 2026, 8:25:12 PM CEST
UPDATE AD_SysConfig SET Description='Minutes a reset code stays valid',Updated=TO_TIMESTAMP('2026-07-07 20:25:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200316
;

-- Jul 7, 2026, 8:25:27 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200317,0,0,TO_TIMESTAMP('2026-07-07 20:25:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-07-07 20:25:27','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','PASSWORD_RESET_MAX_ATTEMPTS','5','Max wrong-code attempts before a code is locked','D','S','019f3dd3-f1ac-72aa-abf5-75e848ae6aa3')
;

-- Jul 7, 2026, 8:25:41 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200318,0,0,TO_TIMESTAMP('2026-07-07 20:25:41','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-07-07 20:25:41','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','PASSWORD_RESET_REQUEST_COOLDOWN_SECONDS','60','Min seconds between reset requests for one identifier','D','S','019f3dd4-2663-7b10-a221-f2a0e5b36741')
;

-- Jul 7, 2026, 8:25:56 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200319,0,0,TO_TIMESTAMP('2026-07-07 20:25:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-07-07 20:25:56','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','PASSWORD_RESET_MAX_REQUESTS_PER_HOUR','5','Max reset requests per identifier per hour','D','S','019f3dd4-61e7-7096-b2b8-0470f0af22a9')
;

-- Jul 7, 2026, 8:26:10 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200320,0,0,TO_TIMESTAMP('2026-07-07 20:26:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-07-07 20:26:09','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','PASSWORD_RESET_VERIFIED_TOKEN_EXPIRY_MINUTES','5','Minutes the post-verify token stays valid to set a new password','D','S','019f3dd4-96f9-7fe1-8e33-61b3e8b49769')
;

-- Jul 7, 2026, 8:27:16 PM CEST
INSERT INTO R_MailText (R_MailText_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsHtml,MailHeader,MailText,R_MailText_UU) VALUES (200002,0,0,'Y',TO_TIMESTAMP('2026-07-07 20:27:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:27:15','YYYY-MM-DD HH24:MI:SS'),100,'Password Reset Code','Y','Password Reset Code for iDempiere','<p>Hello @Name@,</p>
<p>Your password reset code is: <b>@#ResetCode@</b></p>
<p>This code expires in @#ResetCodeExpiryMinutes@ minutes.</p>
<p>If you did not request this, you can safely ignore this email.</p>','019f3dd5-97df-7e96-9375-c264794003e6')
;

-- Jul 7, 2026, 8:27:33 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Enter your email address to receive a reset code.',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:27:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:27:33','YYYY-MM-DD HH24:MI:SS'),100,201046,'PasswordResetEnterEmail','D','019f3dd5-dba3-7464-aac7-94d688ea2e94')
;

-- Jul 7, 2026, 8:27:45 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','If the account exists, a reset code has been sent to the email on file.',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:27:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:27:45','YYYY-MM-DD HH24:MI:SS'),100,201047,'PasswordResetCodeSent','D','019f3dd6-0aed-751f-87e9-4a0b9d015e0f')
;

-- Jul 7, 2026, 8:27:55 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Enter the code sent to your email.',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:27:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:27:55','YYYY-MM-DD HH24:MI:SS'),100,201048,'PasswordResetEnterCode','D','019f3dd6-33a8-77b5-a3b2-341637948ab4')
;

-- Jul 7, 2026, 8:28:04 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Invalid code.',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:28:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:28:04','YYYY-MM-DD HH24:MI:SS'),100,201049,'PasswordResetInvalidCode','D','019f3dd6-552c-71e0-b7ba-e3c7dd6cd849')
;

-- Jul 7, 2026, 8:28:13 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The code has expired. Please request a new one.',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:28:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:28:12','YYYY-MM-DD HH24:MI:SS'),100,201050,'PasswordResetCodeExpired','D','019f3dd6-76d7-7519-9041-66d8c6669735')
;

-- Jul 7, 2026, 8:28:25 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Too many incorrect attempts. Please request a new code.',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:28:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:28:24','YYYY-MM-DD HH24:MI:SS'),100,201051,'PasswordResetAttemptsExceeded','D','019f3dd6-a5f4-73fb-bef9-8d6cc2eef625')
;

-- Jul 7, 2026, 8:28:33 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Too many requests. Please try again later.',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:28:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:28:32','YYYY-MM-DD HH24:MI:SS'),100,201052,'PasswordResetTooManyRequests','D','019f3dd6-c502-7aa7-869d-d222cafaf2e8')
;

-- Jul 7, 2026, 8:28:42 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Your password has been reset. Please log in with your new password.',0,0,'Y',TO_TIMESTAMP('2026-07-07 20:28:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-07 20:28:42','YYYY-MM-DD HH24:MI:SS'),100,201053,'PasswordResetSuccess','D','019f3dd6-ea3c-7f4b-b5e3-d6c758a6108b')
;

-- Jul 7, 2026, 8:39:23 PM CEST
UPDATE AD_Column SET FieldLength=100,Updated=TO_TIMESTAMP('2026-07-07 20:39:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217646
;

-- Jul 7, 2026, 8:39:27 PM CEST
ALTER TABLE AD_PasswordResetToken MODIFY OneTimeCode VARCHAR2(100 CHAR)
;

-- Jul 7, 2026, 8:39:39 PM CEST
UPDATE AD_Column SET FieldLength=100,Updated=TO_TIMESTAMP('2026-07-07 20:39:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217650
;

-- Jul 7, 2026, 8:39:43 PM CEST
ALTER TABLE AD_PasswordResetToken MODIFY VerifiedTokenHash VARCHAR2(100 CHAR) DEFAULT NULL 
;

