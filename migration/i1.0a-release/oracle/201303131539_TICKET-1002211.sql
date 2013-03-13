-- Mar 13, 2013 2:23:27 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID) VALUES (0,200135,200064,'D','All','298064ff-6e69-435f-aa0e-d156375339f5','A',100,TO_DATE('2013-03-13 14:23:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-13 14:23:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Mar 13, 2013 2:23:27 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200135 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Mar 13, 2013 2:26:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Val_Rule SET Code='AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType IN (''A'', ''F''))',Updated=TO_DATE('2013-03-13 14:26:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200026
;

-- Mar 13, 2013 2:26:55 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Val_Rule SET Code='AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType IN (''A'', ''I''))',Updated=TO_DATE('2013-03-13 14:26:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200027
;

-- Mar 13, 2013 2:27:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Val_Rule SET Code='AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType IN (''A'', ''P''))',Updated=TO_DATE('2013-03-13 14:27:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200029
;

-- Mar 13, 2013 2:27:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Val_Rule SET Code='AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType IN (''A'', ''T''))',Updated=TO_DATE('2013-03-13 14:27:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200030
;

-- Mar 13, 2013 2:27:57 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Val_Rule SET Code='AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType IN (''A'', ''K''))',Updated=TO_DATE('2013-03-13 14:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200028
;

-- Mar 13, 2013 2:28:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Val_Rule SET Code='AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType IN (''A'', ''W''))',Updated=TO_DATE('2013-03-13 14:28:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200031
;

-- Mar 13, 2013 2:35:25 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID) VALUES (0,200136,200064,'D','Node','daeadda1-f591-4efe-92dc-9693b5fe2826','N',100,TO_DATE('2013-03-13 14:35:24','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-13 14:35:24','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Mar 13, 2013 2:35:25 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200136 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Mar 13, 2013 2:36:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_CtxHelp_ID IN (SELECT AD_CtxHelp_ID FROM AD_CtxHelp WHERE CtxType IS NULL OR CtxType IN (''A'', ''N''))',200032,'D','AD_WF_Node AD_CtxHelp_ID','S','20be4227-685b-4815-b24b-e0b318dfc4f1',100,100,TO_DATE('2013-03-13 14:36:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-13 14:36:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Mar 13, 2013 2:36:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',129,208804,'D','N','N','N',0,'N',10,'N',19,200032,'N',202212,'N','Y','898b367b-8f37-4e3a-8d36-ee099bf08bd0','Y','AD_CtxHelp_ID','Context Help','Y',100,TO_DATE('2013-03-13 14:36:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-13 14:36:30','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 13, 2013 2:36:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208804 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 13, 2013 2:36:37 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_WF_Node ADD AD_CtxHelp_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 13, 2013 2:37:32 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',122,36,'N','N',60544,'Y',201873,'N','D','AD_WF_Node_UU','N','Y','b0e1cb0c-63cd-45a9-ada5-6f8e2fdb60cf',100,0,TO_DATE('2013-03-13 14:37:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-13 14:37:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 13, 2013 2:37:32 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201873 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 13, 2013 2:37:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',122,10,'N','N',53309,'Y',201874,'N','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','EE01','Identifies a Business Partner','Business Partner ','N','Y','e5670d17-46a4-4802-aca1-45dfe2885cdd',100,0,TO_DATE('2013-03-13 14:37:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-13 14:37:32','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 13, 2013 2:37:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201874 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 13, 2013 2:37:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',122,10,'N','N',208804,'Y',201875,'N','D','Context Help','N','Y','7e1434c3-7b19-485c-8bee-c29c5ed60d7e',100,0,TO_DATE('2013-03-13 14:37:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-13 14:37:33','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 13, 2013 2:37:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201875 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 13, 2013 2:37:35 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',122,1,'N','N',53304,'Y',201876,'N','EE01','Is Milestone','N','Y','584a97de-bea2-472d-8a8c-f48b682b46ec',100,0,TO_DATE('2013-03-13 14:37:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-13 14:37:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 13, 2013 2:37:35 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201876 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 13, 2013 2:37:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',122,1,'N','N',53305,'Y',201877,'N','EE01','Is Subcontracting','N','Y','7888f993-bb3d-401d-a17f-1d0a764cd88b',100,0,TO_DATE('2013-03-13 14:37:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-13 14:37:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 13, 2013 2:37:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201877 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 13, 2013 2:38:01 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',122,22,'N','N',53308,'Y',201878,'N','When there are two consecutive avtivity, you can sometimes save time by moving partial quantites from one activity to the next before the first activity as been completed.','EE01','Overlap Units are number of units that must be completed before they are moved the next activity','Overlap Units','N','Y','5fce61e0-a726-4a71-8b90-623562be95c0',100,0,TO_DATE('2013-03-13 14:38:00','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-13 14:38:00','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 13, 2013 2:38:02 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201878 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 13, 2013 2:38:24 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',122,10,'N','N',53311,'Y',201879,'N','EE01','Resource','Resource','N','Y','00db24ee-8b3f-4273-97da-3ddf5b35e42a',100,0,TO_DATE('2013-03-13 14:38:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-13 14:38:23','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 13, 2013 2:38:24 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201879 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 13, 2013 2:38:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',122,14,'N','N',53306,'Y',201880,'N','When Units by Cycles are defined the duration time is the total of time to manufactured the units','EE01','The Units by Cycles are defined for process type  Flow Repetitive Dedicated and  indicated the product to be manufactured on a production line for duration unit.','Units by Cycles','N','Y','3c87ab24-cedb-4d1c-a2ec-3ffa1358c665',100,0,TO_DATE('2013-03-13 14:38:45','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-13 14:38:45','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 13, 2013 2:38:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201880 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 13, 2013 2:38:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',122,7,'N','N',53313,'Y',201881,'N','The Valid From date indicates the first day of a date range','EE01','Valid from including this date (first day)','Valid from','N','Y','a5fe43f4-db98-4085-a723-f7f0a9403afb',100,0,TO_DATE('2013-03-13 14:38:46','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-13 14:38:46','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 13, 2013 2:38:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201881 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 13, 2013 2:39:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',122,10,'N','N',56776,'Y',201882,'N','ADempiere Calculate the total yield for a product from the yield for each activity when the process Workflow Cost Roll-Up is executed.

The expected yield for an Activity can be expressed as:

Yield = Acceptable Units at Activity End x 100

The Total manufacturing yield for a product is determined by multiplying the yied percentage for each activity.

Manufacturing Yield = Yield % for Activity 10 x Yied % for Activity 20 , etc 

Take care when setting yield to anything but 100% particularly when yied is used for multiples activities

','EE01','The Yield is the percentage of a lot that is expected to be of acceptable wuality may fall below 100 percent','Yield %','N','Y','96f97be9-7de8-4311-969d-0d68acc5faf7',100,0,TO_DATE('2013-03-13 14:39:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-13 14:39:08','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 13, 2013 2:39:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201882 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201873
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201874
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201876
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201877
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201878
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201879
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201880
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201881
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201882
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=8761
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=1269
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=1268
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=8766
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=2578
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=8771
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=10180
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=10089
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=10920
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=10921
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=8765
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=8767
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=8769
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=8768
;

-- Mar 13, 2013 2:39:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=201875
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201873
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201874
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=385
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201876
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201877
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201878
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201879
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201880
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201881
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201882
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=2005
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=386
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=10195
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=387
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=388
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=389
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=390
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=4572
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=5821
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=8764
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=8772
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=8763
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=8773
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=8882
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=8883
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=1263
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=8881
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=1264
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=3666
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=10088
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=10091
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=10090
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=12615
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=12614
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=12616
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=8761
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=1269
;

-- Mar 13, 2013 2:40:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=1268
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=8766
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=2578
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=8771
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=10180
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=10089
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=10920
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=10921
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=8765
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=8767
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=8769
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=8768
;

-- Mar 13, 2013 2:40:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y' WHERE AD_Field_ID=201875
;

-- Mar 13, 2013 2:40:37 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-03-13 14:40:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201875
;

SELECT register_migration_script('201303131539_TICKET-1002211.sql') FROM dual
;