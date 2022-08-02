-- IDEMPIERE-5259 Default SysConfig
SELECT register_migration_script('202206291714_IDEMPIERE-5259.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 29, 2022, 5:14:48 PM BRT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200201,0,0,TO_TIMESTAMP('2022-06-29 17:14:46','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-06-29 17:14:46','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','LABEL_AUTOMATIC_COLOR','Y','Y/N - Define if the application will automatically colorize labels, even if not assigned to a CSS style','D','C','10c6845f-9ce8-4ad7-8588-cda60416a2a5')
;

