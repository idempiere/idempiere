-- IDEMPIERE-6712 Improve algorithm for password hashing and salt (DAD-103)
SELECT register_migration_script('202510312017_IDEMPIERE-6712.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 31, 2025, 8:17:57 PM MYT
UPDATE AD_Process SET Help='This process will overwrite existing user passwords with a salted hash of the password so that they cannot be recovered if your database is compromised.
(Note: If your password column is currently encrypted, the hash will also be encrypted.)',Updated=TO_TIMESTAMP('2025-10-31 20:17:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53259
;

-- Oct 31, 2025, 8:35:08 PM MYT
UPDATE AD_Process_Para SET DefaultValue='@$sysconfig.USER_PASSWORD_HASH_ALGORITHM@',Updated=TO_TIMESTAMP('2025-10-31 20:35:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200498
;

-- Oct 31, 2025, 8:35:25 PM MYT
UPDATE AD_SysConfig SET Value='SHA-512',Updated=TO_TIMESTAMP('2025-10-31 20:35:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200285
;

