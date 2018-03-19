SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 7, 2016 7:27:27 PM ICT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200082,0,0,TO_DATE('2016-10-07 19:27:21','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2016-10-07 19:27:21','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DASHBOARD_PERFORMANCE_REFRESH_INTERVAL','1800000','Configuration time interval to update dashboard performance. Count on millisecond and can set at client level. default is 30 minute.  ref:IDEMPIERE-3191','D','S','32b0db21-6b5c-4483-873a-6c38fd743ab1')
;

SELECT register_migration_script('201610071604_IDEMPIERE-3191.sql') FROM dual
;
