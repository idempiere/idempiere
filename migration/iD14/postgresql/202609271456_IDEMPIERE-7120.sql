-- IDEMPIERE-7120 Implement UUID Document No Sequences
SELECT register_migration_script('202609271456_IDEMPIERE-7120.sql') FROM dual;

-- Sep 27, 2026, 2:56:32 PM CEST
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-27 14:56:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9273
;

-- Sep 27, 2026, 2:56:37 PM CEST
INSERT INTO t_alter_column values('i_gljournal','BatchDocumentNo','VARCHAR(255)',null,'NULL')
;

-- Sep 27, 2026, 2:56:47 PM CEST
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-27 14:56:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9773
;

-- Sep 27, 2026, 2:56:49 PM CEST
INSERT INTO t_alter_column values('i_gljournal','JournalDocumentNo','VARCHAR(255)',null,'NULL')
;

-- Sep 27, 2026, 2:57:26 PM CEST
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-27 14:57:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5617
;

-- Sep 27, 2026, 2:57:28 PM CEST
INSERT INTO t_alter_column values('c_payselection','Name','VARCHAR(255)',null,null)
;

-- Sep 27, 2026, 2:58:11 PM CEST
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-27 14:58:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5049
;

-- Sep 27, 2026, 2:58:13 PM CEST
INSERT INTO t_alter_column values('c_payment','CheckNo','VARCHAR(255)',null,'NULL')
;

-- Sep 27, 2026, 2:58:41 PM CEST
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-27 14:58:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3045
;

-- Sep 27, 2026, 2:58:43 PM CEST
INSERT INTO t_alter_column values('c_order','POReference','VARCHAR(255)',null,'NULL')
;

-- Sep 27, 2026, 2:59:06 PM CEST
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-27 14:59:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3785
;

-- Sep 27, 2026, 2:59:07 PM CEST
INSERT INTO t_alter_column values('c_invoice','POReference','VARCHAR(255)',null,'NULL')
;

-- Sep 27, 2026, 3:00:21 PM CEST
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-27 15:00:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4215
;

-- Sep 27, 2026, 3:00:22 PM CEST
INSERT INTO t_alter_column values('c_bpartner','POReference','VARCHAR(255)',null,'NULL')
;

