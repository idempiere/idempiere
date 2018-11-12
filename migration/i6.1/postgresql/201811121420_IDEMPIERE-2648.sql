-- IDEMPIERE-2648 implement pack-in pack-out handle for infoWindow
-- Nov 12, 2018, 2:11:41 PM BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213804,0,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',50006,'AD_InfoWindow_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2018-11-12 14:11:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-11-12 14:11:40','YYYY-MM-DD HH24:MI:SS'),100,3068,'N','N','D','N','N','N','Y','6b52cd03-c9ae-4b0e-b24f-45323a7ed42d','Y',0,'N','N','C')
;

-- Nov 12, 2018, 2:12:32 PM BRST
UPDATE AD_Column SET FKConstraintType='N',Updated=TO_TIMESTAMP('2018-11-12 14:12:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213804
;

-- Nov 12, 2018, 2:12:35 PM BRST
UPDATE AD_Column SET FKConstraintName='ADInfoWindow_ADPackageExpDetai', FKConstraintType='N',Updated=TO_TIMESTAMP('2018-11-12 14:12:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213804
;

-- Nov 12, 2018, 2:12:35 PM BRST
ALTER TABLE AD_Package_Exp_Detail ADD COLUMN AD_InfoWindow_ID NUMERIC(10) DEFAULT NULL 
;

-- Nov 12, 2018, 2:12:35 PM BRST
ALTER TABLE AD_Package_Exp_Detail ADD CONSTRAINT ADInfoWindow_ADPackageExpDetai FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 12, 2018, 2:14:03 PM BRST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200445,'Info Window',50004,'IW',0,0,'Y',TO_TIMESTAMP('2018-11-12 14:14:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-11-12 14:14:02','YYYY-MM-DD HH24:MI:SS'),100,'D','c1e5ee93-987c-43cd-90e9-e4cf5d592105')
;

-- Nov 12, 2018, 2:15:14 PM BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205861,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',50006,213804,'Y',10,330,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-11-12 14:15:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-11-12 14:15:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9cbe0104-e976-411a-9aa3-d35798c57519','Y',330,2)
;

-- Nov 12, 2018, 2:15:57 PM BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-11-12 14:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53284
;

-- Nov 12, 2018, 2:15:57 PM BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-11-12 14:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57418
;

-- Nov 12, 2018, 2:15:57 PM BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-11-12 14:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205861
;

-- Nov 12, 2018, 2:15:57 PM BRST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-11-12 14:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50116
;

-- Nov 12, 2018, 2:15:57 PM BRST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-11-12 14:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50117
;

-- Nov 12, 2018, 2:15:57 PM BRST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-11-12 14:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204547
;

-- Nov 12, 2018, 2:16:29 PM BRST
UPDATE AD_Field SET DisplayLogic='@Type@=''IW''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-11-12 14:16:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205861
;

-- Nov 12, 2018 2:49:09 PM BRST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2018-11-12 14:49:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213804
;

SELECT register_migration_script('201811121420_IDEMPIERE-2648.sql') FROM dual
;

