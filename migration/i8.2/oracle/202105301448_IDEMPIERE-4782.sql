SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4782 Multi-factor authentication (FHCA-2034)
-- May 30, 2021, 2:44:22 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200184,'Multi Factor Authentication',0,0,'Y',TO_DATE('2021-05-30 14:44:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:21','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','N','D','N','c40cde28-5062-4990-89e1-187e9991ee68')
;

-- May 30, 2021, 2:44:22 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 0,15, 10, 200184)
;

-- May 30, 2021, 2:44:22 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200129,0,0,'Y',TO_DATE('2021-05-30 14:44:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:22','YYYY-MM-DD HH24:MI:SS'),100,'Unregister MFA Mechanism','Unregister a multi-factor authentication registration','N','MFAUnregister','N','org.idempiere.process.MFAUnregister','7','D',0,0,'N','Y','N','69f1a324-48dd-46be-ba96-0a6a7606dd4d','P')
;

-- May 30, 2021, 2:44:23 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203487,0,0,'Y',TO_DATE('2021-05-30 14:44:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:22','YYYY-MM-DD HH24:MI:SS'),100,'MFA_Registration_ID','MFA Registration','MFA Registration','D','828f84d2-2a9c-4002-bd8e-9b447181699f')
;

-- May 30, 2021, 2:44:23 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200343,0,0,'Y',TO_DATE('2021-05-30 14:44:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:23','YYYY-MM-DD HH24:MI:SS'),100,'MFA Registration',200129,10,19,'N',22,'Y','MFA_Registration_ID','Y','D',203487,'48527fb9-5623-4dc2-9383-e29f22e5e709','N','N')
;

-- May 30, 2021, 2:44:23 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200130,0,0,'Y',TO_DATE('2021-05-30 14:44:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:23','YYYY-MM-DD HH24:MI:SS'),100,'Complete MFA Registration','Complete a registration for a multi-factor authentication mechanism','N','MFACompleteRegistration','N','org.idempiere.process.MFACompleteRegistration','7','D',15,101,'N','Y','N','8f788304-5bcb-4a5d-af28-11b56923995b','P')
;

-- May 30, 2021, 2:44:24 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200149,'MFA_Registration - Pending to Complete','S','MFA_Registration.IsValid=''N'' AND MFA_Registration.IsActive=''Y''',0,0,'Y',TO_DATE('2021-05-30 14:44:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:23','YYYY-MM-DD HH24:MI:SS'),100,'D','195ee644-3a97-4f53-a903-117a3975ea61')
;

-- May 30, 2021, 2:44:24 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200344,0,0,'Y',TO_DATE('2021-05-30 14:44:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:24','YYYY-MM-DD HH24:MI:SS'),100,'MFA Registration',200130,10,18,'N',200149,22,'Y','MFA_Registration_ID','Y','D',203487,'60c97d2a-d429-4272-a218-c5dc33bb6200','N','N')
;

-- May 30, 2021, 2:44:24 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203488,0,0,'Y',TO_DATE('2021-05-30 14:44:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:24','YYYY-MM-DD HH24:MI:SS'),100,'MFAValidationCode','Validation Code','Validation Code','D','7e4caab2-1095-4996-8d00-e5fa7e7917c5')
;

-- May 30, 2021, 2:44:25 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200345,0,0,'Y',TO_DATE('2021-05-30 14:44:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:24','YYYY-MM-DD HH24:MI:SS'),100,'Validation Code',200130,20,10,'N',2000,'Y','MFAValidationCode','Y','D',203488,'b4242496-e7b5-4806-98da-e27861884487','N','N')
;

-- May 30, 2021, 2:44:25 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200346,0,0,'Y',TO_DATE('2021-05-30 14:44:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:25','YYYY-MM-DD HH24:MI:SS'),100,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200130,30,10,'N',60,'N','Name','Y','D',469,'40f4aaf0-4315-4d49-b7b2-65dc50aaa65d','N','N')
;

-- May 30, 2021, 2:44:25 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203489,0,0,'Y',TO_DATE('2021-05-30 14:44:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:25','YYYY-MM-DD HH24:MI:SS'),100,'IsUserMFAPreferred','Preferred','Preferred','D','aa3d11ca-e0bf-4e0d-985c-ebba224c048c')
;

-- May 30, 2021, 2:44:26 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200347,0,0,'Y',TO_DATE('2021-05-30 14:44:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:25','YYYY-MM-DD HH24:MI:SS'),100,'Preferred',200130,40,20,'N',1,'Y','N','IsUserMFAPreferred','Y','D',203489,'583697b4-1448-414d-bfd8-c1ce9aef65d7','N','N')
;

-- May 30, 2021, 2:44:26 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,Description,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200114,'MFA Method','Multi-factor Authentication Method',0,0,'Y',TO_DATE('2021-05-30 14:44:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:26','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','a23a7b83-7c8f-4fdd-8417-17cb06d078f1')
;

-- May 30, 2021, 2:44:26 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200273,'MFA Method','Multi-factor Authentication Method',200114,'MFA_Method',0,'4',0,0,'Y',TO_DATE('2021-05-30 14:44:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','52a472cb-eb8a-4a3e-a0f4-5631a0e564c2','N','N','N','N')
;

-- May 30, 2021, 2:44:27 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('MFA_Method',1000000,'N','N','Table MFA_Method','Y','Y',0,0,TO_DATE('2021-05-30 14:44:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:27','YYYY-MM-DD HH24:MI:SS'),100,200342,'Y',1000000,1,200000,'d2bc703d-8b95-4e07-bd97-166f4b33ac84')
;

-- May 30, 2021, 2:44:27 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203490,0,0,'Y',TO_DATE('2021-05-30 14:44:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:27','YYYY-MM-DD HH24:MI:SS'),100,'MFA_Method_ID','MFA Method','Multi-factor Authentication Method','MFA Method','D','948b99e9-b928-4fca-b57f-660cbd9d9a22')
;

-- May 30, 2021, 2:44:28 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214429,1,'MFA Method','Multi-factor Authentication Method',200273,'MFA_Method_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_DATE('2021-05-30 14:44:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:27','YYYY-MM-DD HH24:MI:SS'),100,203490,'N','N','D','Y','N','N','Y','d98419f9-35b5-4232-9ef1-3589dab0ed49','N','N','N','N','N')
;

-- May 30, 2021, 2:44:28 PM CEST
CREATE TABLE MFA_Method (MFA_Method_ID NUMBER(10) NOT NULL, CONSTRAINT MFA_Method_Key PRIMARY KEY (MFA_Method_ID))
;

-- May 30, 2021, 2:44:28 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214430,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200273,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:44:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:28','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','0af99da2-d540-4b44-8528-c9f319f86dfc','N','N','N','D','N')
;

-- May 30, 2021, 2:44:28 PM CEST
ALTER TABLE MFA_Method ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:44:28 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214431,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200273,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:44:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:28','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','4eaef723-4c38-47b6-a857-0ee776cadb43','N','N','N','D','N')
;

-- May 30, 2021, 2:44:28 PM CEST
ALTER TABLE MFA_Method ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:44:28 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214432,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200273,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:44:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:28','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','ade4c655-7810-43b6-827b-f522b0144ac3','N','N','N','N','N')
;

-- May 30, 2021, 2:44:29 PM CEST
ALTER TABLE MFA_Method ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- May 30, 2021, 2:44:29 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214433,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200273,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_DATE('2021-05-30 14:44:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:29','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','5dd143de-8630-403c-8e59-23af5b48c76c','N','N','N','D','N')
;

-- May 30, 2021, 2:44:29 PM CEST
ALTER TABLE MFA_Method ADD CreatedBy NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:44:29 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214434,1,'Description','Optional short description of the record','A description is limited to 255 characters.',200273,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-05-30 14:44:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:29','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','8b767dc0-1c41-40f8-8ccf-7c45f893b06b','Y',10,'N','N','N','N')
;

-- May 30, 2021, 2:44:29 PM CEST
ALTER TABLE MFA_Method ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:44:30 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214435,1,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200273,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2021-05-30 14:44:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:29','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','07e2d516-3c1a-4a72-a6f1-2abaa73151c9','Y','N','N','N','N')
;

-- May 30, 2021, 2:44:30 PM CEST
ALTER TABLE MFA_Method ADD Help VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:44:30 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214436,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200273,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-05-30 14:44:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:30','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','fedeb044-8209-44c2-b937-395b8006556f','N','N','N','N','N')
;

-- May 30, 2021, 2:44:30 PM CEST
ALTER TABLE MFA_Method ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- May 30, 2021, 2:44:30 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203491,0,0,'Y',TO_DATE('2021-05-30 14:44:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:30','YYYY-MM-DD HH24:MI:SS'),100,'MFA_Method_UU','MFA_Method_UU','MFA_Method_UU','D','74581244-f581-417e-a0d5-9deb86914bd6')
;

-- May 30, 2021, 2:44:31 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214437,1.00,'MFA_Method_UU',200273,'MFA_Method_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2021-05-30 14:44:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:30','YYYY-MM-DD HH24:MI:SS'),100,203491,'Y','N','D','Y','N','N','Y','225f76bb-131a-49dc-9e52-cd715cdf3fb7','N','N','N','N','N')
;

-- May 30, 2021, 2:44:31 PM CEST
ALTER TABLE MFA_Method ADD MFA_Method_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:44:31 PM CEST
ALTER TABLE MFA_Method ADD CONSTRAINT MFA_Method_UU_idx UNIQUE (MFA_Method_UU)
;

-- May 30, 2021, 2:44:31 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214438,1,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200273,'Name',60,'N','N','Y','N','Y',1,'N',10,0,0,'Y',TO_DATE('2021-05-30 14:44:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:31','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','Y','N','N','Y','9bd6de21-f93a-468d-a9ec-5e9dec166aa2','Y',20,'N','N','N','N')
;

-- May 30, 2021, 2:44:31 PM CEST
ALTER TABLE MFA_Method ADD Name VARCHAR2(60 CHAR) NOT NULL
;

