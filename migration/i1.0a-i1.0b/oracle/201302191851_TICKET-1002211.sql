SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 19, 2013 3:37:23 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',106,208589,'D','N','N','N',0,'N',10,'N',19,'N',202212,'N','Y','2866e75e-6021-4e27-9f48-bc3ab9d219a3','Y','AD_CtxHelp_ID','Context Help','Y',100,TO_DATE('2013-02-19 15:37:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-19 15:37:21','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 19, 2013 3:37:24 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208589 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 19, 2013 3:37:27 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_Tab ADD AD_CtxHelp_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 19, 2013 3:38:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',376,208590,'D','N','N','N',0,'N',10,'N',19,'N',202212,'N','Y','39bd71fb-adf0-4cea-8a32-ac0b6ba37269','Y','AD_CtxHelp_ID','Context Help','Y',100,TO_DATE('2013-02-19 15:38:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-19 15:38:11','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 19, 2013 3:38:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208590 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 19, 2013 3:38:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_Form ADD AD_CtxHelp_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 19, 2013 3:38:38 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',895,208591,'D','N','N','N',0,'N',10,'N',19,'N',202212,'N','Y','f99d251d-0d85-4b8e-bc45-03596926ad81','Y','AD_CtxHelp_ID','Context Help','Y',100,TO_DATE('2013-02-19 15:38:38','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-19 15:38:38','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 19, 2013 3:38:38 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208591 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 19, 2013 3:38:40 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_InfoWindow ADD AD_CtxHelp_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 19, 2013 3:39:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',284,208592,'D','N','N','N',0,'N',10,'N',19,'N',202212,'N','Y','9a011043-658e-40df-b994-52ff3fc5c696','Y','AD_CtxHelp_ID','Context Help','Y',100,TO_DATE('2013-02-19 15:39:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-19 15:39:06','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 19, 2013 3:39:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208592 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 19, 2013 3:39:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_Process ADD AD_CtxHelp_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 19, 2013 3:39:35 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',118,208593,'D','N','N','N',0,'N',10,'N',19,'N',202212,'N','Y','b60b5df0-e733-4023-a311-f89e27fd89ec','Y','AD_CtxHelp_ID','Context Help','Y',100,TO_DATE('2013-02-19 15:39:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-19 15:39:34','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 19, 2013 3:39:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208593 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 19, 2013 3:39:38 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_Task ADD AD_CtxHelp_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 19, 2013 3:40:03 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',117,208594,'D','N','N','N',0,'N',10,'N',19,'N',202212,'N','Y','aa62f1d9-816d-4be0-bf25-99698395f457','Y','AD_CtxHelp_ID','Context Help','Y',100,TO_DATE('2013-02-19 15:40:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-19 15:40:02','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 19, 2013 3:40:03 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208594 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 19, 2013 3:40:05 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_Workflow ADD AD_CtxHelp_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 19, 2013 3:40:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',302,36,'N','N',60414,'Y',201804,'N','D','AD_Form_UU','N','Y','39eb0dae-821c-46dd-8d67-7a7e6b575adb',100,0,TO_DATE('2013-02-19 15:40:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:40:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:40:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201804 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:40:37 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',302,10,'N','N',208590,'Y',201805,'N','D','Context Help','N','Y','30de6b37-86ab-4582-88ff-4a4a3fe4d34d',100,0,TO_DATE('2013-02-19 15:40:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:40:37','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:40:37 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201805 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:40:43 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201804
;

-- Feb 19, 2013 3:40:43 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=201805
;

-- Feb 19, 2013 3:40:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201804
;

-- Feb 19, 2013 3:40:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=3614
;

-- Feb 19, 2013 3:40:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=3615
;

-- Feb 19, 2013 3:40:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=3617
;

-- Feb 19, 2013 3:40:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=3618
;

-- Feb 19, 2013 3:40:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=3619
;

-- Feb 19, 2013 3:40:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=3616
;

-- Feb 19, 2013 3:40:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=10777
;

-- Feb 19, 2013 3:40:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=5816
;

-- Feb 19, 2013 3:40:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=4541
;

