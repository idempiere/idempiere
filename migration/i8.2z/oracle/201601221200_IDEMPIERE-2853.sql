-- IDEMPIERE-2853: Panel tab as a factory
-- Jan 22, 2016 11:47:02 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (202974,0,0,'Y',TO_DATE('2016-01-22 11:47:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-01-22 11:47:01','YYYY-MM-DD HH24:MI:SS'),100,'AD_TabType','Tab Type','Defines Tab Type','Tab Type','D','5c68092e-e403-4013-8c0f-ae3f1266d989')
;

-- Jan 22, 2016 11:50:50 AM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200117,'TabTypeList','List of tab type','L',0,0,'Y',TO_DATE('2016-01-22 11:50:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-01-22 11:50:49','YYYY-MM-DD HH24:MI:SS'),100,'D','N','5cc837cc-e950-4a01-8044-4aa6a69d9515')
;

-- Jan 22, 2016 11:51:22 AM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200347,'Form',200117,'FORM',0,0,'Y',TO_DATE('2016-01-22 11:51:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-01-22 11:51:21','YYYY-MM-DD HH24:MI:SS'),100,'D','590c7ccd-4400-4208-aca4-d86e508e0f4d')
;

-- Jan 22, 2016 11:51:36 AM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200348,'Sort',200117,'SORT',0,0,'Y',TO_DATE('2016-01-22 11:51:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-01-22 11:51:36','YYYY-MM-DD HH24:MI:SS'),100,'D','47729861-5eed-4209-8228-7858e0ae7c13')
;

-- Jan 22, 2016 11:52:05 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212616,0,'Tab Type','Defines Tab Type',106,'AD_TabType',40,'N','N','N','N','N',0,'N',17,200117,0,0,'Y',TO_DATE('2016-01-22 11:52:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-01-22 11:52:04','YYYY-MM-DD HH24:MI:SS'),100,202974,'Y','N','D','N','N','N','Y','41054b6a-58eb-427a-9748-a192f20f6efb','Y',0,'N','N')
;

-- Jan 22, 2016 11:52:18 AM IST
ALTER TABLE AD_Tab ADD AD_TabType VARCHAR2(40 CHAR) DEFAULT NULL 
;

-- Jan 22, 2016 11:52:41 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204121,'Tab Type','Defines Tab Type',106,212616,'Y',40,400,'N','N','N','N',0,0,'Y',TO_DATE('2016-01-22 11:52:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-01-22 11:52:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','644e396b-717a-4f99-a0d3-4007862a59c2','Y',330,2)
;

-- Dec 11, 2020, 4:10:34 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204121
;

-- Dec 11, 2020, 4:10:34 PM IST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=124
;

-- Dec 11, 2020, 4:10:34 PM IST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=312
;

-- Dec 11, 2020, 4:10:34 PM IST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202515
;

-- Dec 11, 2020, 4:10:34 PM IST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11997
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=927
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5707
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=928
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206078
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206079
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5709
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5708
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1546
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206373
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57266
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2575
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11265
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=929
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11998
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=271
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11266
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1548
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1550
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1549
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4956
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201811
;

-- Dec 11, 2020, 4:10:35 PM IST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-12-11 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5131
;

CREATE OR REPLACE VIEW AD_TAB_V
(AD_TAB_ID, AD_WINDOW_ID, AD_TABLE_ID, NAME, DESCRIPTION, 
 HELP, SEQNO, ISSINGLEROW, HASTREE, ISINFOTAB, 
 REPLICATIONTYPE, TABLENAME, ACCESSLEVEL, ISSECURITYENABLED, ISDELETEABLE, 
 ISHIGHVOLUME, ISVIEW, HASASSOCIATION, ISTRANSLATIONTAB, ISREADONLY, 
 AD_IMAGE_ID, TABLEVEL, WHERECLAUSE, ORDERBYCLAUSE, COMMITWARNING, 
 READONLYLOGIC, DISPLAYLOGIC, AD_COLUMN_ID, AD_PROCESS_ID, ISSORTTAB, 
 ISINSERTRECORD, ISADVANCEDTAB, AD_COLUMNSORTORDER_ID, AD_COLUMNSORTYESNO_ID, 
 INCLUDED_TAB_ID, PARENT_COLUMN_ID, AD_Tab_UU, AD_Table_UU, TREEDISPLAYEDON,
 MAXQUERYRECORDS, IsAllowAdvancedLookup, IsLookupOnlySelection, AD_TabType)
