-- IDEMPIERE-5470
SELECT register_migration_script('202212020805_IDEMPIERE-5470.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 2, 2022, 8:05:38 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203739,0,0,'Y',TO_TIMESTAMP('2022-12-02 08:05:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-02 08:05:37','YYYY-MM-DD HH24:MI:SS'),100,'IsDisplayDateInWords','Display Date In Words','Display Date In Words','D','74c708de-108a-4154-8b15-05a04fa74bcc')
;

-- Dec 2, 2022, 8:08:15 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215695,0,'Display Date In Words',285,'IsDisplayDateInWords','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-12-02 08:08:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-02 08:08:15','YYYY-MM-DD HH24:MI:SS'),100,203739,'Y','N','D','N','N','N','Y','b26c16cb-e473-48e6-98b2-44130792d069','Y',0,'N','N','N','N')
;

-- Dec 2, 2022, 8:08:19 AM CET
ALTER TABLE AD_Process_Para ADD IsDisplayDateInWords CHAR(1) DEFAULT 'N' CHECK (IsDisplayDateInWords IN ('Y','N')) NOT NULL
;

-- Dec 2, 2022, 8:08:46 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207456,'Display Date In Words',246,215695,'Y',1,310,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-12-02 08:08:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-02 08:08:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2d0f049f-bd43-4878-bcf8-b21fc1d04179','Y',290,2,2)
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205238
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5818
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2539
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2540
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2907
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2901
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2903
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200097
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2904
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=220, XPosition=5,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2544
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='(@AD_Reference_ID@=15 | @AD_Reference_ID@=16) & @IsRange@=''Y''', SeqNo=230, XPosition=5,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207456
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205339
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2902
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4398
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2906
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2905
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205193
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56333
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56334
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204372
;

-- Dec 2, 2022, 8:12:47 AM CET
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2022-12-02 08:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206410
;

