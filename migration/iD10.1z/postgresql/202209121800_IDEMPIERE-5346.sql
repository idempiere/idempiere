-- IDEMPIERE-5346 SSO Support
-- Sep 12, 2022, 4:25:30 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200360,'SSO Configuration','SSO_PrincipleConfig',0,'4',0,0,'Y',TO_TIMESTAMP('2022-09-12 16:25:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:25:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','e7b0a0ee-c098-4705-a2b7-fdd90adc4e63','N','N','N')
;

-- Sep 12, 2022, 4:25:31 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('SSO_PrincipleConfig',1000000,'N','N','Table SSO_PrincipleConfig','Y','Y',0,0,TO_TIMESTAMP('2022-09-12 16:25:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:25:31','YYYY-MM-DD HH24:MI:SS'),100,200428,'Y',1000000,1,200000,'f442cac2-0406-4e4d-a73f-159481fbf4ac')
;

-- Sep 12, 2022, 4:26:32 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215286,0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200360,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:26:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:26:31','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','9922436e-7736-4ac1-a2c6-d48810252c47','N',0,'N','N','D','N')
;

-- Sep 12, 2022, 4:26:51 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215287,0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200360,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:26:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:26:51','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','995c1647-2139-4ec2-b6b9-cb553314b7bc','N',0,'N','N','D','N')
;

-- Sep 12, 2022, 4:27:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215288,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200360,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:27:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:27:16','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','4b815b97-a447-4a19-8c0d-f4bc4139d1ee','N',0,'N','N','N')
;

-- Sep 12, 2022, 4:27:34 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215289,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200360,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:27:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:27:33','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','722a2e9a-62cf-47e4-9656-0a9062f32f71','N',0,'N','N','N')
;

-- Sep 12, 2022, 4:27:45 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215290,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200360,'CreatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:27:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:27:44','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','80ad61ed-4304-4783-bf4f-eca0ccda90cc','N',0,'N','N','D','N')
;

-- Sep 12, 2022, 4:28:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215291,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200360,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:28:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:28:09','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','ae087404-e3a7-4eb8-8574-7aa0d1c5b03f','N',0,'N','N','N')
;

-- Sep 12, 2022, 4:28:20 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215292,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200360,'UpdatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:28:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:28:19','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','35c922af-4d62-43da-8a6f-1761f16fd6d3','N',0,'N','N','D','N')
;

-- Sep 12, 2022, 4:32:36 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203653,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:32:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:32:35','YYYY-MM-DD HH24:MI:SS'),100,'SSO_PrincipleConfig_ID','SSO Configuration','SSO Configuration','D','425b9a47-7bb0-43a7-9229-80055b571c74')
;

-- Sep 12, 2022, 4:32:53 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203654,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:32:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:32:52','YYYY-MM-DD HH24:MI:SS'),100,'SSO_PrincipleConfig_UU','SSO Configuration UU','SSO Configuration UU','D','c54393fb-1913-4660-9672-48f08f2a6026')
;

-- Sep 12, 2022, 4:36:00 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215294,0,'SSO Configuration UU',200360,'SSO_PrincipleConfig_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:36:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:36:00','YYYY-MM-DD HH24:MI:SS'),100,203654,'N','N','D','N','N','N','Y','29915d20-0fb9-4548-8821-02bf067c7fc8','N',0,'N','N','N','N')
;

-- Sep 12, 2022, 4:39:26 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215296,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200360,'Name',60,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:39:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:39:25','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','9d805126-1dbd-4379-b4ba-e83d9e84112d','Y',20,'N','N','N')
;

-- Sep 12, 2022, 4:42:57 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203655,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:42:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:42:56','YYYY-MM-DD HH24:MI:SS'),100,'SSO_AuthorizationTenantID','Tenant ID','SSO Tenant ID','Tenant ID','D','3d476f0b-fc9a-41fe-a934-708ff7b09924')
;

