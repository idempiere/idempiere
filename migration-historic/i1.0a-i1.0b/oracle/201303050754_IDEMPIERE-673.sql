-- Mar 5, 2013 3:26:10 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ListSourcesXTrx',202293,'List the Source Accounts with or without transactions for Summary Accounts selected','D','Include source accounts with no transaction','Include source accounts with no transaction for list report line sources','Include source accounts with no transaction','56a944c7-abf2-4c6d-b0a6-895a01f26115',0,TO_DATE('2013-03-05 15:26:08','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-05 15:26:08','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 5, 2013 3:26:10 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202293 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 5, 2013 3:28:04 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',1,445,208800,'D','N','N','N',0,'N',1,'N',20,'N',202293,'N','Y','177eb65e-2d11-4571-a3fe-a28200cd224a','Y','ListSourcesXTrx','Include source accounts with no transaction for list report line sources','N','List the Source Accounts with or without transactions for Summary Accounts selected','Include source accounts with no transaction','Y',TO_DATE('2013-03-05 15:28:03','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-03-05 15:28:03','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 5, 2013 3:28:04 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208800 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 5, 2013 3:33:36 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',372,0,'N','N',208800,160,'Y',201867,'N','List the Source Accounts with or without transactions for Summary Accounts selected','@ListSources@=Y','D','Include source accounts with no transaction for list report line sources','Include source accounts with no transaction','Y','N','d97b8185-fbea-4227-ad2a-2811e2c9db53',100,0,TO_DATE('2013-03-05 15:33:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-03-05 15:33:35','YYYY-MM-DD HH24:MI:SS'),'Y','Y',160,1,'N')
;

-- Mar 5, 2013 3:33:36 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201867 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 5, 2013 3:35:24 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2013-03-05 15:35:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57034
;

-- Mar 5, 2013 3:35:24 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2013-03-05 15:35:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54234
;

-- Mar 5, 2013 3:35:24 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
UPDATE AD_Field SET SeqNo=120, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-03-05 15:35:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6268
;

-- Mar 5, 2013 3:35:24 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
UPDATE AD_Field SET SeqNo=130, IsDisplayed='Y', XPosition=5,Updated=TO_DATE('2013-03-05 15:35:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6267
;

-- Mar 5, 2013 3:35:24 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
UPDATE AD_Field SET ColumnSpan=3, SeqNo=140, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-03-05 15:35:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201867
;

-- Mar 5, 2013 3:35:24 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2013-03-05 15:35:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4737
;

-- Mar 5, 2013 3:35:24 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2013-03-05 15:35:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6265
;

-- Mar 5, 2013 3:35:24 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
UPDATE AD_Field SET SeqNo=170,Updated=TO_DATE('2013-03-05 15:35:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54235
;

-- Mar 5, 2013 3:35:42 PM MYT
-- IDEMPIERE-673 Financial Report: Option to include source with no transaction.
ALTER TABLE PA_Report ADD ListSourcesXTrx CHAR(1) DEFAULT 'N' CHECK (ListSourcesXTrx IN ('Y','N'))
;

SELECT register_migration_script('201303050754_IDEMPIERE-673.sql') FROM dual
;

