SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 1, 2014 2:53:42 PM SGT
-- IDEMPIERE-2029 Performance gadgets portlet is not sized correctly on login
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,AD_SysConfig_UU,Updated,Created,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200057,'C','500','70b3fe79-cbe4-40d5-89b4-a4c5c9c5a845',TO_DATE('2014-07-01 14:53:41','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-07-01 14:53:41','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'ZK_DASHBOARD_PERFORMANCE_TIMEOUT',0,'D')
;

SELECT register_migration_script('201407011455_IDEMPIERE-2029.sql') FROM dual
;