-- IDEMPIERE-5573
SELECT register_migration_script('202302131520_IDEMPIERE-5573.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 13, 2023, 3:20:01 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203787,0,0,'Y',TO_TIMESTAMP('2023-02-13 15:20:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-13 15:20:01','YYYY-MM-DD HH24:MI:SS'),100,'ShowInactive','Show Inactive','Show Inactive Records','Show Inactive','D','c95fa8c2-91eb-4c57-8a93-5867af55151d')
;

-- Feb 13, 2023, 3:20:44 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200230,'AD_Reference Show Inactive','L',0,0,'Y',TO_TIMESTAMP('2023-02-13 15:20:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-13 15:20:44','YYYY-MM-DD HH24:MI:SS'),100,'D','N','998ea62f-47e7-433e-9293-d49324d16c10')
;

-- Feb 13, 2023, 3:21:46 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200626,'No','No Inactive Records',200230,'N',0,0,'Y',TO_TIMESTAMP('2023-02-13 15:21:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-13 15:21:46','YYYY-MM-DD HH24:MI:SS'),100,'D','f99597a3-8f11-4547-8b62-ab918dad0f8b')
;

-- Feb 13, 2023, 3:22:20 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200627,'Yes','Show all records (active/inactive)',200230,'Y',0,0,'Y',TO_TIMESTAMP('2023-02-13 15:22:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-13 15:22:19','YYYY-MM-DD HH24:MI:SS'),100,'D','4116b567-0f8f-492d-a1f7-4ac3d5a53aaf')
;

-- Feb 13, 2023, 3:23:16 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215772,0,'Show Inactive','Show Inactive Records',102,'ShowInactive','N',4,'N','N','Y','N','N',0,'N',17,200230,0,0,'Y',TO_TIMESTAMP('2023-02-13 15:23:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-13 15:23:15','YYYY-MM-DD HH24:MI:SS'),100,203787,'Y','N','D','N','N','N','Y','3215b375-ef7a-422b-af73-42ca0562bce9','N',0,'N','N','N','N')
;

-- Feb 13, 2023, 3:23:19 PM CET
ALTER TABLE AD_Reference ADD ShowInactive VARCHAR2(4 CHAR) DEFAULT 'N' NOT NULL
;

-- Feb 13, 2023, 3:57:23 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207567,'Show Inactive','Show Inactive Records',102,215772,'Y',4,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-02-13 15:57:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-13 15:57:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f3f4797e-be33-47a5-8d7e-b765723c8ee6','Y',130,2)
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=10,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=258
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=20,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1985
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=30,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=107
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=108
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=109
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=257
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5123
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=178
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206184
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=314
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=4,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207567
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204575
;

-- Feb 13, 2023, 3:57:39 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-02-13 15:57:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=106
;

