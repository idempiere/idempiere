-- Jul 4, 2013 5:39:38 PM COT
-- Hide workflows deprecated
UPDATE AD_Workflow SET IsValid='N', IsActive='N',Updated=TO_TIMESTAMP('2013-07-04 17:39:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50014
;

-- Jul 6, 2013 5:50:57 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:50:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=119
;

-- Jul 6, 2013 5:51:01 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:51:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50009
;

-- Jul 6, 2013 5:51:11 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:51:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50011
;

-- Jul 6, 2013 5:51:31 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:51:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50008
;

-- Jul 6, 2013 5:51:39 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:51:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50013
;

-- Jul 6, 2013 5:52:09 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:52:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50002
;

-- Jul 6, 2013 5:52:16 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:52:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50005
;

-- Jul 6, 2013 5:52:28 PM COT
UPDATE AD_Workflow SET IsValid='N', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:52:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50007
;

-- Jul 6, 2013 5:52:36 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:52:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50010
;

-- Jul 6, 2013 5:52:41 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:52:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50006
;

-- Jul 6, 2013 5:53:07 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:53:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50000
;

-- Jul 6, 2013 5:53:11 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:53:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50001
;

-- Jul 6, 2013 5:53:14 PM COT
UPDATE AD_Workflow SET IsValid='Y', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:53:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50004
;

-- Jul 6, 2013 5:53:27 PM COT
UPDATE AD_Workflow SET IsValid='N', IsActive='N',Updated=TO_TIMESTAMP('2013-07-06 17:53:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=50003
;

SELECT register_migration_script('20130407174015_IDEMPIERE-632.sql') FROM dual
;


