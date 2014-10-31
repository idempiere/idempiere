SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 17, 2014 7:55:51 PM CET
-- IDEMPIERE-1697 Ability to filter available column for print format
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AD_Window_ID,AccessLevel,CopyColumnsFromTable,Created,CreatedBy,DatabaseViewDrop,EntityType,ImportTable,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,Processing,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200109,'61c4df89-6a05-4cdf-8cfb-f911aefe92b4',180,'4','N',TO_DATE('2014-01-17 19:55:50','YYYY-MM-DD HH24:MI:SS'),100,'N','D','N','Y','Y','N','Y','N','N','N',0,'Report View Selected column','N','L','AD_ReportView_Column',TO_DATE('2014-01-17 19:55:50','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 17, 2014 7:55:56 PM CET
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200157,'d643471e-4216-4de0-b8fc-9a9a17567c70',TO_DATE('2014-01-17 19:55:55','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table AD_ReportView_Column',1,'Y','N','Y','Y','AD_ReportView_Column','N',1000000,TO_DATE('2014-01-17 19:55:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 17, 2014 7:56:31 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210934,'fef5898b-5b3a-4820-9c5c-b49d38f47c4b',102,0,19,200109,116,'AD_Client_ID',TO_DATE('2014-01-17 19:56:30','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',22,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','Client','1=1',0,0,TO_DATE('2014-01-17 19:56:30','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jan 17, 2014 7:57:02 PM CET
INSERT INTO AD_Val_Rule (AD_Client_ID,AD_Org_ID,AD_Val_Rule_ID,AD_Val_Rule_UU,Code,Created,CreatedBy,EntityType,IsActive,Name,Type,Updated,UpdatedBy) VALUES (0,0,200055,'a95018ef-f591-4e92-a494-92d875ae7462','AD_Column.AD_Table_ID=@AD_Table_ID@ AND AD_Column.AD_Column_ID NOT IN (SELECT AD_Column_ID FROM AD_ReportView_Column WHERE AD_ReportView_ID=@AD_ReportView_ID@)',TO_DATE('2014-01-17 19:57:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Column in AD_Table (not present in AD_ReportView_Column)','S',TO_DATE('2014-01-17 19:57:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 17, 2014 7:57:32 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210935,'e5fe354e-7566-4a08-a601-b0d97ca5f186',104,0,19,200109,200055,'AD_Column_ID',TO_DATE('2014-01-17 19:57:32','YYYY-MM-DD HH24:MI:SS'),100,'Column in the table','D','N',22,'Link to the database column of the table','Y','Y','Y','N','N','N','N','N','Y','Y','N','N','N','N','N','N','Column',0,0,TO_DATE('2014-01-17 19:57:32','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jan 17, 2014 7:57:50 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210936,'60086644-8471-499c-bf88-44478e949c93',113,0,19,200109,148,'AD_Org_ID',TO_DATE('2014-01-17 19:57:50','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Org_ID@','Organizational entity within client','D',22,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','N','N','Organization',0,0,TO_DATE('2014-01-17 19:57:50','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jan 17, 2014 7:58:03 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202644,'befda76c-f925-4b83-9a67-dc04aee798fe',0,'AD_ReportView_Column_UU',TO_DATE('2014-01-17 19:58:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ReportView_Column_UU','AD_ReportView_Column_UU',TO_DATE('2014-01-17 19:58:02','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 17, 2014 7:58:17 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FKConstraintType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210937,'60cbf348-8cbf-4801-a914-60ac3e550bea',202644,0,10,200109,'AD_ReportView_Column_UU',TO_DATE('2014-01-17 19:58:16','YYYY-MM-DD HH24:MI:SS'),100,'D','N',36,'Y','N','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','AD_ReportView_Column_UU',0,0,TO_DATE('2014-01-17 19:58:16','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jan 17, 2014 7:58:21 PM CET
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2014-01-17 19:58:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210936
;

-- Jan 17, 2014 7:58:23 PM CET
UPDATE AD_Column SET EntityType='D', IsUpdateable='N',Updated=TO_DATE('2014-01-17 19:58:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210935
;

-- Jan 17, 2014 7:58:47 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210938,'6d8f48d0-07e3-49c3-a0e6-5e5539279496',1252,0,30,200109,'AD_ReportView_ID',TO_DATE('2014-01-17 19:58:46','YYYY-MM-DD HH24:MI:SS'),100,'View used to generate this report','D','N',22,'The Report View indicates the view used to generate this report.','Y','Y','Y','N','N','N','N','N','Y','Y','N','N','N','N','N','N','Report View',0,0,TO_DATE('2014-01-17 19:58:46','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jan 17, 2014 7:58:56 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210939,'0a89a617-6e81-4e20-a890-408943ee7e64',245,0,16,200109,'Created',TO_DATE('2014-01-17 19:58:55','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','N','N','Created',0,0,TO_DATE('2014-01-17 19:58:55','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jan 17, 2014 7:59:06 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210940,'5d88374b-0ec9-4791-856f-816aa6a03ac1',246,0,18,110,200109,'CreatedBy',TO_DATE('2014-01-17 19:59:05','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',22,'The Created By field indicates the user who created this record.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','N','N','Created By',0,0,TO_DATE('2014-01-17 19:59:05','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jan 17, 2014 7:59:18 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210941,'1ab404bd-25de-432c-8a80-afe50d47c0a5',348,0,20,200109,'IsActive',TO_DATE('2014-01-17 19:59:17','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','N','Y','Active',0,0,TO_DATE('2014-01-17 19:59:17','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jan 17, 2014 7:59:27 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210942,'d5dc79c0-7fd6-4751-92d3-e944116523ff',607,0,16,200109,'Updated',TO_DATE('2014-01-17 19:59:26','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','N','N','Updated',0,0,TO_DATE('2014-01-17 19:59:26','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jan 17, 2014 7:59:34 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210943,'c6d3683c-cb92-40d5-9e1b-9622b08b487a',608,0,18,110,200109,'UpdatedBy',TO_DATE('2014-01-17 19:59:34','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',22,'The Updated By field indicates the user who updated this record.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','N','N','Updated By',0,0,TO_DATE('2014-01-17 19:59:34','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jan 17, 2014 7:59:43 PM CET
UPDATE AD_Column SET EntityType='D', IsUpdateable='N',Updated=TO_DATE('2014-01-17 19:59:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210938
;

-- Jan 17, 2014 8:00:29 PM CET
UPDATE AD_Column SET FKConstraintName='ADClient_ADReportViewColumn', FKConstraintType='N',Updated=TO_DATE('2014-01-17 20:00:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210934
;

-- Jan 17, 2014 8:00:29 PM CET
UPDATE AD_Column SET FKConstraintName='ADColumn_ADReportViewColumn', FKConstraintType='N', IsUpdateable='N',Updated=TO_DATE('2014-01-17 20:00:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210935
;

-- Jan 17, 2014 8:00:29 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_ADReportViewColumn', FKConstraintType='N',Updated=TO_DATE('2014-01-17 20:00:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210936
;

-- Jan 17, 2014 8:00:30 PM CET
UPDATE AD_Column SET FKConstraintName='ADReportView_ADReportViewColum', FKConstraintType='N', IsUpdateable='N',Updated=TO_DATE('2014-01-17 20:00:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210938
;

-- Jan 17, 2014 8:00:30 PM CET
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADReportViewColumn', FKConstraintType='N',Updated=TO_DATE('2014-01-17 20:00:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210940
;

-- Jan 17, 2014 8:00:30 PM CET
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADReportViewColumn', FKConstraintType='N',Updated=TO_DATE('2014-01-17 20:00:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210943
;

-- Jan 17, 2014 8:00:30 PM CET
CREATE TABLE AD_ReportView_Column (AD_Client_ID NUMBER(10) DEFAULT NULL , AD_Column_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_ReportView_Column_UU VARCHAR2(36) DEFAULT NULL , AD_ReportView_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_ReportView_Column_Key PRIMARY KEY (AD_Column_ID, AD_ReportView_ID), CONSTRAINT AD_ReportView_Column_UU_idx UNIQUE (AD_ReportView_Column_UU))
;

-- Jan 17, 2014 8:00:32 PM CET
ALTER TABLE AD_ReportView_Column ADD CONSTRAINT ADClient_ADReportViewColumn FOREIGN KEY (AD_Client_ID) REFERENCES AD_CLIENT(AD_CLIENT_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 17, 2014 8:00:32 PM CET
ALTER TABLE AD_ReportView_Column ADD CONSTRAINT ADColumn_ADReportViewColumn FOREIGN KEY (AD_Column_ID) REFERENCES AD_COLUMN(AD_COLUMN_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 17, 2014 8:00:32 PM CET
ALTER TABLE AD_ReportView_Column ADD CONSTRAINT ADOrg_ADReportViewColumn FOREIGN KEY (AD_Org_ID) REFERENCES AD_ORG(AD_ORG_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 17, 2014 8:00:32 PM CET
ALTER TABLE AD_ReportView_Column ADD CONSTRAINT ADReportView_ADReportViewColum FOREIGN KEY (AD_ReportView_ID) REFERENCES AD_REPORTVIEW(AD_REPORTVIEW_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 17, 2014 8:00:33 PM CET
ALTER TABLE AD_ReportView_Column ADD CONSTRAINT CreatedBy_ADReportViewColumn FOREIGN KEY (CreatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 17, 2014 8:00:33 PM CET
ALTER TABLE AD_ReportView_Column ADD CONSTRAINT UpdatedBy_ADReportViewColumn FOREIGN KEY (UpdatedBy) REFERENCES AD_USER(AD_USER_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 17, 2014 8:01:17 PM CET
INSERT INTO AD_Tab (AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,210938,0,200116,'4776b336-7794-48c0-96ec-9a3eed2f8143',200109,180,TO_DATE('2014-01-17 20:01:17','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','Y','N','N','N','N','Available Columns','N',30,1,TO_DATE('2014-01-17 20:01:17','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 17, 2014 8:01:19 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210934,202588,'0c47e223-4972-4689-9c92-2734e9814657',0,200116,2,TO_DATE('2014-01-17 20:01:19','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',22,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','N','Client',10,TO_DATE('2014-01-17 20:01:19','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 17, 2014 8:01:21 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,210936,202589,'708987d3-f611-4f68-aa66-7245b5112e76',0,200116,2,TO_DATE('2014-01-17 20:01:20','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',22,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','Y','N','N','N','N','N','N','Organization',20,TO_DATE('2014-01-17 20:01:20','YYYY-MM-DD HH24:MI:SS'),100,4)
;

-- Jan 17, 2014 8:01:21 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210935,202590,'89a6cda0-0a98-43ca-9d40-ee2c62a15994',0,200116,2,TO_DATE('2014-01-17 20:01:21','YYYY-MM-DD HH24:MI:SS'),100,'Column in the table',22,'D','Link to the database column of the table','Y','Y','Y','N','N','N','N','N','Column',30,TO_DATE('2014-01-17 20:01:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 17, 2014 8:01:22 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210937,202591,'e9e6dced-10bc-4f72-a808-9a09bf02cca6',0,200116,2,TO_DATE('2014-01-17 20:01:21','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','AD_ReportView_Column_UU',40,TO_DATE('2014-01-17 20:01:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 17, 2014 8:01:23 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210938,202592,'aeaa9eab-26d1-4a0c-bced-743065cc7aa1',0,200116,2,TO_DATE('2014-01-17 20:01:22','YYYY-MM-DD HH24:MI:SS'),100,'View used to generate this report',22,'D','The Report View indicates the view used to generate this report.','Y','Y','Y','N','N','N','N','N','Report View',50,TO_DATE('2014-01-17 20:01:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 17, 2014 8:01:24 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,210941,202593,'1321abf5-3832-4c51-82a2-ea9a6b9955f0',0,200116,2,TO_DATE('2014-01-17 20:01:23','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',60,TO_DATE('2014-01-17 20:01:23','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Jan 17, 2014 8:01:59 PM CET
UPDATE AD_Tab SET Description='You can define on this tab which columns will be available as the print format items',Updated=TO_DATE('2014-01-17 20:01:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200116
;

-- Jan 17, 2014 8:02:24 PM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202592
;

-- Jan 17, 2014 8:02:24 PM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202590
;

-- Jan 17, 2014 8:02:24 PM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202593
;

-- Jan 17, 2014 8:02:30 PM CET
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202591
;

-- Jan 17, 2014 8:02:30 PM CET
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=202592
;

-- Jan 17, 2014 8:02:30 PM CET
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=202590
;

-- Jan 17, 2014 8:02:30 PM CET
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202593
;

-- Jan 17, 2014 8:02:46 PM CET
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2014-01-17 20:02:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202589
;

-- Jan 17, 2014 8:03:16 PM CET
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2014-01-17 20:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202590
;

SELECT register_migration_script('201401172019_IDEMPIERE-1697.sql') FROM dual
;