-- Sep 12, 2022, 4:43:57 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215297,0,'Tenant ID','SSO Tenant ID',200360,'SSO_AuthorizationTenantID',100,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:43:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:43:56','YYYY-MM-DD HH24:MI:SS'),100,203655,'Y','N','D','N','N','N','N','2e32c2c9-c933-4531-85b8-9fcd5e32cb00','N',0,'N','N','N','N')
;

-- Sep 12, 2022, 4:45:14 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203656,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:45:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:45:13','YYYY-MM-DD HH24:MI:SS'),100,'SSO_ApplicationClientID','Application Client ID','SSO Application Client ID','Application Client ID','D','3747d76d-0432-4981-a8d4-b35b26903ad1')
;

-- Sep 12, 2022, 4:45:58 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215298,0,'Application Client ID','SSO Application Client ID',200360,'SSO_ApplicationClientID',100,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:45:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:45:57','YYYY-MM-DD HH24:MI:SS'),100,203656,'Y','N','D','N','Y','N','N','39975d3e-0a1f-407f-9067-50f7dcfb6bef','N',0,'N','N','N','N')
;

-- Sep 12, 2022, 4:47:18 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203657,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:47:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:47:17','YYYY-MM-DD HH24:MI:SS'),100,'SSO_ApplicationSecretKey','Application Secret Key','SSO Application Secret Key','Application Secret Key','D','d5dd4ee2-f12b-46e3-a972-d8f2731bc540')
;

-- Sep 12, 2022, 4:48:17 PM IST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-09-12 16:48:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215298
;

-- Sep 12, 2022, 4:48:48 PM IST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-09-12 16:48:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215297
;

-- Sep 12, 2022, 4:51:27 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203658,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:51:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:51:27','YYYY-MM-DD HH24:MI:SS'),100,'SSO_ApplicationRedirectURIs','Application Redirect URIs','SSO Application Redirect URIs','Application Redirect URIs','D','b2c0bcba-10c2-4a81-bcec-84f9d6c3522c')
;

-- Sep 12, 2022, 4:52:05 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215300,0,'Application Redirect URIs','SSO Application Redirect URIs',200360,'SSO_ApplicationRedirectURIs',1000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:52:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:52:04','YYYY-MM-DD HH24:MI:SS'),100,203658,'Y','N','D','N','Y','N','N','d407ac13-80ef-4af8-92eb-343f63ea13fc','N',0,'N','N','N','N')
;

-- Sep 12, 2022, 4:54:54 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203659,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:54:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:54:53','YYYY-MM-DD HH24:MI:SS'),100,'SSO_ApplicationLogoutURL','Application Logout URL','SSO Application Logout URL','Application Logout URL','D','343fd50a-b2cb-4e0c-ae61-ecc45c40bbca')
;

-- Sep 12, 2022, 4:56:02 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215301,0,'Application Logout URL','SSO Application Logout URL',200360,'SSO_ApplicationLogoutURL',1000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-12 16:56:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 16:56:01','YYYY-MM-DD HH24:MI:SS'),100,203659,'Y','N','D','N','Y','N','N','c24bd056-beca-4fb6-ae85-660115478486','N',0,'N','N','N','N')
;

