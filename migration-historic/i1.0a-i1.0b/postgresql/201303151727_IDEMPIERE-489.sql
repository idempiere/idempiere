SET CLIENT_ENCODING TO 'UTF8';

-- Mar 15, 2013 5:15:08 PM COT
-- IDEMPIERE-489 Make use of AD_Language configuration 
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',0,111,210160,'D','N','N','N',0,'N',10,'N',19,'N',1793,'N','Y','954051a7-4b61-45d1-ad84-a949ccaf1084','Y','AD_PrintPaper_ID','Printer paper definition','Printer Paper Size, Orientation and Margins','Print Paper','Y',TO_TIMESTAMP('2013-03-15 17:15:07','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-03-15 17:15:07','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 15, 2013 5:15:08 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210160 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 15, 2013 5:15:20 PM COT
ALTER TABLE AD_Language ADD COLUMN AD_PrintPaper_ID NUMERIC(10) DEFAULT NULL 
;

-- Mar 15, 2013 5:17:33 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',0,111,210161,'D','N','N','N',0,'N',60,'N',10,'N',958,'N','Y','5b7516ac-f385-4c7c-9f10-e9aeb50d3306','Y','PrintName','The label text to be printed on a document or correspondence.','The Label to be printed indicates the name that will be printed on a document or correspondence. The max length is 2000 characters.','Print Text','Y',TO_TIMESTAMP('2013-03-15 17:17:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-03-15 17:17:33','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 15, 2013 5:17:33 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210161 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 15, 2013 5:17:50 PM COT
ALTER TABLE AD_Language ADD COLUMN PrintName VARCHAR(60) DEFAULT NULL 
;

-- Mar 15, 2013 5:18:27 PM COT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-03-15 17:18:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210161
;

-- Mar 15, 2013 5:18:31 PM COT
INSERT INTO t_alter_column values('ad_language','PrintName','VARCHAR(60)',null,null)
;

update ad_language set printname=name
;

-- Mar 15, 2013 5:18:31 PM COT
INSERT INTO t_alter_column values('ad_language','PrintName',null,'NOT NULL',null)
;

-- Mar 15, 2013 5:19:16 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',112,36,'N','N',60428,'Y',201883,'N','D','AD_Language_UU','219839b4-3e13-46e4-9234-fcce533f06f0','Y','N',100,0,TO_TIMESTAMP('2013-03-15 17:19:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-15 17:19:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 15, 2013 5:19:16 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201883 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 15, 2013 5:19:16 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',112,10,'N','N',210160,'Y',201884,'N','Printer Paper Size, Orientation and Margins','D','Printer paper definition','Print Paper','29c3e7dd-bde7-4a09-8a61-f00545a2c0c9','Y','N',100,0,TO_TIMESTAMP('2013-03-15 17:19:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-15 17:19:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 15, 2013 5:19:16 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201884 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 15, 2013 5:19:17 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',112,60,'N','N',210161,'Y',201885,'N','The Label to be printed indicates the name that will be printed on a document or correspondence. The max length is 2000 characters.','D','The label text to be printed on a document or correspondence.','Print Text','186fd397-8266-47a6-b6de-04e846997038','Y','N',100,0,TO_TIMESTAMP('2013-03-15 17:19:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-15 17:19:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 15, 2013 5:19:17 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201885 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=10,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=289
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=20,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1995
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=30,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=216
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=217
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET ColumnSpan=5, SeqNo=50, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201885
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1346
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET ColumnSpan=2, SeqNo=90, IsDisplayed='Y', XPosition=5,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200654
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=218
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=110, IsDisplayed='Y', XPosition=5,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=219
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11172
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11175
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11173
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET ColumnSpan=2, SeqNo=150, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201884
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5226
;

