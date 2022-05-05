SELECT register_migration_script('202204190945_IDEMPIERE-5261.sql') FROM dual
;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 18, 2022 11:12:39 PM MYT
INSERT INTO AD_Element (AD_Element_ID,Updated,Created,AD_Client_ID,Description,Name,PrintName,ColumnName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,EntityType) VALUES (203035,TO_DATE('2022-04-18 23:12:27','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2022-04-18 23:12:27','YYYY-MM-DD HH24:MI:SS'),0,'Attached document to Email','Attached Document','Attached Document','IsAttachedDocumentToEmail','67946e6c-ccc9-41e2-be03-45a66d8fca20',0,100,100,'Y','D')
;

-- Apr 18, 2022 11:49:44 PM MYT
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,Updated,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,CreatedBy,IsAllowCopy,Description,ColumnName,Name,DefaultValue,IsSelectionColumn,AD_Column_UU,UpdatedBy,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212827,'N','N',0,0,TO_DATE('2022-04-18 23:49:43','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','Y','N',0,0,1,'N','N',TO_DATE('2022-04-18 23:49:43','YYYY-MM-DD HH24:MI:SS'),'Y','N','Y',100,'Y','Attached document to Email','IsAttachedDocumentToEmail','Attached Document','Y','N','d629a293-9361-4879-b0eb-061b5f54297c',100,'Y','N','N',203035,20,129)
;

-- Apr 18, 2022 11:49:55 PM MYT
ALTER TABLE AD_WF_Node ADD IsAttachedDocumentToEmail CHAR(1 CHAR) DEFAULT 'Y' CHECK (IsAttachedDocumentToEmail IN ('Y','N')) NOT NULL
;

-- Apr 19, 2022 12:22:31 AM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,AD_Field_ID,IsQuickEntry,AD_Client_ID,AD_Org_ID,Updated,IsHeading,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNoGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,CreatedBy,UpdatedBy,Name,Description,SortNo,IsEncrypted,DisplayLength,DisplayLogic,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_Tab_ID) VALUES (2,1,204268,'N',0,0,TO_DATE('2022-04-19 00:22:20','YYYY-MM-DD HH24:MI:SS'),'N','Y','N','N','Y',410,420,'N','Y',TO_DATE('2022-04-19 00:22:20','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Attached Document','Attached document to Email',0,'N',0,'@Action@=''M''','72c63d51-d8d3-4a17-af66-ed5d27c4b32e','Y',1,'N','N',212827,122)
;

-- Apr 19, 2022 12:23:52 AM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, XPosition=5,Updated=TO_DATE('2022-04-19 00:23:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204268
;

-- Apr 19, 2022 12:23:52 AM MYT
UPDATE AD_Field SET SeqNo=280,Updated=TO_DATE('2022-04-19 00:23:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8761
;

-- Apr 19, 2022 12:23:52 AM MYT
UPDATE AD_Field SET SeqNo=290,Updated=TO_DATE('2022-04-19 00:23:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1269
;

-- Apr 19, 2022 12:23:52 AM MYT
UPDATE AD_Field SET SeqNo=300,Updated=TO_DATE('2022-04-19 00:23:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1268
;

-- Apr 19, 2022 12:23:53 AM MYT
UPDATE AD_Field SET SeqNo=310,Updated=TO_DATE('2022-04-19 00:23:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8766
;

-- Apr 19, 2022 12:23:53 AM MYT
UPDATE AD_Field SET SeqNo=320,Updated=TO_DATE('2022-04-19 00:23:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2578
;

-- Apr 19, 2022 12:24:27 AM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=2005
;

-- Apr 19, 2022 12:24:27 AM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=386
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=10195
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=387
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=388
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=389
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=390
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=4572
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=5821
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8764
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8772
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8763
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8773
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8882
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8883
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1263
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8881
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1264
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=3666
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=10088
;

-- Apr 19, 2022 12:24:28 AM MYT
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=10091
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=10090
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=12615
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=12614
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=12616
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=204268
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8761
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1269
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=1268
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8766
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=2578
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8771
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=10180
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=10089
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=10920
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=10921
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8765
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8767
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8769
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=8768
;

-- Apr 19, 2022 12:24:29 AM MYT
UPDATE AD_Field SET SeqNoGrid=420,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=201875
;
