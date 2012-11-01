-- Aug 20, 2012 11:14:07 PM IST
-- Add search sequence support for search dialog
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,EntityType,Description,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Selection_Column_SeqNo',200096,'For ordering sequence of selection column','U','Selection Column Sequence','Selection Column Sequence','Selection Column Sequence','6274682b-ac0f-47e8-9fbb-af34b4d69d89',0,TO_DATE('2012-08-20 23:14:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-08-20 23:14:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 20, 2012 11:14:07 PM IST
-- Add search sequence support for search dialog
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200096 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 20, 2012 11:17:08 PM IST
-- Add search sequence support for search dialog
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,101,200323,'U','N','N','N',0,'N',14,'N',11,'N','N',200096,'N','Y','97599ffb-8d35-48d1-b3c3-d0751a12563e','N','Y','N','Selection_Column_SeqNo','Selection Column Sequence','For ordering sequence of selection column','Selection Column Sequence','Y',100,TO_DATE('2012-08-20 23:17:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-20 23:17:07','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 20, 2012 11:17:08 PM IST
-- Add search sequence support for search dialog
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200323 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 20, 2012 11:17:48 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Element SET ColumnName='SeqNoSelection',Updated=TO_DATE('2012-08-20 23:17:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200096
;

-- Aug 20, 2012 11:17:48 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Column SET ColumnName='SeqNoSelection', Name='Selection Column Sequence', Description='Selection Column Sequence', Help='For ordering sequence of selection column' WHERE AD_Element_ID=200096
;

-- Aug 20, 2012 11:17:48 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Process_Para SET ColumnName='SeqNoSelection', Name='Selection Column Sequence', Description='Selection Column Sequence', Help='For ordering sequence of selection column', AD_Element_ID=200096 WHERE UPPER(ColumnName)='SEQNOSELECTION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 20, 2012 11:17:48 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Process_Para SET ColumnName='SeqNoSelection', Name='Selection Column Sequence', Description='Selection Column Sequence', Help='For ordering sequence of selection column' WHERE AD_Element_ID=200096 AND IsCentrallyMaintained='Y'
;

-- Aug 20, 2012 11:18:20 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Column SET Description='Selection Column Sequence ',Updated=TO_DATE('2012-08-20 23:18:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200323
;

-- Aug 20, 2012 11:18:20 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET Name='Selection Column Sequence', Description='Selection Column Sequence ', Help='For ordering sequence of selection column' WHERE AD_Column_ID=200323 AND IsCentrallyMaintained='Y'
;

-- Aug 20, 2012 11:18:28 PM IST
-- Add search sequence support for search dialog
ALTER TABLE AD_Column ADD SeqNoSelection NUMBER(10) DEFAULT NULL 
;

-- Aug 20, 2012 11:19:29 PM IST
-- Add search sequence support for search dialog
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',101,14,'N','N',200323,'Y',200288,'N','For ordering sequence of selection column','U','Selection Column Sequence','Selection Column Sequence','N','Y','6efc25d8-6850-4e4e-ba45-12c19a7561ec',100,0,TO_DATE('2012-08-20 23:19:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-20 23:19:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 20, 2012 11:19:29 PM IST
-- Add search sequence support for search dialog
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200288 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=56374
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=2526
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=171
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=54403
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=2574
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=2573
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=160
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=161
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=162
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=166
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=2370
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=169
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=10128
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=4941
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=50188
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=168
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=159
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=825
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=4940
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=200288
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=167
;

-- Aug 20, 2012 11:20:42 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=5121
;

-- Aug 20, 2012 11:20:43 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=56317
;

-- Aug 20, 2012 11:20:43 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=62467
;

-- Aug 20, 2012 11:20:43 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=5122
;

-- Aug 20, 2012 11:20:43 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=200286
;

-- Aug 20, 2012 11:27:34 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-20 23:27:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200288
;

-- Aug 20, 2012 11:33:11 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Field SET DisplayLogic='@IsSelectionColumn@=''Y''',Updated=TO_DATE('2012-08-20 23:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200288
;

UPDATE AD_System
  SET LastMigrationScriptApplied='880_IDEMPIERE-377_SeqNoSelection.sql'
WHERE LastMigrationScriptApplied<'880_IDEMPIERE-377_SeqNoSelection.sql'
   OR LastMigrationScriptApplied IS NULL
;