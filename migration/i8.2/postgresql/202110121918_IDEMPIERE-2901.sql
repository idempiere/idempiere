-- IDEMPIERE-2901 Period Control Management
-- Oct 12, 2021, 7:16:44 PM CEST
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,WhereClause,IsDefault,IsDistinct,OrderByClause,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) VALUES (200019,0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:43','YYYY-MM-DD HH24:MI:SS'),100,'Period Control Management','Management of Calendars, Years and Periods',177,'D','c_year y
JOIN c_period p ON (p.c_year_id=y.c_year_id)
JOIN c_periodcontrol pc ON (pc.c_period_id=p.c_period_id)','N','7c79d781-b8d6-484d-b15a-896e1b08087b','y.c_calendar_id=(SELECT ci.c_calendar_id FROM ad_clientinfo ci WHERE ci.ad_client_id=@#AD_Client_ID@)','N','N','y.fiscalyear, p.startdate, p.periodtype, pc.docbasetype','Y',90,'N',0,'Y',0)
;

-- Oct 12, 2021, 7:16:44 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200217,0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:44','YYYY-MM-DD HH24:MI:SS'),100,'Year','The Fiscal Year','The Year identifies the accounting year for a calendar.',200019,'D','y.FiscalYear',10,'Y','Y',3082,10,'88a73213-c230-49fd-8775-0fc795d7f2d3','Y','FiscalYear','=','Y',10,'@SQL=SELECT TO_CHAR(SYSDATE,''yyyy'') FROM DUAL','N','N','Y','N')
;

-- Oct 12, 2021, 7:16:44 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200218,0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:44','YYYY-MM-DD HH24:MI:SS'),100,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200019,'D','p.Name',20,'Y','N',469,10,'9444bad2-1e85-4726-95bb-dc5f18b460be','Y','Name','Like','Upper','Y',0,'N','N','Y','N')
;

-- Oct 12, 2021, 7:16:45 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200219,0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:44','YYYY-MM-DD HH24:MI:SS'),100,'Start Date','First effective day (inclusive)','The Start Date indicates the first or starting date',200019,'D','p.StartDate',40,'Y','N',574,15,'fc45e0cb-710e-40cc-8224-c23f7feb20ba','Y','StartDate','N',0,'N','N','Y','N')
;

-- Oct 12, 2021, 7:16:45 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200220,0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:45','YYYY-MM-DD HH24:MI:SS'),100,'End Date','Last effective date (inclusive)','The End Date indicates the last date in this range.',200019,'D','p.EndDate',50,'Y','N',294,15,'76fb52ab-3919-46ef-9feb-882f82ef1d13','Y','EndDate','N',0,'N','N','Y','N')
;

-- Oct 12, 2021, 7:16:45 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200221,0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:45','YYYY-MM-DD HH24:MI:SS'),100,'Period Type','Period Type','The Period Type indicates the type (Standard or Adjustment) of period.',200019,'D','p.PeriodType',60,'Y','Y',502,17,'c2a7cd92-ef76-4ae9-b811-e46fc1f39b4c',115,'Y','PeriodType','=','N',30,'S','N','N','Y','N')
;

-- Oct 12, 2021, 7:16:46 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200222,0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:45','YYYY-MM-DD HH24:MI:SS'),100,'Document BaseType','Logical type of document','The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.',200019,'D','pc.DocBaseType',70,'Y','N',865,17,'9563a006-ea10-4ee1-87e7-c260c3d900e6',183,'Y','DocBaseType','N',0,'N','N','Y','N')
;

-- Oct 12, 2021, 7:16:46 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200223,0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:46','YYYY-MM-DD HH24:MI:SS'),100,'Period Status','Current state of this period','The Period Status indicates the current status for this period.  For example ''Closed'', ''Open'', ''Never Opened''.',200019,'D','pc.PeriodStatus',80,'Y','Y',501,17,'a9317d39-f149-44d3-b213-44e8a2740d97',177,'Y','PeriodStatus','=','N',40,'N','N','Y','N')
;

-- Oct 12, 2021, 7:16:46 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200224,0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:46','YYYY-MM-DD HH24:MI:SS'),100,'Period No','Unique Period Number','The Period No identifies a specific period for this year. Each period is defined by a start and end date.  Date ranges for a calendar and year cannot overlap.',200019,'D','p.PeriodNo',30,'Y','Y',500,11,'ae57106a-54b6-4d77-a648-0f6c959cbbf2','Y','PeriodNo','=','N',20,'@SQL=SELECT to_number(to_char(SYSDATE, ''mm''), ''999'') FROM dual','N','N','Y','N')
;

-- Oct 12, 2021, 7:16:47 PM CEST
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,EntityType) VALUES (200008,'0c3964ce-c546-4ffe-badc-ea23a2c116fe',0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:46','YYYY-MM-DD HH24:MI:SS'),100,10,167,200019,'B','D')
;

-- Oct 12, 2021, 7:16:47 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU,AD_InfoWindow_ID) VALUES (200196,'Period Control Management','Management of Calendars, Years and Periods','I',0,0,'Y',TO_TIMESTAMP('2021-10-12 19:16:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-10-12 19:16:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','dba4b108-670b-4642-8099-ae9b8db0f221',200019)
;

-- Oct 12, 2021, 7:16:47 PM CEST
INSERT INTO AD_TREENODEMM (AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy,Parent_ID, SeqNo, AD_Tree_ID, Node_ID, AD_TREENODEMM_UU) VALUES(0,0,0,0,164,2,10,200196,'2db416d6-5206-40c5-a4af-1697e64af2d3')
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=2,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200196
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=3,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=105
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=4,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=384
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=5,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=111
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=6,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=106
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=7,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=117
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=8,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=418
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=9,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=102
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=10,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=103
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=11,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=270
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=12,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=121
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=13,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=476
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=14,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=409
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=15,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=151
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=16,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53087
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=17,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=464
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=18,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=124
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=19,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=123
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=20,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=547
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=21,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53189
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=22,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=174
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=23,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=254
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=24,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=120
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=25,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=135
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=26,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=550
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=27,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=551
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=28,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=306
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=29,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53093
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=30,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53091
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=31,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=417
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=32,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=307
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=33,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=393
;

-- Oct 12, 2021, 7:17:41 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=164, SeqNo=34,Updated=TO_TIMESTAMP('2021-10-12 19:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53248
;

-- Oct 12, 2021, 7:37:33 PM CEST
UPDATE AD_InfoProcess SET AD_InfoColumn_ID=NULL,Updated=TO_TIMESTAMP('2021-10-12 19:37:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoProcess_ID=200008
;

-- Oct 13, 2021, 5:31:25 PM CEST
UPDATE AD_InfoColumn SET IsQueryCriteria='Y', QueryOperator='=',Updated=TO_TIMESTAMP('2021-10-13 17:31:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200219
;

-- Oct 13, 2021, 5:31:32 PM CEST
UPDATE AD_InfoColumn SET IsQueryCriteria='Y', QueryOperator='=',Updated=TO_TIMESTAMP('2021-10-13 17:31:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200220
;

-- Oct 13, 2021, 5:36:34 PM CEST
UPDATE AD_InfoColumn SET SeqNoSelection=50,Updated=TO_TIMESTAMP('2021-10-13 17:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200219
;

-- Oct 13, 2021, 5:36:37 PM CEST
UPDATE AD_InfoColumn SET SeqNoSelection=60,Updated=TO_TIMESTAMP('2021-10-13 17:36:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200220
;

-- Oct 13, 2021, 5:37:09 PM CEST
UPDATE AD_InfoColumn SET IsQueryCriteria='Y', QueryOperator='=', SeqNoSelection=70,Updated=TO_TIMESTAMP('2021-10-13 17:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200222
;

-- Oct 13, 2021, 5:56:02 PM CEST
UPDATE AD_InfoWindow SET AD_Table_ID=229, FromClause='C_PeriodControl pc
JOIN C_Period p ON (pc.C_Period_ID=p.C_Period_ID)
JOIN C_Year y ON (p.C_Year_ID=y.C_Year_ID)', WhereClause='y.C_Calendar_ID=(SELECT ci.C_Calendar_ID FROM AD_ClientInfo ci WHERE ci.AD_Client_ID=@#AD_Client_ID@)', OrderByClause='y.FiscalYear, p.StartDate, p.PeriodType, pc.DocBaseType', IsValid='Y',Updated=TO_TIMESTAMP('2021-10-13 17:56:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200019
;

-- Oct 13, 2021, 5:56:29 PM CEST
UPDATE AD_InfoProcess SET AD_InfoColumn_ID=NULL,Updated=TO_TIMESTAMP('2021-10-13 17:56:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoProcess_ID=200008
;

-- Oct 13, 2021, 5:58:51 PM CEST
UPDATE AD_InfoWindow SET PagingSize=50,Updated=TO_TIMESTAMP('2021-10-13 17:58:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200019
;

SELECT register_migration_script('202110121918_IDEMPIERE-2901.sql') FROM dual
;

