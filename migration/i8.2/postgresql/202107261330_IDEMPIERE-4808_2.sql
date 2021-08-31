-- Jul 26, 2021, 1:25:56 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='@SQL=SELECT CASE WHEN ''@IsSOTrx:X@''=''X'' OR ''@+IgnoreIsSOTrxInBPInfo:N@''=''Y'' THEN '''' WHEN ''@IsSOTrx:X@''=''Y'' THEN ''Y'' ELSE ''N'' END AS DefaultValue FROM DUAL',Updated=TO_TIMESTAMP('2021-07-26 13:25:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_InfoColumn_ID=200036
;

SELECT register_migration_script('202107261330_IDEMPIERE-4808_2.sql') FROM dual
;
