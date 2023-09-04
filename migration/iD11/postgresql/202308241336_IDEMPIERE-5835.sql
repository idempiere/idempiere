-- IDEMPIERE-5835
SELECT register_migration_script('202308241336_IDEMPIERE-5835.sql') FROM dual;

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
INSERT INTO t_alter_column values('ad_process','AllowMultipleExecution','VARCHAR(2)',null,'P')
;


-- Sep 4, 2023, 10:11:18 AM BRT
UPDATE AD_Ref_List SET Name='Prevent concurrent executions by any user',Updated=TO_TIMESTAMP('2023-09-04 10:11:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200646
;

-- Sep 4, 2023, 10:11:42 AM BRT
UPDATE AD_Ref_List SET Name='Prevent concurrent executions by same user',Updated=TO_TIMESTAMP('2023-09-04 10:11:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200440
;

-- Sep 4, 2023, 10:12:40 AM BRT
UPDATE AD_Column SET FieldLength=70, SeqNoSelection=10,Updated=TO_TIMESTAMP('2023-09-04 10:12:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=149
;

-- Sep 4, 2023, 10:12:53 AM BRT
INSERT INTO t_alter_column values('ad_ref_list','Name','VARCHAR(70)',null,null)
;

-- Sep 4, 2023, 10:13:19 AM BRT
UPDATE AD_Column SET FieldLength=70, SeqNoSelection=10,Updated=TO_TIMESTAMP('2023-09-04 10:13:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=338
;

-- Sep 4, 2023, 10:13:23 AM BRT
INSERT INTO t_alter_column values('ad_ref_list_trl','Name','VARCHAR(70)',null,null)
;

-- Sep 4, 2023, 10:18:17 AM BRT
UPDATE AD_Ref_List SET Name='Disallow concurrent executions with identical parameters from any user', Description='Allow to execute a process concurrently with different parameters by any user',Updated=TO_TIMESTAMP('2023-09-04 10:18:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200647
;

-- Sep 4, 2023, 10:19:12 AM BRT
UPDATE AD_Ref_List SET Name='Disallow concurrent executions with the same parameters by same user',Updated=TO_TIMESTAMP('2023-09-04 10:19:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200441
;

-- Sep 4, 2023, 10:19:30 AM BRT
UPDATE AD_Ref_List SET Description='Allow to execute a process concurrently with different parameters and same user',Updated=TO_TIMESTAMP('2023-09-04 10:19:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200441
;

-- Sep 4, 2023, 10:21:20 AM BRT
UPDATE AD_Ref_List SET Name='Disallow concurrent executions with identical parameters by same user',Updated=TO_TIMESTAMP('2023-09-04 10:21:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200441
;

-- Sep 4, 2023, 10:22:32 AM BRT
UPDATE AD_Ref_List SET Description='Allow to execute a process concurrently with different parameters from any user',Updated=TO_TIMESTAMP('2023-09-04 10:22:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200647
;

