CREATE OR REPLACE VIEW rv_fact_adaxa AS 
 SELECT f.ad_client_id, f.ad_org_id, ( SELECT cli.name
           FROM ad_client cli
          WHERE cli.ad_client_id = f.ad_client_id) AS clientname, f.dateacct, 
        CASE
            WHEN f.dateacct < (( SELECT clinfo.fy_startdate
               FROM ad_clientinfo clinfo
              WHERE clinfo.ad_client_id = f.ad_client_id)) THEN (( SELECT clinfo.fy_startdate - 1
               FROM ad_clientinfo clinfo
              WHERE clinfo.ad_client_id = f.ad_client_id))
            ELSE f.dateacct
        END AS bsdate, 
        CASE
            WHEN f.dateacct < (( SELECT clinfo.fy_startdate
               FROM ad_clientinfo clinfo
              WHERE clinfo.ad_client_id = f.ad_client_id)) THEN ( SELECT to_char((clinfo.fy_startdate - 1), 'YYYY-MM') AS to_char
               FROM ad_clientinfo clinfo
              WHERE clinfo.ad_client_id = f.ad_client_id)
            ELSE to_char(f.dateacct, 'YYYY-MM')
        END AS bsmth, to_char((f.dateacct + 184), '"FY"YYYY') AS fyear, to_char(f.dateacct, 'YYYY-MM') AS fymth, ( SELECT t.name
           FROM ad_table t
          WHERE t.ad_table_id = f.ad_table_id) AS table_name, f.record_id, ( SELECT gl.name
           FROM gl_budget gl
          WHERE gl.gl_budget_id = f.gl_budget_id) AS budname, ( SELECT tax.name
           FROM c_tax tax
          WHERE tax.c_tax_id = f.c_tax_id) AS taxname, 
        CASE f.postingtype
            WHEN 'A' THEN 'Actual'
            WHEN 'B' THEN 'Budget'
            WHEN 'E' THEN 'Encumbrance'
            WHEN 'S' THEN 'Statistic'
            ELSE 'Other'
        END AS act_bud, ( SELECT c.iso_code
           FROM c_currency c
          WHERE c.c_currency_id = f.c_currency_id) AS currency, f.amtsourcedr - f.amtsourcecr AS amtsce, f.amtacctdr - f.amtacctcr AS amtacct, 
        CASE
            WHEN f.postingtype = 'B' THEN 0
            ELSE f.amtacctcr - f.amtacctdr
        END AS "pl$act", 
        CASE
            WHEN f.postingtype = 'B' THEN 0
            WHEN ev.accounttype = 'A' THEN f.amtacctdr - f.amtacctcr
            WHEN ev.accounttype = 'L' THEN f.amtacctdr - f.amtacctcr
            WHEN ev.accounttype = 'O' THEN f.amtacctcr - f.amtacctdr
            WHEN ev.accounttype = 'E' THEN f.amtacctcr - f.amtacctdr
            WHEN ev.accounttype = 'R' THEN f.amtacctcr - f.amtacctdr
            ELSE 0
        END AS "bs$act", 
        CASE
            WHEN f.postingtype = 'A' THEN 0
            WHEN ev.accounttype = 'E' THEN f.amtacctcr - f.amtacctdr
            WHEN ev.accounttype = 'R' THEN f.amtacctcr - f.amtacctdr
            ELSE 0
        END AS "pl$bud", ( SELECT um.uomsymbol
           FROM c_uom um
          WHERE um.c_uom_id = f.c_uom_id) AS uomname, f.qty, ( SELECT prj.name
           FROM c_project prj
          WHERE prj.c_project_id = f.c_project_id) AS projectname, f.description, o.name AS orgname, ev.value AS ac_code, ev.name AS ac_name, (ev.value || '-' || ev.name) AS account_name, 
        CASE ev.accounttype
            WHEN 'A' THEN '1 Asset'
            WHEN 'E' THEN '3 Equity'
            WHEN 'L' THEN '2 Liability'
            WHEN 'M' THEN '9 Memo'
            WHEN 'O' THEN '3 Equity'
            WHEN 'R' THEN '3 Equity'
            ELSE '9. Unknown'
        END AS bstypename, 
        CASE ev.accounttype
            WHEN 'A' THEN '9 BSheet'
            WHEN 'E' THEN '6 Expense'
            WHEN 'L' THEN '9 BSheet'
            WHEN 'M' THEN '9 Memo'
            WHEN 'O' THEN '9 BSheet'
            WHEN 'R' THEN '4 Revenue'
            ELSE '9. Unknown'
        END AS pltypename, ( SELECT (ss.value || '-') || ss.name
           FROM c_elementvalue ss
          WHERE ss.value = substr(ev.value, 1, 1) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id) AS ac_group, 
        CASE ev.accounttype
            WHEN 'A' THEN ( SELECT (TO_CHAR(ss.value) || '-') || TO_CHAR(ss.name)
               FROM c_elementvalue ss
              WHERE ss.value = substr(ev.value, 1, 3) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id)
            WHEN 'E' THEN '330-Current P and L Accounts Balance'
            WHEN 'L' THEN ( SELECT (TO_CHAR(ss.value) || '-') || TO_CHAR(ss.name)
               FROM c_elementvalue ss
              WHERE ss.value = substr(ev.value, 1, 3) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id)
            WHEN 'O' THEN ( SELECT (TO_CHAR(ss.value) || '-') || TO_CHAR(ss.name)
               FROM c_elementvalue ss
              WHERE ss.value = substr(ev.value, 1, 3) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id)
            WHEN 'R' THEN '330-Current P and L Accounts Balance'
            ELSE 'Unknown Account Type'
        END AS bsgroup, 
        CASE ev.accounttype
            WHEN 'A' THEN '999-Balance Sheet Item'
            WHEN 'E' THEN ( SELECT (TO_CHAR(ss.value) || '-') || TO_CHAR(ss.name)
               FROM c_elementvalue ss
              WHERE ss.value = substr(ev.value, 1, 3) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id)
            WHEN 'L' THEN '999-Balance Sheet Item'
            WHEN 'O' THEN '999-Balance Sheet Item'
            WHEN 'R' THEN ( SELECT (TO_CHAR(ss.value) || '-') || TO_CHAR(ss.name)
               FROM c_elementvalue ss
              WHERE ss.value = substr(ev.value, 1, 3) AND ss.issummary = 'Y' AND ss.ad_client_id = f.ad_client_id)
            ELSE 'Unknown Account Type'
        END AS plgroup, 
        CASE ev.accounttype
            WHEN 'A' THEN 'BS'
            WHEN 'E' THEN 'PL'
            WHEN 'L' THEN 'BS'
            WHEN 'M' THEN 'Unknown Account Type'
            WHEN 'O' THEN 'BS'
            WHEN 'R' THEN 'PL'
            ELSE 'Unknown Account Type'
        END AS plbs, 
        CASE ev.accounttype
            WHEN 'A' THEN '1 NetAssets'
            WHEN 'E' THEN '2 Equity'
            WHEN 'L' THEN '1 NetAssets'
            WHEN 'M' THEN '9 Memo'
            WHEN 'O' THEN '2 Equity'
            WHEN 'R' THEN '2 Equity'
            ELSE 'Unknown Account Type'
        END AS na_eq, bp.value AS bpcode, bp.name AS bpname, 
        CASE
            WHEN bp.name IS NULL THEN NULL
            ELSE (TO_CHAR(bp.value) || '-') || TO_CHAR(bp.name)
        END AS bpartnercodeandname, ( SELECT bpg.name
           FROM c_bp_group bpg
          WHERE bpg.c_bp_group_id = bp.c_bp_group_id) AS bpgroupname, ( SELECT ad_user.name
           FROM ad_user
          WHERE ad_user.ad_user_id = bp.salesrep_id) AS repname, p.value AS prodcode, p.name AS prodname, 
        CASE
            WHEN p.name IS NULL THEN NULL
            ELSE (TO_CHAR(p.value) || '-') || TO_CHAR(p.name)
        END AS product, ( SELECT pc.name
           FROM m_product_category pc
          WHERE pc.m_product_category_id = p.m_product_category_id) AS prodcategory
  FROM fact_acct f
   JOIN ad_org o ON f.ad_org_id = o.ad_org_id
   JOIN c_elementvalue ev ON f.account_id = ev.c_elementvalue_id
   LEFT JOIN c_bpartner bp ON f.c_bpartner_id = bp.c_bpartner_id
   LEFT JOIN m_product p ON f.m_product_id = p.m_product_id
;
