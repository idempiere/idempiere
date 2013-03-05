CREATE OR REPLACE VIEW rv_fact_simple AS 
 SELECT rv_fact_acct.ad_client_id, rv_fact_acct.ad_org_id, rv_fact_acct.isactive, rv_fact_acct.created, rv_fact_acct.createdby, 
 rv_fact_acct.updated, rv_fact_acct.updatedby, rv_fact_acct.c_project_id, rv_fact_acct.c_acctschema_id, rv_fact_acct.account_id, 
 rv_fact_acct.accountvalue, rv_fact_acct.accounttype, rv_fact_acct.dateacct, to_char(rv_fact_acct.dateacct, 'YYYY-MM') AS finyear_mth, 
 sum(rv_fact_acct.amtacctdr - rv_fact_acct.amtacctcr) AS amtacct, to_char(rv_fact_acct.dateacct, '"FY"YYYY') AS finyear, 
        CASE rv_fact_acct.accounttype
            WHEN 'A' THEN 'B'
            WHEN 'E' THEN 'P'
            WHEN 'L' THEN 'B'
            WHEN 'M' THEN 'B'
            WHEN 'O' THEN 'B'
            WHEN 'R' THEN 'P'
            ELSE '9. Unknown'
        END AS "case"
   FROM rv_fact_acct
  WHERE rv_fact_acct.postingtype = 'A'
  GROUP BY rv_fact_acct.ad_client_id, rv_fact_acct.ad_org_id, rv_fact_acct.isactive, rv_fact_acct.created, 
  rv_fact_acct.createdby, rv_fact_acct.updated, rv_fact_acct.updatedby, rv_fact_acct.c_project_id, 
  rv_fact_acct.c_acctschema_id, rv_fact_acct.account_id, rv_fact_acct.accountvalue, rv_fact_acct.accounttype, 
  rv_fact_acct.dateacct, rv_fact_acct.amtacct
;
