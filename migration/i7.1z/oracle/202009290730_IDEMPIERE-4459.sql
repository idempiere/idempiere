SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4459
-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,Description,Help,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200110,'Info Window Customization','Define Info Window Customization for Role/User','The customization values defined here overwrite/replace the default system definition if defined.',0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','49fe86de-d43f-4069-98a4-e649a837e6ce')
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200266,'User defined Info Window',200110,'AD_UserDef_Info',135,'6',0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','Y','bf0ce772-b06d-4c8a-87f2-42adfa5b31a2','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Info',1000000,'N','N','Table AD_UserDef_Info','Y','Y',0,0,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,200332,'Y',1000000,1,200000,'e6ff4b12-be71-49dd-8c7c-47ef5e3e7ef7')
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203433,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_ID','User defined Info Window','User Info Win','D','f59f4c84-4613-48a8-b297-9f2b65aabf7c')
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214227,0.0,'User defined Info Window',200266,'AD_UserDef_Info_ID',10,'Y','N','Y','N','N','N',13,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,203433,'N','N','D','Y','N','N','Y','b148f025-8d82-46ae-8126-27afd1a0269f','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
CREATE TABLE AD_UserDef_Info (AD_UserDef_Info_ID NUMBER(10) NOT NULL, CONSTRAINT AD_UserDef_Info_Key PRIMARY KEY (AD_UserDef_Info_ID))
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214228,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200266,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','49081b54-d21c-4626-a519-0f6b9587b87c','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214229,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200266,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','88359471-f67b-4c75-854c-f9a842db05ca','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214230,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200266,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','ac4ed706-e659-42e4-8c9a-30f91674b6b3','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214231,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200266,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','02ba72c6-ebb4-484c-9562-f5ffca19afa5','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214232,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200266,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','6e420cdc-23ee-4373-99e8-8b31f9a05e43','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD CreatedBy NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214233,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200266,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','53704635-02ba-4cb1-b166-08b6b27070a6','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214234,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200266,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','0f9a1dc0-55c3-4396-8bf8-5547ec3d6314','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214235,0.0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200266,'AD_Role_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,123,'Y','N','D','Y','N','N','Y','fe8cb3f5-3a35-4226-aa43-66a6015b0785','Y','N','N','adrole_aduserdefinfo','C','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD AD_Role_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214236,0.0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200266,'AD_User_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,138,'Y','N','D','Y','N','N','Y','79532b19-8765-4cd9-af0a-fb3a7a063202','Y','N','N','aduser_aduserdefinfo','N','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD AD_User_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214237,0.0,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',200266,'AD_InfoWindow_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,3068,'N','N','D','Y','N','N','Y','355c6b3b-a540-4bf5-983d-3a5ac0a6dc78','Y','N','N','C','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD AD_InfoWindow_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214238,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200266,'Name',60,'N','N','N','N','Y','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','Y','N','N','Y','cf743c89-f7dd-4679-aa63-9dc34b4b5cc5','Y',10,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD Name VARCHAR2(60 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214239,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200266,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','d787f330-ec55-4874-87c5-4f3ee56cec7b','Y',20,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214240,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200266,'Help',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','701db25f-33b4-4e8b-afde-38cc917f594e','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD Help VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:56 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214241,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200266,'AD_Language',6,'N','N','N','N','N','N',18,106,0,0,'Y',TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,109,'Y','N','D','Y','N','N','Y','22154794-072c-4240-891e-ad3623df3b93','Y','N','N','adlangu_aduserdefinfo','N','N')
;

