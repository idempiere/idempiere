-- Jul 5, 2013 9:52:28 PM COT
UPDATE AD_Element SET Help=NULL, Description='Defines whether content must be treated as secure',Updated=TO_TIMESTAMP('2013-07-05 21:52:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2991
;

-- Jul 5, 2013 9:52:28 PM COT
UPDATE AD_Column SET ColumnName='IsSecure', Name='Secure content', Description='Defines whether content must be treated as secure', Help=NULL WHERE AD_Element_ID=2991
;

-- Jul 5, 2013 9:52:28 PM COT
UPDATE AD_Process_Para SET ColumnName='IsSecure', Name='Secure content', Description='Defines whether content must be treated as secure', Help=NULL, AD_Element_ID=2991 WHERE UPPER(ColumnName)='ISSECURE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jul 5, 2013 9:52:28 PM COT
UPDATE AD_Process_Para SET ColumnName='IsSecure', Name='Secure content', Description='Defines whether content must be treated as secure', Help=NULL WHERE AD_Element_ID=2991 AND IsCentrallyMaintained='Y'
;

-- Jul 5, 2013 9:52:28 PM COT
UPDATE AD_InfoColumn SET ColumnName='IsSecure', Name='Secure content', Description='Defines whether content must be treated as secure', Help=NULL WHERE AD_Element_ID=2991 AND IsCentrallyMaintained='Y'
;

-- Jul 5, 2013 9:52:28 PM COT
UPDATE AD_Field SET Name='Secure content', Description='Defines whether content must be treated as secure', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2991) AND IsCentrallyMaintained='Y'
;