-- May 30, 2021, 2:44:31 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214439,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200273,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:44:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:31','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','c239ccb4-c6df-4669-97cd-81c11f4bd4a2','N','N','N','N','N')
;

-- May 30, 2021, 2:44:31 PM CEST
ALTER TABLE MFA_Method ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- May 30, 2021, 2:44:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214440,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200273,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_DATE('2021-05-30 14:44:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:31','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','c77bab50-72c6-4323-9192-18488156171e','N','N','N','D','N')
;

-- May 30, 2021, 2:44:32 PM CEST
ALTER TABLE MFA_Method ADD UpdatedBy NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:44:32 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200187,'MFA_Method','L',0,0,'Y',TO_DATE('2021-05-30 14:44:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:32','YYYY-MM-DD HH24:MI:SS'),100,'D','N','6d3d1f40-0e38-4adf-93d6-b1bb2c44e93c')
;

-- May 30, 2021, 2:44:32 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200507,'Time-Based One-Time Password',200187,'TOTP',0,0,'Y',TO_DATE('2021-05-30 14:44:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:32','YYYY-MM-DD HH24:MI:SS'),100,'D','9c6b8ffe-5d00-40d3-a511-d61238602654')
;

-- May 30, 2021, 2:44:33 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200508,'EMail',200187,'EMail',0,0,'Y',TO_DATE('2021-05-30 14:44:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:32','YYYY-MM-DD HH24:MI:SS'),100,'D','45a33854-e3bd-407b-bda5-ff48e58a2eea')
;

-- May 30, 2021, 2:44:33 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214441,0,'Method',200273,'Method',60,'N','N','Y','N','N',0,'N',17,200187,0,0,'Y',TO_DATE('2021-05-30 14:44:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:33','YYYY-MM-DD HH24:MI:SS'),100,200239,'Y','N','D','Y','N','N','Y','ed1f244e-22d4-4606-addd-e4855adeb8a7','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:44:33 PM CEST
ALTER TABLE MFA_Method ADD Method VARCHAR2(60 CHAR) NOT NULL
;

-- May 30, 2021, 2:44:34 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203492,0,0,'Y',TO_DATE('2021-05-30 14:44:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:33','YYYY-MM-DD HH24:MI:SS'),100,'MFAType','MFA Type','Multi-factor authentication type (Something you Know/Have/Are, Location)','MFA Type','D','8ac35e88-dfeb-4103-8ea8-f2ae4d7fe3c2')
;

-- May 30, 2021, 2:44:34 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200188,'MFAType','L',0,0,'Y',TO_DATE('2021-05-30 14:44:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:34','YYYY-MM-DD HH24:MI:SS'),100,'D','N','c1fc1d9c-6b42-45e9-a9d1-67aa9a8e77f1')
;

-- May 30, 2021, 2:44:34 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200510,'Something you Know',200188,'K',0,0,'Y',TO_DATE('2021-05-30 14:44:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:34','YYYY-MM-DD HH24:MI:SS'),100,'D','dad0212a-776c-476f-8ee1-f36d223b9899')
;

-- May 30, 2021, 2:44:35 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200511,'Something you Have',200188,'H',0,0,'Y',TO_DATE('2021-05-30 14:44:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:34','YYYY-MM-DD HH24:MI:SS'),100,'D','e9f47e72-2282-4363-aaf2-5decec4d390b')
;

-- May 30, 2021, 2:44:35 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200512,'Something you Are (Biometrics)',200188,'A',0,0,'Y',TO_DATE('2021-05-30 14:44:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:35','YYYY-MM-DD HH24:MI:SS'),100,'D','032e4006-0523-4f4b-bd01-50345a2476e5')
;

-- May 30, 2021, 2:44:35 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200513,'Location',200188,'L',0,0,'Y',TO_DATE('2021-05-30 14:44:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:35','YYYY-MM-DD HH24:MI:SS'),100,'D','3c49620f-54d9-41cf-94a9-9c951f1ab271')
;

-- May 30, 2021, 2:44:36 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214442,0,'MFA Type','Multi-factor authentication type (Something you Know/Have/Are, Location)',200273,'MFAType',1,'N','N','N','N','N',0,'N',17,200188,0,0,'Y',TO_DATE('2021-05-30 14:44:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:35','YYYY-MM-DD HH24:MI:SS'),100,203492,'Y','N','D','Y','N','N','Y','0a1e1c0f-4b22-4638-b03a-82fba98f65f6','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:44:36 PM CEST
ALTER TABLE MFA_Method ADD MFAType CHAR(1) DEFAULT NULL 
;

-- May 30, 2021, 2:44:36 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203493,0,0,'Y',TO_DATE('2021-05-30 14:44:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:36','YYYY-MM-DD HH24:MI:SS'),100,'MFAIssuer','Issuer','Issuer','D','4b7bdf09-91b0-4cac-be32-3b2ed8b3124a')
;

-- May 30, 2021, 2:44:36 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214443,0,'Issuer',200273,'MFAIssuer',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-05-30 14:44:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:36','YYYY-MM-DD HH24:MI:SS'),100,203493,'Y','N','D','Y','N','N','Y','19519991-f0b8-435d-bc36-595265244cbd','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:44:36 PM CEST
ALTER TABLE MFA_Method ADD MFAIssuer VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:44:37 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203494,0,0,'Y',TO_DATE('2021-05-30 14:44:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:36','YYYY-MM-DD HH24:MI:SS'),100,'MFAAllowedTimeDiscrepancy','Allowed Time Period Discrepancy','Allowed Time Period Discrepancy','D','5aab867e-1e0c-4e50-93d0-bf3a9a37c5e8')
;

-- May 30, 2021, 2:44:37 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214444,0,'Allowed Time Period Discrepancy',200273,'MFAAllowedTimeDiscrepancy',14,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_DATE('2021-05-30 14:44:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:37','YYYY-MM-DD HH24:MI:SS'),100,203494,'Y','N','D','Y','N','N','Y','64c621a3-580a-4d16-85c6-7429ab6147dd','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:44:37 PM CEST
ALTER TABLE MFA_Method ADD MFAAllowedTimeDiscrepancy NUMBER(10) DEFAULT NULL 
;

-- May 30, 2021, 2:44:37 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203495,0,0,'Y',TO_DATE('2021-05-30 14:44:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:37','YYYY-MM-DD HH24:MI:SS'),100,'MFATimeProvider','Time Provider','Time Provider','D','6e641fb6-95cc-4b6b-b547-45f17ad220af')
;

-- May 30, 2021, 2:44:38 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200189,'MFATimeProvider','L',0,0,'Y',TO_DATE('2021-05-30 14:44:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:37','YYYY-MM-DD HH24:MI:SS'),100,'D','N','0c6758f4-b113-4ebc-91e9-0de6c565c139')
;

-- May 30, 2021, 2:44:38 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200514,'System',200189,'S',0,0,'Y',TO_DATE('2021-05-30 14:44:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:38','YYYY-MM-DD HH24:MI:SS'),100,'D','bee8e82d-d76d-4c8e-8290-d5a25f59a08f')
;

-- May 30, 2021, 2:44:38 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200515,'Ntp',200189,'N',0,0,'Y',TO_DATE('2021-05-30 14:44:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:38','YYYY-MM-DD HH24:MI:SS'),100,'D','4e72ac53-5c98-44dc-bf2e-72d36c221399')
;

-- May 30, 2021, 2:44:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214445,0,'Time Provider',200273,'MFATimeProvider',1,'N','N','N','N','N',0,'N',17,200189,0,0,'Y',TO_DATE('2021-05-30 14:44:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:38','YYYY-MM-DD HH24:MI:SS'),100,203495,'Y','N','D','Y','N','N','Y','1294116a-1119-4d76-a543-757d9fb9e902','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:44:39 PM CEST
ALTER TABLE MFA_Method ADD MFATimeProvider CHAR(1) DEFAULT NULL 
;

-- May 30, 2021, 2:44:39 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203496,0,0,'Y',TO_DATE('2021-05-30 14:44:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:39','YYYY-MM-DD HH24:MI:SS'),100,'MFATimeServer','Time Server','Time Server','D','15fea993-88bc-4911-af5d-4c5145649a8e')
;

-- May 30, 2021, 2:44:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214446,0,'Time Server',200273,'MFATimeServer',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-05-30 14:44:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:39','YYYY-MM-DD HH24:MI:SS'),100,203496,'Y','N','D','Y','N','N','Y','b81a2e75-550a-41d6-a635-94f6890dd50c','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:44:39 PM CEST
ALTER TABLE MFA_Method ADD MFATimeServer VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:44:40 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203497,0,0,'Y',TO_DATE('2021-05-30 14:44:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:39','YYYY-MM-DD HH24:MI:SS'),100,'ExpireInMinutes','Expire in Minutes','Expire in Minutes','D','e57c156c-7823-4cba-9658-b4ef76f5288f')
;

-- May 30, 2021, 2:44:40 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214447,0,'Expire in Minutes',200273,'ExpireInMinutes',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_DATE('2021-05-30 14:44:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:40','YYYY-MM-DD HH24:MI:SS'),100,203497,'Y','N','D','Y','N','N','Y','cb8ddae6-cd0b-41a1-a5d1-cc7f3abed025','Y',0,'N','N','N')
;

-- May 30, 2021, 2:44:40 PM CEST
ALTER TABLE MFA_Method ADD ExpireInMinutes NUMBER(10) DEFAULT NULL 
;

-- May 30, 2021, 2:44:40 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214448,0,'Mail Template','Text templates for mailings','The Mail Template indicates the mail template for return messages. Mail text can include variables.  The priority of parsing is User/Contact, Business Partner and then the underlying business object (like Request, Dunning, Workflow object).<br>
So, @Name@ would resolve into the User name (if user is defined defined), then Business Partner name (if business partner is defined) and then the Name of the business object if it has a Name.<br>
For Multi-Lingual systems, the template is translated based on the Business Partner''s language selection.',200273,'R_MailText_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:44:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:40','YYYY-MM-DD HH24:MI:SS'),100,1515,'Y','N','D','Y','N','N','Y','c14d9d08-e4ab-4e94-b89f-4f83e6611abd','Y',0,'N','N','RMailText_MFAMethod','N','N')
;

