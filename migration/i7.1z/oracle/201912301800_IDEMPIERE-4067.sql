SET SQLBLANKLINES ON
SET DEFINE OFF

-- Adding Over/Under line in Report
-- Oct 16, 2019 2:39:54 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203371,0,0,'Y',TO_DATE('2019-10-16 14:39:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:39:53','YYYY-MM-DD HH24:MI:SS'),100,'OverlineStrokeType','Overline Stroke Type','Overline Stroke Type','D','18f9193c-b4a9-4dc2-ba69-8dcefc4d8e88')
;

-- Oct 16, 2019 2:40:47 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200174,'PA_ReportLine Line Stroke Type','L',0,0,'Y',TO_DATE('2019-10-16 14:40:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:40:46','YYYY-MM-DD HH24:MI:SS'),100,'D','N','a66f38f4-feeb-472f-a561-0f2134214e66')
;

-- Oct 16, 2019 2:41:10 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200477,'Dotted',200174,'DT',0,0,'Y',TO_DATE('2019-10-16 14:41:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:41:10','YYYY-MM-DD HH24:MI:SS'),100,'D','e61955b1-37f0-45ed-8bd3-d7b72f5f730b')
;

-- Oct 16, 2019 2:41:45 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200478,'Dashed',200174,'DS',0,0,'Y',TO_DATE('2019-10-16 14:41:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:41:44','YYYY-MM-DD HH24:MI:SS'),100,'D','035f9d9e-4650-43e8-a0ec-e931e07270d8')
;

-- Oct 16, 2019 2:42:08 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200479,'Double Dotted',200174,'DDT',0,0,'Y',TO_DATE('2019-10-16 14:42:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:42:07','YYYY-MM-DD HH24:MI:SS'),100,'D','011c9ad0-34a9-4bd4-9af3-50615790ffb6')
;

-- Oct 16, 2019 2:42:22 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200480,'Double Dashed',200174,'DDS',0,0,'Y',TO_DATE('2019-10-16 14:42:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:42:22','YYYY-MM-DD HH24:MI:SS'),100,'D','13cd13e4-af78-4252-957e-3b1e45f33497')
;

-- Oct 16, 2019 2:42:38 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200481,'Double Solid',200174,'DSD',0,0,'Y',TO_DATE('2019-10-16 14:42:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:42:37','YYYY-MM-DD HH24:MI:SS'),100,'D','e39cde64-0d54-4cf9-93c1-5068c0e97ee6')
;

-- Oct 16, 2019 2:42:53 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200482,'Solid',200174,'SD',0,0,'Y',TO_DATE('2019-10-16 14:42:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:42:52','YYYY-MM-DD HH24:MI:SS'),100,'D','9e450ade-e54b-46e1-b96f-36c02b3090eb')
;

-- Oct 16, 2019 2:43:26 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214088,0,'Overline Stroke Type',448,'OverlineStrokeType',3,'N','N','N','N','N',0,'N',17,200174,0,0,'Y',TO_DATE('2019-10-16 14:43:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:43:26','YYYY-MM-DD HH24:MI:SS'),100,203371,'Y','N','D','N','N','N','Y','b1529a0e-96a5-43e6-94b6-d78feea8e8c8','Y',0,'N','N')
;

-- Oct 16, 2019 2:43:31 PM IST
ALTER TABLE PA_ReportLine ADD OverlineStrokeType VARCHAR2(3 CHAR) DEFAULT NULL 
;

-- Oct 16, 2019 2:44:08 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203372,0,0,'Y',TO_DATE('2019-10-16 14:44:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:44:08','YYYY-MM-DD HH24:MI:SS'),100,'UnderlineStrokeType','Underline Stroke Type','Underline Stroke Type','D','36e60c3b-2eff-4d58-a530-101b2d060f4a')
;

-- Oct 16, 2019 2:45:23 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214089,0,'Underline Stroke Type',448,'UnderlineStrokeType',3,'N','N','N','N','N',0,'N',17,200174,0,0,'Y',TO_DATE('2019-10-16 14:45:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:45:23','YYYY-MM-DD HH24:MI:SS'),100,203372,'Y','N','D','N','N','N','Y','d3504292-068e-4126-944c-dc3d165019c0','Y',0,'N','N')
;

-- Oct 16, 2019 2:45:39 PM IST
ALTER TABLE PA_ReportLine ADD UnderlineStrokeType VARCHAR2(3 CHAR) DEFAULT NULL 
;

-- Oct 16, 2019 2:48:07 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206214,'Overline Stroke Type',376,214088,'Y',0,200,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-16 14:48:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:48:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','04733ecb-3dc6-4fde-82ab-33434b230ca5','Y',215,1,2,1,'N','N','N')
;

-- Oct 16, 2019 2:48:25 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206215,'Underline Stroke Type',376,214089,'Y',0,210,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-16 14:48:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 14:48:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e5614dd4-9884-4053-99d5-1cb59540e412','Y',225,4,2,1,'N','N','N')
;

-- Added Line Type Blank Line
-- Oct 16, 2019 5:29:02 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200483,'Blank line',241,'B',0,0,'Y',TO_DATE('2019-10-16 17:29:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-16 17:29:01','YYYY-MM-DD HH24:MI:SS'),100,'D','bb000455-9057-4c8a-a656-b0f1074e3fd3')
;

SELECT register_migration_script('201912301800_IDEMPIERE-4067.sql') FROM dual
;

