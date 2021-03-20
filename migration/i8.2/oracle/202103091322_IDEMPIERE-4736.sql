SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 9, 2021, 1:20:04 PM CET
UPDATE AD_Ref_Table SET WhereClause='AD_Table.IsView=''N'' AND AD_Table.IsActive=''Y'' AND EXISTS (SELECT 1 FROM AD_Column c WHERE c.AD_Table_ID=AD_Table.AD_Table_ID AND UPPER(c.ColumnName)=UPPER(AD_Table.TableName)||''_ID'' AND c.IsActive=''Y'')',Updated=TO_DATE('2021-03-09 13:20:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200165
;

SELECT register_migration_script('202103091322_IDEMPIERE-4736.sql') FROM dual
;

