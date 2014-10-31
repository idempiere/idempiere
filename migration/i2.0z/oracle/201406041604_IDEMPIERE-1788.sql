SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 4, 2014 9:40:09 PM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (200084,'ParentPreferenceType','D','8412d243-d7da-4064-8784-db1cca37c95e','N','Type of preference WEditor lie on (process, info window, window)','L',0,100,TO_DATE('2014-06-04 21:40:03','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2014-06-04 21:40:03','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jun 4, 2014 9:56:17 PM ICT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,EntityType,AD_Client_ID,AD_Org_ID) VALUES (200188,200084,'Window','d16e365d-8cc1-489e-b909-89054fdf58af','W',TO_DATE('2014-06-04 21:56:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-06-04 21:56:08','YYYY-MM-DD HH24:MI:SS'),100,'Y','D',0,0)
;

-- Jun 4, 2014 9:56:31 PM ICT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,EntityType,AD_Client_ID,AD_Org_ID) VALUES (200189,200084,'Process','a9497c99-06dd-40ab-b866-b37d3fb60bc7','P',TO_DATE('2014-06-04 21:56:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-06-04 21:56:30','YYYY-MM-DD HH24:MI:SS'),100,'Y','U',0,0)
;

-- Jun 4, 2014 9:56:36 PM ICT
UPDATE AD_Ref_List SET EntityType='D',Updated=TO_DATE('2014-06-04 21:56:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200189
;

-- Jun 4, 2014 10:09:25 PM ICT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,'N',0,211276,'N','N','N',0,'N',22,'N','N','N','Y','4b259980-d1cd-4aed-87a0-7aa6787a53ee','Y','AD_Process_ID','Process or Report','The Process field identifies a unique Process or Report in the system.','Process','Y',TO_DATE('2014-06-04 22:09:24','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-06-04 22:09:24','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','ad_process_preference','N',117,19,195)
;

-- Jun 4, 2014 10:09:33 PM ICT
ALTER TABLE AD_Preference ADD AD_Process_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 4, 2014 10:09:33 PM ICT
ALTER TABLE AD_Preference ADD CONSTRAINT ad_process_preference FOREIGN KEY (AD_Process_ID) REFERENCES ad_process(ad_process_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 4, 2014 10:13:04 PM ICT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,Description,PrintName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created,Updated) VALUES ('PreferenceFor',202716,'Preference For','Type of preference, it can window, info window or parameter process','Preference For','71eeaffc-a430-4bca-ad26-8ff04fc0e6ac',0,100,100,'Y',0,'D',TO_DATE('2014-06-04 22:12:53','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-06-04 22:12:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 4, 2014 10:14:15 PM ICT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (0,'N',0,211277,'N','N','N',0,'N',1,'N','N','N','Y','462b65e9-7f17-44dc-879c-771182fa0a3c','Y','PreferenceFor','Type of preference, it can window, info window or parameter process','W','Preference For','Y',TO_DATE('2014-06-04 22:14:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-06-04 22:14:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',202716,17,200084,195)
;

-- Jun 4, 2014 10:14:20 PM ICT
ALTER TABLE AD_Preference ADD PreferenceFor CHAR(1) DEFAULT 'W'
;

-- Jun 4, 2014 10:16:12 PM ICT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,SeqNo,AD_Column_ID,EntityType) VALUES (0,0,201242,'74e5f7d2-2f62-4b48-a1ec-0ef1f85c9a63',TO_DATE('2014-06-04 22:16:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-06-04 22:16:11','YYYY-MM-DD HH24:MI:SS'),100,200141,0,211277,'D')
;

-- Jun 4, 2014 10:16:48 PM ICT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,SeqNo,AD_Column_ID,EntityType) VALUES (0,0,201243,'423ef2ae-1412-470c-857e-949614c5946c',TO_DATE('2014-06-04 22:16:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-06-04 22:16:47','YYYY-MM-DD HH24:MI:SS'),100,200141,0,211276,'D')
;

-- Jun 4, 2014 10:18:27 PM ICT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2014-06-04 22:18:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211277
;

-- Jun 4, 2014 10:18:33 PM ICT
ALTER TABLE AD_Preference MODIFY PreferenceFor CHAR(1) DEFAULT 'W'
;


UPDATE AD_Preference SET preferencefor = 'W'
;


-- Jun 4, 2014 10:18:33 PM ICT
ALTER TABLE AD_Preference MODIFY PreferenceFor NOT NULL
;

-- Jun 4, 2014 10:20:18 PM ICT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES (0,'N',156,0,'N','N',90,'Y',203058,'N','Type of preference, it can window, info window or parameter process','Preference For','792c877f-3415-43e4-8660-a4c0a1f78552','Y','N',100,0,100,TO_DATE('2014-06-04 22:20:17','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,1,'N',0,1,1,'N','N',211277,'D',TO_DATE('2014-06-04 22:20:17','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 4, 2014 10:20:52 PM ICT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES (0,'N',156,0,'N','N',100,'Y',203059,'N','The Process field identifies a unique Process or Report in the system.','Process or Report','Process','407aabeb-f94d-405b-bdaa-6212bd2df853','Y','N',100,0,100,TO_DATE('2014-06-04 22:20:51','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,1,'N',0,1,1,'N','N',211276,'D',TO_DATE('2014-06-04 22:20:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 4, 2014 10:22:09 PM ICT
UPDATE AD_Field SET SeqNo=10,Updated=TO_DATE('2014-06-04 22:22:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=661
;

-- Jun 4, 2014 10:22:09 PM ICT
UPDATE AD_Field SET SeqNo=20,Updated=TO_DATE('2014-06-04 22:22:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=902
;

-- Jun 4, 2014 10:22:09 PM ICT
UPDATE AD_Field SET SeqNo=30, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2014-06-04 22:22:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=663
;

-- Jun 4, 2014 10:22:09 PM ICT
UPDATE AD_Field SET SeqNo=40, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2014-06-04 22:22:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=659
;

-- Jun 4, 2014 10:22:09 PM ICT
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2014-06-04 22:22:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203059
;

-- Jun 4, 2014 10:22:09 PM ICT
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=1, ColumnSpan=2,Updated=TO_DATE('2014-06-04 22:22:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203058
;

-- Jun 4, 2014 10:22:09 PM ICT
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2014-06-04 22:22:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=877
;

-- Jun 4, 2014 10:22:09 PM ICT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2014-06-04 22:22:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=662
;

-- Jun 4, 2014 10:22:09 PM ICT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2014-06-04 22:22:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=658
;
-- Jun 6, 2014 1:19:24 PM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,Description,AD_Window_ID,AD_Window_UU,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,AD_Client_ID,Created) VALUES ('N','Q','Y','N','N',0,0,'D','Dummy','This window if for save preference for process parameter panel and info window in case open from menu (stand alone window)',200054,'25099c88-2b91-4f01-8b21-02ef5de79505',TO_DATE('2014-06-06 13:19:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,0,TO_DATE('2014-06-06 13:19:22','YYYY-MM-DD HH24:MI:SS'))
;
SELECT register_migration_script('201406041604_IDEMPIERE-1788.sql') FROM dual
;
