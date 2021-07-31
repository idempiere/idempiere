SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4782 Multi-factor authentication (FHCA-2034)
-- Jun 7, 2021, 9:39:32 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203515,0,0,'Y',TO_DATE('2021-06-07 21:39:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:39:32','YYYY-MM-DD HH24:MI:SS'),100,'MFALastSecret','Last MFA Secret','Last MFA Secret','D','e65db29f-25a3-4b07-acd3-1d442897e22f')
;

-- Jun 7, 2021, 9:02:33 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214500,0,'Last MFA Secret',200275,'MFALastSecret',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-06-07 21:02:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:02:32','YYYY-MM-DD HH24:MI:SS'),100,203515,'Y','N','D','N','N','N','Y','13927461-61b7-4008-b867-25147cbc6eb3','Y',0,'N','N','N','N')
;

-- Jun 7, 2021, 9:02:59 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203513,0,0,'Y',TO_DATE('2021-06-07 21:02:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:02:48','YYYY-MM-DD HH24:MI:SS'),100,'LastSuccess','Last Success',NULL,NULL,'Last Success','D','b9882967-1536-463b-ba6b-e185ea647e20')
;

-- Jun 7, 2021, 9:03:07 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214501,0,'Last Success',200275,'LastSuccess',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-06-07 21:03:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:03:07','YYYY-MM-DD HH24:MI:SS'),100,203513,'Y','N','D','N','N','N','Y','b71e7f11-90be-4596-8368-26fd0a0606af','Y',0,'N','N','N','N')
;

-- Jun 7, 2021, 9:03:32 PM CEST
ALTER TABLE MFA_Registration ADD MFALastSecret VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Jun 7, 2021, 9:03:56 PM CEST
ALTER TABLE MFA_Registration ADD LastSuccess DATE DEFAULT NULL 
;

-- Jun 7, 2021, 9:04:16 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203514,0,0,'Y',TO_DATE('2021-06-07 21:04:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:04:09','YYYY-MM-DD HH24:MI:SS'),100,'LastFailure','Last Failure',NULL,NULL,'Last Failure','D','d1f7a3ad-db3c-47a1-9d6a-67163d72a88d')
;

-- Jun 7, 2021, 9:04:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214502,0,'Last Failure',200275,'LastFailure',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_DATE('2021-06-07 21:04:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:04:20','YYYY-MM-DD HH24:MI:SS'),100,203514,'Y','N','D','N','N','N','Y','3dff6b96-912a-405e-bcf4-662466d708f6','Y',0,'N','N','N','N')
;

-- Jun 7, 2021, 9:04:21 PM CEST
ALTER TABLE MFA_Registration ADD LastFailure DATE DEFAULT NULL 
;

-- Jun 7, 2021, 9:04:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214503,0,'Failed Login Count',200275,'FailedLoginCount',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_DATE('2021-06-07 21:04:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:04:56','YYYY-MM-DD HH24:MI:SS'),100,200113,'N','N','D','N','N','N','Y','ab6cf862-137c-4b10-939a-f97b19dc3943','Y',0,'N','N','N','N')
;

-- Jun 7, 2021, 9:04:58 PM CEST
ALTER TABLE MFA_Registration ADD FailedLoginCount NUMBER(10) DEFAULT NULL 
;

-- Jun 7, 2021, 9:05:11 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206666,'Last MFA Secret',200290,214500,'Y',2000,160,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-07 21:05:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:05:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f1754863-8ed2-468c-be3a-6ebff14996a7','Y',150,5)
;

-- Jun 7, 2021, 9:05:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206667,'Last Success',200290,214501,'Y',7,170,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-07 21:05:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:05:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b2473190-ee58-47fb-b99a-d21242187b7f','Y',160,2)
;

-- Jun 7, 2021, 9:05:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206668,'Last Failure',200290,214502,'Y',7,180,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-07 21:05:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:05:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','57cce993-f54c-48c0-b130-384162ab73ea','Y',170,2)
;

-- Jun 7, 2021, 9:05:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206669,'Failed Login Count',200290,214503,'Y',10,190,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-07 21:05:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:05:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d5738f08-cdfe-4417-97c1-875db62bf899','Y',180,2)
;

-- Jun 7, 2021, 9:05:50 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-07 21:05:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206651
;

-- Jun 7, 2021, 9:05:50 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-07 21:05:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206652
;

-- Jun 7, 2021, 9:05:50 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-07 21:05:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206666
;

-- Jun 7, 2021, 9:05:50 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-07 21:05:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206667
;

-- Jun 7, 2021, 9:05:50 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-07 21:05:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206668
;

-- Jun 7, 2021, 9:05:50 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-07 21:05:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206669
;

-- Jun 7, 2021, 9:58:42 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The one-time validation code has been used, please try again with a different code',0,0,'Y',TO_DATE('2021-06-07 21:58:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-07 21:58:41','YYYY-MM-DD HH24:MI:SS'),100,200710,'MFACodeAlreadyConsumed','D','a1c11929-d6ae-410b-a57a-eb9f6259fbee')
;

SELECT register_migration_script('202106072201_IDEMPIERE-4782.sql') FROM dual
;

