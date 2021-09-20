-- IDEMPIERE-4906 Dashboard showing donation message on first log-in
-- Sep 16, 2021, 5:07:33 PM CEST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2021-09-16 17:07:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200106
;

-- Sep 16, 2021, 5:07:40 PM CEST
UPDATE AD_Tab SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2021-09-16 17:07:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200112
;

-- Sep 16, 2021, 5:10:34 PM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,HTML) VALUES ('Donate',0,TO_TIMESTAMP('2021-09-16 17:10:33','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2021-09-16 17:10:33','YYYY-MM-DD HH24:MI:SS'),0,200005,1,'Y','T','961920e4-bf1d-492a-98a7-783c6f7c1d75','Y','N','N',0,0,'Y','<iframe src="https://www.idempiere.org/short-donate/" style="border-top-width: 0px;border-bottom-width: 0px;border-right-width: 0px;border-left-width: 0px;width: 100%;height: 450px;"></iframe>')
;

-- Sep 16, 2021, 5:10:40 PM CEST
INSERT INTO PA_DashboardContent_Access (PA_DashboardContent_Access_ID,PA_DashboardContent_Access_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PA_DashboardContent_ID,AD_Role_ID) VALUES (200000,'15ae66fe-34f6-4074-baa0-263813fb4dd0',0,0,'Y',TO_TIMESTAMP('2021-09-16 17:10:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-09-16 17:10:40','YYYY-MM-DD HH24:MI:SS'),100,200005,0)
;

-- Sep 16, 2021, 5:21:53 PM CEST
INSERT INTO PA_DashboardContent_Access (PA_DashboardContent_Access_ID,PA_DashboardContent_Access_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PA_DashboardContent_ID,AD_Role_ID) VALUES (200001,'f6f929c1-4bb7-4c8b-83c9-33af1651a041',11,0,'Y',TO_TIMESTAMP('2021-09-16 17:21:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-09-16 17:21:53','YYYY-MM-DD HH24:MI:SS'),100,200005,102)
;

SELECT register_migration_script('202109161712_IDEMPIERE-4906.sql') FROM dual
;

