-- IDEMPIERE-5410-charts
SELECT register_migration_script('202209090852_IDEMPIERE-5410.sql') FROM dual;

-- Sep 9, 2022, 8:52:43 AM CEST
INSERT INTO AD_Chart (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Chart_ID,ChartType,Name,WinHeight,IsDisplayLegend,ChartOrientation,IsTimeSeries,TimeUnit,TimeScope,DomainLabel,RangeLabel,AD_Chart_UU,EntityType) VALUES (0,0,'Y',TO_TIMESTAMP('2022-09-09 08:52:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 08:52:42','YYYY-MM-DD HH24:MI:SS'),100,200000,'BC','Order Counts Year/Month',300,'Y','V','Y','M',0,'Month','Count','7b45cfbc-0779-48e2-b768-67c7181973aa','D')
;

-- Sep 9, 2022, 8:52:43 AM CEST
INSERT INTO AD_ChartDatasource (AD_Client_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,DateColumn,EntityType,IsActive,KeyColumn,Name,AD_ChartDatasource_ID,FromClause,Updated,UpdatedBy,WhereClause,AD_Chart_ID,ValueColumn,TimeOffset,AD_ChartDatasource_UU) VALUES (0,0,259,TO_TIMESTAMP('2022-09-09 08:52:43','YYYY-MM-DD HH24:MI:SS'),100,'o.DateOrdered','D','Y','o.C_Order_ID','Last 12m',200000,'C_Order o',TO_TIMESTAMP('2022-09-09 08:52:43','YYYY-MM-DD HH24:MI:SS'),100,'o.DocStatus IN (''CO'',''CL'') AND o.IsSOTrx=''Y''',200000,'count(o.C_Order_ID)',0,'fe6ff57d-d504-4c10-8730-000fc1de9cda')
;

-- Sep 9, 2022, 8:52:44 AM CEST
INSERT INTO AD_Chart (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Chart_ID,ChartType,Name,WinHeight,IsDisplayLegend,ChartOrientation,IsTimeSeries,TimeUnit,TimeScope,DomainLabel,RangeLabel,AD_Chart_UU,EntityType) VALUES (0,0,'Y',TO_TIMESTAMP('2022-09-09 08:52:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 08:52:44','YYYY-MM-DD HH24:MI:SS'),100,200001,'LC','Monthly Orders Count',300,'Y','V','Y','M',0,'Monthly','Orders','27bbd91b-a61e-4e63-bfe0-64af5cedd43b','D')
;

-- Sep 9, 2022, 8:52:44 AM CEST
INSERT INTO AD_ChartDatasource (AD_Client_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,DateColumn,EntityType,IsActive,KeyColumn,Name,AD_ChartDatasource_ID,FromClause,Updated,UpdatedBy,WhereClause,AD_Chart_ID,ValueColumn,TimeOffset,AD_ChartDatasource_UU) VALUES (0,0,259,TO_TIMESTAMP('2022-09-09 08:52:44','YYYY-MM-DD HH24:MI:SS'),100,'o.DateOrdered','D','Y','o.C_Order_ID','Current',200001,'C_Order o',TO_TIMESTAMP('2022-09-09 08:52:44','YYYY-MM-DD HH24:MI:SS'),100,'o.DocStatus IN (''CO'',''CL'') AND o.IsSOTrx=''Y''',200001,'count(o.C_Order_ID)',0,'6a2ed1ff-2ba7-4e2d-ac53-97e6b9715e0d')
;

-- Sep 9, 2022, 8:52:45 AM CEST
INSERT INTO AD_Chart (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Chart_ID,ChartType,Name,WinHeight,IsDisplayLegend,ChartOrientation,IsTimeSeries,TimeUnit,TimeScope,DomainLabel,RangeLabel,AD_Chart_UU,EntityType) VALUES (0,0,'Y',TO_TIMESTAMP('2022-09-09 08:52:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 08:52:44','YYYY-MM-DD HH24:MI:SS'),100,200002,'WC','User Sessions',300,'Y','H','Y','M',0,'Days','Sessions','3edf7ef4-04b7-4356-8345-08122aa1a693','D')
;

