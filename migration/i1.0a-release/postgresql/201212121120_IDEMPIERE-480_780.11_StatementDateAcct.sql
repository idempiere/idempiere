-- 22/07/2011 5:13:40 PM
-- --
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,61939,263,0,15,392,'DateAcct',TO_TIMESTAMP('2011-07-22 17:13:37','YYYY-MM-DD HH24:MI:SS'),100,'Accounting Date','D',7,'The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.','Y','Y','N','N','N','N','N','Y','N','N','N','N','Y','Account Date',0,TO_TIMESTAMP('2011-07-22 17:13:37','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- 22/07/2011 5:13:40 PM
-- --
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=61939 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 22/07/2011 5:13:47 PM
-- --
ALTER TABLE C_BankStatement ADD COLUMN DateAcct TIMESTAMP
;

update c_bankstatement set dateacct=statementdate;

-- 22/07/2011 5:32:05 PM
-- --
INSERT INTO t_alter_column values('c_bankstatement','DateAcct','TIMESTAMP',null,null)
;

-- 22/07/2011 5:32:05 PM
-- --
INSERT INTO t_alter_column values('c_bankstatement','DateAcct',null,'NOT NULL',null)
;


-- 22/07/2011 5:14:50 PM
-- --
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,61939,61967,0,328,TO_TIMESTAMP('2011-07-22 17:14:49','YYYY-MM-DD HH24:MI:SS'),100,'Accounting Date',7,'D','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.','Y','Y','Y','N','N','N','N','N','Account Date',TO_TIMESTAMP('2011-07-22 17:14:49','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 22/07/2011 5:14:50 PM
-- --
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=61967 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 22/07/2011 5:14:52 PM
-- --
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,59035,61968,0,328,TO_TIMESTAMP('2011-07-22 17:14:50','YYYY-MM-DD HH24:MI:SS'),100,'The date+time (expressed in decimal format) when the document has been processed',20,'D','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.','Y','Y','Y','N','N','N','N','N','Processed On',TO_TIMESTAMP('2011-07-22 17:14:50','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 22/07/2011 5:14:52 PM
-- --
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=61968 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 22/07/2011 5:15:05 PM
-- --
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=61968
;

-- 22/07/2011 5:15:05 PM
-- --
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=61967
;

-- 22/07/2011 5:15:05 PM
-- --
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=3996
;

-- 22/07/2011 5:15:05 PM
-- --
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=3998
;

-- 22/07/2011 5:15:05 PM
-- --
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=4119
;

-- 22/07/2011 5:15:05 PM
-- --
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=3993
;

-- 22/07/2011 5:15:05 PM
-- --
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=4365
;

-- 22/07/2011 5:15:05 PM
-- --
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=4003
;

-- 22/07/2011 5:15:06 PM
-- --
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=8933
;

-- 22/07/2011 5:15:06 PM
-- --
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=3997
;

-- 22/07/2011 5:15:06 PM
-- --
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=8686
;

-- 22/07/2011 5:15:06 PM
-- --
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=8687
;

-- 22/07/2011 5:15:06 PM
-- --
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=10585
;

-- 22/07/2011 5:15:06 PM
-- --
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=10586
;

-- 22/07/2011 5:15:06 PM
-- --
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=10587
;

-- 22/07/2011 5:15:06 PM
-- --
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=3999
;

-- 22/07/2011 5:15:20 PM
-- --
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2011-07-22 17:15:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=61967
;

-- 26/07/2011 3:12:34 PM
-- --
UPDATE AD_Column SET Callout='org.compiere.model.CalloutEngine.dateAcct',Updated=TO_TIMESTAMP('2011-07-26 15:12:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4918
;

-- Dec 12, 2012 11:39:16 AM COT
-- IDEMPIERE-480 Huge bug with FactAcctReset and Automatic Accounting
UPDATE AD_Field SET ColumnSpan=2, SeqNo=60, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2012-12-12 11:39:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=61967
;

-- Dec 12, 2012 11:39:16 AM COT
-- IDEMPIERE-480 Huge bug with FactAcctReset and Automatic Accounting
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2012-12-12 11:39:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3997
;

-- Dec 12, 2012 11:39:16 AM COT
-- IDEMPIERE-480 Huge bug with FactAcctReset and Automatic Accounting
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2012-12-12 11:39:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8686
;

-- Dec 12, 2012 11:39:16 AM COT
-- IDEMPIERE-480 Huge bug with FactAcctReset and Automatic Accounting
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2012-12-12 11:39:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8687
;

-- Dec 12, 2012 11:39:16 AM COT
-- IDEMPIERE-480 Huge bug with FactAcctReset and Automatic Accounting
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2012-12-12 11:39:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10585
;

-- Dec 12, 2012 11:39:17 AM COT
-- IDEMPIERE-480 Huge bug with FactAcctReset and Automatic Accounting
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2012-12-12 11:39:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10586
;

-- Dec 12, 2012 11:39:17 AM COT
-- IDEMPIERE-480 Huge bug with FactAcctReset and Automatic Accounting
UPDATE AD_Field SET SeqNo=200, IsDisplayed='Y', XPosition=5,Updated=TO_TIMESTAMP('2012-12-12 11:39:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10587
;

-- Dec 12, 2012 11:39:17 AM COT
-- IDEMPIERE-480 Huge bug with FactAcctReset and Automatic Accounting
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2012-12-12 11:39:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3999
;

-- Dec 12, 2012 11:41:08 AM COT
-- IDEMPIERE-480 Huge bug with FactAcctReset and Automatic Accounting
UPDATE AD_Column SET DefaultValue='@DateAcct@',Updated=TO_TIMESTAMP('2012-12-12 11:41:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5216
;

-- Dec 12, 2012 11:41:34 AM COT
-- IDEMPIERE-480 Huge bug with FactAcctReset and Automatic Accounting
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2012-12-12 11:41:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4121
;

SELECT register_migration_script('201212121120_IDEMPIERE-480_780.11_StatementDateAcct.sql') FROM dual
;