-- May 30, 2021, 2:44:40 PM CEST
ALTER TABLE MFA_Method ADD R_MailText_ID NUMBER(10) DEFAULT NULL 
;

-- May 30, 2021, 2:44:41 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203498,0,0,'Y',TO_DATE('2021-05-30 14:44:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:40','YYYY-MM-DD HH24:MI:SS'),100,'MFA_ElementPrm_ID','Parameter Element','Parameter Element','D','811fb12c-863b-48cd-83bd-e5add686b638')
;

-- May 30, 2021, 2:44:41 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200190,'AD_Element','T',0,0,'Y',TO_DATE('2021-05-30 14:44:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:41','YYYY-MM-DD HH24:MI:SS'),100,'D','N','3a119c73-263b-4f8b-b45c-33d25562a1d2')
;

-- May 30, 2021, 2:44:41 PM CEST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200190,276,2594,2603,0,0,'Y',TO_DATE('2021-05-30 14:44:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:41','YYYY-MM-DD HH24:MI:SS'),100,'N','D','6463365d-a1b0-47f7-8cf6-553dcc50acc2')
;

-- May 30, 2021, 2:44:41 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214449,0,'Parameter Element',200273,'MFA_ElementPrm_ID',10,'N','N','N','N','N',0,'N',30,200190,0,0,'Y',TO_DATE('2021-05-30 14:44:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:41','YYYY-MM-DD HH24:MI:SS'),100,203498,'Y','N','D','Y','N','N','Y','40200045-c6ad-4658-95f0-9e4de2f78fc2','Y',0,'N','N','MFAElementPrm_MFAMethod','N','N')
;

-- May 30, 2021, 2:44:42 PM CEST
ALTER TABLE MFA_Method ADD MFA_ElementPrm_ID NUMBER(10) DEFAULT NULL 
;

-- May 30, 2021, 2:44:42 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200288,'MFA Method','Multi-factor Authentication Method',200114,10,'Y',200273,0,0,'Y',TO_DATE('2021-05-30 14:44:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:42','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','MFA_Method.Name','N',0,'N','D','Y','N','9306f3ac-9af6-4e1e-aeff-a48e90e9301b','B','N','Y',0)
;

-- May 30, 2021, 2:44:42 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206611,'MFA_Method_UU',200288,214437,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a8bf5eaa-a374-460f-ab88-0a0106bb0c68','N',1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206612,'MFA Method','Multi-factor Authentication Method',200288,214429,'N',22,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','868bed40-7adc-48e0-a2a2-1095fde13fdb','N',1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206613,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200288,214430,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','13f7107c-77be-4b5e-8c90-3871f6b019f9','N',1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206614,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200288,214431,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9ffd36e7-096e-4275-bad6-85de7671b77c','Y','N',4,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206615,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200288,214438,'Y',60,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dee34ab4-1a66-4ea5-991f-7ad8c46170bd','Y',10,1,5,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206616,'Description','Optional short description of the record','A description is limited to 255 characters.',200288,214434,'Y',255,40,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1e5db2b3-4703-4b51-a9cf-cdca64392016','Y',20,1,5,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206617,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200288,214435,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d841cff6-25dc-4bab-8ae0-fba6aa6eb067','Y',30,1,5,3,'N','N','N','N')
;

-- May 30, 2021, 2:44:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206618,'Method',200288,214441,'Y',60,60,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','514a9741-e739-46b2-ab07-977c81278bb9','Y',40,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206619,'MFA Type','Multi-factor authentication type (Something you Know/Have/Are, Location)',200288,214442,'Y',1,70,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','18e94064-2604-4fda-b3dd-1c4375d47cc6','Y',50,4,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206620,'Parameter Element',200288,214449,'Y',10,80,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','301a64c6-09a9-4f60-8f60-b978f565191f','Y',190,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206621,'Expire in Minutes',200288,214447,'Y',10,90,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e778e00d-e130-4b30-ab79-912fa45295bc','Y',170,4,1,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:46 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206622,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200288,214436,'Y',1,100,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3126acb5-db24-47cf-b2f7-d3d6e4e45ba0','Y',70,6,1,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:46 PM CEST
INSERT INTO AD_FieldGroup (AD_FieldGroup_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,EntityType,FieldGroupType,IsCollapsedByDefault,AD_FieldGroup_UU) VALUES (200027,0,0,'Y',TO_DATE('2021-05-30 14:44:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:46','YYYY-MM-DD HH24:MI:SS'),100,'EMail','D','C','N','2779dca5-1eb8-421c-a8ff-73fcebaf1324')
;

-- May 30, 2021, 2:44:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206623,'Mail Template','Text templates for mailings','The Mail Template indicates the mail template for return messages. Mail text can include variables.  The priority of parsing is User/Contact, Business Partner and then the underlying business object (like Request, Dunning, Workflow object).<br>
So, @Name@ would resolve into the User name (if user is defined defined), then Business Partner name (if business partner is defined) and then the Name of the business object if it has a Name.<br>
For Multi-Lingual systems, the template is translated based on the Business Partner''s language selection.',200288,214448,'Y',10,110,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',200027,'D','e1785367-c587-443c-bcd5-9e6bbef4b31e','Y',180,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:47 PM CEST
INSERT INTO AD_FieldGroup (AD_FieldGroup_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,EntityType,FieldGroupType,IsCollapsedByDefault,AD_FieldGroup_UU) VALUES (200028,0,0,'Y',TO_DATE('2021-05-30 14:44:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:47','YYYY-MM-DD HH24:MI:SS'),100,'TOTP','D','C','N','659d859f-1cb2-4157-ab2e-eb62fd04c23b')
;

-- May 30, 2021, 2:44:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206624,'Issuer',200288,214443,'Y',2000,120,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',200028,'D','5dc13f32-8ca0-4132-a7c9-dec2935dc3dc','Y',80,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206625,'Allowed Time Period Discrepancy',200288,214444,'Y',14,130,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f133bfc6-75a8-483f-b99e-9df797f9e26e','Y',130,4,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:48 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206626,'Time Provider',200288,214445,'Y',1,150,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','050eeafe-e41b-4289-8970-940852612cdc','Y',140,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:48 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206627,'Time Server',200288,214446,'Y','@MFATimeProvider@=N',255,160,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','04369763-05e6-4f1a-b20e-39ee9d4b0e60','Y',160,4,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:48 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200131,0,0,'Y',TO_DATE('2021-05-30 14:44:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:48','YYYY-MM-DD HH24:MI:SS'),100,'Revoke MFA Trusted Device','Revoke one multi-factor authentication trusted device or all','N','MFARevokeDevice','N','org.idempiere.process.MFARevokeDevice','7','D',0,0,'N','Y','N','b009ee88-78dd-4adf-97ff-8847464d0bf7','P')
;

-- May 30, 2021, 2:44:49 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203499,0,0,'Y',TO_DATE('2021-05-30 14:44:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:48','YYYY-MM-DD HH24:MI:SS'),100,'MFARevokeAll','Revoke All','Revoke All','D','ade34ca8-4a79-4b67-8d99-c32d5a290def')
;

-- May 30, 2021, 2:44:49 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200348,0,0,'Y',TO_DATE('2021-05-30 14:44:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:49','YYYY-MM-DD HH24:MI:SS'),100,'Revoke All',200131,10,20,'N',1,'Y','N','MFARevokeAll','Y','D',203499,'162304fb-2d23-4c38-ae15-889ffa0b7ff3','N','N')
;

-- May 30, 2021, 2:44:49 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203500,0,0,'Y',TO_DATE('2021-05-30 14:44:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:49','YYYY-MM-DD HH24:MI:SS'),100,'MFA_RegisteredDevice_ID','MFA Registered Device','MFA Registered Device','D','5286209e-eed9-4540-98b9-387819ac63d5')
;

-- May 30, 2021, 2:44:50 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200349,0,0,'Y',TO_DATE('2021-05-30 14:44:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:49','YYYY-MM-DD HH24:MI:SS'),100,'MFA Registered Device',200131,20,19,'N',22,'N','MFA_RegisteredDevice_ID','Y','D',203500,'@MFARevokeAll@=N','7ec29817-28a7-4f56-b905-3f2a24384b88','N','N')
;

-- May 30, 2021, 2:44:50 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200132,0,0,'Y',TO_DATE('2021-05-30 14:44:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:50','YYYY-MM-DD HH24:MI:SS'),100,'Register MFA','Register a multi-factor authentication mechanism','N','MFARegister','N','org.idempiere.process.MFARegister','7','D',42,408,'N','Y','N','f8bf7446-35c7-4cea-913f-c41930f7c6fc','P')
;

-- May 30, 2021, 2:44:50 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200191,'MFA_Method - on client rule','T',0,0,'Y',TO_DATE('2021-05-30 14:44:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:50','YYYY-MM-DD HH24:MI:SS'),100,'D','N','ab76ace8-d950-46d5-a262-d2de59f39d6e')
;

-- May 30, 2021, 2:44:50 PM CEST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200191,200273,214429,214438,'MFA_Method.MFA_Method_ID IN (SELECT MFA_Method_ID FROM MFA_Rule WHERE IsActive=''Y'' AND AD_Client_ID IN (0,@#AD_Client_ID@))',0,0,'Y',TO_DATE('2021-05-30 14:44:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:50','YYYY-MM-DD HH24:MI:SS'),100,'N','D','68ddf06f-e3af-45ed-843a-1a78cec49bb8')
;

-- May 30, 2021, 2:44:51 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200350,0,0,'Y',TO_DATE('2021-05-30 14:44:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:50','YYYY-MM-DD HH24:MI:SS'),100,'MFA Method','Multi-factor Authentication Method',200132,10,18,200191,'N',22,'Y','MFA_Method_ID','Y','D',203490,'6f3e3d51-51b7-4845-8c33-b7669f32a1eb','N','N')
;

