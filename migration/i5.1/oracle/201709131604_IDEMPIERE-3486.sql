SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3486 add default logic for customize and vendor parameter
-- Sep 13, 2017 9:25:06 PM ICT
UPDATE AD_InfoColumn SET DefaultValue='@IsSOTrx@',Updated=TO_DATE('2017-09-13 21:25:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200036
;

-- Sep 13, 2017 9:25:14 PM ICT
UPDATE AD_InfoColumn SET DefaultValue='@SQL=SELECT CASE ''@IsSOTrx@'' WHEN '''' THEN '''' WHEN ''N'' THEN ''Y'' ELSE ''N'' END AS DefaultValue FROM DUAL',Updated=TO_DATE('2017-09-13 21:25:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200037
;

SELECT register_migration_script('201709131604_IDEMPIERE-3486.sql') FROM dual
;
