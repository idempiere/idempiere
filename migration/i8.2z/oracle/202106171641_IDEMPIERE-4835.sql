SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 17, 2021, 4:31:48 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200175,0,0,TO_DATE('2021-06-17 16:31:47','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2021-06-17 16:31:47','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_GRID_AUTO_HIDE_EMPTY_COLUMNS','N','Y/N - Auto hide column with empty content','D','C','b1bcee77-fbb7-413a-a22b-f250929b3e65')
;

SELECT Register_Migration_Script ('202106171641_IDEMPIERE-4835.sql') FROM DUAL
;

