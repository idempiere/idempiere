-- IDEMPIERE-6733 Additional columns on Statement of account
SELECT register_migration_script('202511201738_IDEMPIERE-6733.sql') FROM dual;

-- Nov 20, 2025, 5:38:42 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217167,0,'Account','Account used','The (natural) account used',545,'Account_ID','0',22,'N','N','N','N','N',0,'N',30,132,0,0,'Y',TO_TIMESTAMP('2025-11-20 17:38:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-11-20 17:38:41','YYYY-MM-DD HH24:MI:SS'),100,148,'N','N','D','N','N','N','Y','019aa12a-b568-757e-b0a8-b64bbac08baa','Y',0,'N','N','N','N')
;

-- Nov 20, 2025, 5:38:45 PM IST
UPDATE AD_Column SET FKConstraintName='Account_TReportStatement', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-11-20 17:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217167
;

-- Nov 20, 2025, 5:38:45 PM IST
ALTER TABLE T_ReportStatement ADD COLUMN Account_ID NUMERIC(10) DEFAULT '0' 
;

-- Nov 20, 2025, 5:38:45 PM IST
ALTER TABLE T_ReportStatement ADD CONSTRAINT Account_TReportStatement FOREIGN KEY (Account_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 20, 2025, 5:39:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217168,0,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',545,'C_BPartner_ID',22,'N','N','N','N','N',0,'N',30,200175,0,0,'Y',TO_TIMESTAMP('2025-11-20 17:39:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-11-20 17:39:42','YYYY-MM-DD HH24:MI:SS'),100,187,'N','N','D','N','N','N','Y','019aa12b-a488-76e7-bee0-2b2e86d33cb6','Y',0,'N','N','N','N')
;

-- Nov 20, 2025, 5:39:45 PM IST
UPDATE AD_Column SET FKConstraintName='CBPartner_TReportStatement', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-11-20 17:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217168
;

-- Nov 20, 2025, 5:39:45 PM IST
ALTER TABLE T_ReportStatement ADD COLUMN C_BPartner_ID NUMERIC(10) DEFAULT NULL 
;

-- Nov 20, 2025, 5:39:45 PM IST
ALTER TABLE T_ReportStatement ADD CONSTRAINT CBPartner_TReportStatement FOREIGN KEY (C_BPartner_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;


-- Nov 20, 2025, 5:41:42 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,AD_PrintColor_ID,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,AD_PrintFont_ID,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,BelowColumn,IsNextPage,IsFixedWidth,IsMaxCalc,RunningTotalLines,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,IsSuppressRepeats,AD_PrintFormatItem_UU,IsDesc,IsPrintBarcodeText,IsPrintInstanceAttributes,PrintName) VALUES (80,'Account',TO_TIMESTAMP('2025-11-20 17:41:41','YYYY-MM-DD HH24:MI:SS'),'Y',0,0,10,217167,'N','Y',100,0,200534,100,'N',0,100,TO_TIMESTAMP('2025-11-20 17:41:41','YYYY-MM-DD HH24:MI:SS'),134,0,0,130,'Y','Y',0,0,'D','Y','Y','Y','X','F','C','N','N','N','N','N',0,'N','N','N',20,'N','N','N','N','N',1,0,'N','N','N','N','019aa12d-7469-7898-ad51-b5ea90f32314','N','Y','N','Account')
;

-- Nov 20, 2025, 5:42:12 PM IST
INSERT INTO AD_PrintFormatItem (SeqNo,Name,Created,IsNextLine,AD_Client_ID,YSpace,SortNo,AD_Column_ID,IsPageBreak,IsRelativePosition,UpdatedBy,MaxWidth,AD_PrintFormatItem_ID,CreatedBy,IsSummarized,YPosition,AD_PrintColor_ID,Updated,AD_PrintFormat_ID,AD_Org_ID,XSpace,AD_PrintFont_ID,IsActive,IsHeightOneLine,MaxHeight,XPosition,FieldAlignmentType,IsPrinted,IsOrderBy,IsGroupBy,LineAlignmentType,PrintFormatType,PrintAreaType,ImageIsAttached,IsCounted,IsAveraged,IsSuppressNull,IsSetNLPosition,BelowColumn,IsNextPage,IsFixedWidth,IsMaxCalc,RunningTotalLines,IsRunningTotal,IsMinCalc,IsVarianceCalc,IsDeviationCalc,IsFilledRectangle,LineWidth,ArcDiameter,ShapeType,IsCentrallyMaintained,IsImageField,IsSuppressRepeats,AD_PrintFormatItem_UU,IsDesc,IsPrintBarcodeText,IsPrintInstanceAttributes,PrintName) VALUES (90,'BPartner',TO_TIMESTAMP('2025-11-20 17:42:11','YYYY-MM-DD HH24:MI:SS'),'Y',0,0,0,217168,'N','Y',100,0,200535,100,'N',0,100,TO_TIMESTAMP('2025-11-20 17:42:11','YYYY-MM-DD HH24:MI:SS'),134,0,0,130,'Y','Y',0,0,'D','Y','N','N','X','F','C','N','N','N','N','N',0,'N','N','N',20,'N','N','N','N','N',1,0,'N','N','N','N','019aa12d-ebb4-7b01-a75f-98f74030f034','N','Y','N','Business Partner')
;

-- Nov 20, 2025, 5:44:50 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=10, YPosition=0, XPosition=0, IsPrinted='Y',Updated=TO_TIMESTAMP('2025-11-20 17:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200534
;

-- Nov 20, 2025, 5:44:50 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=20, YPosition=0, XPosition=0, IsPrinted='Y',Updated=TO_TIMESTAMP('2025-11-20 17:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=981
;

-- Nov 20, 2025, 5:44:50 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=30, YPosition=0, XPosition=0, IsPrinted='Y',Updated=TO_TIMESTAMP('2025-11-20 17:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=982
;

-- Nov 20, 2025, 5:44:50 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=40, SortNo=0, IsPageBreak='N', YPosition=0, XPosition=0, IsPrinted='Y', IsGroupBy='N',Updated=TO_TIMESTAMP('2025-11-20 17:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=983
;

-- Nov 20, 2025, 5:44:50 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=50, SortNo=0, IsPageBreak='N', YPosition=0, XPosition=0, IsPrinted='Y', IsGroupBy='N',Updated=TO_TIMESTAMP('2025-11-20 17:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200535
;

-- Nov 20, 2025, 5:44:50 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=70, SortNo=0, IsPageBreak='N', YPosition=0, XPosition=0, IsPrinted='Y', IsGroupBy='N',Updated=TO_TIMESTAMP('2025-11-20 17:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=984
;

-- Nov 20, 2025, 5:44:50 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=80, SortNo=0, IsPageBreak='N', YPosition=0, XPosition=0, IsPrinted='Y', IsGroupBy='N',Updated=TO_TIMESTAMP('2025-11-20 17:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=985
;

-- Nov 20, 2025, 5:44:50 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=90, SortNo=0, IsPageBreak='N', YPosition=0, XPosition=0, IsPrinted='Y', IsGroupBy='N',Updated=TO_TIMESTAMP('2025-11-20 17:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=986
;

-- Nov 20, 2025, 5:44:50 PM IST
UPDATE AD_PrintFormatItem SET SeqNo=100, SortNo=0, IsPageBreak='N', YPosition=0, XPosition=0, IsPrinted='Y', IsGroupBy='N',Updated=TO_TIMESTAMP('2025-11-20 17:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=987
;

-- Nov 20, 2025, 6:04:10 PM IST
UPDATE AD_PrintFormatItem SET SortNo=30, YPosition=0, XPosition=0, IsOrderBy='Y',Updated=TO_TIMESTAMP('2025-11-20 18:04:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=981
;

-- Nov 20, 2025, 6:04:10 PM IST
UPDATE AD_PrintFormatItem SET SortNo=40, YPosition=0, XPosition=0, IsOrderBy='Y',Updated=TO_TIMESTAMP('2025-11-20 18:04:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=982
;

-- Nov 20, 2025, 6:59:43 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201291,'019aa174-e1d0-70b5-969c-fecd881b9587',TO_TIMESTAMP('2025-11-20 18:59:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','t_reportstatement_pkey',TO_TIMESTAMP('2025-11-20 18:59:42','YYYY-MM-DD HH24:MI:SS'),100,545,'Y','Y','N','N','Y')
;

-- Nov 20, 2025, 6:59:52 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201766,'019aa175-05cd-796e-8274-007997b7199d',TO_TIMESTAMP('2025-11-20 18:59:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-11-20 18:59:51','YYYY-MM-DD HH24:MI:SS'),100,8191,201291,10)
;

-- Nov 20, 2025, 6:59:58 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201767,'019aa175-1c47-7542-b064-52966943120f',TO_TIMESTAMP('2025-11-20 18:59:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-11-20 18:59:57','YYYY-MM-DD HH24:MI:SS'),100,8192,201291,20)
;

-- Nov 20, 2025, 7:00:02 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201768,'019aa175-2e14-7d13-8b6e-1364d2267960',TO_TIMESTAMP('2025-11-20 19:00:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-11-20 19:00:01','YYYY-MM-DD HH24:MI:SS'),100,217167,201291,30)
;

ALTER TABLE T_ReportStatement DROP CONSTRAINT t_reportstatement_pkey
;

-- Nov 20, 2025, 7:00:05 PM IST
ALTER TABLE T_ReportStatement ADD CONSTRAINT t_reportstatement_pkey PRIMARY KEY (AD_PInstance_ID,Fact_Acct_ID,Account_ID)
;

