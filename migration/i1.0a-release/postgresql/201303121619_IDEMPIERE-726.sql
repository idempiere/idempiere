-- Mar 12, 2013 11:23:29 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsInverseDebitCreditOnly',202295,'D','Inverse Operation for Debit/Credit Only Column','Apply inverse operation to debit or credit only column','Inverse Operation for Debit/Credit Only Column','582bb9ba-18fe-44d5-a1c7-35c4b0abc922',0,TO_TIMESTAMP('2013-03-12 23:23:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-12 23:23:27','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 12, 2013 11:23:29 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202295 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 12, 2013 11:24:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',1,448,208803,'U','Y','N','N',0,'N',1,'N',20,'N',202295,'N','Y','e70f17d5-2b1e-4062-b1ce-72c931a403cb','Y','IsInverseDebitCreditOnly','Apply inverse operation to debit or credit only column','N','Inverse Operation for Debit/Credit Only Column','Y',TO_TIMESTAMP('2013-03-12 23:24:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-03-12 23:24:04','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 12, 2013 11:24:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208803 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 12, 2013 11:24:15 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
ALTER TABLE PA_ReportLine ADD COLUMN IsInverseDebitCreditOnly CHAR(1) DEFAULT 'N' CHECK (IsInverseDebitCreditOnly IN ('Y','N')) NOT NULL
;

-- Mar 12, 2013 11:25:42 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (3,1,0,'N',376,0,'N','N',208803,195,'Y',201872,'N','D','Apply inverse operation to debit or credit only column','Inverse Operation for Debit/Credit Only Column','Y','N','0b1330b3-1101-46be-8473-4ad3a26c8d1d',100,0,TO_TIMESTAMP('2013-03-12 23:25:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-12 23:25:41','YYYY-MM-DD HH24:MI:SS'),'Y','Y',195,1,'N')
;

-- Mar 12, 2013 11:25:42 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201872 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 12, 2013 11:31:52 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET DisplayLogic='@LineType@=C&@CalculationType@=A,R,S',Updated=TO_TIMESTAMP('2013-03-12 23:31:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201872
;

-- Mar 12, 2013 11:33:05 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=10,Updated=TO_TIMESTAMP('2013-03-12 23:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4786
;

-- Mar 12, 2013 11:33:05 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=20,Updated=TO_TIMESTAMP('2013-03-12 23:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4787
;

-- Mar 12, 2013 11:33:05 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=30,Updated=TO_TIMESTAMP('2013-03-12 23:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4789
;

-- Mar 12, 2013 11:33:05 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2013-03-12 23:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4790
;

-- Mar 12, 2013 11:33:05 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2013-03-12 23:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4792
;

-- Mar 12, 2013 11:33:05 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2013-03-12 23:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4788
;

-- Mar 12, 2013 11:33:05 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2013-03-12 23:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4793
;

-- Mar 12, 2013 11:33:05 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2013-03-12 23:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4791
;

-- Mar 12, 2013 11:33:05 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2013-03-12 23:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4796
;

-- Mar 12, 2013 11:33:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2013-03-12 23:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4797
;

-- Mar 12, 2013 11:33:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2013-03-12 23:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4798
;

-- Mar 12, 2013 11:33:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2013-03-12 23:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4799
;

-- Mar 12, 2013 11:33:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=130, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-03-12 23:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201872
;

-- Mar 12, 2013 11:33:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2013-03-12 23:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4800
;

-- Mar 12, 2013 11:33:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2013-03-12 23:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4801
;

-- Mar 12, 2013 11:33:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2013-03-12 23:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58043
;

-- Mar 12, 2013 11:33:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2013-03-12 23:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58044
;

-- Mar 12, 2013 11:33:06 PM MYT
-- IDEMPIERE-726 Financial Report: Add inverse operation option for credit/debit only column
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2013-03-12 23:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4785
;

SELECT register_migration_script('201303121619_IDEMPIERE-726.sql') FROM dual
;