AS 
SELECT t.AD_Tab_ID, t.AD_Window_ID, t.AD_Table_ID, t.Name, t.Description, 
    t.Help, t.SeqNo, t.IsSingleRow, t.HasTree, t.IsInfoTab, tbl.ReplicationType,
    tbl.TableName, tbl.AccessLevel, tbl.IsSecurityEnabled, tbl.IsDeleteable, 
    tbl.IsHighVolume, tbl.IsView, cast('N' as char) AS HasAssociation, -- compatibility
    t.IsTranslationTab, t.IsReadOnly, t.AD_Image_ID, t.TabLevel, 
    t.WhereClause, t.OrderByClause, t.CommitWarning, t.ReadOnlyLogic, t.DisplayLogic,
    t.AD_Column_ID, t.AD_Process_ID, t.IsSortTab, t.IsInsertRecord, t.IsAdvancedTab,
    t.AD_ColumnSortOrder_ID, t.AD_ColumnSortYesNo_ID, t.Included_Tab_ID, t.Parent_Column_ID,
    t.AD_Tab_UU, tbl.AD_Table_UU, t.TreeDisplayedOn, t.MaxQueryRecords,
    t.IsAllowAdvancedLookup, t.IsLookupOnlySelection, t.AD_TabType
FROM AD_Tab t 
	INNER JOIN AD_Table tbl ON (t.AD_Table_ID = tbl.AD_Table_ID)
WHERE t.IsActive='Y'
  AND tbl.IsActive='Y'
;

CREATE OR REPLACE VIEW AD_TAB_VT
(AD_LANGUAGE, AD_TAB_ID, AD_WINDOW_ID, AD_TABLE_ID, NAME, 
 DESCRIPTION, HELP, SEQNO, ISSINGLEROW, HASTREE, 
 ISINFOTAB, REPLICATIONTYPE, TABLENAME, ACCESSLEVEL, ISSECURITYENABLED, 
 ISDELETEABLE, ISHIGHVOLUME, ISVIEW, HASASSOCIATION, ISTRANSLATIONTAB, 
 ISREADONLY, AD_IMAGE_ID, TABLEVEL, WHERECLAUSE, ORDERBYCLAUSE, 
 COMMITWARNING, READONLYLOGIC, DISPLAYLOGIC, AD_COLUMN_ID, AD_PROCESS_ID, 
 ISSORTTAB, ISINSERTRECORD, ISADVANCEDTAB, AD_COLUMNSORTORDER_ID, AD_COLUMNSORTYESNO_ID, 
 INCLUDED_TAB_ID, PARENT_COLUMN_ID, AD_Tab_UU, AD_Table_UU, TREEDISPLAYEDON,
 MAXQUERYRECORDS, IsAllowAdvancedLookup, IsLookupOnlySelection, AD_TabType)
AS 
SELECT trl.AD_Language, t.AD_Tab_ID, t.AD_Window_ID, t.AD_Table_ID, trl.Name, trl.Description, 
    trl.Help, t.SeqNo, t.IsSingleRow, t.HasTree, t.IsInfoTab, tbl.ReplicationType,
    tbl.TableName, tbl.AccessLevel, tbl.IsSecurityEnabled, tbl.IsDeleteable, 
    tbl.IsHighVolume, tbl.IsView, cast('N' as char) AS HasAssociation, -- compatibility
    t.IsTranslationTab, t.IsReadOnly, t.AD_Image_ID, t.TabLevel, 
    t.WhereClause, t.OrderByClause, trl.CommitWarning, t.ReadOnlyLogic, t.DisplayLogic,
    t.AD_Column_ID, t.AD_Process_ID, t.IsSortTab, t.IsInsertRecord, t.IsAdvancedTab,
    t.AD_ColumnSortOrder_ID, t.AD_ColumnSortYesNo_ID, t.Included_Tab_ID, t.Parent_Column_ID,
    t.AD_Tab_UU, tbl.AD_Table_UU, t.TreeDisplayedOn, t.MaxQueryRecords,
    t.IsAllowAdvancedLookup, t.IsLookupOnlySelection, t.AD_TabType
FROM AD_Tab t 
	INNER JOIN AD_Table tbl ON (t.AD_Table_ID = tbl.AD_Table_ID)
	INNER JOIN AD_Tab_Trl trl ON (t.AD_Tab_ID = trl.AD_Tab_ID)
WHERE t.IsActive='Y'
  AND tbl.IsActive='Y'
;

-- Jan 22, 2016 11:53:09 AM IST
SELECT register_migration_script('201601221200_IDEMPIERE-2853.sql') FROM dual
;