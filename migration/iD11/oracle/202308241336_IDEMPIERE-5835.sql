-- IDEMPIERE-5835
SELECT register_migration_script('202308241336_IDEMPIERE-5835.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 24, 2023, 1:36:54 PM BRT
UPDATE AD_Ref_List SET Name='Disallow multiple executions with the same parameters & user', Description='Allow to execute a process multiple times with different parameters and same user',Updated=TO_TIMESTAMP('2023-08-24 13:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200441
;

-- Aug 24, 2023, 1:37:12 PM BRT
UPDATE AD_Ref_List SET Name='Disallow multiple executions by same user',Updated=TO_TIMESTAMP('2023-08-24 13:37:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200440
;

-- Aug 24, 2023, 1:37:20 PM BRT
UPDATE AD_Ref_List SET Description='Never allow to execute a process that is already running by the same user',Updated=TO_TIMESTAMP('2023-08-24 13:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200440
;

-- Aug 24, 2023, 1:38:20 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200646,'Disallow multiple executions any user','Never allow to execute a process that is already running by any user',200158,'NA',0,0,'Y',TO_TIMESTAMP('2023-08-24 13:38:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-08-24 13:38:19','YYYY-MM-DD HH24:MI:SS'),100,'D','8911db76-92ef-4c9b-9482-442cf31a2fc4')
;

-- Aug 24, 2023, 1:39:40 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200647,'Disallow multiple execution with the same parameter any user','Allow to execute a process multiple times with different parameters by any user',200158,'PA',0,0,'Y',TO_TIMESTAMP('2023-08-24 13:39:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-08-24 13:39:40','YYYY-MM-DD HH24:MI:SS'),100,'D','d13ecbd0-370f-4935-826b-2ae7313add8a')
;

-- Aug 24, 2023, 2:13:12 PM BRT
UPDATE AD_Column SET FieldLength=2,Updated=TO_TIMESTAMP('2023-08-24 14:13:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213699
;

-- Aug 24, 2023, 2:13:16 PM BRT
ALTER TABLE AD_Process MODIFY AllowMultipleExecution VARCHAR2(2 CHAR) DEFAULT 'P'
;

-- Sep 11, 2023, 12:26:16 PM CEST
UPDATE AD_Element SET Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help='When blank: Allows to execute a process concurrently.', PrintName='Allow Concurrent Execution',Updated=TO_TIMESTAMP('2023-09-11 12:26:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203269
;

-- Sep 11, 2023, 12:26:16 PM CEST
UPDATE AD_Column SET ColumnName='AllowMultipleExecution', Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help='When blank: Allows to execute a process concurrently.', Placeholder=NULL WHERE AD_Element_ID=203269
;

-- Sep 11, 2023, 12:26:16 PM CEST
UPDATE AD_Process_Para SET ColumnName='AllowMultipleExecution', Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help='When blank: Allows to execute a process concurrently.', AD_Element_ID=203269 WHERE UPPER(ColumnName)='ALLOWMULTIPLEEXECUTION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 11, 2023, 12:26:16 PM CEST
UPDATE AD_Process_Para SET ColumnName='AllowMultipleExecution', Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help='When blank: Allows to execute a process concurrently.', Placeholder=NULL WHERE AD_Element_ID=203269 AND IsCentrallyMaintained='Y'
;

-- Sep 11, 2023, 12:26:16 PM CEST
UPDATE AD_InfoColumn SET ColumnName='AllowMultipleExecution', Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help='When blank: Allows to execute a process concurrently.', Placeholder=NULL WHERE AD_Element_ID=203269 AND IsCentrallyMaintained='Y'
;

-- Sep 11, 2023, 12:26:16 PM CEST
UPDATE AD_Field SET Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help='When blank: Allows to execute a process concurrently.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203269) AND IsCentrallyMaintained='Y'
;

-- Sep 11, 2023, 12:26:16 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Allow Concurrent Execution', Name='Allow Concurrent Execution' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203269)
;

-- Sep 11, 2023, 12:27:29 PM CEST
UPDATE AD_Ref_List SET Name='Not from same user', Description='Do not allow to execute a process that is already running by the same user',Updated=TO_TIMESTAMP('2023-09-11 12:27:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200440
;

-- Sep 11, 2023, 12:27:48 PM CEST
UPDATE AD_Ref_List SET Name='Not from any user', Description='Do not allow to execute a process that is already running by any user',Updated=TO_TIMESTAMP('2023-09-11 12:27:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200646
;

-- Sep 11, 2023, 12:28:44 PM CEST
UPDATE AD_Ref_List SET Name='Not same user and parameters', Description='Do not allow to execute a process concurrently with same parameters and same user',Updated=TO_TIMESTAMP('2023-09-11 12:28:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200441
;

-- Sep 11, 2023, 12:28:48 PM CEST
UPDATE AD_Ref_List SET Name='Not from same user and parameters',Updated=TO_TIMESTAMP('2023-09-11 12:28:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200441
;

-- Sep 11, 2023, 12:29:17 PM CEST
UPDATE AD_Ref_List SET Name='Not from any user and same parameters', Description='Do not allow to execute a process concurrently with same parameters from any user',Updated=TO_TIMESTAMP('2023-09-11 12:29:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200647
;

-- Sep 11, 2023, 12:31:35 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200648,'Yes','Allow concurrent execution',200158,'Y',0,0,'Y',TO_TIMESTAMP('2023-09-11 12:31:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 12:31:35','YYYY-MM-DD HH24:MI:SS'),100,'D','832cb3cb-d520-4c5d-98e5-a302f0fa0f39')
;

-- Sep 11, 2023, 12:32:49 PM CEST
UPDATE AD_Element SET Help=NULL,Updated=TO_TIMESTAMP('2023-09-11 12:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203269
;

-- Sep 11, 2023, 12:32:49 PM CEST
UPDATE AD_Column SET ColumnName='AllowMultipleExecution', Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203269
;

-- Sep 11, 2023, 12:32:49 PM CEST
UPDATE AD_Process_Para SET ColumnName='AllowMultipleExecution', Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help=NULL, AD_Element_ID=203269 WHERE UPPER(ColumnName)='ALLOWMULTIPLEEXECUTION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 11, 2023, 12:32:49 PM CEST
UPDATE AD_Process_Para SET ColumnName='AllowMultipleExecution', Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203269 AND IsCentrallyMaintained='Y'
;

-- Sep 11, 2023, 12:32:49 PM CEST
UPDATE AD_InfoColumn SET ColumnName='AllowMultipleExecution', Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203269 AND IsCentrallyMaintained='Y'
;

-- Sep 11, 2023, 12:32:49 PM CEST
UPDATE AD_Field SET Name='Allow Concurrent Execution', Description='Allow or disallow executing a process/report multiple times concurrently', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203269) AND IsCentrallyMaintained='Y'
;

-- Sep 11, 2023, 12:33:33 PM CEST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2023-09-11 12:33:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213699
;

-- Sep 11, 2023, 12:33:37 PM CEST
ALTER TABLE AD_Process MODIFY AllowMultipleExecution VARCHAR2(2 CHAR) DEFAULT 'P'
;

-- Sep 11, 2023, 12:33:37 PM CEST
UPDATE AD_Process SET AllowMultipleExecution='Y' WHERE AllowMultipleExecution IS NULL
;

-- Sep 11, 2023, 12:33:37 PM CEST
ALTER TABLE AD_Process MODIFY AllowMultipleExecution NOT NULL
;

