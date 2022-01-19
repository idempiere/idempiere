SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3044
-- Jan 19, 2022, 9:57:24 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214663,0,'High Volume','Use Search instead of Pick list','The High Volume Checkbox indicates if a search screen will display as opposed to a pick list for selecting records from this table.',106,'IsHighVolume',1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_DATE('2022-01-19 09:57:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-01-19 09:57:23','YYYY-MM-DD HH24:MI:SS'),100,1174,'Y','N','D','N','N','N','Y','34772251-6e73-4b56-859f-d6280c772a00','Y',0,'N','N','N')
;

-- Jan 19, 2022, 9:57:31 AM CET
ALTER TABLE AD_Tab ADD IsHighVolume CHAR(1) DEFAULT NULL 
;

-- Jan 19, 2022, 9:57:50 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206835,'High Volume','Use Search instead of Pick list','The High Volume Checkbox indicates if a search screen will display as opposed to a pick list for selecting records from this table.',106,214663,'Y',1,400,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-19 09:57:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-01-19 09:57:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','84611521-27c9-4787-9257-a00e4d811406','Y',350,2)
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=928
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206078
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206079
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5709
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5708
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1546
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206373
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57266
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2575
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206835
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3205
;

-- Jan 19, 2022, 9:58:08 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5707
;

-- Jan 19, 2022, 9:58:34 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214664,0,'High Volume','Use Search instead of Pick list','The High Volume Checkbox indicates if a search screen will display as opposed to a pick list for selecting records from this table.',466,'IsHighVolume',1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_DATE('2022-01-19 09:58:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-01-19 09:58:34','YYYY-MM-DD HH24:MI:SS'),100,1174,'Y','N','D','N','N','N','Y','89512430-8e54-4603-b14c-7f68a657635c','Y',0,'N','N','N','N')
;

-- Jan 19, 2022, 9:58:37 AM CET
ALTER TABLE AD_UserDef_Tab ADD IsHighVolume CHAR(1) DEFAULT NULL 
;

-- Jan 19, 2022, 9:58:48 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206836,'High Volume','Use Search instead of Pick list','The High Volume Checkbox indicates if a search screen will display as opposed to a pick list for selecting records from this table.',394,214664,'Y',1,180,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-19 09:58:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-01-19 09:58:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','83dbfadc-d288-4d10-809f-5bee556d9913','Y',180,2)
;

-- Jan 19, 2022, 9:59:00 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206836
;

-- Jan 19, 2022, 9:59:00 AM CET
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5039
;

-- Jan 19, 2022, 9:59:00 AM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5040
;

-- Jan 19, 2022, 9:59:00 AM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206313
;

-- Jan 19, 2022, 9:59:00 AM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206314
;

-- Jan 19, 2022, 9:59:00 AM CET
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205833
;

-- Jan 19, 2022, 9:59:00 AM CET
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200003
;

-- Jan 19, 2022, 9:59:00 AM CET
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205828
;

-- Jan 19, 2022, 9:59:00 AM CET
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-19 09:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205830
;