-- Jul 5, 2013 9:55:26 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,101,210596,'Y','N','N',0,'N',1,'N',20,'N','N','Y','4390c065-55a1-4f20-b5dd-fbd2b50ee66d','Y','IsSecure','Defines whether content must be treated as secure','N','Secure content','Y',TO_TIMESTAMP('2013-07-05 21:55:24','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-05 21:55:24','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2991)
;

-- Jul 5, 2013 9:55:26 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210596 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 5, 2013 9:55:33 PM COT
ALTER TABLE AD_Column ADD COLUMN IsSecure CHAR(1) DEFAULT 'N' CHECK (IsSecure IN ('Y','N')) NOT NULL
;

-- Jul 5, 2013 9:57:16 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES (0,'N',101,0,'N','N',210596,420,'Y',202257,'N','D','Defines whether content must be treated as secure','Secure content','16162fa3-3425-4e4b-b1bc-d620bdf72ba4','Y','N',100,0,TO_TIMESTAMP('2013-07-05 21:57:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-05 21:57:15','YYYY-MM-DD HH24:MI:SS'),'Y','Y',430,1,'N',0,1,1)
;

-- Jul 5, 2013 9:57:16 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202257 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 5, 2013 10:00:19 PM COT
UPDATE AD_Field SET SeqNo=280, IsDisplayed='Y', XPosition=5, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-07-05 22:00:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202257
;

-- Jul 5, 2013 10:00:19 PM COT
UPDATE AD_Field SET SeqNo=290, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-07-05 22:00:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2370
;

-- Jul 5, 2013 10:00:19 PM COT
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2013-07-05 22:00:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10128
;

-- Jul 5, 2013 10:00:19 PM COT
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2013-07-05 22:00:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=160
;

-- Jul 5, 2013 10:00:19 PM COT
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2013-07-05 22:00:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5122
;

-- Jul 5, 2013 10:00:19 PM COT
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2013-07-05 22:00:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4941
;

-- Jul 5, 2013 10:00:19 PM COT
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2013-07-05 22:00:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50188
;

-- Jul 5, 2013 10:00:19 PM COT
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2013-07-05 22:00:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=168
;

-- Jul 5, 2013 10:00:20 PM COT
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2013-07-05 22:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=159
;

-- Jul 5, 2013 10:00:20 PM COT
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2013-07-05 22:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4940
;

-- Jul 5, 2013 10:00:20 PM COT
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2013-07-05 22:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200288
;

-- Jul 5, 2013 10:00:20 PM COT
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2013-07-05 22:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56317
;

-- Jul 5, 2013 10:00:20 PM COT
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2013-07-05 22:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62467
;

-- Jul 5, 2013 10:00:20 PM COT
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2013-07-05 22:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=167
;

-- Jul 5, 2013 10:00:20 PM COT
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2013-07-05 22:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=825
;

-- Jul 5, 2013 10:13:17 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:13:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6560
;

-- Jul 5, 2013 10:15:16 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6559
;

-- Jul 5, 2013 10:15:42 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:15:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4771
;

-- Jul 5, 2013 10:20:07 PM COT
UPDATE R_RequestProcessor SET DateLastRun=TO_TIMESTAMP('2013-07-05 22:20:07','YYYY-MM-DD HH24:MI:SS'), DateNextRun=TO_TIMESTAMP('2013-07-05 22:35:07','YYYY-MM-DD HH24:MI:SS'),Updated=TO_TIMESTAMP('2013-07-05 22:20:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE R_RequestProcessor_ID=1000003
;

-- Jul 5, 2013 10:29:14 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:29:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200972
;

-- Jul 5, 2013 10:29:21 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:29:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200974
;

-- Jul 5, 2013 10:29:27 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:29:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200971
;

-- Jul 5, 2013 10:29:32 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:29:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200973
;

-- Jul 5, 2013 10:30:23 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:30:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12943
;

-- Jul 5, 2013 10:31:04 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:31:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9885
;

-- Jul 5, 2013 10:31:11 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:31:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12402
;

-- Jul 5, 2013 10:31:14 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:31:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12409
;

-- Jul 5, 2013 10:31:38 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:31:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7806
;

-- Jul 5, 2013 10:31:50 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:31:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14856
;

-- Jul 5, 2013 10:32:00 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:32:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12944
;

-- Jul 5, 2013 10:32:35 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:32:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200458
;

-- Jul 5, 2013 10:32:52 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:32:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7793
;

-- Jul 5, 2013 10:32:55 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:32:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7794
;

-- Jul 5, 2013 10:33:28 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:33:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200409
;

-- Jul 5, 2013 10:33:35 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:33:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12401
;

-- Jul 5, 2013 10:33:43 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:33:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=417
;

-- Jul 5, 2013 10:33:55 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:33:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=61756
;

-- Jul 5, 2013 10:33:58 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:33:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200457
;

-- Jul 5, 2013 10:34:08 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:34:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=52066
;

-- Jul 5, 2013 10:35:02 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:35:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200895
;

-- Jul 5, 2013 10:35:15 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:35:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200898
;

-- Jul 5, 2013 10:35:26 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:35:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200897
;

-- Jul 5, 2013 10:35:30 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:35:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200896
;

-- Jul 5, 2013 10:36:19 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:36:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10365
;

-- Jul 5, 2013 10:36:26 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:36:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10354
;

-- Jul 5, 2013 10:36:30 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10345
;

-- Jul 5, 2013 10:36:37 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:36:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10350
;

-- Jul 5, 2013 10:36:42 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:36:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10356
;

-- Jul 5, 2013 10:36:46 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:36:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10367
;

-- Jul 5, 2013 10:36:56 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10360
;

-- Jul 5, 2013 10:37:32 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:37:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5060
;

-- Jul 5, 2013 10:37:42 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:37:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5062
;

-- Jul 5, 2013 10:37:45 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:37:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5064
;

-- Jul 5, 2013 10:37:48 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:37:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5065
;

-- Jul 5, 2013 10:38:29 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:38:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54537
;

-- Jul 5, 2013 10:38:36 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:38:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54540
;

-- Jul 5, 2013 10:39:10 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:39:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54587
;

-- Jul 5, 2013 10:39:18 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:39:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54590
;

-- Jul 5, 2013 10:39:32 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:39:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54589
;

-- Jul 5, 2013 10:39:43 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:39:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54539
;

-- Jul 5, 2013 10:40:34 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:40:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13618
;

-- Jul 5, 2013 10:41:49 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:41:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200612
;

-- Jul 5, 2013 10:43:21 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:43:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=201024
;

-- Jul 5, 2013 10:43:24 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:43:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=201025
;

-- Jul 5, 2013 10:43:37 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:43:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=201034
;

-- Jul 5, 2013 10:43:51 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:43:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202058
;

-- Jul 5, 2013 10:44:00 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:44:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202064
;

-- Jul 5, 2013 10:44:03 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:44:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202065
;

-- Jul 5, 2013 10:44:06 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:44:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202066
;

-- Jul 5, 2013 10:45:06 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:45:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202216
;

-- Jul 5, 2013 10:45:41 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:45:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=201176
;

-- Jul 5, 2013 10:45:43 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:45:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=201177
;

-- Jul 5, 2013 10:46:00 PM COT
UPDATE AD_Column SET IsSecure='Y',Updated=TO_TIMESTAMP('2013-07-05 22:46:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=201174
;

SELECT register_migration_script('201307052208_IDEMPIERE-1151.sql') FROM dual
;

