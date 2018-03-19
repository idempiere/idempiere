-- Mar 15, 2012 3:07:53 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,Name,IsTranslationTab,Processing,IsSortTab,AD_Table_ID,AD_Tab_ID,ImportFields,HasTree,IsInfoTab,IsReadOnly,TabLevel,IsInsertRecord,IsAdvancedTab,EntityType,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,IsActive,UpdatedBy) VALUES ('N',112,20,'Sequence No','N','N','N',122,200001,'N','N','N','N',1,'Y','N','U',0,0,TO_DATE('2012-03-15 15:07:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-03-15 15:07:49','YYYY-MM-DD HH24:MI:SS'),'Y',100)
;

-- Mar 15, 2012 3:07:53 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Name,Help,CommitWarning,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Tab_ID, t.Name,t.Help,t.CommitWarning,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200001 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Mar 15, 2012 3:08:12 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',1,'Y','N','N',646,'N','Y',200001,200042,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','U','The record is active in the system','Active',100,0,'Y',TO_DATE('2012-03-15 15:08:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-15 15:08:10','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 15, 2012 3:08:12 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200042 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 15, 2012 3:08:14 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',22,'Y','N','N',748,'N','Y',200001,200043,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','U','Client/Tenant for this installation.','Client',100,0,'Y',TO_DATE('2012-03-15 15:08:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-15 15:08:12','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 15, 2012 3:08:14 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200043 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 15, 2012 3:08:17 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',22,'Y','N','N',263,'N','Y',200001,200044,'N','The Current Next indicates the next number to use for this document','U','The next number to be used','Current Next',100,0,'Y',TO_DATE('2012-03-15 15:08:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-15 15:08:14','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 15, 2012 3:08:17 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200044 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 15, 2012 3:08:19 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',22,'Y','N','N',749,'N','Y',200001,200045,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','U','Organizational entity within client','Organization',100,0,'Y',TO_DATE('2012-03-15 15:08:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-15 15:08:17','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 15, 2012 3:08:19 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200045 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 15, 2012 3:08:22 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',22,'Y','N','N',1197,'N','Y',200001,200046,'N','The Sequence defines the numbering sequence to be used for documents.','U','Document Sequence','Sequence',100,0,'Y',TO_DATE('2012-03-15 15:08:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-15 15:08:19','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 15, 2012 3:08:22 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200046 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 15, 2012 3:08:24 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',4,'Y','N','N',262,'N','Y',200001,200047,'N','The Year identifies the Calendar year','U','Calendar Year','Year',100,0,'Y',TO_DATE('2012-03-15 15:08:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-15 15:08:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 15, 2012 3:08:24 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200047 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 15, 2012 3:08:39 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200043
;

-- Mar 15, 2012 3:08:39 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200045
;

-- Mar 15, 2012 3:08:39 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200046
;

-- Mar 15, 2012 3:08:39 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200042
;

-- Mar 15, 2012 3:08:39 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200047
;

-- Mar 15, 2012 3:08:39 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200044
;

-- Mar 15, 2012 3:09:05 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET IsReadOnly='Y', DefaultValue='@AD_Client_ID@',Updated=TO_DATE('2012-03-15 15:09:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200043
;

-- Mar 15, 2012 3:09:29 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-03-15 15:09:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200045
;

-- Mar 15, 2012 3:09:43 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-03-15 15:09:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200044
;

-- Mar 15, 2012 3:09:48 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-03-15 15:09:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200042
;

-- Mar 15, 2012 3:39:49 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Tab SET DisplayLogic='@StartNewYear@=''Y''',Updated=TO_DATE('2012-03-15 15:39:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200001
;

-- Mar 15, 2012 3:40:08 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET DefaultValue='@AD_Org_ID@',Updated=TO_DATE('2012-03-15 15:40:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200045
;

-- Mar 15, 2012 3:41:45 PM WIT
-- IDEMPIERE-151 - Create tab to maintain yearly sequences
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-03-15 15:41:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200045
;

UPDATE AD_System
  SET LastMigrationScriptApplied='827_IDEMPIERE-151.sql'
WHERE LastMigrationScriptApplied<'827_IDEMPIERE-151.sql'
   OR LastMigrationScriptApplied IS NULL
;
