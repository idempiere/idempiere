-- IDEMPIERE-5400-style
SELECT register_migration_script('202209081125_IDEMPIERE-5400.sql') FROM dual;

-- Sep 8, 2022, 11:25:57 AM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Chart_ID@ > 0 | @PA_Goal_ID@ > 0', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-08 11:25:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207125
;

-- Sep 8, 2022, 11:26:22 AM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-08 11:26:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207135
;

-- Sep 8, 2022, 11:26:22 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-08 11:26:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207187
;

-- Sep 8, 2022, 11:26:22 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-08 11:26:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207125
;

-- Sep 8, 2022, 11:26:22 AM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-08 11:26:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56504
;

-- Sep 8, 2022, 11:26:22 AM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-08 11:26:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200268
;

-- Sep 8, 2022, 12:14:11 PM CEST
INSERT INTO AD_PrintColor (CreatedBy,Created,AD_Client_ID,AD_PrintColor_ID,AD_Org_ID,IsDefault,Code,Name,IsActive,UpdatedBy,Updated,AD_PrintColor_UU) VALUES (100,TO_TIMESTAMP('2022-09-08 12:14:11','YYYY-MM-DD HH24:MI:SS'),0,200000,0,'N','14248035','Metabase Green','Y',100,TO_TIMESTAMP('2022-09-08 12:14:11','YYYY-MM-DD HH24:MI:SS'),'2d6610c2-cce4-4568-8e4a-827fe6cb2ae0')
;

-- Sep 8, 2022, 12:14:59 PM CEST
INSERT INTO AD_PrintColor (CreatedBy,Created,AD_Client_ID,AD_PrintColor_ID,AD_Org_ID,IsDefault,Code,Name,IsActive,UpdatedBy,Updated,AD_PrintColor_UU) VALUES (100,TO_TIMESTAMP('2022-09-08 12:14:59','YYYY-MM-DD HH24:MI:SS'),0,200001,0,'N','16042069','Metabase Yellow','Y',100,TO_TIMESTAMP('2022-09-08 12:14:59','YYYY-MM-DD HH24:MI:SS'),'00d930ae-eaf7-468b-a1a3-c913c23513af')
;

-- Sep 8, 2022, 12:15:35 PM CEST
UPDATE AD_PrintColor SET Name='Metabase Red',Updated=TO_TIMESTAMP('2022-09-08 12:15:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintColor_ID=200000
;

-- Sep 8, 2022, 12:16:08 PM CEST
INSERT INTO AD_PrintColor (CreatedBy,Created,AD_Client_ID,AD_PrintColor_ID,AD_Org_ID,IsDefault,Code,Name,IsActive,UpdatedBy,Updated,AD_PrintColor_UU) VALUES (100,TO_TIMESTAMP('2022-09-08 12:16:08','YYYY-MM-DD HH24:MI:SS'),0,200002,0,'N','8564560','Metabase Green','Y',100,TO_TIMESTAMP('2022-09-08 12:16:08','YYYY-MM-DD HH24:MI:SS'),'9e2db602-f7bd-49b3-aea7-7920ea6c26d6')
;

-- Sep 8, 2022, 12:16:51 PM CEST
UPDATE PA_ColorSchema SET AD_PrintColor1_ID=200000, AD_PrintColor2_ID=200001, AD_PrintColor3_ID=200002,Updated=TO_TIMESTAMP('2022-09-08 12:16:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_ColorSchema_ID=100
;

-- Sep 8, 2022, 12:17:07 PM CEST
UPDATE PA_ColorSchema SET AD_PrintColor1_ID=200002, AD_PrintColor2_ID=200001, AD_PrintColor3_ID=200000,Updated=TO_TIMESTAMP('2022-09-08 12:17:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_ColorSchema_ID=101
;

