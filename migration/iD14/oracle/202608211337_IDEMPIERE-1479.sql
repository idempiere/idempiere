-- IDEMPIERE-1479 Add the default-deny AD_Role.IsShowChangeLog flag and preserve visibility for roles with PreferenceType='C'
SELECT register_migration_script('202608211337_IDEMPIERE-1479.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 21, 2026, 1:37:44 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (204120,0,0,'Y',TO_TIMESTAMP('2026-08-21 13:37:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-21 13:37:43','YYYY-MM-DD HH24:MI:SS'),100,'IsShowChangeLog','Show Change Log','Allow users with this role to view change log information','Show Change Log','D','01a0241c-d4fe-77c4-a831-06d5f85b8496')
;

-- Aug 21, 2026, 1:41:59 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217654,0,'Show Change Log','Allow users with this role to view change log information',156,'IsShowChangeLog','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-08-21 13:41:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-21 13:41:59','YYYY-MM-DD HH24:MI:SS'),100,204120,'Y','N','D','N','N','N','Y','01a02420-b927-708e-89fd-23787c4774d3','Y',0,'N','N','N','N')
;

-- Aug 21, 2026, 1:42:26 PM CEST
ALTER TABLE AD_Role ADD IsShowChangeLog CHAR(1) DEFAULT 'N' CHECK (IsShowChangeLog IN ('Y','N')) NOT NULL
;

-- Preserve the existing change log visibility for client preference roles
UPDATE AD_Role SET IsShowChangeLog='Y' WHERE PreferenceType='C'
;

-- Aug 21, 2026, 1:43:37 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209239,'Show Change Log','Allow users with this role to view change log information',119,217654,'Y',1,450,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-08-21 13:43:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-21 13:43:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a02422-3754-7ba3-a254-7e7764bb81a1','Y',470,2,2)
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200071
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11002
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=930
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=931
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59591
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59592
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10126
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205947
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11003
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5227
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202366
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10813
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11257
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8312
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8310
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8313
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8314
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206904
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8311
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11006
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=280, XPosition=2, ColumnSpan=1,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209239
;

-- Aug 21, 2026, 1:47:54 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-08-21 13:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200411
;

-- Aug 21, 2026, 1:49:32 PM CEST
UPDATE AD_Element SET Help='Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference.',Updated=TO_TIMESTAMP('2026-08-21 13:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2656
;

-- Aug 21, 2026, 1:49:32 PM CEST
UPDATE AD_Column SET ColumnName='PreferenceType', Name='Preference Level', Description='Determines what preferences the user can set', Help='Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference.', Placeholder=NULL WHERE AD_Element_ID=2656
;

-- Aug 21, 2026, 1:49:32 PM CEST
UPDATE AD_Process_Para SET ColumnName='PreferenceType', Name='Preference Level', Description='Determines what preferences the user can set', Help='Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference.', AD_Element_ID=2656 WHERE UPPER(ColumnName)='PREFERENCETYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 21, 2026, 1:49:32 PM CEST
UPDATE AD_Process_Para SET ColumnName='PreferenceType', Name='Preference Level', Description='Determines what preferences the user can set', Help='Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference.', Placeholder=NULL WHERE AD_Element_ID=2656 AND IsCentrallyMaintained='Y'
;

-- Aug 21, 2026, 1:49:32 PM CEST
UPDATE AD_InfoColumn SET ColumnName='PreferenceType', Name='Preference Level', Description='Determines what preferences the user can set', Help='Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference.', Placeholder=NULL WHERE AD_Element_ID=2656 AND IsCentrallyMaintained='Y'
;

-- Aug 21, 2026, 1:49:32 PM CEST
UPDATE AD_Field SET Name='Preference Level', Description='Determines what preferences the user can set', Help='Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2656) AND IsCentrallyMaintained='Y'
;
