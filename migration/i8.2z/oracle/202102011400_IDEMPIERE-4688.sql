SET SQLBLANKLINES ON
SET DEFINE OFF

-- Adding customs tariff number to products
-- Feb 1, 2021, 7:48:49 PM UTC
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203451,0,0,'Y',TO_DATE('2021-02-01 19:48:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-02-01 19:48:48','YYYY-MM-DD HH24:MI:SS'),100,'CustomsTariffNumber','Customs Tariff Number','Customs Tariff Number, usually the HS-Code','Customs Tariff Number','D','80499878-be76-441b-b271-927aae501777')
;

-- Feb 1, 2021, 7:50:29 PM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214343,0,'Customs Tariff Number','Customs Tariff Number, usually the HS-Code',208,'CustomsTariffNumber',20,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2021-02-01 19:50:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-02-01 19:50:28','YYYY-MM-DD HH24:MI:SS'),100,203451,'Y','N','U','N','N','N','Y','f0067f75-e06f-4289-b74e-718ede8d5c2e','Y',0,'N','N','N','N')
;

-- Feb 1, 2021, 7:50:33 PM UTC
ALTER TABLE M_Product ADD CustomsTariffNumber VARCHAR2(20 CHAR) DEFAULT NULL 
;

-- Feb 1, 2021, 7:51:55 PM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214344,0,'Customs Tariff Number','Customs Tariff Number, usually the HS-Code',532,'CustomsTariffNumber',20,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2021-02-01 19:51:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-02-01 19:51:54','YYYY-MM-DD HH24:MI:SS'),100,203451,'Y','N','U','N','N','N','Y','62588c69-9631-4d00-866f-69ae670bf79a','Y',0,'N','N','N','N')
;

-- Feb 1, 2021, 7:51:58 PM UTC
ALTER TABLE I_Product ADD CustomsTariffNumber VARCHAR2(20 CHAR) DEFAULT NULL 
;

-- Feb 1, 2021, 7:53:26 PM UTC
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2021-02-01 19:53:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214344
;

-- Feb 1, 2021, 7:53:29 PM UTC
ALTER TABLE I_Product MODIFY CustomsTariffNumber VARCHAR2(20 CHAR) DEFAULT NULL 
;

-- Feb 1, 2021, 7:53:59 PM UTC
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2021-02-01 19:53:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214343
;

-- Feb 1, 2021, 7:54:05 PM UTC
ALTER TABLE M_Product MODIFY CustomsTariffNumber VARCHAR2(20 CHAR) DEFAULT NULL 
;

-- Feb 1, 2021, 7:54:43 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206544,'Customs Tariff Number','Customs Tariff Number, usually the HS-Code',180,214343,'Y',20,590,'N','N','N','N',0,0,'Y',TO_DATE('2021-02-01 19:54:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-02-01 19:54:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a8c023b0-6720-498f-b3e1-2122a110ee97','Y',590,2,3)
;

-- Feb 1, 2021, 8:00:33 PM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214346,0,'Group1',532,'Group1',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-02-01 20:00:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-02-01 20:00:32','YYYY-MM-DD HH24:MI:SS'),100,52018,'Y','N','D','N','N','N','Y','1d058d3d-bc5a-4a22-8268-8b33f5cdfd7c','Y',0,'N','N','N')
;

-- Feb 1, 2021, 8:00:35 PM UTC
ALTER TABLE I_Product ADD Group1 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Feb 1, 2021, 8:00:53 PM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214347,0,'Group2',532,'Group2',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-02-01 20:00:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-02-01 20:00:53','YYYY-MM-DD HH24:MI:SS'),100,52019,'Y','N','D','N','N','N','Y','bdc770aa-81e6-4be9-83e1-761fef0dbf7a','Y',0,'N','N','N')
;

-- Feb 1, 2021, 8:00:56 PM UTC
ALTER TABLE I_Product ADD Group2 VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Feb 1, 2021, 8:03:35 PM UTC
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206544
;

-- Feb 1, 2021, 8:03:35 PM UTC
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=6841
;

-- Feb 1, 2021, 8:03:35 PM UTC
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=10411
;

-- Feb 1, 2021, 8:03:35 PM UTC
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1026
;

-- Feb 1, 2021, 8:03:35 PM UTC
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=200294
;

-- Feb 1, 2021, 8:03:35 PM UTC
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=200295
;

-- Feb 1, 2021, 8:03:35 PM UTC
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=200296
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=200297
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=7646
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1319
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1320
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1321
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1322
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=3743
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=3746
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=3747
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=3744
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=3745
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1027
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1028
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1568
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1569
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5381
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=470,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5383
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=480,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=12418
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=9286
;

-- Feb 1, 2021, 8:03:36 PM UTC
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5910
;

