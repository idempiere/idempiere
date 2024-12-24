-- IDEMPIERE-6291
SELECT register_migration_script('202411280613_IDEMPIERE-6291.sql') FROM dual;

-- Nov 28, 2024, 6:13:27 AM WIB
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216923,0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',50010,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2024-11-28 06:13:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-28 06:13:26','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','N','N','Y','a4b5002f-457b-4eb1-8343-f991587dcd3d','Y',0,'N','N','N','N')
;

-- Nov 28, 2024, 6:13:30 AM WIB
ALTER TABLE PA_DashboardContent ADD COLUMN Help VARCHAR(2000) DEFAULT NULL 
;

-- Nov 28, 2024, 6:13:49 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (208546,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',50010,216923,'Y',0,260,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-28 06:13:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-28 06:13:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','398c2367-07eb-451c-8a6f-3ee2ee2a2f11','Y',250,1,1,1,'N','N','N','N','N')
;

-- Nov 28, 2024, 6:14:09 AM WIB
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=1, ColumnSpan=5, NumLines=6,Updated=TO_TIMESTAMP('2024-11-28 06:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208546
;

-- Nov 28, 2024, 6:14:09 AM WIB
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2024-11-28 06:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=51011
;

-- Nov 28, 2024, 6:14:09 AM WIB
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2024-11-28 06:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56486
;

-- Nov 28, 2024, 6:14:09 AM WIB
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2024-11-28 06:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=51012
;

-- Nov 28, 2024, 6:14:09 AM WIB
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2024-11-28 06:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57344
;

-- Nov 28, 2024, 6:14:09 AM WIB
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2024-11-28 06:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=51013
;

-- Nov 28, 2024, 6:14:09 AM WIB
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2024-11-28 06:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200262
;

-- Nov 28, 2024, 6:14:09 AM WIB
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2024-11-28 06:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200261
;

-- Nov 28, 2024, 6:14:09 AM WIB
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2024-11-28 06:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200263
;

-- Nov 28, 2024, 6:14:09 AM WIB
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2024-11-28 06:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202524
;

-- Nov 28, 2024, 6:18:41 AM WIB
UPDATE PA_DashboardContent SET Name='Favorites', Description='User favorites', Help='Set your favorite menu from menu tree panel or drag and drop menu item to favorite dashboard panel. Right click on favorite item to remove. You can organize your favorites by folder.',Updated=TO_TIMESTAMP('2024-11-28 06:18:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=50001
;

-- Nov 28, 2024, 6:19:48 AM WIB
UPDATE PA_DashboardContent SET Help='Show your latest opened document. Drag and drop a recent item to trash bin to remove it.',Updated=TO_TIMESTAMP('2024-11-28 06:19:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=200000
;

