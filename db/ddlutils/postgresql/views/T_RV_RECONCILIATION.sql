CREATE OR REPLACE VIEW t_rv_reconciliation AS 
 SELECT f.*, t.ad_pinstance_id, t.matchcode
   FROM rv_fact_acct f
   JOIN t_reconciliation t ON f.fact_acct_id = t.fact_acct_id
;
