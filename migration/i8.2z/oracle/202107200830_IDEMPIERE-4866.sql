SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 20, 2021, 8:18:16 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200280,'AD_SMTP','AD_SMTP',0,'3',0,0,'Y',TO_DATE('2021-07-20 08:18:15','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:15','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','N','N','D','N','Y','L','N','Y','dd5e80b1-9206-4f13-9d9a-a225ed3d7b78','N','N','N','N')
;

-- Jul 20, 2021, 8:18:16 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_SMTP',1000000,'N','N','Table AD_SMTP','Y','Y',0,0,TO_DATE('2021-07-20 08:18:16','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:16','YYYY-MM-DD HH24:MI:SS'),0,200349,'Y',1000000,1,200000,'1ec73ebd-f1cc-4563-9789-b2656dd6df87')
;

-- Jul 20, 2021, 8:18:27 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214546,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200280,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-07-20 08:18:26','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:26','YYYY-MM-DD HH24:MI:SS'),0,102,'N','N','D','N','N','N','Y','330e94eb-0578-4a45-97b1-9cf7e6105c91','N','N','N','D','N')
;

-- Jul 20, 2021, 8:18:27 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214547,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200280,104,'AD_Org_ID','0',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-07-20 08:18:27','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:27','YYYY-MM-DD HH24:MI:SS'),0,113,'N','N','D','N','N','N','Y','289b148b-9a2d-4821-95df-684f924f0d95','N','N','N','D','N')
;

-- Jul 20, 2021, 8:18:27 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214548,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200280,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-07-20 08:18:27','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:27','YYYY-MM-DD HH24:MI:SS'),0,245,'N','N','D','N','N','N','Y','c893791c-76d8-4311-82bc-41413dff319e','N','N','N','N','N')
;

-- Jul 20, 2021, 8:18:28 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214549,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200280,'CreatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2021-07-20 08:18:27','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:27','YYYY-MM-DD HH24:MI:SS'),0,246,'N','N','D','N','N','N','Y','5a062ad4-bac3-4e84-b23c-7eb3ac1a3d97','N','N','N','D','N')
;

-- Jul 20, 2021, 8:18:28 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214550,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200280,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-07-20 08:18:28','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:28','YYYY-MM-DD HH24:MI:SS'),0,348,'Y','N','D','N','N','N','Y','47c96422-152d-46d2-bb4e-f5a6ac79d50a','N','N','N','N','N')
;

-- Jul 20, 2021, 8:18:28 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214551,1,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200280,'Name',60,'N','N','Y','N','Y',1,'N',10,0,0,'Y',TO_DATE('2021-07-20 08:18:28','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:28','YYYY-MM-DD HH24:MI:SS'),0,469,'Y','Y','D','N','N','N','Y','cae3d5d8-1297-4a8a-b2a4-8d4a1086ef51','Y',10,'N','N','N','N')
;

-- Jul 20, 2021, 8:18:29 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214552,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200280,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-07-20 08:18:28','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:28','YYYY-MM-DD HH24:MI:SS'),0,607,'N','N','D','N','N','N','Y','dc748512-cc27-45b7-ba22-6217297589e8','N','N','N','N','N')
;

-- Jul 20, 2021, 8:18:29 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214553,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200280,'UpdatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_DATE('2021-07-20 08:18:29','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:29','YYYY-MM-DD HH24:MI:SS'),0,608,'N','N','D','N','N','N','Y','475af82d-63a0-4bea-8977-73ce134d7f7f','N','N','N','D','N')
;

-- Jul 20, 2021, 8:18:29 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203525,0,0,'Y',TO_DATE('2021-07-20 08:18:29','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:29','YYYY-MM-DD HH24:MI:SS'),0,'AD_SMTP_ID','AD_SMTP','AD_SMTP','D','0ee50e0c-2c02-443b-894b-070367ee3c3a')
;

