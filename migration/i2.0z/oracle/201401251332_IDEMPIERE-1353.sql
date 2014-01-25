SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 11, 2013 7:42:21 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,Description,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202610,'eaf54818-43d8-4c85-a7cd-24892ad5740e',0,'TreeDisplayedOn',TO_DATE('2013-09-11 19:42:20','YYYY-MM-DD HH24:MI:SS'),100,'The tree can be displayed on master tab, detail tab or both','D','Y','Tree displayed','Tree displayed',TO_DATE('2013-09-11 19:42:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 11, 2013 7:43:03 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
INSERT INTO AD_Reference (AD_Client_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_UU,Created,CreatedBy,EntityType,IsActive,IsOrderByValue,Name,Updated,UpdatedBy,ValidationType) VALUES (0,0,200074,'859b6bbe-8381-44d4-b3f6-374c17be1b53',TO_DATE('2013-09-11 19:43:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','N','TreeDisplayedOn',TO_DATE('2013-09-11 19:43:02','YYYY-MM-DD HH24:MI:SS'),100,'L')
;

-- Sep 11, 2013 7:43:14 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Org_ID,AD_Ref_List_ID,AD_Ref_List_UU,AD_Reference_ID,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,Value) VALUES (0,0,200158,'4b99f0aa-846d-459e-a361-8df1018ea08b',200074,TO_DATE('2013-09-11 19:43:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Both',TO_DATE('2013-09-11 19:43:13','YYYY-MM-DD HH24:MI:SS'),100,'B')
;

-- Sep 11, 2013 7:43:22 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Org_ID,AD_Ref_List_ID,AD_Ref_List_UU,AD_Reference_ID,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,Value) VALUES (0,0,200159,'0a125aed-6b96-41c2-86c7-6b196830dbcc',200074,TO_DATE('2013-09-11 19:43:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Detail Tab',TO_DATE('2013-09-11 19:43:21','YYYY-MM-DD HH24:MI:SS'),100,'D')
;

-- Sep 11, 2013 7:43:29 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Org_ID,AD_Ref_List_ID,AD_Ref_List_UU,AD_Reference_ID,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,Value) VALUES (0,0,200160,'8b216882-c0c4-47c1-a2a8-d75721082def',200074,TO_DATE('2013-09-11 19:43:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Master Tab',TO_DATE('2013-09-11 19:43:28','YYYY-MM-DD HH24:MI:SS'),100,'M')
;

-- Sep 11, 2013 7:43:49 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210869,'6ee372e3-8199-4d45-b500-1f4f872bc6dd',202610,0,17,200074,106,'TreeDisplayedOn',TO_DATE('2013-09-11 19:43:49','YYYY-MM-DD HH24:MI:SS'),100,'B','The tree can be displayed on master tab, detail tab or both','D',1,'Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','N','N','Y','Tree displayed',0,0,TO_DATE('2013-09-11 19:43:49','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 11, 2013 7:43:53 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
ALTER TABLE AD_Tab ADD TreeDisplayedOn CHAR(1) DEFAULT 'B' NOT NULL
;

-- Sep 11, 2013 7:45:06 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,60551,202514,'b2bf9bc2-5018-434f-bdab-c036ba3a19c3',0,105,2,TO_DATE('2013-09-11 19:45:06','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','AD_Window_UU',170,TO_DATE('2013-09-11 19:45:06','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 11, 2013 7:45:18 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210869,202515,'f1b8cfef-debb-44af-aa67-4854b94e69dc',0,106,2,TO_DATE('2013-09-11 19:45:18','YYYY-MM-DD HH24:MI:SS'),100,'The tree can be displayed on master tab, detail tab or both',1,'D','Y','Y','Y','N','N','N','N','N','Tree displayed',340,TO_DATE('2013-09-11 19:45:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 11, 2013 7:46:09 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
UPDATE AD_Field SET DisplayLogic='@HasTree@=Y',Updated=TO_DATE('2013-09-11 19:46:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202515
;

-- Sep 11, 2013 7:46:16 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=202515
;

-- Sep 11, 2013 7:46:16 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=5131
;

-- Sep 11, 2013 7:46:16 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=3205
;

-- Sep 11, 2013 7:46:23 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=202515
;

-- Sep 11, 2013 7:46:23 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=5131
;

-- Sep 11, 2013 7:46:23 PM CEST
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=3205
;

CREATE OR REPLACE VIEW AD_TAB_V
(AD_TAB_ID, AD_WINDOW_ID, AD_TABLE_ID, NAME, DESCRIPTION, 
 HELP, SEQNO, ISSINGLEROW, HASTREE, ISINFOTAB, 
 REPLICATIONTYPE, TABLENAME, ACCESSLEVEL, ISSECURITYENABLED, ISDELETEABLE, 
 ISHIGHVOLUME, ISVIEW, HASASSOCIATION, ISTRANSLATIONTAB, ISREADONLY, 
 AD_IMAGE_ID, TABLEVEL, WHERECLAUSE, ORDERBYCLAUSE, COMMITWARNING, 
 READONLYLOGIC, DISPLAYLOGIC, AD_COLUMN_ID, AD_PROCESS_ID, ISSORTTAB, 
 ISINSERTRECORD, ISADVANCEDTAB, AD_COLUMNSORTORDER_ID, AD_COLUMNSORTYESNO_ID, 
 INCLUDED_TAB_ID, PARENT_COLUMN_ID, AD_Tab_UU, AD_Table_UU, TREEDISPLAYEDON)
AS 
SELECT t.AD_Tab_ID, t.AD_Window_ID, t.AD_Table_ID, t.Name, t.Description, 
    t.Help, t.SeqNo, t.IsSingleRow, t.HasTree, t.IsInfoTab, tbl.ReplicationType,
    tbl.TableName, tbl.AccessLevel, tbl.IsSecurityEnabled, tbl.IsDeleteable, 
    tbl.IsHighVolume, tbl.IsView, cast('N' as char) AS HasAssociation, -- compatibility
    t.IsTranslationTab, t.IsReadOnly, t.AD_Image_ID, t.TabLevel, 
    t.WhereClause, t.OrderByClause, t.CommitWarning, t.ReadOnlyLogic, t.DisplayLogic,
    t.AD_Column_ID, t.AD_Process_ID, t.IsSortTab, t.IsInsertRecord, t.IsAdvancedTab,
    t.AD_ColumnSortOrder_ID, t.AD_ColumnSortYesNo_ID, t.Included_Tab_ID, t.Parent_Column_ID,
    t.AD_Tab_UU, tbl.AD_Table_UU, t.TreeDisplayedOn
FROM AD_Tab t 
	INNER JOIN AD_Table tbl ON (t.AD_Table_ID = tbl.AD_Table_ID)
WHERE t.IsActive='Y'
  AND tbl.IsActive='Y';



CREATE OR REPLACE VIEW AD_TAB_VT
(AD_LANGUAGE, AD_TAB_ID, AD_WINDOW_ID, AD_TABLE_ID, NAME, 
 DESCRIPTION, HELP, SEQNO, ISSINGLEROW, HASTREE, 
 ISINFOTAB, REPLICATIONTYPE, TABLENAME, ACCESSLEVEL, ISSECURITYENABLED, 
 ISDELETEABLE, ISHIGHVOLUME, ISVIEW, HASASSOCIATION, ISTRANSLATIONTAB, 
 ISREADONLY, AD_IMAGE_ID, TABLEVEL, WHERECLAUSE, ORDERBYCLAUSE, 
 COMMITWARNING, READONLYLOGIC, DISPLAYLOGIC, AD_COLUMN_ID, AD_PROCESS_ID, 
 ISSORTTAB, ISINSERTRECORD, ISADVANCEDTAB, AD_COLUMNSORTORDER_ID, AD_COLUMNSORTYESNO_ID, 
 INCLUDED_TAB_ID, PARENT_COLUMN_ID, AD_Tab_UU, AD_Table_UU, TREEDISPLAYEDON)
AS 
SELECT trl.AD_Language, t.AD_Tab_ID, t.AD_Window_ID, t.AD_Table_ID, trl.Name, trl.Description, 
    trl.Help, t.SeqNo, t.IsSingleRow, t.HasTree, t.IsInfoTab, tbl.ReplicationType,
    tbl.TableName, tbl.AccessLevel, tbl.IsSecurityEnabled, tbl.IsDeleteable, 
    tbl.IsHighVolume, tbl.IsView, cast('N' as char) AS HasAssociation, -- compatibility
    t.IsTranslationTab, t.IsReadOnly, t.AD_Image_ID, t.TabLevel, 
    t.WhereClause, t.OrderByClause, trl.CommitWarning, t.ReadOnlyLogic, t.DisplayLogic,
    t.AD_Column_ID, t.AD_Process_ID, t.IsSortTab, t.IsInsertRecord, t.IsAdvancedTab,
    t.AD_ColumnSortOrder_ID, t.AD_ColumnSortYesNo_ID, t.Included_Tab_ID, t.Parent_Column_ID,
    t.AD_Tab_UU, tbl.AD_Table_UU, t.TreeDisplayedOn
FROM AD_Tab t 
	INNER JOIN AD_Table tbl ON (t.AD_Table_ID = tbl.AD_Table_ID)
	INNER JOIN AD_Tab_Trl trl ON (t.AD_Tab_ID = trl.AD_Tab_ID)
WHERE t.IsActive='Y'
  AND tbl.IsActive='Y';


-- Jan 25, 2014 1:54:55 PM COT
-- IDEMPIERE-1353 Choose to display trees on master, detail or both tabs
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=131
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5824
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=123
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5326
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=110, ColumnSpan=1,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=124
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=120, IsDisplayed='Y', XPosition=3, ColumnSpan=1,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=312
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=130, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202515
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=2, ColumnSpan=1,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11997
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=150, IsDisplayed='Y', XPosition=3, ColumnSpan=1,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=927
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=160, IsDisplayed='Y', XPosition=4, ColumnSpan=1,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5707
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=170, ColumnSpan=1,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=928
;

-- Jan 25, 2014 1:54:55 PM COT
UPDATE AD_Field SET SeqNo=240, ColumnSpan=1,Updated=TO_DATE('2014-01-25 13:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=929
;

-- Jan 25, 2014 1:54:56 PM COT
UPDATE AD_Field SET SeqNo=250, IsDisplayed='Y', XPosition=4, ColumnSpan=1,Updated=TO_DATE('2014-01-25 13:54:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11998
;

-- Jan 25, 2014 1:54:56 PM COT
UPDATE AD_Field SET SeqNo=260, IsDisplayed='Y', XPosition=6, ColumnSpan=1,Updated=TO_DATE('2014-01-25 13:54:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=271
;

-- Jan 25, 2014 1:54:56 PM COT
UPDATE AD_Field SET SeqNo=270,Updated=TO_DATE('2014-01-25 13:54:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11266
;

-- Jan 25, 2014 1:54:56 PM COT
UPDATE AD_Field SET SeqNo=280,Updated=TO_DATE('2014-01-25 13:54:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1548
;

-- Jan 25, 2014 1:54:56 PM COT
UPDATE AD_Field SET SeqNo=290,Updated=TO_DATE('2014-01-25 13:54:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1550
;

-- Jan 25, 2014 1:54:56 PM COT
UPDATE AD_Field SET SeqNo=300,Updated=TO_DATE('2014-01-25 13:54:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1549
;

-- Jan 25, 2014 1:54:56 PM COT
UPDATE AD_Field SET SeqNo=310,Updated=TO_DATE('2014-01-25 13:54:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4956
;

-- Jan 25, 2014 1:54:56 PM COT
UPDATE AD_Field SET SeqNo=320, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2014-01-25 13:54:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201811
;

SELECT register_migration_script('201401251332_IDEMPIERE-1353.sql') FROM dual
;

