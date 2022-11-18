-- IDEMPIERE-5482
SELECT register_migration_script('202211181424_IDEMPIERE-5482.sql') FROM dual;

-- Nov 18, 2022, 2:24:27 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203730,0,0,'Y',TO_TIMESTAMP('2022-11-18 14:24:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-18 14:24:26','YYYY-MM-DD HH24:MI:SS'),100,'AD_StyleScope','Scope','Scope','D','d853e315-81ed-4981-b48d-f0e96e9eae70')
;

-- Nov 18, 2022, 2:26:52 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200226,'AD_Style Scope','L',0,0,'Y',TO_TIMESTAMP('2022-11-18 14:26:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-18 14:26:52','YYYY-MM-DD HH24:MI:SS'),100,'D','N','e6a12197-9fbf-4d8c-98d9-a820e664472b')
;

-- Nov 18, 2022, 2:31:53 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200618,'Table Cell',200226,'T',0,0,'Y',TO_TIMESTAMP('2022-11-18 14:31:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-18 14:31:53','YYYY-MM-DD HH24:MI:SS'),100,'D','93fde91d-d85c-413f-8ed9-8cb598f47da0')
;

-- Nov 18, 2022, 2:32:08 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200619,'Span Child',200226,'S',0,0,'Y',TO_TIMESTAMP('2022-11-18 14:32:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-18 14:32:08','YYYY-MM-DD HH24:MI:SS'),100,'D','f408594a-dfbc-4a0c-bc07-55a2acb4b28f')
;

-- Nov 18, 2022, 2:33:26 PM CET
UPDATE AD_Element SET Description='The user is able to change the behaviour, how to apply css style regarding to scope of HTML Dom element. As legacy mode, apply style to td table cell.',Updated=TO_TIMESTAMP('2022-11-18 14:33:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203730
;

-- Nov 18, 2022, 2:33:26 PM CET
UPDATE AD_Column SET ColumnName='AD_StyleScope', Name='Scope', Description='The user is able to change the behaviour, how to apply css style regarding to scope of HTML Dom element. As legacy mode, apply style to td table cell.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203730
;

-- Nov 18, 2022, 2:33:26 PM CET
UPDATE AD_Process_Para SET ColumnName='AD_StyleScope', Name='Scope', Description='The user is able to change the behaviour, how to apply css style regarding to scope of HTML Dom element. As legacy mode, apply style to td table cell.', Help=NULL, AD_Element_ID=203730 WHERE UPPER(ColumnName)='AD_STYLESCOPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 18, 2022, 2:33:26 PM CET
UPDATE AD_Process_Para SET ColumnName='AD_StyleScope', Name='Scope', Description='The user is able to change the behaviour, how to apply css style regarding to scope of HTML Dom element. As legacy mode, apply style to td table cell.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203730 AND IsCentrallyMaintained='Y'
;

-- Nov 18, 2022, 2:33:26 PM CET
UPDATE AD_InfoColumn SET ColumnName='AD_StyleScope', Name='Scope', Description='The user is able to change the behaviour, how to apply css style regarding to scope of HTML Dom element. As legacy mode, apply style to td table cell.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203730 AND IsCentrallyMaintained='Y'
;

-- Nov 18, 2022, 2:33:26 PM CET
UPDATE AD_Field SET Name='Scope', Description='The user is able to change the behaviour, how to apply css style regarding to scope of HTML Dom element. As legacy mode, apply style to td table cell.', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203730) AND IsCentrallyMaintained='Y'
;

-- Nov 18, 2022, 2:34:59 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215643,0,'Scope','The user is able to change the behaviour, how to apply css style regarding to scope of HTML Dom element. As legacy mode, apply style to td table cell.',200207,'AD_StyleScope','T',8,'N','N','Y','N','N',0,'N',17,200226,0,0,'Y',TO_TIMESTAMP('2022-11-18 14:34:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-18 14:34:59','YYYY-MM-DD HH24:MI:SS'),100,203730,'Y','N','D','N','N','N','Y','3469b655-74d4-4629-9524-2e98e30005d6','Y',0,'N','N','N','N')
;

-- Nov 18, 2022, 2:35:02 PM CET
ALTER TABLE AD_Style ADD COLUMN AD_StyleScope VARCHAR(8) DEFAULT 'T' NOT NULL
;

-- Nov 18, 2022, 2:35:34 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207421,'Scope','The user is able to change the behaviour, how to apply css style regarding to scope of HTML Dom element. As legacy mode, apply style to td table cell.',200213,215643,'Y',8,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-18 14:35:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-18 14:35:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d09625d8-be9c-4dcf-93d6-b5661c9b23ce','Y',50,2)
;

-- Nov 18, 2022, 2:35:56 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=1,Updated=TO_TIMESTAMP('2022-11-18 14:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207421
;

-- Nov 18, 2022, 2:35:56 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=5,Updated=TO_TIMESTAMP('2022-11-18 14:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204202
;

