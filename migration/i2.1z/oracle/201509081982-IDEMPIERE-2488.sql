SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2488 Info Window run Query twice
-- Aug 9, 2015 11:42:05 PM WITA
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (202897,0,0,'Y',TO_DATE('2015-08-09 23:42:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-09 23:42:05','YYYY-MM-DD HH24:MI:SS'),100,'isLoadPageNum','Load Page Num','When load data for info window, also load number of paging','Load number of paging maybe affect to performance when info window is join of many table','Load Page Num','D','9ac2b88f-7ada-4a37-a458-5900f1cdb71b')
;

-- Aug 9, 2015 11:42:50 PM WITA
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212224,0,'Load Page Num','When load data for info window, also load number of paging','Load number of paging maybe affect to performance when info window is join of many table',895,'isLoadPageNum','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-08-09 23:42:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-09 23:42:50','YYYY-MM-DD HH24:MI:SS'),100,202897,'Y','N','D','N','N','N','Y','fd37da5c-6442-425e-9217-fd186c67ff65','Y',0,'N','N')
;

-- Aug 9, 2015 11:42:55 PM WITA
ALTER TABLE AD_InfoWindow ADD isLoadPageNum CHAR(1) DEFAULT 'Y' CHECK (isLoadPageNum IN ('Y','N'))
;

-- Aug 9, 2015 11:43:33 PM WITA
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203856,'Load Page Num','When load data for info window, also load number of paging','Load number of paging maybe affect to performance when info window is join of many table',842,212224,'Y',0,220,0,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-09 23:43:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-09 23:43:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6cc379fd-0f84-45d8-acf7-12f12ce4c753','Y',130,1,1,1,'N','N','N')
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13581
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201621
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201634
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13579
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13580
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201627
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201628
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, XPosition=5, ColumnSpan=2,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203856
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=190,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201639
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=200,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202198
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=210,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201807
;

-- Aug 9, 2015 11:45:12 PM WITA
UPDATE AD_Field SET SeqNo=220,Updated=TO_DATE('2015-08-09 23:45:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202196
;
UPDATE AD_InfoWindow SET isLoadPageNum = 'Y'
;
SELECT register_migration_script('201509081982-IDEMPIERE-2488.sql') FROM dual
;

