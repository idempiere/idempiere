-- IDEMPIERE-362 Hide things that don't work on iDempiere

ALTER TABLE c_acctschema_default MODIFY ( b_expense_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( b_revaluationgain_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( b_revaluationloss_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( b_settlementgain_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( b_settlementloss_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( b_unidentified_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( e_expense_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( e_prepayment_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( notinvoicedreceivables_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( notinvoicedrevenue_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( t_liability_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( t_receivables_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( w_invactualadjust_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( w_inventory_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( w_revaluation_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_default MODIFY ( withholding_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_gl MODIFY ( incomesummary_acct NUMBER(10) NULL );

ALTER TABLE c_acctschema_gl MODIFY ( retainedearning_acct NUMBER(10) NULL );

ALTER TABLE c_bankaccount_acct MODIFY ( b_expense_acct NUMBER(10) NULL );

ALTER TABLE c_bankaccount_acct MODIFY ( b_revaluationgain_acct NUMBER(10) NULL );

ALTER TABLE c_bankaccount_acct MODIFY ( b_revaluationloss_acct NUMBER(10) NULL );

ALTER TABLE c_bankaccount_acct MODIFY ( b_settlementgain_acct NUMBER(10) NULL );

ALTER TABLE c_bankaccount_acct MODIFY ( b_settlementloss_acct NUMBER(10) NULL );

ALTER TABLE c_bankaccount_acct MODIFY ( b_unidentified_acct NUMBER(10) NULL );

ALTER TABLE c_bp_group_acct MODIFY ( notinvoicedreceivables_acct NUMBER(10) NULL );

ALTER TABLE c_bp_group_acct MODIFY ( notinvoicedrevenue_acct NUMBER(10) NULL );

ALTER TABLE c_currency_acct MODIFY ( realizedgain_acct NUMBER(10) NULL );

ALTER TABLE c_currency_acct MODIFY ( realizedloss_acct NUMBER(10) NULL );

ALTER TABLE c_currency_acct MODIFY ( unrealizedgain_acct NUMBER(10) NULL );

ALTER TABLE c_currency_acct MODIFY ( unrealizedloss_acct NUMBER(10) NULL );

ALTER TABLE c_tax_acct MODIFY ( t_liability_acct NUMBER(10) NULL );

ALTER TABLE c_tax_acct MODIFY ( t_receivables_acct NUMBER(10) NULL );

ALTER TABLE m_warehouse_acct MODIFY ( w_invactualadjust_acct NUMBER(10) NULL );

ALTER TABLE m_warehouse_acct MODIFY ( w_inventory_acct NUMBER(10) NULL );

ALTER TABLE m_warehouse_acct MODIFY ( w_revaluation_acct NUMBER(10) NULL );

SELECT register_migration_script('922_IDEMPIERE-362.sql') FROM dual
;

