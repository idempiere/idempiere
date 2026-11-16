-- Open IDEMPIERE-7120 Address sequence lock issue under concurrent document creation (load testing)
SELECT register_migration_script('202611041644_IDEMPIERE-7120.sql') FROM dual;

-- Nov 4, 2026, 4:44:14 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:44:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55442
;

-- Nov 4, 2026, 4:44:16 PM CET
INSERT INTO t_alter_column values('i_fajournal','BatchDocumentNo','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:45:35 PM CET
UPDATE AD_Column SET FieldLength=255, IsToolbarButton='N',Updated=TO_TIMESTAMP('2026-11-04 16:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=201579
;

-- Nov 4, 2026, 4:47:32 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:47:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200742
;

-- Nov 4, 2026, 4:47:35 PM CET
INSERT INTO t_alter_column values('c_paymenttransaction','CheckNo','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:47:59 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:47:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8369
;

-- Nov 4, 2026, 4:48:25 PM CET
UPDATE AD_Column SET FieldLength=255, IsToolbarButton='N',Updated=TO_TIMESTAMP('2026-11-04 16:48:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=206528
;

-- Nov 4, 2026, 4:49:24 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200440
;

-- Nov 4, 2026, 4:49:26 PM CET
INSERT INTO t_alter_column values('c_pospayment','CheckNo','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:49:44 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:49:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9133
;

-- Nov 4, 2026, 4:49:45 PM CET
INSERT INTO t_alter_column values('i_payment','CheckNo','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:50:06 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:50:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13147
;

-- Nov 4, 2026, 4:50:45 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:50:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9304
;

-- Nov 4, 2026, 4:50:47 PM CET
INSERT INTO t_alter_column values('i_bankstatement','InvoiceDocumentNo','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:51:07 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:51:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9151
;

-- Nov 4, 2026, 4:51:08 PM CET
INSERT INTO t_alter_column values('i_payment','InvoiceDocumentNo','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:51:42 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:51:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13208
;

-- Nov 4, 2026, 4:52:10 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:52:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55460
;

-- Nov 4, 2026, 4:52:11 PM CET
INSERT INTO t_alter_column values('i_fajournal','JournalDocumentNo','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:52:47 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:52:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10381
;

-- Nov 4, 2026, 4:52:49 PM CET
INSERT INTO t_alter_column values('i_bankstatement','PaymentDocumentNo','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:53:58 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:53:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12617
;

-- Nov 4, 2026, 4:54:24 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:54:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7456
;

-- Nov 4, 2026, 4:54:45 PM CET
UPDATE AD_Column SET FieldLength=255, IsToolbarButton='N',Updated=TO_TIMESTAMP('2026-11-04 16:54:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=205614
;

-- Nov 4, 2026, 4:55:15 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:55:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7088
;

-- Nov 4, 2026, 4:55:37 PM CET
UPDATE AD_Column SET FieldLength=255, IsToolbarButton='N',Updated=TO_TIMESTAMP('2026-11-04 16:55:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=203901
;

-- Nov 4, 2026, 4:55:51 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:55:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7156
;

-- Nov 4, 2026, 4:56:07 PM CET
UPDATE AD_Column SET FieldLength=255, IsToolbarButton='N',Updated=TO_TIMESTAMP('2026-11-04 16:56:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=204287
;

-- Nov 4, 2026, 4:56:59 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5794
;

-- Nov 4, 2026, 4:57:00 PM CET
INSERT INTO t_alter_column values('c_project','POReference','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:57:19 PM CET
UPDATE AD_Column SET FieldLength=255, IsToolbarButton='N',Updated=TO_TIMESTAMP('2026-11-04 16:57:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=206700
;

-- Nov 4, 2026, 4:57:37 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:57:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9662
;

-- Nov 4, 2026, 4:57:53 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:57:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53908
;

-- Nov 4, 2026, 4:57:54 PM CET
INSERT INTO t_alter_column values('dd_order','POReference','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:58:08 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56229
;

-- Nov 4, 2026, 4:58:25 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:58:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3799
;

-- Nov 4, 2026, 4:58:27 PM CET
INSERT INTO t_alter_column values('m_inout','POReference','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 4:58:44 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:58:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215049
;

-- Nov 4, 2026, 4:58:57 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:58:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12258
;

-- Nov 4, 2026, 4:59:14 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:59:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7199
;

-- Nov 4, 2026, 4:59:28 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:59:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56246
;

-- Nov 4, 2026, 4:59:45 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 16:59:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=205533
;

-- Nov 4, 2026, 4:59:47 PM CET
INSERT INTO t_alter_column values('m_shippingtransaction','POReference','VARCHAR(255)',null,'NULL')
;

-- Nov 4, 2026, 5:00:02 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 17:00:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14243
;

-- Nov 4, 2026, 5:00:22 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 17:00:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5553
;

-- Nov 4, 2026, 5:00:35 PM CET
UPDATE AD_Column SET FieldLength=255, IsToolbarButton='N',Updated=TO_TIMESTAMP('2026-11-04 17:00:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=204941
;

-- Nov 4, 2026, 5:00:47 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 17:00:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56264
;

-- Nov 4, 2026, 5:01:01 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 17:01:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12809
;

-- Nov 4, 2026, 5:01:15 PM CET
UPDATE AD_Column SET FieldLength=255, IsToolbarButton='N',Updated=TO_TIMESTAMP('2026-11-04 17:01:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=205265
;

-- Nov 4, 2026, 5:01:33 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 17:01:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11613
;

-- Nov 4, 2026, 5:01:45 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-11-04 17:01:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9733
;

-- Nov 4, 2026, 5:02:09 PM CET
UPDATE AD_Column SET FieldLength=255, IsToolbarButton='N',Updated=TO_TIMESTAMP('2026-11-04 17:02:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=205499
;

-- Nov 4, 2026, 5:02:38 PM CET
INSERT INTO t_alter_column values('m_movement','POReference','VARCHAR(255)',null,'NULL')
;

