SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3926 Restrict roles in login by type
-- Mar 21, 2019, 2:17:02 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203303,0,0,'Y',TO_DATE('2019-03-21 14:16:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:16:45','YYYY-MM-DD HH24:MI:SS'),100,'RoleType','Role Type',NULL,NULL,'Role Type','D','d5790909-7831-4e65-ae23-2621d6916933')
;

-- Mar 21, 2019, 2:17:50 PM BRT
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200166,'AD_Role RoleType','L',0,0,'Y',TO_DATE('2019-03-21 14:17:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:17:49','YYYY-MM-DD HH24:MI:SS'),100,'D','N','88b0c074-0f6f-4a8b-b76e-e230e340f670')
;

-- Mar 21, 2019, 2:18:17 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (213856,0,'Role Type',156,'RoleType',2,'N','N','N','N','N',0,'N',17,200166,0,0,'Y',TO_DATE('2019-03-21 14:18:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:18:16','YYYY-MM-DD HH24:MI:SS'),100,203303,'Y','N','D','N','N','N','Y','ab062f58-46e1-4a1a-9245-bfa6dd7f42bb','Y',0,'N','N','N')
;

-- Mar 21, 2019, 2:18:20 PM BRT
ALTER TABLE AD_Role ADD RoleType VARCHAR2(2) DEFAULT NULL 
;

-- Mar 21, 2019, 2:21:49 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205947,'Role Type',119,213856,'Y',0,450,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-03-21 14:21:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:21:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',135,'D','69560ba0-28c5-481b-b06f-ba1fb8cf468f','Y',440,1,1,1,'N','N','N')
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=364
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7833
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=363
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200071
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11002
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=930
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=931
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59591
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59592
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10126
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205947
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11003
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5227
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202366
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10813
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11257
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8312
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8310
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8313
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8314
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8311
;

-- Mar 21, 2019, 2:34:40 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11006
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12367
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12368
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11256
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50168
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50178
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50176
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50170
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50174
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50173
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50172
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50175
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50169
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50177
;

-- Mar 21, 2019, 2:34:41 PM BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204590
;

-- Mar 21, 2019, 2:35:20 PM BRT
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-03-21 14:35:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205947
;

-- Mar 21, 2019, 2:37:34 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200457,'WebUI',200166,'ZK',0,0,'Y',TO_DATE('2019-03-21 14:37:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:37:33','YYYY-MM-DD HH24:MI:SS'),100,'D','af5be523-6318-4b6c-bc8b-f51ecd0de2d0')
;

-- Mar 21, 2019, 2:37:43 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200458,'WebService',200166,'WS',0,0,'Y',TO_DATE('2019-03-21 14:37:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:37:43','YYYY-MM-DD HH24:MI:SS'),100,'D','ff7ae569-ea86-4c21-9aff-6a9073f4b677')
;

-- Mar 21, 2019, 2:37:53 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200459,'System Support',200166,'SS',0,0,'Y',TO_DATE('2019-03-21 14:37:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:37:53','YYYY-MM-DD HH24:MI:SS'),100,'D','3b6ad66c-e962-46a5-a3ec-b8787ee4c754')
;

-- Mar 21, 2019, 2:38:04 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200460,'Mobile',200166,'MO',0,0,'Y',TO_DATE('2019-03-21 14:38:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:38:03','YYYY-MM-DD HH24:MI:SS'),100,'D','78962d5b-b6bb-4798-8f9d-fd36381b58ed')
;

-- Mar 21, 2019, 2:38:13 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200461,'Swing',200166,'SW',0,0,'Y',TO_DATE('2019-03-21 14:38:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:38:12','YYYY-MM-DD HH24:MI:SS'),100,'D','b6d02ebf-6845-47d9-b91e-b956084333e8')
;

-- Mar 21, 2019, 2:38:27 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200462,'External App 1',200166,'E1',0,0,'Y',TO_DATE('2019-03-21 14:38:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:38:27','YYYY-MM-DD HH24:MI:SS'),100,'D','d6bc8c6d-d5bf-458c-81f7-4d3f11303d6d')
;

-- Mar 21, 2019, 2:38:41 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200463,'External App 2',200166,'E2',0,0,'Y',TO_DATE('2019-03-21 14:38:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:38:40','YYYY-MM-DD HH24:MI:SS'),100,'D','79a2e44a-dfd6-4114-b835-5392c4736eb9')
;

-- Mar 21, 2019, 2:38:46 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200464,'External App 3',200166,'E3',0,0,'Y',TO_DATE('2019-03-21 14:38:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:38:46','YYYY-MM-DD HH24:MI:SS'),100,'D','f158da0d-6ad6-4f2e-aa65-099417d6217b')
;

-- Mar 21, 2019, 2:38:54 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200465,'External App 4',200166,'E4',0,0,'Y',TO_DATE('2019-03-21 14:38:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:38:53','YYYY-MM-DD HH24:MI:SS'),100,'D','d136b0f9-658a-4e79-b22f-3cf995da34ff')
;

-- Mar 21, 2019, 2:39:00 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200466,'External App 5',200166,'E5',0,0,'Y',TO_DATE('2019-03-21 14:38:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-21 14:38:59','YYYY-MM-DD HH24:MI:SS'),100,'D','b06729fb-ce8e-4bff-b6da-0f38bdefa55e')
;

-- Mar 21, 2019, 2:43:43 PM BRT
UPDATE AD_Role SET RoleType='WS',Updated=TO_DATE('2019-03-21 14:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Role_ID=50004
;

UPDATE AD_Role SET RoleType='SS',Updated=TO_DATE('2019-03-21 14:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Role_ID=0
;

SELECT register_migration_script('201903211444_IDEMPIERE-3926.sql') FROM dual
;