-- Feb 1, 2021, 8:03:37 PM UTC
UPDATE AD_Field SET SeqNo=510,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5911
;

-- Feb 1, 2021, 8:03:37 PM UTC
UPDATE AD_Field SET SeqNo=520,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=6130
;

-- Feb 1, 2021, 8:03:37 PM UTC
UPDATE AD_Field SET SeqNo=530,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8307
;

-- Feb 1, 2021, 8:03:37 PM UTC
UPDATE AD_Field SET SeqNo=540,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=6343
;

-- Feb 1, 2021, 8:03:37 PM UTC
UPDATE AD_Field SET SeqNo=550,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=6344
;

-- Feb 1, 2021, 8:03:37 PM UTC
UPDATE AD_Field SET SeqNo=560,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=58973
;

-- Feb 1, 2021, 8:03:37 PM UTC
UPDATE AD_Field SET SeqNo=570,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8608
;

-- Feb 1, 2021, 8:03:37 PM UTC
UPDATE AD_Field SET SeqNo=580,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8613
;

-- Feb 1, 2021, 8:03:37 PM UTC
UPDATE AD_Field SET SeqNo=590,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=52015
;

-- Feb 1, 2021, 8:03:37 PM UTC
UPDATE AD_Field SET SeqNo=600,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=52016
;

-- Feb 1, 2021, 8:05:14 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206545,'Customs Tariff Number','Customs Tariff Number, usually the HS-Code',442,214344,'Y',20,490,'N','N','N','N',0,0,'Y',TO_DATE('2021-02-01 20:05:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-02-01 20:05:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d82cbc8a-b444-465c-8c17-e2ae70ac0aff','Y',490,2,3)
;

-- Feb 1, 2021, 8:05:15 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206546,'Group1',442,214346,'Y',255,500,'N','N','N','N',0,0,'Y',TO_DATE('2021-02-01 20:05:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-02-01 20:05:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8f5c09bb-48a0-4b79-a765-6a87852a6655','Y',500,5)
;

-- Feb 1, 2021, 8:05:15 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206547,'Group2',442,214347,'Y',255,510,'N','N','N','N',0,0,'Y',TO_DATE('2021-02-01 20:05:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-02-01 20:05:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','61d96cb9-a004-451d-a324-2ee9360ab9c2','Y',510,5)
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206545
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5994
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5998
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206546
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206547
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5986
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5985
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5958
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5977
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5982
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5999
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=12420
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=12419
;

-- Feb 1, 2021, 8:08:38 PM UTC
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5975
;

-- Feb 1, 2021, 8:08:39 PM UTC
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5963
;

-- Feb 1, 2021, 8:08:39 PM UTC
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5960
;

-- Feb 1, 2021, 8:08:39 PM UTC
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5973
;

-- Feb 1, 2021, 8:08:39 PM UTC
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5988
;

-- Feb 1, 2021, 8:08:39 PM UTC
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5996
;

-- Feb 1, 2021, 8:08:39 PM UTC
UPDATE AD_Field SET SeqNo=470,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5968
;

-- Feb 1, 2021, 8:08:39 PM UTC
UPDATE AD_Field SET SeqNo=480,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5971
;

-- Feb 1, 2021, 8:08:39 PM UTC
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5970
;

-- Feb 1, 2021, 8:08:39 PM UTC
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5993
;

-- Feb 1, 2021, 8:08:39 PM UTC
UPDATE AD_Field SET SeqNo=510,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5965
;

-- Feb 1, 2021, 8:10:33 PM UTC
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=1, IsToolbarButton=NULL,Updated=TO_DATE('2021-02-01 20:10:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206545
;

-- Feb 1, 2021, 8:11:36 PM UTC
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=1, IsToolbarButton=NULL,Updated=TO_DATE('2021-02-01 20:11:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206544
;

-- Feb 1, 2021, 8:14:27 PM UTC
UPDATE AD_Column SET AD_Reference_ID=10,Updated=TO_DATE('2021-02-01 20:14:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214343
;

-- Feb 1, 2021, 8:15:22 PM UTC
UPDATE AD_Column SET AD_Reference_ID=10,Updated=TO_DATE('2021-02-01 20:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214344
;

-- Feb 1, 2021, 8:15:29 PM UTC
ALTER TABLE I_Product MODIFY CustomsTariffNumber VARCHAR2(20 CHAR) DEFAULT NULL 
;

-- Feb 1, 2021, 8:15:41 PM UTC
ALTER TABLE M_Product MODIFY CustomsTariffNumber VARCHAR2(20 CHAR) DEFAULT NULL 
;

SELECT register_migration_script('202102011400_IDEMPIERE-4688.sql') FROM dual
;