-- Sep 12, 2022, 5:03:36 PM IST
INSERT INTO AD_Window (AD_Window_ID,Name,Description,Help,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200132,'SSO Configuration','Single sign-on Configuration','Single sign-on is an authentication scheme that allows a user to log in with a single ID to any of several related, yet independent, software systems.',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:03:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:03:35','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','60c3edde-af29-44d9-bc0c-9dab28f5dc32')
;

-- Sep 12, 2022, 5:04:09 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200328,'SSO Configuration',200132,10,'Y',200360,0,0,'Y',TO_TIMESTAMP('2022-09-12 17:04:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:04:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','29ac2590-d681-4a3e-8b04-caf5269dda86','B','N','Y',0)
;

-- Sep 12, 2022, 5:04:22 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207191,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200328,215286,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:04:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:04:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6b76faa4-3d47-460c-b6a9-be25ee42157f','N',2)
;

-- Sep 12, 2022, 5:04:22 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207192,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200328,215287,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:04:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:04:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','68d8d75d-7d18-47b3-86c1-9146bfeb5bb2','Y','N',4,2)
;

-- Sep 12, 2022, 5:04:24 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207194,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200328,215296,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:04:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:04:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bf3c6b23-a1de-4c0a-afe8-81aa42826d5c','Y',20,5)
;

-- Sep 12, 2022, 5:04:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207195,'SSO Configuration UU',200328,215294,'Y',36,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:04:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:04:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d2d7b7a8-2d3a-473e-b4c9-6081967b65c1','Y',30,2)
;

-- Sep 12, 2022, 5:04:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207196,'Tenant ID','SSO Tenant ID',200328,215297,'Y',100,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:04:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:04:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','87c18271-db99-413d-80a7-8a0e78484e0d','Y',40,5)
;

-- Sep 12, 2022, 5:04:26 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207197,'Application Client ID','SSO Application Client ID',200328,215298,'Y',100,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:04:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:04:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fe330472-2b33-4ba4-b162-c375d569cda1','Y',50,5)
;

-- Sep 12, 2022, 5:04:27 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207198,'Application Redirect URIs','SSO Application Redirect URIs',200328,215300,'Y',1000,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:04:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:04:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bc2ba7bc-d194-42de-83f7-6ae40e659436','Y',60,5)
;

-- Sep 12, 2022, 5:04:27 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207199,'Application Logout URL','SSO Application Logout URL',200328,215301,'Y',1000,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:04:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:04:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','266b349b-5040-4e62-a2bd-12cc8d1b26a5','Y',70,5)
;

-- Sep 12, 2022, 5:04:28 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207200,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200328,215288,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:04:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:04:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','665490df-8b3d-4e40-a9f2-659e3e9ead95','Y',80,2,2)
;

-- Sep 12, 2022, 5:06:28 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215302,0,'Application Secret Key','SSO Application Secret Key',200360,'SSO_ApplicationSecretKey',100,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-12 17:06:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:06:28','YYYY-MM-DD HH24:MI:SS'),100,203657,'Y','N','D','N','N','N','N','a1c453e1-42f2-4131-810a-3e9f6ea6c81e','N',0,'N','Y','N')
;

-- Sep 12, 2022, 5:06:35 PM IST
CREATE TABLE SSO_PrincipleConfig (AD_Client_ID NUMERIC(10) DEFAULT NULL , AD_Org_ID NUMERIC(10) DEFAULT NULL , Created TIMESTAMP DEFAULT statement_timestamp(), CreatedBy NUMERIC(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')), Name VARCHAR(60) DEFAULT NULL , SSO_ApplicationClientID VARCHAR(100) NOT NULL, SSO_ApplicationLogoutURL VARCHAR(1000) DEFAULT NULL , SSO_ApplicationRedirectURIs VARCHAR(1000) DEFAULT NULL , SSO_ApplicationSecretKey VARCHAR(100) DEFAULT NULL , SSO_AuthorizationTenantID VARCHAR(100) NOT NULL, SSO_PrincipleConfig_ID NUMERIC(10) DEFAULT NULL , SSO_PrincipleConfig_UU VARCHAR(36) DEFAULT NULL , Updated TIMESTAMP DEFAULT statement_timestamp(), UpdatedBy NUMERIC(10) DEFAULT NULL , CONSTRAINT SSO_PrincipleConfig_Key PRIMARY KEY (SSO_PrincipleConfig_ID), CONSTRAINT SSO_PrincipleConfig_UU_idx UNIQUE (SSO_PrincipleConfig_UU))
;

-- Sep 12, 2022, 5:06:51 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207201,'Application Secret Key','SSO Application Secret Key',200328,215302,'Y',100,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:06:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:06:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fbb79fdd-d901-4376-b7d9-1590714388a2','Y',90,5)
;

-- Sep 12, 2022, 5:07:03 PM IST
UPDATE AD_Field SET IsEncrypted='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:07:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207201
;

-- Sep 12, 2022, 5:07:41 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:07:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207200
;

-- Sep 12, 2022, 5:07:41 PM IST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:07:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207194
;

-- Sep 12, 2022, 5:07:41 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:07:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207201
;

-- Sep 12, 2022, 5:07:41 PM IST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:07:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207198
;

-- Sep 12, 2022, 5:07:41 PM IST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:07:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207199
;

-- Sep 12, 2022, 5:07:41 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:07:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207195
;

-- Sep 12, 2022, 5:08:48 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215303,0,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200360,'IsDefault','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-09-12 17:08:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:08:47','YYYY-MM-DD HH24:MI:SS'),100,1103,'Y','N','D','N','Y','N','N','20322354-658d-4f1c-a843-63210d791833','N',0,'N','N','N')
;

-- Sep 12, 2022, 5:08:54 PM IST
ALTER TABLE SSO_PrincipleConfig ADD COLUMN IsDefault CHAR(1) DEFAULT 'N' CHECK (IsDefault IN ('Y','N'))
;

-- Sep 12, 2022, 5:09:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207202,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200328,215303,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 17:09:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 17:09:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','92e8c5be-c0ec-4ab8-8b2c-75b50580fd0e','Y',100,2,2)
;

-- Sep 12, 2022, 5:09:40 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:09:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207194
;

-- Sep 12, 2022, 5:09:40 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:09:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207200
;

-- Sep 12, 2022, 5:09:40 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:09:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207202
;

-- Sep 12, 2022, 5:09:40 PM IST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:09:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207196
;

-- Sep 12, 2022, 5:09:40 PM IST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:09:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207197
;

-- Sep 12, 2022, 5:09:40 PM IST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:09:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207201
;

-- Sep 12, 2022, 5:09:40 PM IST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:09:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207198
;

-- Sep 12, 2022, 5:09:40 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 17:09:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207199
;

-- Sep 12, 2022, 7:02:49 PM IST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-09-12 19:02:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215302
;

-- Sep 12, 2022, 7:08:59 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215304,0,'SSO Configuration',200360,'SSO_PrincipleConfig_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2022-09-12 19:08:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 19:08:58','YYYY-MM-DD HH24:MI:SS'),100,203653,'N','N','D','N','N','N','Y','55dd0703-1d94-4de9-abc2-cd4380265192','N',0,'N','N','N','N')
;

