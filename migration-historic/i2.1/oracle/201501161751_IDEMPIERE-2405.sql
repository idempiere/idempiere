SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 16, 2015 5:50:47 PM COT
-- IDEMPIERE-2405 Implement SaaS support for Setup Wizard
UPDATE AD_Val_Rule SET Code='AD_Workflow.WorkflowType IN (''G'',''W'')',Updated=TO_DATE('2015-01-16 17:50:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52006
;

SELECT register_migration_script('201501161751_IDEMPIERE-2405.sql') FROM dual
;

