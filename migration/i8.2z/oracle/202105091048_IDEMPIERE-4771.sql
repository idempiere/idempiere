SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 6, 2021, 5:49:33 PM MYT
UPDATE AD_Process SET Name='Add Authorization Account',Updated=TO_DATE('2021-05-06 17:49:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200128
;

-- May 6, 2021, 5:49:33 PM MYT
UPDATE AD_Menu SET Name='Add Authorization Account', Description=NULL, IsActive='Y',Updated=TO_DATE('2021-05-06 17:49:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200182
;

-- May 6, 2021, 8:35:15 PM MYT
UPDATE AD_Process_Para SET ReadOnlyLogic=NULL,Updated=TO_DATE('2021-05-06 20:35:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200335
;

-- May 6, 2021, 8:42:25 PM MYT
UPDATE AD_Val_Rule SET Code='AD_Ref_List.Value IN (
SELECT DISTINCT asp.AD_AuthorizationScope
FROM AD_AuthorizationScopeProv asp
WHERE asp.IsActive=''Y''
  AND asp.AD_Client_ID IN (0,@#AD_Client_ID@)
  AND EXISTS (SELECT 1
    FROM AD_AuthorizationCredential ac
    JOIN AD_AuthorizationProvider ap ON (ac.AD_AuthorizationProvider_ID=ap.AD_AuthorizationProvider_ID
      AND ap.IsActive=''Y''
      AND ap.AD_Client_ID IN (0,@#AD_Client_ID@))
    WHERE ac.AD_AuthorizationProvider_ID=asp.AD_AuthorizationProvider_ID 
      AND ac.IsActive=''Y''
      AND ac.AD_AuthorizationScopeList LIKE ''%''||asp.AD_AuthorizationScope||''%''
      AND ac.AD_Client_ID IN (0,@#AD_Client_ID@))
)',Updated=TO_DATE('2021-05-06 20:42:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200145
;

-- May 7, 2021, 4:28:29 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203484,0,0,'Y',TO_DATE('2021-05-07 16:28:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-07 16:28:28','YYYY-MM-DD HH24:MI:SS'),100,'IsUpload','Upload','Upload','D','80633b80-bba3-461e-82d1-2514d1d6186c')
;

-- May 7, 2021, 4:29:46 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214423,0,'Upload',704,'IsUpload','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-05-07 16:29:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-07 16:29:45','YYYY-MM-DD HH24:MI:SS'),100,203484,'Y','N','D','N','N','N','Y','2ee1e970-758a-4a0d-b318-5854fc61e2a0','N',0,'N','N','N','N')
;

-- May 7, 2021, 4:29:51 PM MYT
ALTER TABLE AD_SchedulerRecipient ADD IsUpload CHAR(1) DEFAULT 'N' CHECK (IsUpload IN ('Y','N')) NOT NULL
;

-- May 7, 2021, 4:35:11 PM MYT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200148,'AD_AuthorizationAccount of User (Document Scope)','S','AD_AuthorizationAccount.AD_User_ID=@AD_User_ID@ AND AD_AuthorizationAccount.AD_AuthorizationScope=''Document''',0,0,'Y',TO_DATE('2021-05-07 16:35:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-07 16:35:10','YYYY-MM-DD HH24:MI:SS'),100,'D','bd13a10f-26f4-4b2b-9a65-85faf35303e3')
;

-- May 7, 2021, 4:35:40 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214424,0,'Authorization Account',704,200148,'AD_AuthorizationAccount_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-05-07 16:35:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-07 16:35:39','YYYY-MM-DD HH24:MI:SS'),100,203467,'N','N','D','N','N','N','Y','5c2d33eb-301d-46c0-a13f-2ad9db1edfb6','N',0,'N','N','N','N')
;

-- May 7, 2021, 4:35:45 PM MYT
UPDATE AD_Column SET FKConstraintName='ADAuthorizationAccount_ADSched', FKConstraintType='N',Updated=TO_DATE('2021-05-07 16:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214424
;

-- May 7, 2021, 4:35:45 PM MYT
ALTER TABLE AD_SchedulerRecipient ADD AD_AuthorizationAccount_ID NUMBER(10) DEFAULT NULL 
;

-- May 7, 2021, 4:35:45 PM MYT
ALTER TABLE AD_SchedulerRecipient ADD CONSTRAINT ADAuthorizationAccount_ADSched FOREIGN KEY (AD_AuthorizationAccount_ID) REFERENCES ad_authorizationaccount(ad_authorizationaccount_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 7, 2021, 4:36:35 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214425,0,'File Name','Name of the local file or URL','Name of a file in the local directory space - or URL (file://.., http://.., ftp://..)',704,'FileName',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-05-07 16:36:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-07 16:36:35','YYYY-MM-DD HH24:MI:SS'),100,2295,'Y','N','D','N','N','N','Y','f1e841ca-64cc-4a76-902c-4dd3b66d96a1','N',0,'N','N','N')
;

-- May 7, 2021, 4:36:40 PM MYT
ALTER TABLE AD_SchedulerRecipient ADD FileName VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- May 7, 2021, 4:39:09 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206605,'Upload',639,214423,'Y','@AD_User_ID@>0',0,80,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-07 16:39:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-07 16:39:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','46cee751-46b4-42a8-9bc4-b0b3b59c57cb','Y',80,2,1,1,'N','N','N','N')
;

-- May 7, 2021, 4:40:02 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206606,'Authorization Account',639,214424,'Y','@AD_User_ID@>0 & @IsUpload@=Y',0,90,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-07 16:40:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-07 16:40:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cb00d48c-7de5-4b12-95a8-39cc402b3eb1','Y',90,1,2,1,'N','N','N','N')
;

-- May 7, 2021, 4:41:18 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206607,'File Name','Name of the local file or URL','Name of a file in the local directory space - or URL (file://.., http://.., ftp://..)',639,214425,'Y','@AD_User_ID@>0 & @IsUpload@=Y',0,100,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-05-07 16:41:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-07 16:41:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','12be3db7-c8a9-43b0-84a0-3ec1bdbfa517','Y',100,4,2,1,'N','N','N','N')
;

-- May 8, 2021, 6:12:43 AM MYT
UPDATE AD_Column SET IsIdentifier='Y',Updated=TO_DATE('2021-05-08 06:12:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214401
;

-- May 8, 2021, 6:12:53 AM MYT
UPDATE AD_Column SET SeqNo=10,Updated=TO_DATE('2021-05-08 06:12:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214401
;

-- May 8, 2021, 6:13:07 AM MYT
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=20,Updated=TO_DATE('2021-05-08 06:13:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214405
;

-- May 9, 2021, 6:36:31 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Cloud Upload',0,0,'Y',TO_DATE('2021-05-09 18:36:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-09 18:36:30','YYYY-MM-DD HH24:MI:SS'),100,200677,'CloudUpload','D','a1ecabfa-79fe-47f4-92d9-aad2946a2751')
;

-- May 9, 2021, 6:37:08 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Upload Failed',0,0,'Y',TO_DATE('2021-05-09 18:37:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-09 18:37:08','YYYY-MM-DD HH24:MI:SS'),100,200678,'UploadFailed','D','c7a087f0-7e8d-4896-b99a-d23332a198c0')
;

-- May 9, 2021, 6:37:42 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Upload Successful',0,0,'Y',TO_DATE('2021-05-09 18:37:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-09 18:37:41','YYYY-MM-DD HH24:MI:SS'),100,200679,'UploadSucess','D','2ce61461-c80b-4dae-9c71-a02ea7b749e0')
;

-- May 9, 2021, 6:39:06 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to send scheduler attachment',0,0,'Y',TO_DATE('2021-05-09 18:39:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-09 18:39:05','YYYY-MM-DD HH24:MI:SS'),100,200680,'SchedulerSendAttachmentFailed','D','5216aa31-8089-4500-a580-2afcd5df1916')
;

-- May 9, 2021, 6:39:44 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to send scheduler notification',0,0,'Y',TO_DATE('2021-05-09 18:39:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-09 18:39:43','YYYY-MM-DD HH24:MI:SS'),100,200681,'SchedulerSendNotificationFailed','D','2747dbf7-f04a-479e-b005-d5c9578f46dc')
;

-- May 9, 2021, 6:40:34 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Upload Action:',0,0,'Y',TO_DATE('2021-05-09 18:40:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-09 18:40:34','YYYY-MM-DD HH24:MI:SS'),100,200682,'UploadAction','D','f371db18-d552-47dd-94a5-1622c60eff56')
;

SELECT Register_Migration_Script ('202105091048_IDEMPIERE-4771.sql') FROM DUAL
;

