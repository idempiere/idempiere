-- IDEMPIERE-5445
SELECT register_migration_script('202210081008_IDEMPIERE-5445.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 8, 2022, 10:08:29 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203704,0,0,'Y',TO_TIMESTAMP('2022-10-08 10:08:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-08 10:08:23','YYYY-MM-DD HH24:MI:SS'),100,'RoundingPrecision','Rounding Precision',NULL,NULL,'Rounding Precision','D','574f7522-95be-4f00-a912-8fa3bded16a3')
;

-- Oct 8, 2022, 10:08:51 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,AD_InfoWindow_ID) VALUES (215524,0,'Rounding Precision',448,'RoundingPrecision',2,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2022-10-08 10:08:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-08 10:08:51','YYYY-MM-DD HH24:MI:SS'),100,203704,'Y','N','D','N','N','N','Y','0468266c-d1f1-4fdd-a45b-6d30b7ba2f3f','Y',0,'N','N','N','N',200000)
;

-- Oct 8, 2022, 10:08:55 AM CEST
ALTER TABLE PA_ReportLine ADD RoundingPrecision NUMBER(10) DEFAULT NULL 
;

-- Oct 8, 2022, 10:09:11 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207288,'Rounding Precision',376,215524,'Y',2,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-08 10:09:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-08 10:09:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5fda0fce-4785-481d-8be1-985f7ae488a4','Y',235,2)
;

-- Oct 8, 2022, 10:09:54 AM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2022-10-08 10:09:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206182
;

-- Oct 8, 2022, 10:09:54 AM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2022-10-08 10:09:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206214
;

-- Oct 8, 2022, 10:09:54 AM CEST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2022-10-08 10:09:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206215
;

-- Oct 8, 2022, 10:09:54 AM CEST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2022-10-08 10:09:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207288
;

-- Oct 8, 2022, 10:09:54 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2022-10-08 10:09:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204996
;

-- Oct 8, 2022, 10:10:53 AM CEST
UPDATE AD_Field SET DisplayLogic='@CalculationType@ = P',Updated=TO_TIMESTAMP('2022-10-08 10:10:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4796
;

