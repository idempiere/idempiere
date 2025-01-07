-- IDEMPIERE-5786
SELECT register_migration_script('202306290925_IDEMPIERE-5786.sql') FROM dual;

-- Jun 29, 2023, 9:25:49 AM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200230,0,0,TO_TIMESTAMP('2023-06-29 09:25:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-06-29 09:25:48','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','USE_ESC_FOR_TAB_CLOSING','N','Y - use ESC for closing tabs; N - use Alt+X for closing tabs','D','C','a33cec55-070b-41bf-9448-26b797237ee6')
;

