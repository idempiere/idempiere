-- Jan 17, 2013 4:59:01 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',661,208381,'D','N','N','N',0,'N',1,'N',28,'N',1490,'N','Y','4b3ce962-3793-4481-951b-3be35236b0a5','Y','CreateFrom','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.','Create lines from','Y',100,TO_DATE('2013-01-17 16:58:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-17 16:58:59','YYYY-MM-DD HH24:MI:SS'),100,0,0,'Y','N')
;

-- Jan 17, 2013 4:59:02 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208381 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 17, 2013 4:59:05 PM SGT
-- Ticket 1001770: RMA improvements
ALTER TABLE M_RMA ADD CreateFrom CHAR(1) DEFAULT NULL 
;

-- Jan 17, 2013 4:59:53 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',628,1,'N','N',208381,'Y',201654,'N','The Create From process will create a new document based on information in an existing document selected by the user.','D','Process which will generate a new document lines based on an existing document','Create lines from','N','Y','7670ee3c-1706-4878-959e-76e72553cb9f',100,0,TO_DATE('2013-01-17 16:59:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-17 16:59:52','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 17, 2013 4:59:53 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201654 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 17, 2013 4:59:54 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',628,36,'N','N',60948,'Y',201655,'N','D','M_RMA_UU','N','Y','116fe123-5fa5-427d-8c1d-7a784adc30e6',100,0,TO_DATE('2013-01-17 16:59:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-17 16:59:53','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 17, 2013 4:59:54 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201655 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 17, 2013 4:59:55 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',628,22,'N','N',57790,'Y',201656,'N','D','Referenced RMA','N','Y','98cee54f-a60a-4d4c-8882-4b83bc46216b',100,0,TO_DATE('2013-01-17 16:59:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-17 16:59:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 17, 2013 4:59:55 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201656 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 17, 2013 5:00:50 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201655
;

-- Jan 17, 2013 5:00:50 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201656
;

-- Jan 17, 2013 5:00:50 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=201654
;

-- Jan 17, 2013 5:00:50 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=52000
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=9302
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201655
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201656
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=9306
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=9303
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=9305
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=9309
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=10413
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=10375
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=10399
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=9304
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=10416
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=10382
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=10400
;

-- Jan 17, 2013 5:00:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=10380
;

-- Jan 17, 2013 5:00:57 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=10381
;

-- Jan 17, 2013 5:00:57 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=10374
;

-- Jan 17, 2013 5:00:57 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=201654
;

-- Jan 17, 2013 5:01:25 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-01-17 17:01:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201654
;

-- Jan 17, 2013 5:02:03 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53280,1,'N','N',208381,'Y',201657,'N','The Create From process will create a new document based on information in an existing document selected by the user.','D','Process which will generate a new document lines based on an existing document','Create lines from','N','Y','ed4e5b43-bc9d-4dab-80e0-445babd647c6',100,0,TO_DATE('2013-01-17 17:02:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-17 17:02:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 17, 2013 5:02:03 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201657 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 17, 2013 5:02:04 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53280,36,'N','N',60948,'Y',201658,'N','D','M_RMA_UU','N','Y','0b3c888d-b170-4abb-9517-c981b49daabe',100,0,TO_DATE('2013-01-17 17:02:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-17 17:02:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 17, 2013 5:02:04 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201658 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 17, 2013 5:02:05 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53280,22,'N','N',57790,'Y',201659,'N','D','Referenced RMA','N','Y','0e186562-ad5d-4e2e-b531-21d4c9505960',100,0,TO_DATE('2013-01-17 17:02:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-17 17:02:04','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 17, 2013 5:02:05 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201659 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 17, 2013 5:02:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201658
;

-- Jan 17, 2013 5:02:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201659
;

-- Jan 17, 2013 5:02:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=201657
;

-- Jan 17, 2013 5:02:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=57965
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=57950
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201658
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201659
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=57951
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=57952
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=57953
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=57954
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=57955
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=57956
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=57957
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=57958
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=57959
;

-- Jan 17, 2013 5:02:23 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=57960
;

-- Jan 17, 2013 5:02:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=57961
;

-- Jan 17, 2013 5:02:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=57962
;

-- Jan 17, 2013 5:02:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=57963
;

-- Jan 17, 2013 5:02:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=57964
;

-- Jan 17, 2013 5:02:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=201657
;

-- Jan 17, 2013 5:02:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-01-17 17:02:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201657
;

SELECT register_migration_script('201301181134_TICKET-1001770.sql') FROM dual
;