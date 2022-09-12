-- IDEMPIERE-5410
SELECT register_migration_script('202209081507_IDEMPIERE-5410.sql') FROM dual;

-- Sep 8, 2022, 3:07:16 PM CEST
INSERT INTO C_SalesStage (AD_Client_ID,AD_Org_ID,C_SalesStage_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,Name,Probability,Value,IsClosed,IsWon,C_SalesStage_UU) VALUES (11,0,200008,TO_TIMESTAMP('2022-09-08 15:07:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:15','YYYY-MM-DD HH24:MI:SS'),100,'New',10,'1000000','N','N','b9b910fd-462c-47e0-93ca-876db5a4a79b')
;

-- Sep 8, 2022, 3:07:16 PM CEST
INSERT INTO C_SalesStage (AD_Client_ID,AD_Org_ID,C_SalesStage_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,Name,Probability,Value,IsClosed,IsWon,C_SalesStage_UU) VALUES (11,0,200009,TO_TIMESTAMP('2022-09-08 15:07:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:16','YYYY-MM-DD HH24:MI:SS'),100,'Won',100,'1000002','Y','Y','23f083af-e8ca-4047-b103-94d97cb0c5d6')
;

-- Sep 8, 2022, 3:07:16 PM CEST
INSERT INTO C_SalesStage (AD_Client_ID,AD_Org_ID,C_SalesStage_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,Name,Probability,Value,IsClosed,IsWon,C_SalesStage_UU) VALUES (11,0,200010,TO_TIMESTAMP('2022-09-08 15:07:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:16','YYYY-MM-DD HH24:MI:SS'),100,'Lost',0,'1000003','Y','N','ce1b1cb7-54fc-49ef-b8f7-923a3d85f786')
;

-- Sep 8, 2022, 3:07:17 PM CEST
INSERT INTO C_SalesStage (AD_Client_ID,AD_Org_ID,C_SalesStage_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,Name,Probability,Value,IsClosed,IsWon,C_SalesStage_UU) VALUES (11,0,200011,TO_TIMESTAMP('2022-09-08 15:07:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:16','YYYY-MM-DD HH24:MI:SS'),100,'Negotiation',70.00,'1000001','N','N','2bd45041-af26-4a19-a31f-b17a5be3c792')
;

-- Sep 8, 2022, 3:07:17 PM CEST
INSERT INTO C_Campaign (C_Campaign_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,C_Channel_ID,StartDate,EndDate,Costs,Value,IsSummary,C_Campaign_UU) VALUES (200000,11,11,'Y',TO_TIMESTAMP('2022-09-08 15:07:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 15:07:17','YYYY-MM-DD HH24:MI:SS'),100,'Winter Mailer','Brochure Mailing for Wrinter',103,TO_TIMESTAMP('2022-01-02','YYYY-MM-DD'),TO_TIMESTAMP('2022-03-31','YYYY-MM-DD'),0,'WinterMailer','N','f92217a0-4718-4006-83a1-9d70a37b7a48')
;

-- Sep 8, 2022, 3:07:17 PM CEST
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200000, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=11 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MC' AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200000)
;

-- Sep 8, 2022, 3:07:17 PM CEST
INSERT INTO C_Opportunity (AD_Client_ID,AD_Org_ID,C_Opportunity_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,DocumentNo,C_BPartner_ID,ExpectedCloseDate,OpportunityAmt,C_Currency_ID,Cost,C_SalesStage_ID,Probability,C_Opportunity_UU) VALUES (11,0,200003,TO_TIMESTAMP('2022-09-08 15:07:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:17','YYYY-MM-DD HH24:MI:SS'),100,'1000002',50002,TO_TIMESTAMP('2022-09-14','YYYY-MM-DD'),5000,100,0,200009,100,'25b772f2-1212-43c4-a643-3a2bc73be3ac')
;

-- Sep 8, 2022, 3:07:18 PM CEST
INSERT INTO C_Opportunity (AD_Client_ID,AD_Org_ID,C_Opportunity_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,DocumentNo,C_BPartner_ID,AD_User_ID,C_Campaign_ID,ExpectedCloseDate,SalesRep_ID,OpportunityAmt,C_Currency_ID,Cost,C_SalesStage_ID,Probability,C_Opportunity_UU) VALUES (11,0,200004,TO_TIMESTAMP('2022-09-08 15:07:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:17','YYYY-MM-DD HH24:MI:SS'),100,'1000000',120,105,102,TO_TIMESTAMP('2022-09-30','YYYY-MM-DD'),101,15000,100,0,200011,70.00,'c23b3525-f7cb-4a30-8674-2296cd4db0d3')
;

