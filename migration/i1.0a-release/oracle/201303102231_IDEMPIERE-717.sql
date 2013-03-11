-- Mar 10, 2013 10:22:13 PM COT
-- IDEMPIERE-717 On "Field Group" window add a tab "Used in Field"
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,AD_Column_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,OrderByClause,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N','N','N',200,30,'N','N',107,'N','N','Y',5375,'N','N',1,'ca67b2fa-1cd1-46f7-9996-4f92fcf9f6dc','D','Used in Field','AD_Tab_ID, SeqNo',200079,0,0,TO_DATE('2013-03-10 22:22:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-10 22:22:11','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Mar 10, 2013 10:22:13 PM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200079 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Mar 10, 2013 10:27:19 PM COT
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',200079,10,'N','N',172,10,'Y',201869,'N','The Tab indicates a tab that displays within a window.','D','Tab within a Window','Tab','deaa330a-1463-4796-912c-b88479e35abf','Y','N',100,0,TO_DATE('2013-03-10 22:27:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-10 22:27:16','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N')
;

-- Mar 10, 2013 10:27:19 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201869 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 10, 2013 10:27:21 PM COT
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Reference_ID,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',200079,10,'N','N',167,20,'Y',201870,'N','The Field identifies a field on a database table.',19,'D','Field on a database table','Field','a58e9e9b-1bb7-43c2-a5bf-6548f86bf5ff','Y','N',100,0,TO_DATE('2013-03-10 22:27:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-10 22:27:19','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,'N')
;

-- Mar 10, 2013 10:27:21 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201870 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 10, 2013 10:27:24 PM COT
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',200079,10,'Y','N',168,30,'Y',201871,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','1608fc91-e62d-4f6a-9498-cf088267dd6f','Y','N',100,0,TO_DATE('2013-03-10 22:27:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-10 22:27:21','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,4,'N')
;

-- Mar 10, 2013 10:27:24 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201871 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

SELECT register_migration_script('201303102231_IDEMPIERE-717.sql') FROM dual
;

