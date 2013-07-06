-- Jul 4, 2013 5:39:38 PM COT
UPDATE AD_Workflow SET IsValid='N', IsActive='N',Updated=TO_DATE('2013-07-04 17:39:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50014
;

SELECT register_migration_script('20130407174015_IDEMPIERE-632.sql') FROM dual
;