-- May 30, 2021, 2:44:51 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200351,0,0,'Y',TO_DATE('2021-05-30 14:44:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:51','YYYY-MM-DD HH24:MI:SS'),100,'Parameter Value',200132,30,10,'N',2000,'N','ParameterValue','Y','D',53379,'a5bdb3ad-c28b-483f-81aa-472cf75d2424','N','N')
;

-- May 30, 2021, 2:44:51 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,ReadOnlyLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200352,0,0,'Y',TO_DATE('2021-05-30 14:44:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:51','YYYY-MM-DD HH24:MI:SS'),100,'Parameter Element',200132,20,30,200190,'N',10,'N','MFA_ElementPrm_ID','Y','D',203498,'1=1','82d2fd0e-f8a6-43ea-8681-99443d7c3174','N','N')
;

-- May 30, 2021, 2:44:52 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200115,'MFA Registered Device',0,0,'Y',TO_DATE('2021-05-30 14:44:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:51','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','6e249a9d-541b-479b-ad74-bbcb7d06844d')
;

-- May 30, 2021, 2:44:52 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200274,'MFA Registered Device','Multi-factor Authentication Registered Device',200115,'MFA_RegisteredDevice',0,'6',0,0,'Y',TO_DATE('2021-05-30 14:44:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','ce1694fc-32ce-46b4-ae8c-6dda7b652c3f','N','N','N','N')
;

-- May 30, 2021, 2:44:52 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('MFA_RegisteredDevice',1000000,'N','N','Table MFA_RegisteredDevice','Y','Y',0,0,TO_DATE('2021-05-30 14:44:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:52','YYYY-MM-DD HH24:MI:SS'),100,200343,'Y',1000000,1,200000,'3a5a9a56-486f-4e6d-adb1-9c9da5f8d5f5')
;

-- May 30, 2021, 2:44:53 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214450,1,'MFA Registered Device',200274,'MFA_RegisteredDevice_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_DATE('2021-05-30 14:44:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:52','YYYY-MM-DD HH24:MI:SS'),100,203500,'N','N','D','Y','N','N','Y','dca35a97-edf8-4846-9cb7-e3ccb563e2d6','N','N','N','N','N')
;

-- May 30, 2021, 2:44:53 PM CEST
CREATE TABLE MFA_RegisteredDevice (MFA_RegisteredDevice_ID NUMBER(10) NOT NULL, CONSTRAINT MFA_RegisteredDevice_Key PRIMARY KEY (MFA_RegisteredDevice_ID))
;

-- May 30, 2021, 2:44:53 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214451,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200274,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:44:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:53','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','f3c3a610-726a-44e7-b265-11f7841f6aed','N','N','N','D','N')
;

-- May 30, 2021, 2:44:53 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:44:53 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214452,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200274,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:44:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:53','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','1eac193f-deca-413d-9ba2-e2e5c9dbe34c','N','N','N','D','N')
;

-- May 30, 2021, 2:44:53 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:44:54 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214453,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200274,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:44:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:53','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','d9362d1f-cd9e-4e71-a23a-1033466efe09','N','N','N','N','N')
;

-- May 30, 2021, 2:44:54 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- May 30, 2021, 2:44:54 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214454,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200274,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_DATE('2021-05-30 14:44:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:54','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','394f8325-3760-46ef-9703-42fbf76e3cb3','N','N','N','D','N')
;

-- May 30, 2021, 2:44:54 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD CreatedBy NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:44:54 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214455,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200274,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-05-30 14:44:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:54','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','4c04d7b0-2340-40ab-9cd3-241c04d08ccb','N','N','N','N','N')
;

-- May 30, 2021, 2:44:54 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- May 30, 2021, 2:44:55 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203501,0,0,'Y',TO_DATE('2021-05-30 14:44:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:54','YYYY-MM-DD HH24:MI:SS'),100,'MFA_RegisteredDevice_UU','MFA_RegisteredDevice_UU','MFA_RegisteredDevice_UU','D','3d08a37e-4824-4629-905c-351dce55048f')
;

-- May 30, 2021, 2:44:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214456,1.00,'MFA_RegisteredDevice_UU',200274,'MFA_RegisteredDevice_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2021-05-30 14:44:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:55','YYYY-MM-DD HH24:MI:SS'),100,203501,'Y','N','D','Y','N','N','Y','a223f7ff-6f07-4a16-b1f0-6d85da4cdef1','N','N','N','N','N')
;

-- May 30, 2021, 2:44:55 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD MFA_RegisteredDevice_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:44:55 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD CONSTRAINT MFA_RegisteredDevice_UU_idx UNIQUE (MFA_RegisteredDevice_UU)
;

-- May 30, 2021, 2:44:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214457,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200274,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:44:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:55','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','76773355-f7ad-40cf-90f3-3b11e33893ac','N','N','N','N','N')
;

-- May 30, 2021, 2:44:55 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- May 30, 2021, 2:44:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214458,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200274,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_DATE('2021-05-30 14:44:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:55','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','0442103e-eb9d-4e9c-88c8-3f1bff1fe6e0','N','N','N','D','N')
;

-- May 30, 2021, 2:44:56 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD UpdatedBy NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:44:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214459,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200274,'AD_User_ID',22,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_DATE('2021-05-30 14:44:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:56','YYYY-MM-DD HH24:MI:SS'),100,138,'Y','N','D','Y','N','N','Y','e303baea-478e-40a7-a2cc-c726bdf1ea2b','Y',0,'N','N','ADUser_MFARegisteredDevice','N','N')
;

-- May 30, 2021, 2:44:56 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD AD_User_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:44:56 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203502,0,0,'Y',TO_DATE('2021-05-30 14:44:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:56','YYYY-MM-DD HH24:MI:SS'),100,'MFADeviceIdentifier','MFA Device Identifier','Multi-factor Authentication Device Identifier','MFA Device Identifier','D','c2a0cbe6-3fe4-49de-ab8f-cc03a712f4f8')
;

-- May 30, 2021, 2:44:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214460,0,'MFA Device Identifier','Multi-factor Authentication Device Identifier',200274,'MFADeviceIdentifier',2000,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-05-30 14:44:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:56','YYYY-MM-DD HH24:MI:SS'),100,203502,'Y','N','D','Y','N','N','Y','1dd157be-f306-4aef-9f60-6fa41dd61544','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:44:57 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD MFADeviceIdentifier VARCHAR2(2000 CHAR) NOT NULL
;

-- May 30, 2021, 2:44:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214461,0,'Expire On','Expire On',200274,'Expiration',29,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:44:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:57','YYYY-MM-DD HH24:MI:SS'),100,200245,'Y','N','D','Y','N','N','Y','e3d4054a-7ac7-499c-95a7-32b31d345e11','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:44:57 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD Expiration DATE DEFAULT NULL 
;

-- May 30, 2021, 2:44:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214462,0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200274,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2021-05-30 14:44:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:57','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','576f9669-ee37-4846-84c0-05fd540bebac','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:44:57 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD Help VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:44:58 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200289,'MFA Registered Device',200115,10,'Y',200274,0,0,'Y',TO_DATE('2021-05-30 14:44:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:57','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','MFA_RegisteredDevice.Created DESC','N',0,'N','D','Y','Y','d4125e71-276c-4fba-b857-0c83ff610a87','B','N','Y',0)
;

-- May 30, 2021, 2:44:58 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206628,'MFA Registered Device',200289,214450,'N',22,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','29882a81-1c74-4068-9038-1027dc01bcd3','N',1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:58 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206629,'MFA_RegisteredDevice_UU',200289,214456,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','142dc396-7ca7-444b-99aa-31d5eec34084','N',1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:58 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206630,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200289,214451,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','af6a1342-dabe-4b7a-a4b1-f6acff61e56f','Y',10,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:59 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206631,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200289,214452,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9f774c93-0cd7-4e22-bc4e-f900b0d6ee0f','Y','N',4,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:59 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206632,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200289,214459,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0b327ebf-9e1b-4a6c-aa65-5b2461c1284e','Y',20,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:44:59 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206633,'MFA Device Identifier','Multi-factor Authentication Device Identifier',200289,214460,'Y',2000,40,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7e58b4db-f209-4a74-b718-373d31042359','Y',30,1,5,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:00 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206634,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200289,214462,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:44:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:44:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fed4ae1b-d8db-4735-9d24-b650b5e134a8','Y',60,1,5,3,'N','N','N','N')
;

-- May 30, 2021, 2:45:00 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206635,'Expire On','Expire On',200289,214461,'Y',29,60,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','774f6ad1-9d07-4614-82cc-215230104a31','Y',40,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:00 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206636,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200289,214455,'Y',1,70,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','11219e02-68a6-4705-8ab6-5cdd766b9bec','Y',50,6,1,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:01 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200116,'MFA Registration',0,0,'Y',TO_DATE('2021-05-30 14:45:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:00','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','48632d2c-fd99-488d-a030-2ed3a54f99c1')
;

-- May 30, 2021, 2:45:01 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200275,'MFA Registration','Multi-factor Authentication Registration',200116,'MFA_Registration',0,'6',0,0,'Y',TO_DATE('2021-05-30 14:45:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','0c80292c-8d90-4e7b-81d4-9e03a6397f70','N','N','N','N')
;

-- May 30, 2021, 2:45:01 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('MFA_Registration',1000000,'N','N','Table MFA_Registration','Y','Y',0,0,TO_DATE('2021-05-30 14:45:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:01','YYYY-MM-DD HH24:MI:SS'),100,200344,'Y',1000000,1,200000,'ca2a5e73-37c6-4a51-8219-006e0b19f79a')
;

-- May 30, 2021, 2:45:02 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214463,1,'MFA Registration',200275,'MFA_Registration_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_DATE('2021-05-30 14:45:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:01','YYYY-MM-DD HH24:MI:SS'),100,203487,'N','N','D','Y','N','N','Y','3e6c4c15-603e-45fd-875f-eca9919c07cc','N','N','N','N','N')
;

