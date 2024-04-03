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