-- Jul 20, 2021, 8:18:30 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214554,1,'AD_SMTP',200280,'AD_SMTP_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_DATE('2021-07-20 08:18:29','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:29','YYYY-MM-DD HH24:MI:SS'),0,203525,'N','N','D','N','N','N','Y','2bd1febd-7a44-4680-9f6a-e3662a8bff6c','N','N','N','N','N')
;

-- Jul 20, 2021, 8:18:30 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203526,0,0,'Y',TO_DATE('2021-07-20 08:18:30','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:30','YYYY-MM-DD HH24:MI:SS'),0,'AD_SMTP_UU','AD_SMTP_UU','AD_SMTP_UU','D','e08db265-962d-4315-9970-00075a9da6a9')
;

-- Jul 20, 2021, 8:18:30 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214555,1.00,'AD_SMTP_UU',200280,'AD_SMTP_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2021-07-20 08:18:30','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:18:30','YYYY-MM-DD HH24:MI:SS'),0,203526,'Y','N','D','N','N','N','Y','b268b718-cd7f-45ee-8e84-dacb35b59d18','N','N','N','N','N')
;

-- Jul 20, 2021, 8:19:06 AM CEST
UPDATE AD_Element SET Name='SMTP Server', PrintName='SMTP Server',Updated=TO_DATE('2021-07-20 08:19:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=203525
;

-- Jul 20, 2021, 8:19:06 AM CEST
UPDATE AD_Column SET ColumnName='AD_SMTP_ID', Name='SMTP Server', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203525
;

-- Jul 20, 2021, 8:19:06 AM CEST
UPDATE AD_Process_Para SET ColumnName='AD_SMTP_ID', Name='SMTP Server', Description=NULL, Help=NULL, AD_Element_ID=203525 WHERE UPPER(ColumnName)='AD_SMTP_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jul 20, 2021, 8:19:06 AM CEST
UPDATE AD_Process_Para SET ColumnName='AD_SMTP_ID', Name='SMTP Server', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203525 AND IsCentrallyMaintained='Y'
;

-- Jul 20, 2021, 8:19:06 AM CEST
UPDATE AD_InfoColumn SET ColumnName='AD_SMTP_ID', Name='SMTP Server', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203525 AND IsCentrallyMaintained='Y'
;

-- Jul 20, 2021, 8:19:06 AM CEST
UPDATE AD_Field SET Name='SMTP Server', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203525) AND IsCentrallyMaintained='Y'
;

-- Jul 20, 2021, 8:19:06 AM CEST
UPDATE AD_PrintFormatItem SET PrintName='SMTP Server', Name='SMTP Server' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203525)
;

-- Jul 20, 2021, 8:19:40 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,AD_Process_ID) VALUES (214556,0,'EMail Test','Test EMail',200280,'EMailTest',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_DATE('2021-07-20 08:19:40','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:19:40','YYYY-MM-DD HH24:MI:SS'),0,2806,'Y','N','D','N','N','N','Y','cb98c7f6-e9c2-4bcc-8004-15686e1cc871','Y',0,'Y','N','N',327)
;

-- Jul 20, 2021, 8:19:50 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214557,0,'SMTP SSL/TLS','Use SSL/TLS for SMTP',200280,'IsSecureSMTP','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-07-20 08:19:49','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:19:49','YYYY-MM-DD HH24:MI:SS'),0,200171,'Y','N','U','N','N','N','Y','0e07e4f8-9068-4ccf-9ce2-d509f5700834','Y',0,'N','N','N')
;

-- Jul 20, 2021, 8:19:55 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214558,0,'SMTP Authentication','Your mail server requires Authentication','Some email servers require authentication before sending emails.  If yes, users are required to define their email user name and password.  If authentication is required and no user name and password is required, delivery will fail.',200280,'IsSmtpAuthorization','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-07-20 08:19:55','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:19:55','YYYY-MM-DD HH24:MI:SS'),0,1898,'Y','N','U','N','N','N','Y','f2b2e9f9-625c-46e5-9d64-2ba1cd681b92','Y',0,'N','N','N')
;