-- May 30, 2021, 2:45:02 PM CEST
CREATE TABLE MFA_Registration (MFA_Registration_ID NUMBER(10) NOT NULL, CONSTRAINT MFA_Registration_Key PRIMARY KEY (MFA_Registration_ID))
;

-- May 30, 2021, 2:45:02 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214464,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200275,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:45:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:02','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','0b347cca-16ae-4f32-874f-76521b2e3971','N','N','N','D','N')
;

-- May 30, 2021, 2:45:02 PM CEST
ALTER TABLE MFA_Registration ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:02 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214465,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200275,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:45:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:02','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','55467df6-cae6-4a24-adde-50ced5f7ac63','N','N','N','D','N')
;

-- May 30, 2021, 2:45:02 PM CEST
ALTER TABLE MFA_Registration ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:03 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214466,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200275,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:45:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:03','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','91cb1f9c-06bf-44ba-8ec5-776ba73439ec','N','N','N','N','N')
;

-- May 30, 2021, 2:45:03 PM CEST
ALTER TABLE MFA_Registration ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- May 30, 2021, 2:45:03 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214467,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200275,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_DATE('2021-05-30 14:45:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:03','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','0905234a-e64c-490f-8161-fdb3ab369a6e','N','N','N','D','N')
;

-- May 30, 2021, 2:45:03 PM CEST
ALTER TABLE MFA_Registration ADD CreatedBy NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:03 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214468,1,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200275,'Name',1000,'N','N','N','N','Y',2,'N',10,0,0,'Y',TO_DATE('2021-05-30 14:45:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:03','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','Y','N','N','Y','364b1b1d-808f-44f1-98d5-58a7f39b1978','Y',10,'N','N','N')
;

-- May 30, 2021, 2:45:03 PM CEST
ALTER TABLE MFA_Registration ADD Name VARCHAR2(1000 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:45:04 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214469,1,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200275,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2021-05-30 14:45:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:04','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','047282d1-da77-4a40-b347-28c3ae3acc00','Y','N','N','N','N')
;

-- May 30, 2021, 2:45:04 PM CEST
ALTER TABLE MFA_Registration ADD Help VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:45:04 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214470,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200275,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-05-30 14:45:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:04','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','2de645f9-01c5-4a03-a72b-8906750c3d28','N','N','N','N','N')
;

-- May 30, 2021, 2:45:04 PM CEST
ALTER TABLE MFA_Registration ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- May 30, 2021, 2:45:05 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203503,0,0,'Y',TO_DATE('2021-05-30 14:45:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:04','YYYY-MM-DD HH24:MI:SS'),100,'MFA_Registration_UU','MFA_Registration_UU','MFA_Registration_UU','D','d933ab33-08d4-4772-ad49-5cd54e86870a')
;

-- May 30, 2021, 2:45:05 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214471,1.00,'MFA_Registration_UU',200275,'MFA_Registration_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2021-05-30 14:45:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:05','YYYY-MM-DD HH24:MI:SS'),100,203503,'Y','N','D','Y','N','N','Y','a31634e6-b68e-4f1c-875d-037fd72e0eee','N','N','N','N','N')
;

-- May 30, 2021, 2:45:05 PM CEST
ALTER TABLE MFA_Registration ADD MFA_Registration_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:45:05 PM CEST
ALTER TABLE MFA_Registration ADD CONSTRAINT MFA_Registration_UU_idx UNIQUE (MFA_Registration_UU)
;

-- May 30, 2021, 2:45:05 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214472,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200275,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:45:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:05','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','6427e797-f3d0-40de-9851-a335bde9e5ac','N','N','N','N','N')
;

-- May 30, 2021, 2:45:05 PM CEST
ALTER TABLE MFA_Registration ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- May 30, 2021, 2:45:06 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214473,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200275,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_DATE('2021-05-30 14:45:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:05','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','a0af0c88-69e7-40e7-919d-0a4b90654829','N','N','N','D','N')
;

-- May 30, 2021, 2:45:06 PM CEST
ALTER TABLE MFA_Registration ADD UpdatedBy NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:06 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214474,0,'MFA Method','Multi-factor Authentication Method',200275,'MFA_Method_ID',22,'N','N','Y','N','Y',1,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:45:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:06','YYYY-MM-DD HH24:MI:SS'),100,203490,'Y','N','D','Y','N','N','Y','c6d57e6f-5ef8-4553-adf5-ae3e80a06d7f','Y',0,'N','N','MFAMethod_MFARegistration','N','N')
;

-- May 30, 2021, 2:45:06 PM CEST
ALTER TABLE MFA_Registration ADD MFA_Method_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:06 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214475,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200275,'AD_User_ID',22,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_DATE('2021-05-30 14:45:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:06','YYYY-MM-DD HH24:MI:SS'),100,138,'Y','N','D','Y','N','N','Y','957429c0-e82a-404f-8256-f14d98c8c7b6','Y',0,'N','N','ADUser_MFARegistration','N','N')
;

-- May 30, 2021, 2:45:06 PM CEST
ALTER TABLE MFA_Registration ADD AD_User_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:07 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203504,0,0,'Y',TO_DATE('2021-05-30 14:45:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:06','YYYY-MM-DD HH24:MI:SS'),100,'MFASecret','MFA Secret','Multi-factor Authentication Secret','MFA Secret','D','75934c11-c373-44c4-a3a1-290e01dbae94')
;

-- May 30, 2021, 2:45:07 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214476,0,'MFA Secret','Multi-factor Authentication Secret',200275,'MFASecret',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-05-30 14:45:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:07','YYYY-MM-DD HH24:MI:SS'),100,203504,'Y','N','D','Y','N','N','Y','649b3d2f-6d06-43b0-a3b3-db377d66d138','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:45:07 PM CEST
ALTER TABLE MFA_Registration ADD MFASecret VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:45:07 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214477,0,'Valid','Element is valid','The element passed the validation check',200275,'IsValid','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-05-30 14:45:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:07','YYYY-MM-DD HH24:MI:SS'),100,2002,'Y','N','D','Y','N','N','Y','07f81c2c-e77e-4425-a15a-7e8157eb6856','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:45:07 PM CEST
ALTER TABLE MFA_Registration ADD IsValid CHAR(1) DEFAULT 'N' CHECK (IsValid IN ('Y','N')) NOT NULL
;

-- May 30, 2021, 2:45:08 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203505,0,0,'Y',TO_DATE('2021-05-30 14:45:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:07','YYYY-MM-DD HH24:MI:SS'),100,'MFAValidatedAt','Validated at','Validated at','D','26fad160-6cac-403b-9fcc-7d1fff1d79ec')
;

-- May 30, 2021, 2:45:08 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214478,0,'Validated at',200275,'MFAValidatedAt',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:45:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:08','YYYY-MM-DD HH24:MI:SS'),100,203505,'Y','N','D','Y','N','N','Y','a6a98589-aabb-4960-aa7b-4f5935234e42','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:45:08 PM CEST
ALTER TABLE MFA_Registration ADD MFAValidatedAt DATE DEFAULT NULL 
;

-- May 30, 2021, 2:45:08 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203506,0,0,'Y',TO_DATE('2021-05-30 14:45:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:08','YYYY-MM-DD HH24:MI:SS'),100,'MFAUnregisteredAt','Unregistered at','Unregistered at','D','576139cd-dd64-4fb6-ae5d-6cd1a9d470e0')
;

-- May 30, 2021, 2:45:09 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214479,0,'Unregistered at',200275,'MFAUnregisteredAt',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:45:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:08','YYYY-MM-DD HH24:MI:SS'),100,203506,'Y','N','D','Y','N','N','Y','2adb4401-1b68-470f-aa03-01a3d3fdd350','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:45:09 PM CEST
ALTER TABLE MFA_Registration ADD MFAUnregisteredAt DATE DEFAULT NULL 
;

-- May 30, 2021, 2:45:09 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214480,0,'Preferred',200275,'IsUserMFAPreferred','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-05-30 14:45:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:09','YYYY-MM-DD HH24:MI:SS'),100,203489,'Y','N','D','Y','N','N','Y','5f25c961-b544-4868-8ad9-6eea0724fa03','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:45:09 PM CEST
ALTER TABLE MFA_Registration ADD IsUserMFAPreferred CHAR(1) DEFAULT 'N' CHECK (IsUserMFAPreferred IN ('Y','N')) NOT NULL
;

-- May 30, 2021, 2:45:09 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214481,0,'Expire On','Expire On',200275,'Expiration',29,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:45:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:09','YYYY-MM-DD HH24:MI:SS'),100,200245,'Y','N','D','Y','N','N','Y','27e95438-f072-4e92-ac5b-6cd93a1b971a','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:45:09 PM CEST
ALTER TABLE MFA_Registration ADD Expiration DATE DEFAULT NULL 
;

-- May 30, 2021, 2:45:10 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214482,0,'Parameter Value',200275,'ParameterValue',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-05-30 14:45:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:09','YYYY-MM-DD HH24:MI:SS'),100,53379,'Y','N','D','Y','N','N','Y','19b59c42-fd59-4ff3-a486-f8b9cc5a4ce7','Y',0,'N','N','N','N')
;

-- May 30, 2021, 2:45:10 PM CEST
ALTER TABLE MFA_Registration ADD ParameterValue VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:45:10 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200290,'MFA Registration',200116,10,'Y',200275,0,0,'Y',TO_DATE('2021-05-30 14:45:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','MFA_Registration.Name','N',0,'N','D','Y','Y','9831281f-f29f-41ef-9d8f-baf9e14e4d4f','B','N','Y',0)
;

-- May 30, 2021, 2:45:10 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206637,'MFA Registration',200290,214463,'N',22,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d59d4ce0-7f32-4e75-bb7a-f49e77015b90','N',1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:11 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206638,'MFA_Registration_UU',200290,214471,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7cbac4df-2f61-4bd9-aeaa-d42ce2c80842','N',1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:11 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206639,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200290,214464,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f03f6b4a-40df-42b5-8dcb-3629bd462af5','Y',10,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:11 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206640,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200290,214465,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8206502a-0d10-4de2-9324-7404c71ecafc','Y','N',4,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206641,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200290,214468,'Y',60,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','57bc1544-5e4e-4c40-99d5-9b869e884847','Y',20,1,5,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206642,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200290,214469,'Y',2000,40,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9df607dd-80b9-4c2a-97c7-a94e64f0d122','Y',30,1,5,3,'N','N','N','N')
;