-- Feb 19, 2013 3:40:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=3620
;

-- Feb 19, 2013 3:40:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=10957
;

-- Feb 19, 2013 3:40:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=201805
;

-- Feb 19, 2013 3:42:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET IsIdentifier='Y',Updated=TO_DATE('2013-02-19 15:42:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208549
;

-- Feb 19, 2013 3:43:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',842,36,'N','N',60423,'Y',201806,'N','D','AD_InfoWindow_UU','N','Y','a68183cb-7789-40df-a270-81e631da4793',100,0,TO_DATE('2013-02-19 15:43:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:43:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:43:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201806 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:43:05 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',842,10,'N','N',208591,'Y',201807,'N','D','Context Help','N','Y','93722008-308c-4039-b5da-767d4d048018',100,0,TO_DATE('2013-02-19 15:43:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:43:04','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:43:05 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201807 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:43:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201806
;

-- Feb 19, 2013 3:43:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=201807
;

-- Feb 19, 2013 3:43:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201806
;

-- Feb 19, 2013 3:43:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201634
;

-- Feb 19, 2013 3:43:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=201639
;

-- Feb 19, 2013 3:43:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=201807
;

-- Feb 19, 2013 3:43:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-19 15:43:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201807
;

-- Feb 19, 2013 3:43:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-19 15:43:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201805
;

-- Feb 19, 2013 3:44:35 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',245,36,'N','N',60468,'Y',201808,'N','D','AD_Process_UU','N','Y','837ffbfb-68a2-4f00-b12f-ed5d6fb912e6',100,0,TO_DATE('2013-02-19 15:44:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:44:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:44:35 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201808 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:44:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',245,10,'N','N',208592,'Y',201809,'N','D','Context Help','N','Y','9c1440b7-a400-46e6-ab90-6cda2e7952dc',100,0,TO_DATE('2013-02-19 15:44:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:44:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:44:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201809 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:44:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201808
;

-- Feb 19, 2013 3:44:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=56497
;

-- Feb 19, 2013 3:44:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=3278
;

-- Feb 19, 2013 3:44:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=3219
;

-- Feb 19, 2013 3:44:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=5849
;

-- Feb 19, 2013 3:44:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=50155
;

-- Feb 19, 2013 3:44:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=5850
;

-- Feb 19, 2013 3:44:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=5851
;

-- Feb 19, 2013 3:44:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=50156
;

-- Feb 19, 2013 3:44:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=57342
;

-- Feb 19, 2013 3:44:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=201809
;

-- Feb 19, 2013 3:44:53 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201808
;

-- Feb 19, 2013 3:44:53 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2527
;

-- Feb 19, 2013 3:44:53 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2528
;

-- Feb 19, 2013 3:44:53 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=3116
;

-- Feb 19, 2013 3:44:53 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=2533
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=2530
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=2531
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=2532
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=10562
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=5128
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=4540
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=2571
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=12100
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=3703
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=2534
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=10235
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=56497
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=3278
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=3219
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=5849
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=50155
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=201809
;

-- Feb 19, 2013 3:44:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=57342
;

-- Feb 19, 2013 3:44:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=201809
;

-- Feb 19, 2013 3:44:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=57342
;

-- Feb 19, 2013 3:45:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-19 15:45:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201809
;

-- Feb 19, 2013 3:45:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',106,36,'N','N',60504,'Y',201810,'N','D','AD_Tab_UU','N','Y','f9f47fac-6a1c-48a9-a6d9-910aad0768e1',100,0,TO_DATE('2013-02-19 15:45:46','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:45:46','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:45:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201810 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:45:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',106,10,'N','N',208589,'Y',201811,'N','D','Context Help','N','Y','ea5fe9ba-893b-4960-95fd-ad133f6e1ebc',100,0,TO_DATE('2013-02-19 15:45:47','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:45:47','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:45:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201811 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:45:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',106,22,'N','N',8547,'Y',201812,'N','You can include a Tab in a Tab. If displayed in single row record, the included tab is displayed as multi-row table.','D','Included Tab in this Tab (Master Detail)','Included Tab','N','Y','bd04512e-8d20-4219-bade-0b926ab313ed',100,0,TO_DATE('2013-02-19 15:45:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:45:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:45:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201812 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201810
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201812
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=57266
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=2575
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=11265
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=929
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=11998
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=11266
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=1548
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=1550
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=1549
;

-- Feb 19, 2013 3:46:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=4956
;

-- Feb 19, 2013 3:46:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=201811
;

-- Feb 19, 2013 3:46:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=5131
;

-- Feb 19, 2013 3:46:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=3205
;

-- Feb 19, 2013 3:46:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201810
;

-- Feb 19, 2013 3:46:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=272
;

-- Feb 19, 2013 3:46:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201812
;

-- Feb 19, 2013 3:46:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=1989
;

-- Feb 19, 2013 3:46:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=119
;

-- Feb 19, 2013 3:46:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=120
;

-- Feb 19, 2013 3:46:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=121
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=122
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=271
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=131
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=5824
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=123
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=5326
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=124
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=11997
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=312
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=927
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=5707
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=928
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=5709
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=5708
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=1546
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=57266
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=2575
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=11265
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=929
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=11998
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=11266
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=1548
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=1550
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=1549
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=4956
;

-- Feb 19, 2013 3:46:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=201811
;

-- Feb 19, 2013 3:46:25 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-19 15:46:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201811
;

-- Feb 19, 2013 3:46:55 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',150,36,'N','N',60510,'Y',201813,'N','D','AD_Task_UU','N','Y','290b1fb6-9b17-4034-b620-12797963a336',100,0,TO_DATE('2013-02-19 15:46:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:46:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:46:55 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201813 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:46:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',150,10,'N','N',208593,'Y',201814,'N','D','Context Help','N','Y','2fc653f1-f010-4c65-a554-7dbef582d3d9',100,0,TO_DATE('2013-02-19 15:46:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:46:55','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:46:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201814 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201813
;

-- Feb 19, 2013 3:47:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=201814
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201813
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=397
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=2022
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=398
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=399
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=400
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=401
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=5814
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=5116
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=12105
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=402
;

-- Feb 19, 2013 3:47:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=201814
;

-- Feb 19, 2013 3:47:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-19 15:47:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201814
;

-- Feb 19, 2013 3:47:39 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,36,'N','N',60557,'Y',201815,'N','D','AD_Workflow_UU','N','Y','200add4e-1ad5-4b88-8039-b3450c878aef',100,0,TO_DATE('2013-02-19 15:47:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:38','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:39 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201815 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:40 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,10,'N','N',208594,'Y',201816,'N','D','Context Help','N','Y','1ebc0eac-2ab0-4cc0-a40b-1c96e9bb8a3d',100,0,TO_DATE('2013-02-19 15:47:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:39','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:40 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201816 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,30,'N','N',53318,'Y',201817,'N','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','EE01','Document sequence number of the document','Document No','N','Y','701665c6-c74e-4b9c-b988-da4d16417d41',100,0,TO_DATE('2013-02-19 15:47:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:40','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201817 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,22,'N','N',53316,'Y',201818,'N','EE01','Moving Time','N','Y','db93ca99-ba0d-4e9f-a96c-35e90afe1527',100,0,TO_DATE('2013-02-19 15:47:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:41','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201818 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:42 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,10,'N','N',56783,'Y',201819,'N','When there are two consecutive avtivity, you can sometimes save time by moving partial quantites from one activity to the next before the first activity as been completed.','EE01','Overlap Units are number of units that must be completed before they are moved the next activity','Overlap Units','N','Y','e5f9ed27-65b5-400e-9045-8ab2ebacb894',100,0,TO_DATE('2013-02-19 15:47:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:41','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:42 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201819 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:43 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,2,'N','N',53317,'Y',201820,'N','EE01','Process Type','N','Y','3655e137-474d-410c-9f64-254f8d0a1314',100,0,TO_DATE('2013-02-19 15:47:42','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:42','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:43 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201820 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:44 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,10,'N','N',53319,'Y',201821,'N','EE01','Qty Batch Size','N','Y','8f32acf8-c5da-4b22-bba1-7231542a12a6',100,0,TO_DATE('2013-02-19 15:47:43','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:43','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:44 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201821 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:45 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,22,'N','N',53320,'Y',201822,'N','Queuing time has no implication on costs, but on Capacity Requirement Planning (CRP) to calculate the total time needed to manufacture a product.','EE01','Queue time is the time a job waits at a work center before begin handled.','Queuing Time','N','Y','81afb950-a7dd-4a41-b1be-869faab53749',100,0,TO_DATE('2013-02-19 15:47:44','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:44','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:45 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201822 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,10,'N','N',53314,'Y',201823,'N','EE01','Resource','Resource','N','Y','f344d3a8-cec2-44f6-9436-300714b62b20',100,0,TO_DATE('2013-02-19 15:47:45','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:45','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201823 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,22,'N','N',53315,'Y',201824,'N','Once per operation','EE01','Setup time before starting Production','Setup Time','N','Y','a351c0a0-02b4-4855-9570-36f7ac4d70d0',100,0,TO_DATE('2013-02-19 15:47:46','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:46','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201824 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,10,'N','N',56778,'Y',201825,'N','When Units by Cycles are defined the duration time is the total of time to manufactured the units','EE01','The Units by Cycles are defined for process type  Flow Repetitive Dedicated and  indicated the product to be manufactured on a production line for duration unit.','Units by Cycles','N','Y','394b45a4-aabf-4be2-b75b-cd8d5a88c619',100,0,TO_DATE('2013-02-19 15:47:47','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:47','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201825 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:47:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',148,10,'N','N',56777,'Y',201826,'N','ADempiere Calculate the total yield for a product from the yield for each activity when the process Workflow Cost Roll-Up is executed.

The expected yield for an Activity can be expressed as:

Yield = Acceptable Units at Activity End x 100

The Total manufacturing yield for a product is determined by multiplying the yied percentage for each activity.

Manufacturing Yield = Yield % for Activity 10 x Yied % for Activity 20 , etc 

Take care when setting yield to anything but 100% particularly when yied is used for multiples activities

','EE01','The Yield is the percentage of a lot that is expected to be of acceptable wuality may fall below 100 percent','Yield %','N','Y','dee3895e-3a37-4ffc-8e9f-310a5204c680',100,0,TO_DATE('2013-02-19 15:47:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-19 15:47:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 19, 2013 3:47:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201826 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201815
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201817
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201818
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201819
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201820
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201821
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201822
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201823
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201824
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201825
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201826
;

-- Feb 19, 2013 3:48:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=201816
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201815
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=379
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201817
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201818
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201819
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201820
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201821
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201822
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201823
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201824
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201825
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201826
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=2020
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=10087
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=380
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=381
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=382
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=383
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=56501
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=10899
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=10086
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=10900
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=4539
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=5811
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=8748
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=8743
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=8746
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=8751
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=8895
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=8749
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=8742
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=10084
;

-- Feb 19, 2013 3:48:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=3665
;

-- Feb 19, 2013 3:48:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=9495
;

-- Feb 19, 2013 3:48:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=8752
;

-- Feb 19, 2013 3:48:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=8745
;

-- Feb 19, 2013 3:48:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=8747
;

-- Feb 19, 2013 3:48:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=8750
;

-- Feb 19, 2013 3:48:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=8744
;

-- Feb 19, 2013 3:48:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=8753
;

-- Feb 19, 2013 3:48:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=10085
;

-- Feb 19, 2013 3:48:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=10919
;

-- Feb 19, 2013 3:48:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=201816
;

-- Feb 19, 2013 3:48:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-19 15:48:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201816
;

-- Feb 19, 2013 3:49:19 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=201816
;

-- Feb 19, 2013 3:49:19 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=10085
;

-- Feb 19, 2013 3:49:19 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=10919
;

-- Feb 19, 2013 3:49:22 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=201816
;

-- Feb 19, 2013 3:49:22 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=10085
;

-- Feb 19, 2013 3:49:22 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=10919
;

UPDATE AD_Form t SET AD_CtxHelp_ID = (
	SELECT MAX(h.AD_CtxHelp_ID) 
	FROM AD_CtxHelp h 
	WHERE h.AD_Form_ID = t.AD_Form_ID 
	AND CtxType = 'F') 
WHERE t.AD_Form_ID IN (SELECT h.AD_Form_ID FROM AD_CtxHelp h WHERE CtxType = 'F');

UPDATE AD_InfoWindow t SET AD_CtxHelp_ID = (
	SELECT MAX(h.AD_CtxHelp_ID) 
	FROM AD_CtxHelp h 
	WHERE h.AD_InfoWindow_ID = t.AD_InfoWindow_ID 
	AND CtxType = 'I') 
WHERE t.AD_InfoWindow_ID IN (SELECT h.AD_InfoWindow_ID FROM AD_CtxHelp h WHERE CtxType = 'I');

UPDATE AD_Task t SET AD_CtxHelp_ID = (
	SELECT MAX(h.AD_CtxHelp_ID) 
	FROM AD_CtxHelp h 
	WHERE h.AD_Task_ID = t.AD_Task_ID 
	AND CtxType = 'K') 
WHERE t.AD_Task_ID IN (SELECT h.AD_Task_ID FROM AD_CtxHelp h WHERE CtxType = 'K');

UPDATE AD_Process t SET AD_CtxHelp_ID = (
	SELECT MAX(h.AD_CtxHelp_ID) 
	FROM AD_CtxHelp h 
	WHERE h.AD_Process_ID = t.AD_Process_ID 
	AND CtxType = 'P') 
WHERE t.AD_Process_ID IN (SELECT h.AD_Process_ID FROM AD_CtxHelp h WHERE CtxType = 'P');

UPDATE AD_Tab t SET AD_CtxHelp_ID = (
	SELECT MAX(h.AD_CtxHelp_ID) 
	FROM AD_CtxHelp h 
	WHERE h.AD_Tab_ID = t.AD_Tab_ID 
	AND CtxType = 'T') 
WHERE t.AD_Tab_ID IN (SELECT h.AD_Tab_ID FROM AD_CtxHelp h WHERE CtxType = 'T');

UPDATE AD_Workflow t SET AD_CtxHelp_ID = (
	SELECT MAX(h.AD_CtxHelp_ID) 
	FROM AD_CtxHelp h 
	WHERE h.AD_Workflow_ID = t.AD_Workflow_ID 
	AND CtxType = 'W') 
WHERE t.AD_Workflow_ID IN (SELECT h.AD_Workflow_ID FROM AD_CtxHelp h WHERE CtxType = 'W');

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=201778
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Field WHERE AD_Field_ID=201778
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=201776
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Field WHERE AD_Field_ID=201776
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=201777
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Field WHERE AD_Field_ID=201777
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=201795
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Field WHERE AD_Field_ID=201795
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=201797
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Field WHERE AD_Field_ID=201797
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=201796
;

-- Feb 19, 2013 4:27:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Field WHERE AD_Field_ID=201796
;

-- Feb 19, 2013 4:27:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2013-02-19 16:27:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208545
;

-- Feb 19, 2013 4:27:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_CtxHelp MODIFY CtxType CHAR(1) DEFAULT NULL 
;

-- Feb 19, 2013 4:27:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_CtxHelp MODIFY CtxType NULL
;

-- Feb 19, 2013 4:28:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208548
;

-- Feb 19, 2013 4:28:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208548
;

-- Feb 19, 2013 4:28:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208580
;

-- Feb 19, 2013 4:28:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208580
;

-- Feb 19, 2013 4:28:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208547
;

-- Feb 19, 2013 4:28:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208547
;

-- Feb 19, 2013 4:28:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208546
;

-- Feb 19, 2013 4:28:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208546
;

-- Feb 19, 2013 4:28:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208582
;

-- Feb 19, 2013 4:28:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208582
;

-- Feb 19, 2013 4:28:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208581
;

-- Feb 19, 2013 4:28:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208581
;

-- Feb 19, 2013 4:32:52 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_Form.AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType = ''F'')',200026,'D','AD_Form AD_CtxHelp_ID','S','b26f089c-3f8c-4931-82c1-021002cef62c',100,100,TO_DATE('2013-02-19 16:32:50','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-19 16:32:50','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Feb 19, 2013 4:33:19 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET AD_Val_Rule_ID=200026,Updated=TO_DATE('2013-02-19 16:33:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208590
;

-- Feb 19, 2013 4:35:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Val_Rule SET Code='AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType = ''F'')',Updated=TO_DATE('2013-02-19 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200026
;

-- Feb 19, 2013 4:36:57 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType = ''I'')',200027,'D','AD_InfoWindow AD_CtxHelp_ID','S','1776cd68-7b0d-4511-86cb-694ef25f63f3',100,100,TO_DATE('2013-02-19 16:36:56','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-19 16:36:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Feb 19, 2013 4:37:17 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType = ''K'')',200028,'D','AD_Task AD_CtxHelp_ID','S','828e4abe-f56a-4cee-a67b-d550b64099bd',100,100,TO_DATE('2013-02-19 16:37:16','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-19 16:37:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Feb 19, 2013 4:37:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType = ''P'')',200029,'U','AD_Process AD_CtxHelp_ID','S','20231ee9-5605-427a-a5c1-7acc46249ca0',100,100,TO_DATE('2013-02-19 16:37:33','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-19 16:37:33','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Feb 19, 2013 4:37:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType = ''T'')',200030,'U','AD_Tab AD_CtxHelp_ID','S','cb1ba6d7-b52e-4d21-8402-8c7e91ba70b5',100,100,TO_DATE('2013-02-19 16:37:53','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-19 16:37:53','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Feb 19, 2013 4:37:57 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Val_Rule SET EntityType='D',Updated=TO_DATE('2013-02-19 16:37:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200030
;

-- Feb 19, 2013 4:38:03 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Val_Rule SET EntityType='D',Updated=TO_DATE('2013-02-19 16:38:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200029
;

-- Feb 19, 2013 4:38:30 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType = ''W'')',200031,'D','AD_Workflow AD_CtxHelp_ID','S','a2c2de97-7236-43c7-9d48-ff31d0b491fd',100,100,TO_DATE('2013-02-19 16:38:29','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-19 16:38:29','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Feb 19, 2013 4:39:22 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET AD_Val_Rule_ID=200027,Updated=TO_DATE('2013-02-19 16:39:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208591
;

-- Feb 19, 2013 4:39:44 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET AD_Val_Rule_ID=200028,Updated=TO_DATE('2013-02-19 16:39:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208593
;

-- Feb 19, 2013 4:40:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET AD_Val_Rule_ID=200029,Updated=TO_DATE('2013-02-19 16:40:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208592
;

-- Feb 19, 2013 4:40:24 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET AD_Val_Rule_ID=200031,Updated=TO_DATE('2013-02-19 16:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208594
;

-- Feb 19, 2013 4:40:45 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET AD_Val_Rule_ID=200030,Updated=TO_DATE('2013-02-19 16:40:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208589
;

-- Feb 19, 2013 6:29:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=201784
;

-- Feb 19, 2013 6:29:02 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Field WHERE AD_Field_ID=201784
;

-- Feb 19, 2013 6:29:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2013-02-19 18:29:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208565
;

-- Feb 19, 2013 6:29:18 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET IsIdentifier='N',Updated=TO_DATE('2013-02-19 18:29:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208565
;

-- Feb 19, 2013 6:29:21 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_CtxHelpMsg MODIFY Line NUMBER(10) DEFAULT NULL 
;

-- Feb 19, 2013 6:29:22 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_CtxHelpMsg MODIFY Line NULL
;

-- Feb 19, 2013 6:31:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208565
;

-- Feb 19, 2013 6:31:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208565
;

-- Feb 19, 2013 6:39:05 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2013-02-19 18:39:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201786
;

SELECT register_migration_script('201302191851_TICKET-1002211.sql') FROM dual
;
