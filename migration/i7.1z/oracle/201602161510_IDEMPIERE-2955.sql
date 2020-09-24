SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2955 Adding Attribute set type field (M_AttributeSet_Type), support DMS/MM
-- Dec 2, 2015 11:53:13 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202952,0,0,'Y',TO_DATE('2015-12-02 11:53:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-12-02 11:53:12','YYYY-MM-DD HH24:MI:SS'),100,'M_AttributeSet_Type','AttributeSet Type','AttributeSet Type','D','7b193413-66ff-4a9b-a4e3-73cacc8d413d')
;

-- Dec 2, 2015 11:53:49 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,DefaultValue) VALUES (212554,0,'AttributeSet Type',560,'M_AttributeSet_Type',3,'N','N','Y','N','N',0,'N',17,0,0,'Y',TO_DATE('2015-12-02 11:53:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-12-02 11:53:44','YYYY-MM-DD HH24:MI:SS'),100,202952,'Y','N','D','N','N','N','Y','b0f70177-747f-4e25-9d88-df4111f43712','Y',0,'N','N','MMS')
;

-- Dec 2, 2015 11:54:23 AM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200115,'AttributeSet Type','L',0,0,'Y',TO_DATE('2015-12-02 11:54:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-12-02 11:54:22','YYYY-MM-DD HH24:MI:SS'),100,'D','N','dc52c0cb-adec-4c9e-a176-29ca09f0072e')
;

-- Dec 2, 2015 11:56:12 AM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200344,'Material Management System',200115,'MMS',0,0,'Y',TO_DATE('2015-12-02 11:56:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-12-02 11:56:10','YYYY-MM-DD HH24:MI:SS'),100,'D','4455f892-2ea1-499d-a0b9-c01b3226f97d')
;

-- Dec 2, 2015 11:56:29 AM IST
UPDATE AD_Column SET AD_Reference_Value_ID=200115,Updated=TO_DATE('2015-12-02 11:56:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212554
;

-- Dec 2, 2015 11:56:42 AM IST
ALTER TABLE M_AttributeSet ADD M_AttributeSet_Type VARCHAR2(3 CHAR) DEFAULT 'MMS' 
;

-- Dec 2, 2015 12:01:46 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204081,'AttributeSet Type',461,212554,'Y',0,220,0,'N','N','N','N',0,0,'Y',TO_DATE('2015-12-02 12:01:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-12-02 12:01:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','caa0a379-b7c5-4485-ba5b-5d4bff21d144','Y',210,1,1,1,'N','N','N')
;

-- Dec 2, 2015 12:03:35 PM IST
UPDATE AD_Field SET SeqNo=220, ColumnSpan=2,Updated=TO_DATE('2015-12-02 12:03:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204081
;

-- Mar 10, 2016 8:08:28 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200093,'AttributeSetMMS','Get MMS type AttributeSet','S','M_AttributeSet_Type=''MMS''',0,0,'Y',TO_DATE('2016-03-10 20:08:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-10 20:08:27','YYYY-MM-DD HH24:MI:SS'),100,'D','1dc169ec-e8ac-4d7a-91d4-fa7789170cf1')
;

-- Mar 10, 2016 8:35:47 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200093,Updated=TO_DATE('2016-03-10 20:35:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8417
;

-- Sep 14, 2020, 6:30:08 PM IST
UPDATE AD_InfoColumn SET AD_Val_Rule_ID=200093, SeqNoSelection=10,Updated=TO_DATE('2020-09-14 18:30:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200007
;

SELECT register_migration_script('201602161510_IDEMPIERE-2955.sql') FROM dual
;