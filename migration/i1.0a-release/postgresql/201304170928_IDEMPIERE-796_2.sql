-- Mar 24, 2013 8:41:39 PM ICT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200139,183,'U','Fixed Assets Document','fef8f9ac-de6a-4ea9-b117-3a6bcfb2f3d4','FAA',TO_TIMESTAMP('2013-03-24 20:41:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-24 20:41:37','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Mar 24, 2013 8:41:39 PM ICT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200139 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Mar 24, 2013 8:42:03 PM ICT
UPDATE AD_Ref_List SET EntityType='D',Updated=TO_TIMESTAMP('2013-03-24 20:42:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200139
;

-- Mar 24, 2013 8:44:07 PM ICT
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('C_DocType.DocBaseType=''FAA'' AND C_DocType.AD_Org_ID IN (0, @AD_Org_ID@)',200035,'D','C_DocType Fixed Assets','S','7305a6f8-6b50-498e-b5ec-c1dc94902817',100,100,TO_TIMESTAMP('2013-03-24 20:44:05','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-24 20:44:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Mar 24, 2013 8:44:23 PM ICT
UPDATE AD_Column SET AD_Val_Rule_ID=200035,Updated=TO_TIMESTAMP('2013-03-24 20:44:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55563
;

-- Mar 24, 2013 8:56:46 PM ICT
UPDATE AD_Menu SET Name='Asset Disposal', Description='Dispose of Assets',Updated=TO_TIMESTAMP('2013-03-24 20:56:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53274
;

-- Mar 24, 2013 8:56:46 PM ICT
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=53274
;

-- Mar 24, 2013 8:57:45 PM ICT
UPDATE AD_Window SET Description='Dispose of Assets',Updated=TO_TIMESTAMP('2013-03-24 20:57:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=53114
;

-- Mar 24, 2013 8:57:45 PM ICT
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=53114
;

-- Mar 24, 2013 8:57:45 PM ICT
UPDATE AD_Menu SET Name='Asset Activation/Disposal', Description='Dispose of Assets', IsActive='Y',Updated=TO_TIMESTAMP('2013-03-24 20:57:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53274
;

-- Mar 24, 2013 8:57:45 PM ICT
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=53274
;

-- Mar 24, 2013 8:58:07 PM ICT
UPDATE AD_Window SET Name='Asset Disposal2', IsActive='N',Updated=TO_TIMESTAMP('2013-03-24 20:58:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=53049
;

-- Mar 24, 2013 8:58:07 PM ICT
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=53049
;

-- Mar 24, 2013 8:58:07 PM ICT
UPDATE AD_Menu SET Name='Asset Disposal2', Description='Dispose of Assets', IsActive='N',Updated=TO_TIMESTAMP('2013-03-24 20:58:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53145
;

-- Mar 24, 2013 8:58:07 PM ICT
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=53145
;

-- Mar 24, 2013 8:58:15 PM ICT
UPDATE AD_Window SET Name='Asset Disposal',Updated=TO_TIMESTAMP('2013-03-24 20:58:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=53114
;

-- Mar 24, 2013 8:58:15 PM ICT
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=53114
;

-- Mar 24, 2013 8:58:15 PM ICT
UPDATE AD_Menu SET Name='Asset Disposal', Description='Dispose of Assets', IsActive='Y',Updated=TO_TIMESTAMP('2013-03-24 20:58:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53274
;

-- Mar 24, 2013 8:58:15 PM ICT
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=53274
;

-- Mar 24, 2013 9:14:57 PM ICT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',0,53137,210209,'U','N','N','N',0,'N',10,'N',19,200035,'N',196,'N','Y','34a3e305-8dd5-4e41-9953-8dbde442ceaf','Y','C_DocType_ID','Document type or rules','The Document Type determines document sequence and processing rules','Document Type','Y',TO_TIMESTAMP('2013-03-24 21:14:55','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-03-24 21:14:55','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 24, 2013 9:14:57 PM ICT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210209 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 24, 2013 9:15:05 PM ICT
ALTER TABLE A_Asset_Addition ADD COLUMN C_DocType_ID NUMERIC(10) DEFAULT NULL 
;

-- Mar 24, 2013 9:15:42 PM ICT
UPDATE AD_Tab SET Name='Asset Disposal', Description='Process the Disposal',Updated=TO_TIMESTAMP('2013-03-24 21:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53325
;

-- Mar 24, 2013 9:15:42 PM ICT
UPDATE AD_Tab_Trl SET IsTranslated='N' WHERE AD_Tab_ID=53325
;

-- Mar 24, 2013 9:16:12 PM ICT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',0,53127,210210,'U','N','N','N',0,'N',10,'N',19,200035,'N',196,'N','Y','928a0f0a-da92-405a-bedc-176cee363dee','Y','C_DocType_ID','Document type or rules','The Document Type determines document sequence and processing rules','Document Type','Y',TO_TIMESTAMP('2013-03-24 21:16:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-03-24 21:16:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 24, 2013 9:16:12 PM ICT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210210 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 24, 2013 9:16:18 PM ICT
ALTER TABLE A_Asset_Disposed ADD COLUMN C_DocType_ID NUMERIC(10) DEFAULT NULL 
;

-- Mar 24, 2013 9:16:33 PM ICT
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-03-24 21:16:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53127
;

-- Mar 24, 2013 9:16:50 PM ICT
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-03-24 21:16:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53123
;

-- Mar 24, 2013 9:17:01 PM ICT
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-03-24 21:17:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53130
;

-- Mar 24, 2013 9:17:04 PM ICT
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-03-24 21:17:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53132
;

-- Mar 24, 2013 9:17:06 PM ICT
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-03-24 21:17:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53135
;

-- Mar 24, 2013 9:17:09 PM ICT
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-03-24 21:17:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53134
;

-- Mar 24, 2013 9:17:11 PM ICT
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-03-24 21:17:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53136
;

-- Mar 24, 2013 9:17:31 PM ICT
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-03-24 21:17:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53131
;

-- Mar 24, 2013 9:17:50 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53325,36,'N','N',60357,'Y',201887,'N','D','A_Asset_Disposed_UU','Y','N','aa5f43db-8a63-46bb-8132-a8a0db473e36',100,0,TO_TIMESTAMP('2013-03-24 21:17:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-24 21:17:49','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 24, 2013 9:17:50 PM ICT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201887 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 24, 2013 9:17:51 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53325,10,'N','N',210210,'Y',201888,'N','The Document Type determines document sequence and processing rules','U','Document type or rules','Document Type','Y','N','c28d47c5-5c1c-4040-8190-967e0ae37c5c',100,0,TO_TIMESTAMP('2013-03-24 21:17:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-24 21:17:50','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 24, 2013 9:17:51 PM ICT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201888 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 24, 2013 9:17:52 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53325,10,'N','N',200075,'Y',201889,'N','The Invoice Document.','D','Invoice Identifier','Invoice','Y','N','d7270c7e-841e-49cf-bae0-8041a17d9509',100,0,TO_TIMESTAMP('2013-03-24 21:17:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-24 21:17:51','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 24, 2013 9:17:52 PM ICT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201889 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 24, 2013 9:17:54 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53325,10,'N','N',200076,'Y',201890,'N','The Invoice Line uniquely identifies a single line of an Invoice.','D','Invoice Detail Line','Invoice Line','Y','N','e15d85a5-f240-414d-87ac-9cbde577caf4',100,0,TO_TIMESTAMP('2013-03-24 21:17:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-24 21:17:52','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 24, 2013 9:17:54 PM ICT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201890 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 24, 2013 9:17:55 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53325,20,'N','N',59588,'Y',201891,'N','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.','D','The date+time (expressed in decimal format) when the document has been processed','Processed On','Y','N','20f54461-f9f4-46e5-9262-2fad03b7f38c',100,0,TO_TIMESTAMP('2013-03-24 21:17:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-24 21:17:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 24, 2013 9:17:55 PM ICT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201891 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201887
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201889
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201890
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201891
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201888
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=59396
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=59136
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=59138
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=59139
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=59137
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=59140
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=59402
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=59141
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=59405
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=59398
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=59401
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=59399
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=59400
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=59403
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=59404
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=59406
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=59408
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=59407
;

-- Mar 24, 2013 9:18:22 PM ICT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=59409
;

-- Mar 24, 2013 9:18:46 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201887
;

-- Mar 24, 2013 9:18:46 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=59407
;

-- Mar 24, 2013 9:18:46 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=59134
;

-- Mar 24, 2013 9:18:46 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201889
;

-- Mar 24, 2013 9:18:46 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201890
;

-- Mar 24, 2013 9:18:46 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201891
;

-- Mar 24, 2013 9:18:46 PM ICT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=59135
;

-- Mar 24, 2013 9:18:46 PM ICT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=59395
;

-- Mar 24, 2013 9:18:46 PM ICT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201888
;

-- Mar 24, 2013 9:18:46 PM ICT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=59409
;

-- Mar 24, 2013 9:19:11 PM ICT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-03-24 21:19:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201888
;

-- Mar 24, 2013 9:20:43 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53324,36,'N','N',60354,'Y',201892,'N','D','A_Asset_Addition_UU','Y','N','9d33d304-53c6-4aec-a126-b2e20505cfe8',100,0,TO_TIMESTAMP('2013-03-24 21:20:43','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-24 21:20:43','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 24, 2013 9:20:44 PM ICT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201892 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 24, 2013 9:20:44 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53324,10,'N','N',210209,'Y',201893,'N','The Document Type determines document sequence and processing rules','U','Document type or rules','Document Type','Y','N','384fc5d9-fcc7-43f4-8de1-dbbe912aedef',100,0,TO_TIMESTAMP('2013-03-24 21:20:44','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-24 21:20:44','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 24, 2013 9:20:44 PM ICT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201893 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201892
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201893
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=59118
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=59367
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=59368
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=59369
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=59119
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=59121
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=59120
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=59122
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=59123
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=59370
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=59371
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=59124
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=59372
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=59373
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=59374
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=59375
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=59376
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=59377
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=59125
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=59378
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=59126
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=59379
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=200159
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=59127
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=59380
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=59381
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=59382
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=59383
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=59384
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=59385
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=59386
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=59387
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=59388
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=59389
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=59390
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=59393
;

-- Mar 24, 2013 9:21:13 PM ICT
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=59394
;

-- Mar 24, 2013 9:21:31 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201892
;

-- Mar 24, 2013 9:21:31 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=59115
;

-- Mar 24, 2013 9:21:31 PM ICT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=59116
;

-- Mar 24, 2013 9:21:31 PM ICT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=59117
;

-- Mar 24, 2013 9:21:31 PM ICT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201893
;

-- Mar 24, 2013 9:21:50 PM ICT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-03-24 21:21:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201893
;

-- Mar 24, 2013 9:22:12 PM ICT
UPDATE AD_Menu SET Name='Create Asset From Project',Updated=TO_TIMESTAMP('2013-03-24 21:22:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200006
;

-- Mar 24, 2013 9:22:12 PM ICT
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=200006
;

-- Mar 24, 2013 9:22:42 PM ICT
UPDATE AD_Menu SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-24 21:22:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53175
;

-- Mar 24, 2013 9:22:46 PM ICT
UPDATE AD_Menu SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-24 21:22:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53176
;

-- Mar 24, 2013 9:31:15 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=56075
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56075
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56069
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56063
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56052
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56064
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56057
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56073
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56074
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56068
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56078
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56079
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56076
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56077
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56080
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56062
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=56053
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=56054
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=56055
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=56056
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=59256
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=59258
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=59259
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=59260
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=59261
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=56065
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=59262
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=56066
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=56067
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=59263
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=56070
;

-- Mar 24, 2013 9:31:18 PM ICT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=56071
;

-- Mar 24, 2013 9:31:19 PM ICT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=59264
;

-- Mar 24, 2013 9:31:19 PM ICT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=56072
;

-- Mar 24, 2013 9:31:19 PM ICT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=59265
;

-- Mar 24, 2013 9:31:50 PM ICT
UPDATE AD_Column SET IsMandatory='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-03-24 21:31:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59403
;

-- Mar 24, 2013 9:31:56 PM ICT
INSERT INTO t_alter_column values('a_asset_group_acct','A_Depreciation_Conv_F_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 24, 2013 9:31:57 PM ICT
INSERT INTO t_alter_column values('a_asset_group_acct','A_Depreciation_Conv_F_ID',null,'NULL',null)
;

-- Mar 24, 2013 9:32:06 PM ICT
UPDATE AD_Column SET IsMandatory='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-03-24 21:32:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59404
;

-- Mar 24, 2013 9:32:10 PM ICT
INSERT INTO t_alter_column values('a_asset_group_acct','A_Depreciation_Conv_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 24, 2013 9:32:10 PM ICT
INSERT INTO t_alter_column values('a_asset_group_acct','A_Depreciation_Conv_ID',null,'NULL',null)
;

-- Mar 24, 2013 9:32:21 PM ICT
UPDATE AD_Column SET IsMandatory='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-03-24 21:32:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59405
;

-- Mar 24, 2013 9:32:24 PM ICT
INSERT INTO t_alter_column values('a_asset_group_acct','A_Depreciation_Method_F_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 24, 2013 9:32:24 PM ICT
INSERT INTO t_alter_column values('a_asset_group_acct','A_Depreciation_Method_F_ID',null,'NULL',null)
;

-- Mar 24, 2013 9:32:34 PM ICT
UPDATE AD_Column SET IsMandatory='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-03-24 21:32:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59402
;

-- Mar 24, 2013 9:32:38 PM ICT
INSERT INTO t_alter_column values('a_asset_group_acct','A_Depreciation_Method_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 24, 2013 9:32:38 PM ICT
INSERT INTO t_alter_column values('a_asset_group_acct','A_Depreciation_Method_ID',null,'NULL',null)
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=59260
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=59261
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=59258
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=59259
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=56065
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=56066
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=59262
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=56067
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=59263
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=56070
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=56071
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=56072
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=59264
;

-- Mar 24, 2013 9:32:53 PM ICT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=59265
;

-- Mar 24, 2013 9:33:18 PM ICT
UPDATE AD_Column SET IsMandatory='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-03-24 21:33:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59307
;

-- Mar 24, 2013 9:33:22 PM ICT
INSERT INTO t_alter_column values('a_asset_acct','A_Depreciation_Conv_F_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 24, 2013 9:33:22 PM ICT
INSERT INTO t_alter_column values('a_asset_acct','A_Depreciation_Conv_F_ID',null,'NULL',null)
;

-- Mar 24, 2013 9:33:33 PM ICT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2013-03-24 21:33:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55632
;

-- Mar 24, 2013 9:33:37 PM ICT
INSERT INTO t_alter_column values('a_asset_acct','A_Depreciation_Conv_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 24, 2013 9:33:37 PM ICT
INSERT INTO t_alter_column values('a_asset_acct','A_Depreciation_Conv_ID',null,'NULL',null)
;

-- Mar 24, 2013 9:33:44 PM ICT
UPDATE AD_Column SET IsMandatory='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-03-24 21:33:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59305
;

-- Mar 24, 2013 9:33:46 PM ICT
INSERT INTO t_alter_column values('a_asset_acct','A_Depreciation_Method_F_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 24, 2013 9:33:46 PM ICT
INSERT INTO t_alter_column values('a_asset_acct','A_Depreciation_Method_F_ID',null,'NULL',null)
;

-- Mar 24, 2013 9:33:51 PM ICT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2013-03-24 21:33:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55628
;

-- Mar 24, 2013 9:33:53 PM ICT
INSERT INTO t_alter_column values('a_asset_acct','A_Depreciation_Method_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 24, 2013 9:33:53 PM ICT
INSERT INTO t_alter_column values('a_asset_acct','A_Depreciation_Method_ID',null,'NULL',null)
;

-- Mar 24, 2013 9:34:03 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=55877
;

-- Mar 24, 2013 9:34:03 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=59033
;

-- Mar 24, 2013 9:34:03 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=55876
;

-- Mar 24, 2013 9:34:03 PM ICT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=59032
;

-- Mar 24, 2013 9:34:03 PM ICT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=55880
;

-- Mar 24, 2013 9:34:03 PM ICT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=55881
;

-- Mar 24, 2013 9:34:03 PM ICT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=55882
;

-- Mar 24, 2013 9:34:03 PM ICT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=59034
;

-- Mar 24, 2013 9:34:03 PM ICT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=59035
;

-- Mar 24, 2013 9:34:35 PM ICT
UPDATE AD_Tab SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-24 21:34:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=451
;

-- Mar 24, 2013 9:34:45 PM ICT
UPDATE AD_Tab SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-24 21:34:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53164
;

-- Mar 24, 2013 9:36:18 PM ICT
UPDATE AD_Menu SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-24 21:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53138
;

-- Mar 24, 2013 9:36:21 PM ICT
UPDATE AD_Menu SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-24 21:36:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53136
;

-- Mar 24, 2013 9:37:19 PM ICT
UPDATE AD_Menu SET Name='Asset Transactions ', Description='Asset Transactions (Addition, Disposal, Split & Transfer)',Updated=TO_TIMESTAMP('2013-03-24 21:37:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53139
;

-- Mar 24, 2013 9:37:19 PM ICT
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=53139
;

-- Mar 24, 2013 9:39:55 PM ICT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,IsOrgLevelSequence,StartNo,StartNewMonth) VALUES ('N',100,'N',1000000,'N','Y',200070,'Asset Addition',1,'bb13be47-97be-4334-b9de-b10d31722bac',0,11,TO_TIMESTAMP('2013-03-24 21:39:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-24 21:39:53','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',1000000,'N')
;

-- Mar 24, 2013 9:40:10 PM ICT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,IsOrgLevelSequence,StartNo,StartNewMonth) VALUES ('N',100,'N',1000000,'N','Y',200071,'Asset Depreciation',1,'d134f7ea-3d17-43e1-82a1-45764d57a835',0,11,TO_TIMESTAMP('2013-03-24 21:40:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-24 21:40:09','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',1000000,'N')
;

-- Mar 24, 2013 9:40:18 PM ICT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,IsOrgLevelSequence,StartNo,StartNewMonth) VALUES ('N',100,'N',1000000,'N','Y',200072,'Asset Disposal',1,'a30f77d3-1d39-4ec4-8187-bb402877f605',0,11,TO_TIMESTAMP('2013-03-24 21:40:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-24 21:40:16','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',1000000,'N')
;

-- Mar 24, 2013 9:40:29 PM ICT
INSERT INTO C_DocType (DocNoSequence_ID,GL_Category_ID,C_DocType_ID,IsDefault,DocBaseType,IsSOTrx,DocumentCopies,IsCreateCounter,IsIndexed,IsShipConfirm,IsSplitWhenDifference,IsDefaultCounterDoc,IsInTransit,IsPickQAConfirm,IsOverwriteDateOnComplete,IsOverwriteSeqOnComplete,C_DocType_UU,IsPrepareSplitDocument,PrintName,Name,IsDocNoControlled,HasCharges,HasProforma,CreatedBy,UpdatedBy,Updated,AD_Org_ID,IsActive,Created,AD_Client_ID,IsChargeOrProductMandatory) VALUES (200070,108,200001,'N','FAA','N',1,'Y','Y','N','N','N','N','N','N','N','7b210fc5-489c-4ff3-9d9a-2fbe8b4c5136','Y','Asset Addition','Asset Addition','Y','N','N',100,100,TO_TIMESTAMP('2013-03-24 21:40:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-24 21:40:28','YYYY-MM-DD HH24:MI:SS'),11,'N')
;

-- Mar 24, 2013 9:40:29 PM ICT
INSERT INTO C_DocType_Trl (AD_Language,C_DocType_ID, DocumentNote,PrintName,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_DocType_Trl_UU ) SELECT l.AD_Language,t.C_DocType_ID, t.DocumentNote,t.PrintName,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, C_DocType t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_DocType_ID=200001 AND NOT EXISTS (SELECT * FROM C_DocType_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_DocType_ID=t.C_DocType_ID)
;

-- Mar 24, 2013 9:40:42 PM ICT
INSERT INTO C_DocType (DocNoSequence_ID,GL_Category_ID,C_DocType_ID,IsDefault,DocBaseType,IsSOTrx,DocumentCopies,IsCreateCounter,IsIndexed,IsShipConfirm,IsSplitWhenDifference,IsDefaultCounterDoc,IsInTransit,IsPickQAConfirm,IsOverwriteDateOnComplete,IsOverwriteSeqOnComplete,C_DocType_UU,IsPrepareSplitDocument,PrintName,Name,IsDocNoControlled,HasCharges,HasProforma,CreatedBy,UpdatedBy,Updated,AD_Org_ID,IsActive,Created,AD_Client_ID,IsChargeOrProductMandatory) VALUES (200071,108,200002,'N','FAA','N',1,'Y','Y','N','N','N','N','N','N','N','2d0701af-23b4-4c8c-9c48-9fb238db69fb','Y','Asset Depreciation','Asset Depreciation','Y','N','N',100,100,TO_TIMESTAMP('2013-03-24 21:40:41','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-24 21:40:41','YYYY-MM-DD HH24:MI:SS'),11,'N')
;

-- Mar 24, 2013 9:40:42 PM ICT
INSERT INTO C_DocType_Trl (AD_Language,C_DocType_ID, DocumentNote,PrintName,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_DocType_Trl_UU ) SELECT l.AD_Language,t.C_DocType_ID, t.DocumentNote,t.PrintName,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, C_DocType t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_DocType_ID=200002 AND NOT EXISTS (SELECT * FROM C_DocType_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_DocType_ID=t.C_DocType_ID)
;

-- Mar 24, 2013 9:40:56 PM ICT
INSERT INTO C_DocType (DocNoSequence_ID,GL_Category_ID,C_DocType_ID,IsDefault,DocBaseType,IsSOTrx,DocumentCopies,IsCreateCounter,IsIndexed,IsShipConfirm,IsSplitWhenDifference,IsDefaultCounterDoc,IsInTransit,IsPickQAConfirm,IsOverwriteDateOnComplete,IsOverwriteSeqOnComplete,C_DocType_UU,IsPrepareSplitDocument,PrintName,Name,IsDocNoControlled,HasCharges,HasProforma,CreatedBy,UpdatedBy,Updated,AD_Org_ID,IsActive,Created,AD_Client_ID,IsChargeOrProductMandatory) VALUES (200072,108,200003,'N','FAA','N',1,'Y','Y','N','N','N','N','N','N','N','0fac34f1-aa81-49d7-be50-88b566ca81c8','Y','Asset Disposal','Asset Disposal','Y','N','N',100,100,TO_TIMESTAMP('2013-03-24 21:40:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-24 21:40:55','YYYY-MM-DD HH24:MI:SS'),11,'N')
;

-- Mar 24, 2013 9:40:56 PM ICT
INSERT INTO C_DocType_Trl (AD_Language,C_DocType_ID, DocumentNote,PrintName,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_DocType_Trl_UU ) SELECT l.AD_Language,t.C_DocType_ID, t.DocumentNote,t.PrintName,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, C_DocType t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_DocType_ID=200003 AND NOT EXISTS (SELECT * FROM C_DocType_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_DocType_ID=t.C_DocType_ID)
;

-- Mar 24, 2013 9:43:42 PM ICT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-03-24 21:43:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=55803
;

-- Mar 24, 2013 9:44:04 PM ICT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-03-24 21:44:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59395
;

SELECT register_migration_script('201304170928_IDEMPIERE-796_2.sql') FROM dual
;

