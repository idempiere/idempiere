-- May 27, 2013 10:43:09 AM COT
-- IDEMPIERE-962 Misspelled words and/or sentences
UPDATE AD_Process SET Description='Validate that the workflow is correct',Updated=TO_TIMESTAMP('2013-05-27 10:43:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=304
;

-- May 27, 2013 10:55:51 AM COT
-- IDEMPIERE-962 Misspelled words and/or sentences
UPDATE AD_Workflow SET IsValid='Y', Description='(Standard Process Invoice)',Updated=TO_TIMESTAMP('2013-05-27 10:55:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=118
;

-- May 27, 2013 10:59:41 AM COT
-- IDEMPIERE-962 Misspelled words and/or sentences
UPDATE AD_Process SET Description='Check data consistency of Business Partner',Updated=TO_TIMESTAMP('2013-05-27 10:59:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=314
;

-- May 27, 2013 10:59:41 AM COT
-- IDEMPIERE-962 Misspelled words and/or sentences
UPDATE AD_Menu SET Name='Validate Business Partner', Description='Check data consistency of Business Partner', IsActive='Y',Updated=TO_TIMESTAMP('2013-05-27 10:59:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=506
;

-- May 29, 2013 7:52:39 AM COT
UPDATE AD_Ref_List SET Description='Check Document consistency and check Inventory',Updated=TO_TIMESTAMP('2013-05-29 07:52:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=345
;

-- May 29, 2013 7:53:14 AM COT
UPDATE AD_Ref_List SET Description='Reopen Document and Reverse automatically generated documents; You need to Complete the transaction after the change. ',Updated=TO_TIMESTAMP('2013-05-29 07:53:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=188
;

-- May 29, 2013 7:53:31 AM COT
UPDATE AD_Ref_List SET Description='Wait Condition ok Complete Document',Updated=TO_TIMESTAMP('2013-05-29 07:53:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=691
;

SELECT register_migration_script('20130527113000_IDEMPIERE-962.sql') FROM dual
;
