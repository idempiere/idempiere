-- IDEMPIERE-4297 organize dashboard
SELECT register_migration_script('202410031525_IDEMPIERE-4297.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 3, 2024, 3:31:34 PM CEST
UPDATE PA_DashboardContent SET ColumnNo=2,Updated=TO_TIMESTAMP('2024-10-03 15:31:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=200005
;

-- Oct 3, 2024, 3:31:56 PM CEST
UPDATE PA_DashboardContent SET Line=1, ColumnNo=2,Updated=TO_TIMESTAMP('2024-10-03 15:31:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=200002
;

-- Oct 3, 2024, 3:32:40 PM CEST
UPDATE PA_DashboardContent SET ColumnNo=4,Updated=TO_TIMESTAMP('2024-10-03 15:32:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=50003
;

-- Oct 3, 2024, 3:32:54 PM CEST
UPDATE PA_DashboardContent SET Line=0, ColumnNo=1,Updated=TO_TIMESTAMP('2024-10-03 15:32:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=50002
;

-- Oct 3, 2024, 3:33:54 PM CEST
UPDATE PA_DashboardContent SET Line=1, ColumnNo=1,Updated=TO_TIMESTAMP('2024-10-03 15:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=200019
;

-- Oct 3, 2024, 3:34:26 PM CEST
UPDATE PA_DashboardContent SET Line=1, ColumnNo=0,Updated=TO_TIMESTAMP('2024-10-03 15:34:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=200018
;

-- Oct 3, 2024, 3:34:57 PM CEST
UPDATE PA_DashboardContent SET Line=0, ColumnNo=3,Updated=TO_TIMESTAMP('2024-10-03 15:34:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=50004
;

-- Oct 3, 2024, 3:55:12 PM CEST
UPDATE AD_StatusLine SET SQLStatement='SELECT
    SUM(CASE WHEN EXTRACT(YEAR FROM Dateordered) = EXTRACT(YEAR FROM getdate()) THEN 1 ELSE 0 END) AS total_orders_current_year,
    SUM(CASE WHEN EXTRACT(YEAR FROM Dateordered) = 2002 THEN 1 ELSE 0 END) AS total_orders_2002,
    SUM(CASE WHEN EXTRACT(YEAR FROM Dateordered) = EXTRACT(YEAR FROM getdate()) THEN 1 ELSE 0 END) -
    SUM(CASE WHEN EXTRACT(YEAR FROM Dateordered) = 2002 THEN 1 ELSE 0 END) AS difference
FROM c_order
WHERE issotrx=''Y'' AND ad_client_id= @#AD_Client_ID@',Updated=TO_TIMESTAMP('2024-10-03 15:55:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_StatusLine_ID=200024
;

