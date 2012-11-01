-- Feb 18, 2012 8:32:49 PM COT
-- IDEMPIERE-153 OrderBy Type (Print Format Item View)
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,Description,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200003,'IsDesc','D','Descending','Sort your data using a SQL Desc Order By statement','Descending',0,TO_TIMESTAMP('2012-02-18 20:32:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-18 20:32:48','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Feb 18, 2012 8:32:49 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200003 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 18, 2012 8:32:50 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('N',200016,489,'D',0,'Y','N','N','N',1,'N',20,'Y','N',200003,'N','Y','N','IsDesc','Sort your data using a SQL Desc Order By statement','Descending',100,TO_TIMESTAMP('2012-02-18 20:32:49','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-02-18 20:32:49','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 18, 2012 8:32:50 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200016 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 18, 2012 8:32:50 PM COT
ALTER TABLE AD_PrintFormatItem ADD COLUMN IsDesc CHAR(1) DEFAULT 'N' CHECK (IsDesc IN ('Y','N')) NOT NULL
;

-- Feb 18, 2012 8:32:53 PM COT
INSERT INTO AD_Field (SortNo,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,DisplayLogic,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,0,'Y','Y','N',200016,'N',430,'Y',426,200001,'N','@IsOrderBy@=Y','D','Sort your data using a SQL Desc Order By statement','Descending',100,0,'Y',TO_TIMESTAMP('2012-02-18 20:32:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-02-18 20:32:52','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 18, 2012 8:32:53 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200001 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=5692
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=5760
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=56378
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=56373
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=5671
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=11200
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=5756
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=5755
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=5697
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=13016
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=5677
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=5761
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=5690
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=5681
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=5669
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=5804
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=5763
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=5695
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=5691
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=5685
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=5673
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=5678
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=5805
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=11023
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=5689
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=5688
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=11021
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=5682
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=5686
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=11020
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=5693
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y' WHERE AD_Field_ID=5674
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y' WHERE AD_Field_ID=200001
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y' WHERE AD_Field_ID=5694
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y' WHERE AD_Field_ID=5676
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=470,IsDisplayed='Y' WHERE AD_Field_ID=5680
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=480,IsDisplayed='Y' WHERE AD_Field_ID=8294
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y' WHERE AD_Field_ID=5757
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y' WHERE AD_Field_ID=8293
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=510,IsDisplayed='Y' WHERE AD_Field_ID=8295
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=520,IsDisplayed='Y' WHERE AD_Field_ID=8292
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=530,IsDisplayed='Y' WHERE AD_Field_ID=5758
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=540,IsDisplayed='Y' WHERE AD_Field_ID=8604
;

-- Feb 18, 2012 8:35:40 PM COT
UPDATE AD_Field SET SeqNo=550,IsDisplayed='Y' WHERE AD_Field_ID=8605
;

-- Feb 18, 2012 8:57:37 PM COT
-- IDEMPIERE-153 OrderBy Type (Print Format Item View)
UPDATE AD_Field SET DisplayLength=1, IsSameLine='N', DisplayLogic='@PrintFormatType@=F & @IsOrderBy@=Y',Updated=TO_TIMESTAMP('2012-02-18 20:57:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200001
;

UPDATE AD_System
  SET LastMigrationScriptApplied='820_IDEMPIERE-153.sql'
WHERE LastMigrationScriptApplied<'820_IDEMPIERE-153.sql'
   OR LastMigrationScriptApplied IS NULL
;
