-- May 30, 2012 9:45:16 AM CEST
-- IDEMPIERE-255
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200192,469,0,10,522,'Name',TO_TIMESTAMP('2012-05-30 09:45:13','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity','D',60,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','N','N','Y','N','N','Y','Name',0,TO_TIMESTAMP('2012-05-30 09:45:13','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- May 30, 2012 9:45:16 AM CEST
-- IDEMPIERE-255
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200192 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 30, 2012 9:45:22 AM CEST
-- IDEMPIERE-255
ALTER TABLE AD_PrintFormatItem_Trl ADD COLUMN Name VARCHAR(60) DEFAULT NULL 
;

-- May 30, 2012 9:46:11 AM CEST
-- IDEMPIERE-255
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2012-05-30 09:46:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6940
;

-- May 30, 2012 9:46:35 AM CEST
-- IDEMPIERE-255
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200192,200140,0,433,TO_TIMESTAMP('2012-05-30 09:46:34','YYYY-MM-DD HH24:MI:SS'),100,'Alphanumeric identifier of the entity',60,'D','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y','Y','Y','N','N','N','N','N','Name',TO_TIMESTAMP('2012-05-30 09:46:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 30, 2012 9:46:35 AM CEST
-- IDEMPIERE-255
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200140 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 30, 2012 9:46:40 AM CEST
-- IDEMPIERE-255
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200140
;

-- May 30, 2012 9:46:40 AM CEST
-- IDEMPIERE-255
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=5769
;

-- May 30, 2012 9:46:40 AM CEST
-- IDEMPIERE-255
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=6274
;

UPDATE ad_printformatitem_trl 
SET	 NAME = (	SELECT COALESCE(et.name, pf.name) 
				FROM ad_printformatitem pf 
					LEFT JOIN ad_column c ON pf.ad_column_id=c.ad_column_id
                    LEFT JOIN ad_element_trl et ON et.ad_element_id=c.ad_element_id AND et.ad_language=ad_printformatitem_trl.ad_language 
				WHERE pf.ad_printformatitem_id=ad_printformatitem_trl.ad_printformatitem_id);

-- May 30, 2012 12:15:59 PM COT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2012-05-30 12:15:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200192
;

-- May 30, 2012 12:16:02 PM COT
INSERT INTO t_alter_column values('ad_printformatitem_trl','Name','VARCHAR(60)',null,null)
;

-- May 30, 2012 12:16:02 PM COT
INSERT INTO t_alter_column values('ad_printformatitem_trl','Name',null,'NOT NULL',null)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='845_IDEMPIERE-255.sql'
WHERE LastMigrationScriptApplied<'845_IDEMPIERE-255.sql'
   OR LastMigrationScriptApplied IS NULL
;