-- Jan 19, 2022, 10:03:58 AM CET
UPDATE AD_ViewColumn SET ColumnSQL='COALESCE(t.IsHighVolume, tbl.IsHighVolume)',Updated=TO_DATE('2022-01-19 10:03:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=200391
;

-- Jan 19, 2022, 10:04:03 AM CET
CREATE OR REPLACE VIEW AD_Tab_v(AD_Tab_ID, AD_Window_ID, AD_Table_ID, Name, Description, Help, SeqNo, IsSingleRow, HasTree, IsInfoTab, ReplicationType, TableName, AccessLevel, IsSecurityEnabled, IsDeleteable, IsHighVolume, IsView, hasassociation, IsTranslationTab, IsReadOnly, AD_Image_ID, TabLevel, WhereClause, OrderByClause, CommitWarning, ReadOnlyLogic, DisplayLogic, AD_Column_ID, AD_Process_ID, IsSortTab, IsInsertRecord, IsAdvancedTab, AD_ColumnSortOrder_ID, AD_ColumnSortYesNo_ID, Included_Tab_ID, Parent_Column_ID, AD_Tab_UU, AD_Table_UU, TreeDisplayedOn, MaxQueryRecords, IsAllowAdvancedLookup, IsLookupOnlySelection, AD_TabType) AS SELECT t.ad_tab_id AS AD_Tab_ID, t.ad_window_id AS AD_Window_ID, t.ad_table_id AS AD_Table_ID, t.name AS Name, t.description AS Description, t.help AS Help, t.seqno AS SeqNo, t.issinglerow AS IsSingleRow, t.hastree AS HasTree, t.isinfotab AS IsInfoTab, tbl.replicationtype AS ReplicationType, tbl.tablename AS TableName, tbl.accesslevel AS AccessLevel, tbl.issecurityenabled AS IsSecurityEnabled, tbl.isdeleteable AS IsDeleteable, COALESCE(t.IsHighVolume, tbl.IsHighVolume) AS IsHighVolume, tbl.isview AS IsView, CAST('N' AS char(1)) AS hasassociation, t.istranslationtab AS IsTranslationTab, t.isreadonly AS IsReadOnly, t.ad_image_id AS AD_Image_ID, t.tablevel AS TabLevel, t.whereclause AS WhereClause, t.orderbyclause AS OrderByClause, t.commitwarning AS CommitWarning, t.readonlylogic AS ReadOnlyLogic, t.displaylogic AS DisplayLogic, t.ad_column_id AS AD_Column_ID, t.ad_process_id AS AD_Process_ID, t.issorttab AS IsSortTab, t.isinsertrecord AS IsInsertRecord, t.isadvancedtab AS IsAdvancedTab, t.ad_columnsortorder_id AS AD_ColumnSortOrder_ID, t.ad_columnsortyesno_id AS AD_ColumnSortYesNo_ID, t.included_tab_id AS Included_Tab_ID, t.parent_column_id AS Parent_Column_ID, t.ad_tab_uu AS AD_Tab_UU, tbl.ad_table_uu AS AD_Table_UU, t.treedisplayedon AS TreeDisplayedOn, t.maxqueryrecords AS MaxQueryRecords, t.isallowadvancedlookup AS IsAllowAdvancedLookup, t.islookuponlyselection AS IsLookupOnlySelection, t.ad_tabtype AS AD_TabType FROM ad_tab t
JOIN ad_table tbl ON t.ad_table_id = tbl.ad_table_id WHERE t.isactive = 'Y' AND tbl.isactive = 'Y'
;

-- Jan 19, 2022, 10:04:23 AM CET
UPDATE AD_ViewColumn SET ColumnSQL='COALESCE(t.IsHighVolume, tbl.IsHighVolume)',Updated=TO_DATE('2022-01-19 10:04:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=200435
;

-- Jan 19, 2022, 10:04:27 AM CET
CREATE OR REPLACE VIEW AD_Tab_vt(AD_Language, AD_Tab_ID, AD_Window_ID, AD_Table_ID, Name, Description, Help, SeqNo, IsSingleRow, HasTree, IsInfoTab, ReplicationType, TableName, AccessLevel, IsSecurityEnabled, IsDeleteable, IsHighVolume, IsView, hasassociation, IsTranslationTab, IsReadOnly, AD_Image_ID, TabLevel, WhereClause, OrderByClause, CommitWarning, ReadOnlyLogic, DisplayLogic, AD_Column_ID, AD_Process_ID, IsSortTab, IsInsertRecord, IsAdvancedTab, AD_ColumnSortOrder_ID, AD_ColumnSortYesNo_ID, Included_Tab_ID, Parent_Column_ID, AD_Tab_UU, AD_Table_UU, TreeDisplayedOn, MaxQueryRecords, IsAllowAdvancedLookup, IsLookupOnlySelection, AD_TabType) AS SELECT trl.ad_language AS AD_Language, t.ad_tab_id AS AD_Tab_ID, t.ad_window_id AS AD_Window_ID, t.ad_table_id AS AD_Table_ID, trl.name AS Name, trl.description AS Description, trl.help AS Help, t.seqno AS SeqNo, t.issinglerow AS IsSingleRow, t.hastree AS HasTree, t.isinfotab AS IsInfoTab, tbl.replicationtype AS ReplicationType, tbl.tablename AS TableName, tbl.accesslevel AS AccessLevel, tbl.issecurityenabled AS IsSecurityEnabled, tbl.isdeleteable AS IsDeleteable, COALESCE(t.IsHighVolume, tbl.IsHighVolume) AS IsHighVolume, tbl.isview AS IsView, CAST('N' AS char(1)) AS hasassociation, t.istranslationtab AS IsTranslationTab, t.isreadonly AS IsReadOnly, t.ad_image_id AS AD_Image_ID, t.tablevel AS TabLevel, t.whereclause AS WhereClause, t.orderbyclause AS OrderByClause, trl.commitwarning AS CommitWarning, t.readonlylogic AS ReadOnlyLogic, t.displaylogic AS DisplayLogic, t.ad_column_id AS AD_Column_ID, t.ad_process_id AS AD_Process_ID, t.issorttab AS IsSortTab, t.isinsertrecord AS IsInsertRecord, t.isadvancedtab AS IsAdvancedTab, t.ad_columnsortorder_id AS AD_ColumnSortOrder_ID, t.ad_columnsortyesno_id AS AD_ColumnSortYesNo_ID, t.included_tab_id AS Included_Tab_ID, t.parent_column_id AS Parent_Column_ID, t.ad_tab_uu AS AD_Tab_UU, tbl.ad_table_uu AS AD_Table_UU, t.treedisplayedon AS TreeDisplayedOn, t.maxqueryrecords AS MaxQueryRecords, t.isallowadvancedlookup AS IsAllowAdvancedLookup, t.islookuponlyselection AS IsLookupOnlySelection, t.ad_tabtype AS AD_TabType FROM ad_tab t
JOIN ad_table tbl ON t.ad_table_id = tbl.ad_table_id
JOIN ad_tab_trl trl ON t.ad_tab_id = trl.ad_tab_id WHERE t.isactive = 'Y' AND tbl.isactive = 'Y'
;

SELECT register_migration_script('202201191000_IDEMPIERE-3044.sql') FROM dual
;