-- May 30, 2021, 2:45:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206643,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200290,214475,'Y',22,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','14dc9d13-ef51-44fa-92f5-98c791bc757e','Y',50,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206644,'MFA Method','Multi-factor Authentication Method',200290,214474,'Y',22,60,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','48512d1f-3e5e-41eb-b54c-538da325b7ee','Y',40,4,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:13 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206645,'Parameter Value',200290,214482,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4d689c8e-9f61-41ba-953a-d90361c61050','Y',140,1,5,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:13 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206646,'MFA Secret','Multi-factor Authentication Secret',200290,214476,'Y',2000,80,'N','N','N','Y',0,0,'Y',TO_DATE('2021-05-30 14:45:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','da72323c-6950-49e9-b2ce-97a26922e981','Y',60,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:13 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206647,'Expire On','Expire On',200290,214481,'Y',29,90,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0816c719-de38-4951-8537-584bf795a544','Y',130,4,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206648,'Valid','Element is valid','The element passed the validation check',200290,214477,'Y',1,100,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5c93c799-2b4f-4f00-a750-c09d62e5850e','Y',70,2,1,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206649,'Preferred',200290,214480,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8dff0bc0-ecc8-4a9d-9521-b8ece1b90009','Y',110,3,1,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206650,'Validated at',200290,214478,'Y',7,120,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6f8ea06e-2a03-45b0-99be-9ee52ffb8ed0','Y',90,4,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:15 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206651,'Unregistered at',200290,214479,'Y',7,140,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','398bfaac-b931-41d8-adb8-be36bf8b3047','Y',100,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:15 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206652,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200290,214470,'Y',1,150,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','54e089be-a428-448c-88da-df68438e5a17','Y',120,6,1,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:15 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,Description,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200117,'MFA Rule','Multi-factor Authentication Rule',0,0,'Y',TO_DATE('2021-05-30 14:45:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:15','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','d97ad960-feb6-4deb-9991-9af7955253d1')
;

-- May 30, 2021, 2:45:16 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200276,'MFA Rule','Multi-factor Authentication Rule',200117,'MFA_Rule',0,'6',0,0,'Y',TO_DATE('2021-05-30 14:45:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','3143692d-dc6d-4a3d-8f01-40fce4bb398a','N','N','N','N')
;

-- May 30, 2021, 2:45:16 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('MFA_Rule',1000000,'N','N','Table MFA_Rule','Y','Y',0,0,TO_DATE('2021-05-30 14:45:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:16','YYYY-MM-DD HH24:MI:SS'),100,200345,'Y',1000000,1,200000,'a8365f4a-e13d-464e-b4ef-82ea4e6bad1d')
;

-- May 30, 2021, 2:45:16 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203507,0,0,'Y',TO_DATE('2021-05-30 14:45:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:16','YYYY-MM-DD HH24:MI:SS'),100,'MFA_Rule_ID','MFA Rule','Multi-factor Authentication Rule','MFA Rule','D','69b6070b-aa9c-4b26-bd0a-ec54171dae03')
;

-- May 30, 2021, 2:45:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214483,1,'MFA Rule','Multi-factor Authentication Rule',200276,'MFA_Rule_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_DATE('2021-05-30 14:45:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:16','YYYY-MM-DD HH24:MI:SS'),100,203507,'N','N','D','Y','N','N','Y','a3204fe0-25ee-4aa6-a25c-4caaf9936b9c','N','N','N','N','N')
;

-- May 30, 2021, 2:45:17 PM CEST
CREATE TABLE MFA_Rule (MFA_Rule_ID NUMBER(10) NOT NULL, CONSTRAINT MFA_Rule_Key PRIMARY KEY (MFA_Rule_ID))
;

-- May 30, 2021, 2:45:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214484,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200276,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:45:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:17','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','63061b21-b6c5-4a1d-82bb-ef8c32e42bf6','N','N','N','D','N')
;

-- May 30, 2021, 2:45:17 PM CEST
ALTER TABLE MFA_Rule ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214485,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200276,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:45:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:17','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','afbfb795-112c-48eb-801e-1ac8edd77bf5','N','N','N','D','N')
;

-- May 30, 2021, 2:45:17 PM CEST
ALTER TABLE MFA_Rule ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214486,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200276,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:45:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:17','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','f2ebf2ae-a4a4-4b72-b1b9-fda80421c6f0','N','N','N','N','N')
;

-- May 30, 2021, 2:45:18 PM CEST
ALTER TABLE MFA_Rule ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- May 30, 2021, 2:45:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214487,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200276,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_DATE('2021-05-30 14:45:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:18','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','839fc23c-7413-41fa-93a1-f5a193a1bcc4','N','N','N','D','N')
;

-- May 30, 2021, 2:45:18 PM CEST
ALTER TABLE MFA_Rule ADD CreatedBy NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214488,1,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200276,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2021-05-30 14:45:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:18','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','00b06810-1ac8-4614-8c54-928c0cb40fad','Y','N','N','N','N')
;

-- May 30, 2021, 2:45:18 PM CEST
ALTER TABLE MFA_Rule ADD Help VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:45:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214489,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200276,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-05-30 14:45:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:18','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','10ee6d2f-b8cb-48ee-a385-fa4cb686b0b2','N','N','N','N','N')
;

-- May 30, 2021, 2:45:19 PM CEST
ALTER TABLE MFA_Rule ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- May 30, 2021, 2:45:19 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203508,0,0,'Y',TO_DATE('2021-05-30 14:45:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:19','YYYY-MM-DD HH24:MI:SS'),100,'MFA_Rule_UU','MFA_Rule_UU','MFA_Rule_UU','D','ab218afd-6a60-4300-9d14-2bc70ee5b405')
;

-- May 30, 2021, 2:45:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214490,1.00,'MFA_Rule_UU',200276,'MFA_Rule_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2021-05-30 14:45:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:19','YYYY-MM-DD HH24:MI:SS'),100,203508,'Y','N','D','Y','N','N','Y','39f43c92-27d0-48f2-b435-a44124b28c84','N','N','N','N','N')
;

-- May 30, 2021, 2:45:19 PM CEST
ALTER TABLE MFA_Rule ADD MFA_Rule_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 30, 2021, 2:45:19 PM CEST
ALTER TABLE MFA_Rule ADD CONSTRAINT MFA_Rule_UU_idx UNIQUE (MFA_Rule_UU)
;

-- May 30, 2021, 2:45:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214491,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200276,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-05-30 14:45:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:19','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','0bcf9ffc-1f5f-4c3b-8596-ebadcdcc15de','N','N','N','N','N')
;

-- May 30, 2021, 2:45:20 PM CEST
ALTER TABLE MFA_Rule ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- May 30, 2021, 2:45:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214492,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200276,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_DATE('2021-05-30 14:45:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:20','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','81d2913a-f0c4-4ce3-b369-6abd6c6cc32e','N','N','N','D','N')
;

-- May 30, 2021, 2:45:20 PM CEST
ALTER TABLE MFA_Rule ADD UpdatedBy NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214493,0,'MFA Method','Multi-factor Authentication Method',200276,'MFA_Method_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-30 14:45:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:20','YYYY-MM-DD HH24:MI:SS'),100,203490,'N','N','D','Y','N','N','Y','e46cba84-bc2e-47dd-8945-2c41e44e4fcb','Y',0,'N','N','MFAMethod_MFARule','N','N')
;

-- May 30, 2021, 2:45:20 PM CEST
ALTER TABLE MFA_Rule ADD MFA_Method_ID NUMBER(10) NOT NULL
;

-- May 30, 2021, 2:45:23 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200291,'MFA Rule','Multi-factor Authentication Rule',200117,10,'Y',200276,0,0,'Y',TO_DATE('2021-05-30 14:45:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','MFA_Rule.Created DESC','N',0,'N','D','Y','Y','b870c13f-8ff8-462a-80fa-9e27ca0fb329','B','N','Y',0)
;

-- May 30, 2021, 2:45:23 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206653,'MFA_Rule_UU',200291,214490,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a0ccfd12-5e27-45ef-9344-c2b554f12a1e','N',1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:23 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206654,'MFA Rule','Multi-factor Authentication Rule',200291,214483,'N',22,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0a4a6136-0536-4ff0-bb60-e445f5a4b25e','N',1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206655,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200291,214484,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8668ecbd-4965-4823-a074-4ee6ae0c8727','Y',10,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206656,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200291,214485,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1a88050c-4ad9-4944-bdf5-e22de820d5a6','Y','N',4,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206657,'MFA Method','Multi-factor Authentication Method',200291,214493,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d30c7b06-5930-469e-8c5a-73bcc78eabcf','Y',30,1,2,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206658,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200291,214488,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fa1f35dc-1ad6-445e-9157-14357b2273e3','Y',20,1,5,3,'N','N','N','N')
;

-- May 30, 2021, 2:45:26 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206662,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200291,214489,'Y',1,90,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-30 14:45:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2bb3137e-35e5-49d1-ac7c-944d560b37f3','Y',80,5,1,1,'N','N','N','N')
;

-- May 30, 2021, 2:45:26 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The provided code doesn''t match with the expected secret',0,0,'Y',TO_DATE('2021-05-30 14:45:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:26','YYYY-MM-DD HH24:MI:SS'),100,200686,'MFACodeInvalid','D','fc8f217f-7734-4614-b93d-0b593847607b')
;

-- May 30, 2021, 2:45:27 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Code required to complete MFA registration',0,0,'Y',TO_DATE('2021-05-30 14:45:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:26','YYYY-MM-DD HH24:MI:SS'),100,200687,'MFACodeRequired','D','b75a4b06-82f8-4262-9f05-e78fcbdcb233')
;

