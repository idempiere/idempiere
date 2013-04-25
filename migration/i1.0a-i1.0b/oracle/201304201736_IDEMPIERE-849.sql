-- 821_IDEMPIERE-137_GLReconciliation.sql
CREATE OR REPLACE VIEW t_rv_reconciliation AS 
 SELECT f.*, t.ad_pinstance_id, t.matchcode
   FROM rv_fact_acct f
   JOIN t_reconciliation t ON f.fact_acct_id = t.fact_acct_id
;

SELECT register_migration_script('201304201736_IDEMPIERE-849.sql') FROM dual
;