-- Sep 29, 2020, 7:26:56 AM CEST
ALTER TABLE AD_UserDef_Info ADD AD_Language VARCHAR2(6 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203436,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_UU','AD_UserDef_Info_UU','AD_UserDef_Info_UU','D','445df916-338b-4a70-8838-a7331b4d25c2')
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214245,0.0,'AD_UserDef_Info_UU',200266,'AD_UserDef_Info_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,203436,'N','N','D','Y','N','N','Y','04f2c9c7-d3e3-4847-93b0-edb8fc829af0','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info ADD AD_UserDef_Info_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info ADD CONSTRAINT AD_UserDef_Info_UU_idx UNIQUE (AD_UserDef_Info_UU)
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200268,'User defined Info Window Column','AD_UserDef_Info_Column',135,'6',0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','Y','50038b97-2f94-40f0-8ae2-79b517c07390','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Info_Column',1000000,'N','N','Table AD_UserDef_Info_Column','Y','Y',0,0,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,200333,'Y',1000000,1,200000,'9100f403-1c05-42b3-9cb7-889e024f201f')
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203434,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_Column_ID','User defined Info Column','User Info Column','D','c6764b46-7e2f-47f7-93dc-fd2485211131')
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214271,0.0,'User defined Info Column',200268,'AD_UserDef_Info_Column_ID',10,'Y','N','Y','N','N','N',13,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,203434,'N','N','D','Y','N','N','Y','b370b463-85ec-41d2-aa8f-2a121041d7a7','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
CREATE TABLE AD_UserDef_Info_Column (AD_UserDef_Info_Column_ID NUMBER(10) NOT NULL, CONSTRAINT AD_UserDef_Info_Column_Key PRIMARY KEY (AD_UserDef_Info_Column_ID))
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214272,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200268,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','d39252c7-ae85-458c-b20b-9e13c47b7808','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214273,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200268,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','2c6e10f1-d702-4f9a-9420-1e3b8b7d49f7','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214274,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200268,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','dc7884f2-06ca-419f-bfdc-025b1f94de88','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214275,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200268,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','bf072bc6-b62b-4a04-acaa-e015c235c0cc','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214276,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200268,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','2056c54d-0543-4454-b660-28a3dba7ed1c','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD CreatedBy NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214277,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200268,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','e9767da8-79cd-4cf0-9acf-52a33269ee2b','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214278,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200268,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','857ea778-427d-4e25-8ba8-7dcbe2261069','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214279,0.0,'Info Column','Info Window Column','Column in the Info Window for display and/or selection.  If used for selection, the column cannot be a SQL expression. The SQL clause must be fully qualified based on the FROM clause in the Info Window definition',200268,200065,'AD_InfoColumn_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,3069,'N','N','D','Y','N','N','Y','c8b226ca-a750-4f36-bbae-f0c9d8d681b8','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD AD_InfoColumn_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214280,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200268,'Name',60,'N','N','N','N','Y','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','Y','N','N','Y','2a4a9c5a-7abc-4556-b793-a021b9cd881b','Y',10,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD Name VARCHAR2(60 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214281,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200268,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','dc13fdf2-6024-45f1-b5e1-1f038a471378','Y',20,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214282,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200268,'Help',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','1ca3f676-fc63-4a53-9093-d3971d3da078','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD Help VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203438,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_Column_UU','AD_UserDef_Info_Column_UU','AD_UserDef_Info_Column_UU','D','5caacb44-b85b-4041-aca9-c2537b53ce49')
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214283,0.0,'AD_UserDef_Info_Column_UU',200268,'AD_UserDef_Info_Column_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,203438,'N','N','D','Y','N','N','Y','515c5930-6520-4e23-8dd2-a3046d30c573','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD AD_UserDef_Info_Column_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD CONSTRAINT AD_UserDef_Info_Column_UU_idx UNIQUE (AD_UserDef_Info_Column_UU)
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214286,0.0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200268,'SeqNo',10,'N','N','Y','N','N','N',11,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','Y','N','N','Y','ade452ae-74c9-4c71-baff-7f5e98a35df0','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD SeqNo NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214287,0.0,'Displayed','Determines, if this field is displayed','If the field is displayed, the field Display Logic will determine at runtime, if it is actually displayed',200268,'IsDisplayed',1,'N','N','N','N','N','N',17,319,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,368,'Y','N','D','Y','N','N','Y','0f88487a-4f36-44a3-957b-88c5cbace276','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD IsDisplayed CHAR(1) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214288,0.0,'Query Criteria','The column is also used as a query criteria','The column is used to enter queries - the SQL cannot be an expression',200268,'IsQueryCriteria',1,'N','N','N','N','N','N',17,319,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,3070,'Y','N','D','Y','N','N','Y','15006214-23ce-4ee9-98c8-938401993124','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD IsQueryCriteria CHAR(1) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214290,0.0,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',200268,'AD_Reference_ID',10,'N','N','N','N','N','N',18,1,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,120,'Y','N','D','Y','N','N','Y','9fe08529-33ae-4a29-b0d5-fa3268fd13fc','Y','N','N','adreference_aduserdefcolumn','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD AD_Reference_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214292,0.0,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',200268,115,'AD_Reference_Value_ID',10,'N','N','N','N','N','N',18,4,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,121,'Y','N','D','Y','N','N','Y','fda4d3fe-9b79-4c5c-b51d-8023dcbd3cee','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD AD_Reference_Value_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214293,0.0,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',200268,'AD_Val_Rule_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,139,'Y','N','D','Y','N','N','Y','7db14722-0d54-4cd1-be09-3341053e3ea2','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD AD_Val_Rule_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214295,0.0,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)',200268,'DisplayLogic',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,283,'Y','N','D','Y','N','N','Y','06877dff-75a8-4d5c-b9a2-86e08406cbb7','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD DisplayLogic VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214297,0.0,'Query Operator','Operator for database query',200268,'QueryOperator',10,'N','N','N','N','N','N',17,200061,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,202188,'Y','N','D','Y','N','@IsQueryCriteria@=Y','N','Y','f77da0c5-bdac-40a9-83e3-9c1e2c0a86ac','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD QueryOperator VARCHAR2(10 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214298,0.0,'Query Function','Database function for query','Database function for user query. If the database function takes more than just the column name parameter, use ? to indicate where the column name should goes to. E.g: Upper, Trunc and To_Char(?,''MM'')',200268,'QueryFunction',2000,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,202189,'Y','N','D','Y','N','N','Y','df3004cf-ef37-4c71-869f-54e3b31281ba','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD QueryFunction VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214300,0.0,'Selection Column Sequence','Selection Column Sequence','For ordering sequence of selection column',200268,'SeqNoSelection','0',10,'N','N','N','N','N','N',11,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,200096,'Y','N','D','Y','N','N','Y','4248b59c-2f42-47f9-8f7c-65c8a0aa591b','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD SeqNoSelection NUMBER(10) DEFAULT 0
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214305,0.0,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',200268,'DefaultValue',2000,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,272,'Y','N','D','Y','N','N','Y','7f881248-d5d8-4b64-910b-cca588e38931','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:57 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD DefaultValue VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:57 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214307,0.0,'Mandatory','Data entry is required in this column','The field must have a value for the record to be saved to the database.',200268,'IsMandatory',1,'N','N','N','N','N','N',17,319,0,0,'Y',TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:57','YYYY-MM-DD HH24:MI:SS'),100,392,'Y','N','D','Y','N','N','Y','409d763f-d6a0-46a7-9d16-4834a5de43af','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD IsMandatory CHAR(1) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214309,0.0,'Read Only','Field is read only','The Read Only indicates that this field may only be Read.  It may not be updated.',200268,'IsReadOnly',1,'N','N','N','N','N','N',17,319,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,405,'Y','N','D','Y','N','N','Y','0c9661b8-33e5-49fe-a9be-411db249faf3','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD IsReadOnly CHAR(1) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214310,0.0,'Placeholder',200268,'Placeholder',255,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','Y','N','N','Y','8abd7b94-9da0-487f-a1dc-ca2f02ccae47','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD Placeholder VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214311,0.0,'Input field validation','Input field validaton query','Input field validaton query',200268,'InputFieldValidation',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,203216,'Y','N','D','Y','N','N','Y','13dba0ff-8984-49a6-9876-2562a96a4aa1','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD InputFieldValidation VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214312,0.0,'Field Style','Field CSS Style ',200268,'AD_FieldStyle_ID',10,'N','N','N','N','N','N',18,200121,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,203012,'Y','N','D','Y','N','N','Y','b760d164-353e-4e61-98e9-61b4c1a7b2af','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD AD_FieldStyle_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214313,0.0,'Autocomplete','Automatic completion for textfields','The autocompletion uses all existing values (from the same client and organization) of the field.',200268,'IsAutocomplete',1,'N','N','N','N','N','N',17,319,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,53655,'Y','N','D','Y','N','N','Y','1ae09f15-49e6-42c1-a802-a43c410f857b','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD IsAutocomplete CHAR(1) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214314,0,'User defined Info Window',200268,'AD_UserDef_Info_ID','@AD_UserDef_Info_ID@',22,'N','Y','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,203433,'N','N','D','Y','N','N','Y','8758377a-2340-4fb1-9f59-9949d1a3dcab','Y',0,'N','N','ADUserDefInfo_ADUserDefInfoCol','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD AD_UserDef_Info_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200267,'User defined Info Window Related','AD_UserDef_Info_Related',135,'6',0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','Y','c7a35973-e80a-45a3-885f-ced286ba7d10','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Info_Related',1000000,'N','N','Table AD_UserDef_Info_Related','Y','Y',0,0,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,200334,'Y',1000000,1,200000,'55a3ccf3-6dad-4b0c-992a-ab53ec67041d')
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203435,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_Related_ID','User defined Info Related','User Info Related','D','60154684-1e81-4868-8295-99c3f8d22fbc')
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214246,0.0,'User defined Info Related',200267,'AD_UserDef_Info_Related_ID',10,'Y','N','Y','N','N','N',13,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,203435,'N','N','D','Y','N','N','Y','ee258c88-b40b-47eb-9336-367ffaaf0c4f','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
CREATE TABLE AD_UserDef_Info_Related (AD_UserDef_Info_Related_ID NUMBER(10) NOT NULL, CONSTRAINT AD_UserDef_Info_Related_Key PRIMARY KEY (AD_UserDef_Info_Related_ID))
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214247,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200267,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','75d6a16c-350f-435d-ad3a-14c3bd766de4','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214248,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200267,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','6f22c7ac-8e32-4d38-9dfb-6708920a6d14','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214249,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200267,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','0c7aabc6-4a40-42b0-b05a-44cdd06006bf','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214250,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200267,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','268d8df0-7714-40ad-a745-63f91b4921e2','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214251,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200267,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','8c0d4db1-8807-4646-b7c4-60c6a42040ee','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD CreatedBy NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214252,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200267,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','4b228dfd-2fd0-4b47-8879-b33d45e26cf8','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214253,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200267,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','16493810-fd33-4ca6-bb8d-20800c7a1184','N','N','N','D','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214254,0.0,'User defined Info Window',200267,'AD_UserDef_Info_ID','@AD_UserDef_Info_ID@',10,'N','Y','Y','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,203433,'N','N','D','Y','N','N','Y','9f604bf1-cfa8-49c1-a180-3aecfa55d681','Y','N','N','ADUserDefInfo_ADUserDefInfoRel','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD AD_UserDef_Info_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200141,'AD_InfoRelated Windows','S','AD_InfoRelated.AD_InfoWindow_ID=@AD_InfoWindow_ID@',0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,'D','1857d9ec-905b-4352-922d-dd9e46fab36c')
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214255,0.0,'InfoRelated',200267,200141,'AD_InfoRelated_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,202556,'N','N','D','Y','N','N','Y','33359872-aa10-4fa2-bc06-5d1a828c971f','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD AD_InfoRelated_ID NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214256,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200267,'Name',60,'N','N','N','N','Y','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','Y','N','N','Y','887484d9-7533-474a-b0dd-f5bf391398c8','Y',10,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD Name VARCHAR2(60 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214257,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200267,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','004544c7-eb56-47dc-8e3f-2205c9a9e047','Y',20,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214258,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200267,'Help',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','382d2129-4772-4554-8086-16bfea67929c','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD Help VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203437,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_Related_UU','AD_UserDef_Info_Related_UU','AD_UserDef_Info_Related_UU','D','61fbc58b-539b-4181-9eac-91867d39a6cf')
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214261,0.0,'AD_UserDef_Info_Related_UU',200267,'AD_UserDef_Info_Related_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,203437,'N','N','D','Y','N','N','Y','f0b0a8d8-3e22-4504-83fd-b50b49fea309','N','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD AD_UserDef_Info_Related_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD CONSTRAINT AD_UserDef_Info_Related_UU_idx UNIQUE (AD_UserDef_Info_Related_UU)
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214266,0.0,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)',200267,'DisplayLogic',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,283,'Y','N','D','Y','N','N','Y','93ce9482-7fb4-4d54-97b0-51da098363c3','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD DisplayLogic VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214270,0.0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200267,'SeqNo',10,'N','N','Y','N','N','N',11,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','Y','N','N','Y','1b5028d1-38db-41c5-9743-be85a4964b64','Y','N','N','N','N')
;