-- Jul 20, 2021, 8:20:06 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214559,0,'Request User','User Name (ID) of the email owner','EMail user name for requests, alerts and escalation are sent from this email address as well as delivery information if the sales rep does not have an email account. Required, if your mail server requires authentification as well as for processing incoming mails.',200280,'RequestUser',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-07-20 08:20:06','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:20:06','YYYY-MM-DD HH24:MI:SS'),0,1700,'Y','N','D','N','N','N','Y','f0d3ea5a-337b-4d83-bf8b-a6ec24bf79d6','Y',0,'N','N','N')
;

-- Jul 20, 2021, 8:20:13 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214560,0,'Request User Password','Password of the user name (ID) for mail processing',200280,'RequestUserPW',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-07-20 08:20:13','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:20:13','YYYY-MM-DD HH24:MI:SS'),0,1701,'Y','N','D','N','N','N','Y','4d247dca-ba8f-4317-8ce8-56dfbe1162e7','Y',0,'N','N','N')
;

-- Jul 20, 2021, 8:20:39 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214561,0,'Mail Host','Hostname of Mail Server for SMTP and IMAP','The host name of the Mail Server for this client with SMTP services to send mail, and IMAP to process incoming mail.',200280,'SMTPHost',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-07-20 08:20:38','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:20:38','YYYY-MM-DD HH24:MI:SS'),0,1253,'Y','N','D','N','N','N','Y','8b6cac01-c49d-46df-b937-276ffe868c82','Y',0,'N','N','N')
;

-- Jul 20, 2021, 8:20:46 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214562,0,'SMTP Port','SMTP Port Number',200280,'SMTPPort',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_DATE('2021-07-20 08:20:45','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:20:45','YYYY-MM-DD HH24:MI:SS'),0,200170,'Y','N','D','N','N','N','Y','4523d5ec-1ab4-4e86-b80d-5752a84648ef','Y',0,'N','N','N')
;

-- Jul 20, 2021, 8:21:06 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203527,0,0,'Y',TO_DATE('2021-07-20 08:20:53','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:20:53','YYYY-MM-DD HH24:MI:SS'),0,'UsedByEmailOrDomain','Used by email or domain',NULL,NULL,'Used by email or domain','D','a1d45340-7b37-4a20-aecb-7520ed02e32c')
;

-- Jul 20, 2021, 8:21:23 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214563,0,'Used by email or domain',200280,'UsedByEmailOrDomain',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-07-20 08:21:23','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:21:23','YYYY-MM-DD HH24:MI:SS'),0,203527,'Y','N','D','N','N','N','Y','c7a8c6bb-a7da-48d2-8b8b-40d07a3acb2d','Y',0,'N','N','N','N')
;

-- Jul 20, 2021, 8:21:35 AM CEST
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2021-07-20 08:21:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214557
;

-- Jul 20, 2021, 8:21:38 AM CEST
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2021-07-20 08:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214558
;

-- Jul 20, 2021, 8:21:47 AM CEST
CREATE TABLE AD_SMTP (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) DEFAULT 0 NOT NULL, AD_SMTP_ID NUMBER(10) NOT NULL, AD_SMTP_UU VARCHAR2(36 CHAR) DEFAULT NULL , Created DATE DEFAULT SYSDATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, EMailTest CHAR(1) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsSecureSMTP CHAR(1) DEFAULT 'N' CHECK (IsSecureSMTP IN ('Y','N')) NOT NULL, IsSmtpAuthorization CHAR(1) DEFAULT 'N' CHECK (IsSmtpAuthorization IN ('Y','N')) NOT NULL, Name VARCHAR2(60 CHAR) NOT NULL, RequestUser VARCHAR2(60 CHAR) DEFAULT NULL , RequestUserPW VARCHAR2(255 CHAR) DEFAULT NULL , SMTPHost VARCHAR2(60 CHAR) DEFAULT NULL , SMTPPort NUMBER(10) DEFAULT NULL , Updated DATE DEFAULT SYSDATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, UsedByEmailOrDomain VARCHAR2(255 CHAR) DEFAULT NULL , CONSTRAINT AD_SMTP_Key PRIMARY KEY (AD_SMTP_ID), CONSTRAINT AD_SMTP_UU_idx UNIQUE (AD_SMTP_UU))
;

