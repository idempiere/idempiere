-- Mar 5, 2013 4:17:05 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Oper_2_LineName',202294,'When specify this identified the name of the financial report line to take values from for column Oper_2_ID. No validation at entry time, value will be zero if the name doesn''t match any line.','D','Operand 2 Line Name','Name of the financial report line to take values from','Operand 2 Line Name','0943530f-41bf-450a-b261-c2b4c81e686e',0,TO_TIMESTAMP('2013-03-05 16:17:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-05 16:17:01','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 5, 2013 4:17:05 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202294 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 5, 2013 4:19:48 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',1,446,208801,'D','N','N','N',0,'N',2000,'N',10,'N',202294,'N','Y','1102e981-efc0-4412-9511-d34a1f3d6c41','Y','Oper_2_LineName','Name of the financial report line to take values from','When specify this identified the name of the financial report line to take values from for column Oper_2_ID. No validation at entry time, value will be zero if the name doesn''t match any line.','Operand 2 Line Name','Y',TO_TIMESTAMP('2013-03-05 16:19:47','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-03-05 16:19:47','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 5, 2013 4:19:48 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208801 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 5, 2013 4:20:42 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Column SET FieldLength=512,Updated=TO_TIMESTAMP('2013-03-05 16:20:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208801
;

-- Mar 5, 2013 4:20:47 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
ALTER TABLE PA_ReportColumn ADD COLUMN Oper_2_LineName VARCHAR(512) DEFAULT NULL 
;

-- Mar 5, 2013 4:21:21 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
INSERT INTO AD_Preference (AD_Preference_ID,AD_Window_ID,Attribute,AD_Preference_UU,Value,CreatedBy,AD_Org_ID,AD_Client_ID,Created,UpdatedBy,Updated,IsActive) VALUES (200001,102,'107|DetailPane.IsOpen','d68b1ac5-7833-4599-956d-eaf6dec673fe','N',100,0,0,TO_TIMESTAMP('2013-03-05 16:21:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-05 16:21:20','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 5, 2013 4:21:58 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (1,1,0,'N',374,0,'N','N',208801,470,'Y',201868,'N','When specify this identified the name of the financial report line to take values from for column Oper_2_ID. No validation at entry time, value will be zero if the name doesn''t match any line.','@ColumnType@=C','D','Name of the financial report line to take values from','Operand 2 Line Name','Y','N','a6d0adf3-bf54-47d5-84d6-b5532ab919b6',100,0,TO_TIMESTAMP('2013-03-05 16:21:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-05 16:21:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',470,1,'N')
;

-- Mar 5, 2013 4:21:58 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201868 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 5, 2013 4:22:55 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2013-03-05 16:22:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58042
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4756
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4757
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4759
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4761
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4762
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET ColumnSpan=2, SeqNo=180, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201868
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4763
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4764
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56301
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56518
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56517
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4765
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56296
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4766
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56302
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4777
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56299
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4776
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56298
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4775
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56303
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4767
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56300
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4768
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56304
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4769
;

-- Mar 5, 2013 4:22:56 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2013-03-05 16:22:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56297
;

-- Mar 5, 2013 4:22:57 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2013-03-05 16:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56281
;

-- Mar 5, 2013 4:22:57 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2013-03-05 16:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56305
;

-- Mar 5, 2013 4:22:57 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2013-03-05 16:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56282
;

-- Mar 5, 2013 4:22:57 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=430,Updated=TO_TIMESTAMP('2013-03-05 16:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56306
;

-- Mar 5, 2013 4:22:57 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=440,Updated=TO_TIMESTAMP('2013-03-05 16:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56375
;

-- Mar 5, 2013 4:22:57 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET SeqNo=450,Updated=TO_TIMESTAMP('2013-03-05 16:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56376
;

-- Mar 5, 2013 6:12:02 PM MYT
-- IDEMPIERE-674 Financial Report: Percentage of column against line total
UPDATE AD_Field SET DisplayLogic='@ColumnType@=C&@CalculationType@=P',Updated=TO_TIMESTAMP('2013-03-05 18:12:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201868
;

SELECT register_migration_script('201303050820_IDEMPIERE-674.sql') FROM dual
;

