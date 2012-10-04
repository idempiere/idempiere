-- Oct 4, 2012 1:29:34 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Process (AD_Client_ID,AD_Org_ID,AD_Process_ID,AccessLevel,Classname,CopyFromProcess,Created,CreatedBy,Description,EntityType,IsActive,IsBetaFunctionality,IsDirectPrint,IsReport,IsServerProcess,Name,ShowHelp,Statistic_Count,Statistic_Seconds,Updated,UpdatedBy,Value) VALUES (0,0,200012,'1','org.compiere.process.CopyFromBankStmt','N',TO_DATE('2012-10-04 13:29:33','YYYY-MM-DD HH24:MI:SS'),100,'Copy Lines from other bank statement','D','Y','N','N','N','N','Copy Lines','Y',0,0,TO_DATE('2012-10-04 13:29:33','YYYY-MM-DD HH24:MI:SS'),100,'C_BankStatement CopyFrom')
;

-- Oct 4, 2012 1:29:35 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200012 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Oct 4, 2012 1:30:09 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Val_Rule (AD_Client_ID,AD_Org_ID,AD_Val_Rule_ID,Code,Created,CreatedBy,EntityType,IsActive,Name,Type,Updated,UpdatedBy) VALUES (0,0,200008,'C_BankStatement.C_BankAccount_ID=@C_BankAccount_ID@',TO_DATE('2012-10-04 13:30:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','BankStatement of BankAccount','S',TO_DATE('2012-10-04 13:30:09','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 4, 2012 1:30:16 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Process_Para (AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,AD_Val_Rule_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsCentrallyMaintained,IsEncrypted,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1381,0,200012,200043,30,200008,'C_BankStatement_ID',TO_DATE('2012-10-04 13:30:16','YYYY-MM-DD HH24:MI:SS'),100,'Bank Statement of account','D',0,'The Bank Statement identifies a unique Bank Statement for a defined time period.  The statement defines all transactions that occurred','Y','Y','N','Y','N','Bank Statement',10,TO_DATE('2012-10-04 13:30:16','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 4, 2012 1:30:17 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200043 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Oct 4, 2012 1:30:34 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200585,2037,0,200012,28,392,'CopyFrom',TO_DATE('2012-10-04 13:30:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Copy From Record','D',1,'Copy From Record','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Copy From',0,TO_DATE('2012-10-04 13:30:33','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 4, 2012 1:30:34 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200585 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 4, 2012 1:30:36 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
ALTER TABLE C_BankStatement ADD CopyFrom CHAR(1) DEFAULT 'N'
;

-- Oct 4, 2012 1:30:48 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200585,200599,0,328,TO_DATE('2012-10-04 13:30:48','YYYY-MM-DD HH24:MI:SS'),100,'Copy From Record',1,'D','Copy From Record','Y','Y','Y','N','N','N','N','N','Copy From',TO_DATE('2012-10-04 13:30:48','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 4, 2012 1:30:48 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200599 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 4, 2012 1:30:49 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,59035,200600,0,328,TO_DATE('2012-10-04 13:30:49','YYYY-MM-DD HH24:MI:SS'),100,'The date+time (expressed in decimal format) when the document has been processed',20,'D','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.','Y','Y','Y','N','N','N','N','N','Processed On',TO_DATE('2012-10-04 13:30:49','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 4, 2012 1:30:49 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200600 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 4, 2012 1:31:05 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200600
;

-- Oct 4, 2012 1:31:05 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200599
;

-- Oct 4, 2012 1:31:05 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=8686
;

-- Oct 4, 2012 1:31:05 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=8687
;

-- Oct 4, 2012 1:31:05 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=10585
;

-- Oct 4, 2012 1:31:05 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=10586
;

-- Oct 4, 2012 1:31:05 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=10587
;

-- Oct 4, 2012 1:31:05 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=3999
;

-- Oct 4, 2012 1:31:11 PM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-10-04 13:31:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200599
;

SELECT register_migration_script('201212120818_IDEMPIERE-448.sql') FROM dual
;