-- Jul 20, 2021, 8:22:35 AM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200118,'SMTP Server',0,0,'Y',TO_DATE('2021-07-20 08:22:34','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:22:34','YYYY-MM-DD HH24:MI:SS'),0,'M','N','D','Y','N',0,0,'N','5e08444e-edc9-40e0-8f12-b71bdd4111b2')
;

-- Jul 20, 2021, 8:23:15 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200298,'SMTP Server',200118,10,'Y',200280,0,0,'Y',TO_DATE('2021-07-20 08:23:15','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:15','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N','N','N','N',0,'N','D','Y','N','bdf27ca5-26af-456d-a647-6bad3d5cad38','B','N','Y',0)
;

-- Jul 20, 2021, 8:23:17 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206720,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200298,214546,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:16','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:16','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','661b348f-a5fe-41e4-a472-12656f43ed5e','N',2)
;

-- Jul 20, 2021, 8:23:17 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206721,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200298,214547,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:17','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:17','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','a1ac54dc-7dcd-46a4-a88a-a028d7ad104f','Y','Y',10,4,2)
;

-- Jul 20, 2021, 8:23:17 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206722,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200298,214551,'Y',60,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:17','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:17','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','1fcc6ba4-057c-420c-b6a6-bb7c97f7251b','Y',20,5)
;

-- Jul 20, 2021, 8:23:18 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206723,'SMTP Server',200298,214554,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:17','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:17','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','02d61fa8-7161-4b5a-931e-3e05f82a33f4','N',2)
;

-- Jul 20, 2021, 8:23:18 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206724,'AD_SMTP_UU',200298,214555,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:18','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:18','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','8027793c-398f-46fd-a8f7-9edce0a744ce','N',2)
;

-- Jul 20, 2021, 8:23:18 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206725,'EMail Test','Test EMail',200298,214556,'Y',1,40,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:18','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:18','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','f873fbec-85b5-4913-bf0d-8ca6893a102f','Y',30,2,2)
;

-- Jul 20, 2021, 8:23:19 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206726,'SMTP SSL/TLS','Use SSL/TLS for SMTP',200298,214557,'Y',1,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:18','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:18','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','e41c22d0-fa66-439c-8c10-f1a1cd315208','Y',40,2,2)
;

-- Jul 20, 2021, 8:23:19 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206727,'SMTP Authentication','Your mail server requires Authentication','Some email servers require authentication before sending emails.  If yes, users are required to define their email user name and password.  If authentication is required and no user name and password is required, delivery will fail.',200298,214558,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:19','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:19','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','d4c07dc2-404e-477a-8389-6fbf98155aae','Y',50,2,2)
;

-- Jul 20, 2021, 8:23:19 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206728,'Request User','User Name (ID) of the email owner','EMail user name for requests, alerts and escalation are sent from this email address as well as delivery information if the sales rep does not have an email account. Required, if your mail server requires authentification as well as for processing incoming mails.',200298,214559,'Y',60,70,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:19','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:19','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','07e96818-ea11-4b98-8963-e3535381f08f','Y',60,5)
;

-- Jul 20, 2021, 8:23:20 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206729,'Request User Password','Password of the user name (ID) for mail processing',200298,214560,'Y',255,80,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:19','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:19','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','56da641e-33cf-44bd-a07b-227bd16a22cf','Y',70,5)
;

-- Jul 20, 2021, 8:23:20 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206730,'Mail Host','Hostname of Mail Server for SMTP and IMAP','The host name of the Mail Server for this client with SMTP services to send mail, and IMAP to process incoming mail.',200298,214561,'Y',60,90,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:20','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:20','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','f87e5013-9b8c-4536-9766-d51fa5d0dc64','Y',80,5)
;

