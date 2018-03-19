-- Sep 4, 2012 10:34:50 AM COT
-- Element Master Role
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsMasterRole',200117,'D','MasterRole','MasterRole','4bad6035-f81b-4e25-81d9-bbf55b099113',0,TO_DATE('2012-09-04 10:34:49','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-04 10:34:49','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 4, 2012 10:34:50 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200117 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 4, 2012 10:36:19 AM COT
-- Column master Role
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,DefaultValue) VALUES (0,156,200410,'D','Y','N','N',0,'N',1,'N',20,'N','N',200117,'N','Y','5ec60b3e-f1a7-447c-a7ea-f3575dcb24d4','N','Y','N','IsMasterRole','MasterRole','Y',100,TO_DATE('2012-09-04 10:36:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-04 10:36:18','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Sep 4, 2012 10:36:19 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200410 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;


-- Sep 4, 2012 10:37:58 AM COT
-- Field Master Role
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',119,1,'N','N',200410,'Y',200411,'N','D','MasterRole','Y','N','b57a3894-98be-44fa-a834-6883c8824d92',100,0,TO_DATE('2012-09-04 10:37:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-04 10:37:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 4, 2012 10:37:58 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200411 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 4, 2012 10:38:27 AM COT
-- seq
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y' WHERE AD_Field_ID=200411
;

-- Sep 4, 2012 10:38:40 AM COT
-- Position web
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2012-09-04 10:38:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200411
;


-- Sep 4, 2012 4:12:10 PM COT
-- Validation for just Master Role in included roles
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_Role.IsMasterRole=''Y''',200006,'D','MasterRoles','S','5d5fa599-0937-4e88-905b-b0814fc7fc84',100,100,TO_DATE('2012-09-04 16:12:08','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-04 16:12:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;


-- Sep 4, 2012 4:13:06 PM COT
UPDATE AD_Column SET AD_Val_Rule_ID=200006, IsUpdateable='N',Updated=TO_DATE('2012-09-04 16:13:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=57949
;

-- Sep 4, 2012 4:55:32 PM COT
-- Display Logic Window Role
UPDATE AD_Tab SET DisplayLogic='@IsMasterRole@=N',Updated=TO_DATE('2012-09-04 16:55:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=351
;

-- Sep 4, 2012 4:55:40 PM COT
-- Display Logic Window Role
UPDATE AD_Tab SET DisplayLogic='@IsMasterRole@=N',Updated=TO_DATE('2012-09-04 16:55:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=120
;

-- Sep 4, 2012 4:55:53 PM COT
-- Display Logic Window Role
UPDATE AD_Tab SET DisplayLogic='@IsMasterRole@=N',Updated=TO_DATE('2012-09-04 16:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53240
;

-- Sep 5, 2012 2:26:43 PM COT
-- Roles are manual for default
UPDATE AD_Column SET DefaultValue='Y',Updated=TO_DATE('2012-09-05 14:26:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9593
;

-- Sep 11, 2012 6:56:24 PM COT
ALTER TABLE AD_Role ADD IsMasterRole CHAR(1) DEFAULT 'N' CHECK (IsMasterRole IN ('Y','N')) NOT NULL
;

-- Sep 11, 2012 6:56:46 PM COT
ALTER TABLE AD_Role MODIFY IsManual CHAR(1) DEFAULT 'Y'
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200411
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=930
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=931
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=59592
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=59591
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=10126
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=52018
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=8740
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=5227
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=11006
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=11003
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=11002
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=8311
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=10813
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=11256
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=11257
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=8313
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=8314
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=8312
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=8310
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=12367
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=12368
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=12641
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=200071
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=50168
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=50169
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=50170
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=50171
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=50172
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=50173
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=50174
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=50175
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=50176
;

-- Sep 11, 2012 8:39:22 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=50177
;

-- Sep 11, 2012 8:39:23 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=50178
;

-- Sep 11, 2012 8:39:23 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y' WHERE AD_Field_ID=55432
;

-- Sep 11, 2012 8:39:23 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y' WHERE AD_Field_ID=55433
;

-- Sep 11, 2012 8:43:59 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Element SET Name='Master Role', Description='A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', PrintName='Master Role',Updated=TO_DATE('2012-09-11 20:43:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200117
;

-- Sep 11, 2012 8:43:59 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200117
;

-- Sep 11, 2012 8:43:59 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Column SET ColumnName='IsMasterRole', Name='Master Role', Description='A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', Help=NULL WHERE AD_Element_ID=200117
;

-- Sep 11, 2012 8:43:59 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Process_Para SET ColumnName='IsMasterRole', Name='Master Role', Description='A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', Help=NULL, AD_Element_ID=200117 WHERE UPPER(ColumnName)='ISMASTERROLE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 11, 2012 8:43:59 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Process_Para SET ColumnName='IsMasterRole', Name='Master Role', Description='A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', Help=NULL WHERE AD_Element_ID=200117 AND IsCentrallyMaintained='Y'
;

-- Sep 11, 2012 8:43:59 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Field SET Name='Master Role', Description='A master role cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200117) AND IsCentrallyMaintained='Y'
;

-- Sep 11, 2012 8:43:59 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_PrintFormatItem pi SET PrintName='Master Role', Name='Master Role' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200117)
;

-- Sep 11, 2012 10:48:11 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''GLJ'' AND AD_Client_ID=@AD_Client_ID@',Updated=TO_DATE('2012-09-11 22:48:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=102
;

-- Sep 12, 2012 11:38:13 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''ARI'', ''API'',''ARC'',''APC'') AND C_DocType.IsSOTrx=''@IsSOTrx@''  AND AD_Client_ID=@AD_Client_ID@''',Updated=TO_DATE('2012-09-12 11:38:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=124
;


-- Sep 12, 2012 11:40:18 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''GLD'' AND AD_Client_ID=@AD_Client_ID@''',Updated=TO_DATE('2012-09-12 11:40:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=121
;

-- Sep 12, 2012 11:41:16 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''ARI'', ''API'',''ARC'',''APC'') AND AD_Client_ID=@AD_Client_ID@''',Updated=TO_DATE('2012-09-12 11:41:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=173
;

-- Sep 12, 2012 11:41:30 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''MMI'' AND AD_Client_ID=@AD_Client_ID@''',Updated=TO_DATE('2012-09-12 11:41:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=209
;

-- Sep 12, 2012 11:41:39 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''MMR'') AND IsSOTrx=''N'' AND AD_Client_ID=@AD_Client_ID@''',Updated=TO_DATE('2012-09-12 11:41:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52054
;


-- Sep 12, 2012 11:41:55 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''MMR'', ''MMS'') AND AD_Client_ID=@AD_Client_ID@''',Updated=TO_DATE('2012-09-12 11:41:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=125
;

-- Sep 12, 2012 11:42:02 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''MMM'' AND AD_Client_ID=@AD_Client_ID@''',Updated=TO_DATE('2012-09-12 11:42:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=201
;

-- Sep 12, 2012 11:42:08 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''DOO'' AND AD_Client_ID=@AD_Client_ID@''',Updated=TO_DATE('2012-09-12 11:42:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52004
;

-- Sep 12, 2012 11:42:16 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''SOO'', ''POO'') AND C_DocType.DocSubTypeSO=''RM'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@ AND IsSOTrx=''N'' AND AD_Client_ID=@AD_Client_ID@''',Updated=TO_DATE('2012-09-12 11:42:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52066
;


-- Sep 12, 2012 6:20:08 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''MMI'' AND AD_Client_ID=@AD_Client_ID@',Updated=TO_DATE('2012-09-12 18:20:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=209
;


-- Sep 12, 2012 6:28:44 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''ARR'', ''APP'')  AND AD_Client_ID=@AD_Client_ID@',Updated=TO_DATE('2012-09-12 18:28:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=149
;


UPDATE AD_System
  SET LastMigrationScriptApplied='899_IDEMPIERE_366.sql'
WHERE LastMigrationScriptApplied<'899_IDEMPIERE_366.sql'
   OR LastMigrationScriptApplied IS NULL
;

