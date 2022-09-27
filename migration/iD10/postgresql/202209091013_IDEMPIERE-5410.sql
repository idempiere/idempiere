-- IDEMPIERE-5410-kpi
SELECT register_migration_script('202209091013_IDEMPIERE-5410.sql') FROM dual;

-- Sep 9, 2022, 10:13:47 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','<div class="kpi-title">
			{0,number,#,###} EUR</div>
<div style="kpi-text-align: center;">
	<div class="kpi-sub-text">Last 365 days</div>
</div>',0,0,'Y',TO_TIMESTAMP('2022-09-09 10:13:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 10:13:46','YYYY-MM-DD HH24:MI:SS'),100,200782,'KPI-AVG-1','D','51be543f-cc86-4962-bbc7-cf0afb10a0cd')
;

-- Sep 9, 2022, 10:16:28 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','<div class="kpi-title">
			{0,number,#,###.##} %</div>
		<div class="kpi-text">Gross Profit Margin YTD</div>

		<div style="kpi-text-align: center;">
			<div class="kpi-text {2,choice,-1#kpi-data-negative|0#|0<kpi-data-positive}">
				<div class="kpi-arrow {2,choice,-1#kpi-arrow-down|0#kpi-arrow-right|0<kpi-arrow-up}"></div>
				{2,number,#.#} %
		</div>
		<div class="kpi-sub-text">vs {1,number,#,###.##} % Previous YTD</div>
</div>',0,0,'Y',TO_TIMESTAMP('2022-09-09 10:16:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-09 10:16:28','YYYY-MM-DD HH24:MI:SS'),100,200783,'KPI-2-YTD','D','f88368c6-a767-4022-88ab-16db4de3997e')
;

-- Sep 9, 2022, 10:17:02 AM CEST
INSERT INTO AD_StatusLine (AD_StatusLine_ID,AD_Client_ID,AD_Org_ID,AD_StatusLine_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Message_ID,SQLStatement) VALUES (200021,0,0,'63f54ea1-b43f-4f43-9af1-6d8a591015bb',TO_TIMESTAMP('2022-09-09 10:17:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','KPI/Average Sales',TO_TIMESTAMP('2022-09-09 10:17:02','YYYY-MM-DD HH24:MI:SS'),100,200782,'SELECT AVG(TotalLines) FROM C_Order WHERE AD_CLient_ID = @#AD_Client_ID@ AND issotrx=''Y'' AND trunc(DateOrdered, ''DD'') BETWEEN trunc(now() -INTERVAL ''1 year'', ''DD'') AND  trunc(now(), ''DD'')')
;

-- Sep 9, 2022, 10:17:20 AM CEST
INSERT INTO AD_StatusLine (AD_StatusLine_ID,AD_Client_ID,AD_Org_ID,AD_StatusLine_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Message_ID,SQLStatement) VALUES (200022,0,0,'53f41a48-b5fc-4016-b8b6-5c450efff3ab',TO_TIMESTAMP('2022-09-09 10:17:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','KPI_Gross Profit Margin YTD',TO_TIMESTAMP('2022-09-09 10:17:20','YYYY-MM-DD HH24:MI:SS'),100,200783,'SELECT 
  ROUND (SUM(CASE WHEN kpidata.year = trunc(now(), ''Y'') THEN ((revenue-COGS)/revenue)*100 ELSE 0 END),2) as revenue_YTD ,
  ROUND (SUM(CASE WHEN kpidata.year  = trunc(now() - INTERVAL ''1 year'', ''Y'') THEN ((revenue-COGS)/revenue)*100 ELSE 0 END),2) revenue_YTD_P,
  round((SUM(CASE WHEN kpidata.year = trunc(now(), ''Y'') THEN ((revenue-COGS)/revenue)*100 ELSE 0 END) / NULLIF(SUM(CASE WHEN kpidata.year = trunc(now() - INTERVAL ''1 year'', ''Y'') THEN ((revenue-COGS)/revenue)*100 ELSE 0 END), 0) - 1) * 100, 2) as diff
  FROM
(
SELECT 
   trunc(DateAcct, ''Y'') AS year,
  COALESCE(SUM(totallines), 1) AS revenue,
  SUM(subq.cogs) as COGS
FROM C_Invoice
LEFT JOIN LATERAL ( SELECT SUM(iol.PriceLimit*iol.qtyEntered) as cogs FROM C_InvoiceLine iol WHERE iol.C_Invoice_ID = C_Invoice.C_Invoice_ID ) as subq ON 1=1
where ad_client_id=@#AD_Client_ID@ and issotrx=''Y'' 
AND ( (DateAcct + INTERVAL ''1 year'' >= trunc(now(), ''Y'') AND DateAcct + INTERVAL ''1 year'' < now() )
OR ( DateAcct >= trunc(now(), ''Y'') AND DateAcct  <= now()))
GROUP BY year
) kpidata')
;

-- Sep 9, 2022, 10:21:18 AM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,Description,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,IsShowTitle,AD_StatusLine_ID,IsMaximizable) VALUES ('Average Sales Order',0,TO_TIMESTAMP('2022-09-09 10:21:18','YYYY-MM-DD HH24:MI:SS'),100,'Average Turnover sales orders',100,'Y',0,TO_TIMESTAMP('2022-09-09 10:21:18','YYYY-MM-DD HH24:MI:SS'),0,200016,1,'Y','T','b937cfe6-c8bf-46cd-9d89-2cbc2ab33a56','Y','N','N',0,0,'Y','Y',200021,'Y')
;

-- Sep 9, 2022, 10:21:41 AM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,Description,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,IsShowTitle,AD_StatusLine_ID,IsMaximizable) VALUES ('Gross Profit Margin YTD',0,TO_TIMESTAMP('2022-09-09 10:21:41','YYYY-MM-DD HH24:MI:SS'),100,'Gross profit margin YTD calculated from invoices',100,'Y',0,TO_TIMESTAMP('2022-09-09 10:21:41','YYYY-MM-DD HH24:MI:SS'),0,200017,1,'Y','T','41fed7a9-e027-4a04-8dec-eddb4bd5b6ba','Y','N','N',0,0,'Y','Y',200022,'Y')
;

-- Sep 9, 2022, 10:27:00 AM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-09 10:27:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200010,TO_TIMESTAMP('2022-09-09 10:27:00','YYYY-MM-DD HH24:MI:SS'),100,200016,'965325d3-6290-4e80-a6f4-dda8a79d5677',1)
;

-- Sep 9, 2022, 10:27:00 AM CEST
INSERT INTO PA_DashboardPreference (AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,ColumnNo,Created,CreatedBy,IsActive,IsCollapsedByDefault,IsShowInDashboard,Line,PA_DashboardPreference_ID,Updated,UpdatedBy,PA_DashboardContent_ID,PA_DashboardPreference_UU,FlexGrow) VALUES (11,0,102,100,1,TO_TIMESTAMP('2022-09-09 10:27:00','YYYY-MM-DD HH24:MI:SS'),100,'Y','N','Y',0,200011,TO_TIMESTAMP('2022-09-09 10:27:00','YYYY-MM-DD HH24:MI:SS'),100,200017,'13b960e9-fd9b-4d20-8ec6-840b1ac92d48',1)
;

-- Sep 9, 2022, 10:28:53 AM CEST
UPDATE AD_StatusLine SET SQLStatement='SELECT AVG(TotalLines) FROM C_Order WHERE AD_CLient_ID = @#AD_Client_ID@ AND issotrx=''Y'' AND trunc(DateOrdered, ''D'') BETWEEN trunc(now() - INTERVAL ''1 year'', ''D'') AND trunc(now(), ''D'')',Updated=TO_TIMESTAMP('2022-09-09 10:28:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_StatusLine_ID=200021
;

-- Sep 9, 2022, 10:53:44 AM CEST
UPDATE AD_Message SET MsgText='<div class="kpi-title">
   <div class="kpi-arrow {2,choice,-1#kpi-arrow-down kpi-data-negative|0#kpi-arrow-right|0<kpi-arrow-up kpi-data-positive}"></div>
   {2,number,#.#} %
</div>
<div class="kpi-sub-text"> Current Month: {0}</div>
<div class="kpi-sub-text"> Last Month: {1}</div>
',Updated=TO_TIMESTAMP('2022-09-09 10:53:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200783
;

-- Sep 9, 2022, 10:54:06 AM CEST
UPDATE AD_Message SET Value='KPI-2-ORDERS',Updated=TO_TIMESTAMP('2022-09-09 10:54:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200783
;

-- Sep 9, 2022, 10:55:43 AM CEST
UPDATE AD_StatusLine SET Name='KPI_This Month Orders', SQLStatement='with months(monthFrom) as (select trunc(add_months(current_timestamp,-1), ''MM'') from dual union select trunc(current_timestamp, ''MM'') from dual)
select 
  COALESCE (ROUND (SUM(CASE WHEN kpidata.month = trunc(current_timestamp, ''MM'') THEN orders ELSE 0 END),0),0) as orders_MTD ,
  COALESCE (ROUND (SUM(CASE WHEN kpidata.month = trunc(add_months(current_timestamp,-1),''MM'') THEN orders ELSE 0 END),0),0) orders_MTD_P,  
  round((SUM(CASE WHEN kpidata.month = trunc(current_timestamp, ''MM'') THEN orders ELSE 0 END) / NULLIF(SUM(CASE WHEN kpidata.month = trunc(add_months(current_timestamp,-1),''MM'') THEN orders ELSE 0 END),0) - 1) * 100, 2) as diff
 FROM
(
SELECT 
  trunc(months.monthFrom, ''MM'') AS month,
  COUNT(c_order_id) AS orders
FROM  months
LEFT JOIN c_order ON trunc(DateOrdered, ''MM'') = months.monthFrom AND ad_client_id=@#AD_Client_ID@ and issotrx=''Y''
GROUP BY trunc(months.monthFrom, ''MM'')
) kpidata',Updated=TO_TIMESTAMP('2022-09-09 10:55:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_StatusLine_ID=200022
;

-- Sep 9, 2022, 10:58:38 AM CEST
UPDATE PA_DashboardContent SET Name='This Month Orders',Updated=TO_TIMESTAMP('2022-09-09 10:58:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=200017
;

-- Sep 9, 2022, 10:59:52 AM CEST
UPDATE AD_StatusLine SET SQLStatement='with months(monthFrom) as (select trunc(add_months(current_timestamp,-1), ''MM'') from dual union select trunc(current_timestamp, ''MM'') from dual)
select 
  COALESCE (ROUND (SUM(CASE WHEN kpidata.month = trunc(current_timestamp, ''MM'') THEN orders ELSE 0 END),0),0) as orders_MTD ,
  COALESCE (ROUND (SUM(CASE WHEN kpidata.month = trunc(add_months(current_timestamp,-1),''MM'') THEN orders ELSE 0 END),0),0) orders_MTD_P,  
  round((SUM(CASE WHEN kpidata.month = trunc(current_timestamp, ''MM'') THEN orders ELSE 0 END) / NULLIF(SUM(CASE WHEN kpidata.month = trunc(add_months(current_timestamp,-1),''MM'') THEN orders ELSE 0 END),0) - 1) * 100, 2) as diff
 FROM
(
SELECT 
  trunc(months.monthFrom, ''MM'') AS month,
  COUNT(c_order_id) AS orders
FROM  months
LEFT JOIN c_order ON trunc(DateOrdered, ''MM'') = months.monthFrom AND ad_client_id=@#AD_Client_ID@ and issotrx=''Y''
GROUP BY trunc(months.monthFrom, ''MM'')
) kpidata',Updated=TO_TIMESTAMP('2022-09-09 10:59:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_StatusLine_ID=200022
;

-- Sep 9, 2022, 11:05:00 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=5,Updated=TO_TIMESTAMP('2022-09-09 11:05:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200010
;

-- Sep 9, 2022, 11:05:12 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=7,Updated=TO_TIMESTAMP('2022-09-09 11:05:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200008
;

-- Sep 9, 2022, 11:05:21 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=6,Updated=TO_TIMESTAMP('2022-09-09 11:05:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200011
;

-- Sep 9, 2022, 11:20:58 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=1, IsShowInDashboard='Y', Line=7,Updated=TO_TIMESTAMP('2022-09-09 11:20:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200008
;

-- Sep 9, 2022, 11:21:02 AM CEST
UPDATE PA_DashboardPreference SET ColumnNo=0, IsShowInDashboard='Y', Line=7,Updated=TO_TIMESTAMP('2022-09-09 11:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardPreference_ID=200008
;

