-- Nov 28, 2013 9:18:15 AM CET
-- IDEMPIERE-1575
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2013-11-28 09:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14862
;

-- Nov 28, 2013 9:18:17 AM CET
INSERT INTO t_alter_column values('ad_issue','LoggerName','VARCHAR(255)',null,'NULL')
;

-- Nov 28, 2013 9:18:33 AM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2013-11-28 09:18:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14860
;

-- Nov 28, 2013 9:18:33 AM CET
INSERT INTO t_alter_column values('ad_issue','SourceClassName','VARCHAR(255)',null,'NULL')
;

-- Nov 28, 2013 9:19:32 AM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2013-11-28 09:19:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5664
;

-- Nov 28, 2013 9:19:33 AM CET
INSERT INTO t_alter_column values('ad_pinstance_para','Info','VARCHAR(255)',null,'NULL')
;

-- Nov 28, 2013 9:20:44 AM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2013-11-28 09:20:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14922
;

-- Nov 28, 2013 9:20:45 AM CET
INSERT INTO t_alter_column values('ad_system','ProfileInfo','VARCHAR(255)',null,'NULL')
;

-- Nov 28, 2013 9:21:02 AM CET
UPDATE AD_Column SET FieldLength=120,Updated=TO_TIMESTAMP('2013-11-28 09:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2902
;

-- Nov 28, 2013 9:21:03 AM CET
INSERT INTO t_alter_column values('c_bpartner','Name','VARCHAR(120)',null,null)
;

-- Nov 28, 2013 9:21:17 AM CET
UPDATE AD_Column SET FieldLength=120,Updated=TO_TIMESTAMP('2013-11-28 09:21:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1135
;

-- Nov 28, 2013 9:21:18 AM CET
INSERT INTO t_alter_column values('c_elementvalue','Name','VARCHAR(120)',null,null)
;

-- Nov 28, 2013 9:21:26 AM CET
UPDATE AD_Column SET FieldLength=120,Updated=TO_TIMESTAMP('2013-11-28 09:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3163
;

-- Nov 28, 2013 9:21:26 AM CET
INSERT INTO t_alter_column values('c_elementvalue_trl','Name','VARCHAR(120)',null,null)
;

-- Nov 28, 2013 9:21:42 AM CET
UPDATE AD_Column SET FieldLength=120,Updated=TO_TIMESTAMP('2013-11-28 09:21:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5617
;

-- Nov 28, 2013 9:21:43 AM CET
INSERT INTO t_alter_column values('c_payselection','Name','VARCHAR(120)',null,null)
;

-- Dec 11, 2013 1:49:22 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2013-12-11 13:49:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5950
;

-- Dec 11, 2013 1:49:22 PM CET
INSERT INTO t_alter_column values('ad_note','Reference','VARCHAR(255)',null,'NULL')
;

SELECT register_migration_script('201311280926_IDEMPIERE-1575.sql') FROM dual
;
