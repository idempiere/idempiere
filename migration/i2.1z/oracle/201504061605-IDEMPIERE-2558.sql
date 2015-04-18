SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2558:don't allow use old password when change password
-- Apr 6, 2015 6:42:41 PM ICT
INSERT INTO AD_Table (AD_Table_ID,Name,Help,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop) VALUES (200171,'Password History ID','Save password history to void user from reuse it for time range','AD_Password_History',0,'4',0,0,'Y',TO_DATE('2015-04-06 18:42:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','N','L','N','Y','49da1460-ff37-4f00-9ace-97bdf44db0ad','N','N')
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Password_History',1000000,'N','N','Table AD_Password_History','Y','Y',0,0,TO_DATE('2015-04-06 18:42:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:41','YYYY-MM-DD HH24:MI:SS'),100,200228,'Y',1000000,1,200000,'1a1cc6c7-d4ed-469f-91e6-42c4dff8a0fc')
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202871,0,0,'Y',TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,'AD_Password_History_ID','Password History ID','PasswordHistoryID','D','485e98ad-d7ba-4ce5-9569-09dd0d02ed46')
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212113,0,'Password History ID',200171,'AD_Password_History_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,202871,'N','N','D','Y','N','N','Y','991d817c-bb9d-425b-af2d-97db8c5617fd','N',0,'N','N','N')
;

-- Apr 6, 2015 6:42:42 PM ICT
CREATE TABLE AD_Password_History (AD_Password_History_ID NUMBER(10) DEFAULT NULL , CONSTRAINT AD_Password_History_Key PRIMARY KEY (AD_Password_History_ID))
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (212106,0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200171,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','N','a7778717-650f-4298-b050-bffbae429272','N',0,'N','N','ADClient_ADPasswordHistory','N')
;

-- Apr 6, 2015 6:42:42 PM ICT
ALTER TABLE AD_Password_History ADD AD_Client_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (212107,0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200171,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','N','8c9cd3ea-f1fb-454e-8f11-32333752e7f0','N',0,'N','N','ADOrg_ADPasswordHistory','N')
;

-- Apr 6, 2015 6:42:42 PM ICT
ALTER TABLE AD_Password_History ADD AD_Org_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (212108,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200171,'AD_User_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,138,'N','N','D','Y','N','N','N','7a7ebfcb-87e0-4550-9124-f2e109bfaa4c','N',0,'N','N','ADUser_ADPasswordHistory','N')
;

-- Apr 6, 2015 6:42:42 PM ICT
ALTER TABLE AD_Password_History ADD AD_User_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212109,0,'Password','Password of any length (case sensitive)','The Password for this User.  Passwords are required to identify authorized users.  For iDempiere Users, you can change the password via the Process "Reset Password".',200171,'Password',1024,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,498,'Y','N','D','Y','N','N','Y','ce12dd69-6a4f-403f-9637-683cbdd6f2f8','Y',0,'N','N','N')
;

-- Apr 6, 2015 6:42:42 PM ICT
ALTER TABLE AD_Password_History ADD Password VARCHAR2(1024) DEFAULT NULL 
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212110,0,'Salt','Random data added to improve password hash effectiveness',200171,'Salt',16,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,55218,'N','N','D','Y','N','N','Y','d24dd208-ea40-4e5d-ba95-fed28420e342','Y',0,'N','N','N')
;

-- Apr 6, 2015 6:42:42 PM ICT
ALTER TABLE AD_Password_History ADD Salt VARCHAR2(16) DEFAULT NULL 
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212111,0,'Date Password Changed',200171,'DatePasswordChanged',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,200114,'Y','N','D','Y','N','N','N','b01a8cde-f959-4364-ab89-d43d7382b504','Y',0,'N','N','N')
;

-- Apr 6, 2015 6:42:42 PM ICT
ALTER TABLE AD_Password_History ADD DatePasswordChanged DATE DEFAULT NULL 
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202870,0,0,'Y',TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,'AD_Password_History_UU','AD_Password_History_UU','AD_Password_History_UU','D','aea756f7-adec-4785-b603-d21266aa745b')
;

-- Apr 6, 2015 6:42:42 PM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212112,0,'AD_Password_History_UU',200171,'AD_Password_History_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:42','YYYY-MM-DD HH24:MI:SS'),100,202870,'N','N','D','Y','N','N','N','d0d514cb-4c02-441b-b8d5-93326e6b12c9','N',0,'N','N','N')
;

-- Apr 6, 2015 6:42:42 PM ICT
ALTER TABLE AD_Password_History ADD AD_Password_History_UU VARCHAR2(36) DEFAULT NULL 
;

-- Apr 6, 2015 6:42:42 PM ICT
ALTER TABLE AD_Password_History ADD CONSTRAINT AD_Password_History_UU_idx UNIQUE (AD_Password_History_UU)
;

-- Apr 6, 2015 6:42:43 PM ICT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201031,'ff68b691-ab99-4e65-886c-93b2741fade4',TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Password_History_uu_idx',TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),100,200171,'N','Y','N','N','N')
;

-- Apr 6, 2015 6:42:43 PM ICT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201256,'94ca3aa6-d1d5-4481-b787-d7f44297b71a',TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),100,212112,201031,0)
;

-- Apr 6, 2015 6:42:43 PM ICT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (202868,0,0,'Y',TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),100,'Days_Reuse_Password','Days Reuse Password','Define number of day can reuser password','Each time change password, old password keep in history
Example this value = 60. user can''t reuse password in history has age < 60
','Days Reuse Password','D','7f28c4dd-e1fb-41d6-a8b7-de18c205e6ac')
;

-- Apr 6, 2015 6:42:43 PM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212098,0,'Days Reuse Password','Define number of day can reuser password','Each time change password, old password keep in history
Example this value = 60. user can''t reuse password in history has age < 60
',200005,'Days_Reuse_Password',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),100,202868,'Y','N','D','Y','N','N','Y','57073b2e-e457-4445-96fd-4390d48fdd20','Y',0,'N','N','N')
;

-- Apr 6, 2015 6:42:43 PM ICT
ALTER TABLE AD_PasswordRule ADD Days_Reuse_Password NUMBER(10) DEFAULT NULL 
;

-- Apr 6, 2015 6:42:43 PM ICT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200075
;

-- Apr 6, 2015 6:42:43 PM ICT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203782,'Days Reuse Password','Define number of day can reuser password','Each time change password, old password keep in history
Example this value = 60. user can''t reuse password in history has age < 60
',200004,212098,'Y',0,150,0,'N','N','N','N',0,0,'Y',TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8585820b-9be4-4161-8d96-10a05ed80b10','Y',220,1,2,1,'N','N','N')
;

-- Apr 6, 2015 6:42:43 PM ICT
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200090
;

-- Apr 6, 2015 6:42:43 PM ICT
UPDATE AD_Field SET SeqNo=170,Updated=TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200094
;

-- Apr 6, 2015 6:42:43 PM ICT
UPDATE AD_Field SET SeqNo=180,Updated=TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200093
;

-- Apr 6, 2015 6:42:43 PM ICT
UPDATE AD_Field SET SeqNo=190,Updated=TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200079
;

-- Apr 6, 2015 6:42:43 PM ICT
UPDATE AD_Field SET IsActive='N',Updated=TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200080
;

-- Apr 6, 2015 6:42:43 PM ICT
UPDATE AD_Field SET SeqNo=200,Updated=TO_DATE('2015-04-06 18:42:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200254
;
SELECT register_migration_script('201504061605-IDEMPIERE-2558.sql') FROM dual
;