-- Sep 12, 2022, 7:09:00 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_PrincipleConfig_ID','NUMERIC(10)',null,null)
;

-- Sep 12, 2022, 7:10:54 PM IST
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N',Updated=TO_TIMESTAMP('2022-09-12 19:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215304
;

-- Sep 12, 2022, 7:15:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207203,'SSO Configuration',200328,215304,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-12 19:15:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 19:15:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7ce5cdab-9590-4185-a300-6a8a8faf4c8e','N',2)
;

-- Sep 12, 2022, 7:15:20 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-12 19:15:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207203
;

-- Sep 12, 2022, 7:21:23 PM IST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-09-12 19:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215300
;

-- Sep 12, 2022, 6:22:56 PM IST
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200213,'SSO Configuration','W',200132,0,0,'Y',TO_TIMESTAMP('2022-09-12 18:22:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-12 18:22:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','7ce4cdf9-d345-4a4f-919b-698661ea99f0')
;

-- Sep 12, 2022, 6:22:56 PM IST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200213, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200213)
;

-- Sep 12, 2022, 7:00:55 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200205,0,0,TO_TIMESTAMP('2022-09-12 19:00:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-09-12 19:00:54','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ENABLE_SSO','N','Enable SSO Authentication Login','D','S','51cf2755-a4cb-49bf-b08e-c1ef54c1e0f8')
;