-- Sep 9, 2022, 8:52:45 AM CEST
INSERT INTO AD_ChartDatasource (AD_Client_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,DateColumn,EntityType,IsActive,KeyColumn,Name,AD_ChartDatasource_ID,FromClause,Updated,UpdatedBy,AD_Chart_ID,ValueColumn,TimeOffset,SeriesColumn,AD_ChartDatasource_UU) VALUES (0,0,566,TO_TIMESTAMP('2022-09-09 08:52:45','YYYY-MM-DD HH24:MI:SS'),100,'s.created','D','Y','s.AD_Session_ID','Session',200002,'AD_Session s
INNER JOIN AD_User u ON (u.AD_User_ID=s.createdby)',TO_TIMESTAMP('2022-09-09 08:52:45','YYYY-MM-DD HH24:MI:SS'),100,200002,'count(1)',0,'u.name','1ee4a54c-04b7-4668-a3d6-d85c77652738')
;

-- Sep 9, 2022, 8:52:46 AM CEST
INSERT INTO AD_Chart (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Chart_ID,ChartType,Name,WinHeight,IsDisplayLegend,ChartOrientation,IsTimeSeries,TimeUnit,TimeScope,DomainLabel,RangeLabel,AD_Chart_UU,EntityType) VALUES (0,0,'Y',TO_TIMESTAMP('2022-09-09 08:52:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 08:52:45','YYYY-MM-DD HH24:MI:SS'),100,200003,'AC','Orders last 30 days',300,'Y','V','Y','W',0,'Day','Value','f046ce9b-7cef-4085-b479-e47c690f2585','D')
;

-- Sep 9, 2022, 8:52:46 AM CEST
INSERT INTO AD_ChartDatasource (AD_Client_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,DateColumn,EntityType,IsActive,KeyColumn,Name,AD_ChartDatasource_ID,FromClause,Updated,UpdatedBy,AD_Chart_ID,ValueColumn,TimeOffset,AD_ChartDatasource_UU) VALUES (0,0,259,TO_TIMESTAMP('2022-09-09 08:52:46','YYYY-MM-DD HH24:MI:SS'),100,'o.dateordered','D','Y','o.C_Order_ID','current',200003,'C_Order o',TO_TIMESTAMP('2022-09-09 08:52:46','YYYY-MM-DD HH24:MI:SS'),100,200003,'sum(o.grandtotal)',0,'7f05953d-8591-42d2-b6a3-a27a3381f797')
;

-- Sep 9, 2022, 8:52:47 AM CEST
INSERT INTO AD_Chart (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Chart_ID,ChartType,Name,WinHeight,IsDisplayLegend,ChartOrientation,IsTimeSeries,TimeUnit,TimeScope,DomainLabel,AD_Chart_UU,EntityType) VALUES (0,0,'Y',TO_TIMESTAMP('2022-09-09 08:52:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 08:52:47','YYYY-MM-DD HH24:MI:SS'),100,200004,'BS','Payments Montly',300,'Y','V','Y','M',0,'Month','14441c8f-8b5c-4912-ac1c-c10486c09b5c','D')
;

-- Sep 9, 2022, 9:06:23 AM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,AD_Chart_ID,IsShowTitle,IsMaximizable) VALUES ('Order Counts Year/Month',0,TO_TIMESTAMP('2022-09-09 09:06:22','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2022-09-09 09:06:22','YYYY-MM-DD HH24:MI:SS'),0,200010,1,'Y','T','5a12f351-a72c-4b78-8abb-a42d2fefef51','Y','N','N',0,0,'Y',200000,'N','Y')
;

-- Sep 9, 2022, 9:06:47 AM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,AD_Chart_ID,IsShowTitle,IsMaximizable) VALUES ('Monthly Orders Count',0,TO_TIMESTAMP('2022-09-09 09:06:47','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2022-09-09 09:06:47','YYYY-MM-DD HH24:MI:SS'),0,200011,1,'Y','T','f35ae526-3332-4761-9e9f-3aaf98815f24','Y','N','N',0,0,'Y',200001,'N','Y')
;

-- Sep 9, 2022, 9:07:01 AM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,AD_Chart_ID,IsShowTitle,IsMaximizable) VALUES ('User Sessions',0,TO_TIMESTAMP('2022-09-09 09:07:01','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2022-09-09 09:07:01','YYYY-MM-DD HH24:MI:SS'),0,200012,1,'Y','T','15fbc319-9c94-43d8-9f28-809c7b6f17dd','Y','N','N',0,0,'Y',200002,'N','Y')
;

