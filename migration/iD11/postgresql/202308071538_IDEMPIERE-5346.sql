-- IDEMPIERE-5346 SSO Support
SELECT register_migration_script('202308071538_IDEMPIERE-5346.sql') FROM dual;

-- Aug 7, 2023, 3:38:25 PM IST
UPDATE AD_Column SET DefaultValue='AAS',IsMandatory='Y',Updated=TO_TIMESTAMP('2023-08-07 15:38:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215840
;

-- Aug 7, 2023, 3:54:21 PM IST
INSERT INTO t_alter_column values('ad_client','AuthenticationType','VARCHAR(10)',null,'AAS')
;

-- Aug 7, 2023, 3:54:21 PM IST
UPDATE AD_Client SET AuthenticationType='AAS' WHERE AuthenticationType IS NULL
;

-- Aug 7, 2023, 3:54:21 PM IST
INSERT INTO t_alter_column values('ad_client','AuthenticationType',null,'NOT NULL',null)
;

-- Aug 17, 2023, 8:34:57 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200231,0,0,TO_TIMESTAMP('2023-08-17 20:34:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-08-17 20:34:56','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ENABLE_SSO_IDEMPIERE_MONITOR','N','Enable SSO Authentication Login for iDempiere Monitor','D','S','b9ab5ead-5743-4b62-aaab-6c3ae9d969ac')
;

-- Aug 17, 2023, 8:35:22 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200232,0,0,TO_TIMESTAMP('2023-08-17 20:35:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-08-17 20:35:21','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ENABLE_SSO_OSGI_CONSOLE','N','Enable SSO Authentication Login for Felix Web Console','D','S','063c3226-5c7f-40af-ba8d-d594a4ca469c')
;