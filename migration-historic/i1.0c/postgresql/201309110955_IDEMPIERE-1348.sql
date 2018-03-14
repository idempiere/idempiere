-- Sep 11, 2013 9:47:04 AM COT
-- IDEMPIERE-1348 Cannot translate HTML content on dashboard
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,53295,210868,'N','N','N',0,'N',0,'N',36,'N','N','Y','6ec9f091-1c67-4b1e-8117-10f120939584','Y','HTML','HTML','Y',TO_TIMESTAMP('2013-09-11 09:46:55','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-09-11 09:46:55','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',51005,'N')
;

-- Sep 11, 2013 9:47:07 AM COT
-- IDEMPIERE-1348 Cannot translate HTML content on dashboard
ALTER TABLE PA_DashboardContent_Trl ADD COLUMN HTML TEXT DEFAULT NULL 
;

-- Sep 11, 2013 9:47:22 AM COT
-- IDEMPIERE-1348 Cannot translate HTML content on dashboard
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2013-09-11 09:47:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=51012
;

-- Sep 11, 2013 9:48:56 AM COT
-- IDEMPIERE-1348 Cannot translate HTML content on dashboard
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',53372,36,'N','N',60965,90,'Y',202494,'N','D','PA_DashboardContent_Trl_UU','361b6894-aa95-424e-a371-e6123f14e502','N','N',100,0,TO_TIMESTAMP('2013-09-11 09:48:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-09-11 09:48:48','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Sep 11, 2013 9:48:57 AM COT
-- IDEMPIERE-1348 Cannot translate HTML content on dashboard
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',53372,0,'N','N',210868,100,'Y',202495,'N','D','HTML','ac01ef3e-7eed-49e5-84eb-5b7bdb3d4218','Y','N',100,0,TO_TIMESTAMP('2013-09-11 09:48:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-09-11 09:48:56','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,5)
;

-- Sep 11, 2013 9:49:20 AM COT
-- IDEMPIERE-1348 Cannot translate HTML content on dashboard
UPDATE AD_Field SET SeqNo=90, ColumnSpan=5,Updated=TO_TIMESTAMP('2013-09-11 09:49:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202495
;

-- Sep 11, 2013 9:49:20 AM COT
-- IDEMPIERE-1348 Cannot translate HTML content on dashboard
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2013-09-11 09:49:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202494
;

-- Sep 11, 2013 9:49:36 AM COT
-- IDEMPIERE-1348 Cannot translate HTML content on dashboard
UPDATE AD_Field SET SeqNo=20, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-09-11 09:49:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=60879
;

SELECT register_migration_script('201309110955_IDEMPIERE-1348.sql') FROM dual
;

