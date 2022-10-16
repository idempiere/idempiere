-- IDEMPIERE-5445 Fin Report - Percentage lines - Rounding
SELECT register_migration_script('202210111720_IDEMPIERE-5445.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 11, 2022, 5:20:53 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215623,0,'Multiplier','Type Multiplier (Credit = -1)',446,'Multiplier',14,'N','N','N','N','N',0,'N',22,0,0,'Y',TO_TIMESTAMP('2022-10-11 17:20:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 17:20:52','YYYY-MM-DD HH24:MI:SS'),100,1525,'N','N','D','N','N','N','Y','5aadeabd-11a2-4c72-816d-b29742744481','Y',0,'N','N','N','N')
;

-- Oct 11, 2022, 5:21:04 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215624,0,'Multiplier','Type Multiplier (Credit = -1)',448,'Multiplier',14,'N','N','N','N','N',0,'N',22,0,0,'Y',TO_TIMESTAMP('2022-10-11 17:21:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 17:21:04','YYYY-MM-DD HH24:MI:SS'),100,1525,'N','N','D','N','N','N','Y','714062d2-e95a-41e1-af63-3b61c2a7c3c3','Y',0,'N','N','N','N')
;

-- Oct 11, 2022, 5:21:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215625,0,'Round Factor',446,'RoundFactor',14,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2022-10-11 17:21:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 17:21:17','YYYY-MM-DD HH24:MI:SS'),100,200145,'Y','N','D','N','N','N','Y','4afbd87d-edf2-4dea-932e-9b9fabd13fed','Y',0,'N','N','N')
;

-- Oct 11, 2022, 5:21:25 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215626,0,'Round Factor',448,'RoundFactor',14,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2022-10-11 17:21:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 17:21:24','YYYY-MM-DD HH24:MI:SS'),100,200145,'Y','N','D','N','N','N','Y','827ddc6d-2b3c-42b3-a921-2f3d13c34c35','Y',0,'N','N','N','N')
;

-- Oct 11, 2022, 5:21:32 PM CEST
ALTER TABLE PA_ReportColumn ADD RoundFactor NUMBER(10) DEFAULT NULL 
;

-- Oct 11, 2022, 5:21:44 PM CEST
ALTER TABLE PA_ReportColumn ADD Multiplier NUMBER DEFAULT NULL 
;

-- Oct 11, 2022, 5:21:52 PM CEST
ALTER TABLE PA_ReportLine ADD RoundFactor NUMBER(10) DEFAULT NULL 
;

-- Oct 11, 2022, 5:21:59 PM CEST
ALTER TABLE PA_ReportLine ADD Multiplier NUMBER DEFAULT NULL 
;

-- Oct 11, 2022, 5:22:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207399,'Multiplier','Type Multiplier (Credit = -1)',374,215623,'Y',14,470,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-11 17:22:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 17:22:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5b2a762b-7aa1-4c1e-be69-8bbaa80d44f9','Y',490,2)
;

-- Oct 11, 2022, 5:22:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207400,'Round Factor',374,215625,'Y',14,480,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-11 17:22:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 17:22:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','abf762bb-a4f7-4e44-b824-36de7ce06649','Y',500,2)
;

-- Oct 11, 2022, 5:23:53 PM CEST
UPDATE AD_Field SET IsDisplayed='N', IsActive='N', IsDisplayedGrid='N',Updated=TO_TIMESTAMP('2022-10-11 17:23:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56376
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206213
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4759
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4761
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4762
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201868
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4763
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4764
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56301
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56518
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56517
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4765
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56296
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4766
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56302
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4777
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56299
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4776
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56298
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4775
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56303
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4767
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56300
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4768
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56304
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4769
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56297
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56281
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56305
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=430,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56282
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=440,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56306
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=450,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56375
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=460, XPosition=5,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206181
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=480, XPosition=4,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207400
;

-- Oct 11, 2022, 5:24:28 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2022-10-11 17:24:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204993
;

-- Oct 11, 2022, 5:24:51 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207401,'Multiplier','Type Multiplier (Credit = -1)',376,215624,'Y',14,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-11 17:24:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 17:24:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','149a6131-75df-4214-9707-d4c515c4d507','Y',235,2)
;

-- Oct 11, 2022, 5:24:52 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207402,'Round Factor',376,215626,'Y',14,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-11 17:24:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 17:24:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','54046543-2dda-423b-9dcf-8a695bf29936','Y',245,2)
;

-- Oct 11, 2022, 5:25:08 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2022-10-11 17:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206182
;

-- Oct 11, 2022, 5:25:08 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2022-10-11 17:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206214
;

-- Oct 11, 2022, 5:25:08 PM CEST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2022-10-11 17:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206215
;

-- Oct 11, 2022, 5:25:08 PM CEST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2022-10-11 17:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207401
;

-- Oct 11, 2022, 5:25:08 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=220, XPosition=4,Updated=TO_TIMESTAMP('2022-10-11 17:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207402
;

-- Oct 11, 2022, 5:25:08 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2022-10-11 17:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204996
;

-- Oct 11, 2022, 5:58:30 PM CEST
UPDATE AD_Column SET DefaultValue='NULL', IsUpdateable='Y',Updated=TO_TIMESTAMP('2022-10-11 17:58:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215623
;

-- Oct 11, 2022, 5:58:44 PM CEST
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_TIMESTAMP('2022-10-11 17:58:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215625
;

-- Oct 11, 2022, 5:59:19 PM CEST
UPDATE AD_Column SET DefaultValue='NULL', IsUpdateable='Y',Updated=TO_TIMESTAMP('2022-10-11 17:59:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215624
;

-- Oct 11, 2022, 5:59:34 PM CEST
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_TIMESTAMP('2022-10-11 17:59:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215626
;

UPDATE pa_reportcolumn SET multiplier=0.001 WHERE factor='k';

UPDATE pa_reportcolumn SET multiplier=0.000001 WHERE factor='M';

