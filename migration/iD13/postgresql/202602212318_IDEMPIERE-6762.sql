-- IDEMPIERE-6762 Exception occurs when attempting to export a simple fact view report
SELECT register_migration_script('202602212318_IDEMPIERE-6762.sql') FROM dual;

-- Feb 21, 2026, 11:18:17 PM CET
UPDATE AD_Element SET IsActive='N', Description='** DO NOT USE - Oracle reserved word **',Updated=TO_TIMESTAMP('2026-02-21 23:18:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202261
;

-- Feb 21, 2026, 11:18:17 PM CET
UPDATE AD_Column SET ColumnName='Case', Name='Case', Description='** DO NOT USE - Oracle reserved word **', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202261
;

-- Feb 21, 2026, 11:18:17 PM CET
UPDATE AD_Process_Para SET ColumnName='Case', Name='Case', Description='** DO NOT USE - Oracle reserved word **', Help=NULL, AD_Element_ID=202261 WHERE UPPER(ColumnName)='CASE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 21, 2026, 11:18:17 PM CET
UPDATE AD_Process_Para SET ColumnName='Case', Name='Case', Description='** DO NOT USE - Oracle reserved word **', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202261 AND IsCentrallyMaintained='Y'
;

-- Feb 21, 2026, 11:18:17 PM CET
UPDATE AD_InfoColumn SET ColumnName='Case', Name='Case', Description='** DO NOT USE - Oracle reserved word **', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=202261 AND IsCentrallyMaintained='Y'
;

-- Feb 21, 2026, 11:18:17 PM CET
UPDATE AD_Field SET Name='Case', Description='** DO NOT USE - Oracle reserved word **', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202261) AND IsCentrallyMaintained='Y'
;

-- Feb 21, 2026, 11:22:28 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (204032,0,0,'Y',TO_TIMESTAMP('2026-02-21 23:22:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-21 23:22:28','YYYY-MM-DD HH24:MI:SS'),100,'StatementType','Statement Type','Statement Type can be Balance or P&L','Statement Type','D','019c824c-0f1a-7daa-8b5c-af3fefbc0671')
;

-- Feb 21, 2026, 11:24:13 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200280,'StatementType','L',0,0,'Y',TO_TIMESTAMP('2026-02-21 23:24:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-21 23:24:13','YYYY-MM-DD HH24:MI:SS'),100,'D','N','019c824d-a839-78d8-b8c4-7d5eaf715c24','N')
;

-- Feb 21, 2026, 11:24:22 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200750,'Balance',200280,'B',0,0,'Y',TO_TIMESTAMP('2026-02-21 23:24:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-21 23:24:22','YYYY-MM-DD HH24:MI:SS'),100,'D','019c824d-cd18-71fe-868a-a07d0559590c')
;

-- Feb 21, 2026, 11:24:28 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200751,'P&L',200280,'P',0,0,'Y',TO_TIMESTAMP('2026-02-21 23:24:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-21 23:24:28','YYYY-MM-DD HH24:MI:SS'),100,'D','019c824d-e405-7e27-aebc-da40669633cc')
;

