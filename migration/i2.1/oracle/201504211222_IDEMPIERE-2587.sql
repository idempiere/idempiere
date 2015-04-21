SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2587 Can't login by SuperUser to client with client roles has Use User Org Access
-- Apr 21, 2015 12:20:54 PM COT
UPDATE AD_Tab SET WhereClause=NULL,Updated=TO_DATE('2015-04-21 12:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=118
;

-- Apr 21, 2015 12:21:25 PM COT
UPDATE AD_Column SET DefaultValue='@#AD_Client_ID@',Updated=TO_DATE('2015-04-21 12:21:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13440
;

-- Apr 21, 2015 12:21:30 PM COT
UPDATE AD_Column SET DefaultValue='@#AD_Org_ID@', IsUpdateable='N',Updated=TO_DATE('2015-04-21 12:21:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13439
;

SELECT register_migration_script('201504211222_IDEMPIERE-2587.sql') FROM dual
;