-- Sep 15, 2022, 11:56:42 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203670,0,0,'Y',TO_TIMESTAMP('2022-09-15 11:56:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-15 11:56:41','YYYY-MM-DD HH24:MI:SS'),100,'SSO_Provider','SSO Provider','Single Sign-On (SSO) Providers ( Microsoft Azure , Google, Jump Cloud etc..)','SSO Provider','D','959ffea1-effb-434a-8480-f035fca65815')
;

-- Sep 15, 2022, 11:58:07 AM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200213,'SSO Provider List','L',0,0,'Y',TO_TIMESTAMP('2022-09-15 11:58:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-15 11:58:06','YYYY-MM-DD HH24:MI:SS'),100,'D','N','f12db9ec-7c5c-46a7-a2ba-d01b4043dae2')
;

-- Sep 15, 2022, 11:58:44 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215355,0,'SSO Provider','Single Sign-On (SSO) Providers ( Microsoft Azure , Google, Jump Cloud etc..)',200360,'SSO_Provider',22,'N','N','Y','N','N',0,'N',17,200213,0,0,'Y',TO_TIMESTAMP('2022-09-15 11:58:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-15 11:58:42','YYYY-MM-DD HH24:MI:SS'),100,203670,'Y','N','D','N','N','N','N','88889119-20f7-4261-9bc7-344c0c7fc9ff','N',0,'N','N','N','N')
;

-- Sep 15, 2022, 11:58:46 AM IST
ALTER TABLE SSO_PrincipleConfig ADD COLUMN SSO_Provider VARCHAR(22) NOT NULL
;

-- Sep 15, 2022, 11:59:03 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207242,'SSO Provider','Single Sign-On (SSO) Providers ( Microsoft Azure , Google, Jump Cloud etc..)',200328,215355,'Y',22,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-15 11:59:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-15 11:59:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','425a912e-b334-46b6-863f-ebd31bb46003','Y',110,2)
;

-- Sep 15, 2022, 11:59:39 AM IST
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=10, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-15 11:59:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207242
;

-- Sep 19, 2022, 3:49:07 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The user has no access',0,0,'Y',TO_TIMESTAMP('2022-09-19 15:49:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-19 15:49:05','YYYY-MM-DD HH24:MI:SS'),100,200784,'UserNoRoleError','D','241a07d4-4b46-4666-b7a9-277edbcdefa5')
;

-- Sep 19, 2022, 3:49:32 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','User not found',0,0,'Y',TO_TIMESTAMP('2022-09-19 15:49:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-19 15:49:31','YYYY-MM-DD HH24:MI:SS'),100,200785,'UserNotFoundError','D','64499310-0505-4cc3-8089-b6e64011d99a')
;

-- Oct 18, 2022, 11:37:28 AM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2022-10-18 11:37:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215298
;

-- Oct 18, 2022, 11:37:45 AM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2022-10-18 11:37:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215300
;

-- Oct 18, 2022, 11:37:55 AM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2022-10-18 11:37:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215302
;

-- Oct 18, 2022, 11:38:12 AM IST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2022-10-18 11:38:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215297
;

-- Oct 18, 2022, 11:38:28 AM IST
UPDATE AD_Field SET IsDisplayed='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-10-18 11:38:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207199
;

-- Oct 19, 2022, 3:54:46 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_ApplicationClientID','VARCHAR(100)',null,'NULL')
;

-- Oct 19, 2022, 3:54:46 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_ApplicationClientID',null,'NULL',null)
;

-- Oct 19, 2022, 3:54:58 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_ApplicationLogoutURL','VARCHAR(1000)',null,'NULL')
;

-- Oct 19, 2022, 3:55:09 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_ApplicationRedirectURIs','VARCHAR(1000)',null,'NULL')
;