-- Sep 29, 2020, 7:26:58 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD SeqNo NUMBER(10) NOT NULL
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,MaxQueryRecords) VALUES (200279,'Column Customization',200110,20,'Y',200268,0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','Y','N','50258ad1-c73b-4b4e-9a84-098d8a8ca2a7','B',0)
;

-- Sep 29, 2020, 7:26:58 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206436,'User defined Info Column',200279,214271,'N',10,0,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2cceba74-a3db-488f-b061-91e840f8f8ca','N',1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206438,'AD_UserDef_Info_Column_UU',200279,214283,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ac44dab5-36be-4e7b-a87f-76fe91105761','N',1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206431,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200279,214272,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','7c671412-91ba-4107-aa6c-75c24aa29b88','Y',10,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206432,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200279,214273,'Y',10,20,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d9761524-5421-4a92-842e-ba7dca73b2cc','Y','N',4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206506,'User defined Info Window',200279,214314,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','166e9f9d-d7ec-478c-bb64-54e4c7355f8a','Y',370,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206437,'Info Column','Info Window Column','Column in the Info Window for display and/or selection.  If used for selection, the column cannot be a SQL expression. The SQL clause must be fully qualified based on the FROM clause in the Info Window definition',200279,214279,'Y',10,40,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','032bdc84-f757-4643-a618-8d6602c9b81e','Y',50,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206433,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200279,214280,'Y',60,50,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5d7bbb44-7fe3-47fe-95d2-178256d95c93','Y',20,1,5,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206434,'Description','Optional short description of the record','A description is limited to 255 characters.',200279,214281,'Y',255,60,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f5903082-8d4b-44c0-964a-28cf4161c5a2','Y',30,1,5,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206435,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200279,214282,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1e423ac8-03ab-48cc-99b6-850d34002185','Y',40,1,5,3,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206469,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200279,214274,'Y',1,80,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c3bee628-857f-4315-9b60-422cb7b65001','Y',360,2,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206443,'Query Criteria','The column is also used as a query criteria','The column is used to enter queries - the SQL cannot be an expression',200279,214288,'Y',1,90,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a332223d-88d0-4582-8038-f3e9a5c40dc2','Y',100,4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206441,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200279,214286,'Y',10,100,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','222e8de0-2c92-4eb6-94e3-3a89e8469e7b','Y',80,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206455,'Selection Column Sequence','Selection Column Sequence','For ordering sequence of selection column',200279,214300,'Y',10,110,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c4bfa94a-2b68-47de-974c-c0fe0378dc99','Y',220,4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206442,'Displayed','Determines, if this field is displayed','If the field is displayed, the field Display Logic will determine at runtime, if it is actually displayed',200279,214287,'Y',1,120,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f9bcf547-4868-4798-8b91-95d0c69c664f','Y',90,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206464,'Read Only','Field is read only','The Read Only indicates that this field may only be Read.  It may not be updated.',200279,214309,'Y',1,130,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','33e258bb-49f5-4007-8339-b7274a9fab6d','Y',310,4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206462,'Mandatory','Data entry is required in this column','The field must have a value for the record to be saved to the database.',200279,214307,'Y',1,150,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1b1c69a5-25d1-49b2-bb1e-aa75cae10f1f','Y',290,4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206450,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)',200279,214295,'Y',2000,160,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','97feaea9-fbd1-4b7a-b037-b03ee26721c5','Y',170,1,5,3,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206460,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',200279,214305,'Y',2000,170,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3af2c09a-f1d4-4194-9b65-173a2af8e4de','Y',270,1,5,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206467,'Field Style','Field CSS Style ',200279,214312,'Y',10,180,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3d662531-ed79-492b-81b0-d08d0cf4db6b','Y',340,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206468,'Autocomplete','Automatic completion for textfields','The autocompletion uses all existing values (from the same client and organization) of the field.',200279,214313,'Y',1,190,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','acb3ab3e-f88e-484f-ac3f-75720877d3f6','Y',350,4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206465,'Placeholder',200279,214310,'Y',255,200,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','813f1a59-3764-45e3-9214-e0adeea8662e','Y',320,1,5,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206445,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',200279,214290,'Y',10,210,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',200004,'D','be75ecf9-7d02-460e-a286-bc16b7fce809','Y',120,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206448,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',200279,214293,'Y',10,220,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ad8fc99f-339e-4ce0-adf2-cdb7e1db56e9','Y',150,4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206447,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',200279,214292,'Y',10,230,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','63cf963c-c92b-4f9d-94c8-4cc5f53dd4ab','Y',140,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206453,'Query Function','Database function for query','Database function for user query. If the database function takes more than just the column name parameter, use ? to indicate where the column name should goes to. E.g: Upper, Trunc and To_Char(?,''MM'')',200279,214298,'Y',2000,240,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cccabe72-d84e-4e76-a802-fb5ae612072b','Y',200,4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206452,'Query Operator','Operator for database query',200279,214297,'Y',10,250,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','10107421-94ef-4971-906a-d554f65ff4ea','Y',190,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206466,'Input field validation','Input field validaton query','Input field validaton query',200279,214311,'Y',2000,300,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','681cad79-973b-4729-9038-a768de6a2157','Y',330,1,5,3,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,MaxQueryRecords) VALUES (200280,'Info Window Customization',200110,10,'Y',200266,0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','e939cff1-b690-4902-97f0-2443609cc00e','B',0)
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206470,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200280,214228,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','25bc5758-768c-4ac7-911b-c6f300b20794','Y',10,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206471,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200280,214229,'Y',10,20,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','43009af9-0b73-4cc6-9af9-9de872e352d1','Y','N',4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206472,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200280,214238,'Y',60,30,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4fb3e4fb-7508-4a26-8139-a521fd641398','Y',20,1,5,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206473,'Description','Optional short description of the record','A description is limited to 255 characters.',200280,214239,'Y',255,40,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','790e76b3-a79d-484c-8a35-7b815a9e080f','Y',30,1,5,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206474,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200280,214240,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4a91902b-1b73-450a-88c5-864c1ae5935f','Y',40,1,5,3,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206476,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200280,214235,'Y',10,60,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','141c6f74-1b7c-4898-8add-34d13d6525ad','Y',50,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206477,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200280,214236,'Y',10,70,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','602ae35f-8474-4f3d-922b-cd0fed2edb08','Y',60,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206478,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',200280,214237,'Y',10,80,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6308fcb5-5f1d-4aa3-8376-8fc7aa54bb53','Y',70,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206479,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200280,214241,'Y',6,90,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','65a5db92-f50f-4cde-a274-3edaacc2d120','Y',80,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206484,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200280,214230,'Y',1,130,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f3800950-3c95-4b9d-9319-d9c249438159','Y',120,2,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206483,'AD_UserDef_Info_UU',200280,214245,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c5cf65a9-aa5a-48cd-a064-9cbb06429187','N',1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206475,'User defined Info Window',200280,214227,'N',10,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','93d70a87-d7bb-4900-8477-e2314b09394c','N',1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,MaxQueryRecords) VALUES (200281,'Related Customization',200110,30,'Y',200267,0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','Y','N','b592e5b9-2a8b-4f14-8639-f7b003539224','B',0)
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206500,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)',200281,214266,'Y',2000,0,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a5af0d4-bf0a-44ec-b11a-fc2814adbb70','Y',130,1,5,3,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206495,'AD_UserDef_Info_Related_UU',200281,214261,'N',36,0,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','091580eb-5bd1-4be2-b866-3d3dd920054f','N',1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206490,'User defined Info Related',200281,214246,'N',10,0,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a14984f-f64e-43bb-be0f-ae19ea493e8c','N',1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206485,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200281,214247,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','8540ad53-e8c1-41ea-b0b2-218fade7afc7','Y',10,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206486,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200281,214248,'Y',10,20,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','82d03105-cd2d-43af-be66-c349e46c373f','Y','N',4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206491,'User defined Info Window',200281,214254,'Y',10,30,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','d1e8b5ea-e001-48e5-924e-859ed79b6cdc','Y',50,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206487,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200281,214256,'Y',60,40,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b2eae256-2ed0-40b9-b92d-c5fcdbddff83','Y',20,1,5,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206488,'Description','Optional short description of the record','A description is limited to 255 characters.',200281,214257,'Y',255,50,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a14e0b20-2f08-48ef-af67-b9f0fa29b76f','Y',30,1,5,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206489,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200281,214258,'Y',2000,60,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','80840f5a-cf76-435c-a26d-c200fd1c5522','Y',40,1,5,3,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206492,'InfoRelated',200281,214255,'Y',10,70,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a8d3e0c3-a6d7-4209-8200-a5375131df0a','Y',60,1,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206504,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200281,214270,'Y',10,80,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','51d6bf36-4654-4591-9cee-4c7e00cf9ef4','Y',170,4,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:26:59 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206505,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200281,214249,'Y',1,90,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-29 07:26:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8aa5de2b-f9c0-4333-a302-dd572a688fc0','Y',180,2,2,1,'N','N','N','N')
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info ADD CONSTRAINT adrole_aduserdefinfo FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info ADD CONSTRAINT aduser_aduserdefinfo FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_Column SET FKConstraintName='ADInfoWindow_ADUserDefInfo', FKConstraintType='C',Updated=TO_DATE('2020-09-29 07:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214237
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info ADD CONSTRAINT ADInfoWindow_ADUserDefInfo FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info ADD CONSTRAINT adlangu_aduserdefinfo FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_Column SET FKConstraintName='ADInfoColumn_ADUserDefInfoColu', FKConstraintType='N',Updated=TO_DATE('2020-09-29 07:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214279
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD CONSTRAINT ADInfoColumn_ADUserDefInfoColu FOREIGN KEY (AD_InfoColumn_ID) REFERENCES ad_infocolumn(ad_infocolumn_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD CONSTRAINT adreference_aduserdefcolumn FOREIGN KEY (AD_Reference_ID) REFERENCES ad_reference(ad_reference_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_Column SET FKConstraintName='ADReferenceValue_ADUserDefInfo', FKConstraintType='N',Updated=TO_DATE('2020-09-29 07:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214292
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD CONSTRAINT ADReferenceValue_ADUserDefInfo FOREIGN KEY (AD_Reference_Value_ID) REFERENCES ad_reference(ad_reference_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_Column SET FKConstraintName='ADValRule_ADUserDefInfoColumn', FKConstraintType='N',Updated=TO_DATE('2020-09-29 07:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214293
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD CONSTRAINT ADValRule_ADUserDefInfoColumn FOREIGN KEY (AD_Val_Rule_ID) REFERENCES ad_val_rule(ad_val_rule_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_Column SET FKConstraintName='ADFieldStyle_ADUserDefInfoColu', FKConstraintType='N',Updated=TO_DATE('2020-09-29 07:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214312
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD CONSTRAINT ADFieldStyle_ADUserDefInfoColu FOREIGN KEY (AD_FieldStyle_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info_Column ADD CONSTRAINT ADUserDefInfo_ADUserDefInfoCol FOREIGN KEY (AD_UserDef_Info_ID) REFERENCES ad_userdef_info(ad_userdef_info_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD CONSTRAINT ADUserDefInfo_ADUserDefInfoRel FOREIGN KEY (AD_UserDef_Info_ID) REFERENCES ad_userdef_info(ad_userdef_info_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_Column SET FKConstraintName='ADInfoRelated_ADUserDefInfoRel', FKConstraintType='N',Updated=TO_DATE('2020-09-29 07:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214255
;

-- Sep 29, 2020, 7:27:00 AM CEST
ALTER TABLE AD_UserDef_Info_Related ADD CONSTRAINT ADInfoRelated_ADUserDefInfoRel FOREIGN KEY (AD_InfoRelated_ID) REFERENCES ad_inforelated(ad_inforelated_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2020, 7:27:00 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200174,'Info Window Customization','Define Info Window Customization for Role/User','W',200110,0,0,'Y',TO_DATE('2020-09-16 10:38:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-16 10:38:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','Y','b13e8923-8016-46ee-a687-0e12ca0a8391')
;

-- Sep 29, 2020, 7:27:00 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200174, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200174)
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200145
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200142
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53203
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=586
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=138
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=139
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200065
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200063
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=249
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200072
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200150
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=27, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200174
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=28, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=29, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=30, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=31, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200143
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=32, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- Sep 29, 2020, 7:27:00 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=33, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Oct 11, 2020, 4:34:07 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206476
;

-- Oct 11, 2020, 4:34:07 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206477
;

-- Oct 11, 2020, 4:34:07 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206478
;

-- Oct 11, 2020, 4:34:07 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206484
;

-- Oct 11, 2020, 4:34:07 PM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206472
;

-- Oct 11, 2020, 4:34:07 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206473
;

-- Oct 11, 2020, 4:34:07 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206474
;

-- Oct 11, 2020, 4:34:07 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206479
;

-- Oct 11, 2020, 4:34:07 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206483
;

-- Oct 11, 2020, 4:34:07 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:34:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206475
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206437
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206441
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206455
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206442
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206464
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206443
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206462
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206450
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206460
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206467
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206468
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206465
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206445
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206448
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206447
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206453
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206452
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206469
;

-- Oct 11, 2020, 4:55:52 PM CEST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:55:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206466
;

-- Oct 11, 2020, 4:56:15 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:56:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206492
;

-- Oct 11, 2020, 4:56:15 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:56:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206487
;

-- Oct 11, 2020, 4:56:15 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:56:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206488
;

-- Oct 11, 2020, 4:56:15 PM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:56:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206489
;

-- Oct 11, 2020, 4:56:15 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:56:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206504
;

-- Oct 11, 2020, 4:56:15 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-11 16:56:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206505
;

-- Oct 11, 2020, 4:58:25 PM CEST
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=10,Updated=TO_DATE('2020-10-11 16:58:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214237
;

-- Oct 11, 2020, 4:58:35 PM CEST
UPDATE AD_Column SET SeqNo=20,Updated=TO_DATE('2020-10-11 16:58:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214238
;

-- Oct 11, 2020, 5:00:40 PM CEST
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=2,Updated=TO_DATE('2020-10-11 17:00:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15787
;

-- Oct 11, 2020, 5:01:39 PM CEST
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=3,Updated=TO_DATE('2020-10-11 17:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15788
;

-- Oct 11, 2020, 5:01:55 PM CEST
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=4,Updated=TO_DATE('2020-10-11 17:01:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15789
;

-- Oct 11, 2020, 5:03:52 PM CEST
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_DATE('2020-10-11 17:03:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214286
;

-- Oct 11, 2020, 5:04:00 PM CEST
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_DATE('2020-10-11 17:04:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214300
;

-- Oct 11, 2020, 5:05:18 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2020-10-11 17:05:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214286
;

-- Oct 11, 2020, 5:05:20 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY SeqNo NUMBER(10) DEFAULT NULL
;

-- Oct 11, 2020, 5:05:20 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY SeqNo NULL
;

-- Oct 11, 2020, 5:06:35 PM CEST
UPDATE AD_Column SET DefaultValue='NULL', IsMandatory='N',Updated=TO_DATE('2020-10-11 17:06:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214270
;

-- Oct 11, 2020, 5:06:36 PM CEST
ALTER TABLE AD_UserDef_Info_Related MODIFY SeqNo NUMBER(10) DEFAULT NULL
;

-- Oct 11, 2020, 5:06:36 PM CEST
ALTER TABLE AD_UserDef_Info_Related MODIFY SeqNo NULL
;

SELECT register_migration_script('202009290730_IDEMPIERE-4459.sql') FROM dual
;