-- Sep 9, 2022, 9:07:13 AM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,AD_Chart_ID,IsShowTitle,IsMaximizable) VALUES ('Orders last 30 days',0,TO_TIMESTAMP('2022-09-09 09:07:13','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2022-09-09 09:07:13','YYYY-MM-DD HH24:MI:SS'),0,200013,1,'Y','T','9c5fe823-f864-43c0-bf68-ec684d1634cd','Y','N','N',0,0,'Y',200003,'N','Y')
;

-- Sep 9, 2022, 9:07:34 AM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,AD_Chart_ID,IsShowTitle,IsMaximizable) VALUES ('Payments Monthly',0,TO_TIMESTAMP('2022-09-09 09:07:34','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2022-09-09 09:07:34','YYYY-MM-DD HH24:MI:SS'),0,200014,1,'Y','T','009bc630-e9d4-4adb-b116-ca3e24bff15f','Y','N','N',0,0,'Y',200004,'N','Y')
;

-- Sep 9, 2022, 9:07:50 AM CEST
UPDATE AD_Chart SET Name='Payments Monthly',Updated=TO_TIMESTAMP('2022-09-09 09:07:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=200004
;

-- Sep 9, 2022, 9:11:32 AM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-09 09:11:32','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200004,TO_TIMESTAMP('2022-09-09 09:11:32','YYYY-MM-DD HH24:MI:SS'),100,200010,'b42b1fec-1e64-4ef1-b27c-db94e638d27f',1)
;

-- Sep 9, 2022, 9:11:32 AM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-09 09:11:32','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200005,TO_TIMESTAMP('2022-09-09 09:11:32','YYYY-MM-DD HH24:MI:SS'),100,200011,'d93dd69e-ac08-44b2-8cef-3efb58066790',1)
;

-- Sep 9, 2022, 9:11:33 AM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-09 09:11:32','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200006,TO_TIMESTAMP('2022-09-09 09:11:32','YYYY-MM-DD HH24:MI:SS'),100,200012,'0e433e4f-9e6b-4a88-8b52-1c29b9c7392b',1)
;

-- Sep 9, 2022, 9:11:33 AM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-09 09:11:33','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200007,TO_TIMESTAMP('2022-09-09 09:11:33','YYYY-MM-DD HH24:MI:SS'),100,200013,'94476fed-fccb-430e-a22f-eef8de3ecf68',1)
;

-- Sep 9, 2022, 9:11:33 AM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-09 09:11:33','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200008,TO_TIMESTAMP('2022-09-09 09:11:33','YYYY-MM-DD HH24:MI:SS'),100,200014,'1157b09e-d7f1-44c0-896d-cda78c01fcc3',1)
;

