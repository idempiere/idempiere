-- Sep 10, 2012 5:10:21 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsExpired',200126,'D','Expired','Expired','875fbbb0-2513-4a00-9f74-001bceab1f24',0,TO_DATE('2012-09-10 17:10:19','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-10 17:10:19','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 10, 2012 5:10:22 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200126 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 10, 2012 5:10:40 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,114,200456,'U','Y','N','N',0,'N',1,'N',20,'N','N',200126,'N','Y','a5c7128b-3935-41c0-aa78-8541972a7171','N','Y','N','IsExpired','N','Expired','Y',100,TO_DATE('2012-09-10 17:10:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-10 17:10:39','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 10, 2012 5:10:40 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200456 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 10, 2012 5:10:45 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-09-10 17:10:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200456
;

-- Sep 10, 2012 5:12:01 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
ALTER TABLE AD_User ADD IsExpired CHAR(1) DEFAULT 'N' CHECK (IsExpired IN ('Y','N')) NOT NULL
;

-- Sep 10, 2012 5:12:30 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('SecurityQuestion',200127,'D','Security Question','Security Question','11eefd52-bc27-4768-a8ca-71e4c481fd53',0,TO_DATE('2012-09-10 17:12:29','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-10 17:12:29','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 10, 2012 5:12:30 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200127 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 10, 2012 5:14:35 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,114,200457,'D','N','N','N',0,'N',255,'N',10,'N','N',200127,'N','Y','b92718ad-ac9d-40d7-929a-a1b34d9982fa','N','Y','N','SecurityQuestion','Security Question','Y',100,TO_DATE('2012-09-10 17:14:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-10 17:14:34','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 10, 2012 5:14:35 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200457 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 10, 2012 5:14:43 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
ALTER TABLE AD_User ADD SecurityQuestion NVARCHAR2(255) DEFAULT NULL 
;

-- Sep 10, 2012 5:14:58 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Answer',200128,'D','Answer','Answer','3d07421f-1ebf-49b1-9b0e-d7d4bbb0cc39',0,TO_DATE('2012-09-10 17:14:57','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-10 17:14:57','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 10, 2012 5:14:58 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200128 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 10, 2012 5:16:45 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,114,200458,'U','N','N','N',0,'N',1024,'N',10,'N','N',200128,'N','Y','cc25c82a-78b7-4831-81a2-4eae10c6b839','N','Y','N','Answer','Answer','Y',100,TO_DATE('2012-09-10 17:16:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-10 17:16:45','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 10, 2012 5:16:45 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200458 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 10, 2012 5:16:56 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-09-10 17:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200458
;

-- Sep 10, 2012 5:18:30 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
ALTER TABLE AD_User ADD Answer NVARCHAR2(1024) DEFAULT NULL 
;

-- Sep 10, 2012 5:19:50 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Reset Password',200044,'D','183be9be-6e0a-4cdc-82fd-c91efabfd586','ResetPassword','Y',TO_DATE('2012-09-10 17:19:49','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-10 17:19:49','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 5:19:51 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200044 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 10, 2012 5:20:14 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Security Question',200045,'D','74df2198-589e-4e80-93c3-6b300c5705b5','SecurityQuestion','Y',TO_DATE('2012-09-10 17:20:13','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-10 17:20:13','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 5:20:14 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200045 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 10, 2012 5:21:23 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Security Question is Mandatory',200048,'D','5c73ed0f-6ca9-45bc-8df7-e85f8bc3471d','SecurityQuestionMandatory','Y',TO_DATE('2012-09-10 17:21:22','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-10 17:21:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 5:21:23 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200048 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 10, 2012 5:21:43 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Answer is Mandatory',200049,'D','2a9de4c5-671b-4622-a8d4-b0fde148308d','AnswerMandatory','Y',TO_DATE('2012-09-10 17:21:43','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-10 17:21:43','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 5:21:43 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200049 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 10, 2012 5:22:14 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Invalid Security Question and Answer!',200050,'D','2904015f-ffe7-4179-a76d-5748700ea0ee','InvalidSecurityQuestionAndAnswer','Y',TO_DATE('2012-09-10 17:22:13','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-10 17:22:13','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 5:22:14 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200050 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 10, 2012 5:22:39 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,1024,'N','N',200458,'Y',200473,'N','D','Answer','N','Y','2e16932c-92d6-46a0-be21-70164101b156',100,0,TO_DATE('2012-09-10 17:22:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-10 17:22:38','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 10, 2012 5:22:39 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200473 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 10, 2012 5:22:41 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,1,'N','N',200456,'Y',200474,'N','D','Expired','N','Y','2b408d81-657b-473b-b425-b97e2d54dd3a',100,0,TO_DATE('2012-09-10 17:22:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-10 17:22:40','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 10, 2012 5:22:41 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200474 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 10, 2012 5:22:41 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',118,255,'N','N',200457,'Y',200475,'N','D','Security Question','N','Y','52bbd8a1-d84e-451d-8b79-63a8db9b9dbe',100,0,TO_DATE('2012-09-10 17:22:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-10 17:22:41','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 10, 2012 5:22:42 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200475 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 10, 2012 5:22:56 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=200474
;

-- Sep 10, 2012 5:22:56 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=200475
;

-- Sep 10, 2012 5:22:56 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=200473
;

-- Sep 10, 2012 5:23:06 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=200474
;

-- Sep 10, 2012 5:23:06 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y' WHERE AD_Field_ID=200475
;

-- Sep 10, 2012 5:23:06 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y' WHERE AD_Field_ID=200473
;

-- Sep 10, 2012 5:23:47 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-09-10 17:23:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200474
;

-- Sep 10, 2012 5:23:51 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-09-10 17:23:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200475
;

-- Sep 10, 2012 5:24:16 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET IsEncrypted='Y', IsSameLine='Y', IsReadOnly='Y',Updated=TO_DATE('2012-09-10 17:24:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200473
;

-- Sep 10, 2012 5:24:20 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET IsEncrypted='Y',Updated=TO_DATE('2012-09-10 17:24:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200475
;

-- Sep 10, 2012 5:24:59 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET DisplayLength=20,Updated=TO_DATE('2012-09-10 17:24:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200473
;

-- Sep 10, 2012 5:25:02 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET DisplayLength=20,Updated=TO_DATE('2012-09-10 17:25:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200475
;

-- Sep 10, 2012 6:23:18 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','What was your childhood nickname?',200051,'D','5f1d8902-cf42-4ebc-ac9a-40e08ccdd0e7','SecurityQuestion_1','Y',TO_DATE('2012-09-10 18:23:17','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-10 18:23:17','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 6:23:19 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200051 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 10, 2012 6:23:30 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Who was your childhood hero?',200052,'D','a6c718d8-1c4d-423d-a075-724c61d897bd','SecurityQuestion_2','Y',TO_DATE('2012-09-10 18:23:29','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-10 18:23:29','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 6:23:30 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200052 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 10, 2012 6:23:42 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','What was the name of your elementary / primary school?',200053,'D','f707f3be-69f3-4c3a-870e-5c366e9b2874','SecurityQuestion_3','Y',TO_DATE('2012-09-10 18:23:41','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-10 18:23:41','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 6:23:42 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200053 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 10, 2012 6:23:52 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','What are the last 5 digits of your driver''s license number?',200054,'D','c1e63df5-2df9-4970-ae78-24b75411d166','SecurityQuestion_4','Y',TO_DATE('2012-09-10 18:23:51','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-10 18:23:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 6:23:52 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200054 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 10, 2012 6:24:04 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Where did you meet your spouse / significant other?',200055,'D','0d1ffdfe-7e55-4796-ba95-7282154fe6fe','SecurityQuestion_5','Y',TO_DATE('2012-09-10 18:24:03','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-10 18:24:03','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 6:24:04 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200055 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 11, 2012 2:29:52 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-11 14:29:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200473
;

-- Sep 11, 2012 2:29:56 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-11 14:29:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200475
;

-- Sep 11, 2012 2:31:07 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2012-09-11 14:31:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200474
;

-- Sep 11, 2012 4:08:26 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO R_MailText (MailText,IsHtml,MailHeader,R_MailText_ID,Name,UpdatedBy,AD_Client_ID,Updated,CreatedBy,AD_Org_ID,IsActive,Created,R_MailText_UU) VALUES ('Dear @Name@,

You are receiving this email because you (or somebody pretending to be you) said you have lost your iDempiere password.

To access your iDempiere, use the temporary password from @AD_Client_ID<Name>@ below:
@Password@

Once you login, you will be directed to change password screen. Please change your password to something you can remember.

Sincerely,
The iDempiere Accounts Team

Note: This email address cannot accept replies.','N','iDempiere Reset Password ',200000,'Reset Password',100,0,TO_DATE('2012-09-11 16:08:24','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-09-11 16:08:24','YYYY-MM-DD HH24:MI:SS'),'b8938ab2-d3e8-4cc5-9eae-cf27670d2dae')
;

-- Sep 11, 2012 4:08:26 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO R_MailText_Trl (AD_Language,R_MailText_ID, MailText,MailHeader,MailText2,MailText3,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,R_MailText_Trl_UU ) SELECT l.AD_Language,t.R_MailText_ID, t.MailText,t.MailHeader,t.MailText2,t.MailText3,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, R_MailText t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.R_MailText_ID=200000 AND NOT EXISTS (SELECT * FROM R_MailText_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.R_MailText_ID=t.R_MailText_ID)
;

-- Sep 11, 2012 6:26:48 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Change Password',200058,'D','1676e190-c252-42c9-b641-76b52145c35c','ChangePassword','Y',TO_DATE('2012-09-11 18:26:46','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-11 18:26:46','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 11, 2012 6:26:48 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200058 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 11, 2012 6:27:32 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Invalid User Name and EMail',200059,'D','cf60c2b0-9d9d-4eed-b04e-496ae2fba7e4','InvalidUserNameAndEmail','Y',TO_DATE('2012-09-11 18:27:31','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-11 18:27:31','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 11, 2012 6:27:32 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200059 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 11, 2012 6:27:51 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Message SET MsgText='Invalid User Name and EMail!',Updated=TO_DATE('2012-09-11 18:27:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200059
;

-- Sep 11, 2012 6:27:51 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200059
;

SELECT register_migration_script('907_IDEMPIERE-375.sql') FROM dual
;