-- May 30, 2021, 2:45:27 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','A validation code was sent to the provided address, please check the EMail, remember to check spam folder in case you don''t receive it soon.',0,0,'Y',TO_DATE('2021-05-30 14:45:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:27','YYYY-MM-DD HH24:MI:SS'),100,200688,'MFAEMailCodeSent','D','24785891-890a-4f87-8961-1441495e55ec')
;

-- May 30, 2021, 2:45:27 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','For EMail authentication method the EMail is required',0,0,'Y',TO_DATE('2021-05-30 14:45:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:27','YYYY-MM-DD HH24:MI:SS'),100,200689,'MFAEMailRequired','D','839569eb-d57b-42ca-bd52-b9a1b9ba8b90')
;

-- May 30, 2021, 2:45:28 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','A validation code was sent to the email {0}',0,0,'Y',TO_DATE('2021-05-30 14:45:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:27','YYYY-MM-DD HH24:MI:SS'),100,200690,'MFAEMailValidationCodeSent','D','fcf83a42-2e5b-413e-a482-c5418ed0d0a3')
;

-- May 30, 2021, 2:45:28 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The EMail address provided is not valid',0,0,'Y',TO_DATE('2021-05-30 14:45:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:28','YYYY-MM-DD HH24:MI:SS'),100,200691,'MFAInvalidEMail','D','65fc1b0c-d5dc-48ed-a04d-e4bd6faf74a2')
;

-- May 30, 2021, 2:45:28 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','MFA Mechanism',0,0,'Y',TO_DATE('2021-05-30 14:45:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:28','YYYY-MM-DD HH24:MI:SS'),100,200692,'MFALoginMechanism','D','6d8b9d59-9080-4803-b461-f9ed239c3157')
;

-- May 30, 2021, 2:45:28 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Select a mechanism and click OK to start',0,0,'Y',TO_DATE('2021-05-30 14:45:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:28','YYYY-MM-DD HH24:MI:SS'),100,200693,'MFALoginMessage','D','41e6fb50-2876-40cd-ac05-c1ad19267a05')
;

-- May 30, 2021, 2:45:29 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Set as Preferred',0,0,'Y',TO_DATE('2021-05-30 14:45:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:29','YYYY-MM-DD HH24:MI:SS'),100,200694,'MFALoginSetPreferred','D','88658383-0553-4b30-9f2d-29e392355049')
;

-- May 30, 2021, 2:45:29 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Validation Code',0,0,'Y',TO_DATE('2021-05-30 14:45:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:29','YYYY-MM-DD HH24:MI:SS'),100,200695,'MFALoginValidationCode','D','c6d302d0-ac83-4d63-8b7b-f4b2da50dcbd')
;

-- May 30, 2021, 2:45:29 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Multi-Factor Authentication',0,0,'Y',TO_DATE('2021-05-30 14:45:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:29','YYYY-MM-DD HH24:MI:SS'),100,200696,'MFALoginValidationHeader','D','11681326-f0c2-405b-9b81-ba79b4616565')
;

-- May 30, 2021, 2:45:30 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The user has a valid mechanism already registered for this method',0,0,'Y',TO_DATE('2021-05-30 14:45:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:29','YYYY-MM-DD HH24:MI:SS'),100,200697,'MFAMethodAlreadyRegistered','D','5d128030-9924-49c6-8ad0-005643440b59')
;

-- May 30, 2021, 2:45:30 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','There was an error contacting the NTP server',0,0,'Y',TO_DATE('2021-05-30 14:45:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:30','YYYY-MM-DD HH24:MI:SS'),100,200698,'MFANTPServerError','D','bec57e99-cd5b-47bd-a6e0-03b0ff092b2e')
;

-- May 30, 2021, 2:45:30 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','There was a problem trying to send the EMail, please contact support.',0,0,'Y',TO_DATE('2021-05-30 14:45:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:30','YYYY-MM-DD HH24:MI:SS'),100,200699,'MFAProblemSendingEMail','D','29523709-e005-4bab-98fc-b7fe065bac9f')
;

-- May 30, 2021, 2:45:31 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The MFA registration was already completed',0,0,'Y',TO_DATE('2021-05-30 14:45:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:30','YYYY-MM-DD HH24:MI:SS'),100,200700,'MFARegistrationAlreadyValid','D','70cc56f5-a381-4a62-9d14-c780d3861f5d')
;

-- May 30, 2021, 2:45:31 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The MFA registration was completed successfully',0,0,'Y',TO_DATE('2021-05-30 14:45:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:31','YYYY-MM-DD HH24:MI:SS'),100,200701,'MFARegistrationCompleted','D','bb76e61e-96de-4247-b300-3e52a005b90c')
;

-- May 30, 2021, 2:45:31 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The registration expired, please register again',0,0,'Y',TO_DATE('2021-05-30 14:45:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:31','YYYY-MM-DD HH24:MI:SS'),100,200702,'MFARegistrationExpired','D','127c4a80-d80b-4fcc-ae7f-1d1844996798')
;

-- May 30, 2021, 2:45:32 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Enter the validation code generated by your TOTP application',0,0,'Y',TO_DATE('2021-05-30 14:45:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:31','YYYY-MM-DD HH24:MI:SS'),100,200703,'MFATOTPEnterValidationCode','D','b059e87e-fe07-40c2-8f27-f5463c6d5e15')
;

-- May 30, 2021, 2:45:32 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','There was an error generating the QR Code',0,0,'Y',TO_DATE('2021-05-30 14:45:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:32','YYYY-MM-DD HH24:MI:SS'),100,200704,'MFATOTPErrorGeneratingQR','D','09b7504e-f371-4435-ae64-e6207f5db9d8')
;

-- May 30, 2021, 2:45:32 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','<b>Barcode:</b>',0,0,'Y',TO_DATE('2021-05-30 14:45:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:32','YYYY-MM-DD HH24:MI:SS'),100,200705,'MFATOTPImage','D','11b238ff-0b52-4f9a-beab-beefa94374cc')
;

-- May 30, 2021, 2:45:33 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Wrong TOTP configuration, issuer required',0,0,'Y',TO_DATE('2021-05-30 14:45:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:32','YYYY-MM-DD HH24:MI:SS'),100,200706,'MFATOTPIssuerRequired','D','ec8ef5c1-0680-42e5-aef4-82a3c40c9f0e')
;

-- May 30, 2021, 2:45:33 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The TOTP mechanism was successfully registered, you can scan the barcode for the registration process, or manually enter the secret code in your TOTP application to register it',0,0,'Y',TO_DATE('2021-05-30 14:45:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:33','YYYY-MM-DD HH24:MI:SS'),100,200707,'MFATOTPRegistered','D','56d95714-9355-4d2d-a36c-d572f53f11f7')
;

-- May 30, 2021, 2:45:33 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','<b>Secret:</b>',0,0,'Y',TO_DATE('2021-05-30 14:45:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:33','YYYY-MM-DD HH24:MI:SS'),100,200708,'MFATOTPSecret','D','fa6009c5-89d9-47f1-9b5e-5948ae71d8b7')
;

-- May 30, 2021, 2:45:34 PM CEST
INSERT INTO R_MailText (R_MailText_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsHtml,MailHeader,MailText,R_MailText_UU) VALUES (200001,0,0,'Y',TO_DATE('2021-05-30 14:45:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:33','YYYY-MM-DD HH24:MI:SS'),100,'MFA Validation Code','Y','MFA Validation Code for iDempiere','<p>Hello @Name@,</p>

<p>The validation code for multi-factor authentication on iDempiere is: <b>@MFASecret@</b></p>

<p>This validation code expires in @MFA_Method_ID<ExpireInMinutes>@ minutes.</p>','e49493ce-1e00-4d65-a537-bc962e419bbc')
;

-- May 30, 2021, 2:45:34 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200174,0,0,TO_DATE('2021-05-30 14:45:34','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2021-05-30 14:45:34','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MFA_REGISTERED_DEVICE_EXPIRATION_DAYS','30','Days of expiration for a registered device - if zero then registering device is not allowed','D','C','a93e2d8c-c09f-4b99-b0ff-d57420d922a0')
;

-- May 30, 2021, 2:45:34 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200185,'Unregister MFA Mechanism','Unregister a multi-factor authentication registration','P',0,0,'Y',TO_DATE('2021-05-30 14:45:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:34','YYYY-MM-DD HH24:MI:SS'),100,'N',200129,'Y','N','D','Y','abfd0551-f6e6-42a9-842f-df58039cc942')
;

-- May 30, 2021, 2:45:34 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200184,8, 10, 200185)
;

-- May 30, 2021, 2:45:35 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200186,'Complete MFA Registration','Complete a registration for a multi-factor authentication mechanism','P',0,0,'Y',TO_DATE('2021-05-30 14:45:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:34','YYYY-MM-DD HH24:MI:SS'),100,'N',200130,'Y','N','D','Y','944b0ed7-5760-4d8b-8c32-02c0247e4dba')
;

-- May 30, 2021, 2:45:35 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200184,6, 10, 200186)
;

-- May 30, 2021, 2:45:35 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200187,'MFA Method','Multi-factor Authentication Method','W',200114,0,0,'Y',TO_DATE('2021-05-30 14:45:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','37259222-7dbd-4127-a38e-0ff06edb133b')
;

-- May 30, 2021, 2:45:35 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200184,0, 10, 200187)
;

-- May 30, 2021, 2:45:35 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200188,'Revoke MFA Trusted Device','Revoke one multi-factor authentication trusted device or all','P',0,0,'Y',TO_DATE('2021-05-30 14:45:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:35','YYYY-MM-DD HH24:MI:SS'),100,'N',200131,'Y','N','D','Y','37af83e2-d444-4e79-aa20-dd9d24884cbe')
;

-- May 30, 2021, 2:45:35 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200184,9, 10, 200188)
;

-- May 30, 2021, 2:45:36 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200189,'Register MFA','Register a multi-factor authentication mechanism','P',0,0,'Y',TO_DATE('2021-05-30 14:45:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:35','YYYY-MM-DD HH24:MI:SS'),100,'N',200132,'Y','N','D','Y','4578e2a5-d26d-4548-8879-dd09f7a1abeb')
;

