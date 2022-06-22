-- IDEMPIERE-5300 ErrorMsg doesn't show full message + LifeTime Msg configurable
SELECT register_migration_script('202206221758_IDEMPIERE-5300.sql') FROM dual;

-- Jun 22, 2022, 5:58:45 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200200,0,0,TO_TIMESTAMP('2022-06-22 17:58:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-06-22 17:58:44','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_ERROR_MSG_LIFETIME_MILLISECONDS','3500','Lifetime for the popup error message on windows.  Setting to zero will make the popup stay open and requires manual closing','D','C','634c3da3-bb6c-4476-8d3f-a158ef36efd1')
;

