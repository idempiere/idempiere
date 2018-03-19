SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 17, 2014 8:23:45 PM CEST
-- IDEMPIERE-2073
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FKConstraintType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,211571,'5bd0edd0-0f13-463e-bf7d-4f8f8d5a8aa3',139,0,19,464,'AD_Val_Rule_ID',TO_DATE('2014-07-17 20:23:44','YYYY-MM-DD HH24:MI:SS'),100,'Dynamic Validation Rule','D','N',22,'These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','Dynamic Validation',0,0,TO_DATE('2014-07-17 20:23:44','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 17, 2014 8:23:48 PM CEST
UPDATE AD_Column SET FKConstraintName='ADValRule_ADUserDefField', FKConstraintType='N',Updated=TO_DATE('2014-07-17 20:23:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211571
;

-- Jul 17, 2014 8:23:48 PM CEST
ALTER TABLE AD_UserDef_Field ADD AD_Val_Rule_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 17, 2014 8:23:48 PM CEST
ALTER TABLE AD_UserDef_Field ADD CONSTRAINT ADValRule_ADUserDefField FOREIGN KEY (AD_Val_Rule_ID) REFERENCES AD_VAL_RULE(AD_VAL_RULE_ID) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 17, 2014 8:24:03 PM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,211571,203266,'e0427cf3-b251-47c0-aa58-afc672aac597',0,395,2,TO_DATE('2014-07-17 20:24:03','YYYY-MM-DD HH24:MI:SS'),100,'Dynamic Validation Rule',22,'D','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.','Y','Y','Y','N','N','N','N','N','Dynamic Validation',280,TO_DATE('2014-07-17 20:24:03','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=200857
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200850
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=5055
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=11252
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=200853
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=200858
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=200856
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=200855
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=200849
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=200851
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=200852
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=200854
;

-- Jul 17, 2014 8:24:22 PM CEST
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=203266
;

-- Jul 17, 2014 8:24:59 PM CEST
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=203266
;

-- Jul 17, 2014 8:24:59 PM CEST
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=5054
;

-- Jul 17, 2014 8:24:59 PM CEST
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=200849
;

-- Jul 17, 2014 8:24:59 PM CEST
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=200851
;

-- Jul 17, 2014 8:24:59 PM CEST
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=200852
;

-- Jul 17, 2014 8:24:59 PM CEST
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200854
;

-- Jul 17, 2014 8:24:59 PM CEST
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=5051
;

-- Jul 17, 2014 8:24:59 PM CEST
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=5057
;

-- Jul 17, 2014 8:25:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, XPosition=4,Updated=TO_DATE('2014-07-17 20:25:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203266
;

-- Jul 17, 2014 8:26:05 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012',Updated=TO_DATE('2014-07-17 20:26:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203266
;

-- Jul 17, 2014 8:26:41 PM CEST
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2014-07-17 20:26:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203266
;

SELECT register_migration_script('201407172028_IDEMPIERE-2073.sql') FROM dual
;