-- Feb 21, 2026, 11:25:15 PM CET
UPDATE AD_Column SET Name='Statement Type', Description='Statement Type can be Balance or P&L', Help=NULL, ColumnName='StatementType', FieldLength=1, AD_Reference_ID=17, AD_Reference_Value_ID=200280, AD_Element_ID=204032, IsToolbarButton='N',Updated=TO_TIMESTAMP('2026-02-21 23:25:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208756
;

-- Feb 21, 2026, 11:26:31 PM CET
UPDATE AD_ViewColumn SET ColumnName='StatementType', ColumnSQL='CASE rv_fact_acct.accounttype WHEN ''A'' THEN ''B'' WHEN ''E'' THEN ''P'' WHEN ''L'' THEN ''B'' WHEN ''M'' THEN ''B'' WHEN ''O'' THEN ''B'' WHEN ''R'' THEN ''P'' ELSE ''9'' END',Updated=TO_TIMESTAMP('2026-02-21 23:26:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=214700
;

-- Feb 21, 2026, 11:26:42 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200752,'Unknown',200280,'9',0,0,'Y',TO_TIMESTAMP('2026-02-21 23:26:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-21 23:26:42','YYYY-MM-DD HH24:MI:SS'),100,'D','019c824f-efec-71b0-9b44-a7a25e6ca5bb')
;

-- Feb 21, 2026, 11:26:57 PM CET
DROP VIEW RV_Fact_Simple
;

-- Feb 21, 2026, 11:29:07 PM CET
UPDATE AD_PrintFormatItem SET Name='Statement Type', PrintName='Statement Type', SortNo=0, IsPageBreak='N', YPosition=0, XPosition=0, IsGroupBy='N',Updated=TO_TIMESTAMP('2026-02-21 23:29:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200171
;

-- Feb 22, 2026, 1:29:33 AM CET
UPDATE AD_ViewComponent SET OtherClause='GROUP BY rv_fact_acct.ad_client_id, rv_fact_acct.ad_org_id, rv_fact_acct.isactive, rv_fact_acct.created, rv_fact_acct.createdby, rv_fact_acct.updated, rv_fact_acct.updatedby, rv_fact_acct.c_project_id, rv_fact_acct.c_acctschema_id, rv_fact_acct.account_id, rv_fact_acct.accountvalue, rv_fact_acct.accounttype, rv_fact_acct.dateacct',Updated=TO_TIMESTAMP('2026-02-22 01:29:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200142
;

-- Feb 22, 2026, 1:29:37 AM CET
CREATE OR REPLACE VIEW RV_Fact_Simple(AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, C_Project_ID, C_AcctSchema_ID, Account_ID, AccountValue, AccountType, DateAcct, FinYear_Mth, AmtAcct, FinYear, StatementType) AS SELECT rv_fact_acct.ad_client_id AS AD_Client_ID, rv_fact_acct.ad_org_id AS AD_Org_ID, rv_fact_acct.isactive AS IsActive, rv_fact_acct.created AS Created, rv_fact_acct.createdby AS CreatedBy, rv_fact_acct.updated AS Updated, rv_fact_acct.updatedby AS UpdatedBy, rv_fact_acct.c_project_id AS C_Project_ID, rv_fact_acct.c_acctschema_id AS C_AcctSchema_ID, rv_fact_acct.account_id AS Account_ID, rv_fact_acct.accountvalue AS AccountValue, rv_fact_acct.accounttype AS AccountType, rv_fact_acct.dateacct AS DateAcct, to_char(rv_fact_acct.dateacct, 'YYYY-MM') AS FinYear_Mth, sum(rv_fact_acct.amtacctdr - rv_fact_acct.amtacctcr) AS AmtAcct, to_char(rv_fact_acct.dateacct, '"FY"YYYY') AS FinYear, CASE rv_fact_acct.accounttype WHEN 'A' THEN 'B' WHEN 'E' THEN 'P' WHEN 'L' THEN 'B' WHEN 'M' THEN 'B' WHEN 'O' THEN 'B' WHEN 'R' THEN 'P' ELSE '9' END AS StatementType FROM rv_fact_acct WHERE rv_fact_acct.postingtype = 'A' GROUP BY rv_fact_acct.ad_client_id, rv_fact_acct.ad_org_id, rv_fact_acct.isactive, rv_fact_acct.created, rv_fact_acct.createdby, rv_fact_acct.updated, rv_fact_acct.updatedby, rv_fact_acct.c_project_id, rv_fact_acct.c_acctschema_id, rv_fact_acct.account_id, rv_fact_acct.accountvalue, rv_fact_acct.accounttype, rv_fact_acct.dateacct
;

