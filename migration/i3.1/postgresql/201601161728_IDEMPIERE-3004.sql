-- IDEMPIERE-3004: View Column - View Component require SeqNo
-- Jan 25, 2016 5:22:40 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212635,0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200088,'SeqNo','@SQL=SELECT COALESCE(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_ViewColumn WHERE AD_Table_ID=@AD_Table_ID@',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2016-01-25 17:22:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-25 17:22:39','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','N','N','Y','cc51c32b-7c4a-49c8-a9d4-94989260e242','Y',0,'N','N')
;

-- Jan 25, 2016 5:24:53 PM CET
UPDATE AD_Column SET DefaultValue='@SQL=SELECT COALESCE(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_ViewColumn WHERE AD_ViewComponent_ID=@AD_ViewComponent_ID@',Updated=TO_TIMESTAMP('2016-01-25 17:24:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212635
;

-- Jan 25, 2016 5:25:19 PM CET
ALTER TABLE AD_ViewColumn ADD COLUMN SeqNo NUMERIC(10) DEFAULT NULL 
;

-- Jan 25, 2016 5:27:04 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204135,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200099,212635,'Y',22,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-01-25 17:27:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-01-25 17:27:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6f955e38-0d37-4410-b8d2-3034ab5edd4a','Y',90,2)
;

-- Jan 25, 2016 5:27:47 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=4,Updated=TO_TIMESTAMP('2016-01-25 17:27:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204135
;

-- Jan 25, 2016 5:27:48 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2016-01-25 17:27:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202244
;

-- Jan 25, 2016 5:27:48 PM CET
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2016-01-25 17:27:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202248
;

-- Jan 25, 2016 5:28:00 PM CET
UPDATE AD_Field SET SortNo=1.0,Updated=TO_TIMESTAMP('2016-01-25 17:28:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204135
;

-- Jan 25, 2016 5:28:00 PM CET
UPDATE AD_ViewColumn SET SeqNo = 0,Updated=TO_TIMESTAMP('2016-01-25 17:28:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100
;

SELECT register_migration_script('201601161728_IDEMPIERE-3004.sql') FROM dual
;
