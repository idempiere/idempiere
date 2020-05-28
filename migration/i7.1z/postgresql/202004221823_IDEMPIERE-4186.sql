-- IDEMPIERE-4186 allow workflow to be suspended until after commit of actual transaction
-- Apr 22, 2020, 6:22:04 PM CEST
UPDATE AD_Field SET IsCentrallyMaintained='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-04-22 18:22:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10089
;

-- Apr 22, 2020, 6:23:03 PM CEST
UPDATE AD_Field SET Help='Time in minutes to be suspended (sleep).  A value of -1 means to wait and execute after the commit of the workflow transaction.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-04-22 18:23:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10089
;

-- Apr 22, 2020, 6:23:27 PM CEST
UPDATE AD_Tab SET Help='The Node Tab defines each Node, Activity or step in this Workflow.<br>
The action (activity) type determines the execution: "Route" may be used in routing control conditions.  "None" identifies manual execution.',Updated=TO_TIMESTAMP('2020-04-22 18:23:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=122
;

SELECT register_migration_script('202004221823_IDEMPIERE-4186.sql') FROM dual
;