-- Sep 8, 2022, 3:07:18 PM CEST
INSERT INTO C_Opportunity (AD_Client_ID,AD_Org_ID,C_Opportunity_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,DocumentNo,C_BPartner_ID,C_Campaign_ID,ExpectedCloseDate,SalesRep_ID,OpportunityAmt,C_Currency_ID,Cost,C_SalesStage_ID,Probability,C_Opportunity_UU) VALUES (11,0,200005,TO_TIMESTAMP('2022-09-08 15:07:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:18','YYYY-MM-DD HH24:MI:SS'),100,'1000001',50001,200000,TO_TIMESTAMP('2022-09-30','YYYY-MM-DD'),101,12000.00,100,0,200011,100,'05d7ceb6-96db-4623-976f-b84729f3b794')
;

-- Sep 8, 2022, 3:07:18 PM CEST
INSERT INTO C_Opportunity (AD_Client_ID,AD_Org_ID,C_Opportunity_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,DocumentNo,C_BPartner_ID,AD_User_ID,C_Campaign_ID,ExpectedCloseDate,SalesRep_ID,OpportunityAmt,C_Currency_ID,Cost,C_SalesStage_ID,Probability,C_Opportunity_UU) VALUES (11,0,200006,TO_TIMESTAMP('2022-09-08 15:07:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:18','YYYY-MM-DD HH24:MI:SS'),100,'1000003',120,105,102,TO_TIMESTAMP('2022-09-30','YYYY-MM-DD'),101,7000.00,100,0,200009,100,'fbee0784-2943-4812-a61b-0ec9bfecd95e')
;

-- Sep 8, 2022, 3:07:18 PM CEST
INSERT INTO C_Opportunity (AD_Client_ID,AD_Org_ID,C_Opportunity_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,DocumentNo,C_BPartner_ID,AD_User_ID,C_Campaign_ID,ExpectedCloseDate,SalesRep_ID,OpportunityAmt,C_Currency_ID,Cost,C_SalesStage_ID,Probability,C_Opportunity_UU) VALUES (11,0,200007,TO_TIMESTAMP('2022-09-08 15:07:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:18','YYYY-MM-DD HH24:MI:SS'),100,'1000004',120,105,200000,TO_TIMESTAMP('2022-09-30','YYYY-MM-DD'),101,2000.00,100,0,200010,0,'6befe89e-c9f8-4cba-b4fb-8e94b9e34f5a')
;

-- Sep 8, 2022, 3:07:19 PM CEST
INSERT INTO C_Opportunity (AD_Client_ID,AD_Org_ID,C_Opportunity_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,DocumentNo,C_BPartner_ID,AD_User_ID,C_Campaign_ID,ExpectedCloseDate,SalesRep_ID,OpportunityAmt,C_Currency_ID,Cost,C_SalesStage_ID,Probability,C_Opportunity_UU) VALUES (11,0,200008,TO_TIMESTAMP('2022-09-08 15:07:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:18','YYYY-MM-DD HH24:MI:SS'),100,'1000005',120,105,200000,TO_TIMESTAMP('2022-10-06','YYYY-MM-DD'),101,2000.00,100,0,200008,10,'8987b181-8f1f-403d-949b-390780e4a340')
;

-- Sep 8, 2022, 3:07:19 PM CEST
INSERT INTO C_Opportunity (AD_Client_ID,AD_Org_ID,C_Opportunity_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,DocumentNo,C_BPartner_ID,AD_User_ID,C_Campaign_ID,ExpectedCloseDate,SalesRep_ID,OpportunityAmt,C_Currency_ID,Cost,C_SalesStage_ID,Probability,C_Opportunity_UU) VALUES (11,0,200009,TO_TIMESTAMP('2022-09-08 15:07:19','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2022-09-08 15:07:19','YYYY-MM-DD HH24:MI:SS'),100,'1000006',120,105,200000,TO_TIMESTAMP('2022-11-08','YYYY-MM-DD'),101,3000.00,100,0,200008,10,'3df967c3-4a1f-4d59-9d30-806b4cf97ec3')
;

