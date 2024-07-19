-- IDEMPIERE-5013 Implement HikariCP as a replacement for c3p0
SELECT register_migration_script('202208072022_IDEMPIERE-5013.sql') FROM dual;

-- Aug 7, 2022, 8:22:48 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200202,0,0,TO_TIMESTAMP('2022-08-07 20:22:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-08-07 20:22:48','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MSEQUENCE_GETNEXT_TIMEOUT','30','Timeout in seconds for getting the next sequence from AD_Sequence table','D','C','77ad6242-4a80-448b-8385-42453cd831ba')
;

