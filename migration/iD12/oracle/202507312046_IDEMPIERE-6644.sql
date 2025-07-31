-- IDEMPIERE-6644 Fix some wrong defaults for EntityType
SELECT register_migration_script('202507312046_IDEMPIERE-6644.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 31, 2025, 8:46:04 PM CEST
UPDATE AD_Column SET DefaultValue='@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',Updated=TO_TIMESTAMP('2025-07-31 20:46:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216311
;

-- Jul 31, 2025, 8:46:21 PM CEST
UPDATE AD_Column SET DefaultValue='@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',Updated=TO_TIMESTAMP('2025-07-31 20:46:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216309
;

-- Jul 31, 2025, 8:46:29 PM CEST
UPDATE AD_Column SET DefaultValue='@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',Updated=TO_TIMESTAMP('2025-07-31 20:46:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216310
;

-- Jul 31, 2025, 8:46:36 PM CEST
UPDATE AD_Column SET DefaultValue='@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',Updated=TO_TIMESTAMP('2025-07-31 20:46:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216312
;

-- Jul 31, 2025, 8:46:54 PM CEST
UPDATE AD_Column SET DefaultValue='@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',Updated=TO_TIMESTAMP('2025-07-31 20:46:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53474
;

-- Jul 31, 2025, 8:47:10 PM CEST
UPDATE AD_Column SET DefaultValue='@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',Updated=TO_TIMESTAMP('2025-07-31 20:47:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53520
;

-- Jul 31, 2025, 8:47:26 PM CEST
UPDATE AD_Column SET DefaultValue='@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',Updated=TO_TIMESTAMP('2025-07-31 20:47:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53701
;

-- Jul 31, 2025, 8:49:33 PM CEST
UPDATE AD_Process_Para SET DefaultValue='@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',Updated=TO_TIMESTAMP('2025-07-31 20:49:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=630
;

-- Jul 31, 2025, 8:49:43 PM CEST
UPDATE AD_Process_Para SET DefaultValue='@SQL=SELECT CASE WHEN ''@P|AdempiereSys:N@''=''Y'' THEN ''D'' ELSE get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) END FROM Dual',Updated=TO_TIMESTAMP('2025-07-31 20:49:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200358
;

