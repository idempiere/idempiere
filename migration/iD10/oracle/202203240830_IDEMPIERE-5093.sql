SELECT register_migration_script('202203240830_IDEMPIERE-5093.sql') FROM dual
;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5093 Scheduler cron pattern scheduling is always using server time zone
-- Mar 24, 2022 3:21:34 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,AD_Org_ID,Description,ValidationType,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType) VALUES (200133,'Timestamp With Time Zone','a4c9a3f1-ecbb-4beb-ac16-d1b66279f698','N',0,'Date and time with time zone','D',TO_DATE('2022-03-24 15:27:01','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_DATE('2022-03-24 15:27:01','YYYY-MM-DD HH24:MI:SS'),'D')
;

-- Mar 24, 2022 3:21:34 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,AD_Org_ID,Description,ValidationType,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType) VALUES (200135,'Time Zone','9420d498-a217-4c35-a638-b6fcf462538e','N',0,'Time Zone','D',TO_DATE('2022-03-24 15:21:27','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_DATE('2022-03-24 15:21:27','YYYY-MM-DD HH24:MI:SS'),'D')
;

-- Mar 24, 2022 3:27:34 PM MYT
UPDATE AD_Column SET AD_Reference_ID=200133,Updated=TO_DATE('2022-03-24 15:27:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11264
;

-- Mar 24, 2022 3:27:42 PM MYT
ALTER TABLE AD_Scheduler MODIFY DateLastRun TIMESTAMP WITH TIME ZONE DEFAULT NULL 
;

-- Mar 24, 2022 3:27:59 PM MYT
UPDATE AD_Column SET AD_Reference_ID=200133,Updated=TO_DATE('2022-03-24 15:27:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11257
;

-- Mar 24, 2022 3:28:04 PM MYT
ALTER TABLE AD_Scheduler MODIFY DateNextRun TIMESTAMP WITH TIME ZONE DEFAULT NULL 
;

-- Mar 24, 2022 3:39:53 PM MYT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203049,'TimeZone',TO_DATE('2022-03-24 15:39:47','YYYY-MM-DD HH24:MI:SS'),'Time Zone','Time zone name','Time Zone','90009634-4025-4850-a73e-0cdb0b06994b','Y',TO_DATE('2022-03-24 15:39:47','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Mar 24, 2022 3:41:07 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212855,0,'N',1,'N','N','N',0,'N',60,'N','N','N','Y','17152afe-47ff-4610-8765-aec3a5d56b19',TO_DATE('2022-03-24 15:41:02','YYYY-MM-DD HH24:MI:SS'),'Y','TimeZone','Time zone name','Time Zone','Y','Y',100,100,'N','N',0,0,TO_DATE('2022-03-24 15:41:02','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203049,200135,227)
;

-- Mar 24, 2022 3:41:15 PM MYT
ALTER TABLE AD_ClientInfo ADD TimeZone VARCHAR2(60 CHAR) DEFAULT NULL 
;

-- Mar 24, 2022 3:42:03 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (0,204287,'N',0,'N','N',1020,'Y','N',0,TO_DATE('2022-03-24 15:42:03','YYYY-MM-DD HH24:MI:SS'),'Time zone name','Time Zone','16686d03-b85e-4b58-a0a4-21e99fa4303c','Y','N',100,100,'Y','Y',1020,1,'N',0,TO_DATE('2022-03-24 15:42:03','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',212855,118,'D',169)
;

-- Mar 24, 2022 4:43:42 PM MYT
UPDATE AD_Field SET SeqNo=45,SeqNoGrid=45,Updated=TO_DATE('2022-03-24 16:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204287
;