-- Jul 20, 2021, 8:23:20 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206731,'SMTP Port','SMTP Port Number',200298,214562,'Y',10,100,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:20','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:20','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','2a064c38-a454-48b1-a238-bc3a45234ab1','Y',90,2)
;

-- Jul 20, 2021, 8:23:20 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206732,'Used by email or domain',200298,214563,'Y',255,110,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:20','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:20','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','0cd1cffd-9570-43ff-b40f-25de04997618','Y',100,5)
;

-- Jul 20, 2021, 8:23:21 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206733,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200298,214550,'Y',1,120,'N','N','N','N',0,0,'Y',TO_DATE('2021-07-20 08:23:20','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:23:20','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','b40f1eaa-b099-48fe-bd10-461a81e98426','Y',110,2,2)
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206722
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206733
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206730
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206727
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206731
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206726
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206728
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206729
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206732
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206724
;

-- Jul 20, 2021, 8:24:18 AM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206723
;

-- Jul 20, 2021, 8:24:26 AM CEST
UPDATE AD_Column SET IsToolbarButton='N',Updated=TO_DATE('2021-07-20 08:24:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214556
;

-- Jul 20, 2021, 8:24:48 AM CEST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206733
;

-- Jul 20, 2021, 8:24:48 AM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206730
;

-- Jul 20, 2021, 8:24:48 AM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206727
;

-- Jul 20, 2021, 8:24:48 AM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206731
;

-- Jul 20, 2021, 8:24:48 AM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206726
;

-- Jul 20, 2021, 8:24:48 AM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206728
;

-- Jul 20, 2021, 8:24:48 AM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206729
;

-- Jul 20, 2021, 8:24:48 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206732
;

-- Jul 20, 2021, 8:24:48 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-07-20 08:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206725
;

-- Jul 20, 2021, 8:25:08 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200195,'SMTP Server','W',200118,0,0,'Y',TO_DATE('2021-07-20 08:25:08','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 08:25:08','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','N','D','Y','b160c2f4-694d-46bc-87c9-47e5a6a6ec87')
;

-- Jul 20, 2021, 8:25:08 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 0, getDate(), 0,t.AD_Tree_ID, 200195, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200195)
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=0, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=334
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=1, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=498
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=2, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=224
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=3, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=145
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=4, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200176
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=5, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=336
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=6, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=341
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=7, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=144
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=8, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=170
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=9, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=465
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=10, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200137
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=11, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=101
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=12, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=294
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=13, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=395
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=14, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=296
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=15, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=221
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=16, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=233
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=17, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=290
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=18, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=109
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=19, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200093
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=20, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=50008
;

-- Jul 20, 2021, 8:28:16 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=21, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200195
;

-- Jul 20, 2021, 8:29:07 AM CEST
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206720
;

-- Jul 20, 2021, 8:29:07 AM CEST
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206721
;

-- Jul 20, 2021, 8:29:07 AM CEST
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206722
;

-- Jul 20, 2021, 8:29:07 AM CEST
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206730
;

-- Jul 20, 2021, 8:29:07 AM CEST
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206731
;

-- Jul 20, 2021, 8:29:07 AM CEST
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206726
;

-- Jul 20, 2021, 8:29:07 AM CEST
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206727
;

-- Jul 20, 2021, 8:29:07 AM CEST
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206728
;

-- Jul 20, 2021, 8:29:07 AM CEST
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206729
;

-- Jul 20, 2021, 8:29:07 AM CEST
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=0 WHERE AD_Field_ID=206725
;

-- Sep 17, 2021, 2:41:31 PM CEST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_DATE('2021-09-17 14:41:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200280
;

-- Sep 17, 2021, 3:21:51 PM CEST
UPDATE AD_Column SET IsAllowLogging='N', IsSecure='Y',Updated=TO_DATE('2021-09-17 15:21:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214560
;

-- Sep 17, 2021, 3:21:56 PM CEST
UPDATE AD_Field SET IsEncrypted='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-17 15:21:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206729
;

SELECT Register_Migration_Script ('202107200830_IDEMPIERE-4866.sql') FROM DUAL
;
