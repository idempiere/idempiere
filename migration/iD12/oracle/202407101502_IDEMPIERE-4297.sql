-- IDEMPIERE-4297 - Add Status Line Dashboard Examples to GW
SELECT register_migration_script('202407101502_IDEMPIERE-4297.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 10, 2024, 3:02:44 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','<h2 style="text-align: center;">
   <div style="{2,choice,-1#color:red;|0#color:gray;|0<color:green;}">{2,number,#.#}</div>
</h2>
<div style="font-size: small; text-align: center;">Order Count</div>
<div style="font-size: small; color: gray; margin-top: 5px;">
   Top Year (2002): {1}
</div>
<div style="font-size: small; color: gray; margin-top: 5px;">
   Current Year: {0}
</div>',0,0,'Y',TO_TIMESTAMP('2024-07-10 15:02:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-07-10 15:02:44','YYYY-MM-DD HH24:MI:SS'),100,200901,'Dashboard_OrderCount','D','0f81b4a1-1884-4672-8844-0f638423cd0f')
;

-- Jul 10, 2024, 3:03:10 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Total Sales: ${0,number,#,##0}',0,0,'Y',TO_TIMESTAMP('2024-07-10 15:03:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-07-10 15:03:10','YYYY-MM-DD HH24:MI:SS'),100,200902,'Dashboard_TotalSales','D','2a787df3-0b25-4c72-b15b-c0379ff67131')
;

-- Jul 10, 2024, 3:03:47 PM CEST
INSERT INTO AD_StatusLine (AD_StatusLine_ID,AD_Client_ID,AD_Org_ID,AD_StatusLine_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Message_ID,SQLStatement) VALUES (200023,0,0,'aa72e4e9-f1af-4f28-82cd-e2675ac6be96',TO_TIMESTAMP('2024-07-10 15:03:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Dashboard_TotalSales',TO_TIMESTAMP('2024-07-10 15:03:47','YYYY-MM-DD HH24:MI:SS'),100,200902,'SELECT SUM(grandtotal)
FROM rv_c_invoice 
WHERE docstatus IN (''CO'',''CL'') 
AND issotrx = ''Y'' 
AND ad_client_id = @#AD_Client_ID@
')
;

-- Jul 10, 2024, 3:04:11 PM CEST
INSERT INTO AD_StatusLine (AD_StatusLine_ID,AD_Client_ID,AD_Org_ID,AD_StatusLine_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Message_ID,SQLStatement) VALUES (200024,0,0,'daf11ab7-a62a-4d09-8df7-b93659f2c364',TO_TIMESTAMP('2024-07-10 15:04:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Dashboard_OrderCount',TO_TIMESTAMP('2024-07-10 15:04:11','YYYY-MM-DD HH24:MI:SS'),100,200901,'SELECT 
    SUM(CASE WHEN EXTRACT(YEAR FROM Dateordered) = EXTRACT(YEAR FROM getdate()) THEN 1 ELSE 0 END) AS total_orders_current_year,
    SUM(CASE WHEN EXTRACT(YEAR FROM Dateordered) = 2002 THEN 1 ELSE 0 END) AS total_orders_2002,
    SUM(CASE WHEN EXTRACT(YEAR FROM Dateordered) = EXTRACT(YEAR FROM getdate()) THEN 1 ELSE 0 END) -
    SUM(CASE WHEN EXTRACT(YEAR FROM Dateordered) = 2002 THEN 1 ELSE 0 END) AS difference
FROM c_order
WHERE issotrx=''Y'' AND ad_client_id= @#AD_Client_ID@;')
;

-- Jul 10, 2024, 3:05:11 PM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,IsShowTitle,AD_StatusLine_ID,IsMaximizable) VALUES ('KPI1',0,TO_TIMESTAMP('2024-07-10 15:05:11','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2024-07-10 15:05:11','YYYY-MM-DD HH24:MI:SS'),11,200018,1,'Y','T','743302ff-1906-4f48-9db4-5367d6cbb20d','Y','N','N',0,0,'Y','Y',200024,'N')
;

-- Jul 10, 2024, 3:05:26 PM CEST
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin,IsShowTitle,AD_StatusLine_ID,IsMaximizable) VALUES ('KPI2',0,TO_TIMESTAMP('2024-07-10 15:05:26','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2024-07-10 15:05:26','YYYY-MM-DD HH24:MI:SS'),11,200019,1,'Y','T','2e1093ab-1914-4a15-8110-87257cd29655','Y','N','N',0,0,'Y','Y',200023,'N')
;

