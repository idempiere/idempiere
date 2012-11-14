-- Nov 12, 2012 6:10:19 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Reference (AD_Reference_UU,Name,EntityType,IsOrderByValue,AD_Reference_ID,ValidationType,AD_Org_ID,Created,UpdatedBy,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('9a238b56-6113-430b-969d-c72f023d059d','M_MatchPO','D','N',200017,'T',0,TO_TIMESTAMP('2012-11-12 18:10:15','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2012-11-12 18:10:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 12, 2012 6:10:19 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200017 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Nov 12, 2012 6:11:40 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Ref_Table (IsValueDisplayed,OrderByClause,AD_Key,AD_Display,Updated,EntityType,AD_Reference_ID,AD_Client_ID,UpdatedBy,AD_Table_ID,AD_Org_ID,AD_Ref_Table_UU,CreatedBy,Created,IsActive) VALUES ('N','M_MatchPO.DocumentNo',6513,13087,TO_TIMESTAMP('2012-11-12 18:11:40','YYYY-MM-DD HH24:MI:SS'),'D',200017,0,100,473,0,'f2683800-01e3-47fd-85ea-2a1bb1a8ab48',100,TO_TIMESTAMP('2012-11-12 18:11:40','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 12, 2012 6:12:28 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N',1,473,'D',200017,'N','N','N',0,'N',10,'N',18,'N',53457,TO_TIMESTAMP('2012-11-12 18:12:26','YYYY-MM-DD HH24:MI:SS'),'N','Y','104c1cef-5cc1-436d-aa8a-548e66b2469f','Y','N','Reversal_ID','ID of document reversal','Reversal ID','N','Y',100,TO_TIMESTAMP('2012-11-12 18:12:26','YYYY-MM-DD HH24:MI:SS'),0,100,0,200880,'N',0)
;

-- Nov 12, 2012 6:12:28 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200880 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 12, 2012 6:12:36 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
ALTER TABLE M_MatchPO ADD COLUMN Reversal_ID NUMERIC(10) DEFAULT NULL 
;

-- Nov 12, 2012 6:14:15 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Reference (AD_Reference_UU,Name,EntityType,IsOrderByValue,AD_Reference_ID,ValidationType,AD_Org_ID,Created,UpdatedBy,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('a8cf3824-9f18-4d6b-802e-3412a8954a00','M_MatchInv','D','N',200018,'T',0,TO_TIMESTAMP('2012-11-12 18:14:13','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2012-11-12 18:14:13','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 12, 2012 6:14:15 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200018 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Nov 12, 2012 6:14:53 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Ref_Table (IsValueDisplayed,OrderByClause,AD_Key,AD_Display,Updated,EntityType,AD_Reference_ID,AD_Client_ID,UpdatedBy,AD_Table_ID,AD_Org_ID,AD_Ref_Table_UU,CreatedBy,Created,IsActive) VALUES ('N','M_MatchInv.DocumentNo',6497,13086,TO_TIMESTAMP('2012-11-12 18:14:53','YYYY-MM-DD HH24:MI:SS'),'D',200018,0,100,472,0,'24adae8f-5c79-4cae-b407-3ca6fba3c375',100,TO_TIMESTAMP('2012-11-12 18:14:53','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 12, 2012 6:16:04 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N',1,472,'D',200018,'N','N','N',0,'N',10,'N',18,'N',53457,TO_TIMESTAMP('2012-11-12 18:16:03','YYYY-MM-DD HH24:MI:SS'),'N','Y','62823c9e-b2c1-46e2-9157-80a1338d0b71','Y','N','Reversal_ID','ID of document reversal','Reversal ID','Y','Y',100,TO_TIMESTAMP('2012-11-12 18:16:03','YYYY-MM-DD HH24:MI:SS'),0,100,0,200881,'N',0)
;

-- Nov 12, 2012 6:16:04 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200881 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 12, 2012 6:16:10 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
ALTER TABLE M_MatchInv ADD COLUMN Reversal_ID NUMERIC(10) DEFAULT NULL 
;

-- Nov 12, 2012 6:19:34 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N',1,735,'D',323,'N','N','N',0,'N',10,'N',18,'N',53457,TO_TIMESTAMP('2012-11-12 18:19:33','YYYY-MM-DD HH24:MI:SS'),'N','Y','f8c0678b-cdcc-41b2-8ccf-b7e5bba6c5a1','Y','N','Reversal_ID','ID of document reversal','Reversal ID','Y','Y',100,TO_TIMESTAMP('2012-11-12 18:19:33','YYYY-MM-DD HH24:MI:SS'),0,100,0,200882,'N',0)
;

-- Nov 12, 2012 6:19:34 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200882 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 12, 2012 6:19:39 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
ALTER TABLE C_AllocationHdr ADD COLUMN Reversal_ID NUMERIC(10) DEFAULT NULL 
;

-- Nov 12, 2012 6:24:58 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Classname,Name,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Value,AD_Org_ID,Created,IsActive) VALUES ('N',200016,'N','N','c3c3698b-82ca-4686-9d92-0ffc83c10bf6','3','N','N',0,0,'Y','D','org.adempiere.process.MatchPOReverse','Reverse MatchPO',0,100,TO_TIMESTAMP('2012-11-12 18:24:56','YYYY-MM-DD HH24:MI:SS'),100,'M_MatchPO_Reversal',0,TO_TIMESTAMP('2012-11-12 18:24:56','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 12, 2012 6:24:58 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200016 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Nov 12, 2012 6:26:45 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Classname,Name,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Value,AD_Org_ID,Created,IsActive) VALUES ('N',200017,'N','N','bbb372e3-138e-4425-9f8c-bfbd1e73a666','3','N','N',0,0,'Y','D','org.adempiere.process.MatchInvReverse','Reverse MatchInv',0,100,TO_TIMESTAMP('2012-11-12 18:26:44','YYYY-MM-DD HH24:MI:SS'),100,'M_MatchInv_Reversal',0,TO_TIMESTAMP('2012-11-12 18:26:44','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 12, 2012 6:26:45 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200017 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Nov 12, 2012 6:30:55 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_ToolBarButton ("action",AD_Tab_ID,SeqNo,AD_Process_ID,AD_ToolBarButton_ID,Updated,IsActive,IsCustomization,Name,AD_Client_ID,AD_ToolBarButton_UU,ComponentName,Created,CreatedBy,UpdatedBy,AD_Org_ID) VALUES ('W',408,10,200017,200069,TO_TIMESTAMP('2012-11-12 18:30:54','YYYY-MM-DD HH24:MI:SS'),'Y','N','Reverse Invoice Matching',0,'08eda454-bcb1-4c57-83e4-97212206a7bc','ReverseMatchInv',TO_TIMESTAMP('2012-11-12 18:30:54','YYYY-MM-DD HH24:MI:SS'),100,100,0)
;

-- Nov 12, 2012 6:31:40 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
UPDATE AD_Process SET Name='Reverse Invoice Matching',Updated=TO_TIMESTAMP('2012-11-12 18:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200017
;

-- Nov 12, 2012 6:31:40 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
UPDATE AD_Process_Trl SET IsTranslated='N' WHERE AD_Process_ID=200017
;

-- Nov 12, 2012 6:32:43 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_ToolBarButton ("action",AD_Tab_ID,SeqNo,AD_Process_ID,AD_ToolBarButton_ID,Updated,IsActive,IsCustomization,Name,AD_Client_ID,AD_ToolBarButton_UU,ComponentName,Created,CreatedBy,UpdatedBy,AD_Org_ID) VALUES ('W',409,10,200016,200070,TO_TIMESTAMP('2012-11-12 18:32:42','YYYY-MM-DD HH24:MI:SS'),'Y','N','Reverse PO Matching',0,'1ef6e3e8-8997-4242-9715-58d07afe4e08','ReverseMatchPO',TO_TIMESTAMP('2012-11-12 18:32:42','YYYY-MM-DD HH24:MI:SS'),100,100,0)
;

-- Nov 12, 2012 6:34:00 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
UPDATE AD_Process SET Name='Reverse PO Matching',Updated=TO_TIMESTAMP('2012-11-12 18:34:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200016
;

-- Nov 12, 2012 6:34:00 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
UPDATE AD_Process_Trl SET IsTranslated='N' WHERE AD_Process_ID=200016
;

-- Nov 12, 2012 6:36:32 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_ToolBarButton ("action",AD_Tab_ID,SeqNo,AD_Process_ID,AD_ToolBarButton_ID,Updated,IsActive,IsCustomization,Name,AD_Client_ID,AD_ToolBarButton_UU,ComponentName,Created,CreatedBy,UpdatedBy,AD_Org_ID) VALUES ('W',690,10,200017,200071,TO_TIMESTAMP('2012-11-12 18:36:31','YYYY-MM-DD HH24:MI:SS'),'Y','N','Reverse Invoice Matching',0,'00811a39-21a6-4c51-b5f1-299bd6f595b1','ReverseMatchInv',TO_TIMESTAMP('2012-11-12 18:36:31','YYYY-MM-DD HH24:MI:SS'),100,100,0)
;

-- Nov 12, 2012 6:37:50 PM MYT
-- IDEMPIERE-378 Implement Reverse Accrual
INSERT INTO AD_ToolBarButton ("action",AD_Tab_ID,SeqNo,AD_Process_ID,AD_ToolBarButton_ID,Updated,IsActive,IsCustomization,Name,AD_Client_ID,AD_ToolBarButton_UU,ComponentName,Created,CreatedBy,UpdatedBy,AD_Org_ID) VALUES ('W',692,10,200016,200072,TO_TIMESTAMP('2012-11-12 18:37:49','YYYY-MM-DD HH24:MI:SS'),'Y','N','Reverse PO Matching',0,'99e7e98d-a600-4174-9b55-923b790d03ba','ReverseMatchPO',TO_TIMESTAMP('2012-11-12 18:37:49','YYYY-MM-DD HH24:MI:SS'),100,100,0)
;

