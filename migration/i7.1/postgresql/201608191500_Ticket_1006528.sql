-- Aug 18, 2016 9:03:49 PM MYT
-- 1006528 Implement Image Storage Provider
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203038,'StorageImage_ID',TO_TIMESTAMP('2016-08-18 21:03:42','YYYY-MM-DD HH24:MI:SS'),'Image Store','Storage provider for Image','Image Store','a4df3881-4d7e-4b3b-a71a-3380bdebf371','Y',TO_TIMESTAMP('2016-08-18 21:03:42','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Aug 18, 2016 9:05:23 PM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (212831,0,'N',0,'N','N','N',0,'N',22,'N','N','N','Y','a3d7a4ea-9d2e-4da6-b48f-7ee5242719ee',TO_TIMESTAMP('2016-08-18 21:05:07','YYYY-MM-DD HH24:MI:SS'),'Y','StorageImage_ID','Storage provider for Image','Image Store','Y','Y',100,100,'N','N',0,0,TO_TIMESTAMP('2016-08-18 21:05:07','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203038,18,200023,227)
;

-- Aug 18, 2016 9:05:59 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='StorageImage_ADClientInfo',Updated=TO_TIMESTAMP('2016-08-18 21:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212831
;

-- Aug 18, 2016 9:05:59 PM MYT
ALTER TABLE AD_ClientInfo ADD COLUMN StorageImage_ID NUMERIC(10) DEFAULT NULL 
;

-- Aug 18, 2016 9:06:00 PM MYT
ALTER TABLE AD_ClientInfo ADD CONSTRAINT StorageImage_ADClientInfo FOREIGN KEY (StorageImage_ID) REFERENCES ad_storageprovider(ad_storageprovider_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 18, 2016 9:07:51 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,204272,'N',0,'N','N',1020,'Y','N',0,TO_TIMESTAMP('2016-08-18 21:07:45','YYYY-MM-DD HH24:MI:SS'),'Storage provider for Image','Image Store','471cc623-0460-4b6a-8e24-74055858ce8a','Y','N',100,100,'Y','Y',1020,1,'N',0,TO_TIMESTAMP('2016-08-18 21:07:45','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',212831,'D',169)
;

-- Aug 18, 2016 9:08:51 PM MYT
UPDATE AD_Field SET SeqNo=120, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2016-08-18 21:08:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204272
;

-- Aug 18, 2016 9:08:51 PM MYT
UPDATE AD_Field SET SeqNo=125,Updated=TO_TIMESTAMP('2016-08-18 21:08:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202532
;

-- Aug 18, 2016 9:08:51 PM MYT
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2016-08-18 21:08:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202533
;

SELECT register_migration_script('201608191500_Ticket_1006528.sql') FROM dual
;

