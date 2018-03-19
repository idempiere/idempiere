-- Sep 5, 2014 3:42:25 PM COT
-- IDEMPIERE-1901 Deprecate parent composite primary keys - leave management via table index
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Client_ID,AD_Org_ID,EntityType) VALUES (0,'N',0,211762,'Y','N','N',0,'N',1,'N','N','N','Y','f1e7a14f-8ab9-4b2e-9655-95d728ecdc18','Y','IsKey','This column is the key in this table','N','The key column must also be display sequence 0 in the field definition and may be hidden.','Key column','Y',TO_TIMESTAMP('2014-09-05 15:42:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2014-09-05 15:42:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',389,20,200085,0,0,'D')
;

-- Sep 5, 2014 3:42:31 PM COT
ALTER TABLE AD_TableIndex ADD COLUMN IsKey CHAR(1) DEFAULT 'N' CHECK (IsKey IN ('Y','N')) NOT NULL
;

-- Sep 5, 2014 3:42:57 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,AD_Org_ID,Created) VALUES ('N',200096,1,'N','N',140,'Y',203443,'N','The key column must also be display sequence 0 in the field definition and may be hidden.','This column is the key in this table','Key column','606cdea6-8002-4c89-b507-bdeffd5acb2b','Y','N',100,100,TO_TIMESTAMP('2014-09-05 15:42:57','YYYY-MM-DD HH24:MI:SS'),'Y','Y',110,2,0,2,211762,'D',0,TO_TIMESTAMP('2014-09-05 15:42:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 5, 2014 3:43:29 PM COT
UPDATE AD_Field SET SeqNo=90, ColumnSpan=1,Updated=TO_TIMESTAMP('2014-09-05 15:43:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202209
;

-- Sep 5, 2014 3:43:29 PM COT
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=3, ColumnSpan=1,Updated=TO_TIMESTAMP('2014-09-05 15:43:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203443
;

-- Sep 5, 2014 3:43:29 PM COT
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2014-09-05 15:43:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202250
;

-- Sep 5, 2014 3:43:29 PM COT
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2014-09-05 15:43:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202206
;

-- Sep 5, 2014 3:43:29 PM COT
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2014-09-05 15:43:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202210
;

-- Sep 5, 2014 3:43:29 PM COT
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2014-09-05 15:43:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202535
;

-- Sep 5, 2014 3:44:41 PM COT
UPDATE AD_Field SET DisplayLogic='@IsCreateConstraint@=''Y'' & @IsUnique@=''Y''',Updated=TO_TIMESTAMP('2014-09-05 15:44:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203443
;

SELECT register_migration_script('201409051545_IDEMPIERE-1901.sql') FROM dual
;

