-- 7/04/2014 09:21:13 PM CEST
-- IDEMPIERE-1853 Accounting Schema Default
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2014-04-07 21:21:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3455
;

-- 7/04/2014 09:21:15 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','V_Liability_Services_Acct','NUMERIC(10)',null,'NULL')
;

-- 7/04/2014 09:21:15 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','V_Liability_Services_Acct',null,'NULL',null)
;

-- 7/04/2014 09:21:15 PM CEST
ALTER TABLE C_AcctSchema_Default DROP CONSTRAINT vc_vliabilityservices_cschemad
;

-- 7/04/2014 09:21:16 PM CEST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT vc_vliabilityservices_cschemad FOREIGN KEY (V_Liability_Services_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- 7/04/2014 09:24:14 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2014-04-07 21:24:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4872
;

-- 7/04/2014 09:24:16 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','UnEarnedRevenue_Acct','NUMERIC(10)',null,'NULL')
;

-- 7/04/2014 09:24:16 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','UnEarnedRevenue_Acct',null,'NULL',null)
;

-- 7/04/2014 09:24:16 PM CEST
ALTER TABLE C_AcctSchema_Default DROP CONSTRAINT vc_unearnedrevenue_cschemadefa
;

-- 7/04/2014 09:24:16 PM CEST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT vc_unearnedrevenue_cschemadefa FOREIGN KEY (UnEarnedRevenue_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- 7/04/2014 09:24:46 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2014-04-07 21:24:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5206
;

-- 7/04/2014 09:24:48 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','CB_Asset_Acct','NUMERIC(10)',null,'NULL')
;

-- 7/04/2014 09:24:48 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','CB_Asset_Acct',null,'NULL',null)
;

-- 7/04/2014 09:24:48 PM CEST
ALTER TABLE C_AcctSchema_Default DROP CONSTRAINT vc_cbasset_cschemadefault
;

-- 7/04/2014 09:24:48 PM CEST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT vc_cbasset_cschemadefault FOREIGN KEY (CB_Asset_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- 7/04/2014 09:25:05 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2014-04-07 21:25:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6493
;

-- 7/04/2014 09:25:08 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','CB_CashTransfer_Acct','NUMERIC(10)',null,'NULL')
;

-- 7/04/2014 09:25:08 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','CB_CashTransfer_Acct',null,'NULL',null)
;

-- 7/04/2014 09:25:08 PM CEST
ALTER TABLE C_AcctSchema_Default DROP CONSTRAINT vc_cbcashtransfer_cschemadefau
;

-- 7/04/2014 09:25:08 PM CEST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT vc_cbcashtransfer_cschemadefau FOREIGN KEY (CB_CashTransfer_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- 7/04/2014 09:25:23 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2014-04-07 21:25:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5207
;

-- 7/04/2014 09:25:28 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','CB_Differences_Acct','NUMERIC(10)',null,'NULL')
;

-- 7/04/2014 09:25:28 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','CB_Differences_Acct',null,'NULL',null)
;

-- 7/04/2014 09:25:28 PM CEST
ALTER TABLE C_AcctSchema_Default DROP CONSTRAINT vc_cbdifferences_cschemadefaul
;

-- 7/04/2014 09:25:28 PM CEST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT vc_cbdifferences_cschemadefaul FOREIGN KEY (CB_Differences_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- 7/04/2014 09:25:43 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2014-04-07 21:25:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5208
;

-- 7/04/2014 09:25:46 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','CB_Expense_Acct','NUMERIC(10)',null,'NULL')
;

-- 7/04/2014 09:25:46 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','CB_Expense_Acct',null,'NULL',null)
;

-- 7/04/2014 09:25:46 PM CEST
ALTER TABLE C_AcctSchema_Default DROP CONSTRAINT vc_cbexpense_cschemadefault
;

-- 7/04/2014 09:25:46 PM CEST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT vc_cbexpense_cschemadefault FOREIGN KEY (CB_Expense_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- 7/04/2014 09:26:02 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2014-04-07 21:26:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5209
;

-- 7/04/2014 09:26:05 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','CB_Receipt_Acct','NUMERIC(10)',null,'NULL')
;

-- 7/04/2014 09:26:05 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','CB_Receipt_Acct',null,'NULL',null)
;

-- 7/04/2014 09:26:05 PM CEST
ALTER TABLE C_AcctSchema_Default DROP CONSTRAINT vc_cbreceipt_cschemadefault
;

-- 7/04/2014 09:26:05 PM CEST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT vc_cbreceipt_cschemadefault FOREIGN KEY (CB_Receipt_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- 7/04/2014 09:26:34 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2014-04-07 21:26:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14430
;

-- 7/04/2014 09:26:36 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','C_Receivable_Services_Acct','NUMERIC(10)',null,'NULL')
;

-- 7/04/2014 09:26:36 PM CEST
INSERT INTO t_alter_column values('c_acctschema_default','C_Receivable_Services_Acct',null,'NULL',null)
;

-- 7/04/2014 09:26:36 PM CEST
ALTER TABLE C_AcctSchema_Default DROP CONSTRAINT creceivableservices_cacctschem
;

-- 7/04/2014 09:26:36 PM CEST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT creceivableservices_cacctschem FOREIGN KEY (C_Receivable_Services_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201404071427_IDEMPIERE-1853.sql') FROM dual
;

