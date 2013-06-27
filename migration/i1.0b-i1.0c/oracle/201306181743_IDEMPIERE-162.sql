-- Jun 18, 2013 5:43:29 PM COT
-- IDEMPIERE-162 Let Process Role Access Update honor previous modifications to permissions
UPDATE AD_Process_Para SET IsMandatory='Y', DefaultValue='N',Updated=TO_DATE('2013-06-18 17:43:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200007
;

SELECT register_migration_script('201306181743_IDEMPIERE-162.sql') FROM dual
;

