SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4407 Reset Accounting showing Views in the table list
-- Aug 12, 2020, 4:00:06 AM COT
UPDATE AD_Ref_Table SET WhereClause='EXISTS (SELECT * FROM AD_Column c WHERE AD_Table.AD_Table_ID=c.AD_Table_ID AND c.IsActive=''Y'' AND  c.ColumnName=''Posted'') AND AD_Table.IsView=''N''',Updated=TO_DATE('2020-08-12 04:00:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=206
;

SELECT register_migration_script('202008121104_IDEMPIERE-4407.sql') FROM dual
;

