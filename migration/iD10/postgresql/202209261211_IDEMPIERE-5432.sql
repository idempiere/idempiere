-- IDEMPIERE-5432
SELECT register_migration_script('202209261211_IDEMPIERE-5432.sql') FROM dual;

-- Sep 30, 2022, 5:04:55 PM CEST
UPDATE AD_Window SET Help='The Performance Measure Calculation defines how performance measures will be calculated.
The sql needs to return a single value.  Please check examples.<br>
The date restriction is defined in the Goal.
Any restrictions for Organizations, Business Partners, Products, etc. are as Performance Goal Restrictions.',Updated=TO_TIMESTAMP('2022-09-30 17:04:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=213
;

-- Sep 30, 2022, 5:04:55 PM CEST
UPDATE AD_WF_Node SET Name='Performance Measure Calculation', Description='Define how you calculate your performance measures', Help='The Performance Measure Calculation defines how performance measures will be calculated.
The sql needs to return a single value.  Please check examples.<br>
The date restriction is defined in the Goal.
Any restrictions for Organizations, Business Partners, Products, etc. are as Performance Goal Restrictions.',Updated=TO_TIMESTAMP('2022-09-30 17:04:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Node_ID=148
;

-- Sep 30, 2022, 5:05:48 PM CEST
UPDATE AD_Tab SET Help='The Performance Measure Calculation defines how performance measures will be calculated. See examples.<br>
The SELECT definition must contain the SELECT and FROM keywords in upper case.  The WHERE clause can only contain values of the main table (e.g. when selecting from Header and lines, only header variables can be used in the where clause) and be fully qualified if there is more then one table.',Updated=TO_TIMESTAMP('2022-09-30 17:05:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=369
;

