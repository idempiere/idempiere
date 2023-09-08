-- IDEMPIERE-3989
SELECT register_migration_script('202309061939_IDEMPIERE-3989.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 6, 2023, 7:39:15 PM BRT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (nextidfunc(50009,'N'),0,0,TO_TIMESTAMP('2023-09-06 19:39:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-09-06 19:39:15','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DISPLAY_ENTITYTYPE_INFORMATION','Y','''If "Y" then shows information about dictionary element on Field Record Info, Help Window and Help Panel','D','C','0c288cd2-462f-4fb2-9e95-a44f8ceca92d')
;

-- Sep 6, 2023, 7:41:12 PM BRT
CREATE OR REPLACE VIEW AD_Tab_vt(AD_Language, AD_Tab_ID, AD_Window_ID, AD_Table_ID, Name, Description, Help, SeqNo, IsSingleRow, HasTree, IsInfoTab, ReplicationType, TableName, AccessLevel, IsSecurityEnabled, IsDeleteable, IsHighVolume, IsView, hasassociation, IsTranslationTab, IsReadOnly, AD_Image_ID, TabLevel, WhereClause, OrderByClause, CommitWarning, ReadOnlyLogic, DisplayLogic, AD_Column_ID, AD_Process_ID, IsSortTab, IsInsertRecord, IsAdvancedTab, AD_ColumnSortOrder_ID, AD_ColumnSortYesNo_ID, Included_Tab_ID, Parent_Column_ID, AD_Tab_UU, AD_Table_UU, TreeDisplayedOn, MaxQueryRecords, IsAllowAdvancedLookup, IsLookupOnlySelection, AD_TabType, entitytype) AS SELECT trl.ad_language AS AD_Language, t.ad_tab_id AS AD_Tab_ID, t.ad_window_id AS AD_Window_ID, t.ad_table_id AS AD_Table_ID, trl.name AS Name, trl.description AS Description, trl.help AS Help, t.seqno AS SeqNo, t.issinglerow AS IsSingleRow, t.hastree AS HasTree, t.isinfotab AS IsInfoTab, tbl.replicationtype AS ReplicationType, tbl.tablename AS TableName, tbl.accesslevel AS AccessLevel, tbl.issecurityenabled AS IsSecurityEnabled, tbl.isdeleteable AS IsDeleteable, COALESCE(t.IsHighVolume, tbl.IsHighVolume) AS IsHighVolume, tbl.isview AS IsView, CAST('N' AS char(1)) AS hasassociation, t.istranslationtab AS IsTranslationTab, t.isreadonly AS IsReadOnly, t.ad_image_id AS AD_Image_ID, t.tablevel AS TabLevel, t.whereclause AS WhereClause, t.orderbyclause AS OrderByClause, trl.commitwarning AS CommitWarning, t.readonlylogic AS ReadOnlyLogic, t.displaylogic AS DisplayLogic, t.ad_column_id AS AD_Column_ID, t.ad_process_id AS AD_Process_ID, t.issorttab AS IsSortTab, t.isinsertrecord AS IsInsertRecord, t.isadvancedtab AS IsAdvancedTab, t.ad_columnsortorder_id AS AD_ColumnSortOrder_ID, t.ad_columnsortyesno_id AS AD_ColumnSortYesNo_ID, t.included_tab_id AS Included_Tab_ID, t.parent_column_id AS Parent_Column_ID, t.ad_tab_uu AS AD_Tab_UU, tbl.ad_table_uu AS AD_Table_UU, t.treedisplayedon AS TreeDisplayedOn, t.maxqueryrecords AS MaxQueryRecords, t.isallowadvancedlookup AS IsAllowAdvancedLookup, t.islookuponlyselection AS IsLookupOnlySelection, t.ad_tabtype AS AD_TabType, t.entitytype AS entitytype FROM ad_tab t
JOIN ad_table tbl ON t.ad_table_id = tbl.ad_table_id
JOIN ad_tab_trl trl ON t.ad_tab_id = trl.ad_tab_id WHERE t.isactive = 'Y' AND tbl.isactive = 'Y'
;

