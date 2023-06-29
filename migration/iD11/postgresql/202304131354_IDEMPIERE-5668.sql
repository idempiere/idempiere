-- IDEMPIERE-5668
SELECT register_migration_script('202304131354_IDEMPIERE-5668.sql') FROM dual;

-- Apr 13, 2023, 1:57:56 PM BRT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200175,'AD_Role of User','S','AD_Role.AD_Role_ID IN (SELECT AD_User_Roles.AD_Role_ID FROM AD_User_Roles WHERE AD_User_Roles.AD_User_ID = @#AD_User_ID@)',0,0,'Y',TO_TIMESTAMP('2023-04-13 13:57:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-13 13:57:56','YYYY-MM-DD HH24:MI:SS'),100,'D','d1e9c6fc-5a01-41d5-bdaf-4f9f76b8eccd')
;

-- Apr 13, 2023, 1:58:21 PM BRT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200175,Updated=TO_TIMESTAMP('2023-04-13 13:58:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50002
;

-- Apr 13, 2023, 1:58:30 PM BRT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200175,Updated=TO_TIMESTAMP('2023-04-13 13:58:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50001
;

-- Apr 13, 2023, 1:59:13 PM BRT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200176,'AD_Client Acess','S','(CASE WHEN @#AD_Client_ID@ <> 0 THEN AD_Client.AD_Client_ID <> 0 ELSE TRUE END)',0,0,'Y',TO_TIMESTAMP('2023-04-13 13:59:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-13 13:59:12','YYYY-MM-DD HH24:MI:SS'),100,'D','130eb80f-a0d6-4df2-8595-1c92c538700e')
;

-- Apr 13, 2023, 1:59:22 PM BRT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200176,Updated=TO_TIMESTAMP('2023-04-13 13:59:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50003
;

-- Apr 13, 2023, 2:00:53 PM BRT
UPDATE AD_Process_Para SET AD_Val_Rule_ID=148,Updated=TO_TIMESTAMP('2023-04-13 14:00:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=50004
;

-- Apr 13, 2023, 2:02:40 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Roles must be different',0,0,'Y',TO_TIMESTAMP('2023-04-13 14:02:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-13 14:02:40','YYYY-MM-DD HH24:MI:SS'),100,200831,'RolesMustBeDifferent','D','61a4a8d4-a253-4160-867f-1814463b1688')
;

-- Apr 13, 2023, 2:03:37 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Role Copied',0,0,'Y',TO_TIMESTAMP('2023-04-13 14:03:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-13 14:03:36','YYYY-MM-DD HH24:MI:SS'),100,200832,'RoleCopied','D','3f6a6ae6-7083-4d97-afb3-476577b135a5')
;

