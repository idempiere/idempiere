SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 2, 2014 9:15:14 AM CEST
-- IDEMPIERE-1899
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202698,'644f9b63-6ded-406e-abec-44d87375820a',0,'R_DefaultMailText_ID',TO_DATE('2014-05-02 09:15:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Default mail template','Default mail template',TO_DATE('2014-05-02 09:15:13','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 2, 2014 9:15:31 AM CEST
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,Description,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202699,'05f5cb33-9346-4d6d-81c0-26c599af9b5a',0,'IsAddMailTextAutomatically',TO_DATE('2014-05-02 09:15:30','YYYY-MM-DD HH24:MI:SS'),100,'The selected mail template will be automatically inserted when creating an email','D','Y','Add Mail Text Automatically','Add Mail Text Automatically',TO_DATE('2014-05-02 09:15:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 2, 2014 9:15:50 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FKConstraintType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,211208,'9cc67589-fb40-4206-9f03-4057670ed430',202699,0,20,114,'IsAddMailTextAutomatically',TO_DATE('2014-05-02 09:15:49','YYYY-MM-DD HH24:MI:SS'),100,'N','The selected mail template will be automatically inserted when creating an email','D','N',1,'Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','N','N','Y','Add Mail Text Automatically',0,0,TO_DATE('2014-05-02 09:15:49','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- May 2, 2014 9:15:54 AM CEST
ALTER TABLE AD_User ADD IsAddMailTextAutomatically CHAR(1) DEFAULT 'N' CHECK (IsAddMailTextAutomatically IN ('Y','N')) NOT NULL
;

-- May 2, 2014 9:16:15 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FKConstraintType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,211209,'2ecd8ac6-61d1-4062-85d9-2968e5a8f74c',202698,0,18,274,114,'R_DefaultMailText_ID',TO_DATE('2014-05-02 09:16:14','YYYY-MM-DD HH24:MI:SS'),100,'D','N',10,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','Default mail template',0,0,TO_DATE('2014-05-02 09:16:14','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- May 2, 2014 9:16:15 AM CEST
UPDATE AD_Column SET FKConstraintName='RDEFAULTMAILTEXT_ADUSER', FKConstraintType='N',Updated=TO_DATE('2014-05-02 09:16:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211209
;

-- May 14, 2014 10:24:01 AM COT
ALTER TABLE AD_User ADD R_DefaultMailText_ID NUMBER(10) DEFAULT NULL 
;

-- May 14, 2014 10:24:02 AM COT
ALTER TABLE AD_User ADD CONSTRAINT RDefaultMailText_ADUser FOREIGN KEY (R_DefaultMailText_ID) REFERENCES r_mailtext(r_mailtext_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 2, 2014 9:16:27 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,211208,202875,'b020eaab-a12c-4b5a-80ba-8c12f2cba674',0,118,2,TO_DATE('2014-05-02 09:16:27','YYYY-MM-DD HH24:MI:SS'),100,'The selected mail template will be automatically inserted when creating an email',1,'D','Y','Y','Y','N','N','N','N','N','Add Mail Text Automatically',520,TO_DATE('2014-05-02 09:16:27','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- May 2, 2014 9:16:28 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211209,202876,'ef99b478-48c3-4f2f-b276-7ae8695ab14a',0,118,2,TO_DATE('2014-05-02 09:16:27','YYYY-MM-DD HH24:MI:SS'),100,10,'D','Y','Y','Y','N','N','N','N','N','Default mail template',530,TO_DATE('2014-05-02 09:16:27','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=12640
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200072
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=202876
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=202875
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=6513
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=11525
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=6520
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=8342
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=6519
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=200405
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=200400
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=200403
;

-- May 2, 2014 9:17:07 AM CEST
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=200401
;

-- May 2, 2014 9:17:08 AM CEST
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=200406
;

-- May 2, 2014 9:17:08 AM CEST
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=200402
;

-- May 2, 2014 9:17:08 AM CEST
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=200474
;

-- May 2, 2014 9:17:08 AM CEST
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=200475
;

-- May 2, 2014 9:17:08 AM CEST
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=200473
;

-- May 2, 2014 9:17:18 AM CEST
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2014-05-02 09:17:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202875
;

-- May 2, 2014 9:19:54 AM CEST
-- IDEMPIERE-1899
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=280, XPosition=5,Updated=TO_DATE('2014-05-02 09:19:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=202875
;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 2, 2014 9:37:13 AM CEST
-- IDEMPIERE-1899
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200273,'43ee6fb2-59e7-4af2-bf73-b5baf5af5a3a',0,TO_DATE('2014-05-02 09:37:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Add default mail text content','I',TO_DATE('2014-05-02 09:37:13','YYYY-MM-DD HH24:MI:SS'),100,'AddDefaultMailTextContent')
;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 2, 2014 9:38:51 AM CEST
-- IDEMPIERE-1899
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2014-05-02 09:38:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211208
;

-- May 2, 2014 9:38:58 AM CEST
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2014-05-02 09:38:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211209
;

-- May 2, 2014 9:39:11 AM CEST
UPDATE AD_Field SET EntityType='D',Updated=TO_DATE('2014-05-02 09:39:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202876
;

-- May 2, 2014 9:39:13 AM CEST
UPDATE AD_Field SET EntityType='D',Updated=TO_DATE('2014-05-02 09:39:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202875
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=202876
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=202875
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=6513
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=11525
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=6520
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=8342
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=6519
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=200405
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=200400
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=200403
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=200401
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=200406
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y' WHERE AD_Field_ID=200402
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y' WHERE AD_Field_ID=200474
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=420,IsDisplayedGrid='Y' WHERE AD_Field_ID=200475
;

-- May 14, 2014 10:54:07 AM COT
UPDATE AD_Field SET SeqNoGrid=430,IsDisplayedGrid='Y' WHERE AD_Field_ID=200473
;

SELECT register_migration_script('201405021000_IDEMPIERE-1899.sql') FROM dual
;
