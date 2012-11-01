-- Oct 19, 2012 10:16:51 AM COT
-- IDEMPIERE-158 Make selection of login languages more flexible
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsLoginLocale',200192,'D','Login Locale',NULL,'Login Locale','0c0807db-3938-4f20-8937-3efa0b77f774',0,TO_TIMESTAMP('2012-10-19 10:16:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-19 10:16:49','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y')
;

-- Oct 19, 2012 10:16:51 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200192 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 19, 2012 10:21:04 AM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,111,200709,'D','N','N','N',0,'N',1,'N',20,'N','N',200192,'N','Y','e576ec6f-1106-4807-ae4c-fba78b88b854','N','Y','N','IsLoginLocale','N','Login Locale','Y',0,TO_TIMESTAMP('2012-10-19 10:21:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-19 10:21:03','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Oct 19, 2012 10:21:04 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200709 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 19, 2012 10:21:24 AM COT
ALTER TABLE AD_Language ADD COLUMN IsLoginLocale CHAR(1) DEFAULT 'N' CHECK (IsLoginLocale IN ('Y','N'))
;

-- Oct 19, 2012 11:44:48 AM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES (0,'N',112,0,'N','N',200709,60,'Y',200654,'N','D','Login Locale','Y','N','e6657fb8-9911-4b00-b5f9-1d75171af2bf',0,0,TO_TIMESTAMP('2012-10-19 11:44:46','YYYY-MM-DD HH24:MI:SS'),0,0,TO_TIMESTAMP('2012-10-19 11:44:46','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,2,1,1)
;

-- Oct 19, 2012 11:44:48 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200654 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

UPDATE AD_Language
SET IsLoginLocale = 'Y'
WHERE AD_Language IN (SELECT DISTINCT AD_Language FROM AD_Message_Trl)
;

SELECT register_migration_script('941_IDEMPIERE-158.sql') FROM dual
;
