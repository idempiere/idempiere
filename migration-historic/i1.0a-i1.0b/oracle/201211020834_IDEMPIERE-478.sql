-- Nov 2, 2012 2:39:48 PM MYT
-- IDEMPIERE-478 Zk: Theme
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,AD_SysConfig_UU,CreatedBy,Name,Value,Created,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,IsActive) VALUES (200021,'D','S','054399ad-3705-411d-b79e-7ec7111888c5',100,'ZK_THEME','default',TO_DATE('2012-11-02 14:39:46','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-02 14:39:46','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y')
;

SELECT register_migration_script('201211020834_IDEMPIERE-478.sql') FROM dual
;