-- Oct 19, 2022, 3:55:22 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_ApplicationSecretKey','VARCHAR(100)',null,'NULL')
;

-- Oct 19, 2022, 3:55:28 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_AuthorizationTenantID','VARCHAR(100)',null,'NULL')
;

-- Oct 19, 2022, 3:55:28 PM IST
INSERT INTO t_alter_column values('sso_principleconfig','SSO_AuthorizationTenantID',null,'NULL',null)
;

-- Nov 4, 2022, 4:29:25 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203725,0,0,'Y',TO_TIMESTAMP('2022-11-04 16:29:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:29:24','YYYY-MM-DD HH24:MI:SS'),100,'SSO_ApplicationDomain','Application Domain','SSO Application Domain','Application Domain','D','e5ed0a02-4eaf-4713-9107-ccc79f1e0cb1')
;

-- Nov 4, 2022, 4:30:18 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203727,0,0,'Y',TO_TIMESTAMP('2022-11-04 16:30:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:30:18','YYYY-MM-DD HH24:MI:SS'),100,'SSO_ApplicationDiscoveryURI','Application Discovery URI','SSO Application Discovery URI','Application Discovery URI','D','999d76d2-1744-457d-bac9-3134f750874f')
;

-- Nov 4, 2022, 4:30:45 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215637,0,'Application Discovery URI','SSO Application Discovery URI',200360,'SSO_ApplicationDiscoveryURI',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-11-04 16:30:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:30:44','YYYY-MM-DD HH24:MI:SS'),100,203727,'Y','N','D','N','Y','N','Y','f806a488-6dfc-4fee-aa15-9794aa9eafe0','Y',0,'N','N','N','N')
;

-- Nov 4, 2022, 4:30:46 PM IST
ALTER TABLE SSO_PrincipleConfig ADD COLUMN SSO_ApplicationDiscoveryURI VARCHAR(4000) DEFAULT NULL 
;

-- Nov 4, 2022, 4:31:06 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215638,0,'Application Domain','SSO Application Domain',200360,'SSO_ApplicationDomain',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-11-04 16:31:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:31:06','YYYY-MM-DD HH24:MI:SS'),100,203725,'Y','N','D','N','Y','N','Y','2dbe8818-b3c5-470d-885f-7d5cb2eb0c50','Y',0,'N','N','N','N')
;

-- Nov 4, 2022, 4:31:07 PM IST
ALTER TABLE SSO_PrincipleConfig ADD COLUMN SSO_ApplicationDomain VARCHAR(4000) DEFAULT NULL 
;

-- Nov 4, 2022, 4:31:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207414,'Application Discovery URI','SSO Application Discovery URI',200328,215637,'Y',4000,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-04 16:31:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:31:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','24573116-ea2f-4cc2-86d5-19abee762b99','Y',110,5)
;

-- Nov 4, 2022, 4:31:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207415,'Application Domain','SSO Application Domain',200328,215638,'Y',4000,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-04 16:31:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-04 16:31:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3b760acd-467f-42ad-9d9c-2bc1887185b8','Y',120,5)
;

-- Nov 4, 2022, 4:31:38 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-04 16:31:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207415
;

-- Nov 4, 2022, 4:31:38 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-04 16:31:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207199
;

