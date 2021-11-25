-- Jul 15, 2021, 3:50:49 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200180,0,0,TO_TIMESTAMP('2021-07-15 15:50:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-07-15 15:50:48','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_INFO_AUTO_HIDE_EMPTY_COLUMNS','N','Y/N - Define if info window will auto hide columns with empty content','D','C','99ba73cd-f64a-418d-bb55-82f4192b1055')
;

SELECT Register_Migration_Script ('202107150800_IDEMPIERE-4841.sql') FROM DUAL
;

