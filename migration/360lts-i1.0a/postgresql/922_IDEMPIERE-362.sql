-- IDEMPIERE-362 Hide things that don't work on iDempiere

ALTER TABLE c_acctschema_default ALTER b_expense_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER b_revaluationgain_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER b_revaluationloss_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER b_settlementgain_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER b_settlementloss_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER b_unidentified_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER e_expense_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER e_prepayment_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER notinvoicedreceivables_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER notinvoicedrevenue_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER t_liability_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER t_receivables_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER w_invactualadjust_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER w_inventory_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER w_revaluation_acct DROP NOT NULL;

ALTER TABLE c_acctschema_default ALTER withholding_acct DROP NOT NULL;

ALTER TABLE c_acctschema_gl ALTER incomesummary_acct DROP NOT NULL;

ALTER TABLE c_acctschema_gl ALTER retainedearning_acct DROP NOT NULL;

ALTER TABLE c_bankaccount_acct ALTER b_expense_acct DROP NOT NULL;

ALTER TABLE c_bankaccount_acct ALTER b_revaluationgain_acct DROP NOT NULL;

ALTER TABLE c_bankaccount_acct ALTER b_revaluationloss_acct DROP NOT NULL;

ALTER TABLE c_bankaccount_acct ALTER b_settlementgain_acct DROP NOT NULL;

ALTER TABLE c_bankaccount_acct ALTER b_settlementloss_acct DROP NOT NULL;

ALTER TABLE c_bankaccount_acct ALTER b_unidentified_acct DROP NOT NULL;

ALTER TABLE c_bp_group_acct ALTER notinvoicedreceivables_acct DROP NOT NULL;

ALTER TABLE c_bp_group_acct ALTER notinvoicedrevenue_acct DROP NOT NULL;

ALTER TABLE c_currency_acct ALTER realizedgain_acct DROP NOT NULL;

ALTER TABLE c_currency_acct ALTER realizedloss_acct DROP NOT NULL;

ALTER TABLE c_currency_acct ALTER unrealizedgain_acct DROP NOT NULL;

ALTER TABLE c_currency_acct ALTER unrealizedloss_acct DROP NOT NULL;

ALTER TABLE c_tax_acct ALTER t_liability_acct DROP NOT NULL;

ALTER TABLE c_tax_acct ALTER t_receivables_acct DROP NOT NULL;

ALTER TABLE m_warehouse_acct ALTER w_invactualadjust_acct DROP NOT NULL;

ALTER TABLE m_warehouse_acct ALTER w_inventory_acct DROP NOT NULL;

ALTER TABLE m_warehouse_acct ALTER w_revaluation_acct DROP NOT NULL;

SELECT register_migration_script('922_IDEMPIERE-362.sql') FROM dual
;

