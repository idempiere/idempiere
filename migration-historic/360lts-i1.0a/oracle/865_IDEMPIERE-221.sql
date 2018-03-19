-- Aug 6, 2012 12:39:27 PM COT
-- IDEMPIERE-221 Implement password policies
UPDATE AD_Table SET AD_Window_ID=200002,Updated=TO_DATE('2012-08-06 12:39:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200005
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200252
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200076
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200081
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200256
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200086
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200089
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200094
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200093
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200254
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200079
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200080
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200251
;

-- Aug 6, 2012 12:44:29 PM COT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200074
;

-- Aug 6, 2012 12:44:46 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-06 12:44:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200083
;

-- Aug 6, 2012 12:45:17 PM COT
UPDATE AD_Element SET Name='Minimum Length', PrintName='Minimum Length',Updated=TO_DATE('2012-08-06 12:45:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200065
;

-- Aug 6, 2012 12:45:17 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200065
;

-- Aug 6, 2012 12:45:17 PM COT
UPDATE AD_Column SET ColumnName='MinLength', Name='Minimum Length', Description=NULL, Help=NULL WHERE AD_Element_ID=200065
;

-- Aug 6, 2012 12:45:17 PM COT
UPDATE AD_Process_Para SET ColumnName='MinLength', Name='Minimum Length', Description=NULL, Help=NULL, AD_Element_ID=200065 WHERE UPPER(ColumnName)='MINLENGTH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 12:45:17 PM COT
UPDATE AD_Process_Para SET ColumnName='MinLength', Name='Minimum Length', Description=NULL, Help=NULL WHERE AD_Element_ID=200065 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 12:45:17 PM COT
UPDATE AD_Field SET Name='Minimum Length', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200065) AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 12:45:17 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Minimum Length', Name='Minimum Length' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200065)
;

-- Aug 6, 2012 12:45:54 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-06 12:45:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200081
;

-- Aug 6, 2012 12:45:58 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-06 12:45:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200082
;

-- Aug 6, 2012 12:46:09 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-06 12:46:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200089
;

-- Aug 6, 2012 12:46:45 PM COT
UPDATE AD_Element SET Name='Whitespace', PrintName='Whitespace',Updated=TO_DATE('2012-08-06 12:46:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200030
;

-- Aug 6, 2012 12:46:45 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200030
;

-- Aug 6, 2012 12:46:45 PM COT
UPDATE AD_Column SET ColumnName='whitespace', Name='Whitespace', Description=NULL, Help=NULL WHERE AD_Element_ID=200030
;

-- Aug 6, 2012 12:46:45 PM COT
UPDATE AD_Process_Para SET ColumnName='whitespace', Name='Whitespace', Description=NULL, Help=NULL, AD_Element_ID=200030 WHERE UPPER(ColumnName)='WHITESPACE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 12:46:45 PM COT
UPDATE AD_Process_Para SET ColumnName='whitespace', Name='Whitespace', Description=NULL, Help=NULL WHERE AD_Element_ID=200030 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 12:46:45 PM COT
UPDATE AD_Field SET Name='Whitespace', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200030) AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 12:46:45 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Whitespace', Name='Whitespace' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200030)
;

-- Aug 6, 2012 12:47:20 PM COT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200251
;

-- Aug 6, 2012 12:47:20 PM COT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200086
;

-- Aug 6, 2012 12:47:20 PM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200089
;

-- Aug 6, 2012 12:47:20 PM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200094
;

-- Aug 6, 2012 12:47:20 PM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200093
;

-- Aug 6, 2012 12:47:20 PM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200254
;

-- Aug 6, 2012 12:47:20 PM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200079
;

-- Aug 6, 2012 12:47:20 PM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200080
;

-- Aug 6, 2012 12:47:31 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-06 12:47:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200086
;

-- Aug 6, 2012 12:47:35 PM COT
UPDATE AD_Field SET IsSameLine='N',Updated=TO_DATE('2012-08-06 12:47:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200089
;

-- Aug 6, 2012 12:47:39 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-06 12:47:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200094
;

-- Aug 6, 2012 12:47:56 PM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200079
;

-- Aug 6, 2012 12:47:56 PM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200254
;

-- Aug 6, 2012 12:48:02 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-06 12:48:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200079
;

-- Aug 6, 2012 1:25:02 PM COT
UPDATE AD_Column SET FieldLength=10, AD_Reference_ID=11,Updated=TO_DATE('2012-08-06 13:25:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200236
;

-- Aug 6, 2012 1:25:19 PM COT
UPDATE AD_Element SET Description='Lenght of required alphabetical sequence',Updated=TO_DATE('2012-08-06 13:25:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200068
;

-- Aug 6, 2012 1:25:19 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200068
;

-- Aug 6, 2012 1:25:19 PM COT
UPDATE AD_Column SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Lenght of required alphabetical sequence', Help=NULL WHERE AD_Element_ID=200068
;

-- Aug 6, 2012 1:25:19 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Lenght of required alphabetical sequence', Help=NULL, AD_Element_ID=200068 WHERE UPPER(ColumnName)='ALPHABETICALSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 1:25:19 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Lenght of required alphabetical sequence', Help=NULL WHERE AD_Element_ID=200068 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:25:19 PM COT
UPDATE AD_Field SET Name='Alphabetical Sequence', Description='Lenght of required alphabetical sequence', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200068) AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:25:31 PM COT
ALTER TABLE ad_passwordrule DROP ( AlphabeticalSequence ) CASCADE CONSTRAINT
;

-- Aug 6, 2012 1:27:54 PM COT
ALTER TABLE AD_PasswordRule ADD AlphabeticalSequence NUMBER(10) DEFAULT NULL 
;

-- Aug 6, 2012 1:28:58 PM COT
UPDATE AD_Column SET FieldLength=10, AD_Reference_ID=11,Updated=TO_DATE('2012-08-06 13:28:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200131
;

ALTER TABLE ad_passwordrule DROP ( QWERTYSequence ) CASCADE CONSTRAINT
;

-- Aug 6, 2012 1:29:01 PM COT
ALTER TABLE AD_PasswordRule ADD QWERTYSequence NUMBER(10) DEFAULT NULL 
;

-- Aug 6, 2012 1:29:26 PM COT
UPDATE AD_Element SET Description='Lenght of QWERTY sequences to validate',Updated=TO_DATE('2012-08-06 13:29:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200029
;

-- Aug 6, 2012 1:29:26 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200029
;

-- Aug 6, 2012 1:29:26 PM COT
UPDATE AD_Column SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Lenght of QWERTY sequences to validate', Help=NULL WHERE AD_Element_ID=200029
;

-- Aug 6, 2012 1:29:26 PM COT
UPDATE AD_Process_Para SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Lenght of QWERTY sequences to validate', Help=NULL, AD_Element_ID=200029 WHERE UPPER(ColumnName)='QWERTYSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 1:29:26 PM COT
UPDATE AD_Process_Para SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Lenght of QWERTY sequences to validate', Help=NULL WHERE AD_Element_ID=200029 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:29:26 PM COT
UPDATE AD_Field SET Name='QWERTY Sequence', Description='Lenght of QWERTY sequences to validate', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200029) AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:29:52 PM COT
UPDATE AD_Element SET Description='Lenght of alphabetical sequence to validate',Updated=TO_DATE('2012-08-06 13:29:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200068
;

-- Aug 6, 2012 1:29:52 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200068
;

-- Aug 6, 2012 1:29:52 PM COT
UPDATE AD_Column SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Lenght of alphabetical sequence to validate', Help=NULL WHERE AD_Element_ID=200068
;

-- Aug 6, 2012 1:29:52 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Lenght of alphabetical sequence to validate', Help=NULL, AD_Element_ID=200068 WHERE UPPER(ColumnName)='ALPHABETICALSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 1:29:52 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Lenght of alphabetical sequence to validate', Help=NULL WHERE AD_Element_ID=200068 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:29:52 PM COT
UPDATE AD_Field SET Name='Alphabetical Sequence', Description='Lenght of alphabetical sequence to validate', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200068) AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:30:38 PM COT
UPDATE AD_Element SET Description='Length of numerical sequence to validate',Updated=TO_DATE('2012-08-06 13:30:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200028
;

-- Aug 6, 2012 1:30:38 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200028
;

-- Aug 6, 2012 1:30:38 PM COT
UPDATE AD_Column SET ColumnName='NumericalSequence', Name='Numerical Sequence', Description='Length of numerical sequence to validate', Help=NULL WHERE AD_Element_ID=200028
;

-- Aug 6, 2012 1:30:38 PM COT
UPDATE AD_Process_Para SET ColumnName='NumericalSequence', Name='Numerical Sequence', Description='Length of numerical sequence to validate', Help=NULL, AD_Element_ID=200028 WHERE UPPER(ColumnName)='NUMERICALSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 1:30:38 PM COT
UPDATE AD_Process_Para SET ColumnName='NumericalSequence', Name='Numerical Sequence', Description='Length of numerical sequence to validate', Help=NULL WHERE AD_Element_ID=200028 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:30:38 PM COT
UPDATE AD_Field SET Name='Numerical Sequence', Description='Length of numerical sequence to validate', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200028) AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:31:18 PM COT
UPDATE AD_Element SET Description='Require at least # alphabetical in passwords',Updated=TO_DATE('2012-08-06 13:31:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200027
;

-- Aug 6, 2012 1:31:18 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200027
;

-- Aug 6, 2012 1:31:18 PM COT
UPDATE AD_Column SET ColumnName='AlphabeticalCharacter', Name='Alphabetical Character', Description='Require at least # alphabetical in passwords', Help=NULL WHERE AD_Element_ID=200027
;

-- Aug 6, 2012 1:31:18 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalCharacter', Name='Alphabetical Character', Description='Require at least # alphabetical in passwords', Help=NULL, AD_Element_ID=200027 WHERE UPPER(ColumnName)='ALPHABETICALCHARACTER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 1:31:18 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalCharacter', Name='Alphabetical Character', Description='Require at least # alphabetical in passwords', Help=NULL WHERE AD_Element_ID=200027 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:31:18 PM COT
UPDATE AD_Field SET Name='Alphabetical Character', Description='Require at least # alphabetical in passwords', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200027) AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:32:21 PM COT
UPDATE AD_Element SET Description='Length of repeated characters to validate',Updated=TO_DATE('2012-08-06 13:32:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200069
;

-- Aug 6, 2012 1:32:21 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200069
;

-- Aug 6, 2012 1:32:21 PM COT
UPDATE AD_Column SET ColumnName='RepeatCharacterRegex', Name='Repeat Character Regex', Description='Length of repeated characters to validate', Help=NULL WHERE AD_Element_ID=200069
;

-- Aug 6, 2012 1:32:21 PM COT
UPDATE AD_Process_Para SET ColumnName='RepeatCharacterRegex', Name='Repeat Character Regex', Description='Length of repeated characters to validate', Help=NULL, AD_Element_ID=200069 WHERE UPPER(ColumnName)='REPEATCHARACTERREGEX' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 1:32:21 PM COT
UPDATE AD_Process_Para SET ColumnName='RepeatCharacterRegex', Name='Repeat Character Regex', Description='Length of repeated characters to validate', Help=NULL WHERE AD_Element_ID=200069 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:32:21 PM COT
UPDATE AD_Field SET Name='Repeat Character Regex', Description='Length of repeated characters to validate', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200069) AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:34:52 PM COT
UPDATE AD_Element SET ColumnName='IsDictMatchBackwards',Updated=TO_DATE('2012-08-06 13:34:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200033
;

-- Aug 6, 2012 1:34:52 PM COT
UPDATE AD_Column SET ColumnName='IsDictMatchBackwards', Name='Match Backwards of Dictionary', Description='Match dictionary words backwards', Help=NULL WHERE AD_Element_ID=200033
;

-- Aug 6, 2012 1:34:52 PM COT
UPDATE AD_Process_Para SET ColumnName='IsDictMatchBackwards', Name='Match Backwards of Dictionary', Description='Match dictionary words backwards', Help=NULL, AD_Element_ID=200033 WHERE UPPER(ColumnName)='ISDICTMATCHBACKWARDS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 1:34:52 PM COT
UPDATE AD_Process_Para SET ColumnName='IsDictMatchBackwards', Name='Match Backwards of Dictionary', Description='Match dictionary words backwards', Help=NULL WHERE AD_Element_ID=200033 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:35:09 PM COT
UPDATE AD_Column SET IsMandatory='Y', DefaultValue='N',Updated=TO_DATE('2012-08-06 13:35:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200138
;

-- Aug 6, 2012 1:35:12 PM COT
ALTER TABLE ad_passwordrule RENAME COLUMN DictMatchBackwards TO IsDictMatchBackwards
;

-- Aug 6, 2012 1:35:32 PM COT
UPDATE AD_Column SET IsMandatory='Y', DefaultValue='N',Updated=TO_DATE('2012-08-06 13:35:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200133
;

-- Aug 6, 2012 1:35:33 PM COT
ALTER TABLE ad_passwordrule RENAME COLUMN whitespace TO iswhitespace
;

-- Aug 6, 2012 1:36:48 PM COT
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=200240
;

-- Aug 6, 2012 1:36:48 PM COT
DELETE FROM AD_Column WHERE AD_Column_ID=200240
;

-- Aug 6, 2012 2:16:41 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsUserNameRule',200072,'D','User Name Rule','Validate the password doesn''t contain user name (ignore case and match backwards)','User Name Rule','9eda063a-90bd-442f-95ed-89804cf6497a',0,TO_DATE('2012-08-06 14:16:40','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-08-06 14:16:40','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 6, 2012 2:16:41 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200072 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 6, 2012 1:37:02 PM COT
UPDATE AD_Column SET IsMandatory='Y', AD_Element_ID=200072, ColumnName='IsUserNameRule', Description='Validate the password doesn''t contain user name (ignore case and match backwards)', DefaultValue='N', Help=NULL, Name='User Name Rule',Updated=TO_DATE('2012-08-06 13:37:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200134
;

-- Aug 6, 2012 1:37:02 PM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200134
;

-- Aug 6, 2012 1:37:02 PM COT
UPDATE AD_Field SET Name='User Name Rule', Description='Validate the password doesn''t contain user name (ignore case and match backwards)', Help=NULL WHERE AD_Column_ID=200134 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:34:16 PM COT
ALTER TABLE ad_passwordrule RENAME COLUMN username TO IsUserNameRule
;

-- Aug 6, 2012 1:37:03 PM COT
UPDATE AD_PasswordRule SET IsUserNameRule='N' WHERE IsUserNameRule IS NULL
;

-- Aug 6, 2012 1:37:10 PM COT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200090
;

-- Aug 6, 2012 1:37:57 PM COT
UPDATE AD_Element SET ColumnName='IsUsingDictionary',Updated=TO_DATE('2012-08-06 13:37:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200031
;

-- Aug 6, 2012 1:37:57 PM COT
UPDATE AD_Column SET ColumnName='IsUsingDictionary', Name='Using Dictionary', Description=NULL, Help=NULL WHERE AD_Element_ID=200031
;

-- Aug 6, 2012 1:37:57 PM COT
UPDATE AD_Process_Para SET ColumnName='IsUsingDictionary', Name='Using Dictionary', Description=NULL, Help=NULL, AD_Element_ID=200031 WHERE UPPER(ColumnName)='ISUSINGDICTIONARY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 1:37:57 PM COT
UPDATE AD_Process_Para SET ColumnName='IsUsingDictionary', Name='Using Dictionary', Description=NULL, Help=NULL WHERE AD_Element_ID=200031 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 1:38:17 PM COT
UPDATE AD_Column SET IsMandatory='Y', DefaultValue='N',Updated=TO_DATE('2012-08-06 13:38:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200135
;

-- Aug 6, 2012 1:38:18 PM COT
ALTER TABLE ad_passwordrule RENAME COLUMN UsingDictionary TO IsUsingDictionary
;

-- Aug 6, 2012 1:57:03 PM COT
UPDATE AD_Column SET IsMandatory='Y', DefaultValue='Y', IsAllowCopy='N',Updated=TO_DATE('2012-08-06 13:57:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200121
;

-- Aug 6, 2012 1:57:05 PM COT
ALTER TABLE AD_PasswordRule MODIFY IsActive CHAR(1) DEFAULT 'Y'
;

-- Aug 6, 2012 1:57:05 PM COT
UPDATE AD_PasswordRule SET IsActive='Y' WHERE IsActive IS NULL
;

-- Aug 6, 2012 1:57:05 PM COT
ALTER TABLE AD_PasswordRule MODIFY IsActive NOT NULL
;

-- Aug 6, 2012 1:57:11 PM COT
ALTER TABLE AD_PasswordRule MODIFY IsDictMatchBackwards CHAR(1) DEFAULT 'N'
;

-- Aug 6, 2012 1:57:11 PM COT
UPDATE AD_PasswordRule SET IsDictMatchBackwards='N' WHERE IsDictMatchBackwards IS NULL
;

-- Aug 6, 2012 1:57:17 PM COT
ALTER TABLE AD_PasswordRule MODIFY IsUserNameRule CHAR(1) DEFAULT 'N'
;

-- Aug 6, 2012 1:57:17 PM COT
UPDATE AD_PasswordRule SET IsUserNameRule='N' WHERE IsUserNameRule IS NULL
;

-- Aug 6, 2012 1:57:22 PM COT
ALTER TABLE AD_PasswordRule MODIFY IsUsingDictionary CHAR(1) DEFAULT 'N'
;

-- Aug 6, 2012 1:57:22 PM COT
UPDATE AD_PasswordRule SET IsUsingDictionary='N' WHERE IsUsingDictionary IS NULL
;

-- Aug 6, 2012 1:57:28 PM COT
ALTER TABLE AD_PasswordRule MODIFY IsWhitespace CHAR(1) DEFAULT 'N'
;

-- Aug 6, 2012 1:57:28 PM COT
UPDATE AD_PasswordRule SET IsWhitespace='N' WHERE IsWhitespace IS NULL
;

-- Aug 6, 2012 2:31:39 PM COT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200251
;

-- Aug 6, 2012 2:31:39 PM COT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200086
;

-- Aug 6, 2012 2:31:39 PM COT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200089
;

-- Aug 6, 2012 2:31:39 PM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200255
;

-- Aug 6, 2012 2:31:39 PM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200090
;

-- Aug 6, 2012 2:31:39 PM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200094
;

-- Aug 6, 2012 2:31:39 PM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200093
;

-- Aug 6, 2012 2:31:39 PM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200079
;

-- Aug 6, 2012 2:31:39 PM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200254
;

-- Aug 6, 2012 2:31:40 PM COT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200080
;

-- Aug 6, 2012 2:31:40 PM COT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200074
;

-- Aug 6, 2012 2:31:57 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-06 14:31:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200255
;

-- Aug 6, 2012 3:57:31 PM COT
UPDATE AD_Element SET ColumnName='IsWhitespace', Description='Whitespace validation',Updated=TO_DATE('2012-08-06 15:57:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200030
;

-- Aug 6, 2012 3:57:31 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200030
;

-- Aug 6, 2012 3:57:31 PM COT
UPDATE AD_Column SET ColumnName='IsWhitespace', Name='Whitespace', Description='Whitespace validation', Help=NULL WHERE AD_Element_ID=200030
;

-- Aug 6, 2012 3:57:31 PM COT
UPDATE AD_Process_Para SET ColumnName='IsWhitespace', Name='Whitespace', Description='Whitespace validation', Help=NULL, AD_Element_ID=200030 WHERE UPPER(ColumnName)='ISWHITESPACE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 6, 2012 3:57:31 PM COT
UPDATE AD_Process_Para SET ColumnName='IsWhitespace', Name='Whitespace', Description='Whitespace validation', Help=NULL WHERE AD_Element_ID=200030 AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 3:57:31 PM COT
UPDATE AD_Field SET Name='Whitespace', Description='Whitespace validation', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200030) AND IsCentrallyMaintained='Y'
;

-- Aug 6, 2012 5:03:43 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Password Errors',200011,'D','9a29cf03-6807-43c4-aa53-982d2aa63dfc','PasswordErrors','Y',TO_DATE('2012-08-06 17:03:42','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-08-06 17:03:42','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 6, 2012 5:03:43 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200011 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Aug 6, 2012 8:32:30 PM COT
UPDATE AD_Field SET DisplayLogic='@IsUsingDictionary@=Y',Updated=TO_DATE('2012-08-06 20:32:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200254
;

-- Aug 6, 2012 8:32:38 PM COT
UPDATE AD_Field SET DisplayLogic='@IsUsingDictionary@=Y',Updated=TO_DATE('2012-08-06 20:32:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200079
;

-- Aug 6, 2012 8:32:42 PM COT
UPDATE AD_Field SET DisplayLogic='@IsUsingDictionary@=Y',Updated=TO_DATE('2012-08-06 20:32:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200080
;

UPDATE AD_System
  SET LastMigrationScriptApplied='865_IDEMPIERE-221.sql'
WHERE LastMigrationScriptApplied<'865_IDEMPIERE-221.sql'
   OR LastMigrationScriptApplied IS NULL
;

