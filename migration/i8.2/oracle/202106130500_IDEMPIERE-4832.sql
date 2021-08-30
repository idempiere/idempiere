SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 13, 2021, 10:51:43 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@AD_Client_ID@=0',Updated=TO_DATE('2021-06-13 10:51:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2350
;

-- Jun 13, 2021, 10:52:46 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@AD_Client_ID@=0',Updated=TO_DATE('2021-06-13 10:52:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3881
;

-- Jun 13, 2021, 10:53:25 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@AD_Client_ID@=0',Updated=TO_DATE('2021-06-13 10:53:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6735
;

-- Jun 13, 2021, 10:55:03 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@DocStatus@!CO',Updated=TO_DATE('2021-06-13 10:55:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56376
;

-- Jun 13, 2021, 10:58:22 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@OldName@!''''',Updated=TO_DATE('2021-06-13 10:58:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7804
;

-- Jun 13, 2021, 10:59:12 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@AD_Client_ID@=0',Updated=TO_DATE('2021-06-13 10:59:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2349
;

-- Jun 13, 2021, 10:59:31 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@AD_Client_ID@=0',Updated=TO_DATE('2021-06-13 10:59:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2347
;

-- Jun 13, 2021, 10:59:52 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@AD_Client_ID@=0',Updated=TO_DATE('2021-06-13 10:59:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2348
;

-- Jun 13, 2021, 11:00:13 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@AD_Client_ID@=0',Updated=TO_DATE('2021-06-13 11:00:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1983
;

-- Jun 13, 2021, 11:00:33 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@AD_Client_ID@=0',Updated=TO_DATE('2021-06-13 11:00:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3883
;

-- Jun 13, 2021, 11:00:50 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@AD_Client_ID@=0',Updated=TO_DATE('2021-06-13 11:00:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5956
;

-- Jun 13, 2021, 11:03:24 AM MYT
UPDATE AD_Field SET DisplayLogic='@IsIdentifier@=''Y'' & @AD_Column_ID@!0',Updated=TO_DATE('2021-06-13 11:03:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201368
;

-- Jun 13, 2021, 11:04:20 AM MYT
UPDATE AD_Field SET DisplayLogic='@IsIdentifier@=''Y'' & @AD_Column_ID@!0',Updated=TO_DATE('2021-06-13 11:04:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201365
;

-- Jun 13, 2021, 11:05:51 AM MYT
UPDATE AD_Field SET DisplayLogic='@AD_Process_ID.IsReport@=Y & @AD_Process_ID.JasperReport@=''''',Updated=TO_DATE('2021-06-13 11:05:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206075
;

-- Jun 13, 2021, 11:07:31 AM MYT
UPDATE AD_Field SET DisplayLogic='@Type@=''D''|@Type@=''DS''|@Type@=''SQL''|@Type@=''SQM''',Updated=TO_DATE('2021-06-13 11:07:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50105
;

SELECT register_migration_script('202106130500_IDEMPIERE-4832.sql') FROM dual
;

