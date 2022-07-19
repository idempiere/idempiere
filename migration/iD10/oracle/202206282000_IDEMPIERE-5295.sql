-- IDEMPIERE-5295 Trial Balance Report creates wrong Opening Balance
SELECT register_migration_script('202206282000_IDEMPIERE-5295.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 28, 2022, 7:52:14 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203609,0,0,'Y',TO_TIMESTAMP('2022-06-28 19:46:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-28 19:46:33','YYYY-MM-DD HH24:MI:SS'),100,'IsGroupByOrg','Group by Organization','Grouping based on Organization','An Organization wise grouping apply','Group by Organization','D','252461a9-046f-4c0a-baf8-105a21621ff7')
;

-- Jun 28, 2022, 7:53:01 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200386,0,0,'Y',TO_TIMESTAMP('2022-06-28 19:53:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-28 19:53:00','YYYY-MM-DD HH24:MI:SS'),100,'Group by Organization','Grouping based on Organization','An Organization wise grouping apply',310,140,20,'N',1,'N','N','IsGroupByOrg','Y','D',203609,'8791be5a-2921-4ed3-8bd5-e0f793af0543','N','N')
;

ALTER TABLE t_trialbalance 
DROP CONSTRAINT t_trialbalance_key
;

DROP INDEX T_TRIALBALANCE_KEY
;
 
ALTER TABLE t_trialbalance
ADD CONSTRAINT t_trialbalance_pkey PRIMARY KEY (AD_PInstance_ID, Fact_Acct_ID, Account_ID, AD_Org_ID)
;


-- Jun 30, 2022, 2:08:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214972,0,'Level no',753,'LevelNo','0',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2022-06-30 14:08:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-30 14:08:22','YYYY-MM-DD HH24:MI:SS'),100,1982,'Y','N','D','N','N','N','Y','f31683a0-bf6f-4294-ac14-23e77c01d2a0','Y',0,'N','N','N')
;

-- Jun 30, 2022, 2:32:27 PM IST
ALTER TABLE T_TrialBalance ADD LevelNo NUMBER(10) DEFAULT 0
;

