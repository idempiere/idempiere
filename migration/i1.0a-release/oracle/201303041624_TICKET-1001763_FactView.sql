-- Mar 1, 2013 4:52:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('FY_StartDate',202258,'D','Financial Year Start Date','Financial Year Start Date','612dd5a3-8a96-41a6-95e6-5425d13fa9dd',0,TO_DATE('2013-03-01 16:52:22','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 16:52:22','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 4:52:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202258 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 4:52:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',227,208739,'D','N','N','N',0,'N',7,'N',15,'N',202258,'N','Y','9ed9f064-33ce-4c0e-a45e-ca905291ca42','Y','FY_StartDate','Financial Year Start Date','Y',100,TO_DATE('2013-03-01 16:52:50','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 16:52:50','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 4:52:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208739 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 4:52:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
ALTER TABLE AD_ClientInfo ADD FY_StartDate DATE DEFAULT NULL 
;

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
  rv_fact_acct.dateacct, rv_fact_acct.amtacct;
  
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
   LEFT JOIN m_product p ON f.m_product_id = p.m_product_id;
   -- Mar 1, 2013 5:49:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','N','N','3',0,200072,'N','Y','N','D','L','014cfa42-6fad-47d9-bc06-d29272245190','Y','N','RV_Fact_Simple','Simple Fact View',0,'Y',0,TO_DATE('2013-03-01 17:49:50','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2013-03-01 17:49:50','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 1, 2013 5:49:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200072 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Mar 1, 2013 5:49:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200067,'abffb14b-035f-417e-b52f-cb88cb1cc618','Table RV_Fact_Simple','RV_Fact_Simple',1,0,0,TO_DATE('2013-03-01 17:49:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 17:49:52','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Mar 1, 2013 5:50:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208740,'D','N','N','N','N',10,'N',19,'N',102,'f4c1919e-a53d-4331-9b3c-ab8dc2fbbce2','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client',100,TO_DATE('2013-03-01 17:50:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:15','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208740 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208741,'D','N','N','N','N',10,'N',19,'N',113,'a7f82948-9a2f-4fe2-b1de-0ca369be3a0c','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization',100,TO_DATE('2013-03-01 17:50:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:16','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208741 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208742,'D','N','N','N','N',1,'N',20,'N',348,'bbe13fe3-5da8-40d9-884b-f4c8350f5d97','N','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active',100,TO_DATE('2013-03-01 17:50:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:17','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208742 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208743,'D','N','N','N','N',29,'N',16,'N',245,'31221c75-a25c-4adc-97f0-8c8c1bb05085','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created',100,TO_DATE('2013-03-01 17:50:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208743 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208744,'D',110,'N','N','N','N',10,'N',18,'N',246,'a34c09cd-d0d0-4236-afc4-0624c9279044','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By',100,TO_DATE('2013-03-01 17:50:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:19','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208744 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208745,'D','N','N','N','N',29,'N',16,'N',607,'8bfc9fb6-a62f-49dd-829f-e70208801b63','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated',100,TO_DATE('2013-03-01 17:50:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:20','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208745 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208746,'D',110,'N','N','N','N',10,'N',18,'N',608,'543ec7b2-91df-4a2b-b098-5b136aed4b7d','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By',100,TO_DATE('2013-03-01 17:50:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:20','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208746 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208747,'D','N','N','N','N',10,'N',19,'N',208,'8a6bd0f3-649b-4fa7-9ad8-55eca9f51901','N','C_Project_ID','Financial Project','A Project allows you to track and control internal or external activities.','Project',100,TO_DATE('2013-03-01 17:50:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208747 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208748,'D','N','N','N','N',10,'N',19,'N',181,'68ed5b73-5293-49fe-880e-e1c08098be02','N','C_AcctSchema_ID','Rules for accounting','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar','Accounting Schema',100,TO_DATE('2013-03-01 17:50:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:22','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208748 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208749,'D','N','N','N','N',10,'N',19,'N',148,'2b668ab1-d97a-4916-ac35-086fdd5bbc27','N','Account_ID','Account used','The (natural) account used','Account',100,TO_DATE('2013-03-01 17:50:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:23','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208749 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208750,'D','N','N','N','N',40,'N',10,'N',2083,'037feec7-316f-4850-a395-93311cdee2e5','N','AccountValue','Key of Account Element','Account Key',100,TO_DATE('2013-03-01 17:50:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:23','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208750 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208751,'D','N','N','N','N',1,'N',20,'N',147,'37dfde49-731e-4819-ab18-10cc674b4a81','N','AccountType','Indicates the type of account','Valid account types are A - Asset, E - Expense, L - Liability, O- Owner''s Equity, R -Revenue and M- Memo.  The account type is used to determine what taxes, if any are applicable, validating payables and receivables for business partners.  Note:  Memo account amounts are ignored when checking for balancing','Account Type',100,TO_DATE('2013-03-01 17:50:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:24','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208751 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208752,'D','N','N','N','N',29,'N',16,'N',263,'a4a5e8a5-3844-4f19-8125-1947e07e9167','N','DateAcct','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.','Account Date',100,TO_DATE('2013-03-01 17:50:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:25','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208752 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('finyear_mth',202259,'D','finyear_mth','finyear_mth','99474de4-31c0-4e16-afe9-cec9c35048b8',0,TO_DATE('2013-03-01 17:50:26','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:50:26','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:50:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202259 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:50:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208753,'D','N','N','N','N',2147483647,'N',14,'N',202259,'a42a8cba-2511-4feb-97cf-1cbc378ecedf','N','finyear_mth','finyear_mth',100,TO_DATE('2013-03-01 17:50:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:26','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208753 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208754,'D','N','N','N','N',131089,'N',12,'N',2342,'115482bc-4605-4f61-9988-39aff47f9858','N','AmtAcct','Amount Balance in Currency of Accounting Schema','Accounted Amount',100,TO_DATE('2013-03-01 17:50:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:28','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208754 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('finyear',202260,'D','finyear','finyear','9a93b6bf-ed03-4ad9-be6f-67f28b4745a3',0,TO_DATE('2013-03-01 17:50:28','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:50:28','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:50:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202260 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:50:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208755,'D','N','N','N','N',2147483647,'N',14,'N',202260,'256480ea-8832-4c39-b078-2e6ae8e66642','N','finyear','finyear',100,TO_DATE('2013-03-01 17:50:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:28','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208755 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:50:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('case',202261,'D','case','case','78f255f0-926d-46e9-b2f8-6d2b70e4ab29',0,TO_DATE('2013-03-01 17:50:30','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:50:30','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:50:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202261 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:50:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200072,208756,'D','N','N','N','N',2147483647,'N',14,'N',202261,'7831762a-7166-40c4-9bd0-e037839cb3a3','N','case','case',100,TO_DATE('2013-03-01 17:50:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:50:30','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:50:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208756 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:51:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='Case', Name='Case', PrintName='Case',Updated=TO_DATE('2013-03-01 17:51:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202261
;

-- Mar 1, 2013 5:51:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202261
;

-- Mar 1, 2013 5:51:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='Case', Name='Case', Description=NULL, Help=NULL WHERE AD_Element_ID=202261
;

-- Mar 1, 2013 5:51:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Case', Name='Case', Description=NULL, Help=NULL, AD_Element_ID=202261 WHERE UPPER(ColumnName)='CASE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 5:51:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Case', Name='Case', Description=NULL, Help=NULL WHERE AD_Element_ID=202261 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:51:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='Case', Name='Case', Description=NULL, Help=NULL WHERE AD_Element_ID=202261 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:51:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Case', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202261) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:51:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Case', Name='Case' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202261)
;

-- Mar 1, 2013 5:51:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='FinYear', Name='Financial Year', PrintName='Financial Year',Updated=TO_DATE('2013-03-01 17:51:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202260
;

-- Mar 1, 2013 5:51:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202260
;

-- Mar 1, 2013 5:51:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='FinYear', Name='Financial Year', Description=NULL, Help=NULL WHERE AD_Element_ID=202260
;

-- Mar 1, 2013 5:51:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='FinYear', Name='Financial Year', Description=NULL, Help=NULL, AD_Element_ID=202260 WHERE UPPER(ColumnName)='FINYEAR' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 5:51:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='FinYear', Name='Financial Year', Description=NULL, Help=NULL WHERE AD_Element_ID=202260 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:51:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='FinYear', Name='Financial Year', Description=NULL, Help=NULL WHERE AD_Element_ID=202260 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:51:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Financial Year', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202260) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:51:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Financial Year', Name='Financial Year' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202260)
;

-- Mar 1, 2013 5:51:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='FinYear_Mth', Name='Financial Year (Month)', PrintName='Financial Year (Month)',Updated=TO_DATE('2013-03-01 17:51:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202259
;

-- Mar 1, 2013 5:51:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202259
;

-- Mar 1, 2013 5:51:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='FinYear_Mth', Name='Financial Year (Month)', Description=NULL, Help=NULL WHERE AD_Element_ID=202259
;

-- Mar 1, 2013 5:51:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='FinYear_Mth', Name='Financial Year (Month)', Description=NULL, Help=NULL, AD_Element_ID=202259 WHERE UPPER(ColumnName)='FINYEAR_MTH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 5:51:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='FinYear_Mth', Name='Financial Year (Month)', Description=NULL, Help=NULL WHERE AD_Element_ID=202259 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:51:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='FinYear_Mth', Name='Financial Year (Month)', Description=NULL, Help=NULL WHERE AD_Element_ID=202259 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:51:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Financial Year (Month)', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202259) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:51:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Financial Year (Month)', Name='Financial Year (Month)' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202259)
;

-- Mar 1, 2013 5:54:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Financial Month', PrintName='Financial Month',Updated=TO_DATE('2013-03-01 17:54:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202259
;

-- Mar 1, 2013 5:54:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202259
;

-- Mar 1, 2013 5:54:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='FinYear_Mth', Name='Financial Month', Description=NULL, Help=NULL WHERE AD_Element_ID=202259
;

-- Mar 1, 2013 5:54:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='FinYear_Mth', Name='Financial Month', Description=NULL, Help=NULL, AD_Element_ID=202259 WHERE UPPER(ColumnName)='FINYEAR_MTH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 5:54:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='FinYear_Mth', Name='Financial Month', Description=NULL, Help=NULL WHERE AD_Element_ID=202259 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:54:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='FinYear_Mth', Name='Financial Month', Description=NULL, Help=NULL WHERE AD_Element_ID=202259 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:54:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Financial Month', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202259) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:54:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Financial Month', Name='Financial Month' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202259)
;

-- Mar 1, 2013 5:56:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','N','N','3',0,200073,'N','Y','N','D','L','f9e90dd6-dae3-48c9-ad30-b96090e75ab9','Y','N','RV_Fact_Adaxa','Complex Fact View',0,'Y',0,TO_DATE('2013-03-01 17:56:25','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2013-03-01 17:56:25','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 1, 2013 5:56:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200073 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Mar 1, 2013 5:56:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200068,'cb8381dc-04dc-449d-8802-6cad5f6d671a','Table RV_Fact_Adaxa','RV_Fact_Adaxa',1,0,0,TO_DATE('2013-03-01 17:56:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 17:56:26','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Mar 1, 2013 5:56:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208757,'D','N','N','N','N',10,'N',19,'N',102,'be1e7a04-e81e-4c0c-b036-4d7ea990d0e4','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client',100,TO_DATE('2013-03-01 17:56:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:34','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208757 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208758,'D','N','N','N','N',10,'N',19,'N',113,'39abf002-ea46-4f9c-9f50-af456b1d1d2c','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization',100,TO_DATE('2013-03-01 17:56:35','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:35','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208758 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208759,'D','N','N','N','N',60,'Y',10,'N',200186,'11254560-8d64-4e4b-8435-47db4596ced3','N','clientName','Client in which current session user logged in','Client Name',100,TO_DATE('2013-03-01 17:56:36','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208759 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208760,'D','N','N','N','N',29,'N',16,'N',263,'48f7cad5-9816-4632-bba8-a3310b0e353d','N','DateAcct','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.','Account Date',100,TO_DATE('2013-03-01 17:56:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208760 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('bsdate',202262,'D','bsdate','bsdate','8141cd46-6711-48b2-a95e-5c21ebba3c29',0,TO_DATE('2013-03-01 17:56:37','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:37','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202262 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208761,'D','N','N','N','N',29,'N',16,'N',202262,'89d805e2-b5da-48ea-968d-fcbf8e664ee1','N','bsdate','bsdate',100,TO_DATE('2013-03-01 17:56:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208761 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('bsmth',202263,'D','bsmth','bsmth','3f632b5e-38bc-4664-8810-b7d667a7ebd1',0,TO_DATE('2013-03-01 17:56:39','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:39','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202263 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208762,'D','N','N','N','N',2147483647,'N',14,'N',202263,'6c7286fc-6605-433f-bdba-e07e0070d369','N','bsmth','bsmth',100,TO_DATE('2013-03-01 17:56:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:39','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208762 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('fyear',202264,'D','fyear','fyear','73767ab0-a2c8-4d3e-8cad-9607b6fc84b3',0,TO_DATE('2013-03-01 17:56:40','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:40','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202264 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208763,'D','N','N','N','N',2147483647,'N',14,'N',202264,'dcca0850-c900-40fb-901d-8b840ddd23f8','N','fyear','fyear',100,TO_DATE('2013-03-01 17:56:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:40','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208763 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('fymth',202265,'D','fymth','fymth','d02f291c-8ad1-413e-b1cf-eb62c982dd48',0,TO_DATE('2013-03-01 17:56:42','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:42','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202265 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208764,'D','N','N','N','N',2147483647,'N',14,'N',202265,'653178be-d8cd-4d0b-98a4-c7245e0fbbd4','N','fymth','fymth',100,TO_DATE('2013-03-01 17:56:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:42','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208764 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('table_name',202266,'D','table_name','table_name','5a9ec751-1e67-4742-b287-6304e92b7373',0,TO_DATE('2013-03-01 17:56:43','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:43','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202266 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208765,'D','N','N','N','N',60,'Y',10,'N',202266,'53ae73ea-6e40-45a2-86c5-6ec779d130a7','N','table_name','table_name',100,TO_DATE('2013-03-01 17:56:43','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:43','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208765 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:46 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208766,'D','N','N','N','N',10,'N',19,'N',538,'ac181a2d-3ffe-4c48-93ac-9dcd3cb0c38a','N','Record_ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.','Record ID',100,TO_DATE('2013-03-01 17:56:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:45','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:46 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208766 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('budname',202267,'D','budname','budname','aa5546b2-b60e-4a94-bf10-0ebca296d54a',0,TO_DATE('2013-03-01 17:56:46','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:46','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202267 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208767,'D','N','N','N','N',60,'Y',10,'N',202267,'85aaf955-733b-419a-a14b-9d96fa10d42e','N','budname','budname',100,TO_DATE('2013-03-01 17:56:46','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:46','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208767 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('taxname',202268,'D','taxname','taxname','5c65c6b8-efd2-4677-9f00-6d78371a0fc5',0,TO_DATE('2013-03-01 17:56:47','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:47','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202268 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208768,'D','N','N','N','N',60,'Y',10,'N',202268,'fd238236-d8a3-49ae-b859-e200de3af9f7','N','taxname','taxname',100,TO_DATE('2013-03-01 17:56:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:47','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208768 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('act_bud',202269,'D','act_bud','act_bud','e9282f1f-acf0-42d9-97a4-8bcf74bcd5f3',0,TO_DATE('2013-03-01 17:56:49','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:49','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202269 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208769,'D','N','N','N','N',2147483647,'N',14,'N',202269,'65c6caa2-a705-4df3-84e5-43912964f37c','N','act_bud','act_bud',100,TO_DATE('2013-03-01 17:56:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:49','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208769 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('currency',202270,'D','currency','currency','261b6c98-a764-46d2-9c4f-bc1030fde7cd',0,TO_DATE('2013-03-01 17:56:50','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:50','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202270 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208770,'D','N','N','N','N',3,'N',17,'N',202270,'ca594716-ceeb-42a3-8d71-b25ca4827ed2','N','currency','currency',100,TO_DATE('2013-03-01 17:56:50','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:50','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208770 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('amtsce',202271,'D','amtsce','amtsce','c444dd04-3cc8-44e0-9f4f-ede1153fa4c5',0,TO_DATE('2013-03-01 17:56:52','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:52','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202271 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208771,'D','N','N','N','N',131089,'N',12,'N',202271,'1f979ed4-f8b5-4785-9a85-1f740f1aa72c','N','amtsce','amtsce',100,TO_DATE('2013-03-01 17:56:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:52','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208771 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208772,'D','N','N','N','N',131089,'N',12,'N',2342,'d6933daa-e338-43fe-8772-eee08b23dc73','N','AmtAcct','Amount Balance in Currency of Accounting Schema','Accounted Amount',100,TO_DATE('2013-03-01 17:56:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:54','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208772 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('pl$act',202272,'D','pl$act','pl$act','1ff41f3b-2236-46d6-8361-429767fc27e6',0,TO_DATE('2013-03-01 17:56:54','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:54','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202272 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208773,'D','N','N','N','N',131089,'N',22,'N',202272,'53b0890b-7616-4015-b2db-12e48a2f965f','N','pl$act','pl$act',100,TO_DATE('2013-03-01 17:56:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:54','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208773 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('bs$act',202273,'D','bs$act','bs$act','913ca6f4-6259-49e2-9ceb-3ab9a8b45b10',0,TO_DATE('2013-03-01 17:56:56','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:56','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202273 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208774,'D','N','N','N','N',131089,'N',22,'N',202273,'7ddd6a28-e2e9-4541-9f34-72980ce06140','N','bs$act','bs$act',100,TO_DATE('2013-03-01 17:56:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:56','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208774 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('pl$bud',202274,'D','pl$bud','pl$bud','353c6a5e-ced7-4858-9267-e6453cc84783',0,TO_DATE('2013-03-01 17:56:57','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:57','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:56:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202274 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:56:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208775,'D','N','N','N','N',131089,'N',22,'N',202274,'aa9ba732-fbf0-4568-a26f-9bba5080bfb2','N','pl$bud','pl$bud',100,TO_DATE('2013-03-01 17:56:57','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:57','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:56:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208775 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:56:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('uomname',202275,'D','uomname','uomname','c5e7b626-3aef-4825-a61a-f1e6077e827c',0,TO_DATE('2013-03-01 17:56:59','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:56:59','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202275 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208776,'D','N','N','N','N',10,'Y',10,'N',202275,'e9bf0ff9-6e5c-454a-9efb-9d927f7e7ccb','N','uomname','uomname',100,TO_DATE('2013-03-01 17:56:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:56:59','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208776 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208777,'D','N','N','N','N',131089,'N',29,'N',526,'a2b95e8e-192b-4a65-8554-14e834b6cce5','N','Qty','Quantity','The Quantity indicates the number of a specific product or item for this document.','Quantity',100,TO_DATE('2013-03-01 17:57:00','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:00','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208777 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208778,'D','N','N','N','N',60,'Y',10,'N',2161,'3c52345a-29dd-4a7a-beed-c773ad0a53d8','N','ProjectName','Name of the Project','Project',100,TO_DATE('2013-03-01 17:57:01','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:01','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208778 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208779,'D','N','N','N','N',255,'Y',10,'N',275,'e3290167-ff83-4b62-bfe0-adcac990cb6f','N','Description','Optional short description of the record','A description is limited to 255 characters.','Description',100,TO_DATE('2013-03-01 17:57:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:02','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208779 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208780,'D','N','N','N','N',60,'Y',10,'N',2660,'d4c4aec3-5c74-4bfc-a7af-71dd25afc4a9','N','OrgName','Name of the Organization','Organization Name',100,TO_DATE('2013-03-01 17:57:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:03','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208780 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ac_code',202276,'D','ac_code','ac_code','800ddcbb-2597-455e-af34-168d05b4a2cc',0,TO_DATE('2013-03-01 17:57:03','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:03','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202276 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208781,'D','N','N','N','N',40,'N',10,'N',202276,'131841a7-dc05-4a08-a65a-354769ba9cb9','N','ac_code','ac_code',100,TO_DATE('2013-03-01 17:57:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:03','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208781 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ac_name',202277,'D','ac_name','ac_name','d2faa895-2d90-4153-8ae3-1e6357fda78c',0,TO_DATE('2013-03-01 17:57:05','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:05','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202277 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208782,'D','N','N','N','N',60,'Y',10,'N',202277,'f29b2713-a2d8-472b-ab89-524066b96d1a','N','ac_name','ac_name',100,TO_DATE('2013-03-01 17:57:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:05','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208782 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('account_name',202278,'D','account_name','account_name','49d01eb9-7598-4bd8-9b3e-1aaed4bbd5f4',0,TO_DATE('2013-03-01 17:57:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202278 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208783,'D','N','N','N','N',2147483647,'Y',14,'N',202278,'16fc8413-db15-4a04-8225-8f8bba41a3be','N','account_name','account_name',100,TO_DATE('2013-03-01 17:57:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:06','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208783 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('bstypename',202279,'D','bstypename','bstypename','85a90f7d-bcf8-42c3-903c-085559f72555',0,TO_DATE('2013-03-01 17:57:08','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:08','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202279 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208784,'D','N','N','N','N',2147483647,'Y',14,'N',202279,'f8530cf4-5ac9-4e63-aefe-5d5cefc3383f','N','bstypename','bstypename',100,TO_DATE('2013-03-01 17:57:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:08','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208784 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('pltypename',202280,'D','pltypename','pltypename','3198a724-906f-48e1-b13e-a9c9cf429bf7',0,TO_DATE('2013-03-01 17:57:09','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:09','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202280 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208785,'D','N','N','N','N',2147483647,'Y',14,'N',202280,'52dc9a1c-d49e-4d2d-bff5-263c747fc64d','N','pltypename','pltypename',100,TO_DATE('2013-03-01 17:57:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:09','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208785 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ac_group',202281,'D','ac_group','ac_group','efd6a109-e8e9-45e6-865d-610c6492f81b',0,TO_DATE('2013-03-01 17:57:11','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:11','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202281 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208786,'D','N','N','N','N',2147483647,'N',14,'N',202281,'93a3cd0b-422a-47f3-99a3-9abc958f142c','N','ac_group','ac_group',100,TO_DATE('2013-03-01 17:57:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208786 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('bsgroup',202282,'D','bsgroup','bsgroup','bee13042-0c74-4700-a349-6049c13ad827',0,TO_DATE('2013-03-01 17:57:12','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202282 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208787,'D','N','N','N','N',2147483647,'N',14,'N',202282,'3517f418-f223-4dca-971d-88e8dc8412e4','N','bsgroup','bsgroup',100,TO_DATE('2013-03-01 17:57:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:12','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208787 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('plgroup',202283,'D','plgroup','plgroup','d8a888a1-f31f-43d0-adb9-d61c29b6939b',0,TO_DATE('2013-03-01 17:57:14','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202283 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208788,'D','N','N','N','N',2147483647,'N',14,'N',202283,'38ef8a13-ca36-4ad5-92dc-435082e28c2f','N','plgroup','plgroup',100,TO_DATE('2013-03-01 17:57:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:14','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208788 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('plbs',202284,'D','plbs','plbs','4910dd99-d985-484c-8622-08b41854b3de',0,TO_DATE('2013-03-01 17:57:16','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:16','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202284 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208789,'D','N','N','N','N',2147483647,'N',14,'N',202284,'3e2e48a6-260d-4c61-9777-a09d6068447c','N','plbs','plbs',100,TO_DATE('2013-03-01 17:57:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:16','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208789 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('na_eq',202285,'D','na_eq','na_eq','c609a69b-0c00-49f2-9cf8-ad888f76bacf',0,TO_DATE('2013-03-01 17:57:17','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:17','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202285 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208790,'D','N','N','N','N',2147483647,'N',14,'N',202285,'a6a7e716-07ac-4bd5-8a1e-1b35fbb01411','N','na_eq','na_eq',100,TO_DATE('2013-03-01 17:57:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:17','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208790 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('bpcode',202286,'D','bpcode','bpcode','db4fb444-35a1-4c0e-a650-dc8853918a44',0,TO_DATE('2013-03-01 17:57:19','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:19','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202286 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208791,'D','N','N','N','N',40,'N',10,'N',202286,'5ecae4db-1cae-4d2c-8bcf-d4e00333096b','N','bpcode','bpcode',100,TO_DATE('2013-03-01 17:57:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:19','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208791 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208792,'D','N','N','N','N',60,'Y',10,'N',2510,'cdae90e8-dec9-483d-b1a0-c9ce9aec322b','N','BPName','BP Name',100,TO_DATE('2013-03-01 17:57:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:20','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208792 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('bpartnercodeandname',202287,'D','bpartnercodeandname','bpartnercodeandname','9f207660-56d7-435c-add0-d9ea6074ddbd',0,TO_DATE('2013-03-01 17:57:21','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:21','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202287 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208793,'D','N','N','N','N',2147483647,'Y',14,'N',202287,'2affae11-41ec-4888-b1a3-0d0a92ec5aac','N','bpartnercodeandname','bpartnercodeandname',100,TO_DATE('2013-03-01 17:57:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208793 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('bpgroupname',202288,'D','bpgroupname','bpgroupname','f46d9f14-3d04-4fb8-b374-54510b798f8c',0,TO_DATE('2013-03-01 17:57:22','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:22','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202288 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208794,'D','N','N','N','N',60,'Y',10,'N',202288,'fcc31714-fd70-46f1-aad2-77fdb1f4fe71','N','bpgroupname','bpgroupname',100,TO_DATE('2013-03-01 17:57:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:22','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208794 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('repname',202289,'D','repname','repname','026c01fa-3fee-4187-ba7c-d0c4f7eeb179',0,TO_DATE('2013-03-01 17:57:24','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:24','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202289 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208795,'D','N','N','N','N',60,'Y',10,'N',202289,'388e75fc-debe-4736-8f5c-60283a10e702','N','repname','repname',100,TO_DATE('2013-03-01 17:57:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:24','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208795 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('prodcode',202290,'D','prodcode','prodcode','dd1227b5-583e-4e38-9360-b86ffbfa78fe',0,TO_DATE('2013-03-01 17:57:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:25','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202290 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208796,'D','N','N','N','N',40,'N',10,'N',202290,'30a7aa37-c1dd-4d93-8230-24e5ffc53c99','N','prodcode','prodcode',100,TO_DATE('2013-03-01 17:57:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:25','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208796 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('prodname',202291,'D','prodname','prodname','e081670e-44fc-4857-a3e9-781a03d99843',0,TO_DATE('2013-03-01 17:57:27','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:27','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202291 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208797,'D','N','N','N','N',255,'Y',10,'N',202291,'d27bb1d0-4144-496b-8257-d443f5146fd3','N','prodname','prodname',100,TO_DATE('2013-03-01 17:57:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:27','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208797 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208798,'D','N','N','N','N',2147483647,'N',14,'N',1417,'4c7a77dc-4876-4d37-9280-c22aa2beb240','N','Product','Product',100,TO_DATE('2013-03-01 17:57:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:28','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208798 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:57:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('prodcategory',202292,'D','prodcategory','prodcategory','4cf9d342-eb9b-411f-8d86-ca2627f93627',0,TO_DATE('2013-03-01 17:57:29','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 17:57:29','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 5:57:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202292 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 5:57:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200073,208799,'D','N','N','N','N',60,'N',10,'N',202292,'43473408-72fc-4138-95d5-c4adc5665f1b','N','prodcategory','prodcategory',100,TO_DATE('2013-03-01 17:57:29','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 17:57:29','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 5:57:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208799 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 5:59:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='AC_Code', Name='Account Code', PrintName='Account Code',Updated=TO_DATE('2013-03-01 17:59:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202276
;

-- Mar 1, 2013 5:59:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202276
;

-- Mar 1, 2013 5:59:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AC_Code', Name='Account Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202276
;

-- Mar 1, 2013 5:59:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AC_Code', Name='Account Code', Description=NULL, Help=NULL, AD_Element_ID=202276 WHERE UPPER(ColumnName)='AC_CODE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 5:59:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AC_Code', Name='Account Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202276 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:59:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AC_Code', Name='Account Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202276 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:59:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Account Code', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202276) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 5:59:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Account Code', Name='Account Code' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202276)
;

-- Mar 1, 2013 6:01:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='AC_Group', Name='AC Group', PrintName='AC Group',Updated=TO_DATE('2013-03-01 18:01:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202281
;

-- Mar 1, 2013 6:01:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202281
;

-- Mar 1, 2013 6:01:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AC_Group', Name='AC Group', Description=NULL, Help=NULL WHERE AD_Element_ID=202281
;

-- Mar 1, 2013 6:01:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AC_Group', Name='AC Group', Description=NULL, Help=NULL, AD_Element_ID=202281 WHERE UPPER(ColumnName)='AC_GROUP' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:01:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AC_Group', Name='AC Group', Description=NULL, Help=NULL WHERE AD_Element_ID=202281 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:01:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AC_Group', Name='AC Group', Description=NULL, Help=NULL WHERE AD_Element_ID=202281 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:01:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='AC Group', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202281) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:01:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='AC Group', Name='AC Group' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202281)
;

-- Mar 1, 2013 6:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='AC Code', PrintName='AC Code',Updated=TO_DATE('2013-03-01 18:01:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202276
;

-- Mar 1, 2013 6:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202276
;

-- Mar 1, 2013 6:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AC_Code', Name='AC Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202276
;

-- Mar 1, 2013 6:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AC_Code', Name='AC Code', Description=NULL, Help=NULL, AD_Element_ID=202276 WHERE UPPER(ColumnName)='AC_CODE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AC_Code', Name='AC Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202276 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AC_Code', Name='AC Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202276 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='AC Code', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202276) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='AC Code', Name='AC Code' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202276)
;

-- Mar 1, 2013 6:02:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='AC_Name', Name='AC Name', PrintName='AC Name',Updated=TO_DATE('2013-03-01 18:02:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202277
;

-- Mar 1, 2013 6:02:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202277
;

-- Mar 1, 2013 6:02:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AC_Name', Name='AC Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202277
;

-- Mar 1, 2013 6:02:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AC_Name', Name='AC Name', Description=NULL, Help=NULL, AD_Element_ID=202277 WHERE UPPER(ColumnName)='AC_NAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:02:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AC_Name', Name='AC Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202277 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:02:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AC_Name', Name='AC Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202277 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:02:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='AC Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202277) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:02:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='AC Name', Name='AC Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202277)
;

-- Mar 1, 2013 6:02:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='Account_Name', Name='Account Name', PrintName='Account Name',Updated=TO_DATE('2013-03-01 18:02:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202278
;

-- Mar 1, 2013 6:02:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202278
;

-- Mar 1, 2013 6:02:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='Account_Name', Name='Account Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202278
;

-- Mar 1, 2013 6:02:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Account_Name', Name='Account Name', Description=NULL, Help=NULL, AD_Element_ID=202278 WHERE UPPER(ColumnName)='ACCOUNT_NAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:02:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Account_Name', Name='Account Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202278 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:02:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='Account_Name', Name='Account Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202278 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:02:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Account Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202278) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:02:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Account Name', Name='Account Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202278)
;

-- Mar 1, 2013 6:05:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='Act_Bud', Name='Posting Type Name', PrintName='Posting Type Name',Updated=TO_DATE('2013-03-01 18:05:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202269
;

-- Mar 1, 2013 6:05:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202269
;

-- Mar 1, 2013 6:05:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='Act_Bud', Name='Posting Type Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202269
;

-- Mar 1, 2013 6:05:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Act_Bud', Name='Posting Type Name', Description=NULL, Help=NULL, AD_Element_ID=202269 WHERE UPPER(ColumnName)='ACT_BUD' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:05:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Act_Bud', Name='Posting Type Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202269 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:05:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='Act_Bud', Name='Posting Type Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202269 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:05:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Posting Type Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202269) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:05:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Posting Type Name', Name='Posting Type Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202269)
;

-- Mar 1, 2013 6:06:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='AmtSce', Name='Source Amount', PrintName='Source Amount',Updated=TO_DATE('2013-03-01 18:06:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202271
;

-- Mar 1, 2013 6:06:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202271
;

-- Mar 1, 2013 6:06:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtSce', Name='Source Amount', Description=NULL, Help=NULL WHERE AD_Element_ID=202271
;

-- Mar 1, 2013 6:06:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtSce', Name='Source Amount', Description=NULL, Help=NULL, AD_Element_ID=202271 WHERE UPPER(ColumnName)='AMTSCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:06:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtSce', Name='Source Amount', Description=NULL, Help=NULL WHERE AD_Element_ID=202271 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:06:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtSce', Name='Source Amount', Description=NULL, Help=NULL WHERE AD_Element_ID=202271 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:06:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Source Amount', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202271) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:06:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Source Amount', Name='Source Amount' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202271)
;

-- Mar 1, 2013 6:07:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='BPartnerCodeAndName', Name='BP Code and Name', PrintName='BP Code and Name',Updated=TO_DATE('2013-03-01 18:07:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202287
;

-- Mar 1, 2013 6:07:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202287
;

-- Mar 1, 2013 6:07:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='BPartnerCodeAndName', Name='BP Code and Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202287
;

-- Mar 1, 2013 6:07:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BPartnerCodeAndName', Name='BP Code and Name', Description=NULL, Help=NULL, AD_Element_ID=202287 WHERE UPPER(ColumnName)='BPARTNERCODEANDNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:07:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BPartnerCodeAndName', Name='BP Code and Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202287 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:07:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='BPartnerCodeAndName', Name='BP Code and Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202287 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:07:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='BP Code and Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202287) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:07:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='BP Code and Name', Name='BP Code and Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202287)
;

-- Mar 1, 2013 6:07:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='BPCode', Name='BP Code', PrintName='BP Code',Updated=TO_DATE('2013-03-01 18:07:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202286
;

-- Mar 1, 2013 6:07:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202286
;

-- Mar 1, 2013 6:07:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='BPCode', Name='BP Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202286
;

-- Mar 1, 2013 6:07:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BPCode', Name='BP Code', Description=NULL, Help=NULL, AD_Element_ID=202286 WHERE UPPER(ColumnName)='BPCODE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:07:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BPCode', Name='BP Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202286 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:07:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='BPCode', Name='BP Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202286 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:07:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='BP Code', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202286) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:07:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='BP Code', Name='BP Code' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202286)
;

-- Mar 1, 2013 6:08:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='BPGroupName', Name='BP Group Name', PrintName='BP Group Name',Updated=TO_DATE('2013-03-01 18:08:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202288
;

-- Mar 1, 2013 6:08:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202288
;

-- Mar 1, 2013 6:08:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='BPGroupName', Name='BP Group Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202288
;

-- Mar 1, 2013 6:08:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BPGroupName', Name='BP Group Name', Description=NULL, Help=NULL, AD_Element_ID=202288 WHERE UPPER(ColumnName)='BPGROUPNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:08:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BPGroupName', Name='BP Group Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202288 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:08:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='BPGroupName', Name='BP Group Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202288 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:08:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='BP Group Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202288) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:08:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='BP Group Name', Name='BP Group Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202288)
;

-- Mar 1, 2013 6:08:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='BS$ACT', Name='BS$ACT', PrintName='BS$ACT',Updated=TO_DATE('2013-03-01 18:08:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202273
;

-- Mar 1, 2013 6:08:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202273
;

-- Mar 1, 2013 6:08:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='BS$ACT', Name='BS$ACT', Description=NULL, Help=NULL WHERE AD_Element_ID=202273
;

-- Mar 1, 2013 6:08:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BS$ACT', Name='BS$ACT', Description=NULL, Help=NULL, AD_Element_ID=202273 WHERE UPPER(ColumnName)='BS$ACT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:08:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BS$ACT', Name='BS$ACT', Description=NULL, Help=NULL WHERE AD_Element_ID=202273 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:08:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='BS$ACT', Name='BS$ACT', Description=NULL, Help=NULL WHERE AD_Element_ID=202273 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:08:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='BS$ACT', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202273) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:08:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='BS$ACT', Name='BS$ACT' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202273)
;

-- Mar 1, 2013 6:09:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='BSDate', Name='BS Date', PrintName='BS Date',Updated=TO_DATE('2013-03-01 18:09:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202262
;

-- Mar 1, 2013 6:09:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202262
;

-- Mar 1, 2013 6:09:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='BSDate', Name='BS Date', Description=NULL, Help=NULL WHERE AD_Element_ID=202262
;

-- Mar 1, 2013 6:09:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BSDate', Name='BS Date', Description=NULL, Help=NULL, AD_Element_ID=202262 WHERE UPPER(ColumnName)='BSDATE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:09:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BSDate', Name='BS Date', Description=NULL, Help=NULL WHERE AD_Element_ID=202262 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:09:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='BSDate', Name='BS Date', Description=NULL, Help=NULL WHERE AD_Element_ID=202262 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:09:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='BS Date', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202262) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:09:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='BS Date', Name='BS Date' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202262)
;

-- Mar 1, 2013 6:10:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='BSGroup', Name='BS Group', PrintName='BS Group',Updated=TO_DATE('2013-03-01 18:10:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202282
;

-- Mar 1, 2013 6:10:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202282
;

-- Mar 1, 2013 6:10:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='BSGroup', Name='BS Group', Description=NULL, Help=NULL WHERE AD_Element_ID=202282
;

-- Mar 1, 2013 6:10:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BSGroup', Name='BS Group', Description=NULL, Help=NULL, AD_Element_ID=202282 WHERE UPPER(ColumnName)='BSGROUP' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:10:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BSGroup', Name='BS Group', Description=NULL, Help=NULL WHERE AD_Element_ID=202282 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:10:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='BSGroup', Name='BS Group', Description=NULL, Help=NULL WHERE AD_Element_ID=202282 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:10:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='BS Group', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202282) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:10:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='BS Group', Name='BS Group' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202282)
;

-- Mar 1, 2013 6:11:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='BSMth', Name='BS Month', PrintName='BS Month',Updated=TO_DATE('2013-03-01 18:11:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202263
;

-- Mar 1, 2013 6:11:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202263
;

-- Mar 1, 2013 6:11:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='BSMth', Name='BS Month', Description=NULL, Help=NULL WHERE AD_Element_ID=202263
;

-- Mar 1, 2013 6:11:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BSMth', Name='BS Month', Description=NULL, Help=NULL, AD_Element_ID=202263 WHERE UPPER(ColumnName)='BSMTH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:11:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BSMth', Name='BS Month', Description=NULL, Help=NULL WHERE AD_Element_ID=202263 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:11:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='BSMth', Name='BS Month', Description=NULL, Help=NULL WHERE AD_Element_ID=202263 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:11:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='BS Month', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202263) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:11:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='BS Month', Name='BS Month' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202263)
;

-- Mar 1, 2013 6:11:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='BSTypeName', Name='BS Type Name', PrintName='BS Type Name',Updated=TO_DATE('2013-03-01 18:11:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202279
;

-- Mar 1, 2013 6:11:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202279
;

-- Mar 1, 2013 6:11:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='BSTypeName', Name='BS Type Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202279
;

-- Mar 1, 2013 6:11:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BSTypeName', Name='BS Type Name', Description=NULL, Help=NULL, AD_Element_ID=202279 WHERE UPPER(ColumnName)='BSTYPENAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:11:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BSTypeName', Name='BS Type Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202279 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:11:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='BSTypeName', Name='BS Type Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202279 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:11:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='BS Type Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202279) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:11:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='BS Type Name', Name='BS Type Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202279)
;

-- Mar 1, 2013 6:12:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='BudName', Name='Budget Name', PrintName='Budget Name',Updated=TO_DATE('2013-03-01 18:12:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202267
;

-- Mar 1, 2013 6:12:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202267
;

-- Mar 1, 2013 6:12:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='BudName', Name='Budget Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202267
;

-- Mar 1, 2013 6:12:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BudName', Name='Budget Name', Description=NULL, Help=NULL, AD_Element_ID=202267 WHERE UPPER(ColumnName)='BUDNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:12:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='BudName', Name='Budget Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202267 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:12:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='BudName', Name='Budget Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202267 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:12:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Budget Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202267) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:12:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Budget Name', Name='Budget Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202267)
;

-- Mar 1, 2013 6:12:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='Currency', Name='Currency', PrintName='Currency',Updated=TO_DATE('2013-03-01 18:12:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202270
;

-- Mar 1, 2013 6:12:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202270
;

-- Mar 1, 2013 6:12:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='Currency', Name='Currency', Description=NULL, Help=NULL WHERE AD_Element_ID=202270
;

-- Mar 1, 2013 6:12:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Currency', Name='Currency', Description=NULL, Help=NULL, AD_Element_ID=202270 WHERE UPPER(ColumnName)='CURRENCY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:12:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Currency', Name='Currency', Description=NULL, Help=NULL WHERE AD_Element_ID=202270 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:12:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='Currency', Name='Currency', Description=NULL, Help=NULL WHERE AD_Element_ID=202270 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:12:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Currency', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202270) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:12:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Currency', Name='Currency' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202270)
;

-- Mar 1, 2013 6:13:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='FYear', Name='Financial Year', PrintName='Financial Year',Updated=TO_DATE('2013-03-01 18:13:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202264
;

-- Mar 1, 2013 6:13:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202264
;

-- Mar 1, 2013 6:13:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='FYear', Name='Financial Year', Description=NULL, Help=NULL WHERE AD_Element_ID=202264
;

-- Mar 1, 2013 6:13:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='FYear', Name='Financial Year', Description=NULL, Help=NULL, AD_Element_ID=202264 WHERE UPPER(ColumnName)='FYEAR' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:13:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='FYear', Name='Financial Year', Description=NULL, Help=NULL WHERE AD_Element_ID=202264 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:13:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='FYear', Name='Financial Year', Description=NULL, Help=NULL WHERE AD_Element_ID=202264 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:13:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Financial Year', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202264) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:13:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Financial Year', Name='Financial Year' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202264)
;

-- Mar 1, 2013 6:13:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='FYMth', Name='Financial Month', PrintName='Financial Month',Updated=TO_DATE('2013-03-01 18:13:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202265
;

-- Mar 1, 2013 6:13:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202265
;

-- Mar 1, 2013 6:13:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='FYMth', Name='Financial Month', Description=NULL, Help=NULL WHERE AD_Element_ID=202265
;

-- Mar 1, 2013 6:13:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='FYMth', Name='Financial Month', Description=NULL, Help=NULL, AD_Element_ID=202265 WHERE UPPER(ColumnName)='FYMTH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:13:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='FYMth', Name='Financial Month', Description=NULL, Help=NULL WHERE AD_Element_ID=202265 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:13:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='FYMth', Name='Financial Month', Description=NULL, Help=NULL WHERE AD_Element_ID=202265 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:13:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Financial Month', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202265) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:13:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Financial Month', Name='Financial Month' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202265)
;

-- Mar 1, 2013 6:14:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='Na_Eq', Name='Net Assets / Equity', PrintName='Net Assets / Equity',Updated=TO_DATE('2013-03-01 18:14:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202285
;

-- Mar 1, 2013 6:14:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202285
;

-- Mar 1, 2013 6:14:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='Na_Eq', Name='Net Assets / Equity', Description=NULL, Help=NULL WHERE AD_Element_ID=202285
;

-- Mar 1, 2013 6:14:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Na_Eq', Name='Net Assets / Equity', Description=NULL, Help=NULL, AD_Element_ID=202285 WHERE UPPER(ColumnName)='NA_EQ' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:14:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Na_Eq', Name='Net Assets / Equity', Description=NULL, Help=NULL WHERE AD_Element_ID=202285 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:14:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='Na_Eq', Name='Net Assets / Equity', Description=NULL, Help=NULL WHERE AD_Element_ID=202285 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:14:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Net Assets / Equity', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202285) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:14:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Net Assets / Equity', Name='Net Assets / Equity' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202285)
;

-- Mar 1, 2013 6:15:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='PL$ACT', Name='PL$ACT', PrintName='PL$ACT',Updated=TO_DATE('2013-03-01 18:15:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202272
;

-- Mar 1, 2013 6:15:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202272
;

-- Mar 1, 2013 6:15:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='PL$ACT', Name='PL$ACT', Description=NULL, Help=NULL WHERE AD_Element_ID=202272
;

-- Mar 1, 2013 6:15:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='PL$ACT', Name='PL$ACT', Description=NULL, Help=NULL, AD_Element_ID=202272 WHERE UPPER(ColumnName)='PL$ACT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:15:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='PL$ACT', Name='PL$ACT', Description=NULL, Help=NULL WHERE AD_Element_ID=202272 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:15:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='PL$ACT', Name='PL$ACT', Description=NULL, Help=NULL WHERE AD_Element_ID=202272 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:15:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='PL$ACT', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202272) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:15:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='PL$ACT', Name='PL$ACT' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202272)
;

-- Mar 1, 2013 6:16:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='PL$BUD', Name='PL$BUD', PrintName='PL$BUD',Updated=TO_DATE('2013-03-01 18:16:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202274
;

-- Mar 1, 2013 6:16:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202274
;

-- Mar 1, 2013 6:16:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='PL$BUD', Name='PL$BUD', Description=NULL, Help=NULL WHERE AD_Element_ID=202274
;

-- Mar 1, 2013 6:16:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='PL$BUD', Name='PL$BUD', Description=NULL, Help=NULL, AD_Element_ID=202274 WHERE UPPER(ColumnName)='PL$BUD' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:16:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='PL$BUD', Name='PL$BUD', Description=NULL, Help=NULL WHERE AD_Element_ID=202274 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:16:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='PL$BUD', Name='PL$BUD', Description=NULL, Help=NULL WHERE AD_Element_ID=202274 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:16:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='PL$BUD', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202274) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:16:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='PL$BUD', Name='PL$BUD' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202274)
;

-- Mar 1, 2013 6:16:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='PLBS', Name='PL / BS', PrintName='PL / BS',Updated=TO_DATE('2013-03-01 18:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202284
;

-- Mar 1, 2013 6:16:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202284
;

-- Mar 1, 2013 6:16:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='PLBS', Name='PL / BS', Description=NULL, Help=NULL WHERE AD_Element_ID=202284
;

-- Mar 1, 2013 6:16:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='PLBS', Name='PL / BS', Description=NULL, Help=NULL, AD_Element_ID=202284 WHERE UPPER(ColumnName)='PLBS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:16:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='PLBS', Name='PL / BS', Description=NULL, Help=NULL WHERE AD_Element_ID=202284 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:16:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='PLBS', Name='PL / BS', Description=NULL, Help=NULL WHERE AD_Element_ID=202284 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:16:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='PL / BS', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202284) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:16:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='PL / BS', Name='PL / BS' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202284)
;

-- Mar 1, 2013 6:16:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='PLGroup', Name='PL Group', PrintName='PL Group',Updated=TO_DATE('2013-03-01 18:16:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202283
;

-- Mar 1, 2013 6:16:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202283
;

-- Mar 1, 2013 6:16:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='PLGroup', Name='PL Group', Description=NULL, Help=NULL WHERE AD_Element_ID=202283
;

-- Mar 1, 2013 6:16:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='PLGroup', Name='PL Group', Description=NULL, Help=NULL, AD_Element_ID=202283 WHERE UPPER(ColumnName)='PLGROUP' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:16:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='PLGroup', Name='PL Group', Description=NULL, Help=NULL WHERE AD_Element_ID=202283 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:16:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='PLGroup', Name='PL Group', Description=NULL, Help=NULL WHERE AD_Element_ID=202283 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:16:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='PL Group', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202283) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:16:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='PL Group', Name='PL Group' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202283)
;

-- Mar 1, 2013 6:17:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='PLTypeName', Name='PL Type Name', PrintName='PL Type Name',Updated=TO_DATE('2013-03-01 18:17:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202280
;

-- Mar 1, 2013 6:17:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202280
;

-- Mar 1, 2013 6:17:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='PLTypeName', Name='PL Type Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202280
;

-- Mar 1, 2013 6:17:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='PLTypeName', Name='PL Type Name', Description=NULL, Help=NULL, AD_Element_ID=202280 WHERE UPPER(ColumnName)='PLTYPENAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:17:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='PLTypeName', Name='PL Type Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202280 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:17:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='PLTypeName', Name='PL Type Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202280 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:17:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='PL Type Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202280) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:17:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='PL Type Name', Name='PL Type Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202280)
;

-- Mar 1, 2013 6:17:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='ProdCategory', Name='Product Category', PrintName='Product Category',Updated=TO_DATE('2013-03-01 18:17:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202292
;

-- Mar 1, 2013 6:17:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202292
;

-- Mar 1, 2013 6:17:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='ProdCategory', Name='Product Category', Description=NULL, Help=NULL WHERE AD_Element_ID=202292
;

-- Mar 1, 2013 6:17:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='ProdCategory', Name='Product Category', Description=NULL, Help=NULL, AD_Element_ID=202292 WHERE UPPER(ColumnName)='PRODCATEGORY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:17:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='ProdCategory', Name='Product Category', Description=NULL, Help=NULL WHERE AD_Element_ID=202292 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:17:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='ProdCategory', Name='Product Category', Description=NULL, Help=NULL WHERE AD_Element_ID=202292 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:17:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Product Category', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202292) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:17:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Product Category', Name='Product Category' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202292)
;

-- Mar 1, 2013 6:18:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='ProdCode', Name='Product Code', PrintName='Product Code',Updated=TO_DATE('2013-03-01 18:18:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202290
;

-- Mar 1, 2013 6:18:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202290
;

-- Mar 1, 2013 6:18:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='ProdCode', Name='Product Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202290
;

-- Mar 1, 2013 6:18:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='ProdCode', Name='Product Code', Description=NULL, Help=NULL, AD_Element_ID=202290 WHERE UPPER(ColumnName)='PRODCODE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:18:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='ProdCode', Name='Product Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202290 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:18:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='ProdCode', Name='Product Code', Description=NULL, Help=NULL WHERE AD_Element_ID=202290 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:18:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Product Code', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202290) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:18:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Product Code', Name='Product Code' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202290)
;

-- Mar 1, 2013 6:18:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='ProdName', Name='Product Name', PrintName='Product Name',Updated=TO_DATE('2013-03-01 18:18:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202291
;

-- Mar 1, 2013 6:18:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202291
;

-- Mar 1, 2013 6:18:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='ProdName', Name='Product Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202291
;

-- Mar 1, 2013 6:18:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='ProdName', Name='Product Name', Description=NULL, Help=NULL, AD_Element_ID=202291 WHERE UPPER(ColumnName)='PRODNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:18:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='ProdName', Name='Product Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202291 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:18:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='ProdName', Name='Product Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202291 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:18:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Product Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202291) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:18:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Product Name', Name='Product Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202291)
;

-- Mar 1, 2013 6:18:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='RepName', Name='Sales Rep Name', PrintName='Sales Rep Name',Updated=TO_DATE('2013-03-01 18:18:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202289
;

-- Mar 1, 2013 6:18:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202289
;

-- Mar 1, 2013 6:18:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='RepName', Name='Sales Rep Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202289
;

-- Mar 1, 2013 6:18:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='RepName', Name='Sales Rep Name', Description=NULL, Help=NULL, AD_Element_ID=202289 WHERE UPPER(ColumnName)='REPNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:18:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='RepName', Name='Sales Rep Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202289 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:18:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='RepName', Name='Sales Rep Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202289 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:18:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Sales Rep Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202289) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:18:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Sales Rep Name', Name='Sales Rep Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202289)
;

-- Mar 1, 2013 6:19:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='Table_Name', Name='Table Name', PrintName='Table Name',Updated=TO_DATE('2013-03-01 18:19:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202266
;

-- Mar 1, 2013 6:19:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202266
;

-- Mar 1, 2013 6:19:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='Table_Name', Name='Table Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202266
;

-- Mar 1, 2013 6:19:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Table_Name', Name='Table Name', Description=NULL, Help=NULL, AD_Element_ID=202266 WHERE UPPER(ColumnName)='TABLE_NAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:19:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Table_Name', Name='Table Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202266 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:19:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='Table_Name', Name='Table Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202266 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:19:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Table Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202266) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:19:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Table Name', Name='Table Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202266)
;

-- Mar 1, 2013 6:19:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='TaxName', Name='Tax Name', PrintName='Tax Name',Updated=TO_DATE('2013-03-01 18:19:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202268
;

-- Mar 1, 2013 6:19:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202268
;

-- Mar 1, 2013 6:19:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='TaxName', Name='Tax Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202268
;

-- Mar 1, 2013 6:19:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='TaxName', Name='Tax Name', Description=NULL, Help=NULL, AD_Element_ID=202268 WHERE UPPER(ColumnName)='TAXNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:19:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='TaxName', Name='Tax Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202268 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:19:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='TaxName', Name='Tax Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202268 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:19:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Tax Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202268) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:19:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Tax Name', Name='Tax Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202268)
;

-- Mar 1, 2013 6:19:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='UOMName', Name='UOM Name', PrintName='UOM Name',Updated=TO_DATE('2013-03-01 18:19:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202275
;

-- Mar 1, 2013 6:19:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202275
;

-- Mar 1, 2013 6:19:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='UOMName', Name='UOM Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202275
;

-- Mar 1, 2013 6:19:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='UOMName', Name='UOM Name', Description=NULL, Help=NULL, AD_Element_ID=202275 WHERE UPPER(ColumnName)='UOMNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 6:19:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='UOMName', Name='UOM Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202275 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:19:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='UOMName', Name='UOM Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202275 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:19:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='UOM Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202275) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 6:19:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='UOM Name', Name='UOM Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202275)
;

-- Mar 1, 2013 6:21:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_ReportView (AD_ReportView_UU,AD_Table_ID,AD_ReportView_ID,EntityType,Name,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Org_ID,IsActive) VALUES ('1ec4db62-c8ab-4320-ae3c-9bb8af432f7e',200072,200003,'D','RV_Fact_Simple',0,TO_DATE('2013-03-01 18:21:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 18:21:07','YYYY-MM-DD HH24:MI:SS'),100,0,'Y')
;

-- Mar 1, 2013 6:21:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_ReportView (AD_ReportView_UU,AD_Table_ID,AD_ReportView_ID,EntityType,Name,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Org_ID,IsActive) VALUES ('e760d018-1023-46a2-b508-2f6659bbdf6c',200073,200004,'D','RV_Fact_Adaxa',0,TO_DATE('2013-03-01 18:21:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 18:21:25','YYYY-MM-DD HH24:MI:SS'),100,0,'Y')
;

-- Mar 1, 2013 6:22:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,AD_ReportView_ID,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Name,Value,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,IsActive,CreatedBy) VALUES ('N',200037,'N',200003,'Y','e6d33f36-e200-4ab2-95f8-884959210b7e','3','N','N',0,0,'Y','D','Simple Fact View','RV_Fact_Simple',0,0,TO_DATE('2013-03-01 18:22:44','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 18:22:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',100)
;

-- Mar 1, 2013 6:22:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200037 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Mar 1, 2013 6:23:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',181,200056,'99999b62-5a7a-4de7-adb3-25bcefed3b88','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar',200037,19,'N','D','Accounting Schema','C_AcctSchema_ID','Rules for accounting',0,'Y',10,'Y',100,TO_DATE('2013-03-01 18:23:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 18:23:24','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 1, 2013 6:23:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200056 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Mar 1, 2013 6:23:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,AD_Reference_Value_ID,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',113,200057,'5aed24a0-841e-413f-8a0a-f7429e810563','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200037,18,'N',130,'D','Organization','AD_Org_ID','Organizational entity within client',0,'Y',20,'Y',100,TO_DATE('2013-03-01 18:23:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 18:23:57','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 1, 2013 6:23:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200057 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Mar 1, 2013 6:24:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,AD_Reference_Value_ID,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',148,200058,'62d9bcae-8b17-4951-9372-8266dd9c5ac4','The (natural) account used',200037,18,'N',132,'D','Account','Account_ID','Account used',0,'Y',30,'Y',100,TO_DATE('2013-03-01 18:24:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 18:24:28','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 1, 2013 6:24:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200058 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Mar 1, 2013 6:25:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('Y',2083,200059,'a575f559-4406-48f7-803a-f6f8eb52c143',200037,10,'N','D','Account Key','AccountValue','Key of Account Element',0,'Y',40,'Y',100,TO_DATE('2013-03-01 18:25:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 18:25:05','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 1, 2013 6:25:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200059 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Mar 1, 2013 6:26:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,VFormat,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('Y',202259,200060,'7d107cc7-f8be-4e63-95bd-f8d965de08ec','The only valid date format is: YYYY-MM',200037,10,'N','D','Financial Year Month','FinYear_Mth','The only valid date format is: YYYY-MM',0,'N','0000-00',50,'Y',100,TO_DATE('2013-03-01 18:26:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 18:26:40','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 1, 2013 6:26:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200060 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Mar 1, 2013 6:27:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,AD_ReportView_ID,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Name,Value,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,IsActive,CreatedBy) VALUES ('N',200038,'N',200004,'Y','fab3d440-ee73-4aef-a2ba-c7d96b2c5934','3','N','N',0,0,'Y','D','Complex Fact View','RV_Fact_Adaxa',0,0,TO_DATE('2013-03-01 18:27:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 18:27:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',100)
;

-- Mar 1, 2013 6:27:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200038 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Mar 1, 2013 6:28:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormat (CreateCopy,IsForm,IsDefault,AD_PrintFormat_ID,IsStandardHeaderFooter,AD_ReportView_ID,AD_PrintPaper_ID,AD_PrintColor_ID,AD_PrintTableFormat_ID,IsTableBased,AD_Table_ID,HeaderMargin,AD_PrintFont_ID,AD_PrintFormat_UU,FooterMargin,Name,Updated,CreatedBy,Created,UpdatedBy,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('N','N','N',200007,'Y',200003,100,100,100,'Y',200072,0,130,'23bf5453-6efa-4109-a8d2-251d0b7bc5dc',0,'Simple Fact View',TO_DATE('2013-03-01 18:28:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 18:28:52','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',0)
;

-- Mar 1, 2013 6:29:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET AD_PrintPaper_ID=100, AD_PrintColor_ID=100, AD_Table_ID=200072, AD_PrintFont_ID=130, Name='RV_Fact_Simple_2',Updated=TO_DATE('2013-03-01 18:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200007
;

-- Mar 1, 2013 6:29:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Account',0,'N','Y','C',200007,'N',0,'F','N',1,208749,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Account',0,'N','60d36388-7dc0-4ba8-83bf-d933a7818b88',0,200164,'N',0,TO_DATE('2013-03-01 18:29:04','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:04','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200164 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208749) WHERE AD_PrintFormatItem_ID = 200164 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208749 AND trl.AD_PrintFormatItem_ID = 200164) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Account Date',0,'N','Y','C',200007,'N',0,'F','N',2,208752,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Acct Date',0,'N','7520594e-9c61-475f-bd20-f31e85a12b13',0,200165,'N',0,TO_DATE('2013-03-01 18:29:06','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:06','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200165 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208752) WHERE AD_PrintFormatItem_ID = 200165 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208752 AND trl.AD_PrintFormatItem_ID = 200165) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Account Key',0,'N','Y','C',200007,'N',0,'F','N',3,208750,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Account Key',0,'N','cabeb09c-e6eb-4a34-84bc-37362c2859ac',0,200166,'N',0,TO_DATE('2013-03-01 18:29:06','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:06','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200166 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208750) WHERE AD_PrintFormatItem_ID = 200166 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208750 AND trl.AD_PrintFormatItem_ID = 200166) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Account Type',0,'N','Y','C',200007,'N',0,'F','N',4,208751,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Account Type',0,'N','a54ee288-58b7-45ca-9d7f-695002d81ee9',0,200167,'N',0,TO_DATE('2013-03-01 18:29:07','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:07','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200167 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208751) WHERE AD_PrintFormatItem_ID = 200167 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208751 AND trl.AD_PrintFormatItem_ID = 200167) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Accounted Amount',0,'N','Y','C',200007,'N',0,'F','N',5,208754,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Accounted',0,'N','1eafb308-8386-49f1-bc39-2c448d54ee03',0,200168,'N',0,TO_DATE('2013-03-01 18:29:09','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:09','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200168 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208754) WHERE AD_PrintFormatItem_ID = 200168 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208754 AND trl.AD_PrintFormatItem_ID = 200168) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Accounting Schema',0,'N','Y','C',200007,'N',0,'F','N',6,208748,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Accounting Schema',0,'N','a14d8bf2-7c01-4400-9ad7-2ed1646a8ebc',0,200169,'N',0,TO_DATE('2013-03-01 18:29:10','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:10','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200169 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208748) WHERE AD_PrintFormatItem_ID = 200169 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208748 AND trl.AD_PrintFormatItem_ID = 200169) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Active',0,'N','N','C',200007,'N',0,'F','N',0,208742,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Active',0,'N','6895b288-b96d-4b47-9129-c0195b5d9f94',0,200170,'N',0,TO_DATE('2013-03-01 18:29:11','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:11','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200170 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208742) WHERE AD_PrintFormatItem_ID = 200170 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208742 AND trl.AD_PrintFormatItem_ID = 200170) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Case',0,'N','Y','C',200007,'N',0,'F','N',8,208756,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Case',0,'N','263fbc37-0453-480d-a06a-2eed8f3ef790',0,200171,'N',0,TO_DATE('2013-03-01 18:29:11','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:11','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200171 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208756) WHERE AD_PrintFormatItem_ID = 200171 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208756 AND trl.AD_PrintFormatItem_ID = 200171) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Client',0,'N','N','C',200007,'N',0,'F','N',0,208740,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Client',0,'N','04bcb33e-4b5d-4c5b-be03-484a973e1b04',0,200172,'N',0,TO_DATE('2013-03-01 18:29:12','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:12','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200172 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208740) WHERE AD_PrintFormatItem_ID = 200172 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208740 AND trl.AD_PrintFormatItem_ID = 200172) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Created',0,'N','N','C',200007,'N',0,'F','N',0,208743,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Created',0,'N','aaa0a1c6-1132-4790-bf53-a1470e20103f',0,200173,'N',0,TO_DATE('2013-03-01 18:29:13','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:13','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200173 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208743) WHERE AD_PrintFormatItem_ID = 200173 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208743 AND trl.AD_PrintFormatItem_ID = 200173) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Created By',0,'N','N','C',200007,'N',0,'F','N',0,208744,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Created By',0,'N','c4eae83a-22de-49fc-b9b5-4063b850dd40',0,200174,'N',0,TO_DATE('2013-03-01 18:29:14','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:14','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200174 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208744) WHERE AD_PrintFormatItem_ID = 200174 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208744 AND trl.AD_PrintFormatItem_ID = 200174) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Financial Month',0,'N','Y','C',200007,'N',0,'F','N',12,208753,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Financial Month',0,'N','55d02756-f9d9-4e77-8898-65d822d27a60',0,200175,'N',0,TO_DATE('2013-03-01 18:29:15','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:15','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200175 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208753) WHERE AD_PrintFormatItem_ID = 200175 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208753 AND trl.AD_PrintFormatItem_ID = 200175) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Financial Year',0,'N','Y','C',200007,'N',0,'F','N',13,208755,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Financial Year',0,'N','54237461-0306-4082-867a-fec75c5b9ea3',0,200176,'N',0,TO_DATE('2013-03-01 18:29:16','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:16','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200176 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208755) WHERE AD_PrintFormatItem_ID = 200176 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208755 AND trl.AD_PrintFormatItem_ID = 200176) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Organization',0,'N','N','C',200007,'N',0,'F','N',0,208741,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Organization',0,'N','30309939-89d4-4b23-9510-de498becc157',0,200177,'N',0,TO_DATE('2013-03-01 18:29:16','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:16','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200177 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208741) WHERE AD_PrintFormatItem_ID = 200177 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208741 AND trl.AD_PrintFormatItem_ID = 200177) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Project',0,'N','Y','C',200007,'N',0,'F','N',15,208747,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Project',0,'N','0557c4e8-a4e3-4d34-b34e-b00fbc60df41',0,200178,'N',0,TO_DATE('2013-03-01 18:29:17','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:17','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200178 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208747) WHERE AD_PrintFormatItem_ID = 200178 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208747 AND trl.AD_PrintFormatItem_ID = 200178) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Updated',0,'N','N','C',200007,'N',0,'F','N',0,208745,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Updated',0,'N','84b1a320-54d0-4df0-8c8e-6dc9ea3d003d',0,200179,'N',0,TO_DATE('2013-03-01 18:29:18','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:18','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200179 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208745) WHERE AD_PrintFormatItem_ID = 200179 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208745 AND trl.AD_PrintFormatItem_ID = 200179) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Updated By',0,'N','N','C',200007,'N',0,'F','N',0,208746,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Updated By',0,'N','37a3c314-f244-4931-abfe-fa77c72011f8',0,200180,'N',0,TO_DATE('2013-03-01 18:29:19','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:29:19','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:29:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200180 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:29:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208746) WHERE AD_PrintFormatItem_ID = 200180 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208746 AND trl.AD_PrintFormatItem_ID = 200180) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:29:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET Name='Simple Fact View',Updated=TO_DATE('2013-03-01 18:29:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200007
;

-- Mar 1, 2013 6:30:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200165
;

-- Mar 1, 2013 6:30:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200166
;

-- Mar 1, 2013 6:30:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200169
;

-- Mar 1, 2013 6:30:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200178
;

-- Mar 1, 2013 6:30:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=10,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200171
;

-- Mar 1, 2013 6:30:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=20,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200167
;

-- Mar 1, 2013 6:30:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=30,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200164
;

-- Mar 1, 2013 6:30:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=40,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200176
;

-- Mar 1, 2013 6:30:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=50,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200175
;

-- Mar 1, 2013 6:30:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=60,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200168
;

-- Mar 1, 2013 6:30:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SortNo=10,IsOrderBy='Y' WHERE AD_PrintFormatItem_ID=200164
;

-- Mar 1, 2013 6:30:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SortNo=20,IsOrderBy='Y' WHERE AD_PrintFormatItem_ID=200167
;

-- Mar 1, 2013 6:31:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='Y', YPosition=0,Updated=TO_DATE('2013-03-01 18:31:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200167
;

-- Mar 1, 2013 6:31:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSummarized='Y', SortNo=0,Updated=TO_DATE('2013-03-01 18:31:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200168
;

-- Mar 1, 2013 6:31:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormat (CreateCopy,IsForm,IsDefault,AD_PrintFormat_ID,IsStandardHeaderFooter,AD_ReportView_ID,AD_PrintPaper_ID,AD_PrintColor_ID,IsTableBased,AD_Table_ID,HeaderMargin,AD_PrintFont_ID,AD_PrintFormat_UU,FooterMargin,Name,Updated,CreatedBy,Created,UpdatedBy,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('N','N','N',200008,'Y',200004,100,100,'Y',200073,0,130,'73172ae9-4315-4c41-be74-8cb5689e27f6',0,'Complex Fact View',TO_DATE('2013-03-01 18:31:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 18:31:41','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',0)
;

-- Mar 1, 2013 6:31:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET AD_PrintPaper_ID=100, AD_PrintColor_ID=100, AD_Table_ID=200073, AD_PrintFont_ID=130, Name='RV_Fact_Adaxa_2',Updated=TO_DATE('2013-03-01 18:31:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200008
;

-- Mar 1, 2013 6:31:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('AC Code',0,'N','Y','C',200008,'N',0,'F','N',1,208781,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','AC Code',0,'N','1fe443e5-fed4-496a-bdab-cae8fdeea1f2',0,200181,'N',0,TO_DATE('2013-03-01 18:31:50','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:50','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200181 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208781) WHERE AD_PrintFormatItem_ID = 200181 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208781 AND trl.AD_PrintFormatItem_ID = 200181) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('AC Group',0,'N','Y','C',200008,'N',0,'F','N',2,208786,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','AC Group',0,'N','cfd97f26-f582-4992-a5c8-35ffbf107ba0',0,200182,'N',0,TO_DATE('2013-03-01 18:31:51','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:51','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200182 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208786) WHERE AD_PrintFormatItem_ID = 200182 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208786 AND trl.AD_PrintFormatItem_ID = 200182) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('AC Name',0,'N','Y','C',200008,'N',0,'F','N',3,208782,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','AC Name',0,'N','0ee091a6-e8e2-4a77-8378-4d2f9fa7db44',0,200183,'N',0,TO_DATE('2013-03-01 18:31:51','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:51','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200183 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208782) WHERE AD_PrintFormatItem_ID = 200183 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208782 AND trl.AD_PrintFormatItem_ID = 200183) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Account Date',0,'N','Y','C',200008,'N',0,'F','N',4,208760,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Acct Date',0,'N','6ae42832-e1da-4511-8708-58d0a2c9354b',0,200184,'N',0,TO_DATE('2013-03-01 18:31:52','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:52','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200184 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208760) WHERE AD_PrintFormatItem_ID = 200184 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208760 AND trl.AD_PrintFormatItem_ID = 200184) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Account Name',0,'N','Y','C',200008,'N',0,'F','N',5,208783,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Account Name',0,'N','91e9d7a4-3ba8-49bd-b1f7-e365e117b54e',0,200185,'N',0,TO_DATE('2013-03-01 18:31:53','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:53','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200185 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208783) WHERE AD_PrintFormatItem_ID = 200185 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208783 AND trl.AD_PrintFormatItem_ID = 200185) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Accounted Amount',0,'N','Y','C',200008,'N',0,'F','N',6,208772,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Accounted',0,'N','145bdca3-f45e-45cd-96cf-5078653624cb',0,200186,'N',0,TO_DATE('2013-03-01 18:31:54','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:54','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200186 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208772) WHERE AD_PrintFormatItem_ID = 200186 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208772 AND trl.AD_PrintFormatItem_ID = 200186) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('BP Code',0,'N','Y','C',200008,'N',0,'F','N',7,208791,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','BP Code',0,'N','4a5fc986-1f32-4a15-81e9-3b48fd1ec8a4',0,200187,'N',0,TO_DATE('2013-03-01 18:31:55','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:55','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200187 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208791) WHERE AD_PrintFormatItem_ID = 200187 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208791 AND trl.AD_PrintFormatItem_ID = 200187) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('BP Code and Name',0,'N','Y','C',200008,'N',0,'F','N',8,208793,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','BP Code and Name',0,'N','581f892b-b5d3-4641-8272-ad0e91dbfcb3',0,200188,'N',0,TO_DATE('2013-03-01 18:31:55','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:55','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200188 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208793) WHERE AD_PrintFormatItem_ID = 200188 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208793 AND trl.AD_PrintFormatItem_ID = 200188) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('BP Group Name',0,'N','Y','C',200008,'N',0,'F','N',9,208794,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','BP Group Name',0,'N','8e89ea0c-9225-4fa4-8dfb-6614867e51e7',0,200189,'N',0,TO_DATE('2013-03-01 18:31:56','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:56','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200189 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208794) WHERE AD_PrintFormatItem_ID = 200189 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208794 AND trl.AD_PrintFormatItem_ID = 200189) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('BP Name',0,'N','Y','C',200008,'N',0,'F','N',10,208792,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','BP Name',0,'N','5cf859c0-2621-45a5-8f34-2f162afa4f2b',0,200190,'N',0,TO_DATE('2013-03-01 18:31:57','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:57','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200190 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208792) WHERE AD_PrintFormatItem_ID = 200190 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208792 AND trl.AD_PrintFormatItem_ID = 200190) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('BS Date',0,'N','Y','C',200008,'N',0,'F','N',11,208761,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','BS Date',0,'N','fabbe1a3-0ef3-411e-a31c-9275cc57e278',0,200191,'N',0,TO_DATE('2013-03-01 18:31:58','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:58','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200191 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208761) WHERE AD_PrintFormatItem_ID = 200191 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208761 AND trl.AD_PrintFormatItem_ID = 200191) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:31:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('BS Group',0,'N','Y','C',200008,'N',0,'F','N',12,208787,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','BS Group',0,'N','78fa067f-752d-4a3f-831a-aafa9f7a386f',0,200192,'N',0,TO_DATE('2013-03-01 18:31:58','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:58','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:31:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200192 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:31:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208787) WHERE AD_PrintFormatItem_ID = 200192 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208787 AND trl.AD_PrintFormatItem_ID = 200192) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('BS Month',0,'N','Y','C',200008,'N',0,'F','N',13,208762,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','BS Month',0,'N','9c4fa3f0-052a-4ea7-8e32-7eeb31b66dee',0,200193,'N',0,TO_DATE('2013-03-01 18:31:59','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:31:59','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200193 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208762) WHERE AD_PrintFormatItem_ID = 200193 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208762 AND trl.AD_PrintFormatItem_ID = 200193) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('BS Type Name',0,'N','Y','C',200008,'N',0,'F','N',14,208784,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','BS Type Name',0,'N','15d33071-ccdb-4a74-8d10-e94a55374d37',0,200194,'N',0,TO_DATE('2013-03-01 18:32:00','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:00','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200194 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208784) WHERE AD_PrintFormatItem_ID = 200194 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208784 AND trl.AD_PrintFormatItem_ID = 200194) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('BS$ACT',0,'N','Y','C',200008,'N',0,'F','N',15,208774,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','BS$ACT',0,'N','f4465ada-dabc-4a9b-b9ae-fc9236d95ccc',0,200195,'N',0,TO_DATE('2013-03-01 18:32:01','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:01','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200195 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208774) WHERE AD_PrintFormatItem_ID = 200195 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208774 AND trl.AD_PrintFormatItem_ID = 200195) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Budget Name',0,'N','Y','C',200008,'N',0,'F','N',16,208767,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Budget Name',0,'N','2f37ec62-67eb-48c7-88ee-fc4355029b77',0,200196,'N',0,TO_DATE('2013-03-01 18:32:01','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:01','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200196 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208767) WHERE AD_PrintFormatItem_ID = 200196 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208767 AND trl.AD_PrintFormatItem_ID = 200196) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Client',0,'N','N','C',200008,'N',0,'F','N',0,208757,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Client',0,'N','934ce8e4-780d-4778-ac09-6138c83ced25',0,200197,'N',0,TO_DATE('2013-03-01 18:32:02','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:02','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200197 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208757) WHERE AD_PrintFormatItem_ID = 200197 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208757 AND trl.AD_PrintFormatItem_ID = 200197) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Client Name',0,'N','Y','C',200008,'N',0,'F','N',18,208759,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Client Name',0,'N','0cd756af-c5b5-41ca-b3b5-fdccf58b2300',0,200198,'N',0,TO_DATE('2013-03-01 18:32:03','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:03','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200198 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208759) WHERE AD_PrintFormatItem_ID = 200198 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208759 AND trl.AD_PrintFormatItem_ID = 200198) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Currency',0,'N','Y','C',200008,'N',0,'F','N',19,208770,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Currency',0,'N','55e781aa-c2b7-43b3-a929-e12635dff9c6',0,200199,'N',0,TO_DATE('2013-03-01 18:32:04','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:04','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200199 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208770) WHERE AD_PrintFormatItem_ID = 200199 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208770 AND trl.AD_PrintFormatItem_ID = 200199) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Description',0,'N','Y','C',200008,'N',0,'F','N',20,208779,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Description',0,'N','e71984b3-68f2-4af7-908c-ada939fd65e1',0,200200,'N',0,TO_DATE('2013-03-01 18:32:05','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:05','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200200 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208779) WHERE AD_PrintFormatItem_ID = 200200 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208779 AND trl.AD_PrintFormatItem_ID = 200200) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Financial Month',0,'N','Y','C',200008,'N',0,'F','N',21,208764,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Financial Month',0,'N','4f054d3a-6442-4f41-8dd1-e69b1300e58b',0,200201,'N',0,TO_DATE('2013-03-01 18:32:05','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:05','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200201 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208764) WHERE AD_PrintFormatItem_ID = 200201 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208764 AND trl.AD_PrintFormatItem_ID = 200201) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Financial Year',0,'N','Y','C',200008,'N',0,'F','N',22,208763,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Financial Year',0,'N','f8c26f4b-ea1a-419b-a5cc-77c1e993291c',0,200202,'N',0,TO_DATE('2013-03-01 18:32:06','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:06','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200202 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208763) WHERE AD_PrintFormatItem_ID = 200202 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208763 AND trl.AD_PrintFormatItem_ID = 200202) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Net Assets / Equity',0,'N','Y','C',200008,'N',0,'F','N',23,208790,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Net Assets / Equity',0,'N','49f3a57a-f3c2-4a2f-ba6e-56cbc5a89901',0,200203,'N',0,TO_DATE('2013-03-01 18:32:07','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:07','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200203 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208790) WHERE AD_PrintFormatItem_ID = 200203 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208790 AND trl.AD_PrintFormatItem_ID = 200203) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Organization',0,'N','N','C',200008,'N',0,'F','N',0,208758,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Organization',0,'N','f9339a92-a4a7-4251-9ef6-a0ea0d6d9315',0,200204,'N',0,TO_DATE('2013-03-01 18:32:08','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:08','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200204 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208758) WHERE AD_PrintFormatItem_ID = 200204 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208758 AND trl.AD_PrintFormatItem_ID = 200204) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Organization Name',0,'N','Y','C',200008,'N',0,'F','N',25,208780,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Org Name',0,'N','e4a4b00d-fd0b-479b-a8a2-750516275352',0,200205,'N',0,TO_DATE('2013-03-01 18:32:09','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:09','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200205 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208780) WHERE AD_PrintFormatItem_ID = 200205 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208780 AND trl.AD_PrintFormatItem_ID = 200205) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('PL / BS',0,'N','Y','C',200008,'N',0,'F','N',26,208789,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','PL / BS',0,'N','848ea965-f98d-439b-a9a8-01f22f145418',0,200206,'N',0,TO_DATE('2013-03-01 18:32:09','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:09','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200206 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208789) WHERE AD_PrintFormatItem_ID = 200206 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208789 AND trl.AD_PrintFormatItem_ID = 200206) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('PL Group',0,'N','Y','C',200008,'N',0,'F','N',27,208788,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','PL Group',0,'N','e7d4b154-d1f6-47ec-bc14-9c1d68a3bab4',0,200207,'N',0,TO_DATE('2013-03-01 18:32:10','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:10','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200207 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208788) WHERE AD_PrintFormatItem_ID = 200207 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208788 AND trl.AD_PrintFormatItem_ID = 200207) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('PL Type Name',0,'N','Y','C',200008,'N',0,'F','N',28,208785,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','PL Type Name',0,'N','5591e956-1162-4dbe-8f28-cab4ae2bbcbe',0,200208,'N',0,TO_DATE('2013-03-01 18:32:11','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:11','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200208 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208785) WHERE AD_PrintFormatItem_ID = 200208 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208785 AND trl.AD_PrintFormatItem_ID = 200208) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('PL$ACT',0,'N','Y','C',200008,'N',0,'F','N',29,208773,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','PL$ACT',0,'N','ec8a5a43-d897-43da-850d-d6b1670784f5',0,200209,'N',0,TO_DATE('2013-03-01 18:32:12','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:12','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200209 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208773) WHERE AD_PrintFormatItem_ID = 200209 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208773 AND trl.AD_PrintFormatItem_ID = 200209) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('PL$BUD',0,'N','Y','C',200008,'N',0,'F','N',30,208775,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','PL$BUD',0,'N','3cd4a267-154d-4e44-b612-452282a041a8',0,200210,'N',0,TO_DATE('2013-03-01 18:32:13','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:13','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200210 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208775) WHERE AD_PrintFormatItem_ID = 200210 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208775 AND trl.AD_PrintFormatItem_ID = 200210) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Posting Type Name',0,'N','Y','C',200008,'N',0,'F','N',31,208769,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Posting Type Name',0,'N','03f55621-b7d4-4dee-8f78-788ff3b67f22',0,200211,'N',0,TO_DATE('2013-03-01 18:32:13','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:13','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200211 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208769) WHERE AD_PrintFormatItem_ID = 200211 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208769 AND trl.AD_PrintFormatItem_ID = 200211) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Product',0,'N','Y','C',200008,'N',0,'F','N',32,208798,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Product',0,'N','9dec2025-d376-4b0d-8af1-9083395e7875',0,200212,'N',0,TO_DATE('2013-03-01 18:32:14','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:14','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200212 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208798) WHERE AD_PrintFormatItem_ID = 200212 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208798 AND trl.AD_PrintFormatItem_ID = 200212) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Product Category',0,'N','Y','C',200008,'N',0,'F','N',33,208799,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Product Category',0,'N','cd4d3989-61f5-4efd-a4b2-035f22d0a035',0,200213,'N',0,TO_DATE('2013-03-01 18:32:15','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:15','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200213 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208799) WHERE AD_PrintFormatItem_ID = 200213 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208799 AND trl.AD_PrintFormatItem_ID = 200213) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Product Code',0,'N','Y','C',200008,'N',0,'F','N',34,208796,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Product Code',0,'N','63d87647-d1ab-42f9-9407-3a80c50078ff',0,200214,'N',0,TO_DATE('2013-03-01 18:32:15','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:15','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200214 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208796) WHERE AD_PrintFormatItem_ID = 200214 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208796 AND trl.AD_PrintFormatItem_ID = 200214) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Product Name',0,'N','Y','C',200008,'N',0,'F','N',35,208797,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Product Name',0,'N','63efa57a-684a-4c99-94e0-9a5b06f11b60',0,200215,'N',0,TO_DATE('2013-03-01 18:32:16','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:16','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200215 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208797) WHERE AD_PrintFormatItem_ID = 200215 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208797 AND trl.AD_PrintFormatItem_ID = 200215) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Project',0,'N','Y','C',200008,'N',0,'F','N',36,208778,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Project',0,'N','cc9f0de7-d2e5-4fe9-9dd5-7e059463d8e1',0,200216,'N',0,TO_DATE('2013-03-01 18:32:17','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:17','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200216 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208778) WHERE AD_PrintFormatItem_ID = 200216 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208778 AND trl.AD_PrintFormatItem_ID = 200216) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Quantity',0,'N','Y','C',200008,'N',0,'F','N',37,208777,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Qty',0,'N','525aabd5-c806-45bf-9721-10bc1d5d914f',0,200217,'N',0,TO_DATE('2013-03-01 18:32:18','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:18','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200217 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208777) WHERE AD_PrintFormatItem_ID = 200217 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208777 AND trl.AD_PrintFormatItem_ID = 200217) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Record ID',0,'N','Y','C',200008,'N',0,'F','N',38,208766,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Record ID',0,'N','245b7b58-f746-4d72-98be-7ce8c9cde23e',0,200218,'N',0,TO_DATE('2013-03-01 18:32:19','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:19','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200218 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208766) WHERE AD_PrintFormatItem_ID = 200218 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208766 AND trl.AD_PrintFormatItem_ID = 200218) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Sales Rep Name',0,'N','Y','C',200008,'N',0,'F','N',39,208795,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Sales Rep Name',0,'N','222b43bd-c673-42dc-91b7-cd5187e96205',0,200219,'N',0,TO_DATE('2013-03-01 18:32:19','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:19','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200219 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208795) WHERE AD_PrintFormatItem_ID = 200219 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208795 AND trl.AD_PrintFormatItem_ID = 200219) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Source Amount',0,'N','Y','C',200008,'N',0,'F','N',40,208771,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Source Amount',0,'N','fee6efae-657b-4480-85cc-70fb30c31ed2',0,200220,'N',0,TO_DATE('2013-03-01 18:32:20','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:20','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200220 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208771) WHERE AD_PrintFormatItem_ID = 200220 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208771 AND trl.AD_PrintFormatItem_ID = 200220) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Table Name',0,'N','Y','C',200008,'N',0,'F','N',41,208765,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Table Name',0,'N','27f1206f-c0e8-42cf-bfe9-45417849bbda',0,200221,'N',0,TO_DATE('2013-03-01 18:32:21','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:21','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200221 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208765) WHERE AD_PrintFormatItem_ID = 200221 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208765 AND trl.AD_PrintFormatItem_ID = 200221) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Tax Name',0,'N','Y','C',200008,'N',0,'F','N',42,208768,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Tax Name',0,'N','649f7563-e73e-4247-88b3-b3ecf1fbf0f7',0,200222,'N',0,TO_DATE('2013-03-01 18:32:22','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:22','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200222 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208768) WHERE AD_PrintFormatItem_ID = 200222 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208768 AND trl.AD_PrintFormatItem_ID = 200222) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('UOM Name',0,'N','Y','C',200008,'N',0,'F','N',43,208776,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','UOM Name',0,'N','fc392dd9-90c6-4226-a36f-a8f3f8c9e41e',0,200223,'N',0,TO_DATE('2013-03-01 18:32:22','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 18:32:22','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 6:32:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200223 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 6:32:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208776) WHERE AD_PrintFormatItem_ID = 200223 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208776 AND trl.AD_PrintFormatItem_ID = 200223) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 6:32:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET Name='Complex Fact View',Updated=TO_DATE('2013-03-01 18:32:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200008
;

-- Mar 1, 2013 6:32:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET AD_PrintTableFormat_ID=NULL,Updated=TO_DATE('2013-03-01 18:32:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200007
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=10,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200198
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=20,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200184
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=30,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200191
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=40,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200193
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=50,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200202
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=60,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200201
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=70,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200221
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=80,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200218
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=90,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200196
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=100,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200222
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=110,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200211
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=120,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200199
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=130,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200220
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=140,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200186
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=150,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200209
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=160,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200195
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=170,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200210
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=180,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200223
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=190,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200217
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=200,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200216
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=210,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200200
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=220,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200205
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=230,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200181
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=240,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200183
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=250,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200185
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=260,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200194
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=270,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200208
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=280,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200182
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=290,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200192
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=300,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200207
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=310,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200206
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=320,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200203
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=330,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200187
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=340,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200190
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=350,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200188
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=360,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200189
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=370,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200219
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=380,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200214
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=390,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200215
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=400,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200212
;

-- Mar 1, 2013 6:37:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=410,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200213
;

-- Mar 1, 2013 6:39:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,AD_Menu_UU,IsCentrallyMaintained,Name,Action,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200045,'N','N','N',200037,'D','d381e737-0a2a-4df4-9cb5-4543ed789c3b','Y','Simple Fact View','R','Y',0,100,TO_DATE('2013-03-01 18:39:18','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-03-01 18:39:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 1, 2013 6:39:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200045 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Mar 1, 2013 6:39:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200045, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200045)
;

-- Mar 1, 2013 6:39:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,AD_Menu_UU,IsCentrallyMaintained,Name,Action,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200046,'N','N','N',200038,'D','d50dc78b-2db1-4320-86e8-e1304df8a7fe','Y','Complex Fact View','R','Y',0,100,TO_DATE('2013-03-01 18:39:34','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-03-01 18:39:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 1, 2013 6:39:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200046 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Mar 1, 2013 6:39:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200046, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200046)
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=164
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=280
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=158
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=522
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200008
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=118
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53288
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53289
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53290
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=169
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=433
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=352
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=434
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200045
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200019
;

-- Mar 1, 2013 6:39:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=435
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=164
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=280
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=158
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=522
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200008
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=118
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53288
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53289
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53290
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=169
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=433
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=352
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=434
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200045
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200046
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200019
;

-- Mar 1, 2013 6:40:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=435
;

-- Mar 1, 2013 6:55:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,AD_Client_ID,AD_Org_ID,Updated,CreatedBy,IsActive,Created,UpdatedBy) VALUES (200066,'Fact_Acct Account_ID','D','4548bb78-5571-41d3-97d7-2ed4dab17d39','N',NULL,'T',0,0,TO_DATE('2013-03-01 18:55:30','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2013-03-01 18:55:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 1, 2013 6:55:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200066 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Mar 1, 2013 6:56:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Ref_Table (IsValueDisplayed,AD_Reference_ID,AD_Key,AD_Display,EntityType,AD_Table_ID,AD_Ref_Table_UU,CreatedBy,Updated,Created,AD_Client_ID,UpdatedBy,AD_Org_ID,IsActive) VALUES ('N',200066,3001,2519,'D',270,'e2901c8e-746a-417d-a31a-d58f92088528',100,TO_DATE('2013-03-01 18:56:02','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 18:56:02','YYYY-MM-DD HH24:MI:SS'),0,100,0,'Y')
;

-- Mar 1, 2013 6:56:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET AD_Reference_Value_ID=200066,Updated=TO_DATE('2013-03-01 18:56:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200058
;

-- Mar 4, 2013 3:25:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET AD_Reference_Value_ID=200066, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_DATE('2013-03-04 15:25:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208749
;

-- Mar 4, 2013 3:33:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET AD_Reference_Value_ID=132,Updated=TO_DATE('2013-03-04 15:33:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208749
;

-- Mar 4, 2013 3:34:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET AD_Reference_Value_ID=132,Updated=TO_DATE('2013-03-04 15:34:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200058
;

-- Mar 4, 2013 3:36:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE  FROM  AD_Reference_Trl WHERE AD_Reference_ID=200066
;

-- Mar 4, 2013 3:36:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Reference WHERE AD_Reference_ID=200066
;

-- Mar 4, 2013 3:39:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET AD_Reference_Value_ID=117, AD_Reference_ID=17, IsToolbarButton='N',Updated=TO_DATE('2013-03-04 15:39:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208751
;

-- Mar 4, 2013 3:41:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='ClientName',Updated=TO_DATE('2013-03-04 15:41:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200186
;

-- Mar 4, 2013 3:41:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='ClientName', Name='Client Name', Description=NULL, Help='Client in which current session user logged in' WHERE AD_Element_ID=200186
;

-- Mar 4, 2013 3:41:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='ClientName', Name='Client Name', Description=NULL, Help='Client in which current session user logged in', AD_Element_ID=200186 WHERE UPPER(ColumnName)='CLIENTNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 4, 2013 3:41:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='ClientName', Name='Client Name', Description=NULL, Help='Client in which current session user logged in' WHERE AD_Element_ID=200186 AND IsCentrallyMaintained='Y'
;

-- Mar 4, 2013 3:41:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='ClientName', Name='Client Name', Description=NULL, Help='Client in which current session user logged in' WHERE AD_Element_ID=200186 AND IsCentrallyMaintained='Y'
;

-- Mar 4, 2013 3:43:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET AD_Reference_ID=13, IsToolbarButton='N',Updated=TO_DATE('2013-03-04 15:43:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208766
;

-- Mar 4, 2013 3:45:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET AD_Reference_ID=10, IsToolbarButton='N',Updated=TO_DATE('2013-03-04 15:45:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208770
;

SELECT register_migration_script('201303041624_TICKET-1001763_FactView.sql') FROM dual
;