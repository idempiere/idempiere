-- IDEMPIERE-6064 Error when creating a table with a long name through CreateTable process
SELECT register_migration_script('202404031226_IDEMPIERE-6064.sql') FROM dual;

-- Apr 3, 2024, 12:26:12 PM CEST
UPDATE AD_Column SET FieldLength=60, SeqNoSelection=10,Updated=TO_TIMESTAMP('2024-04-03 12:26:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=107
;

-- Apr 3, 2024, 12:26:13 PM CEST
INSERT INTO t_alter_column values('ad_table','TableName','VARCHAR(60)',null,null)
;

-- Apr 3, 2024, 12:26:43 PM CEST
UPDATE AD_Column SET FieldLength=63, SeqNoSelection=10,Updated=TO_TIMESTAMP('2024-04-03 12:26:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=116
;

-- Apr 3, 2024, 12:27:50 PM CEST
UPDATE AD_Column SET FieldLength=63, SeqNoSelection=20,Updated=TO_TIMESTAMP('2024-04-03 12:27:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210871
;

-- Apr 3, 2024, 12:27:55 PM CEST
INSERT INTO t_alter_column values('ad_column','FKConstraintName','VARCHAR(63)',null,'NULL')
;

-- Apr 3, 2024, 12:28:10 PM CEST
INSERT INTO t_alter_column values('ad_column','ColumnName','VARCHAR(63)',null,null)
;

-- Apr 3, 2024, 12:28:52 PM CEST
UPDATE AD_Column SET FieldLength=63, SeqNoSelection=10,Updated=TO_TIMESTAMP('2024-04-03 12:28:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2602
;

-- Apr 3, 2024, 12:29:03 PM CEST
INSERT INTO t_alter_column values('ad_element','ColumnName','VARCHAR(63)',null,null)
;

-- Apr 3, 2024, 12:30:26 PM CEST
UPDATE AD_Column SET FieldLength=63, SeqNoSelection=10,Updated=TO_TIMESTAMP('2024-04-03 12:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210585
;

-- Apr 3, 2024, 12:30:27 PM CEST
INSERT INTO t_alter_column values('ad_viewcolumn','ColumnName','VARCHAR(63)',null,null)
;

-- Apr 3, 2024, 12:30:46 PM CEST
UPDATE AD_Column SET FieldLength=63, SeqNoSelection=10,Updated=TO_TIMESTAMP('2024-04-03 12:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202042
;

-- Apr 3, 2024, 12:30:47 PM CEST
INSERT INTO t_alter_column values('ws_webservicefieldinput','ColumnName','VARCHAR(63)',null,'NULL')
;

-- Apr 3, 2024, 12:30:57 PM CEST
UPDATE AD_Column SET FieldLength=63,Updated=TO_TIMESTAMP('2024-04-03 12:30:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208350
;

-- Apr 3, 2024, 12:30:58 PM CEST
INSERT INTO t_alter_column values('ad_infocolumn','ColumnName','VARCHAR(63)',null,null)
;

-- Apr 3, 2024, 12:31:30 PM CEST
UPDATE AD_Column SET FieldLength=63,Updated=TO_TIMESTAMP('2024-04-03 12:31:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4017
;

-- Apr 3, 2024, 12:31:31 PM CEST
INSERT INTO t_alter_column values('ad_process_para','ColumnName','VARCHAR(63)',null,null)
;

-- Apr 3, 2024, 12:32:06 PM CEST
UPDATE AD_Column SET FieldLength=60,Updated=TO_TIMESTAMP('2024-04-03 12:32:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213696
;

-- Apr 3, 2024, 12:32:08 PM CEST
INSERT INTO t_alter_column values('ad_housekeeping','TableName','VARCHAR(60)',null,'NULL')
;

-- Apr 3, 2024, 12:33:04 PM CEST
UPDATE AD_Column SET FieldLength=63,Updated=TO_TIMESTAMP('2024-04-03 12:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216297
;

-- Apr 3, 2024, 12:33:12 PM CEST
INSERT INTO t_alter_column values('ad_tablepartition','Name','VARCHAR(63)',null,null)
;

-- Apr 3, 2024, 12:33:30 PM CEST
UPDATE AD_Column SET FieldLength=63,Updated=TO_TIMESTAMP('2024-04-03 12:33:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210522
;

-- Apr 3, 2024, 12:33:31 PM CEST
INSERT INTO t_alter_column values('ad_tableindex','Name','VARCHAR(63)',null,null)
;

-- Apr 3, 2024, 3:46:48 PM CEST
UPDATE AD_Process_Para SET FieldLength=60,Updated=TO_TIMESTAMP('2024-04-03 15:46:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53495
;

-- Apr 3, 2024, 3:46:58 PM CEST
UPDATE AD_Process_Para SET FieldLength=60,Updated=TO_TIMESTAMP('2024-04-03 15:46:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200354
;

-- Apr 3, 2024, 3:48:19 PM CEST
UPDATE AD_Column SET FieldLength=63, SeqNoSelection=10,Updated=TO_TIMESTAMP('2024-04-03 15:48:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11819
;

-- Apr 3, 2024, 3:48:27 PM CEST
INSERT INTO t_alter_column values('a_registrationattribute','ColumnName','VARCHAR(63)',null,'NULL')
;

-- Apr 3, 2024, 3:50:29 PM CEST
UPDATE AD_Process_Para SET FieldLength=63,Updated=TO_TIMESTAMP('2024-04-03 15:50:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200303
;

-- Apr 3, 2024, 3:51:50 PM CEST
UPDATE AD_Process_Para SET FieldLength=63,Updated=TO_TIMESTAMP('2024-04-03 15:51:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200306
;

-- Apr 3, 2024, 3:53:27 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:53:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5941
;

-- Apr 3, 2024, 3:53:36 PM CEST
INSERT INTO t_alter_column values('pa_measurecalc','BPartnerColumn','VARCHAR(124)',null,'x.C_BPartner_ID')
;

-- Apr 3, 2024, 3:54:01 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:54:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200528
;

-- Apr 3, 2024, 3:54:04 PM CEST
INSERT INTO t_alter_column values('gl_journalgeneratorline','BPColumn','VARCHAR(124)',null,'NULL')
;

-- Apr 3, 2024, 3:54:20 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:54:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59701
;

-- Apr 3, 2024, 3:54:23 PM CEST
INSERT INTO t_alter_column values('ad_chartdatasource','CategoryColumn','VARCHAR(124)',null,'NULL')
;

-- Apr 3, 2024, 3:55:11 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:55:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54272
;

-- Apr 3, 2024, 3:55:14 PM CEST
INSERT INTO t_alter_column values('ad_sequence','DateColumn','VARCHAR(124)',null,'NULL')
;

-- Apr 3, 2024, 3:55:24 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:55:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5939
;

-- Apr 3, 2024, 3:55:26 PM CEST
INSERT INTO t_alter_column values('pa_measurecalc','DateColumn','VARCHAR(124)',null,'x.Date')
;

-- Apr 3, 2024, 3:55:26 PM CEST
UPDATE PA_MeasureCalc SET DateColumn='x.Date' WHERE DateColumn IS NULL
;

-- Apr 3, 2024, 3:55:42 PM CEST
UPDATE AD_Column SET FieldLength=124, IsToolbarButton='N',Updated=TO_TIMESTAMP('2024-04-03 15:55:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59673
;

-- Apr 3, 2024, 3:55:44 PM CEST
INSERT INTO t_alter_column values('ad_chartdatasource','DateColumn','VARCHAR(124)',null,'NULL')
;

-- Apr 3, 2024, 3:56:13 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:56:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5662
;

-- Apr 3, 2024, 3:56:14 PM CEST
INSERT INTO t_alter_column values('ad_reportview_col','FunctionColumn','VARCHAR(124)',null,null)
;

-- Apr 3, 2024, 3:56:37 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:56:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14780
;

-- Apr 3, 2024, 3:56:39 PM CEST
INSERT INTO t_alter_column values('pa_measurecalc','KeyColumn','VARCHAR(124)',null,null)
;

-- Apr 3, 2024, 3:56:52 PM CEST
UPDATE AD_Column SET FieldLength=124, IsToolbarButton='N',Updated=TO_TIMESTAMP('2024-04-03 15:56:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59677
;

-- Apr 3, 2024, 3:56:54 PM CEST
INSERT INTO t_alter_column values('ad_chartdatasource','KeyColumn','VARCHAR(124)',null,'NULL')
;

-- Apr 3, 2024, 3:57:25 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:57:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200214
;

-- Apr 3, 2024, 3:57:26 PM CEST
INSERT INTO t_alter_column values('ad_sequence','OrgColumn','VARCHAR(124)',null,'NULL')
;

-- Apr 3, 2024, 3:57:35 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:57:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5940
;

-- Apr 3, 2024, 3:57:36 PM CEST
INSERT INTO t_alter_column values('pa_measurecalc','OrgColumn','VARCHAR(124)',null,'x.AD_Org_ID')
;

-- Apr 3, 2024, 3:57:36 PM CEST
UPDATE PA_MeasureCalc SET OrgColumn='x.AD_Org_ID' WHERE OrgColumn IS NULL
;

-- Apr 3, 2024, 3:57:36 PM CEST
INSERT INTO t_alter_column values('pa_measurecalc','OrgColumn',null,'NOT NULL',null)
;

-- Apr 3, 2024, 3:57:49 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:57:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5942
;

-- Apr 3, 2024, 3:57:51 PM CEST
INSERT INTO t_alter_column values('pa_measurecalc','ProductColumn','VARCHAR(124)',null,'x.M_Product_ID')
;

-- Apr 3, 2024, 3:58:03 PM CEST
UPDATE AD_Column SET FieldLength=124,Updated=TO_TIMESTAMP('2024-04-03 15:58:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210647
;

-- Apr 3, 2024, 3:58:04 PM CEST
INSERT INTO t_alter_column values('ad_chartdatasource','SeriesColumn','VARCHAR(124)',null,'NULL')
;

-- Apr 3, 2024, 3:58:25 PM CEST
UPDATE AD_Column SET FieldLength=124, IsToolbarButton='N',Updated=TO_TIMESTAMP('2024-04-03 15:58:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59700
;

-- Apr 3, 2024, 3:58:27 PM CEST
INSERT INTO t_alter_column values('ad_chartdatasource','ValueColumn','VARCHAR(124)',null,null)
;

