-- Aug 8, 2012 9:58:31 AM COT
-- IDEMPIERE-358 Login- how to make unique and safe
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200014,'D','S','N','Use email for login multitenant, WARNING! Before enabling this please check all your users have email filled','70cb7f9b-9993-4f38-a8df-4ce9840af9cf',TO_TIMESTAMP('2012-08-08 09:58:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-08 09:58:29','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y',0,'USE_EMAIL_FOR_LOGIN')
;

-- This is to prevent somebody changing the sysconfig key and disabling access to system roles
update ad_user set email='superuser @ idempiere.com' where name = 'SuperUser';

update ad_user set email='system @ idempiere.com' where name = 'System';

-- delete wrong GardenAdmin record assigning a system role
delete from ad_user_roles where ad_user_id=101 and ad_role_id=50002 and ad_client_id=0;

UPDATE AD_System
  SET LastMigrationScriptApplied='871_IDEMPIERE_358.sql'
WHERE LastMigrationScriptApplied<'871_IDEMPIERE_358.sql'
   OR LastMigrationScriptApplied IS NULL
;