-- May 30, 2021, 2:45:36 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200184,5, 10, 200189)
;

-- May 30, 2021, 2:45:36 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200190,'MFA Registered Device','W',200115,0,0,'Y',TO_DATE('2021-05-30 14:45:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','7305e121-e83b-4f4a-9e8b-f6a404c741ed')
;

-- May 30, 2021, 2:45:36 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200184,3, 10, 200190)
;

-- May 30, 2021, 2:45:36 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200191,'MFA Registration','W',200116,0,0,'Y',TO_DATE('2021-05-30 14:45:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','bf1107dc-629b-4b0e-b30e-88ce65d302de')
;

-- May 30, 2021, 2:45:36 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200184,2, 10, 200191)
;

-- May 30, 2021, 2:45:37 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200192,'MFA Rule','Multi-factor Authentication Rule','W',200117,0,0,'Y',TO_DATE('2021-05-30 14:45:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-30 14:45:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','467583a6-b278-445e-b684-a0278f7f6b91')
;

-- May 30, 2021, 2:45:37 PM CEST
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 200184,1, 10, 200192)
;

-- May 30, 2021, 2:45:37 PM CEST
ALTER TABLE MFA_Method ADD CONSTRAINT RMailText_MFAMethod FOREIGN KEY (R_MailText_ID) REFERENCES r_mailtext(r_mailtext_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 30, 2021, 2:45:37 PM CEST
ALTER TABLE MFA_Method ADD CONSTRAINT MFAElementPrm_MFAMethod FOREIGN KEY (MFA_ElementPrm_ID) REFERENCES ad_element(ad_element_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 30, 2021, 2:45:37 PM CEST
ALTER TABLE MFA_RegisteredDevice ADD CONSTRAINT ADUser_MFARegisteredDevice FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 30, 2021, 2:45:37 PM CEST
ALTER TABLE MFA_Registration ADD CONSTRAINT MFAMethod_MFARegistration FOREIGN KEY (MFA_Method_ID) REFERENCES mfa_method(mfa_method_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 30, 2021, 2:45:37 PM CEST
ALTER TABLE MFA_Registration ADD CONSTRAINT ADUser_MFARegistration FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 30, 2021, 2:45:37 PM CEST
ALTER TABLE MFA_Rule ADD CONSTRAINT MFAMethod_MFARule FOREIGN KEY (MFA_Method_ID) REFERENCES mfa_method(mfa_method_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 30, 2021, 2:46:41 PM CEST
INSERT INTO MFA_Method (MFA_Method_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,MFA_Method_UU,Name,Updated,UpdatedBy,Method,MFAType,MFAIssuer,ExpireInMinutes,MFA_ElementPrm_ID) VALUES (200000,0,0,TO_DATE('2021-05-30 14:46:40','YYYY-MM-DD HH24:MI:SS'),100,'Y','9a3b4d6e-0c31-4a06-9f05-54a0227bdd66','TOTP',TO_DATE('2021-05-30 14:46:40','YYYY-MM-DD HH24:MI:SS'),100,'TOTP','H','iDempiere ERP',60,469)
;

-- May 30, 2021, 2:46:41 PM CEST
INSERT INTO MFA_Method (MFA_Method_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,MFA_Method_UU,Name,Updated,UpdatedBy,Method,MFAType,ExpireInMinutes,R_MailText_ID,MFA_ElementPrm_ID) VALUES (200001,0,0,TO_DATE('2021-05-30 14:46:41','YYYY-MM-DD HH24:MI:SS'),100,'Y','6773bdd1-496f-49af-ad57-9fb077bb9de9','EMail',TO_DATE('2021-05-30 14:46:41','YYYY-MM-DD HH24:MI:SS'),100,'EMail','H',15,200001,881)
;

-- May 30, 2021, 2:46:41 PM CEST
INSERT INTO MFA_Rule (MFA_Rule_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,MFA_Rule_UU,Updated,UpdatedBy,MFA_Method_ID) VALUES (200000,0,0,TO_DATE('2021-05-30 14:46:41','YYYY-MM-DD HH24:MI:SS'),100,'Y','2c0c1a47-398d-4e25-9d8c-d13296e5703e',TO_DATE('2021-05-30 14:46:41','YYYY-MM-DD HH24:MI:SS'),100,200000)
;

-- May 30, 2021, 2:46:42 PM CEST
INSERT INTO MFA_Rule (MFA_Rule_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,MFA_Rule_UU,Updated,UpdatedBy,MFA_Method_ID) VALUES (200001,0,0,TO_DATE('2021-05-30 14:46:41','YYYY-MM-DD HH24:MI:SS'),100,'Y','ac727f25-ca8c-4de9-a2e7-934ee9b4569d',TO_DATE('2021-05-30 14:46:41','YYYY-MM-DD HH24:MI:SS'),100,200001)
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200178
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200184
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200168
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200169
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=21, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=22, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200161
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=23, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=24, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- May 30, 2021, 2:47:38 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=25, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200177
;

-- Jun 1, 2021, 1:02:42 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Register this device for {0} days',0,0,'Y',TO_DATE('2021-06-01 01:02:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-01 01:02:42','YYYY-MM-DD HH24:MI:SS'),100,200709,'MFALoginRegisterDevice','D','0c9b5463-497b-4cd4-b4f0-932fc07c920d')
;

-- Jun 1, 2021, 1:11:52 AM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200150,'MFA_RegisteredDevice - not expired','S','MFA_RegisteredDevice.AD_User_ID=@#AD_User_ID@ AND MFA_RegisteredDevice.Expiration>SYSDATE',0,0,'Y',TO_DATE('2021-06-01 01:11:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-01 01:11:52','YYYY-MM-DD HH24:MI:SS'),100,'D','a3f149eb-b40f-4479-aa8e-34c4ba25ca46')
;

-- Jun 1, 2021, 1:11:59 AM CEST
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200150,Updated=TO_DATE('2021-06-01 01:11:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200349
;

-- Jun 1, 2021, 1:13:06 AM CEST
UPDATE AD_Val_Rule SET Name='MFA_Registration - Pending to Complete from User', Code='MFA_Registration.IsValid=''N'' AND MFA_Registration.IsActive=''Y'' AND MFA_Registration.AD_User_ID=@#AD_User_ID@',Updated=TO_DATE('2021-06-01 01:13:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200149
;

-- Jun 1, 2021, 1:13:16 AM CEST
UPDATE AD_Val_Rule SET Name='MFA_RegisteredDevice - not expired from User',Updated=TO_DATE('2021-06-01 01:13:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200150
;

-- Jun 4, 2021, 1:01:16 PM CEST
UPDATE AD_Message SET MsgText='<ul><li><b>Step 1:</b> Visit the App Store to get an authenticator app like Google Authenticator or Authy, then follow the instructions in the application to set up an account with them</li><li><b>Step 2:</b> Use your authenticator app to scan the barcode below or enter manually the Secret instead</li></ul>
',Updated=TO_DATE('2021-06-04 13:01:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200707
;

-- Jun 4, 2021, 1:27:06 PM CEST
UPDATE AD_Message SET MsgText='Register this device for {0,choice,1#1 day|1<{0} days}',Updated=TO_DATE('2021-06-04 13:27:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200709
;

-- Jun 4, 2021, 1:33:09 PM CEST
INSERT INTO AD_Form (AD_Form_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Classname,AccessLevel,EntityType,IsBetaFunctionality,AD_Form_UU) VALUES (200017,0,0,'Y',TO_DATE('2021-06-04 13:33:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-04 13:33:08','YYYY-MM-DD HH24:MI:SS'),100,'Register MFA','org.adempiere.webui.apps.form.MFARegister','7','D','N','225070fb-7912-4873-b9aa-785e377c9980')
;

-- Jun 4, 2021, 1:34:46 PM CEST
UPDATE AD_Form SET Description='Register a multi-factor authentication mechanism',Updated=TO_DATE('2021-06-04 13:34:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=200017
;

-- Jun 4, 2021, 5:42:58 PM CEST
UPDATE AD_Process SET Classname='org.compiere.process.MFACompleteRegistration',Updated=TO_DATE('2021-06-04 17:42:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200130
;

-- Jun 4, 2021, 5:43:05 PM CEST
UPDATE AD_Process SET Classname='org.compiere.process.MFARegister',Updated=TO_DATE('2021-06-04 17:43:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200132
;

-- Jun 4, 2021, 5:43:10 PM CEST
UPDATE AD_Process SET Classname='org.compiere.process.MFARevokeDevice',Updated=TO_DATE('2021-06-04 17:43:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200131
;

-- Jun 4, 2021, 5:43:15 PM CEST
UPDATE AD_Process SET Classname='org.compiere.process.MFAUnregister',Updated=TO_DATE('2021-06-04 17:43:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200129
;

-- Jun 4, 2021, 6:15:23 PM CEST
UPDATE AD_Form SET Classname='org.adempiere.webui.apps.form.MFARegisterForm',Updated=TO_DATE('2021-06-04 18:15:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=200017
;

-- Jun 5, 2021, 11:11:16 AM CEST
UPDATE MFA_Method SET Name='TOTP (Google Auth, Authy, etc)',Updated=TO_DATE('2021-06-05 11:11:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE MFA_Method_ID=200000
;

-- Jun 5, 2021, 11:31:46 AM CEST
UPDATE AD_Column SET SeqNo=3,Updated=TO_DATE('2021-06-05 11:31:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214468
;

-- Jun 5, 2021, 11:31:49 AM CEST
UPDATE AD_Column SET SeqNo=2,Updated=TO_DATE('2021-06-05 11:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214474
;

-- Jun 5, 2021, 11:31:53 AM CEST
UPDATE AD_Column SET SeqNo=1,Updated=TO_DATE('2021-06-05 11:31:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214468
;

SELECT register_migration_script('202105301448_IDEMPIERE-4782.sql') FROM dual
;