-- Jun 30, 2022, 2:10:01 PM IST
INSERT INTO AD_PrintFormat (Updated,CreatedBy,IsTableBased,IsActive,IsStandardHeaderFooter,AD_PrintFont_ID,AD_Table_ID,IsForm,HeaderMargin,UpdatedBy,AD_PrintColor_ID,Created,Name,CreateCopy,FooterMargin,AD_Client_ID,AD_PrintPaper_ID,AD_Org_ID,AD_PrintFormat_ID,AD_PrintTableFormat_ID,IsDefault,AD_PrintFormat_UU,IsBreakPagePerRecord) VALUES (TO_TIMESTAMP('2022-06-30 14:10:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','Y',130,753,'N',0,100,100,TO_TIMESTAMP('2022-06-30 14:10:00','YYYY-MM-DD HH24:MI:SS'),'Trial Balance Report','N',0,0,100,0,200014,100,'N','3b4700d6-f9d2-4226-abcf-104a4d0f7d47','N')
;

-- Jun 30, 2022, 2:10:19 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (1,'Account',TO_TIMESTAMP('2022-06-30 14:10:18','YYYY-MM-DD HH24:MI:SS'),'N',0,'Account',0,0,12996,'N','Y',100,0,200310,100,'N',0,TO_TIMESTAMP('2022-06-30 14:10:18','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','fcc5ba9f-4dfc-4938-aad1-4e27f1368f8d')
;

-- Jun 30, 2022, 2:10:20 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (2,'Account Date',TO_TIMESTAMP('2022-06-30 14:10:19','YYYY-MM-DD HH24:MI:SS'),'N',0,'Acct Date',0,0,12995,'N','Y',100,0,200311,100,'N',0,TO_TIMESTAMP('2022-06-30 14:10:19','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','7735249c-f0af-42d0-b3a6-13ea0cb4960d')
;

-- Jun 30, 2022, 2:10:21 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (3,'Account Key',TO_TIMESTAMP('2022-06-30 14:10:20','YYYY-MM-DD HH24:MI:SS'),'N',0,'Account Key',0,0,13028,'N','Y',100,0,200312,100,'N',0,TO_TIMESTAMP('2022-06-30 14:10:20','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','3fa7f659-cab7-4d6d-81d3-917c37107236')
;

-- Jun 30, 2022, 2:10:22 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (4,'Accounted Balance',TO_TIMESTAMP('2022-06-30 14:10:21','YYYY-MM-DD HH24:MI:SS'),'N',0,'Balance',0,0,13006,'N','Y',100,0,200313,100,'N',0,TO_TIMESTAMP('2022-06-30 14:10:21','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','10146fb1-91d4-4c3f-bbf8-6c3f58cf3ea4')
;

-- Jun 30, 2022, 2:10:23 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (5,'Accounted Credit',TO_TIMESTAMP('2022-06-30 14:10:22','YYYY-MM-DD HH24:MI:SS'),'N',0,'Acct Credit',0,0,12980,'N','Y',100,0,200314,100,'N',0,TO_TIMESTAMP('2022-06-30 14:10:22','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','0a0c7ff1-5850-434f-b74f-48cf7f276ed7')
;

-- Jun 30, 2022, 2:10:24 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (6,'Accounted Debit',TO_TIMESTAMP('2022-06-30 14:10:23','YYYY-MM-DD HH24:MI:SS'),'N',0,'Acct Debit',0,0,12981,'N','Y',100,0,200315,100,'N',0,TO_TIMESTAMP('2022-06-30 14:10:23','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','5e4789bc-7fd6-45bd-93fa-8dda258992a9')
;

-- Jun 30, 2022, 2:10:27 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Accounting Fact',TO_TIMESTAMP('2022-06-30 14:10:24','YYYY-MM-DD HH24:MI:SS'),'N',0,'Accounting Fact',0,0,13004,'N','Y',100,0,200316,100,'N',0,TO_TIMESTAMP('2022-06-30 14:10:24','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','c714d22a-8b52-4531-b0cf-26294042c102')
;

-- Jun 30, 2022, 2:10:29 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (8,'Accounting Schema',TO_TIMESTAMP('2022-06-30 14:10:27','YYYY-MM-DD HH24:MI:SS'),'N',0,'Accounting Schema',0,0,12997,'N','Y',100,0,200317,100,'N',0,TO_TIMESTAMP('2022-06-30 14:10:27','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','7aea477f-3dce-43ae-a7b4-720e8b4359c1')
;

-- Jun 30, 2022, 2:10:34 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (9,'Activity',TO_TIMESTAMP('2022-06-30 14:10:29','YYYY-MM-DD HH24:MI:SS'),'N',0,'Activity',0,0,12969,'N','Y',100,0,200318,100,'N',0,TO_TIMESTAMP('2022-06-30 14:10:29','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','8e8addd6-763f-45c8-8dc2-e066c2119fc1')
;

-- Jun 30, 2022, 2:10:38 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (10,'Asset',TO_TIMESTAMP('2022-06-30 14:10:34','YYYY-MM-DD HH24:MI:SS'),'N',0,'Asset',0,0,12966,'N','Y',100,0,200319,100,'N',0,TO_TIMESTAMP('2022-06-30 14:10:34','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','4d64a136-a29c-4cbe-ad29-d48b5f8e22a2')
;

-- Jun 30, 2022, 2:12:34 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (12,'Business Partner',TO_TIMESTAMP('2022-06-30 14:12:34','YYYY-MM-DD HH24:MI:SS'),'N',0,'Business Partner',0,0,12976,'N','Y',100,0,200320,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:34','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','83f634d2-525a-48ab-bfcf-24fa7d1a3d7c')
;

-- Jun 30, 2022, 2:12:35 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (13,'Campaign',TO_TIMESTAMP('2022-06-30 14:12:35','YYYY-MM-DD HH24:MI:SS'),'N',0,'Campaign',0,0,12970,'N','Y',100,0,200321,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:35','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','c31c01eb-7fa3-4325-ad8d-267916db4c50')
;

-- Jun 30, 2022, 2:12:37 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Tenant',TO_TIMESTAMP('2022-06-30 14:12:35','YYYY-MM-DD HH24:MI:SS'),'N',0,'Tenant',0,0,13003,'N','Y',100,0,200322,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:35','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','c7f2e97f-e28c-4704-9c39-d86ec6e2fe70')
;

-- Jun 30, 2022, 2:12:38 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Created',TO_TIMESTAMP('2022-06-30 14:12:37','YYYY-MM-DD HH24:MI:SS'),'N',0,'Created',0,0,13001,'N','Y',100,0,200323,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:37','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','f21a5912-ae8d-4edd-919d-258dddab8303')
;

-- Jun 30, 2022, 2:12:40 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Created By',TO_TIMESTAMP('2022-06-30 14:12:38','YYYY-MM-DD HH24:MI:SS'),'N',0,'Created By',0,0,13000,'N','Y',100,0,200324,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:38','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','0c171f7a-503d-43d5-80ca-4e7fa231b734')
;

-- Jun 30, 2022, 2:12:41 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (17,'Currency',TO_TIMESTAMP('2022-06-30 14:12:40','YYYY-MM-DD HH24:MI:SS'),'N',0,'Currency',0,0,12984,'N','Y',100,0,200325,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:40','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','43b4d0b3-c759-4495-8772-fe631de74895')
;

-- Jun 30, 2022, 2:12:42 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (18,'Description',TO_TIMESTAMP('2022-06-30 14:12:41','YYYY-MM-DD HH24:MI:SS'),'N',0,'Description',0,0,12965,'N','Y',100,0,200326,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:41','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','02bee937-48b8-4500-bd5c-ccab610ed926')
;

-- Jun 30, 2022, 2:12:43 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (19,'GL Category',TO_TIMESTAMP('2022-06-30 14:12:42','YYYY-MM-DD HH24:MI:SS'),'N',0,'GL Category',0,0,12989,'N','Y',100,0,200327,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:42','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','7812967c-1874-4db1-8e9f-b8c82129a77a')
;

-- Jun 30, 2022, 2:12:45 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (20,'Level no',TO_TIMESTAMP('2022-06-30 14:12:43','YYYY-MM-DD HH24:MI:SS'),'N',0,'Level no',0,0,214972,'N','Y',100,0,200328,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:43','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','86ebe6e7-995a-4ef3-adf9-f275ec178b4f')
;

-- Jun 30, 2022, 2:12:46 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Line ID',TO_TIMESTAMP('2022-06-30 14:12:45','YYYY-MM-DD HH24:MI:SS'),'N',0,'Line ID',0,0,12990,'N','Y',100,0,200329,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:45','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','bd12d2cb-c59d-4f35-88dc-0d3279c67ec4')
;

-- Jun 30, 2022, 2:12:47 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (22,'Location From',TO_TIMESTAMP('2022-06-30 14:12:46','YYYY-MM-DD HH24:MI:SS'),'N',0,'Location From',0,0,12974,'N','Y',100,0,200330,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:46','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','0e43023c-b768-4193-9f1d-49383848a60c')
;

-- Jun 30, 2022, 2:12:48 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (23,'Location To',TO_TIMESTAMP('2022-06-30 14:12:47','YYYY-MM-DD HH24:MI:SS'),'N',0,'Location To',0,0,12973,'N','Y',100,0,200331,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:47','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','b55280f7-43dc-4193-b0a3-f16d3fa6020b')
;

-- Jun 30, 2022, 2:12:49 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (24,'Locator',TO_TIMESTAMP('2022-06-30 14:12:48','YYYY-MM-DD HH24:MI:SS'),'N',0,'Locator',0,0,12986,'N','Y',100,0,200332,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:48','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','b5aead9d-db4e-4bc5-97a8-7e2b570d3684')
;

-- Jun 30, 2022, 2:12:50 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Organization',TO_TIMESTAMP('2022-06-30 14:12:49','YYYY-MM-DD HH24:MI:SS'),'N',0,'Organization',0,0,13002,'N','Y',100,0,200333,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:49','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','b452c3da-7015-48d7-b6af-4dee27cafdc7')
;

-- Jun 30, 2022, 2:12:51 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (26,'Period',TO_TIMESTAMP('2022-06-30 14:12:50','YYYY-MM-DD HH24:MI:SS'),'N',0,'Period',0,0,12993,'N','Y',100,0,200334,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:50','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','f47fe161-0134-4817-8739-36bfef603fc9')
;

-- Jun 30, 2022, 2:12:52 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (27,'Posting Type',TO_TIMESTAMP('2022-06-30 14:12:51','YYYY-MM-DD HH24:MI:SS'),'N',0,'Posting Type',0,0,12985,'N','Y',100,0,200335,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:51','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','16c49629-a8b2-4084-bb3b-99845861cebc')
;

-- Jun 30, 2022, 2:12:53 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (28,'Process Instance',TO_TIMESTAMP('2022-06-30 14:12:52','YYYY-MM-DD HH24:MI:SS'),'N',0,'Process Instance',0,0,13005,'N','Y',100,0,200336,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:52','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','566e3f20-3caa-4a68-881a-fac36c70aa2e')
;

-- Jun 30, 2022, 2:12:54 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (29,'Product',TO_TIMESTAMP('2022-06-30 14:12:53','YYYY-MM-DD HH24:MI:SS'),'N',0,'Product',0,0,12977,'N','Y',100,0,200337,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:53','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','1be9e87b-f047-4a1b-a68a-9bb762fbdc51')
;

-- Jun 30, 2022, 2:12:56 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (30,'Project',TO_TIMESTAMP('2022-06-30 14:12:54','YYYY-MM-DD HH24:MI:SS'),'N',0,'Project',0,0,12971,'N','Y',100,0,200338,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:54','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','be12fd28-375b-428c-9ce3-fec61a0a38d1')
;

-- Jun 30, 2022, 2:12:57 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (31,'Quantity',TO_TIMESTAMP('2022-06-30 14:12:56','YYYY-MM-DD HH24:MI:SS'),'N',0,'Qty',0,0,12978,'N','Y',100,0,200339,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:56','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','15a54841-aaff-4143-96dd-fa2a4dda0e0c')
;

-- Jun 30, 2022, 2:12:58 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Record ID',TO_TIMESTAMP('2022-06-30 14:12:57','YYYY-MM-DD HH24:MI:SS'),'N',0,'Record ID',0,0,12991,'N','Y',100,0,200340,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:57','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','0dc82d80-88f7-404f-b7a1-3590fa3bdca1')
;

-- Jun 30, 2022, 2:12:59 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (33,'Sales Region',TO_TIMESTAMP('2022-06-30 14:12:58','YYYY-MM-DD HH24:MI:SS'),'N',0,'Sales Region',0,0,12972,'N','Y',100,0,200341,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:58','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','c0eb5ca1-032e-4f0d-8f5a-9dad90fd6874')
;

-- Jun 30, 2022, 2:13:01 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (34,'Source Balance',TO_TIMESTAMP('2022-06-30 14:12:59','YYYY-MM-DD HH24:MI:SS'),'N',0,'Source Balance',0,0,13007,'N','Y',100,0,200342,100,'N',0,TO_TIMESTAMP('2022-06-30 14:12:59','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','550329d0-9a7a-46eb-811b-c56b03e4c4b3')
;

-- Jun 30, 2022, 2:13:02 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (35,'Source Credit',TO_TIMESTAMP('2022-06-30 14:13:01','YYYY-MM-DD HH24:MI:SS'),'N',0,'Source Credit',0,0,12982,'N','Y',100,0,200343,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:01','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','df13c8de-fadd-487a-be7c-7c2503cec462')
;

-- Jun 30, 2022, 2:13:04 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (36,'Source Debit',TO_TIMESTAMP('2022-06-30 14:13:02','YYYY-MM-DD HH24:MI:SS'),'N',0,'Source Debit',0,0,12983,'N','Y',100,0,200344,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:02','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'T','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','ddf0c1cc-1388-4dfd-86cf-41660222daec')
;

-- Jun 30, 2022, 2:13:04 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (37,'Table',TO_TIMESTAMP('2022-06-30 14:13:04','YYYY-MM-DD HH24:MI:SS'),'N',0,'Table',0,0,12992,'N','Y',100,0,200345,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:04','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','45e349c2-ce3d-4dc7-98c1-366d66c11ea0')
;

-- Jun 30, 2022, 2:13:06 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (38,'Tax',TO_TIMESTAMP('2022-06-30 14:13:04','YYYY-MM-DD HH24:MI:SS'),'N',0,'Tax',0,0,12987,'N','Y',100,0,200346,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:04','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','ea42fe15-5142-424c-8f16-3d332e755792')
;

-- Jun 30, 2022, 2:13:07 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (39,'Transaction Date',TO_TIMESTAMP('2022-06-30 14:13:06','YYYY-MM-DD HH24:MI:SS'),'N',0,'Trx Date',0,0,12994,'N','Y',100,0,200347,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:06','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','c676b7b4-e5f9-4191-94f1-a568c7974688')
;

-- Jun 30, 2022, 2:13:09 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (40,'Trx Organization',TO_TIMESTAMP('2022-06-30 14:13:07','YYYY-MM-DD HH24:MI:SS'),'N',0,'Trx Organization',0,0,12975,'N','Y',100,0,200348,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:07','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','793bb4bd-1455-4c30-87a5-f8ce380de6e1')
;

-- Jun 30, 2022, 2:13:10 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (41,'UOM',TO_TIMESTAMP('2022-06-30 14:13:09','YYYY-MM-DD HH24:MI:SS'),'N',0,'UOM',0,0,12979,'N','Y',100,0,200349,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:09','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','2b96f3c1-4d31-4111-8df8-02ad9ed51839')
;

-- Jun 30, 2022, 2:13:11 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Updated',TO_TIMESTAMP('2022-06-30 14:13:10','YYYY-MM-DD HH24:MI:SS'),'N',0,'Updated',0,0,12999,'N','Y',100,0,200350,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:10','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','992e2d60-0c33-4aa8-8eb6-9e89f19cb800')
;

-- Jun 30, 2022, 2:13:12 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (0,'Updated By',TO_TIMESTAMP('2022-06-30 14:13:11','YYYY-MM-DD HH24:MI:SS'),'N',0,'Updated By',0,0,12998,'N','Y',100,0,200351,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:11','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','N','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','7c65a885-3792-4058-a721-1f1002da1783')
;

-- Jun 30, 2022, 2:13:13 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (44,'User Element List 1',TO_TIMESTAMP('2022-06-30 14:13:12','YYYY-MM-DD HH24:MI:SS'),'N',0,'User Element List 1',0,0,12968,'N','Y',100,0,200352,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:12','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','fca4b6dc-50dc-4793-b9b2-6762f4dd68c9')
;

-- Jun 30, 2022, 2:13:14 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,PrintName,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,IsNextPage,IsFixedWidth,IsMaxCalc,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,AD_PrintFormatItem_UU) VALUES (45,'User Element List 2',TO_TIMESTAMP('2022-06-30 14:13:13','YYYY-MM-DD HH24:MI:SS'),'N',0,'User Element List 2',0,0,12967,'N','Y',100,0,200353,100,'N',0,TO_TIMESTAMP('2022-06-30 14:13:13','YYYY-MM-DD HH24:MI:SS'),200014,0,0,'Y','N',0,0,'L','Y','N','N','X','F','C','N','N','N','N','N','N','N','N','N','N','N','N','N',1,0,'N','Y','N','c9bafa4c-d271-49fa-8ffb-480a16f12d2a')
;

-- Jun 30, 2022, 2:19:52 PM IST
UPDATE AD_PrintFormatItem SET SortNo=10,IsOrderBy='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200328
;

-- Jun 30, 2022, 2:19:52 PM IST
UPDATE AD_PrintFormatItem SET SortNo=20,IsOrderBy='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200333
;

-- Jun 30, 2022, 2:19:52 PM IST
UPDATE AD_PrintFormatItem SET SortNo=30,IsOrderBy='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200311
;

-- Jun 30, 2022, 2:19:52 PM IST
UPDATE AD_PrintFormatItem SET SortNo=40,IsOrderBy='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200310
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200341
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200335
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200332
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200331
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200330
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200327
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200321
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200319
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200318
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200336
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200317
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200328
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=10,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200333
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=20,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200326
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=30,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200311
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=40,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200310
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=50,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200312
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=60,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200320
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=70,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200313
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=80,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200314
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=90,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200315
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=100,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200325
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=110,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200334
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=120,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200337
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=130,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200338
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=140,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200339
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=150,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200349
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=160,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200342
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=170,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200343
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=180,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200344
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=190,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200340
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=200,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200346
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=210,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200348
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=220,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200352
;

-- Jun 30, 2022, 2:24:38 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=230,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200353
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=110,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200347
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=120,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200334
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=130,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200337
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=140,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200338
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=150,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200339
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=160,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200349
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=170,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200342
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=180,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200343
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=190,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200344
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=200,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200345
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=210,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200340
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=220,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200346
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=230,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200348
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=240,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200352
;

-- Jun 30, 2022, 2:25:27 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=250,IsPrinted='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200353
;

-- Jun 30, 2022, 2:30:56 PM IST
UPDATE AD_Table SET IsView='N',Updated=TO_TIMESTAMP('2022-06-30 14:30:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=753
;

-- Jun 30, 2022, 2:31:07 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('T_TrialBalance',1000000,'N','N','Table T_TrialBalance','Y','Y',0,0,TO_TIMESTAMP('2022-06-30 14:30:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-30 14:30:56','YYYY-MM-DD HH24:MI:SS'),100,200419,'Y',1000000,1,200000,'b901e84f-e53d-4552-86eb-e8bc49ea9124')
;

-- Jul 4, 2022, 8:03:29 PM MYT
UPDATE AD_PrintFormat SET AD_ReportView_ID=153,Updated=TO_TIMESTAMP('2022-07-04 20:03:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200014
;