-- Mar 15, 2013 5:22:48 PM COT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_TIMESTAMP('2013-03-15 17:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201883
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=289
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201883
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=5226
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=1995
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=216
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=217
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=3047
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201885
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=5225
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=218
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=1346
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=11172
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=11175
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=11173
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=201884
;

-- Mar 15, 2013 5:23:54 PM COT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=219
;

-- Mar 15, 2013 6:54:38 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=319, IsMandatory='N', AD_Reference_ID=17,Updated=TO_TIMESTAMP('2013-03-15 18:54:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13080
;

-- Mar 15, 2013 6:54:40 PM COT
INSERT INTO t_alter_column values('ad_language','IsDecimalPoint','CHAR(1)',null,'NULL')
;

-- Mar 15, 2013 6:54:40 PM COT
INSERT INTO t_alter_column values('ad_language','IsDecimalPoint',null,'NULL',null)
;

update ad_language set isdecimalpoint=null
;

-- Mar 15, 2013 6:59:39 PM COT
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-03-15 18:59:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11173
;

-- Mar 15, 2013 7:00:48 PM COT
UPDATE AD_Column SET IsSelectionColumn='Y',Updated=TO_TIMESTAMP('2013-03-15 19:00:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=203
;

-- Mar 15, 2013 7:01:43 PM COT
UPDATE AD_Column SET SeqNoSelection=1,Updated=TO_TIMESTAMP('2013-03-15 19:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=203
;

-- Mar 15, 2013 7:01:59 PM COT
UPDATE AD_Column SET SeqNoSelection=2,Updated=TO_TIMESTAMP('2013-03-15 19:01:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=204
;

-- Mar 15, 2013 7:02:09 PM COT
UPDATE AD_Column SET SeqNoSelection=3,Updated=TO_TIMESTAMP('2013-03-15 19:02:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3886
;

-- Mar 15, 2013 7:03:37 PM COT
UPDATE AD_Language SET DatePattern='dd.MM.yyyy', PrintName='ﺔﻴﺑﺮﻌﻟﺍ (AR)',Updated=TO_TIMESTAMP('2013-03-15 19:03:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=115
;

-- Mar 15, 2013 7:04:38 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='Български (BG)',Updated=TO_TIMESTAMP('2013-03-15 19:04:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=118
;

-- Mar 15, 2013 7:05:07 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='Català',Updated=TO_TIMESTAMP('2013-03-15 19:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=119
;

-- Mar 15, 2013 7:05:46 PM COT
UPDATE AD_Language SET DatePattern='dd-MM-yyyy', PrintName='Dansk',Updated=TO_TIMESTAMP('2013-03-15 19:05:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=121
;

-- Mar 15, 2013 7:06:48 PM COT
UPDATE AD_Language SET PrintName='Deutsch',Updated=TO_TIMESTAMP('2013-03-15 19:06:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=191
;

-- Mar 15, 2013 7:07:07 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='Ελληνικά (GR)',Updated=TO_TIMESTAMP('2013-03-15 19:07:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=125
;

-- Mar 15, 2013 7:07:35 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='English (AU)',Updated=TO_TIMESTAMP('2013-03-15 19:07:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=126
;

-- Mar 15, 2013 7:08:10 PM COT
UPDATE AD_Language SET PrintName='English (UK)',Updated=TO_TIMESTAMP('2013-03-15 19:08:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=128
;

-- Mar 15, 2013 7:09:24 PM COT
UPDATE AD_Language SET AD_PrintPaper_ID=101, PrintName='English',Updated=TO_TIMESTAMP('2013-03-15 19:09:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=192
;

-- Mar 15, 2013 7:10:11 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', AD_PrintPaper_ID=101, PrintName='Español (Colombia)',Updated=TO_TIMESTAMP('2013-03-15 19:10:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=136
;

-- Mar 15, 2013 7:10:38 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='Español (DO)',Updated=TO_TIMESTAMP('2013-03-15 19:10:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=138
;

-- Mar 15, 2013 7:11:21 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='Español (EC)',Updated=TO_TIMESTAMP('2013-03-15 19:11:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=139
;

-- Mar 15, 2013 7:11:49 PM COT
UPDATE AD_Language SET PrintName='Español',Updated=TO_TIMESTAMP('2013-03-15 19:11:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=140
;

-- Mar 15, 2013 7:12:07 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', AD_PrintPaper_ID=101, PrintName='Español (MX)',Updated=TO_TIMESTAMP('2013-03-15 19:12:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=143
;

-- Mar 15, 2013 7:12:48 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='Español (VE)',Updated=TO_TIMESTAMP('2013-03-15 19:12:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=151
;

-- Mar 15, 2013 7:13:27 PM COT
UPDATE AD_Language SET DatePattern='dd-MM-yyyy', PrintName='Farsi', IsDecimalPoint='N',Updated=TO_TIMESTAMP('2013-03-15 19:13:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=193
;

-- Mar 15, 2013 7:13:51 PM COT
UPDATE AD_Language SET DatePattern='dd.MM.yyyy', PrintName='Finnish', IsDecimalPoint='Y',Updated=TO_TIMESTAMP('2013-03-15 19:13:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=153
;

-- Mar 15, 2013 7:14:29 PM COT
UPDATE AD_Language SET DatePattern='MM/dd/yyyy', AD_PrintPaper_ID=101, PrintName='Français (CA)', IsDecimalPoint='Y',Updated=TO_TIMESTAMP('2013-03-15 19:14:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=155
;

-- Mar 15, 2013 7:14:54 PM COT
UPDATE AD_Language SET PrintName='Français',Updated=TO_TIMESTAMP('2013-03-15 19:14:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=190
;

-- Mar 15, 2013 7:15:29 PM COT
UPDATE AD_Language SET DatePattern='dd.MM.yyyy', PrintName='Hrvatski',Updated=TO_TIMESTAMP('2013-03-15 19:15:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=159
;

-- Mar 15, 2013 7:15:49 PM COT
UPDATE AD_Language SET DatePattern='yyyy.MM.dd', PrintName='Magyar (HU)',Updated=TO_TIMESTAMP('2013-03-15 19:15:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=160
;

-- Mar 15, 2013 7:16:12 PM COT
UPDATE AD_Language SET DatePattern='dd-MM-yyyy', PrintName='Indonesia Bahasa',Updated=TO_TIMESTAMP('2013-03-15 19:16:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=50010
;

-- Mar 15, 2013 7:16:33 PM COT
UPDATE AD_Language SET PrintName='Italiano',Updated=TO_TIMESTAMP('2013-03-15 19:16:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=163
;

-- Mar 15, 2013 7:17:07 PM COT
UPDATE AD_Language SET PrintName='日本語 (JP)',Updated=TO_TIMESTAMP('2013-03-15 19:17:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=165
;

-- Mar 15, 2013 7:17:43 PM COT
UPDATE AD_Language SET DatePattern='dd-MM-yyyy', PrintName='Malaysian', IsDecimalPoint='N',Updated=TO_TIMESTAMP('2013-03-15 19:17:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=50003
;

-- Mar 15, 2013 7:18:09 PM COT
UPDATE AD_Language SET DatePattern='dd-MM-yyyy', PrintName='Nederlands',Updated=TO_TIMESTAMP('2013-03-15 19:18:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=171
;

-- Mar 15, 2013 7:18:32 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='Norsk',Updated=TO_TIMESTAMP('2013-03-15 19:18:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=172
;

-- Mar 15, 2013 7:19:06 PM COT
UPDATE AD_Language SET DatePattern='dd-MM-yyyy', PrintName='Polski',Updated=TO_TIMESTAMP('2013-03-15 19:19:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=173
;

-- Mar 15, 2013 7:19:24 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='Portuguese (BR)',Updated=TO_TIMESTAMP('2013-03-15 19:19:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=174
;

-- Mar 15, 2013 7:19:50 PM COT
UPDATE AD_Language SET DatePattern='dd.MM.yyyy', PrintName='Română',Updated=TO_TIMESTAMP('2013-03-15 19:19:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=176
;

-- Mar 15, 2013 7:20:11 PM COT
UPDATE AD_Language SET DatePattern='dd-MM-yyyy', PrintName='Русский (Russian)',Updated=TO_TIMESTAMP('2013-03-15 19:20:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=177
;

-- Mar 15, 2013 7:20:37 PM COT
UPDATE AD_Language SET DatePattern='dd.MM.yyyy', PrintName='Slovenski',Updated=TO_TIMESTAMP('2013-03-15 19:20:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=180
;

-- Mar 15, 2013 7:21:08 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='Albanian', IsDecimalPoint='Y',Updated=TO_TIMESTAMP('2013-03-15 19:21:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=181
;

-- Mar 15, 2013 7:21:49 PM COT
UPDATE AD_Language SET DatePattern='dd.MM.yyyy', PrintName='Српски (RS)',Updated=TO_TIMESTAMP('2013-03-15 19:21:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=50015
;

-- Mar 15, 2013 7:22:13 PM COT
UPDATE AD_Language SET DatePattern='yyyy-MM-dd', PrintName='Svenska',Updated=TO_TIMESTAMP('2013-03-15 19:22:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=183
;

-- Mar 15, 2013 7:22:40 PM COT
UPDATE AD_Language SET DatePattern='dd/MM/yyyy', PrintName='ไทย (TH)', IsDecimalPoint='N',Updated=TO_TIMESTAMP('2013-03-15 19:22:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=184
;

-- Mar 15, 2013 7:23:14 PM COT
UPDATE AD_Language SET DatePattern='dd-MM-yyyy', PrintName='Việt Nam',Updated=TO_TIMESTAMP('2013-03-15 19:23:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=194
;

-- Mar 15, 2013 7:23:48 PM COT
UPDATE AD_Language SET DatePattern='yyyy-MM-dd', PrintName='简体中文 (CN)',Updated=TO_TIMESTAMP('2013-03-15 19:23:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=187
;

-- Mar 15, 2013 7:24:14 PM COT
UPDATE AD_Language SET PrintName='繁體中文 (TW)',Updated=TO_TIMESTAMP('2013-03-15 19:24:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=189
;

-- Mar 15, 2013 10:32:23 PM COT
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2013-03-15 22:32:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201884
;

-- Mar 15, 2013 10:32:23 PM COT
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2013-03-15 22:32:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5226
;

-- Mar 15, 2013 10:32:23 PM COT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_TIMESTAMP('2013-03-15 22:32:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11173
;

-- Mar 15, 2013 10:32:23 PM COT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_TIMESTAMP('2013-03-15 22:32:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11175
;

SELECT register_migration_script('201303151727_IDEMPIERE-489.sql') FROM dual
;