-- Sep 8, 2022, 3:10:49 PM CEST
UPDATE AD_Chart SET Name='Sales Pipeline',Updated=TO_TIMESTAMP('2022-09-08 15:10:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=50000
;

-- Sep 8, 2022, 3:11:14 PM CEST
UPDATE AD_ChartDatasource SET WhereClause='o.IsActive=''Y'' AND s.IsClosed=''N ''',Updated=TO_TIMESTAMP('2022-09-08 15:11:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50000
;

-- Sep 8, 2022, 3:11:23 PM CEST
UPDATE AD_ChartDatasource SET WhereClause='o.IsActive=''Y'' AND s.IsClosed=''N''',Updated=TO_TIMESTAMP('2022-09-08 15:11:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50002
;

-- Sep 8, 2022, 3:12:33 PM CEST
UPDATE AD_Chart SET ChartOrientation='H',Updated=TO_TIMESTAMP('2022-09-08 15:12:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=50000
;

-- Sep 8, 2022, 3:13:17 PM CEST
UPDATE AD_Chart SET ChartType='RC', Name='Opportunities by Campaign',Updated=TO_TIMESTAMP('2022-09-08 15:13:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=50001
;

-- Sep 8, 2022, 3:13:56 PM CEST
UPDATE AD_ChartDatasource SET WhereClause='o.IsActive=''Y'' AND s.IsClosed=''N'' AND c.IsActive=''Y''',Updated=TO_TIMESTAMP('2022-09-08 15:13:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50001
;

-- Sep 8, 2022, 3:14:57 PM CEST
UPDATE AD_Chart SET ChartType='PC', Name='Open Requests',Updated=TO_TIMESTAMP('2022-09-08 15:14:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=50003
;

-- Sep 8, 2022, 3:15:29 PM CEST
UPDATE AD_ChartDatasource SET WhereClause='r.IsActive = ''Y'' AND rs.IsOpen=''Y''',Updated=TO_TIMESTAMP('2022-09-08 15:15:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50005
;

-- Sep 8, 2022, 3:15:53 PM CEST
UPDATE AD_ChartDatasource SET WhereClause='o.IsActive=''Y'' AND s.IsClosed=''N''',Updated=TO_TIMESTAMP('2022-09-08 15:15:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50000
;

-- Sep 8, 2022, 3:16:27 PM CEST
UPDATE AD_Chart SET ChartType='AS',Updated=TO_TIMESTAMP('2022-09-08 15:16:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=50002
;

-- Sep 8, 2022, 3:16:47 PM CEST
UPDATE AD_ChartDatasource SET WhereClause='o.DocStatus IN (''CO'',''CL'') AND o.IsSOTrx=''Y''',Updated=TO_TIMESTAMP('2022-09-08 15:16:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50003
;

-- Sep 8, 2022, 3:17:05 PM CEST
UPDATE AD_ChartDatasource SET IsActive='Y', WhereClause='o.DocStatus IN (''CO'',''CL'') AND o.IsSOTrx=''Y''',Updated=TO_TIMESTAMP('2022-09-08 15:17:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50004
;

-- Sep 8, 2022, 3:18:56 PM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,AD_Chart_ID,IsShowTitle,IsMaximizable) VALUES ('Sales YTD',0,TO_TIMESTAMP('2022-09-08 15:18:56','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2022-09-08 15:18:56','YYYY-MM-DD HH24:MI:SS'),0,200006,1,'Y','T','d32f451e-8b03-4ae9-b3b2-6ed9cd933eb3','Y','N','N',0,0,'Y',50002,'N','Y')
;

-- Sep 8, 2022, 3:19:31 PM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,AD_Chart_ID,IsShowTitle,IsMaximizable) VALUES ('Opportunities by Campaign',0,TO_TIMESTAMP('2022-09-08 15:19:30','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2022-09-08 15:19:30','YYYY-MM-DD HH24:MI:SS'),0,200007,1,'Y','T','f776a054-a735-4e56-a88b-e18c408a1715','Y','N','N',0,0,'Y',50001,'N','Y')
;

-- Sep 8, 2022, 3:20:10 PM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,AD_Chart_ID,IsShowTitle,IsMaximizable) VALUES ('Open Requests',0,TO_TIMESTAMP('2022-09-08 15:20:10','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2022-09-08 15:20:10','YYYY-MM-DD HH24:MI:SS'),0,200008,1,'Y','T','0c6621eb-ccd0-4552-86a4-ec28195a5d80','Y','N','N',0,0,'Y',50003,'N','Y')
;

-- Sep 8, 2022, 3:20:36 PM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,AD_Chart_ID,IsShowTitle,IsMaximizable) VALUES ('Sales Pipeline',0,TO_TIMESTAMP('2022-09-08 15:20:36','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2022-09-08 15:20:36','YYYY-MM-DD HH24:MI:SS'),0,200009,1,'Y','T','170cc870-327d-4f3f-affe-a1c5834dd3e7','Y','N','N',0,0,'Y',50000,'N','Y')
;

-- Sep 8, 2022, 3:27:34 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-08 15:27:34','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200000,TO_TIMESTAMP('2022-09-08 15:27:34','YYYY-MM-DD HH24:MI:SS'),100,200006,'556ba024-0f22-47fd-a736-4080b40be217',1)
;

-- Sep 8, 2022, 3:27:35 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-08 15:27:34','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200001,TO_TIMESTAMP('2022-09-08 15:27:34','YYYY-MM-DD HH24:MI:SS'),100,200009,'df5d39aa-0c03-4915-9192-ef487dfebe9e',1)
;

-- Sep 8, 2022, 3:27:35 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-08 15:27:35','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200002,TO_TIMESTAMP('2022-09-08 15:27:35','YYYY-MM-DD HH24:MI:SS'),100,200007,'26b5b678-0447-49b5-a6dc-48aa6286c6b7',1)
;

-- Sep 8, 2022, 3:27:35 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-08 15:27:35','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200003,TO_TIMESTAMP('2022-09-08 15:27:35','YYYY-MM-DD HH24:MI:SS'),100,200008,'3763992f-794f-44b9-ba5f-fc4cdad0384f',1)
;

-- Sep 8, 2022, 3:28:40 PM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-08 15:28:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200003
;

-- Sep 8, 2022, 3:29:04 PM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-08 15:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200001
;

-- Sep 8, 2022, 3:29:04 PM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-08 15:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200003
;

-- Sep 8, 2022, 3:29:13 PM CEST
UPDATE PA_DashboardPreference SET ColumnNo=2, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-08 15:29:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200000
;

-- Sep 8, 2022, 3:29:32 PM CEST
UPDATE PA_DashboardPreference SET ColumnNo=3, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-08 15:29:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200002
;

-- Sep 8, 2022, 3:47:09 PM CEST
INSERT INTO R_Request (R_Request_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,RequestAmt,Priority,DueType,Summary,IsEscalated,SalesRep_ID,C_BPartner_ID,NextAction,Processed,R_RequestType_ID,IsSelfService,R_Status_ID,PriorityUser,ConfidentialType,AD_Role_ID,IsInvoiced,ConfidentialTypeEntry,QtySpent,QtyInvoiced,StartDate,QtyPlan,R_Request_UU) VALUES (200000,11,0,'Y',TO_TIMESTAMP('2022-09-08 15:47:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 15:47:08','YYYY-MM-DD HH24:MI:SS'),100,'10000011',0,'5','5','Warranty damaged Fans','N',101,121,'F','N',102,'N',100,'5','C',102,'N','C',0,0,TO_TIMESTAMP('2022-09-08 08:45:16','YYYY-MM-DD HH24:MI:SS'),0,'3345700e-1aa5-4efe-8636-dfc0a44ecf96')
;

-- Sep 8, 2022, 3:47:09 PM CEST
INSERT INTO R_Request (R_Request_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,RequestAmt,Priority,DueType,Summary,IsEscalated,SalesRep_ID,C_BPartner_ID,NextAction,Processed,R_RequestType_ID,IsSelfService,R_Status_ID,PriorityUser,ConfidentialType,AD_Role_ID,IsInvoiced,ConfidentialTypeEntry,QtySpent,QtyInvoiced,StartDate,QtyPlan,R_Request_UU) VALUES (200001,11,0,'Y',TO_TIMESTAMP('2022-09-08 15:47:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 15:47:09','YYYY-MM-DD HH24:MI:SS'),100,'10000010',0,'5','5','Request for Joe','N',101,118,'F','N',101,'N',100,'5','C',102,'N','C',0,0,TO_TIMESTAMP('2022-09-08 08:43:20','YYYY-MM-DD HH24:MI:SS'),0,'cf40128d-2bb4-4f2c-9ddd-4d8b0d0317ef')
;

-- Sep 8, 2022, 3:47:09 PM CEST
INSERT INTO R_Request (R_Request_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,RequestAmt,Priority,DueType,Summary,IsEscalated,SalesRep_ID,C_BPartner_ID,NextAction,Processed,R_RequestType_ID,IsSelfService,R_Status_ID,PriorityUser,ConfidentialType,AD_Role_ID,IsInvoiced,ConfidentialTypeEntry,QtySpent,QtyInvoiced,StartDate,QtyPlan,R_Request_UU) VALUES (200002,11,0,'Y',TO_TIMESTAMP('2022-09-08 15:47:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 15:47:09','YYYY-MM-DD HH24:MI:SS'),100,'10000009',0,'5','5','Service from Agri-Tech','N',101,200000,'F','N',101,'N',100,'5','C',102,'N','C',0,0,TO_TIMESTAMP('2022-09-08 08:42:39','YYYY-MM-DD HH24:MI:SS'),0,'3e0c69cc-b4d5-4398-9979-849bc74a7616')
;

-- Sep 8, 2022, 3:47:10 PM CEST
INSERT INTO R_Request (R_Request_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,RequestAmt,Priority,DueType,Summary,IsEscalated,SalesRep_ID,C_BPartner_ID,NextAction,Processed,R_RequestType_ID,IsSelfService,R_Status_ID,PriorityUser,ConfidentialType,AD_Role_ID,IsInvoiced,ConfidentialTypeEntry,QtySpent,QtyInvoiced,StartDate,QtyPlan,R_Request_UU) VALUES (200003,11,0,'Y',TO_TIMESTAMP('2022-09-08 15:47:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 15:47:09','YYYY-MM-DD HH24:MI:SS'),100,'10000008',0,'5','5','Quotation for Pavement','N',101,117,'F','N',100,'N',100,'5','C',102,'N','C',0,0,TO_TIMESTAMP('2022-09-08 08:41:49','YYYY-MM-DD HH24:MI:SS'),0,'9773dc20-047f-4f6b-adaf-057fb9d48fbf')
;

-- Sep 8, 2022, 3:47:10 PM CEST
INSERT INTO R_Request (R_Request_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,RequestAmt,Priority,DueType,Summary,IsEscalated,SalesRep_ID,C_BPartner_ID,NextAction,Processed,R_RequestType_ID,IsSelfService,R_Status_ID,PriorityUser,ConfidentialType,AD_Role_ID,IsInvoiced,ConfidentialTypeEntry,QtySpent,QtyInvoiced,StartDate,QtyPlan,R_Request_UU) VALUES (200004,11,0,'Y',TO_TIMESTAMP('2022-09-08 15:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 15:47:10','YYYY-MM-DD HH24:MI:SS'),100,'10000007',0,'5','5','Quotation for Seed','N',101,120,'F','N',100,'N',100,'5','C',102,'N','C',0,0,TO_TIMESTAMP('2022-09-08 08:40:32','YYYY-MM-DD HH24:MI:SS'),0,'da8b9d33-1d04-4fa3-880a-696516720f6d')
;

-- Sep 8, 2022, 3:47:10 PM CEST
INSERT INTO R_Request (R_Request_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,RequestAmt,Priority,DueType,Summary,IsEscalated,SalesRep_ID,C_BPartner_ID,NextAction,Processed,R_RequestType_ID,IsSelfService,R_Status_ID,PriorityUser,ConfidentialType,AD_Role_ID,IsInvoiced,ConfidentialTypeEntry,QtySpent,QtyInvoiced,StartDate,QtyPlan,R_Request_UU) VALUES (200005,11,0,'Y',TO_TIMESTAMP('2022-09-08 15:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 15:47:10','YYYY-MM-DD HH24:MI:SS'),100,'10000006',0,'5','5','Damaged Notebook','N',101,117,'F','N',102,'N',100,'5','C',102,'N','C',0,0,TO_TIMESTAMP('2022-09-08 08:39:35','YYYY-MM-DD HH24:MI:SS'),0,'b8eefbdb-3dda-4b4c-8692-d5965081bb3c')
;

-- Sep 8, 2022, 3:47:11 PM CEST
INSERT INTO R_Request (R_Request_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,DocumentNo,RequestAmt,Priority,DueType,Summary,IsEscalated,SalesRep_ID,C_BPartner_ID,NextAction,Processed,R_RequestType_ID,IsSelfService,R_Status_ID,PriorityUser,ConfidentialType,AD_Role_ID,IsInvoiced,ConfidentialTypeEntry,QtySpent,QtyInvoiced,StartDate,QtyPlan,R_Request_UU) VALUES (200006,11,11,'Y',TO_TIMESTAMP('2022-09-08 15:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 15:47:10','YYYY-MM-DD HH24:MI:SS'),100,'10000005',0,'5','5','Damaged Display','N',101,120,'F','N',102,'N',100,'5','C',102,'N','C',0,0,TO_TIMESTAMP('2022-09-08 08:36:48','YYYY-MM-DD HH24:MI:SS'),0,'9be122da-5ebc-4119-a3d5-fbe836eba530')
;

-- Sep 8, 2022, 3:50:40 PM CEST
UPDATE C_SalesStage SET IsClosed='N',Updated=TO_TIMESTAMP('2022-09-08 15:50:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_SalesStage_ID=200010
;

-- Sep 8, 2022, 3:50:44 PM CEST
UPDATE C_SalesStage SET IsClosed='N',Updated=TO_TIMESTAMP('2022-09-08 15:50:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_SalesStage_ID=200009
;

