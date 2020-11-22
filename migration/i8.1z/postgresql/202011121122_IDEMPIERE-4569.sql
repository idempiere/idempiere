-- IDEMPIERE-4569 PostgreSQL Native error on Asset Material Receipt
-- Nov 31, 2020, 11:22:07 AM
UPDATE AD_Column SET ColumnSql  = '(case when UseLifeMonths - (case when A_Current_Period = 0 then 1 else A_Current_Period end )+ 1> 0 then (A_Asset_Cost - A_Accumulated_Depr)/(UseLifeMonths - (case when A_Current_period = 0 then 1 else A_Current_Period end) + 1) else 0 end)' WHERE  AD_Column_ID = 59287
;

UPDATE AD_Column SET ColumnSql  = '(case when UseLifeMonths_F - (case when A_Current_Period = 0 then 1 else A_Current_Period end )+ 1 > 0 then (A_Asset_Cost - A_Accumulated_Depr_F)/(UseLifeMonths_F - (case when A_Current_Period = 0 then 1 else A_Current_Period end ) + 1) else 0 end)' WHERE  AD_Column_ID = 59288
;

SELECT register_migration_script('202011121122_IDEMPIERE-4569.sql') FROM dual
;
