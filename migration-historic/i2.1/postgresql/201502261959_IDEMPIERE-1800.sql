-- IDEMPIERE-1800 Reset Locked Account shows all clients
-- Feb 26, 2015 7:56:16 PM COT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=116, DefaultValue='@#AD_Client_ID@',Updated=TO_TIMESTAMP('2015-02-26 19:56:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200029
;

-- Feb 26, 2015 7:58:22 PM COT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200067,'AD_User Locked of Client','S','AD_User.AD_Client_ID=@#AD_Client_ID@ AND IsLocked=''Y''',0,0,'Y',TO_TIMESTAMP('2015-02-26 19:58:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-26 19:58:20','YYYY-MM-DD HH24:MI:SS'),100,'D','13699034-b9eb-493f-9156-2d6864f366d1')
;

-- Feb 26, 2015 7:58:33 PM COT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200067,Updated=TO_TIMESTAMP('2015-02-26 19:58:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200030
;

-- Feb 26, 2015 7:58:42 PM COT
UPDATE AD_Process_Para SET IsActive='N',Updated=TO_TIMESTAMP('2015-02-26 19:58:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200029
;

-- Feb 26, 2015 8:21:57 PM COT
UPDATE AD_Process SET Help='Select a locked user from the list to unlock it.  Alternatively you can run the process without selecting any user, in this case the process will unlock all locked users from the client applying accordingly the policies configured for "max account lock" and "max inactive period".',Updated=TO_TIMESTAMP('2015-02-26 20:21:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200008
;

SELECT register_migration_script('201502261959_IDEMPIERE-1800.sql') FROM dual
;

