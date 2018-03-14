-- IDEMPIERE-3065 Sales Pipeline Chart hardcode
-- Apr 1, 2016 8:11:34 PM ICT
UPDATE AD_ChartDatasource SET Description=NULL, WhereClause='o.IsActive=''Y'' AND s.IsClosed=''N ''and o.SalesRep_ID=@#AD_User_ID@',Updated=TO_TIMESTAMP('2016-04-01 20:11:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50000
;

SELECT register_migration_script('201605082126_IDEMPIERE-3065.sql') FROM dual
;

