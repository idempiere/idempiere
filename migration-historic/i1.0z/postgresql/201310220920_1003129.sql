-- Oct 22, 2013 4:00:00 PM MYT
-- 1003129 Configure import/export toolbar availability for Bizidium Tenant only
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,Name,Description,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('IsAdvancedButton',202620,'The button with advanced functionality is only displayed for role that can access advanced functionality','Advanced Button','This Button contains advanced Functionality','Advanced Button','cb2580bd-1c17-47ce-a149-4e55176a2424',TO_TIMESTAMP('2013-10-22 15:59:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-10-22 15:59:57','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Oct 22, 2013 4:01:38 PM MYT
-- 1003129 Configure import/export toolbar availability for Bizidium Tenant only
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200003,210880,'Y','N','N',0,'N',1,'N',20,'N','N','Y','5f6b8aa3-5e3c-4a94-9177-1e81fd5dc406','Y','IsAdvancedButton','This Button contains advanced Functionality','N','The button with advanced functionality is only displayed for role that can access advanced functionality','Advanced Button','Y',TO_TIMESTAMP('2013-10-22 16:01:35','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-10-22 16:01:35','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202620,'N')
;

-- Oct 22, 2013 4:02:24 PM MYT
-- 1003129 Configure import/export toolbar availability for Bizidium Tenant only
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,EntityType,IsAdvancedField,IsDefaultFocus) VALUES (0,'N',200002,0,'N','N',210880,100,'Y',202527,'N','The button with advanced functionality is only displayed for role that can access advanced functionality','This Button contains advanced Functionality','Advanced Button','d8129ffc-6856-4651-9480-e25763223f35','Y','N',100,0,TO_TIMESTAMP('2013-10-22 16:02:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-22 16:02:21','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,1,'N',0,2,1,'D','N','N')
;

-- Oct 22, 2013 4:04:30 PM MYT
-- 1003129 Configure import/export toolbar availability for Bizidium Tenant only
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-10-22 16:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202527
;

-- Oct 22, 2013 4:04:30 PM MYT
-- 1003129 Configure import/export toolbar availability for Bizidium Tenant only
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2013-10-22 16:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200053
;

-- Oct 22, 2013 4:04:30 PM MYT
-- 1003129 Configure import/export toolbar availability for Bizidium Tenant only
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2013-10-22 16:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200753
;

-- Oct 22, 2013 4:04:30 PM MYT
-- 1003129 Configure import/export toolbar availability for Bizidium Tenant only
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2013-10-22 16:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200062
;

-- Oct 22, 2013 4:06:03 PM MYT
-- 1003129 Configure import/export toolbar availability for Bizidium Tenant only
ALTER TABLE AD_ToolBarButton ADD COLUMN IsAdvancedButton CHAR(1) DEFAULT 'N' CHECK (IsAdvancedButton IN ('Y','N')) NOT NULL
;

-- Oct 22, 2013 5:01:11 PM MYT
-- 1003129 Configure import/export toolbar availability for Bizidium Tenant only
UPDATE AD_ToolBarButton SET IsAdvancedButton='Y',Updated=TO_TIMESTAMP('2013-10-22 17:01:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200057
;

-- Oct 22, 2013 5:01:23 PM MYT
-- 1003129 Configure import/export toolbar availability for Bizidium Tenant only
UPDATE AD_ToolBarButton SET IsAdvancedButton='Y',Updated=TO_TIMESTAMP('2013-10-22 17:01:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200067
;

SELECT register_migration_script('201310220920_1003129.sql') FROM dual
;