-- Nov 7, 2022, 4:32:56 PM IST
UPDATE AD_Column SET Help='A directory of the OIDC architecture of your user pool.',Updated=TO_TIMESTAMP('2022-11-07 16:32:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215637
;

-- Nov 7, 2022, 4:37:19 PM IST
UPDATE AD_Column SET Help='A domain name is a string that identifies a realm of administrative autonomy, authority or control within the Internet for your Provider.',Updated=TO_TIMESTAMP('2022-11-07 16:37:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215638
;

-- Nov 7, 2022, 4:43:08 PM IST
UPDATE AD_Column SET Help='SSO provider unique app client id',Updated=TO_TIMESTAMP('2022-11-07 16:43:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215298
;

-- Nov 7, 2022, 4:45:25 PM IST
UPDATE AD_Column SET Help='SSO provider client secret key to access this user info',Updated=TO_TIMESTAMP('2022-11-07 16:45:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215302
;

-- Nov 7, 2022, 4:57:57 PM IST
UPDATE AD_Column SET Help='SSO provider Tenant ID is a globally unique identifier (GUID)',Updated=TO_TIMESTAMP('2022-11-07 16:57:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215297
;

-- Nov 7, 2022, 4:58:39 PM IST
UPDATE AD_Column SET Description='SSO provider Tenant ID is a globally unique identifier (GUID)',Updated=TO_TIMESTAMP('2022-11-07 16:58:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215297
;

-- Nov 7, 2022, 4:59:04 PM IST
UPDATE AD_Column SET Description='SSO provider unique app client id',Updated=TO_TIMESTAMP('2022-11-07 16:59:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215298
;

-- Nov 7, 2022, 4:59:12 PM IST
UPDATE AD_Column SET Description='A directory of the OIDC architecture of your user pool.',Updated=TO_TIMESTAMP('2022-11-07 16:59:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215637
;

-- Nov 7, 2022, 4:59:22 PM IST
UPDATE AD_Column SET Description='A domain name is a string that identifies a realm of administrative autonomy, authority or control within the Internet for your Provider.',Updated=TO_TIMESTAMP('2022-11-07 16:59:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215638
;

-- Nov 7, 2022, 4:59:29 PM IST
UPDATE AD_Column SET Description='This is where SSO provider sends a request to have the application clear the user''s session data',Updated=TO_TIMESTAMP('2022-11-07 16:59:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215301
;

-- Nov 7, 2022, 4:59:36 PM IST
UPDATE AD_Column SET Description='The URIs SSO provider will accept as destinations when returning authentication responses (tokens) after successfully authenticating.',Updated=TO_TIMESTAMP('2022-11-07 16:59:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215300
;

-- Nov 7, 2022, 4:59:40 PM IST
UPDATE AD_Column SET Description='SSO provider client secret key to access this user info',Updated=TO_TIMESTAMP('2022-11-07 16:59:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215302
;

-- Nov 8, 2022, 3:50:10 PM IST
UPDATE AD_Field SET Description='SSO provider unique app client id', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207197
;

-- Nov 8, 2022, 3:50:29 PM IST
UPDATE AD_Field SET Description='A directory of the OIDC architecture of your user pool.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:50:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207414
;

-- Nov 8, 2022, 3:50:41 PM IST
UPDATE AD_Field SET Description='A domain name is a string that identifies a realm of administrative autonomy, authority or control within the Internet for your Provider.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:50:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207415
;

-- Nov 8, 2022, 3:51:17 PM IST
UPDATE AD_Field SET Description='The URIs SSO provider will accept as destinations when returning authentication responses (tokens) after successfully authenticating or signing out users.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:51:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207198
;

-- Nov 8, 2022, 3:51:30 PM IST
UPDATE AD_Field SET Description='SSO provider client secret key to access this user info', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:51:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207201
;

-- Nov 8, 2022, 3:51:44 PM IST
UPDATE AD_Field SET Description='SSO provider Tenant ID is a globally unique identifier (GUID)', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 15:51:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207196
;

-- Nov 8, 2022, 4:06:57 PM IST
UPDATE AD_Column SET Help='The URIs SSO provider will accept as destinations when returning authentication responses (tokens) after successfully authenticating.',Updated=TO_TIMESTAMP('2022-11-08 16:06:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215300
;

-- Nov 8, 2022, 4:07:07 PM IST
UPDATE AD_Field SET Description='The URIs SSO provider will accept as destinations when returning authentication responses (tokens) after successfully authenticating.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-11-08 16:07:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207198
;

SELECT register_migration_script('202209121800_IDEMPIERE-5346.sql') FROM dual
;