-- IDEMPIERE-5432
SELECT register_migration_script('202209261211_IDEMPIERE-5432.sql') FROM dual;

-- Sep 26, 2022, 12:11:19 PM CEST
UPDATE PA_MeasureCalc SET WhereClause='IsSOTrx=''Y'' AND Processed=''Y''',Updated=TO_TIMESTAMP('2022-09-26 12:11:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_MeasureCalc_ID=101
;

-- Sep 26, 2022, 12:11:26 PM CEST
UPDATE PA_MeasureCalc SET WhereClause='C_Invoice.IsSOTrx=''Y'' AND C_Invoice.Processed=''Y''',Updated=TO_TIMESTAMP('2022-09-26 12:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_MeasureCalc_ID=100
;

-- Sep 26, 2022, 12:11:32 PM CEST
UPDATE PA_MeasureCalc SET WhereClause='C_Invoice.IsSOTrx=''Y'' AND C_Invoice.Processed=''Y'' AND C_Invoice.IsPaid=''Y''
',Updated=TO_TIMESTAMP('2022-09-26 12:11:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_MeasureCalc_ID=104
;

-- Sep 26, 2022, 12:11:36 PM CEST
UPDATE PA_MeasureCalc SET WhereClause='C_Invoice.IsSOTrx=''Y'' AND C_Invoice.Processed=''Y''',Updated=TO_TIMESTAMP('2022-09-26 12:11:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_MeasureCalc_ID=102
;

-- Sep 26, 2022, 12:11:40 PM CEST
UPDATE PA_MeasureCalc SET WhereClause='IsCustomer=''Y''',Updated=TO_TIMESTAMP('2022-09-26 12:11:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_MeasureCalc_ID=103
;

-- Sep 26, 2022, 12:11:43 PM CEST
UPDATE PA_MeasureCalc SET WhereClause='IsSOTrx=''Y'' AND Processed=''Y''',Updated=TO_TIMESTAMP('2022-09-26 12:11:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_MeasureCalc_ID=105
;