-- Sep 9, 2022, 9:24:43 AM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,PA_Goal_ID,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,IsShowTitle,IsMaximizable) VALUES ('Open Invoices',0,TO_TIMESTAMP('2022-09-09 09:24:43','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,102,TO_TIMESTAMP('2022-09-09 09:24:43','YYYY-MM-DD HH24:MI:SS'),11,200015,1,'Y','G','9e95c85f-05e9-4b77-b2e0-88dbf451e950','Y','N','N',0,0,'Y','N','Y')
;

-- Sep 9, 2022, 9:28:44 AM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-09 09:28:44','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200009,TO_TIMESTAMP('2022-09-09 09:28:44','YYYY-MM-DD HH24:MI:SS'),100,200015,'2ce19b47-d9f5-4afe-bd9a-6fdeb05dd3ed',1)
;

-- Sep 12, 2022, 1:10:57 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,0,TO_TIMESTAMP('2022-09-12 13:10:57','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',2.0,200012,TO_TIMESTAMP('2022-09-12 13:10:57','YYYY-MM-DD HH24:MI:SS'),100,50002,'3f4566fc-4e43-4d9d-9e4c-1b62f1c9eaa5',1)
;

-- Sep 12, 2022, 1:10:58 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-12 13:10:57','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',7.0,200013,TO_TIMESTAMP('2022-09-12 13:10:57','YYYY-MM-DD HH24:MI:SS'),100,200002,'658debf5-f228-421f-9624-45c396c63c1d',1)
;

-- Sep 12, 2022, 1:10:58 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,0,TO_TIMESTAMP('2022-09-12 13:10:58','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200014,TO_TIMESTAMP('2022-09-12 13:10:58','YYYY-MM-DD HH24:MI:SS'),100,200003,'c03f2a33-0f42-444f-9d7b-992f5e433614',1)
;

-- Sep 12, 2022, 1:10:58 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,0,TO_TIMESTAMP('2022-09-12 13:10:58','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',1.0,200015,TO_TIMESTAMP('2022-09-12 13:10:58','YYYY-MM-DD HH24:MI:SS'),100,50001,'912fc41c-6444-4a82-b4d2-386edf9579ae',1)
;

-- Sep 12, 2022, 1:10:58 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,0,TO_TIMESTAMP('2022-09-12 13:10:58','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','N',2.0,200016,TO_TIMESTAMP('2022-09-12 13:10:58','YYYY-MM-DD HH24:MI:SS'),100,200000,'5505a251-85ac-496c-8ac4-b248479d9213',1)
;

-- Sep 12, 2022, 1:10:59 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,2,TO_TIMESTAMP('2022-09-12 13:10:58','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200017,TO_TIMESTAMP('2022-09-12 13:10:58','YYYY-MM-DD HH24:MI:SS'),100,200005,'4f228c78-bd10-45db-b2a9-797ec797a69d',1)
;

-- Sep 12, 2022, 1:10:59 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-12 13:10:59','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200018,TO_TIMESTAMP('2022-09-12 13:10:59','YYYY-MM-DD HH24:MI:SS'),100,50004,'d52a9186-9d26-4f64-9f17-ee3e03c2f078',1)
;

-- Sep 12, 2022, 1:10:59 PM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,3,TO_TIMESTAMP('2022-09-12 13:10:59','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200019,TO_TIMESTAMP('2022-09-12 13:10:59','YYYY-MM-DD HH24:MI:SS'),100,50003,'cfd05db9-5ce9-4d24-8e3f-b20958043cd5',1)
;

-- Sep 9, 2022, 9:29:10 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=2, IsShowInDashboard='Y', Line=0,Updated=TO_TIMESTAMP('2022-09-09 09:29:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200009
;

-- Sep 9, 2022, 9:29:10 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=4, IsShowInDashboard='Y', Line=0,Updated=TO_TIMESTAMP('2022-09-09 09:29:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200004
;

-- Sep 9, 2022, 9:29:10 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=5, IsShowInDashboard='Y', Line=0,Updated=TO_TIMESTAMP('2022-09-09 09:29:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200005
;

-- Sep 9, 2022, 9:29:10 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=6, IsShowInDashboard='Y', Line=0,Updated=TO_TIMESTAMP('2022-09-09 09:29:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200006
;

-- Sep 9, 2022, 9:29:10 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=7, IsShowInDashboard='Y', Line=0,Updated=TO_TIMESTAMP('2022-09-09 09:29:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200007
;

-- Sep 9, 2022, 9:29:10 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=8, IsShowInDashboard='Y', Line=0,Updated=TO_TIMESTAMP('2022-09-09 09:29:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200008
;

-- Sep 9, 2022, 9:29:26 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200004
;

-- Sep 9, 2022, 9:29:37 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200007
;

-- Sep 9, 2022, 9:29:37 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200004
;

-- Sep 9, 2022, 9:29:45 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200005
;

-- Sep 9, 2022, 9:29:45 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200007
;

-- Sep 9, 2022, 9:29:45 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=2, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200004
;

-- Sep 9, 2022, 9:29:48 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200006
;

-- Sep 9, 2022, 9:29:48 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200005
;

-- Sep 9, 2022, 9:29:48 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=2, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200007
;

-- Sep 9, 2022, 9:29:48 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=3, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200004
;

-- Sep 9, 2022, 9:29:57 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200008
;

-- Sep 9, 2022, 9:29:57 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200006
;

-- Sep 9, 2022, 9:29:57 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=2, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200005
;

-- Sep 9, 2022, 9:29:57 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=3, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200007
;

-- Sep 9, 2022, 9:29:57 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=4, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:29:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200004
;

-- Sep 9, 2022, 9:30:07 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=4,Updated=TO_TIMESTAMP('2022-09-09 09:30:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200008
;

-- Sep 9, 2022, 9:30:12 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=4,Updated=TO_TIMESTAMP('2022-09-09 09:30:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200006
;

-- Sep 9, 2022, 9:30:12 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=4,Updated=TO_TIMESTAMP('2022-09-09 09:30:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200008
;

-- Sep 9, 2022, 9:30:18 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=5,Updated=TO_TIMESTAMP('2022-09-09 09:30:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200008
;

-- Sep 9, 2022, 9:30:42 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-09 09:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200001
;

-- Sep 9, 2022, 9:30:42 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=2, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-09 09:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200003
;

-- Sep 9, 2022, 9:30:42 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=3, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-09 09:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200009
;

-- Sep 9, 2022, 9:30:42 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=4, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-09 09:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200000
;

-- Sep 9, 2022, 9:30:42 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=5, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-09 09:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200002
;

-- Sep 9, 2022, 9:31:06 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=5, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-09 09:31:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200000
;

-- Sep 9, 2022, 9:31:06 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=6, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-09 09:31:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200002
;

-- Sep 9, 2022, 9:31:22 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=4, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-09 09:31:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200000
;

-- Sep 9, 2022, 9:31:22 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=5, IsShowInDashboard='Y', Line=2,Updated=TO_TIMESTAMP('2022-09-09 09:31:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200002
;

-- Sep 9, 2022, 9:31:30 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:31:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200003
;

-- Sep 9, 2022, 9:31:30 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:31:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200005
;

-- Sep 9, 2022, 9:31:30 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=2, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:31:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200007
;

-- Sep 9, 2022, 9:31:30 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=3, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:31:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200004
;

-- Sep 9, 2022, 9:32:02 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=4,Updated=TO_TIMESTAMP('2022-09-09 09:32:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200005
;

-- Sep 9, 2022, 9:32:02 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=4,Updated=TO_TIMESTAMP('2022-09-09 09:32:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200006
;

-- Sep 9, 2022, 9:32:21 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=5,Updated=TO_TIMESTAMP('2022-09-09 09:32:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200008
;

-- Sep 9, 2022, 9:32:43 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=6,Updated=TO_TIMESTAMP('2022-09-09 09:32:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200006
;

-- Sep 9, 2022, 9:33:10 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=4,Updated=TO_TIMESTAMP('2022-09-09 09:33:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200009
;

-- Sep 9, 2022, 9:33:10 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=4,Updated=TO_TIMESTAMP('2022-09-09 09:33:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200005
;

-- Sep 9, 2022, 9:33:14 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=4,Updated=TO_TIMESTAMP('2022-09-09 09:33:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200005
;

-- Sep 9, 2022, 9:33:14 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=4,Updated=TO_TIMESTAMP('2022-09-09 09:33:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200009
;

-- Sep 9, 2022, 9:33:42 AM CEST
UPDATE PA_DashboardPreference SET FlexGrow=3,Updated=TO_TIMESTAMP('2022-09-09 09:33:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200005
;

-- Sep 9, 2022, 9:34:15 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200007
;

-- Sep 9, 2022, 9:34:15 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=2, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200002
;

-- Sep 9, 2022, 9:34:24 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=5,Updated=TO_TIMESTAMP('2022-09-09 09:34:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200007
;

-- Sep 9, 2022, 9:34:24 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=2, IsShowInDashboard='Y', Line=5,Updated=TO_TIMESTAMP('2022-09-09 09:34:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200008
;

-- Sep 9, 2022, 9:34:30 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=6,Updated=TO_TIMESTAMP('2022-09-09 09:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200006
;

-- Sep 9, 2022, 9:34:50 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:34:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200004
;

-- Sep 9, 2022, 9:34:50 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=3,Updated=TO_TIMESTAMP('2022-09-09 09:34:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200003
;

-- Sep 9, 2022, 9:35:09 AM CEST
UPDATE PA_DashboardPreference SET FlexGrow=2,Updated=TO_TIMESTAMP('2022-09-09 09:35:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200004
;

-- Sep 9, 2022, 9:38:25 AM CEST
UPDATE AD_Chart SET TimeScope=12,Updated=TO_TIMESTAMP('2022-09-09 09:38:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=200000
;

-- Sep 9, 2022, 9:38:40 AM CEST
UPDATE AD_Chart SET TimeScope=12,Updated=TO_TIMESTAMP('2022-09-09 09:38:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=200001
;

-- Sep 9, 2022, 9:38:54 AM CEST
UPDATE AD_Chart SET TimeScope=90,Updated=TO_TIMESTAMP('2022-09-09 09:38:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=200002
;

-- Sep 9, 2022, 9:39:08 AM CEST
UPDATE AD_Chart SET TimeScope=120,Updated=TO_TIMESTAMP('2022-09-09 09:39:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=200003
;

-- Sep 9, 2022, 9:39:19 AM CEST
UPDATE AD_Chart SET TimeScope=12,Updated=TO_TIMESTAMP('2022-09-09 09:39:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Chart_ID=200004
;

